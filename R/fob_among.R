#' A binary question to be answered by Yes or No.
#' 
#' @param question The question to be asked. 
#' @param choices A vector of choices. 
#' @param output Either "choice" or "id".
#' @param field_name Name of the field (optional).
#' @param ... further arguments to be passed to [generate_form_choices()].
#' 
#' @return Return the choice selected either as the choice value or its identifier (an integer).
#' @export

fob_among <- function(question, choices, field_name = "", output = "choice", 
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
    post = postf,
    ...
  ) 

}


#' @describeIn fob_among One month.
fob_month <- function(question, field_name = "", output = c("choice", "id"), ...) {
  fob_among(question, months(ISOdate(2004, 1:12, 1)), field_name, output)
}

#' @describeIn fob_among One weekday.
fob_weekday <- function(question, field_name = "", output = c("choice", "id"), ...) {
  fob_among(question, weekdays(ISOdate(2004,1,5:11)), field_name, output)
}

# Sys.setlocale("LC_TIME"e,"fr_FR") ;format(ISOdate(2004,1:12,1), "%B")

