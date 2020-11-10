#' A binary question to be answered by Yes or No.
#' 
#' @param question The question to be asked. 
#' @param prompt the string printed when prompting the user for input (see [readline()]).
#' @param field_name Name of the field (optional).
#' @param max maximum of characters (ignored if `NULL`).
#' @param format date format. 
#' @param ... further argument.  
#' 
#' @return Return the choice selected either as the choice value or its identifier (an integer).
#' @export

fob_integer <- function(question, field_name = "", prompt = NULL) {
  if (is.null(prompt)) prompt <- "Enter your answer (an integer): "
  generate_form_pattern(question = question, prompt = prompt, 
    pattern = "^[0-9]+$", confirm = FALSE, pre = NULL, post = as.integer, field_name = field_name)
} 

#' @describeIn fob_integer a numeric. 
#' @export
fob_numeric <- function(question, field_name = "", prompt = NULL) {
  if (is.null(prompt)) prompt <- "Enter your answer (a numeric): "
  generate_form_pattern(question = question, prompt = prompt, 
    pattern = "^[0-9]+\\.?[0-9]*$|^[0-9]*\\.?[0-9]+$", confirm = FALSE,
    pre = NULL, post = as.numeric, field_name = field_name)
} 


#' @describeIn fob_integer a word.
#' @export
fob_word <- function(question, field_name = "", prompt = NULL) {
  if (is.null(prompt)) prompt <- "Enter your answer (one word): "
  generate_form_pattern(question = question, prompt = prompt, 
    pattern = "^[A-Za-z\\-]+$", pre = NULL, post = NULL, confirm = FALSE,
    field_name = field_name)
} 


#' @describeIn fob_integer a text.
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
    pattern = "^[[:graph:]]+$", post = f_post, 
    field_name = field_name, ...)
} 


#' @describeIn fob_integer a date.
#' @export
fob_date <- function(question, field_name = "", format = "%Y-%m-%d", 
  prompt = NULL, ...) {
    
  if (is.null(prompt)) 
    prompt <- paste0("Enter your answer (a date ", format, "): ")
  # as.list needed otherwise will be coerced to numeric
  f_pre <- function(x) as.character(as.Date.character(x, format = format))
  f_val <- function(x) !is.na(x)
  
  generate_form(question = question, prompt = prompt, validate = f_val, 
    pre = f_pre, field_name = field_name, ...)
}


#' @describeIn fob_integer `TRUE` for yes and `FALSE` for no.

fob_yorn <- function(question, field_name = "", 
  prompt = "Enter [Y]es or [N]o: ", ...) { 
  
  f_post <- function(x) grepl("^Y", x)
  
  generate_form_pattern(
    prompt = "Enter [Y]es or [N]o: ", 
    question = question, 
    pattern = "^[NY]$|^YES$|^NO$", 
    pre = toupper, 
    post = f_post, 
    field_name = field_name,
    ...
  ) 

}


#' @describeIn fob_integer one boolean/logical (i.e. `TRUE` or `FALSE`).

fob_boolean <- function(question, field_name = "", 
  prompt = "Enter [T]RUE or [F]ALSE: ", ...) { 
  
  f_post <- function(x) grepl("^T", x)
  
  generate_form_pattern(
    prompt = "Enter [Y]es or [N]o: ", 
    question = question, 
    pattern = "^[TF]$|^TRUE$|^FALSE$", 
    field_name = field_name,
    ...
  ) 

}

