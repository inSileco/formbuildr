#' Generate form partials
#'
#' Functions that generate object of class `form_partials`. 
#' 
#' @param prompt The string printed when prompting the user for input (see [readline()]).
#' @param question The question to be asked. 
#' @param choices A vector of choices. 
#' @param validate A function used to validate the answer (see details), if `NULL` then validation step is ignored.
#' @param field_name Field name (optional) that will be used in the list of answer.
#' @param confirm a logical. Should the answer be confirmed (default is `FALSE`).
#' @param pre A function for pre-processing.
#' @param post A function for post-processing. 
#' @param pattern pattern to be matched (see [grepl()]. 
#' @param extra_space extra space in prompt line.
#'
#' @details
#' The object of class `form_partial` returned is a function with one argument (`x`) that triggers the following actions once called: 
#' 1. displays a question to be asked (`question`);
#' 2. prompts a message (`prompt`) that is used to specify the nature of the input;
#' 3. if `confirm = TRUE` then a confirmation messages will be prompted;
#' 4. (optional) calls the function `pre` that transforms the input;
#' 5. validates the input (`validate`), i.e. returns `TRUE` if the input (that may have been transformed) is valid;
#' 6. (optional) applies a function (`post`) to the validated input that thereby becomes output
#' 
#' The argument `x` of a `form_partial` is set to `NULL`, it can however be set to a different value. In such case, once the object is called, the interactive steps (the first three steps aforementioned) are skipped and the input goes through the 3 last steps. If the input is not validated then `NA` will be returned.
#'
#' @return 
#' A object of class `form_partial`.
#' 
#' @export

generate_form <- function(prompt = "", question = NULL, choices = NULL,
  validate = NULL, confirm = FALSE, pre = NULL, post = NULL, field_name = "", 
  extra_space = " ") {
      
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
          tmp <- readline(paste0(prompt, extra_space))
          if (is.function(pre)) tmp <- pre(tmp)
          vld <- validate(tmp)
          if (vld) {
            # confirm 
            if (confirm) {
              ok <- get_confirmed()
              if (ok) {
                vld <- TRUE
                if (is.function(pre)) tmp <- pre(tmp)
              } else not_confirmed()
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
    spc <- paste(rep(" ", nchar(max(out)) - nchar(i)), collapse = "")
    cat(paste0(i, spc, ": ", x[i], "\n"))
  }
  invisible(0)
}