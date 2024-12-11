<html>

<body background="unesp.jpg">
    <%@page language="Java" import="java.sql.*" %>    
	<%@page language="Java" import="javax.swing.*" %>
	<%@page language="Java" import="database.BancoSQLGeany"%>
	<%@page language="Java" import="database.RPG_Geany"%>
	<%@page language="Java" import="java.util.Base64" %>

       <%-- comentario em JSP aqui: nossa primeira pagina JSP --%>
       
       <%
       
		String znome = request.getParameter("nome");
		String zmarca = request.getParameter("marca");
		String zcategoria = request.getParameter("categoria");
		String zdescricao = request.getParameter("descricao");
		String nomefoto = request.getParameter("foto");
		String caminhofoto="c://xampp//tomcat//webapps//RPGGeany//fotos//"+nomefoto;
		
		byte[] bytefoto=BancoSQLGeany.imageToByte(caminhofoto);
		
		RPG_Geany rrr = new RPG_Geany();
  	        
  	        rrr.setNome(znome);
			rrr.setMarca(zmarca);
			rrr.setCategoria(zcategoria);
			rrr.setDescricao(zdescricao);
			rrr.setFoto(bytefoto);
		
		
		BancoSQLGeany.conectar();
	   	BancoSQLGeany.adicionar(rrr);
		BancoSQLGeany.desconectar();
      %>


<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
</head>

<form action="RPGgeany.jsp" method="get">

<font color="#000">
<b><n> -- Cadastrar novos  ------------------------------------------------------</n></b>
<br>
<br>
<br>
<font color="#FF0000" style='font-weight:bold;'>
Dados do <% 

                 String saida="";
				 String textoSerializado="";
				 textoSerializado = Base64.getEncoder().encodeToString(bytefoto);
                 saida="data:image/png;base64," + textoSerializado;
			     out.println("|"+znome+"|"+zmarca+"|<br> <br>" );
                 out.println("<figure> <img src='"+saida+"'  width='100' height='100' ' /> </figure> <br>");
 %> adicionado com sucesso! 
 <input 

type="submit" name="teste" value="Continuar Cadastrando >" align="top" /><br>


<br>
<br>

<br>
<br>
</form>

</center>

</body>
</html>
