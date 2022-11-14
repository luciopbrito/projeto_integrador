<%@page language="java" import="java.sql.*,java.util.*, java.text.*" contentType="text/html" pageEncoding="UTF-8" %>
<%
    // cria as variaveis e armazena as informações digitadas pelo usuario
    String type = request.getParameter("type");
    String id = request.getParameter("id");

    // out.print(type);

    if (type == null)
    {
        type = "all";
    }

    // links header 
    String link_cadastro = "<a href='./login.html?register=true' target='_parent' class='menu__a no-visual__a'><li>cadastra-se</li></a>";
    String link_login = "<a href='./login.html' target='_parent' class='menu__a no-visual__a'><li>login</li></a>";

    String link_produtosId = "<a href='./produtos-e-servicos.jsp?id=" + id + "&type=all' target='_parent' class='menu__a no-visual__a'><li>produtos</li></a>";
    String link_produtos = "<a href='./produtos-e-servicos.jsp?type=all' target='_parent' class='menu__a no-visual__a'><li>produtos</li></a>";
    String link_orcamentos = "<a href='./orcamentos.jsp?id=" + id + "' target='_parent' class='menu__a no-visual__a'><li>orçamentos</li></a>";
    String link_perfil = "<a href='./perfil.jsp?id=" + id + "' target='_parent' class='menu__a no-visual__a'><li>perfil</li></a>";
    String sair = "<a href='./login.html' target='_parent' class='menu__a no-visual__a'><li>sair</li></a>";

    String logoff = link_produtos + link_cadastro + link_login;
    String login = link_produtosId + link_orcamentos + link_perfil + sair;

 
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

    String sql = "";
    //Cria a variavel sql com o comando de Inserir
    if (type == null)
    {
        sql = "SELECT * FROM produtos";
    }    
    else if (type.equals("products"))
    {   
        sql = "SELECT * FROM produtos WHERE type_product = 1";
    }
    else if (type.equals("services"))
    {
        sql = "SELECT * FROM produtos WHERE type_product = 0";
    }
    else if (type.equals("feature"))
    {
        sql = "SELECT * FROM produtos WHERE promotion = 0";
    }
    else if(type.equals("all"))
    {
        sql = "SELECT * FROM produtos";
    }
 
    PreparedStatement stm = conexao.prepareStatement(sql);

    ResultSet dados = stm.executeQuery() ; 
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
        <title>ACB - Produtos e serviços</title>
    </head>
    <body>
        <header class="header">
            <div class="container">
                <div class="header__img">
                    <a href="./index.jsp" target="_parent">
                        <img src="./assets/imgs/logo.png" alt="logo da empresa Aires Company Brasil">
                    </a>
                </div>
                <div class="menu__mobile">
                    <div class="menu__toggle">
                        <img src="./assets/icons/list.svg" alt="icone para menu">
                    </div>
                    <nav class="menu">
                        <ul>
                            <a href="./index.jsp" target="_parent" class="menu__a no-visual__a">
                                <li>home</li>
                            </a>
                            <a href="./sobre.html" target="_parent" class="menu__a no-visual__a">
                                <li>sobre nós</li>
                            </a>
                            <%                            
                                if(id.equals("null"))
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
            <div class="container">
                <h1 class="titulo-PS">Produtos e Serviços</h1>
                <div class="d-flex gap-2">
                    <%                        
                        out.print("<form action='./change-product.jsp?id="+ id +"' method='post'>");
                    %>
                        <select name="type-product" class="border border-1 border-dark">
                        <%
                            if (type.equals("services"))
                            {
                                out.print("<option selected value='services'>serviços</option>");
                            }
                            else
                            {
                                out.print("<option value='services'>serviços</option>");
                            }
                            if (type.equals("products"))
                            {
                                out.print("<option selected value='products'>produtos</option>");
                            }
                            else
                            {
                                out.print("<option value='products'>produtos</option>");
                            }
                            if (type.equals("feature"))
                            {
                                out.print("<option selected value='feature'>destaques</option>");
                            }
                            else
                            {
                                out.print("<option value='feature'>destaques</option>");
                            }
                            if (type.equals("all"))
                            {
                                out.print(" <option selected value='all' selected>todos</option>");
                            }
                            else
                            {
                                out.print("<option value='all'>todos</option>");
                            }
                        %>
                        </select>
                        <input class="btn btn-dark" type="submit" value="Buscar">
                    </form>
                </div>
                <div class="imagem-PS">
                <%
                    int cont = 0;
                    Boolean anotherContainer = false;
                    Boolean any = true;
                    while (dados.next())
                    {
                        out.print("<div>");
                            out.print("<div class='imagem-produto'>");
                            // out.print(dados.getString("type_product"));
                                if (Integer.parseInt(dados.getString("type_product")) == 1)
                                {
                                    out.print("<img src='./assets/imgs/imagem-produto.jpg' alt='imagem do produto'>");
                                }
                                else
                                {
                                    out.print("<img src='./assets/imgs/imagem-servico.jpg' alt='imagem de serviço'>");
                                }                                    
                            out.print("</div>");
                            out.print("<h2>" + dados.getString("name") + "</h2>");
                            out.print("<p>Preço R$"  + dados.getString("value_product") + "</p>");  
                            // out.print("<a href=""></a>");
                        out.print("</div>");   
                        any = false;
                    } 
                    if (any == true)
                    {
                        out.print("<h1>Não há produtos</h1>");
                    }         
                    // // response.sendRedirect("./index.jsp?id=" + id);
                %>
                </div>
            </div>
        </main>
        <footer class="footer">
            <div class="container">
                <div class="footer__info">
                    <img class="footer-info__logo" src="assets/imgs/logo.png" />
                    <h3 class="footer-info__title"> Soluções Intelbras </h3>
                </div>
                <nav class="footer__menu">
                    <ul>
                        <a href="./index-login.html" class="text-capitalize no-visual__a menu__a">
                            <li>home</li>
                        </a>
                        <a href="./sobre.html" class="text-capitalize no-visual__a menu__a">
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
                <div class="footer__icons">
                    <a href="#"><img src="assets/icons/facebook.svg" alt="icone facebook"></a>
                    <a href="#"><img src="assets/icons/instagram.svg" alt="icone instagram"></a>
                    <a href="#"><img src="assets/icons/twitter.svg" alt="icone twitter"></a>
                </div>
            </div>
        </footer>
        <script src="https://cdn.jsdelivr.net/npm/@popperjs/core@2.11.6/dist/umd/popper.min.js"
            integrity="sha384-oBqDVmMz9ATKxIep9tiCxS/Z9fNfEXiDAYTujMAeBAsjFuCZSmKbSSUnQlmh/jp3"
            crossorigin="anonymous">
        </script>
        <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.2.2/dist/js/bootstrap.min.js"
            integrity="sha384-IDwe1+LCz02ROU9k972gdyvl+AESN10+x7tBKgc9I5HFtuNz0wWnPclzo6p9vxnk"
            crossorigin="anonymous">
        </script>
    </body>
</html>