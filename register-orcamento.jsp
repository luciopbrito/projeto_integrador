<%@page language="java" import="java.sql.*,java.util.*, java.text.*, java.sql.Date" contentType="text/html" pageEncoding="UTF-8" %>
<%
    Boolean redirect = false;
    String type = request.getParameter("register");
    Integer idClient = Integer.valueOf(request.getParameter("idClient"));
    
    String title = "";
    String message = "";
    String button = "";

    if (type == null || idClient == null)
    {
        redirect = true;
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

    String sql = "";
    //Cria a variavel sql com o comando de Inserir

    PreparedStatement stm;

    ResultSet dados; 

    switch (type)
    {
        case "product":
            // variáveis product            
            Integer id_client_to_back = idClient;

            // Integer type_budget = (request.getParameter("type_budget") == "services") ? 0 : (request.getParameter("type_budget") == "products") ? 1 : null;
            Integer id_product = Integer.valueOf(request.getParameter("product"));
            Integer quantity = Integer.valueOf(request.getParameter("quantity"));
            String description = request.getParameter("description");
            
            String start_dateF = request.getParameter("dateOrcamento");
            String due_dateF = request.getParameter("dateFOrcamento");
            String start_date = start_dateF;
            String due_date = due_dateF;
            
            String cep = request.getParameter("cep");
            String street = request.getParameter("street");
            String street_number = request.getParameter("street_number");
            String district = request.getParameter("district");
            String city = request.getParameter("city");
            
            Float value_orcamento = 0.0F;

            sql = "SELECT value FROM produtos WHERE id_product = '" + id_product + "'";
                    
            stm = conexao.prepareStatement(sql);
        
            dados = stm.executeQuery();

            while (dados.next())
            {
                Float valorProduct = Float.parseFloat(dados.getString("value"));
                value_orcamento = valorProduct * quantity;
            }



            sql = "INSERT INTO orcamentos (id_client, id_product, start_date, due_date, description, cep, street, street_number, district, city, qtde_product, value_orcamento) values(?,?,?,?,?,?,?,?,?,?,?,?)";


            stm = conexao.prepareStatement(sql);
            stm.setInt(1, id_client_to_back);
            stm.setInt(2, id_product);
            stm.setDate(3, java.sql.Date.valueOf(start_date));
            stm.setDate(4, java.sql.Date.valueOf(due_date));
            stm.setString(5, description);
            stm.setString(6, cep);
            stm.setString(7, street);
            stm.setString(8, street_number);
            stm.setString(9, district);
            stm.setString(10, city);
            stm.setInt(11, quantity);
            stm.setFloat(12, value_orcamento);
    
            stm.execute() ;
            stm.close();
            title = "Dados Salvos com Sucesso";
            message = "Cadastro de Orçamento realizado com sucesso";
            button = "<a class='btn btn-lg btn-cinza-azulado' href='./produtos-e-servicos.jsp?id=" + id_client_to_back.toString() + "'>Voltar a Produtos</a>";
            break;
        case "service":
               // variáveis product            
               id_client_to_back = idClient;

               // Integer type_budget = (request.getParameter("type_budget") == "services") ? 0 : (request.getParameter("type_budget") == "products") ? 1 : null;
               Integer id_service = Integer.valueOf(request.getParameter("product"));               
               Integer local = (request.getParameter("selectLocal").equals("corporate")) ? 0 : (request.getParameter("selectLocal").equals("residential")) ? 1 : null;
               Integer type_service = (request.getParameter("type-service").equals("installation")) ? 0 : (request.getParameter("selectLocal").equals("maintenance")) ? 1 : null;
               description = request.getParameter("description");
               
               start_dateF = request.getParameter("dateOrcamento");
               due_dateF = request.getParameter("dateFOrcamento");
               start_date = start_dateF;
               due_date = due_dateF;
               
               cep = request.getParameter("cep");
               street = request.getParameter("street");
               street_number = request.getParameter("street_number");
               district = request.getParameter("district");
               city = request.getParameter("city");
               
               value_orcamento = 0.0F;
   
               sql = "SELECT value FROM servicos WHERE id_service = '" + id_service + "'";
                       
               stm = conexao.prepareStatement(sql);
           
               dados = stm.executeQuery();
   
               while (dados.next())
               {
                   Float valorProduct = Float.parseFloat(dados.getString("value"));
                   value_orcamento = valorProduct;
               }
   
   
   
               sql = "INSERT INTO orcamentos (id_client, id_service, start_date, due_date, description, local, type_service, cep, street, street_number, district, city,value_orcamento) values(?,?,?,?,?,?,?,?,?,?,?,?,?)";
   
   
               stm = conexao.prepareStatement(sql);
               stm.setInt(1, id_client_to_back);
               stm.setInt(2, id_service);
               stm.setDate(3, java.sql.Date.valueOf(start_date));
               stm.setDate(4, java.sql.Date.valueOf(due_date));
               stm.setString(5, description);
               stm.setInt(6, local);
               stm.setInt(7, type_service);
               stm.setString(8, cep);
               stm.setString(9, street);
               stm.setString(10, street_number);
               stm.setString(11, district);
               stm.setString(12, city);
               stm.setFloat(13, value_orcamento);
       
               stm.execute() ;
               stm.close();
               title = "Dados Salvos com Sucesso";
               message = "Cadastro de Orçamento realizado com sucesso";
               button = "<a class='btn btn-lg btn-cinza-azulado' href='./produtos-e-servicos.jsp?id=" + id_client_to_back.toString() + "'>Voltar a Produtos</a>";
            break;
        default:
            redirect = true;
            break;
    }

%>
<!DOCTYPE html>
<html lang="pt-br">

<head>
    <meta charset="UTF-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
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
        <div class="d-flex flex-column align-items-center gap-3">
            <h1><%out.print(message);%></h1>
            <%out.print(button);%>
        </div>
    </main>
    <script src="https://cdn.jsdelivr.net/npm/@popperjs/core@2.11.6/dist/umd/popper.min.js"
        integrity="sha384-oBqDVmMz9ATKxIep9tiCxS/Z9fNfEXiDAYTujMAeBAsjFuCZSmKbSSUnQlmh/jp3"
        crossorigin="anonymous"></script>
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.2.2/dist/js/bootstrap.min.js"
        integrity="sha384-IDwe1+LCz02ROU9k972gdyvl+AESN10+x7tBKgc9I5HFtuNz0wWnPclzo6p9vxnk"
        crossorigin="anonymous"></script>
</body>

</html>
<%
    if (redirect == true)
    {
        response.sendRedirect("./index.jsp");
    }
%>