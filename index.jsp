<%@page language="java" import="java.sql.*,java.util.*, java.text.*" contentType="text/html" pageEncoding="UTF-8" %>
<%
    String id = request.getParameter("id");

     // variaveis para o banco de dados
    String banco    = "projetointegrador";
    String endereco = "jdbc:mysql://localhost:3306/" + banco ;
    String usuario  = "root" ;
    String senha    = "" ;

    String driver   = "com.mysql.jdbc.Driver" ;

    //Carregar o driver na memoria
    Class.forName( driver );

    //cria a variavel para conectar com o banco
    Connection conexao ;

    //Abrir a conexao com o banco de dados
    conexao = DriverManager.getConnection(endereco, usuario, senha) ;

    //Cria a variavel sql com o comando de Inserir
    String sql = "SELECT id_client FROM clientes WHERE id_client = '" + id + "'";

    // String sql = "SELECT * FROM clientes"

    PreparedStatement stm = conexao.prepareStatement(sql);

    ResultSet dados = stm.executeQuery() ;
    stm.close();

    // config para html
    String link_cadastro = "<a href='./login.html?register=true' target='_parent' class='menu__a no-visual__a'><li>cadastra-se</li></a>";
    String link_login = "<a href='./login.html' target='_parent' class='menu__a no-visual__a'><li>login</li></a>";

    String link_produtos = "<a href='./produtos.jsp?id=" + id + "' target='_parent' class='menu__a no-visual__a'><li>produtos</li></a>";
    String link_orcamentos = "<a href='./orcamentos.jsp?id=" + id + "' target='_parent' class='menu__a no-visual__a'><li>orçamentos</li></a>";
    String link_perfil = "<a href='./perfil.jsp?id=" + id + "' target='_parent' class='menu__a no-visual__a'><li>perfil</li></a>";
    String sair = "<a href='./login.html' target='_parent' class='menu__a no-visual__a'><li>sair</li></a>";

    String logoff = link_cadastro + link_login;
    String login = link_produtos + link_orcamentos + link_perfil + sair;
    String loginFooter = link_produtos + link_orcamentos + link_perfil;
%>
    <!DOCTYPE html>
    <html lang="pt-br">

    <head>
        <meta charset="UTF-8"> 
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.6.0/jquery.min.js"></script>
        <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.2.2/dist/css/bootstrap.min.css" rel="stylesheet"
            integrity="sha384-Zenh87qX5JnK2Jl0vWa8Ck2rdkQ2Bzep5IDxbcnCeuOxjzrPF/et3URy9Bv1WTRi" crossorigin="anonymous">
        <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.2.2/dist/js/bootstrap.bundle.min.js"
            integrity="sha384-OERcA2EqjJCMA+/3y+gxIOqMEjwtxJY7qPCqsdltbNJuaOe923+mo//f6V8Qbsw3"
            crossorigin="anonymous"></script>
        <link rel="stylesheet" href="./style.css">
        <title>ACB - Soluções Intelbras</title>
    </head>

    <body>
        <header class="header">
            <div class="container">
                <div class="header__img">
                    <a href="./index.html" target="_parent">
                        <img src="./assets/imgs/logo.png" alt="logo da empresa Aires Company Brasil">
                    </a>
                </div>
                <div class="menu__mobile">
                    <div class="menu__toggle">
                        <img src="./assets/icons/list.svg" alt="icone para menu">
                    </div>
                    <nav class="menu">
                        <ul>
                            <a href="./index.html" target="_parent" class="menu__a no-visual__a">
                                <li>home</li>
                            </a>
                            <a href="./sobre.html" target="_parent" class="menu__a no-visual__a">
                                <li>sobre nós</li>
                            </a>
                            <%                            
                                if(id == null)
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
            <div class="container-carrosel">
            <div class="carrosel__imgs">
                    <img src="./assets/imgs/carrosel_img1.jpg" alt="imagem de um modem visto de atrás">
                    <img src="./assets/imgs/carrosel_img2.jpg"
                        alt="imagem de duas câmeras em fixadas sobre uma parede cinza">
                    <img src="./assets/imgs/carrosel_img3.jpg"
                        alt="imagem de um servidor com cabos conectados visto de atrás">
                    <img src="./assets/imgs/carrosel_img4.jpg"
                        alt="imagem de um câmera rodonda com duas antenas fixada entre duas paredes">
                </div>
                <hgroup class="carrosel__titles">
                    <h1 class="carrosel__title text-capitalize">aires company brasil</h1>
                    <h2 class="carrosel__text text-capitalize">soluções intelbras</h2>
                </hgroup>
            </div>
            <section class="section__sobre">
                <h2 class="section-sobre__title text-capitalize fw-bold"> sobre nós </h2>
                <div class="section__items">
                    <div class="section__item">
                        <img class="carousel-image" src="assets/imgs/Vendas de produtos.png" />
                        <h3 class="section__sobre__subtitle text-capitalize fw-bold"> vendas de produtos </h3>
                    </div>
                    <div class="section__item">
                        <img class="carousel-image" src="assets/imgs/Manutenção.png" />
                        <h3 class="section__sobre__subtitle text-capitalize fw-bold"> manutenção </h3>
                    </div>
                </div>
                <div class="section__item">
                    <img class="carousel-image" src="assets/imgs/Instalação de equipamento.png" />
                    <h3 class="section__sobre__subtitle text-capitalize fw-bold"> instalação de equipamento </h3>
                </div>
            </section> 
        </main>
        <footer class="footer">
            <div class="container">
                <div class="footer__info">
                    <img class="footer-info__logo" src="assets/imgs/logo.png" />
                    <h3 class="footer-info__title"> Soluções Intelbras </h3>
                </div>
                <nav class="footer__menu">
                    <ul>
                        <a href="./index.html" class="footer-botão text-capitalize no-visual__a menu__a">
                            <li>home</li>
                        </a>
                        <a href="./sobre.html" class="footer-botão text-capitalize no-visual__a menu__a">
                            <li>sobre nós</li>
                        </a>
                        <%                            
                            if(id == null)
                            {
                                out.println(logoff);
                            }
                            else
                            {
                                out.println(loginFooter);
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
        <script src="./js/menu.js"></script>
        <script src="./js/carrosel.js"></script>
    </body>

    </html>
