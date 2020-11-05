#' objects of class `form_partial` or `form`
#' 
#' @param x,y objects of class `form_partial` or `form`. 
#' 
#' @return `TRUE` for yes and `FALSE` for No.
#' @export


join <- function(x, y) {
  stopifnot(class(x) %in% c("form_partial", "form"))
  stopifnot(class(y) %in% c("form_partial", "form"))
  
  structure(function(n = 1) {
    r1 <- x()
    r2 <- y()
    if (class(x) == "form" | class(y) == "form") {
      out <- c(r1, r2)
    } else {
      out <- list(r1, r2)
    }
    
    out <- name_field(out, x, 1)
    out <- name_field(out, y, length(out))
            
    structure(out, class = "form_answers")
  }, class = "form")
  
}

#' @describeIn join join operator.
#' @export
'%+%' <- function(x, y) join(x, y)


# 
name_field <- function(out, x, i) {
  if (class(x) == "form_partial") {
    if (attributes(x)$field_name == "") {
      names(out)[i] <- glue("answer_{i}")
    } else names(out)[i] <- attributes(x)$field_name
  } 
  out 
}