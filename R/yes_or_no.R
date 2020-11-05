#' A binary question to be answered by Yes or No.
#' 
#' @param question The question to be asked. 
#' @param field_name Name of the field (optional).
#' 
#' @return `TRUE` for yes and `FALSE` for No.
#' @export

yes_or_no <- function(question, field_name = "") {  
  generate_form_unit(question = question, msg = "[Y]es or [N]o: ", 
    validate = "^[NY]$|^YES$|^NO$", pre = toupper, 
    post = function(x) grepl("^Y", x), field_name = field_name) 
}