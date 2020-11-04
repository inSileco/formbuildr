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

generate_form_unit <- function(msg, question = NULL, choices = NULL, validate = "*", pre = NULL, post = NULL) {
  
  out <- function() {
      
    if (!is.null(question)) {
      msgQuestion(question)
    }
    
    tmp <- readline(msg)
    
    if (is.function(pre)) tmp <- pre(tmp)
    
    while (!grepl(validate, tmp)) {
      not_valid()
      tmp <- readline(msg)
    }  
    
    valid()
    
    if (is.function(post)) {
      post(tmp)
    } else tmp
    
  } 
  
  structure(out, class = "form_partial")
}


generate_form_unit_choices <- function(question, choices, output = "choice") {
  
  output <- match.arg(output, c("choice", "id"))
  
  out <- function() {
      
    if (!is.null(question)) {
      msgQuestion(question)
    }
    
    if (!is.null(choices)) {
      msgInfo("Multiple choices")
      validate <- list_choices(choices)
    }
    
    tmp <- readline("Enter your choice: ")
        
    while (!tmp %in% validate) {
      not_valid()
      tmp <- readline("Enter your choice: ")
    }  
    valid()
    tmp <- as.numeric(tmp)
    if (output == "choice") {
      choices[tmp]
    } else tmp
    
  } 
  
  structure(out, class = "form_partial")
}


list_choices <- function(x) {
  out <- seq_along(x)
  for (i in out) {
    cat(i, ": ", x[i], "\n")
  }
  as.character(out)
}