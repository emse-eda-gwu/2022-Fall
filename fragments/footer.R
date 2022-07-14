# Render footer
source(file.path('fragments', 'settings.R'))
footer <- htmltools::HTML(paste0(
'<hr>

<div>
<center>
    EMSE 6035: Marketing Analytics for Design Decisions (', settings$semester, ')

    <br>

    <i class="far fa-calendar-alt"></i> ', settings$weekday, ' |
    <i class="far fa-clock"></i> ', settings$time, ' |
    <a href="', settings$room_url, '"><i class="fa fa-map-marker-alt"></i> ', settings$room, '</a> |
    <a href="https://www.jhelvy.com"><i class="fas fa-user"></i> Dr. John Paul Helveston</a> |
    <a href="mailto:jph@gwu.edu"><i class="fas fa-envelope"></i> jph@gwu.edu</a>

    <br>

    <a href="LICENSE.html">LICENSE: CC-BY-SA <i class="fab fa-creative-commons"></i><i class="fab fa-creative-commons-by"></i><i class="fab fa-creative-commons-sa"></i></a>
</center>
</div>

<!-- Add function to open links to external links in new tab, from: -->
<!-- https://yihui.name/en/2018/09/target-blank/ -->

<script src="js/external-link.js"></script>'
))
fileConn <- file(file.path('_includes', 'footer.html'))
writeLines(footer, fileConn)
close(fileConn)
