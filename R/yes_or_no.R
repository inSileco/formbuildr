#' A binary question to be answered by Yes or No.
#' 
#' @param question The question to be asked. 
#' @param field_name Name of the field (optional).
#' @param prompt the string printed when prompting the user for input (see [readline()]).
#' 
#' @return `TRUE` for yes and `FALSE` for No.
#' @export

yes_or_no <- function(question, field_name = "", prompt = "Enter [Y]es or [N]o: ") { 
  
  f_post <- function(x) grepl("^Y", x)
  
  generate_form_pattern(
    prompt = "Enter [Y]es or [N]o: ", 
    question = question, 
    pattern = "^[NY]$|^YES$|^NO$", 
    pre = toupper, 
    post = f_post, 
    field_name = field_name
  ) 

}