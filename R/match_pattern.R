#' A binary question to be answered by Yes or No.
#' 
#' @param question The question to be asked. 
#' @param pattern Pattern to be matched. 
#' @param post Post processing. 
#' @param field_name Name of the field (optional).
#' @param prompt the string printed when prompting the user for input (see [readline()]).
#' 
#' @return answer validated.
#' @export

match_pattern <- function(question, pattern, post = NULL, field_name = "",
  prompt = "Enter your answer:") {  
  
  generate_form_pattern(question = question, prompt = prompt, 
    pattern = pattern, pre = NULL, post = post, field_name = field_name) 

}

