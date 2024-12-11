<html>
<body>
       <%-- comentário em JSP aqui: nossa primeira página JSP --%>
       <%
         String mensagem = "Bem vindo ao sistema de agenda do Allan";
         String desenvolvido = "Desenvolvido por (Allan Rosalin)";
         out.println(mensagem);
       %> 
        <br />
       <%=desenvolvido         %> 
         <br />
       <%@page import="java.sql.*" %>    
       <%@page import="javax.swing.*" %>
       <%
         JOptionPane.showMessageDialog(null,"voa muleque!!!!");
		  out.println("Tudo foi executado!");
		  %>
         <br> 
         <br>
         <%
         int j=0;
         for(j=0;j<10;j++) out.println("contando="+j+"<br>");
         %>
</body>
</html>
