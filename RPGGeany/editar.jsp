<html>
<%@page language="Java" import="java.sql.*" %>    
<%@page language="Java" import="javax.swing.*" %>
<%@page language="Java" import="database.BancoSQLGeany"%>
<%@page language="Java" import="java.util.*" %>


<script>
function extractFilename(path) {
  if (path.substr(0, 19) == "C:\\xampp\\tomcat\\")
    return path.substr(19); // modern browser
  
  //if (path.substr(0, 26) == "C:\\apache-tomcat-6.0.29\\")
  //  return path.substr(26); // modern browser
  var x;
  x = path.lastIndexOf('/');
  if (x >= 0) // Unix-based path
    return path.substr(x+1);
  x = path.lastIndexOf('\\');
  if (x >= 0) // Windows-based path
    return path.substr(x+1);
  return path; // just the file name
}
</script>

<body background="">
       <%
        String xid="",xnom="",xmar="",xcat="",xdesc="";
   
      
        byte[] xfoto;
		
        String numero=request.getParameter("id");
        long lnumero=Long.parseLong(numero);
        String saida = "", textoSerializado = "";
        
	try
    	{
					
		BancoSQLGeany.conectar();
	    ArrayList vetor = new ArrayList();
	    vetor = BancoSQLGeany.pegaBanco();
     
        xfoto = null;
        saida = "";
		//JOptionPane.showMessageDialog(null,"VETOR tamanho="+vetor.size());
        if(!vetor.isEmpty())
		{
		    
		   if(vetor.contains(lnumero))
		   {
			 //JOptionPane.showMessageDialog(null,"VETOR tem="+lnumero);
			 System.out.println("achou no vetor id = " +xid);
		     int jj = vetor.indexOf(lnumero); 
		     System.out.println("posicao do vetor = " +jj);
		     //JOptionPane.showMessageDialog(null,"posicAO VETOR="+jj);
		     xid = "" +vetor.get(jj); jj++;
		     xnom = "" +vetor.get(jj); jj++;
			xmar = ""+vetor.get(jj); jj++;
			xcat = ""+vetor.get(jj); jj++;
			xdesc = ""+vetor.get(jj); jj++;
			xfoto = (byte [])vetor.get(jj);
		     
		   }
		   else{
			    JOptionPane.showMessageDialog(null,"Não existe VETOR =" +numero);
		   }
    	   
    		saida = "";
			textoSerializado = "";
			if(xfoto != null)
			{
                   textoSerializado = Base64.getEncoder().encodeToString(xfoto);
            }
           saida = "data:image/png;base64," + textoSerializado;
           BancoSQLGeany.desconectar();
				
		}else
		  { System.out.println("vetor vazio!!");
			 
	      }
      	}//try
    	catch(Exception e)
    	{
    		out.println("ERRO =" +e);
    		
    	}//catch
 	    
	%>

<head>
<link rel = "icon" href = "unesp.jpg" type = "image/png" />
<meta http-equiv = "Content-Type" content = "text/html; charset=utf-8" />
<title>:: Alterar / Excluir::</title>
</head>
<center>


<div id = "fundo">
	<div id = "div_branca_fundo">


			<form action = "alteraexclui.jsp" method = "post">
			<font color = "#000">
			<b>-- Alterar / Excluir ----</b>


				<table width = "200" border = "0" align = "center">
				<tr>
					<td height = "40">ID:</td>
					<td><input type = "text" name = "id" readonly = "readonly" value = "<%out.print(xid);%>" />
					</td>
					
				</tr>
				<tr>
					<td height = "40">Nome:</td>
					<td><input type = "text" name = "nome" value = "<%out.print(xnom);%>"/>
					</td>
				   
				</tr>
				
				<tr>
					<td height = "40">Marca:</td>
					<td><input type = "text" name = "marca" value = "<%out.print(xmar);%>"/>
					</td>
				   
				</tr>
				
				<tr>
					<td height = "40">Categoria:</td>
					<td><input type = "text" name = "categoria" value = "<%out.print(xcat);%>"/>
					</td>
				   
				</tr>
				
				<tr>
					<td height = "40">Descrição:</td>
					<td><input type = "text" name = "descricao" value = "<%out.print(xdesc);%>"/>
					</td>
				   
				</tr>
								
				<tr>
					<td height = "40">Foto:</td>
					<td>
					<%
						out.print("<figure> <img src='"+saida+"' id='foto' name='foto' alt='"+xnom+" width='100' height='100' ' /> </figure> <br>");
					%>		
					</td>
				<tr>	
				</table>	

                <tr>
                <label for = "altera">
				<input type = "radio" id = "altera" name = "altexc" value = "alterar" checked = "true"> Alterar
				<label for = "exclui">
				<input type = "radio" id = "exclui" name = "altexc" value = "excluir"> Excluir
                </tr>
				

					
				<div style = "width: 250px; height: 80px; padding-top: 10px; display: block; margin: auto;">
							<div id = "publi_imagem" class = "publi_imagem">
								<input type = "file" id = "novafoto" name = "novafoto"/>
							</div>
							<output id = "list"></output>
							<div id = "foto_inserida_maisbaixa">
							</div>
						</div>
						
				<div style = "font-size: 4.6px;"><br></div>
				
				

				&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;


			</font>&nbsp;&nbsp;&nbsp;
			<input type = "submit" name = "teste" value = "Enviar" />&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
			<br>
			<br>

			</form>
			
			
			<script type = "text/javascript">
						var pegadiv = document.getElementById('foto_inserida_maisbaixa').insertBefore(list, null);
						pegadiv.innerHTML = ['<img id="imagelogo" class="thumb" style="width: 80px;" src="vazio.png" title="vazio.png"/>'].join('');
						
						function handleFileSelect(evt) 
						{
							//ADAPTADO DE http://www.html5rocks.com/en/tutorials/file/dndfiles/
							// Loop through the FileList and render image files as thumbnails.
							var files = evt.target.files; 
							for (var i = 0, f; f = files[i]; i++)
							{
								// Only process image files.
								if (!f.type.match('image.*'))
									continue;
								var reader = new FileReader();
								// Closure to capture the file information.
								reader.onload = (function(theFile)
								{
									return function(e)
									{
										// Render thumbnail.
										var pegadiv = document.getElementById('foto_inserida_maisbaixa').insertBefore(list, null);
										
										pegadiv.innerHTML = ['<img id="imagelogo" class="thumb" src="', e.target.result,'" title="', escape(theFile.name), '"/>'].join('');
										var largura = document.getElementById('imagelogo').offsetWidth; // retorna a largura
										var altura = document.getElementById('imagelogo').offsetHeight; // retorna a altura
										
										if (largura >= altura)
										{
											pegadiv.innerHTML = ['<img id="imagelogo" class="thumbhor" style="height: 80px;" src="', e.target.result,'" title="', escape(theFile.name), '"/>'].join('');
										}
										else if (altura >= largura)
										{
											pegadiv.innerHTML = ['<img id="imagelogo" class="thumb" style="width: 80px;" src="', e.target.result,'" title="', escape(theFile.name), '"/>'].join('');
										}
									};
								})(f);
								// Read in the image file as a data URL.
								reader.readAsDataURL(f);
							}
						}
						document.getElementById('novafoto').addEventListener('change', handleFileSelect, false);
			</script>
            </div>
				<br>
				<br>
				<div style = "font-size: 9px;"><br></div>
			</div>
</center>

</body>
</html>
