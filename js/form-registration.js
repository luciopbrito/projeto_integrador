"use-strict"

let enable = false;
const $form_registration = $('.form__registration');
const $form_login = $('.form__login');

const url_string = window.location.href;
let url = new URL(url_string);
let data = url.searchParams.get("register");

if (data == 'true')
{
    changeForm();
}

function changeForm() {
    if (enable == true) {
        $($form_login).css('display', 'flex');
        $($form_registration).removeClass("enable").addClass("disable");
    } else {
        $($form_login).css('display', 'none');
        $($form_registration).removeClass("disable").addClass("enable");
    }
    enable = !enable;
}

$(document).on('click', ".form-login__cadastro", function () {
    changeForm();
});

$(document).on('click', ".btn__exit", function () {
    changeForm();
});