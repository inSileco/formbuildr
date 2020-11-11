#' objects of class `form_partial` or `form`
#' 
#' @param ... object(s) of class `form_partial` or `form`. 
#' @param x,y objects of class `form_partial` or `form`. 
#' 
#' @return `TRUE` for yes and `FALSE` for no.
#' @export

join <- function(...) {
  funs <- list(...)
  n <- length(funs)
  cls <- unlist(lapply(funs, function(x) class(x)))
  if (!all(cls %in% c("form_partial", "form"))) {
    stop("only objects of class 'form_partial' and 'form' can be combined")
  }
  # get names 
  nms <- unlist(mapply(name_field, x = funs, i = seq_len(n)))
  # combine fun
  funs <- do.call(c, lapply(funs, list_funs))
  
  structure(function(...) {
    args <- list(...)
    # so far arguments are not used
    if (length(args)) {
        stopifnot(length(funs) == length(args))
        out <- mapply(function(x, y) x(y), x = funs, y = args, SIMPLIFY = FALSE)
    } else out <- lapply(funs, function(x) x())
    names(out) <- nms 
    structure(out, class = "form_answers")
  }, class = c("form"), field_name = nms, funs = funs)

}

#' @describeIn join join operator.
#' @export
'%+%' <- function(x, y) join(x, y)


# helpers
name_field <- function(x, i) {
  if (class(x) == "form_partial") {
    if (attributes(x)$field_name == "") {
      glue("answer_{i}")
    } else attributes(x)$field_name
  } else {
    attributes(x)$field_name
  }
}

# use attribute is class is `form`
list_funs <- function(x) {
  if (class(x) == "form_partial") {
    x
  } else {
    attributes(x)$funs
  }
}
 
 