<html>

<%@page language="Java" import="java.sql.*" %>    
<%@page language="Java" import="javax.swing.*" %>
<%@page language="Java" import="database.BancoSQLGeany"%>
<%@page language="Java" import="database.RPG_Geany"%>
<%@page language="Java" import="java.util.*" %>


<body background = "unesp.jpg">
<head>
<link rel = "icon" href = "unesp.png" type = "image/jpg" />
<meta http-equiv = "Content-Type" content = "text/html; charset=utf-8" />
<title>:: Alterar / Excluir::</title>
</head>

<center>
<form action = "RPGgeany.jsp" method = "get">
<font color = "#000">
<b><n> -----------------ALTERA/EXCLUI-----------------------------------------------------</n></b>
<br>
<br>
			<font color = "#FF0000" style = 'font-weight:bold;'>
			<%

   			String zid = request.getParameter("id");
   			String znome= request.getParameter("nome");
			String zmarca = request.getParameter("marca");
			String zcategoria = request.getParameter("categoria");
			String zdescricao = request.getParameter("descricao");
			String znovafoto = request.getParameter("novafoto");
			String caminhofoto = "c://xampp//tomcat//webapps//RPGGeany//fotos//";
			byte[] xfotorig = null;
			
			//JOptionPane.showMessageDialog(null,"foto escolhida"+znovafoto);
			
			BancoSQLGeany.conectar();
	        ArrayList vetor = new ArrayList();
	        vetor = BancoSQLGeany.pegaBanco();
			long lnumero = Long.parseLong(zid);
			
			int jj = vetor.indexOf(lnumero); 
		    System.out.println("posicao do vetor = " +jj);
		    String xid = "" +vetor.get(jj); jj++;
		    String xnom = "" +vetor.get(jj); jj++;
			String xmar = "" +vetor.get(jj); jj++;
			String xcat = "" +vetor.get(jj); jj++;
			String xdesc = "" +vetor.get(jj); jj++;
			xfotorig = (byte [])vetor.get(jj);
			
				
			if(znovafoto.length()!= 0)
			{
			   caminhofoto = caminhofoto + znovafoto;
			   //JOptionPane.showMessageDialog(null,"ok"+nome+"-"+turma+"-"+matricula+"-"+caminhofoto);
			   xfotorig = BancoSQLGeany.imageToByte(caminhofoto);
			}
			
			String altexc = request.getParameter("altexc");
   			//JOptionPane.showMessageDialog(null,""+altexc);
   			RPG_Geany zzz = new RPG_Geany();
  	        zzz.setId(Long.parseLong(zid));
  	        zzz.setNome(znome);
			zzz.setMarca(zmarca);
			zzz.setCategoria(zcategoria);
			zzz.setDescricao(zdescricao);
			zzz.setFoto(xfotorig);

  	 
        	if(altexc.equals("excluir")){
			   //BancoSql.setMat(matricula); nao tem
			 
			   
			   BancoSQLGeany.remove(zzz);
			
			   out.println("\n<h1> Dados " + znome + " Excluidos com sucesso !</h1>");
   			
			}else
			{
			    BancoSQLGeany.altera(zzz);
			    out.println("\n <h1>Dados " + znome + " Alterados com sucesso !</h1>");
			}
      		 BancoSQLGeany.desconectar();
			%>
 <input type = "submit" name = "teste" value = "Continuar Alterando ou Excluindo >" align = "top" /><br>

<br>
<br>

</form>

</center>
</body>
</html>
