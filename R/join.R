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
  cls_ok <- c("form_partial", "form", "section", "output")
  if (!all(cls %in% cls_ok)) {
    stop(paste0("only objects of class", commaAnd(cls_ok), "can be combined"))
  }
  # get names 
  nms <- unlist(mapply(name_field, x = funs, i = seq_len(n)))
  # combine funs
  funs <- do.call(c, lapply(funs, list_funs))
  cls <- unlist(lapply(funs, function(x) class(x)))
  
  structure(function(...) {
    args <- list(...)
    if (length(args)) {
        funs <- funs[!cls %in% c("section", "output")]
        stopifnot(length(funs) == length(args))
        out <- mapply(function(x, y) x(y), x = funs, y = args, SIMPLIFY = FALSE)
    } else {
      funs <- funs[!cls %in% "output"]
      out <- lapply(funs, function(x) x())
      # remove section
      out <- out[cls != c("section", "output")]
    }
    names(out) <- nms
    structure(
      list(answers = out, outputs = NULL), 
      class = "form_answers"
    )
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
  if (class(x) %in% c("form_partial", "section", "output")) {
    x
  } else {
    attributes(x)$funs
  }
}
 