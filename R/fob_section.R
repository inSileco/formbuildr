#' Add a section.
#'
#' @param msg a character string that will be displayed. 
#' 
#' @return A `section` object.
#' @export

fob_section <- function(msg) {
  structure(
    function() {
      msgSection(msg)
      invisible(msgSection)
    },
    class = "section",
    name_field = "section"
  )
}