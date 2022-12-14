<%@page language="java" import="java.sql.*,java.util.*, java.text.*" contentType="text/html" pageEncoding="UTF-8" %>
<%
    String id = request.getParameter("id");
    // config para html
    String link_cadastro = "<a href='./login.jsp?register=true' target='_parent' class='menu__a no-visual__a'><li>cadastra-se</li></a>";
    String link_login = "<a href='./login.jsp' target='_parent' class='menu__a no-visual__a'><li>login</li></a>";
    String link_produtosId = "<a href='./produtos-e-servicos.jsp?id=" + id + "&type=all' target='_parent' class='text-capitalize menu__a no-visual__a'><li>produtos</li></a>";
    String link_produtos = "<a href='./produtos-e-servicos.jsp?type=all' target='_parent' class='text-capitalize menu__a no-visual__a'><li>produtos</li></a>";
    String link_orcamentos = "<a href='./orcamentos.jsp?id=" + id + "' target='_parent' class='text-capitalize menu__a no-visual__a'><li>orçamentos</li></a>";
    String link_perfil = "<a href='./perfil.jsp?id=" + id + "' target='_parent' class='text-capitalize menu__a no-visual__a'><li>perfil</li></a>";
    String sair = "<a href='./login.jsp' target='_parent' class='text-capitalize menu__a no-visual__a'><li>sair</li></a>";
    String logoff = link_produtos + link_orcamentos + link_login + link_cadastro;
    String login = link_produtosId + link_orcamentos + link_perfil + sair;
%>
<!DOCTYPE html>
<html lang="pt-br">

<head>
    <meta charset="UTF-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.6.0/jquery.min.js"></script>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.2.2/dist/css/bootstrap.min.css" rel="stylesheet"
        integrity="sha384-Zenh87qX5JnK2Jl0vWa8Ck2rdkQ2Bzep5IDxbcnCeuOxjzrPF/et3URy9Bv1WTRi" crossorigin="anonymous">
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.2.2/dist/js/bootstrap.bundle.min.js"
        integrity="sha384-OERcA2EqjJCMA+/3y+gxIOqMEjwtxJY7qPCqsdltbNJuaOe923+mo//f6V8Qbsw3"
        crossorigin="anonymous"></script>
    <link rel="stylesheet" href="style.css">
    <title>ACB - Login</title>
</head>

