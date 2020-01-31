## ------------------------------------------------------------------------
if (!dir.exists("tmp")) {
    dir.create("tmp")
}

dir_info("analysis", regexp = "ch\\d") %>%
    select(path) %>%
    mutate(section = path %>% basename() %>% str_extract("\\d")) %>%
    mutate(text =
               map(path, function(x) {
                   x <- readr::read_file(x)
                   x <- x %>%
                       str_split("\n") %>% 
                       .[[1]]
                   x <- x %>% 
                       str_replace("^# ", "## ")
                   range <- x %>%
                       str_which("^---")
                   x[range[1]:range[2]] <- ""
                   x <- x %>% str_flatten("\n")
                   return(x)
               })) %>%
    group_by(section) %>%
    summarise(text = str_flatten(text, "\n\n")) %>%
    mutate(section = glue::glue("# Chapter {section}")) %>%
    mutate(text = glue::glue("\n{section}\n\n{text}")) %>%
    summarise(text = str_flatten(text, "\n\n")) %>%
    dplyr::pull() %>%
    write_file("tmp/datacamp-childs.Rmd")

rmarkdown::render("datacamp.Rmd")
git2r::add(path = ".")
git2r::commit(message = "build gitbook")
git2r::push(name = 'origin', refspec = "refs/heads/master", cred = git2r::cred_token())
