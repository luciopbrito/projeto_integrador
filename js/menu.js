"use strict";
let menuopen = false;

$(document).on("click", ".menu__mobile", function(){
    if (menuopen == false) {
        $(".menu__mobile").attr("class", "menu__mobile off");
        $(".menu__mobile img").attr("src", "./assets/list.svg");
        menuopen = !menuopen;
    }else {
        $(".menu__mobile").attr("class", "menu__mobile open");
        $(".menu__mobile img").attr("src", "./assets/x-lg.svg");
        menuopen = !menuopen;
    }
});