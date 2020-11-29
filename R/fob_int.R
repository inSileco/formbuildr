#' Generate one question.
#'
#' @param question The question to be asked. 
#' @param prompt The string printed when prompting the user for input (see [readline()]).
#' @param field_name Name of the field (optional).
#' @param format Date format. 
#' @param ... Further arguments to be passed to [generate_form_pattern()].
#' 
#' @return one integer.
#' @export

fob_int <- function(question, field_name = "", prompt = NULL) {
  if (is.null(prompt)) prompt <- "Enter your answer (an integer):"
  generate_form_pattern(question = question, prompt = prompt, 
    pattern = "^[0-9]+$", confirm = FALSE, pre = NULL, post = as.integer, field_name = field_name)
} 

#' @describeIn fob_int one numeric. 
#' @export
fob_num <- function(question, field_name = "", prompt = NULL) {
  if (is.null(prompt)) prompt <- "Enter your answer (a numeric):"
  generate_form_pattern(question = question, prompt = prompt, 
    pattern = "^[0-9]+\\.?[0-9]*$|^[0-9]*\\.?[0-9]+$", confirm = FALSE,
    pre = NULL, post = as.numeric, field_name = field_name)
} 

#' @describeIn fob_int one date.
#' @export
fob_date <- function(question, field_name = "", format = "%Y-%m-%d", 
  prompt = NULL, ...) {
    
  if (is.null(prompt)) 
    prompt <- paste0("Enter your answer (a date ", format, "):")
  # as.list needed otherwise will be coerced to numeric
  f_pre <- function(x) {
    out <- as.Date.character(x, format = format)
    if (!is.na(out)) {
      as.character(out)
    } else out
  }

  f_val <- function(x) !is.na(x)
  
  generate_form(question = question, prompt = prompt, validate = f_val, 
    pre = f_pre, field_name = field_name, ...)
}

#' @describeIn fob_int a character. 
#' @export
fob_char <- function(question, field_name = "", prompt = NULL) {
  if (is.null(prompt)) prompt <- "Enter your answer (a numeric):"
  generate_form_pattern(question = question, prompt = prompt, 
    pattern = "*.", confirm = FALSE,
    pre = NULL, post = as.numeric, field_name = field_name)
} 

#' @describeIn fob_int `TRUE` for yes and `FALSE` for no.

fob_yorn <- function(question, field_name = "", 
  prompt = "Enter [Y]es or [N]o:", ...) { 
  
  f_post <- function(x) grepl("^Y", x)
  
  generate_form_pattern(
    prompt = prompt, 
    question = question, 
    pattern = "^[NY]$|^YES$|^NO$", 
    pre = toupper, 
    post = f_post, 
    field_name = field_name,
    ...
  ) 

}

#' @describeIn fob_int one boolean/logical (i.e. `TRUE` or `FALSE`).

fob_bool <- function(question, field_name = "", 
  prompt = "Enter [T]RUE or [F]ALSE:", ...) { 
  
  f_post <- function(x) grepl("^T", x)
  
  generate_form_pattern(
    prompt = prompt, 
    question = question, 
    pattern = "^[TF]$|^TRUE$|^FALSE$", 
    field_name = field_name,
    ...
  ) 

}

