#' A binary question to be answered by Yes or No.
#' 
#' @param question The question to be asked. 
#' 
#' @return `TRUE` for yes and `FALSE` for No.
#' @export

yes_or_no <- function(question) {  
  generate_form_unit(question = question, msg = "[Y]es or [No]: ", 
    validate = "^[NY]$|^YES$|^NO$", pre = toupper, 
    post = function (x) grepl("^Y", x)) 
}