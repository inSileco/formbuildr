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
      c(r1, r2)
    } else list(r1, r2)
  }, class = "form")
}


'%+%' <- function(x, y) join(x, y)