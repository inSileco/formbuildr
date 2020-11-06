#' A binary question to be answered by Yes or No.
#' 
#' @param question The question to be asked. 
#' @param prompt the string printed when prompting the user for input (see [readline()]).
#' @param field_name Name of the field (optional).
#' @param max maximum of characters (ignored if `NULL`).
#' @param format date format. 
#' 
#' @return Return the choice selected either as the choice value or its identifier (an integer).
#' @export

one_integer <- function(question, field_name = "", prompt = NULL) {
  if (is.null(prompt)) prompt <- "Enter your answer (an integer): "
  generate_form_pattern(question = question, prompt = prompt, 
    pattern = "^[0-9]+$", pre = NULL, post = as.integer, field_name = field_name)
} 

#' @describeIn one_integer a numeric. 
#' @export
one_numeric <- function(question, field_name = "", prompt = NULL) {
  if (is.null(prompt)) prompt <- "Enter your answer (a numeric): "
  generate_form_pattern(question = question, prompt = prompt, 
    pattern = "^[0-9]+\\.?[0-9]*$|^[0-9]*\\.?[0-9]+$", pre = NULL, 
    post = as.numeric, field_name = field_name)
} 


#' @describeIn one_integer a word.
#' @export
one_word <- function(question, field_name = "", prompt = NULL) {
  if (is.null(prompt)) prompt <- "Enter your answer (one word): "
  generate_form_pattern(question = question, prompt = prompt, 
    pattern = "^[A-Za-z\\-]+$", pre = NULL, post = NULL, 
    field_name = field_name)
} 


#' @describeIn one_integer a text.
#' @export
one_text <- function(question, field_name = "", max = NULL, prompt = NULL) {
  
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
    pattern = "^[[:graph:]]+$", pre = NULL, post = f_post, 
    field_name = field_name)
} 


#' @describeIn one_integer a date.
#' @export
one_date <- function(question, field_name = "", format = "%Y-%m-%d", 
  prompt = NULL) {
    
  if (is.null(prompt)) 
    prompt <- paste0("Enter your answer (a date ", format, "): ")
  # as.list needed otherwise will be coerced to numeric
  f_pre <- function(x) as.character(as.Date.character(x, format = format))
  f_val <- function(x) !is.na(x)
  
  generate_form(question = question, prompt = prompt, 
    validate = f_val, pre = f_pre, post = NULL, 
    field_name = field_name)
}