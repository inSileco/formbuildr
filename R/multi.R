#' Repeat a form. 
#'
#' Fill out the same form by multiple participants.
#'
#' @param x a object of class `form`.
#' @param n number of participants. 
#' @param names participants names.
#'
#' @export 
 
multi <- function(x, n = 1, names = NULL) {
  stopifnot(class(x) == "form")
  if (!is.null(names)) {
    stopifnot(length(names) == n)
  } else names <- paste0("participant_", seq_len(n))
  out <- list()
  for (i in seq_len(n)) {
    out[[i]] <- x()
    names(out)[i] <- names[i]
  }
  structure(out, class = "multi_answers")
}