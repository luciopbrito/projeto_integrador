const $cpf = $('input[name="cpf"]');
const $telefone = $('input[name="phone"]');
const $cep = $('input[name="cep"]');
const $numero = $('input[name="number"]');

const letters = ['a', 'b', 'c', 'd', 'e', 'f', 'g', 'h', 'i', 'j', 'k', 'l', 'm', 'n', 'o', 'p', 'q', 'r', 's', 't', 'u', 'v', 'w', 'x','y','z', 'ç','^',',','}','{','[',']','(',')',':',';','/','?','°','+','-','§','_','*','&','¨','¬','¢','£','³','²','¹','!','\\','\'','\"','@','#','$','%','|','~','`','´','º','ª','=','<','>'," ",'.']

function onlyNumbers(element) {
    let value = $(element).val().toLowerCase();
    if (value !== "") {
        let returnWord = "";
        let show = false;
        for (let i=0; i < value.split('').length; i++) {
            if (i == 0) {
                letters.forEach((l) => {
                    if (value.includes(l) === true)
                    {
                        show = true;
                        returnWord = value.replaceAll(l, '');
                    }
                })
            }
            if (i > 0) {
                letters.forEach((l) => {
                    if (returnWord.includes(l) === true)
                    {
                        show = true;
                        returnWord = returnWord.replaceAll(l, '');
                    }
                });
            }
        }       
        if (show == true) {
            $(element).val(returnWord);
        }
    }
}

$(document).on('input', $cpf, function () {
    onlyNumbers($cpf);
});

$(document).on('input', $telefone, function () {
    onlyNumbers($telefone);
});

$(document).on('input', $cep, function () {
    onlyNumbers($cep);
});

$(document).on('input', $numero, function () {
    onlyNumbers($numero);
});
