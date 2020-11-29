#' Add an output.
#'
#' @param FUN a function a character string that will be displayed. 
#' @param field_name field_name.
#' @param ... arguments passed to `FUN`.
#'
#' @return An object of class `output`.
#' @export

fob_output <- function(FUN, field_name = NULL, ...) {
  args <- list(...)
  i <- 0
  structure(
    function(FUN, args) do.call(FUN, args),
    class = "output",
    field_name = NULL
  )
}

