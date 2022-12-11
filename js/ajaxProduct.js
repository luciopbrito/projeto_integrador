"use-strict";

const queryString = window.location.search;
const urlParams = new URLSearchParams(queryString);
const idClient = urlParams.get("idClient").toString();
const idProduct = urlParams.get("idProduct");
const idService = urlParams.get("idService");

if (idProduct === null && idService === null)
{
    showAjax(true)
}
else if (idProduct !== null)
{
    showAjax(true, idProduct.toString(), "product")
}
else if (idService !== null)
{
    showAjax(true, idService.toString(), "service")
}

$(document).on("change", "#type_budget", function(){
    showAjax(false);
});

function showAjax(isInitial, id, type) {
    // const $result = $(".responseAjax");
    if (isInitial == true)
    {
        if (id !== null && type == 'product')
        {   
            $.get("../projeto_integrador/show-orcamento.jsp?type=product&idClient=" + idClient + "&idProduct=" + id, function(data){
                $(".responseAjax").html("");
                $(".responseAjax").append(data);
            });
        }
        else if (id !== null && type == 'service')
        {
            $.get("../projeto_integrador/show-orcamento.jsp?type=service&idClient=" + idClient + "&idService=" + id, function(data){
                $(".responseAjax").html("");
                $(".responseAjax").append(data);
            });
        }
        else
        {
            $.get("../projeto_integrador/show-orcamento.jsp?type=null&idClient=" + idClient , function(data){
                $(".responseAjax").html("");
                $(".responseAjax").append(data);
            });
        }
    }
    else {        
        // if (idProduct !== null || idService !== null)
        // {
        //     let $selected = $("#type_budget").val();
        //     if ($selected === "services")
        //     {
        //         $.get("../projeto_integrador/show-orcamento.jsp?typeService=null&local=null&type=service&idClient=" + idClient + "&idService=" + idService, function(data){
        //             $(".responseAjax").html("");
        //             $(".responseAjax").append(data);
        //         });
        //     }
        //     else if ($selected === "products")
        //     {
        //         $.get("../projeto_integrador/show-orcamento.jsp?typeService=null&local=null&type=product&idClient=" + idClient + "&idProduct=" + idProduct, function(data){
        //             $(".responseAjax").html("");
        //             $(".responseAjax").append(data);
        //         });
        //     }
        //     else
        //     {
        //         alert("Você deve selecionar algum tipo de produto!");
        //     } 
        // }
        // else 
        // {
            let $selected = $("#type_budget").val();
            if ($selected === "services")
            {
                // se serviço
                $.get("../projeto_integrador/show-orcamento.jsp?type=service&idClient=" + idClient, function(data){
                    $(".responseAjax").html("");
                    $(".responseAjax").append(data);
                });
            }
            else if ($selected === "products")
            {
                // se produto
                $.get("../projeto_integrador/show-orcamento.jsp?type=product&idClient=" + idClient, function(data){
                    $(".responseAjax").html("");
                    $(".responseAjax").append(data);
                });        
            }
            else
            {
                alert("Você deve selecionar algum tipo de produto!");
            } 
        // }        
    }    
}