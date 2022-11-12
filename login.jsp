<%@page language="java" import="java.sql.*" contentType="text/html; charset=ISO-8859-1" pageEncoding="ISO-8859-1" import="java.util.*"%>


<% 
    // cria as variaveis e armazena as informações digitadas pelo usuario
    String email = request.getParameter("email");
    String password = request.getParameter("password");

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
    String sql = "SELECT email, password, id_client FROM clientes WHERE email = '" + email + "' AND password = '" + password + "'";

    // String sql = "SELECT * FROM clientes"

    PreparedStatement stm = conexao.prepareStatement(sql);

    ResultSet dados = stm.executeQuery() ;
    while (dados.next())
    {
        String id = dados.getString("id_client");

        response.sendRedirect("./index.jsp?id=" + id);
    }    

    stm.close() ;   
    
    // if (dados == null){
    //     out.print(dados);
    // }

  
    //     User user = new User();
    //     user.setEmail("teste@gmail.com");

    // out.print(user.getEmail());

    // while (dados.next()) {
    //     response.sendRedirect("../index.jsp?id=id");
    // }
    // while ( dados.next() ) {
    //     out.print(dados.getString("email"));
    //     out.print(dados.getString("password"));
    // }

%>