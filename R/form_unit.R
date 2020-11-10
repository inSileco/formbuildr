

generate_form <- function(prompt = "", question = NULL, choices = NULL,
  validate = NULL, confirm = FALSE, pre = NULL, post = NULL, field_name = "") {
      
    out <- function(x = NULL) {
      
      if (!is.null(x)) {
        return(validate(x))
      }
          
      if (!is.null(question)) {
        msgQuestion(question)
      }
      
      if (!is.null(choices)) {
        msgInfo("Multiple choices:")
        list_choices(choices)
      }
      
      # validate
      if (is.function(validate)) {
        ok <- vld <- FALSE
        while (!vld | !ok) {
          tmp <- readline(prompt)
          vld <- validate(tmp)
          if (vld) {
            # confirm 
            if (confirm) {
              ok <- get_confirmed()
              if (ok) {
                vld <- TRUE
                if (is.function(pre)) tmp <- pre(tmp)
              } else {
                not_confirmed()
              }
            } else {
              ok <- vld <- TRUE
              if (is.function(pre)) tmp <- pre(tmp)
            }
          } else not_valid()
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
  pattern = "*", confirm = FALSE, pre = NULL, post = NULL, field_name = "") {
  vf <- function(x) grepl(pattern, x)
  generate_form(prompt, question, choices, vf, confirm, pre, post, field_name)
}


generate_form_choices <- function(prompt = "", question = NULL, choices, 
  confirm = FALSE, pre = NULL, post = NULL, field_name = "") {
  vf <- function(x) return(x %in% as.character(seq_along(choices)))
  generate_form(prompt, question, choices, vf, confirm, pre, post, field_name)
}


list_choices <- function(x) {
  out <- seq_along(x)
  for (i in out) {
    cat(i, ": ", x[i], "\n")
  }
  invisible(0)
}