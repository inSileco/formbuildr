#' objects of class `form_partial` or `form`
#' 
#' @param ... object(s) of class `form_partial` or `form`. 
#' @param x,y objects of class `form_partial` or `form`. 
#' 
#' @return `TRUE` for yes and `FALSE` for No.
#' @export

join <- function(...) {
  tmp <- list(...)
  n <- length(tmp)
  if (n == 1) {
    out <- to_form(tmp[[1L]])
  } else {
    if (n > 1) {
      out <- join_pair(tmp[[1L]], tmp[[2L]])
      if (n > 2) {
        for (i in seq(3, n)) {
          out <- join_pair(out, tmp[[i]])
        }
      }
    }
  }
  out
}


#' @describeIn join join operator.
#' @export
'%+%' <- function(x, y) join_pair(x, y)

to_form <- function(x) {
  stopifnot(class(x) == "form_partial")
  
  structure(function() {
    r1 <- x()
    out <- name_field(list(r1), x, 1)
    structure(out, class = "form_answers")
  }, class = "form")
  
}

join_pair <- function(x, y) {
  stopifnot(class(x) %in% c("form_partial", "form"))
  stopifnot(class(y) %in% c("form_partial", "form"))
  
  structure(function(...) {
    # so far arguments are not used
    arg <- list(...)
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




# helpers 
name_field <- function(out, x, i) {
  if (class(x) == "form_partial") {
    if (attributes(x)$field_name == "") {
      names(out)[i] <- glue("answer_{i}")
    } else names(out)[i] <- attributes(x)$field_name
  } 
  out 
}