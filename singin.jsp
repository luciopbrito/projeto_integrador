<%@page language="java" import="java.sql.*" contentType="text/html" pageEncoding="UTF-8" %>
<%@page import="java.util.*"%>
<%@page import="java.text.*"%>
<% 
    // cria as variaveis e armazena as informações digitadas pelo usuario
    String email = request.getParameter("email");
    String password = request.getParameter("password");
    String redirect = request.getParameter("redirect");
    String type_product = request.getParameter("type");

    if (redirect == null)
    {
        redirect = "";
    }

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
    // String sql = "SELECT email, password, id_client FROM clientes WHERE email = '" + email + "' AND password = '" + password + "'";
    // String sql = "SELECT email, password, id_client FROM clientes WHERE email = '" + email + "' AND password = '" + password + "'";
    // String sql = "SELECT email, password, id_client FROM clientes WHERE email = '" + email + "' AND password = '" + password + "'";
    String sql = "SELECT email FROM clientes WHERE email = '" + email + "'";

    // String sql = "SELECT * FROM clientes"

    PreparedStatement stm = conexao.prepareStatement(sql);

    Boolean hasEmail = false;
    Boolean hasPassword = false;
    String title = "";
    String titleMain = "";
    String btn = "";

    ResultSet dados = stm.executeQuery() ;

    // verificando email
    while (dados.next())
    {
        if (dados.getString("email") != null)
        {
            hasEmail = true;
        }
    }
 
    if (hasEmail == true){
        
        sql = "SELECT password FROM clientes WHERE password = '" + password + "'";
        stm = conexao.prepareStatement(sql);
        dados = stm.executeQuery();

        // verificando senha
        while (dados.next())
        {
            if (dados.getString("password") != null)
            {
                hasPassword = true;
            }
        }

        if (hasEmail == true && hasPassword == true)
        {
            sql = "SELECT email, password, id_client FROM clientes WHERE email = '" + email + "' AND password = '" + password + "'";
            stm = conexao.prepareStatement(sql);
            dados = stm.executeQuery();

            while(dados.next())
            {
                String id = dados.getString("id_client");

                switch(redirect)
                {
                    case "produtos":
                        response.sendRedirect("./produtos-e-servicos.jsp?id=" + id + "&type=" + type_product);
                        break;
                    case "orcamentos":
                        response.sendRedirect("./orcamentos.jsp?id=" + id);
                        break;
                    default:
                        response.sendRedirect("./index.jsp?id=" + id);
                        break;
                }                                
                // response.sendRedirect("./index.jsp?id=" + id + "&teste=" + orcamento);
            }
        }
        else
        {
            title = "Tente Novamente";
            titleMain = "<h1>Email ou Senha estão incorretos</h1>";
            btn = "<button class='btn btn-cinza-azulado' onclick='window.history.back()'>Voltar</button>";
        }
    }  
    else
    {
        title = "Faça um Cadastro";
        titleMain = "<h1>Conta inexistente</h1>";
        btn = "<button class='btn btn-cinza-azulado' onclick='window.history.back()'>Voltar</button>";
    }
    stm.close() ;   
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
        <link rel="stylesheet" href="style.css">
        <title><%out.print(title);%></title>
    </head>
    <body>
        <main class="main">
            <div class="container">
                <div class="d-flex flex-column align-items-center gap-3">
                    <h1>
                        <%
                        out.print(titleMain);
                        %>
                    </h1>
                    <%
                        out.print(btn);
                    %>
                </div>
            </div>
        </main>
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
