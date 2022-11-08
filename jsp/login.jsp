<%@page language="java" import="java.sql.*" %>

<%
    // cria as variaveis e armazena as informações digitadas pelo usuario
    String email = request.getParameter("email");
    String password = request.getParameter("password");

    // String vnome  = request.getParameter("txtNome");
    // int    vidade = Integer.parseInt( request.getParameter("txtIdade") );
    // String vemail = request.getParameter("txtEmail");

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
    // String sql = "INSERT INTO alunos (nome,idade,email) values(?,?,?)" ;

    String sql = "SELECT email, password FROM clientes WHERE email = '" + email + "' AND password = '" + password + "'";
    
    // String sql = "SELECT * FROM clientes"

    PreparedStatement stm = conexao.prepareStatement(sql);
    
    // stm.setString(1, vnome);
    // stm.setInt(2, vidade);
    // stm.setString(3, vemail);

    ResultSet dados = stm.executeQuery() ;
    // stm.close() ;
    
    while ( dados.next() ) {
        out.print(dados.getString("email"));
        out.print(dados.getString("password"));
    }
%>