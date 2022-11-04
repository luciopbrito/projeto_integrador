"use-strict"

let show = false;

$(document).on('click', ".showpassword", function () {
    if (show == true) {
        $(".password").attr("type", "text")
        $('.showpassword').css('font-weight', 'bold');
        show = !show;
    } else {
        $(".password").attr("type", "password");
        $('.showpassword').css('font-weight', 'normal');
        show = !show;
    }
});

$(document).on('click', ".form__registration input:submit", function () {
    const password1 = $(".form__registration [name='password']");
    const password2 = $("[name='confirmPassword']");

    if ($(password1).val() !== $(password2).val()) {
        alert('A senha não são correspondentes')
        $(password1).val("");
        $(password2).val("");
        $(password1).focus();
    }
});