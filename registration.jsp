<%@page language="java" import="java.sql.*,java.util.*, java.text.*" contentType="text/html" pageEncoding="UTF-8" %>
<%
    // cria as variaveis e armazena as informações digitadas pelo usuario
    String name = new String(request.getParameter("name").getBytes("ISO-8859-1"), "UTF-8");
    String surname = new String(request.getParameter("surname").getBytes("ISO-8859-1"), "UTF-8");
    String full_name = new String(name + " " + surname);
    String cep = request.getParameter("cep");
    String street = request.getParameter("street");
    int number = Integer.parseInt(request.getParameter("number"));
    String district = new String(request.getParameter("district").getBytes("ISO-8859-1"), "UTF-8");
    String city = new String(request.getParameter("city").getBytes("ISO-8859-1"), "UTF-8");
    String cpf = request.getParameter("cpf");
    String phone =  request.getParameter("phone");
    String email = request.getParameter("email");
    String password = new String(request.getParameter("password").getBytes("ISO-8859-1"), "UTF-8");

    // String vnome  = request.getParameter("txtNome");
    // int    vidade = Integer.parseInt( request.getParameter("txtIdade") );
    // String vemail = request.getParameter("txtEmail");

    // variaveis para o banco de dados
    String banco    = "projetointegrador";
    String enderecoBanco = "jdbc:mysql://localhost:3306/" + banco ;
    String usuario  = "root" ;
    String senha    = "" ;

    String driver   = "com.mysql.jdbc.Driver" ;

    //Carregar o driver na memoria
    Class.forName( driver );

    //cria a variavel para conectar com o banco
    Connection conexao ;

    //Abrir a conexao com o banco de dados
    conexao = DriverManager.getConnection(enderecoBanco, usuario, senha) ;

    //Cria a variavel sql com o comando de Inserir
    // String sql = "INSERT INTO alunos (nome,idade,email) values(?,?,?)" ;

    // teste
    String sql = "SELECT email FROM clientes WHERE email = '" + email + "'";

    PreparedStatement stm = conexao.prepareStatement(sql);
    ResultSet dados = stm.executeQuery() ;

    String test_email = "";
    String message = "";
    String button = "";
    String title = "";
    Boolean do_register = false;

    while (dados.next())
    {
        test_email = dados.getString("email");
        if (test_email != "")
        {
            title = "Cadastro inválido";
            message = "Este email já é utilizado no sistema";
            button = "<button class='btn btn-cinza-azulado btn-lg' onclick='window.history.back()'>Voltar ao Cadastro</button>";
            // String script = "<script src='./js/backHistory.js'></script>";
            // out.print(message + button + script);
            do_register = true;
        }
    }

    if (do_register == false)
    {
        //inserindo no banco
        sql = "INSERT INTO clientes (name, phone, email, password, cpf, cep, street, street_number, district, city) values(?,?,?,?,?,?,?,?,?,?)";

        stm = conexao.prepareStatement(sql);
        stm.setString(1, full_name);
        stm.setString(2, phone);
        stm.setString(3, email);
        stm.setString(4, password);
        stm.setString(5, cpf);
        stm.setString(6, cep);
        stm.setString(7, street);
        stm.setInt(8, number);
        stm.setString(9, district);
        stm.setString(10, city);

        stm.execute() ;
        stm.close();
        title = "Dados Salvos com Sucesso";
        message = "Cadastro realizado com sucesso";
        button = "<a class='btn btn-lg btn-cinza-azulado' href='./login.jsp'>Faça o login</a>";
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