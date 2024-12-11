
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Strict//EN"
	"http://www.w3.org/TR/xhtml1/DTD/xhtml1-strict.dtd">
<html>

<%@page language="Java" import="java.sql.*" %>    
<%@page language="Java" import="javax.swing.*" %>
<%@page language="Java" import="database.BancoSQLGeany"%>
<%@page language="Java" import="database.RPG_Geany"%>
<%@page language="Java" import="java.util.*" %>
<%@page language="Java" import="java.util.Base64" %>

<head>
	<title>CADASTRO DE RPG</title>
	<meta http-equiv="content-type" content="text/html;charset=utf-8" />
	<meta name="generator" content="Geany 1.38" />
</head>

<body>
	
	 <h1> CRUD JSP Allan Rosalin 73C Numero: 01</h1>
	 <h3> RPGs Cadastrados no Banco SQL</h3>
	 <table border="1">
	   <tr>
		    <td>Id</td>
			<td>Nome</td>
			<td>Marca</td>
			<td>Descricao</td>
			<td>Categoria</td>
			<td>Foto</td>
		   
	   </tr>
	
	 
	 <%
	    try
	    {
			
        BancoSQLGeany.conectar();
	    ArrayList vetor=new ArrayList();
	    
        vetor=BancoSQLGeany.pegaBanco();
        
        String id_rpg, nomerpg, marcarpg, categoriarpg, descricaorpg, saida;
    	String textoSerializado;
    		
    	byte[] fotorpg;
    		
    	if(!vetor.isEmpty())
        for(int j=0;j<vetor.size(); j++)
        {
			id_rpg=""+vetor.get(j); j++;
			nomerpg=""+vetor.get(j); j++;
			marcarpg=""+vetor.get(j); j++;
			categoriarpg=""+vetor.get(j); j++;
			descricaorpg=""+vetor.get(j); j++;
			fotorpg=(byte [])vetor.get(j);
			saida="";
			textoSerializado="";
			if(fotorpg!=null)
				 {
                   textoSerializado = Base64.getEncoder().encodeToString(fotorpg);
                   //System.out.println("Texto em Base64: " + textoSerializado);
				 }
           saida="data:image/png;base64," + textoSerializado;
		%>
			
			<tr>
			 <td><%=id_rpg %> </td>
			 <td><%=nomerpg %> </td>
			 <td><%=marcarpg %> </td>
			 <td><%=categoriarpg %> </td>
			 <td><%=descricaorpg %> </td>
			 <td><%out.println("<figure> <img src='"+saida+"' alt='"+nomerpg+" width='40' height='40' ' /> </figure> <br>");%> </td>
			 <td><%out.println("<a href='editar.jsp?id="+id_rpg+"' >Link para editar </a>");%>  </td>
			</tr>
			<%
		    
			
		 }//for
		else
           out.println("<br>Banco de dados vazio!!!!!");	
           
        BancoSQLGeany.desconectar();
      }    /////try
        catch(Exception e)
    	{
    		out.println("ERRO WEB ="+ e);
    		
    	}//catch
	 %>
	  </table>
	  <table border="2">
	  <tr>
	   <td>
	  <a href="adiciona.html">Novo registro </a>
	  </td>
	  <td>
	  <a href="index.html"> Inicio trabalho </a>
	  </td>
	  <td>
	  <a href="reljrxml.jsp"> Relatório </a>
	  </td>
	  
	  
	  </tr>
	  </table>
</body>

</html>
