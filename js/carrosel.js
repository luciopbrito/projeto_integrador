"use strict";

const container = $('.carrosel__imgs');
const carrosel = $('.carrosel__imgs img');

let idx = 0;

function alternateImg() {
    idx++;

    if (idx > $(carrosel).length - 1) {
        idx = 0;
    }

    $(container).css("transform", `translateX(${-idx * 100}%)`)

}

$(document).ready(() => {
    setInterval(alternateImg, 5000);
})