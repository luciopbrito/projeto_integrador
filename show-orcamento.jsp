<%@page language="java" import="java.sql.*,java.util.*, java.text.*" contentType="text/html" pageEncoding="UTF-8" %>
<%
    String type = request.getParameter("type");
    String typeService = request.getParameter("typeService");   
    String local = request.getParameter("local");
    String idProduct = request.getParameter("idProduct");
    String idService = request.getParameter("idService");
    Boolean redirect = false;

    if (local == null || local.equals("null") || local.equals(""))
    {
        local = "any";
    }     

    if (typeService == null || typeService.equals("null") || typeService.equals(""))
    {
        typeService = "any";
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
%>
<%
    if (type == null)
    {
        redirect = true;
    }
    else if (type.equals("null"))
    {
        out.print("<div class=\"col-md-2 d-flex flex-column\">");
            out.print("<label for=\"type_budget\">Tipo de Orçamento</label>"); 
            out.print("<select name=\"type_budget\" class=\" h-25 border border-1 border-dark\" id=\"type_budget\">");
                out.print(" <option disabled selected value> selecione </option>");                
                out.print("<option value='products'>produto</option>");                
                out.print("<option value='services'>serviço</option>");      
            out.print("</select>");
        out.print("</div>");
    }
    else if (type.equals("product"))
    {        
        if (idProduct != null)
        {
            String idClient = request.getParameter("idClient");
            out.print("<form action='register-orcamento.jsp?register=product&idClient=" + idClient + "\'" + " method=\'post\'" + ">");
                out.print("<div class=\"row d-flex align-items-end justify-content-between\">");
                    out.print("<div class=\"col-md-auto d-flex flex-column h-25\">"); 
                        out.print("<label for=\"type_budget\">Tipo de Orçamento</label>");  
                        out.print("<select name=\"type_budget\" class=\"border border-1 border-dark\" id=\"type_budget\">");                                
                            // if (type.equals("service"))
                            // {
                            //     out.print("<option selected value='services'>serviço</option>");
                            // }
                            // else
                            // {
                            //     out.print("<option value='services'>serviço</option>");
                            // }
                            out.print("<option disabled selected value='products'>produto</option>");
                            // if (type.equals("product"))
                            // {
                                
                            // }
                            // else
                            // {
                            //     out.print("<option value='products'>produto</option>");
                            // }      
                        out.print("</select>");
                    out.print("</div>");
                    out.print("<div class=\"col-md-auto d-flex flex-column\">");
                        out.print("<label for=\"dateOrcamento\">Data Início do Orçamento</label>");
                        out.print("<input required class=\"border border-1 border-dark\" type=\"date\" name=\"dateOrcamento\">");            
                    out.print("</div>");
                out.print("</div>");

                out.print("<div class=\"row d-flex justify-content-between\">");
                    out.print("<div class=\"col-sm-auto d-flex flex-column\">");   
                        out.print("<label for=\"product\">Produto</label>");
                        out.print("<select class=\"border border-1 border-dark\" name=\"product\" id=\"product\">");
                            
                        sql = "SELECT id_product id, name FROM produtos";
                        stm = conexao.prepareStatement(sql);
                        dados = stm.executeQuery(); 
                        
                        while (dados.next() != false)
                        {                            
                            if (Integer.valueOf(dados.getString("id")) == Integer.valueOf(idProduct))
                            {                                
                                out.print("<option selected value='" + dados.getString("id") + "'>" + dados.getString("name") + "</option>");                                
                            }
                            else if (Integer.valueOf(dados.getString("id")) != Integer.valueOf(idProduct))
                            {
                                out.print("<option value='" + dados.getString("id") + "'>" + dados.getString("name") + "</option>");
                            }
                            else
                            {
                                out.print("<option value='null'>Não Existe Nenhum Produto</option>");
                            }
                        }                
                        out.print("</select>");            
                    out.print("</div>");
                    out.print("<div class=\"col-md-auto d-flex flex-column\">");
                        out.print("<label for=\"dateFOrcamento\">Data Final do Orçamento</label>");
                        out.print("<input required class=\"border border-1 border-dark\" type=\"date\" name=\"dateFOrcamento\">");            
                    out.print("</div>");  
                out.print("</div>");    
                out.print("<div class=\"row d-flex justify-content-between mb-3\">");
                        out.print("<div class=\"col-md-auto d-flex flex-column\">");   
                            out.print("<label for=\"quantity\">Quatidade</label>");
                            out.print("<input required class=\"border border-1 border-dark\" type=\"number\" name=\"quantity\">");            
                        out.print("</div>");
                    out.print("</div>");
                    
                    out.print("<div class=\"row d-flex justify-content-between mb-3\">");
                        out.print("<div class=\"col-sm-7 d-flex flex-column\">");   
                            out.print("<label for=\"description\">Descrição</label>");
                            out.print("<textarea class=\"border border-1 border-dark\" name=\"description\" id=\"description\" cols=\"30\" rows=\"10\" maxlength=\"200\"></textarea>");  
                        out.print("</div>");
                    out.print("</div>");
                out.print("</div>");               

                sql = "SELECT * FROM clientes WHERE id_client = '" + idClient + "'";
                stm = conexao.prepareStatement(sql);
                dados = stm.executeQuery();

                out.print("<div class=\"row d-flex justify-content-between mb-3\">");
                    out.print("<div class='container d-flex flex-column gap-2 mb-3'>");
                        out.print("<div class='row'>");
                            out.print("<h2 class='fw-bold col'>Endereço</h2>");
                        out.print("</div>");
                        while (dados.next())
                        {
                            out.print("<div class='container d-flex flex-column gap-5'>");
                                out.print("<div class='row'>");
                                    out.print("<div class='col-sm-4 d-flex flex-column ps-0'>");
                                        out.print("<label>CEP:</label>");
                                        out.print("<input class='border border-1 border-dark p-2' type='text' name='cep' value='" + dados.getString("cep") + "'/>");
                                    out.print("</div>");
                                    out.print("<div class='col-sm-4 d-flex flex-column'>");
                                        out.print("<label>RUA:</label>");
                                        out.print("<input class='border border-1 border-dark p-2' type='text' name='street' value='" + dados.getString("street") + "'/>");
                                    out.print("</div>");
                                    out.print("<div class='col-sm-1 d-flex flex-column'>");
                                        out.print("<label>Nª:</label>");
                                        out.print("<input class='border border-1 border-dark p-2' type='text' name='street_number' value='" + dados.getString("street_number") + "'/>");
                                    out.print("</div>");
                                out.print("</div>");
                                out.print("<div class='row'>");
                                    out.print("<div class='col-sm-4 d-flex flex-column ps-0'>");
                                        out.print("<label>BAIRRO:</label>");
                                        out.print("<input class='border border-1 border-dark p-2' type='text' name='district' value='" + dados.getString("district") + "'/>");
                                    out.print("</div>");
                                    out.print("<div class='col-sm-4 d-flex flex-column'>");
                                        out.print("<label>CIDADE:</label>");
                                        out.print("<input class='border border-1 border-dark p-2' type='text' name='city' value='" + dados.getString("city") + "'/>");
                                    out.print("</div>");
                                out.print("</div>");
                            out.print("</div>");
                        }
                        out.print("<input class=\"btn btn-lg btn-cinza-azulado mt-3\" type=\"submit\" value=\"Enviar\">");
                    out.print("</div>");
                out.print("</div>");
            out.print("</form>"); 
        }
        else if (idProduct.equals("null") || idProduct.equals(""))
        {
            String idClient = request.getParameter("idClient");
            out.print("<form action='register-orcamento.jsp?register=product&idClient=" + idClient + "\'" + " method=\'post\'" + ">");
                out.print("<div class=\"row d-flex align-items-end justify-content-between\">");
                    out.print("<div class=\"col-md-auto d-flex flex-column h-25\">"); 
                        out.print("<label for=\"type_budget\">Tipo de Orçamento</label>");  
                        out.print("<select name=\"type_budget\" class=\"border border-1 border-dark\" id=\"type_budget\">");                                
                            if (type.equals("service"))
                            {
                                out.print("<option selected value='services'>serviço</option>");
                            }
                            else
                            {
                                out.print("<option value='services'>serviço</option>");
                            }

                            if (type.equals("product"))
                            {
                                out.print("<option selected value='products'>produto</option>");
                            }
                            else
                            {
                                out.print("<option value='products'>produto</option>");
                            }      
                        out.print("</select>");
                    out.print("</div>");
                    out.print("<div class=\"col-md-auto d-flex flex-column\">");
                        out.print("<label for=\"dateOrcamento\">Data Início do Orçamento</label>");
                        out.print("<input required class=\"border border-1 border-dark\" type=\"date\" name=\"dateOrcamento\">");            
                    out.print("</div>");
                out.print("</div>");

                out.print("<div class=\"row d-flex justify-content-between\">");
                    out.print("<div class=\"col-sm-auto d-flex flex-column\">");   
                        out.print("<label for=\"product\">Produto</label>");
                        out.print("<select class=\"border border-1 border-dark\" name=\"product\" id=\"product\">");
                            
                        sql = "SELECT id_product id, name FROM produtos";
                        stm = conexao.prepareStatement(sql);
                        dados = stm.executeQuery(); 

                        while (dados.next())
                        {
                            if (dados.getString("name") != null)
                            {
                                out.print("<option value='" + dados.getString("id") + "'>" + dados.getString("name") + "</option>");
                            }
                            else
                            {
                                out.print("<option value='null'>Não Existe Nenhum Produto</option>");
                            }
                        }                
                        out.print("</select>");            
                    out.print("</div>");
                    out.print("<div class=\"col-md-auto d-flex flex-column\">");
                        out.print("<label for=\"dateFOrcamento\">Data Final do Orçamento</label>");
                        out.print("<input required class=\"border border-1 border-dark\" type=\"date\" name=\"dateFOrcamento\">");            
                    out.print("</div>");  
                out.print("</div>");    
                out.print("<div class=\"row d-flex justify-content-between mb-3\">");
                        out.print("<div class=\"col-md-auto d-flex flex-column\">");   
                            out.print("<label for=\"quantity\">Quatidade</label>");
                            out.print("<input required class=\"border border-1 border-dark\" type=\"number\" name=\"quantity\">");            
                        out.print("</div>");
                    out.print("</div>");
                    
                    out.print("<div class=\"row d-flex justify-content-between mb-3\">");
                        out.print("<div class=\"col-sm-7 d-flex flex-column\">");   
                            out.print("<label for=\"description\">Descrição</label>");
                            out.print("<textarea class=\"border border-1 border-dark\" name=\"description\" id=\"description\" cols=\"30\" rows=\"10\" maxlength=\"200\"></textarea>");  
                        out.print("</div>");
                    out.print("</div>");
                out.print("</div>");               

                sql = "SELECT * FROM clientes WHERE id_client = '" + idClient + "'";
                stm = conexao.prepareStatement(sql);
                dados = stm.executeQuery();

                out.print("<div class=\"row d-flex justify-content-between mb-3\">");
                    out.print("<div class='container d-flex flex-column gap-2 mb-3'>");
                        out.print("<div class='row'>");
                            out.print("<h2 class='fw-bold col'>Endereço</h2>");
                        out.print("</div>");
                        while (dados.next())
                        {
                            out.print("<div class='container d-flex flex-column gap-5'>");
                                out.print("<div class='row'>");
                                    out.print("<div class='col-sm-4 d-flex flex-column ps-0'>");
                                        out.print("<label>CEP:</label>");
                                        out.print("<input class='border border-1 border-dark p-2' type='text' name='cep' value='" + dados.getString("cep") + "'/>");
                                    out.print("</div>");
                                    out.print("<div class='col-sm-4 d-flex flex-column'>");
                                        out.print("<label>RUA:</label>");
                                        out.print("<input class='border border-1 border-dark p-2' type='text' name='street' value='" + dados.getString("street") + "'/>");
                                    out.print("</div>");
                                    out.print("<div class='col-sm-1 d-flex flex-column'>");
                                        out.print("<label>Nª:</label>");
                                        out.print("<input class='border border-1 border-dark p-2' type='text' name='street_number' value='" + dados.getString("street_number") + "'/>");
                                    out.print("</div>");
                                out.print("</div>");
                                out.print("<div class='row'>");
                                    out.print("<div class='col-sm-4 d-flex flex-column ps-0'>");
                                        out.print("<label>BAIRRO:</label>");
                                        out.print("<input class='border border-1 border-dark p-2' type='text' name='district' value='" + dados.getString("district") + "'/>");
                                    out.print("</div>");
                                    out.print("<div class='col-sm-4 d-flex flex-column'>");
                                        out.print("<label>CIDADE:</label>");
                                        out.print("<input class='border border-1 border-dark p-2' type='text' name='city' value='" + dados.getString("city") + "'/>");
                                    out.print("</div>");
                                out.print("</div>");
                            out.print("</div>");
                        }
                        out.print("<input class=\"btn btn-lg btn-cinza-azulado mt-3\" type=\"submit\" value=\"Enviar\">");
                    out.print("</div>");
                out.print("</div>");
            out.print("</form>"); 
        }           
    }
    else if (type.equals("service"))
    {
        if (idService != null)
        {
            String idClient = request.getParameter("idClient");
            out.print("<form action='register-orcamento.jsp?register=service&idClient="+ idClient + "\'" + " method='post'" + ">");
                out.print("<div class=\"row d-flex align-items-end justify-content-between\">");
                    out.print("<div class=\"col-md-auto d-flex flex-column h-25\">");   
                        out.print("<label for=\"type_budget\">Tipo de Orçamento</label>");  
                        out.print("<select name=\"type_budget\" class=\"border border-1 border-dark\" id=\"type_budget\">");                    
                            out.print("<option disabled selected value='services'>serviço</option>");
                                // if (type.equals("service"))
                                // {
                                  
                                // }
                                // else
                                // {
                                //     out.print("<option value='services'>serviço</option>");
                                // }
                                
                                // if (type.equals("product"))
                                // {
                                //     out.print("<option selected value='products'>produto</option>");
                                // }
                                // else
                                // {
                                //     out.print("<option value='products'>produto</option>");
                                // }            
                            out.print("</select>");                
                    out.print("</div>");
                    out.print("<div class=\"col-md-auto d-flex flex-column\">");   
                        out.print("<label for=\"dateOrcamento\">Data Início do Orçamento</label>");
                        out.print("<input required class=\"border border-1 border-dark\" type=\"date\" name=\"dateOrcamento\">");              
                    out.print("</div>");
                out.print("</div>");    
                out.print("<div class=\"row d-flex justify-content-between\">");
                    out.print("<div class=\"col-md-auto d-flex flex-column\">");   
                        out.print("<label for=\"selectLocal\">Local</label>");      
                        out.print("<select name=\"selectLocal\" class=\"border border-1 border-dark h-100\">");                       
                                        
                            if (local.equals("corporate"))
                            {
                                out.print("<option selected value='corporate'>corporativo</option>");
                            }
                            else
                            {
                                out.print("<option value='corporate'>corporativo</option>");
                            }

                            if (local.equals("residential"))
                            {
                                out.print("<option selected value='residential'>residencial</option>");
                            }
                            else
                            {
                                out.print("<option value='residential'>residencial</option>");
                            }   

                                        
                            if (local.equals("any"))
                            {
                                out.print(" <option disabled selected value> selecione </option>");  
                            }
                            // else
                            // {
                            //     out.print("<option value='null'>selecione</option>");
                            // }                   
                            out.print("</select>");          
                    out.print("</div>");
                    out.print("<div class=\"col-md-auto d-flex flex-column\">");   
                        out.print("<label for=\"dateFOrcamento\">Data Final do Orçamento</label>");
                        out.print("<input required class=\"border border-1 border-dark\" type=\"date\" name=\"dateFOrcamento\">");              
                    out.print("</div>");            
                out.print("</div>");
                out.print("<div class=\"row d-flex justify-content-between\">");            
                    out.print("<div class=\"col-md-auto d-flex flex-column\">");   
                        out.print("<label for=\"\">Tipo de Serviço</label>");
                        out.print("<select name=\"type-service\" class=\"border border-1 border-dark\">");
                                
                            if (typeService.equals("installation"))
                            {
                                out.print("<option selected value='installation'>instalação</option>");
                            }
                            else
                            {
                                out.print("<option value='installation'>instalação</option>");
                            }

                            if (typeService.equals("maintenance"))
                            {
                                out.print("<option selected value='maintenance'>manutenção</option>");
                            }
                            else
                            {
                                out.print("<option value='maintenance'>manutenção</option>");
                            }   

                                        
                            if (typeService.equals("any"))
                            {
                                out.print("<option disabled selected value> selecione </option>");  
                            }
                            // else
                            // {
                            //     out.print("<option value='null'>selecione</option>");
                            // } 
                        out.print("</select>");                
                    out.print("</div>");

                    out.print("<div class=\"col-md-auto d-flex flex-column\">");   
                        out.print("<label for=\"product\">Serviço</label>");
                        out.print("<select class=\"border border-1 border-dark\" name=\"product\" id=\"product\">");

                        sql = "SELECT id_service id, name FROM servicos";
                        stm = conexao.prepareStatement(sql);
                        dados = stm.executeQuery(); 

                        while (dados.next() != false)
                        {
                            if (Integer.valueOf(dados.getString("id")) == Integer.valueOf(idService))
                            {                                
                                out.print("<option selected value='" + dados.getString("id") + "'>" + dados.getString("name") + "</option>");
                            }
                            else if (Integer.valueOf(dados.getString("id")) != Integer.valueOf(idService))
                            {
                                out.print("<option value='" + dados.getString("id") + "'>" + dados.getString("name") + "</option>");
                            }
                            else
                            {
                                out.print("<option value='null'>Não Existe Nenhum Serviço</option>");
                            }
                        }           
                        out.print("</select>");               
                    out.print("</div>");
                out.print("</div>");
                out.print("<div class=\"row d-flex justify-content-between mb-3\">");
                    out.print("<div class=\"col-sm-7 d-flex flex-column\">");   
                        out.print("<label for=\"description\">Descrição</label>");
                        out.print("<textarea class=\"border border-1 border-dark\" name=\"description\" id=\"description\" cols=\"30\" rows=\"10\" maxlength=\"200\"></textarea>");           
                    out.print("</div>");
                out.print("</div>");        
                
                sql = "SELECT * FROM clientes WHERE id_client = '" + idClient + "'";
                stm = conexao.prepareStatement(sql);
                dados = stm.executeQuery();
                

                out.print("<div class=\"row d-flex justify-content-between\">");
                    out.print("<div class='container d-flex flex-column gap-2 mb-3'>");
                        out.print("<div class='row'>");
                            out.print("<h2 class='fw-bold col'>Endereço</h2>");
                        out.print("</div>");
                        while (dados.next())
                        {
                            out.print("<div class='container d-flex flex-column gap-5'>");
                                out.print("<div class='row'>");
                                    out.print("<div class='col-sm-4 d-flex flex-column ps-0'>");
                                        out.print("<label>CEP:</label>");
                                        out.print("<input class='border border-1 border-dark p-2' type='text' name='cep' value='" + dados.getString("cep") + "'/>");
                                    out.print("</div>");
                                    out.print("<div class='col-sm-4 d-flex flex-column'>");
                                        out.print("<label>RUA:</label>");
                                        out.print("<input class='border border-1 border-dark p-2' type='text' name='street' value='" + dados.getString("street") + "'/>");
                                    out.print("</div>");
                                    out.print("<div class='col-sm-1 d-flex flex-column'>");
                                        out.print("<label>Nª:</label>");
                                        out.print("<input class='border border-1 border-dark p-2' type='text' name='street_number' value='" + dados.getString("street_number") + "'/>");
                                    out.print("</div>");
                                out.print("</div>");
                                out.print("<div class='row'>");
                                    out.print("<div class='col-sm-4 d-flex flex-column ps-0'>");
                                        out.print("<label>BAIRRO:</label>");
                                        out.print("<input class='border border-1 border-dark p-2' type='text' name='district' value='" + dados.getString("district") + "'/>");
                                    out.print("</div>");
                                    out.print("<div class='col-sm-4 d-flex flex-column'>");
                                        out.print("<label>CIDADE:</label>");
                                        out.print("<input class='border border-1 border-dark p-2' type='text' name='city' value='" + dados.getString("city") + "'/>");
                                    out.print("</div>");
                                out.print("</div>");
                            out.print("</div>");
                        }
                        out.print("<input class=\"btn btn-lg btn-cinza-azulado mt-3\" type=\"submit\" value=\"Enviar\">");
                    out.print("</div>");
                out.print("</div>");        
            out.print("</form>");
        }
        else if (idService.equals("null") || idService.equals(""))
        {
            String idClient = request.getParameter("idClient");
            out.print("<form action='register-orcamento.jsp?register=service&idClient="+ idClient + "\'" + " method='post'" + ">");
                out.print("<div class=\"row d-flex align-items-end justify-content-between\">");
                    out.print("<div class=\"col-md-auto d-flex flex-column h-25\">");   
                        out.print("<label for=\"type_budget\">Tipo de Orçamento</label>");  
                        out.print("<select name=\"type_budget\" class=\"border border-1 border-dark\" id=\"type_budget\">");                    
        
                                if (type.equals("service"))
                                {
                                    out.print("<option selected value='services'>serviço</option>");
                                }
                                else
                                {
                                    out.print("<option value='services'>serviço</option>");
                                }
                                
                                if (type.equals("product"))
                                {
                                    out.print("<option selected value='products'>produto</option>");
                                }
                                else
                                {
                                    out.print("<option value='products'>produto</option>");
                                }            
                            out.print("</select>");                
                    out.print("</div>");
                    out.print("<div class=\"col-md-auto d-flex flex-column\">");   
                        out.print("<label for=\"dateOrcamento\">Data Início do Orçamento</label>");
                        out.print("<input required class=\"border border-1 border-dark\" type=\"date\" name=\"dateOrcamento\">");              
                    out.print("</div>");
                out.print("</div>");    
                out.print("<div class=\"row d-flex justify-content-between\">");
                    out.print("<div class=\"col-md-auto d-flex flex-column\">");   
                        out.print("<label for=\"selectLocal\">Local</label>");      
                        out.print("<select name=\"selectLocal\" class=\"border border-1 border-dark h-100\">");                       
                                        
                            if (local.equals("corporate"))
                            {
                                out.print("<option selected value='0'>corporativo</option>");
                            }
                            else
                            {
                                out.print("<option value='0'>corporativo</option>");
                            }

                            if (local.equals("residential"))
                            {
                                out.print("<option selected value='1'>residencial</option>");
                            }
                            else
                            {
                                out.print("<option value='1'>residencial</option>");
                            }   

                                        
                            if (local.equals("any"))
                            {
                                out.print(" <option disabled selected value> selecione </option>");  
                            }
                            // else
                            // {
                            //     out.print("<option value='null'>selecione</option>");
                            // }                   
                            out.print("</select>");          
                    out.print("</div>");
                    out.print("<div class=\"col-md-auto d-flex flex-column\">");   
                        out.print("<label for=\"dateFOrcamento\">Data Final do Orçamento</label>");
                        out.print("<input required class=\"border border-1 border-dark\" type=\"date\" name=\"dateFOrcamento\">");              
                    out.print("</div>");            
                out.print("</div>");
                out.print("<div class=\"row d-flex justify-content-between\">");            
                    out.print("<div class=\"col-md-auto d-flex flex-column\">");   
                        out.print("<label for=\"\">Tipo de Serviço</label>");
                        out.print("<select name=\"type-service\" class=\"border border-1 border-dark\">");
                                
                            if (typeService.equals("installation"))
                            {
                                out.print("<option selected value='0'>instalação</option>");
                            }
                            else
                            {
                                out.print("<option value='0'>instalação</option>");
                            }

                            if (typeService.equals("maintenance"))
                            {
                                out.print("<option selected value='1'>manutenção</option>");
                            }
                            else
                            {
                                out.print("<option value='1'>manutenção</option>");
                            }   

                                        
                            if (typeService.equals("any"))
                            {
                                out.print("<option disabled selected value> selecione </option>");  
                            }
                            // else
                            // {
                            //     out.print("<option value='null'>selecione</option>");
                            // } 
                        out.print("</select>");                
                    out.print("</div>");

                    out.print("<div class=\"col-md-auto d-flex flex-column\">");   
                        out.print("<label for=\"product\">Serviço</label>");
                        out.print("<select class=\"border border-1 border-dark\" name=\"products\" id=\"product\">");

                        sql = "SELECT id_service id, name FROM servicos";
                        stm = conexao.prepareStatement(sql);
                        dados = stm.executeQuery(); 

                        while (dados.next())
                        {
                            if (dados.getString("name") != null)
                            {
                                out.print("<option value='" + dados.getString("id") + "'>" + dados.getString("name") + "</option>");
                            }
                            else
                            {
                                out.print("<option value='null'>Não Existe Nenhum Serviço</option>");
                            }
                        }
                        out.print("</select>");               
                    out.print("</div>");
                out.print("</div>");
                out.print("<div class=\"row d-flex justify-content-between mb-3\">");
                    out.print("<div class=\"col-sm-7 d-flex flex-column\">");   
                        out.print("<label for=\"description\">Descrição</label>");
                        out.print("<textarea class=\"border border-1 border-dark\" name=\"description\" id=\"description\" cols=\"30\" rows=\"10\" maxlength=\"200\"></textarea>");           
                    out.print("</div>");
                out.print("</div>");        
                
                sql = "SELECT * FROM clientes WHERE id_client = '" + idClient + "'";
                stm = conexao.prepareStatement(sql);
                dados = stm.executeQuery();
                

                out.print("<div class=\"row d-flex justify-content-between\">");
                    out.print("<div class='container d-flex flex-column gap-2 mb-3'>");
                        out.print("<div class='row'>");
                            out.print("<h2 class='fw-bold col'>Endereço</h2>");
                        out.print("</div>");
                        while (dados.next())
                        {
                            out.print("<div class='container d-flex flex-column gap-5'>");
                                out.print("<div class='row'>");
                                    out.print("<div class='col-sm-4 d-flex flex-column ps-0'>");
                                        out.print("<label>CEP:</label>");
                                        out.print("<input class='border border-1 border-dark p-2' type='text' name='cep' value='" + dados.getString("cep") + "'/>");
                                    out.print("</div>");
                                    out.print("<div class='col-sm-4 d-flex flex-column'>");
                                        out.print("<label>RUA:</label>");
                                        out.print("<input class='border border-1 border-dark p-2' type='text' name='street' value='" + dados.getString("street") + "'/>");
                                    out.print("</div>");
                                    out.print("<div class='col-sm-1 d-flex flex-column'>");
                                        out.print("<label>Nª:</label>");
                                        out.print("<input class='border border-1 border-dark p-2' type='text' name='street_number' value='" + dados.getString("street_number") + "'/>");
                                    out.print("</div>");
                                out.print("</div>");
                                out.print("<div class='row'>");
                                    out.print("<div class='col-sm-4 d-flex flex-column ps-0'>");
                                        out.print("<label>BAIRRO:</label>");
                                        out.print("<input class='border border-1 border-dark p-2' type='text' name='district' value='" + dados.getString("district") + "'/>");
                                    out.print("</div>");
                                    out.print("<div class='col-sm-4 d-flex flex-column'>");
                                        out.print("<label>CIDADE:</label>");
                                        out.print("<input class='border border-1 border-dark p-2' type='text' name='city' value='" + dados.getString("city") + "'/>");
                                    out.print("</div>");
                                out.print("</div>");
                            out.print("</div>");
                        }
                        out.print("<input class=\"btn btn-lg btn-cinza-azulado mt-3\" type=\"submit\" value=\"Enviar\">");
                    out.print("</div>");
                out.print("</div>");        
            out.print("</form>");
        }
        
    }
%>  
<%
if (redirect == true)
{
    response.sendRedirect("./index.jsp");
}    
%>