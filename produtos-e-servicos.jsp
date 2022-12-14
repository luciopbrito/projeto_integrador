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
    String link_cadastro = "<a " + "class=\"text-capitalize menu__a no-visual__a\"" + " href='./login.jsp?register=true&redirect=produtos&type=" + type + "'>cadastre-se</a>";
    String link_login = "<a href='./login.jsp' target='_parent' class='text-capitalize menu__a no-visual__a'><li>login</li></a>";

    String link_produtosId = "<a href='./produtos-e-servicos.jsp?id=" + id + "&type=all' target='_parent' class='text-capitalize menu__a no-visual__a'><li>produtos</li></a>";
    String link_produtos = "<a href='./produtos-e-servicos.jsp?type=all' target='_parent' class='text-capitalize menu__a no-visual__a'><li>produtos</li></a>";
    String link_orcamentos = "<a href='./orcamentos.jsp?id=" + id + "' target='_parent' class='text-capitalize menu__a no-visual__a'><li>orçamentos</li></a>";
    String link_perfil = "<a href='./perfil.jsp?id=" + id + "' target='_parent' class='text-capitalize menu__a no-visual__a'><li>perfil</li></a>";
    String sair = "<a href='./login.jsp' target='_parent' class='text-capitalize menu__a no-visual__a'><li>sair</li></a>";
    

    String logoff = link_produtos + link_orcamentos + link_login + link_cadastro;
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
    switch (type)
    {
        case "products":
            sql = "SELECT * FROM produtos p";
            break;
        case "services":
            sql = "SELECT * FROM servicos s";
            break;
        case "feature":
            sql = "SELECT * FROM produtos p JOIN servicos s on s.isPromotion = p.isPromotion WHERE s.isPromotion = 0 GROUP BY s.id_service, s.name, s.value, s.isPromotion";
            break;
        case "all":
            sql = "SELECT * FROM produtos p";
            break;
        default:
            if (id == null || id.equals("null"))
            {
                response.sendRedirect("./index.jsp");               
            }
            else
            {       
                response.sendRedirect("./index.jsp?id=" + id);
            }
            break;
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
                                    out.print("<a href='./index.jsp' class='text-capitalize menu__a no-visual__a' target='_parent'>");
                                }
                                else
                                {
                                    out.print("<a href='./index.jsp?id=" + id + "' class='text-capitalize menu__a no-visual__a' target='_parent'>");
                                }
                            %>
                                <li>home</li>
                            </a>
                            <%
                            out.print("<a href='./sobre.jsp?id=" + id + "\' target='_parent' class='menu__a no-visual__a'> <li>sobre nós</li> </a>");
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
            <div class="container">
                <h1 class="titulo-PS">Produtos e Serviços</h1>
                <%                        
                    out.print("<form class=\"d-flex align-content-center gap-2\" action='./change-product.jsp?id="+ id +"' method='post'>");
                %>
                    <select name="type-product" class="border border-1 border-dark h-100">
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
                            out.print(" <option selected value='all'>todos</option>");
                        }
                        else
                        {
                            out.print("<option value='all'>todos</option>");
                        }
                    %>
                    </select>
                    <input class="btn btn-dark" type="submit" value="Buscar">
                </form>
                <div class="imagem-PS">
                <%
                    String id_product = "";
                    String id_service = "";
                    Boolean any = true;        
                    switch (type)
                    {
                        case "products":
                            // int cont = 0;
                            // // Boolean anotherContainer = false;
                            any = true;
                            id_product = "";
                            while (dados.next())
                            {
                                id_product = dados.getString("id_product");
                                out.print("<div>");
                                    out.print("<div class='imagem-produto'>");
                                        out.print("<img src='./assets/imgs/imagem-produto.jpg' alt='imagem do produto'>");                                   
                                    out.print("</div>");
                                    out.print("<h2>" + dados.getString("p.name") + "</h2>");
                                    out.print("<p>Preço R$"  + dados.getString("p.value") + "</p>");  
                                    if (id == null || id.equals("null"))
                                    {
                                        out.print("<a " + "class=\"btn btn-cinza-azulado btn-lg\"" + " href='./login.jsp?redirect=produtos&type=" + type + "'>Crie um Orçamento</a>");
                                    }
                                    else
                                    {
                                        out.print("<a " + "class=\"btn btn-cinza-azulado btn-lg\"" + "href='./registrar-orcamento.jsp?idClient="+ id + "&idProduct=" + id_product +"'>Crie um Orçamento</a>");
                                    }
                                out.print("</div>");   
                                any = false;
                            } 
                            stm.close();
                            if (any == true)
                            {
                                // não produtos no banco de dados
                                out.print("<h1>Não há produtos</h1>");
                            }   
                            break;                                  
                        case "services":
                            // int cont = 0;
                            // // Boolean anotherContainer = false;
                            any = true;
                            id_service = "";
                            while (dados.next())
                            {
                                id_product = dados.getString("id_service");
                                out.print("<div>");
                                    out.print("<div class='imagem-produto'>");
                                        out.print("<img src='./assets/imgs/imagem-servico.jpg' alt='imagem de serviço'>");      
                                    out.print("</div>");
                                    out.print("<h2>" + dados.getString("s.name") + "</h2>");
                                    out.print("<p>Preço R$"  + dados.getString("s.value") + "</p>");  
                                    if (id == null || id.equals("null"))
                                    {
                                        out.print("<a " + "class=\"btn btn-cinza-azulado btn-lg\"" + " href='./login.jsp?redirect=produtos&type=" + type + "'>Crie um Orçamento</a>");
                                    }
                                    else
                                    {
                                        out.print("<a " + "class=\"btn btn-cinza-azulado btn-lg\"" + "href='./registrar-orcamento.jsp?idClient="+ id + "&idService=" + id_service +"'>Crie um Orçamento</a>");
                                    }
                                out.print("</div>");   
                                any = false;
                            }                             
                            stm.close();
                            if (any == true)
                            {
                                // não produtos no banco de dados
                                out.print("<h1>Não há produtos</h1>");
                            }         
                            break;
                        case "feature":
                            any = true;
                            id_product = "";
                            id_service = "";
                            while (dados.next())
                            {                                
                                id_product = dados.getString("id_product");
                                out.print("<div>");
                                    out.print("<div class='imagem-produto'>");
                                        out.print("<img src='./assets/imgs/imagem-produto.jpg' alt='imagem do produto'>");                                 
                                    out.print("</div>");
                                    out.print("<h2>" + dados.getString("p.name") + "</h2>");
                                    out.print("<p>Preço R$"  + dados.getString("p.value") + "</p>");  
                                    if (id == null || id.equals("null"))
                                    {
                                        out.print("<a " + "class=\"btn btn-cinza-azulado btn-lg\"" + " href='./login.jsp?redirect=produtos&type=" + type + "'>Crie um Orçamento</a>");
                                    }
                                    else
                                    {
                                        out.print("<a " + "class=\"btn btn-cinza-azulado btn-lg\"" + "href='./registrar-orcamento.jsp?idClient="+ id + "&idProduct=" + id_product +"'>Crie um Orçamento</a>");
                                    }
                                out.print("</div>");  
                                id_service = dados.getString("id_service");
                                out.print("<div>");
                                    out.print("<div class='imagem-produto'>");
                                        out.print("<img src='./assets/imgs/imagem-servico.jpg' alt='imagem de serviço'>");                        
                                    out.print("</div>");
                                    out.print("<h2>" + dados.getString("s.name") + "</h2>");
                                    out.print("<p>Preço R$"  + dados.getString("s.value") + "</p>");  
                                    if (id == null || id.equals("null"))
                                    {
                                        out.print("<a " + "class=\"btn btn-cinza-azulado btn-lg\"" + " href='./login.jsp?redirect=produtos&type=" + type + "'>Crie um Orçamento</a>");
                                    }
                                    else
                                    {
                                        out.print("<a " + "class=\"btn btn-cinza-azulado btn-lg\"" + "href='./registrar-orcamento.jsp?idClient="+ id + "&idService=" + id_service +"'>Crie um Orçamento</a>");
                                    }
                                out.print("</div>");                            
                                any = false; 
                            }           
                            stm.close();
                            if (any == true)
                            {
                                // não produtos no banco de dados
                                out.print("<h1>Não há produtos</h1>");
                            }         
                            break;
                        case "all":
                            any = true;
                            id_product = "";
                            id_service = "";                                                    
                            while (dados.next())
                            {                                
                                id_product = dados.getString("id_product");
                                out.print("<div>");
                                    out.print("<div class='imagem-produto'>");
                                        out.print("<img src='./assets/imgs/imagem-produto.jpg' alt='imagem do produto'>");                                 
                                    out.print("</div>");
                                    out.print("<h2>" + dados.getString("p.name") + "</h2>");
                                    out.print("<p>Preço R$"  + dados.getString("p.value") + "</p>");  
                                    if (id == null || id.equals("null"))
                                    {
                                        out.print("<a " + "class=\"btn btn-cinza-azulado btn-lg\"" + " href='./login.jsp?redirect=produtos&type=" + type + "'>Crie um Orçamento</a>");
                                    }
                                    else
                                    {
                                        out.print("<a " + "class=\"btn btn-cinza-azulado btn-lg\"" + "href='./registrar-orcamento.jsp?idClient="+ id + "&idProduct=" + id_product +"'>Crie um Orçamento</a>");
                                    }
                                out.print("</div>");
                                any = false; 
                            }
                            sql = "SELECT * FROM servicos s";
                            stm = conexao.prepareStatement(sql);
                            dados = stm.executeQuery() ; 
                            while (dados.next())
                            {
                                id_service = dados.getString("id_service");
                                out.print("<div>");
                                    out.print("<div class='imagem-produto'>");
                                        out.print("<img src='./assets/imgs/imagem-servico.jpg' alt='imagem de serviço'>");                        
                                    out.print("</div>");
                                    out.print("<h2>" + dados.getString("s.name") + "</h2>");
                                    out.print("<p>Preço R$"  + dados.getString("s.value") + "</p>");  
                                    if (id == null || id.equals("null"))
                                    {
                                        out.print("<a " + "class=\"btn btn-cinza-azulado btn-lg\"" + " href='./login.jsp?redirect=produtos&type=" + type + "'>Crie um Orçamento</a>");
                                    }
                                    else
                                    {
                                        out.print("<a " + "class=\"btn btn-cinza-azulado btn-lg\"" + "href='./registrar-orcamento.jsp?idClient="+ id + "&idService=" + id_service +"'>Crie um Orçamento</a>");
                                    }
                                out.print("</div>");
                                any = false;  
                            }           
                            stm.close();
                            if (any == true)
                            {
                                // não produtos no banco de dados
                                out.print("<h1>Não há produtos</h1>");
                            }  
                            break;
                    }                                       
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
                        <%
                            if (id == null || id.equals("null"))
                            {
                                out.print("<a href='./index.jsp' class='text-capitalize no-visual__a menu__a' target='_parent'>");
                            }
                            else
                            {
                                out.print("<a href='./index.jsp?id=" + id + "' class='text-capitalize no-visual__a menu__a' target='_parent'>");
                            }
                        %>
                            <li>home</li>
                        </a>
                        <%
                        out.print("<a href='./sobre.jsp?id=" + id + "\' target='_parent' class='menu__a no-visual__a'> <li>sobre nós</li> </a>");
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
            crossorigin="anonymous">
        </script>
        <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.2.2/dist/js/bootstrap.min.js"
            integrity="sha384-IDwe1+LCz02ROU9k972gdyvl+AESN10+x7tBKgc9I5HFtuNz0wWnPclzo6p9vxnk"
            crossorigin="anonymous">
        </script>
        <script src="./js/menu.js"></script>
    </body>
</html>