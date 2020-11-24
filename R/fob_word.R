#' A binary question to be answered by Yes or No.
#' 
#' @param question The question to be asked. 
#' @param prompt the string printed when prompting the user for input (see [readline()]).
#' @param field_name Name of the field (optional).
#' @param max maximum of characters (ignored if `NULL`).
#' @param ... further arguments to be passed to [generate_form_pattern()].
#'
#' @return a word.
#' @export
fob_word <- function(question, field_name = "", prompt = NULL, ...) {
  if (is.null(prompt)) prompt <- "Enter your answer (one word): "
  generate_form_pattern(question = question, prompt = prompt, 
    pattern = "^[A-Za-z\\-]+$", pre = NULL, post = NULL, confirm = FALSE,
    field_name = field_name)
} 


#' @describeIn fob_word a character string.
#' @export
fob_text <- function(question, field_name = "", max = NULL, prompt = NULL, ...) {
  
  if (is.null(prompt)) {
    if (is.null(max)) {
      prompt <- paste0("Enter your answer: ")
    } else {
      prompt <- paste0("Enter your answer (max characters = ", max, "): ")
    }  
  }
  
  f_post <- function(x) {
    if (!is.null(max)) {
      if (nchar(x) > max) {
        msgWarning(
          paste0("string cut out due to size limit (", max, " characters)")
        )
        x <- substr(x, 1, max)
      }
    } 
    x 
  } 
  
  generate_form_pattern(question = question, prompt = prompt, 
    pattern = ".*", post = f_post, 
    field_name = field_name, ...)
} 


#' @describeIn fob_word a character string. 
#' @export
fob_email <- function(question, field_name = "", prompt = NULL, ...) {
  if (is.null(prompt)) prompt <- "Enter your email: "
  generate_form_pattern(question = question, prompt = prompt, 
    pattern = "^[[:graph:]]+@[[:graph:]]+\\.[[:graph:]]{2,}$", pre = NULL, post = NULL, confirm = FALSE,
    field_name = field_name)
} 