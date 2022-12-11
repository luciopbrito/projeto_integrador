<%@page language="java" import="java.sql.*,java.util.*, java.text.*, java.time.format.DateTimeFormatter, java.time.LocalDate" contentType="text/html" pageEncoding="UTF-8" %>
<%
    String id = request.getParameter("id");

    String link_cadastro = "<a href='./login.jsp?register=true' target='_parent' class='menu__a no-visual__a'><li>cadastra-se</li></a>";
    String link_login = "<a href='./login.jsp' target='_parent' class='menu__a no-visual__a'><li>login</li></a>";

    String link_produtosId = "<a href='./produtos-e-servicos.jsp?id=" + id + "&type=all' target='_parent' class='menu__a no-visual__a'><li>produtos</li></a>";
    String link_produtos = "<a href='./produtos-e-servicos.jsp?type=all' target='_parent' class='menu__a no-visual__a'><li>produtos</li></a>";
    String link_orcamentos = "<a href='./orcamentos.jsp?id=" + id + "' target='_parent' class='menu__a no-visual__a'><li>orçamentos</li></a>";
    String link_perfil = "<a href='./perfil.jsp?id=" + id + "' target='_parent' class='menu__a no-visual__a'><li>perfil</li></a>";
    String sair = "<a href='./login.jsp' target='_parent' class='menu__a no-visual__a'><li>sair</li></a>";

    String logoff = link_produtos + link_orcamentos + link_login + link_cadastro;
    String login = link_produtosId + link_orcamentos + link_perfil + sair;
    Integer show = 0;
    Boolean searchOrcamento = false;
    Float ValueTotalOrcamento = 0.0F; 


    // não é usuário cadastrado
    if (id == null || id.equals("null") || id == "")
    { 
        show = 1;  
    }
    else
    {
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

        String sql = "SELECT id_client FROM clientes WHERE id_client ='" + id + "'"; 

        PreparedStatement stm = conexao.prepareStatement(sql);
    
        ResultSet dados = stm.executeQuery();

        while (dados.next())
        {
            if (dados.getString("id_client") != null)
            {
                searchOrcamento = true;
            }
        }

        dados.close();
        stm.close();
    }

    if (searchOrcamento == true)
    {
         // possui id    
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

        String sql = "SELECT id_client id FROM orcamentos WHERE id_client ='" + id + "'"; 
        
        PreparedStatement stm = conexao.prepareStatement(sql);

        ResultSet dados = stm.executeQuery();                           
        
        if (dados.next() != false)
        {
            show = 3;
        }
        else
        {
            show = 2;
        }           
        dados.close();
        stm.close();    
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
        <main>        
            <div class="container d-flex flex-column align-content-between gap-5 mb-5 mt-5">
                <h1 class="text-center fw-bold">Orçamentos</h1>            
                <%                
                    switch (show) {
                        case 1:
                             // não é usuário cadastro no sistema
                            out.print("<div class='container-orcamentos d-flex flex-column justify-content-center align-items-center'>");
                            out.print("<h2 class='title-orcamento text-bolder'>Nenhum produto cadastrado</h2>");
                            out.print("<button class='btn btn-cinza-azulado btn-lg' onclick='window.location.href=\"./login.jsp?redirect=orcamentos\"'>Faça um orçamento</button>");
                            out.print("</div>");
                            break;
                        case 2:
                            // usuário não possui nenhum orçamento
                            out.print("<div class='container-orcamentos d-flex flex-column justify-content-center align-items-center'>");
                            out.print("<h2 class='title-orcamento text-bold'>Nenhum produto cadastrado</h2>");
                            out.print("<button class=\"btn btn-cinza-azulado btn-lg\" onclick=\"window.location.href='produtos-e-servicos.jsp?id="+ id + "\'\">Faça um orçamento</button>");
                            out.print("</div>");
                            break;
                        case 3:
                            String banco    = "projetointegrador";
                            String endereco = "jdbc:mysql://localhost:3306/" + banco ;
                            String usuario  = "root" ;
                            String senha    = "" ;
                        
                            String driver   = "com.mysql.jdbc.Driver" ;
                        
                            //Carregar o driver na memoria
                            Class.forName( driver );                                    
                        
                            //Abrir a conexao com o banco de dados
                            Connection conexao = DriverManager.getConnection(endereco, usuario, senha) ;

                            String sql = "SELECT COUNT(id_service) id_service, COUNT(id_product) id_product FROM orcamentos WHERE id_client = '" + id + "'";
                            PreparedStatement stm = conexao.prepareStatement(sql);
                        
                            ResultSet dados = stm.executeQuery();

                            Integer typeSql = 0;
                            while (dados.next() != false)
                            {
                                if (Integer.valueOf(dados.getString("id_service")) > 0 && Integer.valueOf(dados.getString("id_product")) == 0)
                                {
                                    typeSql = 1;
                                }
                                else if (Integer.valueOf(dados.getString("id_service")) == 0 && Integer.valueOf(dados.getString("id_product")) > 0)
                                {
                                    typeSql = 2;
                                }         
                                else if (Integer.valueOf(dados.getString("id_service")) > 0 && Integer.valueOf(dados.getString("id_product")) > 0)
                                {
                                    typeSql = 3;
                                }
                            }

                            switch (typeSql)
                            {
                                case 1:
                                    sql = "SELECT s.name, s.value, o.start_date, o.due_date, o.value_orcamento, o.id_client FROM orcamentos as o join servicos as s on s.id_service = o.id_service WHERE o.id_client ='" + id + "'";                        

                                    stm = conexao.prepareStatement(sql);
                                
                                    dados = stm.executeQuery();
                                
                                    out.print("<div class='container-orcamentos p-5 d-flex justify-content-center flex-wrap gap-5'>");
                                    while (dados.next())
                                    {                                
                                        // out.print("<p>Numero do orcamento" + dados.getString("o.id_") + "</p>");
                                        out.print("<div class=\"card imagem-produto\">");
                                            out.print("<img class='card-img-top' src='./assets/imgs/imagem-servico.jpg' alt='imagem de serviço'>");
                                        out.print("<div class='card-body d-flex flex-column'>");           
                                            out.print("<h2 class='card-title text-center'>Nome do Produto: " + dados.getString("s.name") + "</h2>");                                                                   
                                            out.print("<p class='card-text text-center fs-3'>");
                                                out.print("<strong>Preço:</strong> R$" + dados.getString("s.value") + "<br>");                                    
                                                out.print("<strong>Inicio do orçamento:</strong> <br>" + dados.getString("o.start_date") + "<br>");
                                                out.print("<strong>Vencimento do orcamento:</strong> <br>" + dados.getString("o.due_date") + "<br>");    
                                            out.print("</p>");
                                            out.print("<div class='d-flex justify-content-center'>");
                                                out.print("<a href='#'class='btn btn-cinza-azulado'>Ver Detalhes</a>");
                                            out.print("</div>");
                                        out.print("</div>");                            
                                        out.print("</div>");
                                        ValueTotalOrcamento += Float.parseFloat(dados.getString("o.value_orcamento"));
                                    }         
                                    out.print("</div>");  
                                    break;
                                case 2:
                                    sql = "SELECT p.name, p.value, o.start_date, o.due_date, o.value_orcamento, o.qtde_product, o.id_client FROM orcamentos as o join produtos as p on p.id_product = o.id_product WHERE o.id_client ='" + id + "'";                        

                                    stm = conexao.prepareStatement(sql);
                                
                                    dados = stm.executeQuery();
                                
                                    out.print("<div class='container-orcamentos p-5 d-flex justify-content-center flex-wrap gap-5'>");
                                    while (dados.next())
                                    {                                
                                        // out.print("<p>Numero do orcamento" + dados.getString("o.id_") + "</p>");
                                        out.print("<div class=\"card imagem-produto\">");
                                            out.print("<img class='card-img-top' src='./assets/imgs/imagem-produto.jpg' alt='imagem do produto'>");
                                        out.print("<div class='card-body d-flex flex-column'>");           
                                            out.print("<h2 class='card-title text-center'>Nome do Produto: " + dados.getString("p.name") + "</h2>");                                                                   
                                            DateTimeFormatter formato = DateTimeFormatter.ofPattern("dd/MM/yyyy");   
                                            LocalDate start_date = LocalDate.parse(dados.getString("o.start_date"));
                                            LocalDate due_date = LocalDate.parse(dados.getString("o.due_date"));
                                            
                                            out.print("<p class='card-text text-center fs-3'>");
                                                out.print("<strong>Preço:</strong> R$" + dados.getString("p.value") + "<br>");                                    
                                                out.print("<strong>Quantidade:</strong>" + dados.getString("o.qtde_product") + "<br>");                                    
                                                out.print("<strong>Inicio do orçamento:</strong> <br>" + formato.format(start_date) + "<br>");
                                                out.print("<strong>Vencimento do orcamento:</strong> <br>" + formato.format(due_date) + "<br>");    
                                            out.print("</p>");
                                            out.print("<div class='d-flex justify-content-center'>");
                                                out.print("<a href='#'class='btn btn-cinza-azulado'>Ver Detalhes</a>");
                                            out.print("</div>");
                                        out.print("</div>");                            
                                        out.print("</div>");
                                        ValueTotalOrcamento += Float.parseFloat(dados.getString("o.value_orcamento"));
                                    }         
                                    out.print("</div>");  
                                    break;
                                case 3:
                                    sql = "SELECT s.name, s.value, o.start_date, o.due_date, o.value_orcamento, o.id_client FROM orcamentos as o join servicos as s on s.id_service = o.id_service WHERE o.id_client ='" + id + "'";                        

                                    stm = conexao.prepareStatement(sql);
                                
                                    dados = stm.executeQuery();
                                
                                    out.print("<div class='container-orcamentos p-5 d-flex justify-content-center flex-wrap gap-5'>");
                                    while (dados.next())
                                    {                                
                                        // out.print("<p>Numero do orcamento" + dados.getString("o.id_") + "</p>");
                                        out.print("<div class=\"card imagem-produto\">");
                                            out.print("<img class='card-img-top' src='./assets/imgs/imagem-servico.jpg' alt='imagem de serviço'>");
                                        out.print("<div class='card-body d-flex flex-column'>");           
                                            out.print("<h2 class='card-title text-center'>Nome do Produto: " + dados.getString("s.name") + "</h2>");                                                                   
                                            DateTimeFormatter formato = DateTimeFormatter.ofPattern("dd/MM/yyyy");   
                                            LocalDate start_date = LocalDate.parse(dados.getString("o.start_date"));
                                            LocalDate due_date = LocalDate.parse(dados.getString("o.due_date"));

                                            out.print("<p class='card-text text-center fs-3'>");
                                                out.print("<strong>Preço:</strong> R$" + dados.getString("s.value") + "<br>");                                    
                                                out.print("<strong>Inicio do orçamento:</strong> <br>" + formato.format(start_date) + "<br>");
                                                out.print("<strong>Vencimento do orcamento:</strong> <br>" + formato.format(start_date) + "<br>");    
                                            out.print("</p>");
                                            out.print("<div class='d-flex justify-content-center'>");
                                                out.print("<a href='#'class='btn btn-cinza-azulado'>Ver Detalhes</a>");
                                            out.print("</div>");
                                        out.print("</div>");                            
                                        out.print("</div>");
                                        ValueTotalOrcamento += Float.parseFloat(dados.getString("o.value_orcamento"));
                                    }                                          

                                    // serviços
                                    sql = "SELECT p.name, p.value, o.start_date, o.due_date, o.value_orcamento, o.qtde_product, o.id_client FROM orcamentos as o join produtos as p on p.id_product = o.id_product WHERE o.id_client ='" + id + "'";                        

                                    stm = conexao.prepareStatement(sql);
                                
                                    dados = stm.executeQuery();
                                                                    
                                    while (dados.next())
                                    {                                
                                        // out.print("<p>Numero do orcamento" + dados.getString("o.id_") + "</p>");
                                        out.print("<div class=\"card imagem-produto\">");
                                            out.print("<img class='card-img-top' src='./assets/imgs/imagem-produto.jpg' alt='imagem do produto'>");
                                        out.print("<div class='card-body d-flex flex-column'>");           
                                            out.print("<h2 class='card-title text-center'>Nome do Produto: " + dados.getString("p.name") + "</h2>");                                                                   
                                            out.print("<p class='card-text text-center fs-3'>");
                                                out.print("<strong>Preço:</strong> R$" + dados.getString("p.value") + "<br>");                                    
                                                out.print("<strong>Quantidade:</strong>" + dados.getString("o.qtde_product") + "<br>");                                    
                                                out.print("<strong>Inicio do orçamento:</strong> <br>" + dados.getString("o.start_date") + "<br>");
                                                out.print("<strong>Vencimento do orcamento:</strong> <br>" + dados.getString("o.due_date") + "<br>");    
                                            out.print("</p>");
                                            out.print("<div class='d-flex justify-content-center'>");
                                                out.print("<a href='#'class='btn btn-cinza-azulado'>Ver Detalhes</a>");
                                            out.print("</div>");
                                        out.print("</div>");                            
                                        out.print("</div>");
                                        ValueTotalOrcamento += Float.parseFloat(dados.getString("o.value_orcamento"));
                                    }         
                                    out.print("</div>"); 
                                    break;
                            }                            
                            out.print("<div class='mh-25 p-5 d-flex justify-content-center flex-wrap gap-5 flex-fill'>");
                                out.print("<div class=\"mt-5\">");
                                    out.print("<h2>Valor do total dos orcamentos: R$" + String.format("%.02f",ValueTotalOrcamento) + "</h2>");
                                out.print("</div>");
                            out.print("</div>");                                      
                            stm.close();
                            break;            
                        default:                    
                            // response.sendRedirect("./index.jsp");
                            break;
                    }            
                    out.print("</div>");                        
                %>
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
                        <a href="./index-login.jsp" class="text-capitalize no-visual__a menu__a">
                            <li>home</li>
                        </a>
                        <%
                        out.print("<a href='./sobre.jsp?id=" + id + "\' target='_parent' class='menu__a no-visual__a'> <li>sobre nós</li> </a>");
                        %>
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
        <script src="./js/menu.js"></script>
    </body>
</html>