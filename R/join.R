#' objects of class `form_partial` or `form`
#' 
#' @param x,y objects of class `form_partial` or `form`. 
#' 
#' @return `TRUE` for yes and `FALSE` for No.
#' @export


join <- function(x, y) {
  stopifnot(class(x) %in% c("form_partial", "form"))
  stopifnot(class(y) %in% c("form_partial", "form"))
  
  structure(function() {
    r1 <- x()
    r2 <- y()
    if (class(x) == "form" | class(y) == "form") {
      out <- c(r1, r2)
    } else {
      out <- list(r1, r2)
    }
    
    if (class(x) == "form_partial") 
      names(out)[1] <- attributes(x)$field_name
    if (class(y) == "form_partial") 
      names(out)[length(out)] <- attributes(y)$field_name
            
    structure(out, class = "form_answers")
  }, class = "form")
  
}

#' @describeIn join join operator.
#' @export
'%+%' <- function(x, y) join(x, y)