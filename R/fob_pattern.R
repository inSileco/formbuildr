#' A binary question to be answered by Yes or No.
#' 
#' @param question The question to be asked. 
#' @param pattern Pattern to be matched. 
#' @param field_name Name of the field (optional).
#' @param prompt the string printed when prompting the user for input (see [readline()]).
#' @param ... further arguments passed to [generate_form_pattern()].
#' 
#' @return answer validated.
#' @export

fob_pattern <- function(question, pattern, field_name = "",
  prompt = "Enter your answer:", ...) {  
  
  generate_form_pattern(
    question = question, 
    prompt = prompt, 
    pattern = pattern, 
    field_name = field_name,
    ...
  ) 

}

