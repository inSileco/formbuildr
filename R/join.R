#' objects of class `form_partial` or `form`
#' 
#' @param ... object(s) of class `form_partial`, `form`, `section` or `output`. 
#' @param x,y objects of class `form_partial`, `form`, `section` or `output`. 
#' 
#' @return A form.
#' @export

join <- function(...) {
  funs <- list(...)
  cls <- unlist(lapply(funs, function(x) class(x)))
  cls_ok <- c("form_partial", "form", "section", "output")
  if (!all(cls %in% cls_ok)) {
    stop(paste0("only objects of class", commaAnd(cls_ok), "can be combined"))
  }
  # combine funs
  funs <- do.call(c, lapply(funs, list_funs))
  
  cls <- unlist(lapply(funs, function(x) class(x)))
  otps <- funs[cls == "output"]
  funs <- funs[cls != "output"]
  cls <- cls[cls != "output"]

  nms <- unlist(mapply(name_field, x = funs, i = seq_len(length(funs))))
  
  structure(function(...) {
    args <- list(...)
    if (length(args)) {
        funs <- funs[!cls %in% "section"]
        stopifnot(length(funs) == length(args))
        out <- mapply(function(x, y) x(y), x = funs, y = args, SIMPLIFY = FALSE)
    } else {
      out <- lapply(funs, function(x) x())
      # remove section
      out <- out[cls != "section"]
    }
    names(out) <- nms
    if (length(otps)) {
      outputs <- lapply(otps, function(x) x(out))
      names(outputs) <- name_outputs(otps)
    } else outputs <- NULL
    structure(
      list(answers = out, outputs = outputs), 
      class = "form_answers"
    )
  }, class = c("form"), field_name = nms, funs = c(funs, otps))

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
 
name_outputs <- function(x) {
  unlist(mapply(name_outputs_unit, 
      lapply(x, function(y) attributes(y)$field_name), seq_along(x)
  ))
} 
 
name_outputs_unit <- function(x, n) {
  if (is.null(x)) {
    glue("output_{n}")
  } else x
}