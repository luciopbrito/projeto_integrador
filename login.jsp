<%@page language="java" import="java.sql.*,java.util.*, java.text.*" contentType="text/html" pageEncoding="UTF-8" %>
<%
    String redirect = request.getParameter("redirect");
    if (redirect == null)
    {
        redirect = "";
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
    <main class="main">
        <div class="container-forms">
            <div class="logo">
                <img src="assets/imgs/logo-to-login.png" alt="logo">
            </div>
            <div class="form__login">
                <div>
                    <img src="assets/imgs/logo-to-login.png" alt="logo">
                </div>
                <h1 class="form-login__title">Login</h1>
                <%                
                    switch(redirect)
                    {                
                        case "produtos":
                            out.print("<form action='./singin.jsp?redirect=produtos&type=all' method='post'>");
                            break;
                        case "orcamentos":
                            out.print("<form action='./singin.jsp?redirect=orcamentos' method='post'>");
                            break;
                        default:
                            out.print("<form action='./singin.jsp' method='post'>");
                            break;
                    }
                %>
                    <div class="form-login__field">
                        <label for="email">email</label>
                        <input type="email" name="email" class="form-login__input" required>
                    </div>
                    <div class="form-login__field">
                        <label for="password">senha</label>
                        <input type="password" name="password" class="form-login__input password" required>
                        <button type="button" class="m-0 showpassword">mostra senha</button>
                    </div>
                    <input type="submit" value="login" class="text-capitalize form-login__submit btn btn-lg btn-cinza-azulado">
                    <p class="form-login__cadastro">cadastre-se</p>
                </form>
            </div>
            <div class="form__registration disable">
                <form action="./registration.jsp" method="post">
                    <div class="form_logo">
                        <img src="assets/imgs/logo-to-login.png" alt="logo">
                    </div>                   
                    <h1>Cadastro</h1>
                    <div class="form-login__field">
                        <label for="name">nome</label>
                        <input type="text" name="name" class="form-login__input" required>
                    </div>
                    <div class="form-login__field">
                        <label for="surname">sobrenome</label>
                        <input type="text" name="surname" class="form-login__input" required>
                    </div>
                    <div class="form-login__field">
                        <label class="text-uppercase" for="cpf">cpf</label>
                        <input type="text" name="cpf" class="form-login__input" required maxlength="11">
                    </div>
                    <div class="form-login__field">
                        <label for="phone">telefone</label>
                        <input type="text" name="phone" class="form-login__input" maxlength="14">
                    </div>
                    <div class="form-login__field">
                        <label class="text-uppercase" for="cep">cep</label>
                        <input type="text" name="cep" class="form-login__input" required maxlength="8">
                    </div>
                    <div class="form-login__field">
                        <label for="street">rua</label>
                        <input type="text" name="street" class="form-login__input" required>
                    </div>
                    <div class="form-login__field">
                        <label for="number">número</label>
                        <input type="text" name="number" class="form-login__input" required>
                    </div>
                    <div class="form-login__field">
                        <label for="district">bairro</label>
                        <input type="text" name="district" class="form-login__input" required>
                    </div>
                    <div class="form-login__field">
                        <label for="name">email</label>
                        <input type="email" name="email" class="form-login__input" required>
                    </div>
                    <div class="form-login__field">
                        <label for="city">cidade</label>
                        <input type="text" name="city" class="form-login__input" required>
                    </div>
                    <div class="form-login__field">
                        <label for="password">senha</label>
                        <input type="password" name="password" class="form-login__input password" required>
                        <button type="button" class="m-0 showpassword">mostra senha</button>
                    </div>
                    <div class="form-login__field">
                        <label for="confirmPassword">confirma senha</label>
                        <input type="password" name="confirmPassword" class="form-login__input password" required>
                        <button type="button" class="m-0 showpassword">mostra senha</button>
                    </div>
                    <div class="form-registration__btns">
                        <input type="submit" value="salvar" class="text-capitalize btn btn-lg btn-cinza-azulado">
                        <input type="button" value="cancelar" class="text-capitalize btn__exit btn btn-lg btn-cinza-azulado">
                    </div>
                </form>
            </div>
        </div>
    </main>
    <script src="https://cdn.jsdelivr.net/npm/@popperjs/core@2.11.6/dist/umd/popper.min.js"
        integrity="sha384-oBqDVmMz9ATKxIep9tiCxS/Z9fNfEXiDAYTujMAeBAsjFuCZSmKbSSUnQlmh/jp3"
        crossorigin="anonymous"></script>
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.2.2/dist/js/bootstrap.min.js"
        integrity="sha384-IDwe1+LCz02ROU9k972gdyvl+AESN10+x7tBKgc9I5HFtuNz0wWnPclzo6p9vxnk"
        crossorigin="anonymous"></script>
    <script src="js/form-registration.js"></script>
    <script src="js/show-password.js"></script>
    <script src="js/only-numbers.js"></script>
</body>

</html>