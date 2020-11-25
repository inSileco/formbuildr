#' Generate any kind of question.
#' 
#' @param type at the type of answer expected. 
#' @param ... further arguments passed to the question function. 
#' @export

fob_any <- function(type, ...) {
  switch(type,
    bool = fob_bool(...),
    char = fob_char(...),
    date = fob_date(...),
    int = fob_int(...),
    num = fob_num(...),
    yorn = fob_yorn(...),
    #
    word = fob_word(...),
    text = fob_text(...),
    email = fob_yorn(...),
    #
    month = fob_month(...),
    weekday = fob_weekday(...)
  )
}