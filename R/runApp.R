#' Run animalcules shiny app
#'
#' @import assertthat
#' @import covr
#' @import lattice
#' @import DT
#' @importFrom shinyjs addClass
#' @return The shiny app will open
#'
#' @param dev Run the applicaiton in developer mode
#'
#' @examples
#' \dontrun{
#' run_animalcules()
#' }
#' @export
run_animalcules <- function(dev = FALSE, master = NULL) {
    appDir <- system.file("shiny", package = "animalcules")
    if (appDir == "") {
        stop("Could not find myapp. Try re-installing `mypackage`.",
            call. = FALSE
        )
    }
    if (dev) {
        options(shiny.autoreload = TRUE)
    }
    
    if (is.null(master)) {
      if (Sys.getenv("SPARK_CONNECT_ENDPOINT") != "") {
        master <- Sys.getenv("SPARK_CONNECT_ENDPOINT")
        print(paste("Using SPARK_CONNECT_ENDPOINT:", master))
      } else{
        master <- "sc://172.18.0.1:15002"
        print(paste("Using default master:", master))
      }
    }
    print(Sys.getenv("SPARK_CONNECT_ENDPOINT"))
    print(master)
    
    sc <<- sparklyr::spark_connect(
      master = master,
      method = "spark_connect",
      version = "3.5"
    )

    shiny::runApp(appDir, display.mode = "normal")
}
