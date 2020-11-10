#' A binary question to be answered by Yes or No.
#' 
#' @param question The question to be asked. 
#' @param choices A vector of choices. 
#' @param output Either "choice" or "id".
#' @param field_name Name of the field (optional).
#' @param ... further arguments passed to generate_form_choices().
#' 
#' @return Return the choice selected either as the choice value or its identifier (an integer).
#' @export

one_among <- function(question, choices, field_name = "", output = "choice", 
  ...) {
  
  output <- match.arg(output, c("choice", "id"))
  postf <- function(x) {
    if (output == "choice") {
      choices[as.numeric(x)]
    } else as.numeric(x)
  }
  
  generate_form_choices(
    prompt = "Enter your choice: ", 
    question = question,
    choices = choices,
    field_name = field_name,
    ...
  ) 

}
