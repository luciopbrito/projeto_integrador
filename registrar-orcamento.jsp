<%@page language="java" import="java.sql.*,java.util.*, java.text.*" contentType="text/html" pageEncoding="UTF-8" %>
<%
    // cria as variaveis e armazena as informações digitadas pelo usuario
    String idProduct = request.getParameter("idProduct");
    String idService = request.getParameter("idService");
    String idClient = request.getParameter("idClient");
    String type = "";
    Boolean redirect = false;
    Boolean searchId = false;
    Boolean hasIdProduct;
    Boolean hasIdService;
    Boolean searchTypeProduct = false;

    // links header 
    String link_produtosId = "<a href='./produtos-e-servicos.jsp?id=" + idClient + "&type=all' target='_parent' class='text-capitalize menu__a no-visual__a'><li>produtos</li></a>";
    String link_orcamentos = "<a href='./orcamentos.jsp?id=" + idClient + "' target='_parent' class='text-capitalize menu__a no-visual__a'><li>orçamentos</li></a>";
    String link_perfil = "<a href='./perfil.jsp?id=" + idClient + "' target='_parent' class='text-capitalize menu__a no-visual__a'><li>perfil</li></a>";
    String sair = "<a href='./login.jsp' target='_parent' class='text-capitalize menu__a no-visual__a'><li>sair</li></a>";
    
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

    PreparedStatement stm;

    ResultSet dados; 
    
    if (idClient == null || idClient.equals("null") || idClient.equals(""))
    {
        // response.sendRedirect("./index.jsp");
        redirect = true;
    }

    if (redirect == false)
    {
        if (idProduct == null)
        {
            hasIdProduct = false;
        }
        else if (idProduct.equals("null") || idProduct.equals(""))
        {
            hasIdProduct = false;
        }   
        else
        {
            hasIdProduct = true;
        }

        if (idService == null)
        {
            hasIdService = false;
        }
        else if (idService.equals("null") || idService.equals(""))
        {
            hasIdService = false;
        }   
        else
        {
            hasIdService = true;
        }
    
        if (hasIdProduct == true)
        {
            sql = "SELECT id_product FROM produtos WHERE id_product = '" + idProduct + "'";
            stm = conexao.prepareStatement(sql);
            dados = stm.executeQuery(); 
    
            while (dados.next())
            {
                if (dados.getString("id_product") != null)
                {
                    searchTypeProduct = true;
                }
                else
                {
                    redirect = true;
                }  
            }
        }
        else if (hasIdService == true)
        {
            sql = "SELECT id_service FROM servicos WHERE id_service = '" + idService + "'";
            stm = conexao.prepareStatement(sql);
            dados = stm.executeQuery(); 
    
            while (dados.next())
            {
                if (dados.getString("id_service") != null)
                {
                    searchTypeProduct = true;
                }
                else
                {
                    redirect = true;
                }  
            }
        }
    
        if (searchTypeProduct = true)
        {
            sql = "SELECT id_client FROM clientes WHERE id_client = '" + idClient + "'";
            stm = conexao.prepareStatement(sql);
            dados = stm.executeQuery();
    
            while (dados.next())
            {
                if (dados.getString("id_client") != null)
                {                                
                    if (searchTypeProduct == true)
                    {
                        if (hasIdProduct == true)
                        {
                            type = "product";
                        }
                        else if (hasIdService == true)
                        {
                            type = "service";
                        }
                        else 
                        {
                            redirect = true;
                        }                                   
                    }
                    else
                    {
                        type = "any";
                    }               
                }
                else
                {
                    redirect = true;
                }
            }  
        }        
    }
    
    if (redirect == true)
    {
        response.sendRedirect("./index.jsp");
    }
%>

<!DOCTYPE html>
<html lang="pt-br">
    <head>
        <meta charset="UTF-8">
        <meta http-equiv="X-UA-Compatible" content="IE=edge">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.6.1/jquery.min.js"></script>
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
                    <%
                        out.print("<a href='./index.jsp?id=" + idClient + "' target='_parent'>");
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
                                out.print("<a href='./index.jsp?id=" + idClient + "' class='text-capitalize menu__a no-visual__a' target='_parent'>");
                            %>
                                <li>home</li>
                            </a>
                            <%
                            idClient = request.getParameter("idClient");
                            out.print("<a href='./sobre.jsp?id=" + idClient + "\' target='_parent' class='menu__a no-visual__a'> <li>sobre nós</li> </a>");
                            %>
                            <%                                                           
                                out.print(login);                                
                            %>
                        </ul>
                    </nav>
                </div>
            </div>
        </header>
        <main>
            <div class="container d-flex flex-column gap-5 mb-5 mt-5">
                <h1 class="text-center fw-bold">Registrar Orçamento</h1>               
                <div class="responseAjax container"></div>                          
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
                        <%
                            out.print("<a href='./index.jsp?id=" + idClient + "' class='text-capitalize no-visual__a menu__a' target='_parent'>");
                        %>
                            <li>home</li>
                        </a>
                        <%
                        out.print("<a href='./sobre.jsp?id=" + idClient + "\' target='_parent' class='menu__a no-visual__a'> <li>sobre nós</li> </a>");
                        %>
                        <%                            
                           out.print(login);
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
        <script src="./js/menu.js"></script>
        <script src="./js/ajaxProduct.js"></script>
    </body>
</html>
<!-- <%
out.print("<a " + "class=\"btn btn-cinza-azulado btn-lg\"" + "href='./registrar-orcamento.jsp?id="+ idClient + "&idProduct=" + idProduct +"'>Crie um Orçamento</a>");
%> -->