<body>
    <header class="header">
        <div class="container">
            <div class="header__img">
                <%
                    if (id == null || id.equals("null"))
                    {
                        out.print("<a href='./index.jsp' target='_parent'>");
                    }
                    else
                    {
                        out.print("<a href='./index.jsp?id=" + id + "' target='_parent'>");
                    }
                %>                    
                    <img src="./assets/imgs/logo.png" alt="logo da empresa Aires Company Brasil">
                </a>                
            </div>
            <div class="menu__mobile">
                <div class="menu__toggle">
                    <img src="./assets/icons/list.svg" alt="icone para menu">
                </div>
                <nav class="menu">
                    <ul>
                        <%
                             if (id == null || id.equals("null"))
                            {
                                out.print("<a href='./index.jsp' class='menu__a no-visual__a' target='_parent'><li>home</li></a>");
                                out.print("<a href='./sobre.jsp' class='menu__a no-visual__a' target='_parent'><li>sobre nós</li></a>");
                            }
                            else
                            {
                                out.print("<a href='./index.jsp?id=" + id + "' class='menu__a no-visual__a' target='_parent'><li>home</li></a>");
                                out.print("<a href='./sobre.jsp?id=" + id + "' class='menu__a no-visual__a' target='_parent'><li>sobre nós</li></a>");
                            }
                        %>
                        <%                            
                            if(id == null || id.equals("null"))
                            {
                                out.println(logoff);
                            }
                            else
                            {
                                out.println(login);
                            }
                        %>
                    </ul>
                </nav>
            </div>
        </div>
    </header>
    <main class="main">
        <div class="container d-flex justify-content-around flex-wrap gap-5 p-4">
            <div class="card" style="width: 25rem;">
                <img src="./assets/imgs/imagem-lucio.jpeg" class="card-img-top" alt="imagem do integrante Lúcio" width="600">
                <div class="card-body">
                  <h5 class="card-title">Desenvolvedor FrontEnd</h5>
                  <p class="card-text" style="text-align: justify;">Olá meu nome é Lúcio, curso ADS na Faculdade ENIAC meu sonho é trabalhar fora do Brasil, estou correndo atrás desse sonho a cada dia!</p>
                  <a href="https://www.linkedin.com/in/lucio-brito/" class="btn btn-primary">LinkedIn</a>
                </div>
            </div>
            <div class="card" style="width: 25rem;">
                <img src="./assets/imgs/imagem-matheus.jpeg" class="card-img-top" alt="imagem do integrante matheus" width="600">
                <div class="card-body">
                  <h5 class="card-title">Gestão em Tecnologia</h5>
                  <p class="card-text" style="text-align: justify;">Olá, meu nome é Matheus, curso gestão em tecnologia da informação, meu sonho é trabalhar em outros estados ou países, mundo afora, conhecer o mundo. Tentando melhorar 1% a cada dia para alcançar essa objetivo.</p>
                  <a href="https://www.linkedin.com/in/matheus-morais-02ab20218" class="btn btn-primary">LinkedIn</a>
                </div>
            </div>
            <div class="card" style="width: 25rem;">
                <img src="./assets/imgs/imagem-wagner.jpeg" class="card-img-top" alt="imagem do integrante Wagner" width="600">
                <div class="card-body">
                  <h5 class="card-title">LP de Dados</h5>
                  <p class="card-text" style="text-align: justify;">Olá, me chamo Wagner, curso ADS na faculdade Eniac, trabalho atualmente na empresa Vivo, meu sonho é poder trabalhar de Home office para estar sempre perto da minha família.</p>
                  <a href="https://www.linkedin.com/in/wagner-overclock2014-b47540a7/" class="btn btn-primary">LinkedIn</a>
                </div>
            </div>
        </div>
    </main>
    <footer class="footer">    
        <div class="container">
            <div class="footer__info">
                <img src="assets/imgs/logo.png" />
                <h3 class="footer-info__title"> Soluções Intelbras </h3>
            </div>
            <nav class="footer__menu">
                <ul>
                    <%
                        if (id == null || id.equals("null"))
                        {
                            out.print("<a href='./index.jsp' class='footer-botão text-capitalize no-visual__a menu__a' target='_parent'><li>home</li></a>");
                            out.print("<a href='./sobre.jsp' class='footer-botão text-capitalize no-visual__a menu__a' target='_parent'><li>sobre nós</li></a>");
                        }
                        else
                        {
                            out.print("<a href='./index.jsp?id=" + id + "' class='footer-botão text-capitalize no-visual__a menu__a' target='_parent'><li>home</li></a>");
                            out.print("<a href='./sobre.jsp?id=" + id + "' class='footer-botão text-capitalize no-visual__a menu__a' target='_parent'><li>sobre nós</li></a>");
                        }
                    %>
                    <%                            
                        if(id == null || id.equals("null"))
                        {
                            out.println(logoff);
                        }
                        else
                        {
                            out.println(login);
                        }
                    %>
                </ul>
            </nav>
            <div class="footer__icons">
                <a href="#"><img src="assets/icons/facebook.svg" alt="icone facebook"></a>
                <a href="#"><img src="assets/icons/instagram.svg" alt="icone instagram"></a>
                <a href="#"><img src="assets/icons/twitter.svg" alt="icone twitter"></a>
            </div>
        </div>
    </footer>
    <script src="https://cdn.jsdelivr.net/npm/@popperjs/core@2.11.6/dist/umd/popper.min.js"
        integrity="sha384-oBqDVmMz9ATKxIep9tiCxS/Z9fNfEXiDAYTujMAeBAsjFuCZSmKbSSUnQlmh/jp3"
        crossorigin="anonymous"></script>
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.2.2/dist/js/bootstrap.min.js"
        integrity="sha384-IDwe1+LCz02ROU9k972gdyvl+AESN10+x7tBKgc9I5HFtuNz0wWnPclzo6p9vxnk"
        crossorigin="anonymous"></script>
</body>

</html>