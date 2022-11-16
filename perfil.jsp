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

    if (id == null || id.equals("null"))
    {
        response.sendRedirect("index.jsp");
    }

    // variaveis para o banco de dados
    String banco    = "projetointegrador";
    String endereco = "jdbc:mysql://localhost:3306/" + banco ;
    String usuario  = "root" ;
    String senhaBanco    = "" ;

    String driver   = "com.mysql.jdbc.Driver" ;

    //Carregar o driver na memoria
    Class.forName( driver );

    //cria a variavel para conectar com o banco
    Connection conexao ;

    //Abrir a conexao com o banco de dados
    conexao = DriverManager.getConnection(endereco, usuario, senhaBanco) ;

    String sql = "SELECT * FROM clientes WHERE id_client ='" + id + "'"; 

    PreparedStatement stm = conexao.prepareStatement(sql);
    ResultSet dados = stm.executeQuery();
 
    while (dados.next())
    {
        if (dados.getString("id_client").equals("null"))
        {
            response.sendRedirect("./index.jsp");
        }
        else
        {
            
        }
    }
   
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
        <div class="container-perfil container">
            <h1 class="dadostitulo">Dados do Cadastro</h1>
            <div class="container container_dados">
                <div>
                    <div class="container-dados-pessoais">
                        <h1 class="dadostitulo">Dados Pessoais</h1>
                        <div class="container-fluid d-flex">
                            <div class="d-flex flex-column gap-4 dados-filho">
                                <%
                                    sql = "SELECT * FROM clientes WHERE id_client ='" + id + "'"; 

                                    stm = conexao.prepareStatement(sql);
                                    dados = stm.executeQuery();
                                    while (dados.next())
                                    {
                                        out.print("<p>Nome: <br>" + dados.getString("name") + "</p>");
                                        out.print("<p>Email:: <br>" + dados.getString("email") + "</p>");
                                    }   
                                    stm.close();
                                %>                                     
                            </div>
                            <div class="d-flex flex-column gap-4 dados-filho">
                                <%
                                    sql = "SELECT * FROM clientes WHERE id_client ='" + id + "'"; 

                                    stm = conexao.prepareStatement(sql);
                                    dados = stm.executeQuery();
                                    while (dados.next())
                                    {
                                        out.print("<p>Telefone: <br>" + dados.getString("phone") + "</p>");
                                        out.print("<p>Senha: <br>" + dados.getString("password") + "</p>");
                                    }    
                                    stm.close();
                                %>  
                            </div>
                        </div>
                        <%out.print("<button class='btn btn-lg btn-cinza-azulado' onclick=\"window.location.href='./editar-dados.jsp?id=" + id + "&dados=pessoal" + "'\"" +">editar</button>");%>
                    </div>
                </div>
                <div>
                    <div class="container-dados-endereco">                    
                        <h1 class="dadostitulo">Endereço</h1>
                        <div class="d-flex">
                            <div class="d-flex flex-column gap-4 dados-filho">
                                <%
                                    sql = "SELECT * FROM clientes WHERE id_client ='" + id + "'"; 

                                    stm = conexao.prepareStatement(sql);
                                    dados = stm.executeQuery();
                                    while (dados.next())
                                    {
                                        out.print("<p>CEP: <br>" + dados.getString("cep") + "</p>");
                                        out.print("<p>Bairro: <br>" + dados.getString("district") + "</p>");
                                    }  
                                    stm.close();  
                                %> 
                            </div>
                            <div class="d-flex flex-column gap-4 dados-filho">
                                <%
                                    sql = "SELECT * FROM clientes WHERE id_client ='" + id + "'"; 

                                    stm = conexao.prepareStatement(sql);
                                    dados = stm.executeQuery();
                                    while (dados.next())
                                    {
                                        out.print("<p>Rua: <br>" + dados.getString("street") + "</p>");
                                        out.print("<p>Cidade: <br>" + dados.getString("city") + "</p>");
                                    }    
                                    stm.close();
                                %> 
                            </div>
                            <div class="d-flex flex-column gap-4 dados-filho">   
                                <%
                                    sql = "SELECT * FROM clientes WHERE id_client ='" + id + "'"; 

                                    stm = conexao.prepareStatement(sql);
                                    dados = stm.executeQuery();
                                    while (dados.next())
                                    {
                                        out.print("<p>Nº: <br>" + dados.getString("street_number") + "</p>");
                                    }    
                                    stm.close();
                                %>                             
                            </div>
                        </div>
                        <%out.print("<button class='btn btn-lg btn-cinza-azulado' onclick=\"window.location.href='./editar-dados.jsp?id=" + id + "&dados=endereco" + "'\"" +">editar</button>");%>           
                    </div>
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