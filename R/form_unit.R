#' @keywords internal 


generate_form <- function(prompt = "", question = NULL,
  choices = NULL, validate = NULL, pre = NULL, post = NULL, field_name = "") {
      
    out <- function() {
          
      if (!is.null(question)) {
        msgQuestion(question)
      }
      
      if (!is.null(choices)) {
        msgInfo("Multiple choices:")
        list_choices(choices)
      }
      
      tmp <- readline(prompt)
      if (is.function(pre)) tmp <- pre(tmp)
      
      if (is.function(validate)) {
        while (!validate(tmp)) {
          not_valid()
          tmp <- readline(prompt)
          if (is.function(pre)) tmp <- pre(tmp)
        }  
        valid()
      } else {
        if (!is.null(validate)) {
          stop("validate should be a function or `NULL`")
        }
      }

      if (is.function(post)) out <- post(tmp) else out <- tmp
      out
    } 
    
    structure(out, class = "form_partial", field_name = field_name)
}



generate_form_pattern <- function(prompt = "", question = NULL, choices = NULL, 
  pattern = "*", pre = NULL, post = NULL, field_name = "") {
  vf <- function(x) grepl(pattern, x)
  generate_form(prompt, question, choices, vf, pre, post, field_name)
}


generate_form_choices <- function(prompt = "", question = NULL, choices, 
  pre = NULL, post = NULL, field_name = "") {
  
  vf <- function(x) return(x %in% as.character(seq_along(choices)))
  generate_form(prompt, question, choices, vf, pre, post, field_name)
}


list_choices <- function(x) {
  out <- seq_along(x)
  for (i in out) {
    cat(i, ": ", x[i], "\n")
  }
  invisible(0)
}