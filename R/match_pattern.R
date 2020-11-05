#' A binary question to be answered by Yes or No.
#' 
#' @param question The question to be asked. 
#' @param pattern Pattern to be matched. 
#' @param post Post processing. 
#' @param field_name Name of the field (optional).
#' 
#' @return answer validated.
#' @export

match_pattern <- function(question, pattern, post = NULL, field_name = "") {  
  generate_form_unit(question = question, msg = "Enter your answer: ", 
    validate = pattern, pre = NULL, post = post, field_name = field_name) 
}

