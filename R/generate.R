#' Generate form 
#'
#' @param prompt The string printed when prompting the user for input (see [readline()]).
#' @param question The question to be asked. 
#' @param choices A vector of choices. 
#' @param validate A function used to validate the answer, if `NULL` then validation step is ignored.
#' @param field_name Name of the field (optional).
#' @param confirm a logical. Should the answer be confirmed (default is FALSE).
#' @param pre A function for pre processing.
#' @param post A function for post processing. 
#' @param pattern pattern to be matched. 
#'
#' @export

generate_form <- function(prompt = "", question = NULL, choices = NULL,
  validate = NULL, confirm = FALSE, pre = NULL, post = NULL, field_name = "") {
      
    out <- function(x = NULL) {
      
      if (!is.null(x)) {
        if (is.function(pre)) x <- pre(x)
        if (is.function(validate)) {
          if (validate(x)) {
            if (is.function(post)) x <- post(x)
            return(x)
          } else return(NA)
        } else return(x)
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
          stop("`validate` should be a function or `NULL`")
        }
      }

      if (is.function(post)) out <- post(tmp) else out <- tmp
      out
    } 
    
    structure(out, class = "form_partial", field_name = field_name)
}

#' @describeIn generate_form match pattern.
#' @export
generate_form_pattern <- function(prompt = "", question = NULL, choices = NULL, 
  pattern = "*", confirm = FALSE, pre = NULL, post = NULL, field_name = "") {
  vf <- function(x) grepl(pattern, x)
  generate_form(prompt, question, choices, vf, confirm, pre, post, field_name)
}

#' @describeIn generate_form list fo choices.
#' @export
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