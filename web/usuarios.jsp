<%@page import="java.time.LocalDateTime"%>
<%@page import="java.text.SimpleDateFormat"%>
<%@page import="java.sql.Timestamp"%>
<%@page import="java.util.Date"%>
<%@page import="br.com.fatecpg.poo.pj06.grupo06.db.Usuario"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>

<%
    LocalDateTime now = LocalDateTime.now();
    Timestamp tss = Timestamp.valueOf(now);
    String error = null;
    if(request.getParameter("formDeleteUser")!= null){
     try{
         int id = Integer.parseInt(request.getParameter("id"));
         Usuario.removeUsuario(id);
         response.sendRedirect(request.getRequestURI());
     }
     catch(Exception e){   
        error = e.getMessage();
        }
    }

    if(request.getParameter("formNovoUsuario")!= null){
        String nome = request.getParameter("nome");
        String role = request.getParameter("role");
        String login = request.getParameter("login");
        int senha = request.getParameter("senha").hashCode();      
        String data = request.getParameter("data");
        int pontuacao = Integer.parseInt(request.getParameter("pontuacao"));

      try{
           Usuario.addUsuario(nome, Timestamp.valueOf(data), login, senha, pontuacao, role);
           response.sendRedirect(request.getRequestURI());
           
      }catch(Exception e){
          error = e.getMessage();
      } 
  }
    
  //if(request.getParameter("formUpdateUser")!= null){
      
  //}}
  

%>

<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Usuários</title>
    </head>
    <body>
     <%@include file="WEB-INF/jspf/cabecalho.jspf" %>
     <%if(session.getAttribute("me.login")== null){%>
    <center><h2>Efetue o login.</h2></center> <!-- Corrigir-->
        <%}else if (session.getAttribute("me.role") == "torcedor"){%>
        <center><h2>Você não tem permissão para acessar a página!</h2></center>
        <%}else{%>
        <fieldset>
          
            <div class="panel panel-default">
                <div class="panel-body">
                     <form method="post">          
                            <b>Nome</b><input type="text" name="nome" class="form-control"/> 
                            <b>Senha</b><input type="password" name="senha" class="form-control"/> <br/>
                            <b>Data Cadastro</b><input type="text" name="data" value="<%=tss%>" class="form-control" readonly/> <br/>
                            <b>Login</b><input type="text" name="login" class="form-control"/> <br/>
                            
                           
                            <b>Role</b> <select name="role">
                                <option value="admin">admin</option>
                                <option value="torcedor">torcedor</option>
                            </select>
                             
                            <br/>
                            <b>Pontuação</b><input type="text" name="pontuacao" class="form-control"/> <br/>
                            
                        <button type="submit" name="formNovoUsuario" class="btn btn-warning"/> Cadastrar</button>  
                    </form>
                </div>
            </div>
       
        </fieldset>
       
        <center>
        <table border="1" class="table bordered">            
            <tr>
                <th>ID</th>
                <th>Nome</th>
                <th>Data Cadastro</th>
                <th>Login</th>
                <th>Papel</th>
                <th>Ação</th>
                
            </tr>
            <% for (Usuario u: Usuario.getUsuarios()) {%>
                <tr>   
                    <td><%=u.getId()%></td>
                    <td><%=u.getNome()%></td>
                    <td><%=u.getDataCadastro()%></td>
                    <td><%=u.getLogin()%></td>
                     <td><%=u.getRole()%></td>
                    <td>
                        <form>
                            <input type="hidden" name="id" value="<%=u.getId()%>" />
                            <input type="submit" name="formDeleteUser" value="Remover" />
                            <!--<input type="submit" name="formUpdateUser" value="Alterar" />  -->
                        </form>
                    </td>
                </tr>
            <% } %>
        </table>
        </center>
    </body>
</html>
 <%}%>