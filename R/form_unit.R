#' @keywords internal 

form_unit <- function(msg, validate = "*", transform = NULL) {
  tmp <- readline(msg)
  
  while (!grepl(validate, tmp)) {
    not_valid()
    tmp <- readline(msg)
  }  
  valid()
  if (!is.null(transform)) {
    transform(tmp)
  } else tmp
}

generate_form_unit <- function(question, msg, validate = "*", transform = NULL) {
  
  out <- function() {
      
    if (!is.null(question)) {
      msgQuestion(question)
    }
    
    tmp <- readline(msg)
    
    while (!grepl(validate, tmp)) {
      not_valid()
      tmp <- readline(msg)
    }  
    valid()
    if (!is.null(transform)) {
      transform(tmp)
    } else tmp
    
  } 
  
  structure(out, class = "form_partial")
}