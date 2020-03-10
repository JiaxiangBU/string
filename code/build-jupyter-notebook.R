library(tidyverse)
# read_lines("notebook.md") %>%
#     str_replace("^## \\d+\\. ", "### ") %>%
#     write_lines("notebook.md")
read_lines("python-re.md") %>%
    str_replace("^## ", "# ") %>%
    write_lines("python-re.md")
