# NEOF feedback summary ####

#This is code to create summary info of all the NEOF feedback

#It involves download the feedback spreadsheet as an xlsx file 
# so I have all the tab
#Current version downloaded 13 Feb 2026
#Link:
# https://docs.google.com/spreadsheets/d/13XdVo65A8TiZYC9gjxf5YqvYpLiuDION9xJlPmWRJYI/edit?usp=drive_link

#Library
#Using readxl library from tidyverse
library("tidyverse")
library("readxl")

#Vector of sheet names
sheets <- readxl::excel_sheets("2. NEOF Feedback Responses.xlsx")


# VNC info ####
#Will only get info about teaching VNC for now
#Loop through sheets
for (i in 1:length(sheets)) {
  sheet = sheets[i]  
  tbl_tmp <- readxl::read_xlsx("2. NEOF Feedback Responses.xlsx",
                                sheet = sheet) |>
    #Select vnc column
    #Use any_of as it produce a column of NAs if the column does not exist
    #This is better than the command failing and therefroe the loop breaking
    dplyr::select(any_of(c("Computing access [The teaching VNC was]"))) |>
    #Add column of sheet name
    dplyr::mutate(Workshop=sheet) |>
    dplyr::relocate(Workshop)
    if (i == 1) {
      tbl <- tbl_tmp
    } else {
      tbl <- dplyr::bind_rows(tbl, tbl_tmp)
    }
}

#Remove NA rows
tbl <- tbl |> drop_na()
#Table of ratings
table(tbl)
table(tbl$`Computing access [The teaching VNC was]`)
