package database;

import java.util.*;//scanner, arraylist, formatter
import java.io.*; //file
import javax.swing.*;//JOptionPane
import java.sql.*;//sql
import java.io.ByteArrayOutputStream;
import java.awt.image.BufferedImage;
import javax.imageio.ImageIO;

public class BancoSQLGeany
{
   private static File arqtest;
   private static Scanner arqler, tecla;
   private static ArrayList Lista;
   //id   , c1=nome_pet, c2=foto_pet, c3=servico,    c4=idade_pet, c5=tipoanimal;
   //long ,c1=varchar(50),  c2=blob , c3=varchar(20), c4=integer   , c5=varchar(20);

   private static String id, nomerpg, marcarpg, categoriarpg, descricaorpg;
   private static String nomearq, nomebanco, nometabela;
   private static byte[] fotorpg;
   
   private static Connection con = null;   
   private static String url = "",drive = "",fsql = "", caminho = "";
   private static ResultSet rs = null;
   private static PreparedStatement pstmt = null;//sera usado com frase sql 
   
   
	public static ArrayList pegaBanco()
	{
		try
		{
			Lista.clear();//limpa tudo
			pstmt = con.prepareStatement("select * from table_rpg");
			rs = pstmt.executeQuery();
   
			while (rs.next())
			{ // criando o objeto
				Lista.add(rs.getLong("id_rpg"));
				Lista.add(rs.getString("nome_rpg"));
				Lista.add(rs.getString("marca_rpg"));
				Lista.add(rs.getString("categoria_rpg"));
				Lista.add(rs.getString("descricao_rpg"));
				Lista.add(rs.getBytes("foto_rpg"));
				System.out.println("adicionado=");
			}//while
			rs.close();
			pstmt.close();
			System.out.println("Feita leitura Banco");
			return Lista;
		} catch (Exception el) {
			System.out.println( "Erro Arraylist"+el);
		return null;
		}
	}//pegaBanco
   
   
   public static void conectar()
   {
		con = null; 
        rs = null;
        pstmt = null;

        //com pasta
        //url="jdbc:sqlite:.\\bancosql\\"+nomeban;
        //sem pasta
        caminho = "\\xampp\\tomcat\\webapps\\RPGGeany\\";
        url = "jdbc:sqlite:"+caminho+"banco\\RPG.db";
        drive = "org.sqlite.JDBC"; //drive de conexao
        nometabela = "table_rpg";
        Lista = new ArrayList<>();
	   
       try {
           Class.forName(drive);
           con = DriverManager.getConnection(url);
           System.out.print("Conexao realizada !!!!");
        } catch (Exception e) {
			System.out.println("erro.conexao="+e);
            return;
       }
   }//fim conectar
   
    public static void desconectar()
    {
		try {
			if (con.isClosed() == false) {
				con.close();
			}
		} catch (Exception e) {
			System.out.println("Erro ao Desconectar"+e); 
			return;
		}
		System.out.println("Desconectou!!!");
	}//fim desconectar

	
	public static void adicionar(RPG_Geany r)
	{
		fsql = "insert into table_rpg" +
			   "(nome_rpg,marca_rpg,categoria_rpg,descricao_rpg,foto_rpg)" +
			   " values (?,?,?,?,?)";
		try {
		 //prepared statement para inserção
			pstmt = con.prepareStatement(fsql);
		//seta os valores
			pstmt.setString(1,r.getNome());
			pstmt.setString(2,r.getMarca());
			pstmt.setString(3,r.getCategoria());
			pstmt.setString(4,r.getDescricao());
			pstmt.setBytes(5,r.getFoto());
		//executa
			pstmt.execute();
			pstmt.close();
			System.out.println("Adicionado com Sucesso!!");
		} catch (SQLException e) {
			System.out.println("Erro na Inclusão"+e);
			return;
		}
	}//Fim Adicionar
	
	public static void altera(RPG_Geany rp)
	{
		fsql = "update table_rpg set nome_rpg=?, marca_rpg=?, categoria_rpg=?, descricao_rpg=?," +
		"foto_rpg=? where id_rpg=?";
		try {
			pstmt = con.prepareStatement(fsql);
			pstmt.setString(1, rp.getNome());
			pstmt.setString(2, rp.getMarca());
			pstmt.setString(3, rp.getCategoria());
			pstmt.setString(4, rp.getDescricao());
			pstmt.setBytes(5, rp.getFoto());
			
			pstmt.setLong(6, rp.getId());
			pstmt.execute();
			pstmt.close();
			System.out.println("Alterado com Sucesso!");
		} catch (Exception ea) 
		{
			System.out.println("Erro na Alteração"+ea);
			return;
		}
	}//Fim Alterar
			
	public static void remove(RPG_Geany rpg)
	{
		
		if(procura(rpg) == false)
		{
			System.out.println("RPG não existe!!!");
			return;
		}
		
		fsql = "delete from table_rpg where id_rpg=?";
		try {
			pstmt = con.prepareStatement(fsql);
			pstmt.setLong(1, rpg.getId());
			pstmt.execute();
			pstmt.close();
			System.out.println("Excluido com Sucesso!!!");
		} catch (Exception eee) {
			System.out.println("Erro de Exclusão!!"+eee);
			return;
		}
	}//Fim Remover
	
	public static byte[] imageToByte(String image) 
	{
		InputStream is = null;
		byte[] buffer = null;
		try
		{
			is = new FileInputStream(image);
			buffer = new byte[is.available()];
			is.read(buffer);
			is.close();
		}
		catch (Exception e) {
			System.out.println("Erro Bytes Foto="+e);
		}
		return buffer;
	}//Fim imageToByte
	
	public static boolean procura(RPG_Geany rg)
	{
		boolean flag = false;
		fsql = "select * from table_rpg where id_rpg=?";
		try {
			pstmt = con.prepareStatement(fsql);
			pstmt.setLong(1, rg.getId()); 
			rs = pstmt.executeQuery();
			if(rs.next()) //achou
			{
				System.out.println("Achou Id="+rs.getLong("id_rpg"));
				flag = true;
			}
			else
			{
				System.out.println("Não Achou Id="+rg.getId());
			}
		rs.close();
		pstmt.close();
		return flag;
		} catch (Exception el) {
			System.out.println("Erro procura="+el);
        return false;
		}
	}//Fim Procurar
	
	public static ArrayList<RPG_Geany> getLista()
	{
		try {
			ArrayList<RPG_Geany> vetor = new ArrayList<RPG_Geany>();
			pstmt = con.prepareStatement("select * from table_rpg");
			rs = pstmt.executeQuery();
			while (rs.next())
			{
				// criando o objeto Contato
				RPG_Geany g = new RPG_Geany();
				g.setId(rs.getLong("id_rpg"));
				g.setNome(rs.getString("nome_rpg"));
				g.setMarca(rs.getString("marca_rpg"));
				g.setCategoria(rs.getString("categoria_rpg"));
				g.setDescricao(rs.getString("descricao_rpg"));
				g.setFoto(rs.getBytes("foto_rpg"));
				// adicionando o objeto à lista
				vetor.add(g);
			}
			rs.close();
			pstmt.close();
			System.out.println("Leitura do Banco Realizada!!");
			return vetor;
			} catch (Exception el) {
				System.out.println("Erro no Arraylist"+el);
			}
			return null;
	}
	
	public static void ByteArrayToFileImage(byte[] bbb,String xid)
	{
		try
		{
			ByteArrayInputStream bis = new ByteArrayInputStream(bbb);
			BufferedImage bImagex = ImageIO.read(bis);
			ImageIO.write(bImagex, "jpg", new File("foto"+xid+".jpg") );
			System.out.println("image created"+xid);
		}
		catch(Exception erroi)
		{ System.out.println("Erro imagem= " + erroi);
			return;
		}
	}
	
	public static void gravandotxt()
	{
		try {
			pstmt = con.prepareStatement("select * from table_rpg");
			rs = pstmt.executeQuery();
			Formatter arquivo = new Formatter("table_rpg.txt");
			while (rs.next())
			{
				id = rs.getString("id_rpg");
				nomerpg = rs.getString("nome_rpg");
				marcarpg = rs.getString("marca_rpg");
				categoriarpg = rs.getString("categoria_rpg");
				descricaorpg = rs.getString("descricao_rpg");
				fotorpg = rs.getBytes("foto_rpg");
				arquivo.format("%s,%s,%s,%s,%s,%s,\n", 
				id, nomerpg, marcarpg, categoriarpg, descricaorpg, "foto"+id+".jpg");
				ByteArrayToFileImage(fotorpg,id);
				System.out.println("Gravando Registro= "+id);
			}//while
			rs.close();
			arquivo.close();
			pstmt.close();
			System.out.println("Leitura do Banco Realizada!!");
			return;
			} catch (Exception el) {
				System.out.println("Erro no Arraylist"+el);
			}
			return;
	}
	
	public static void lendotxt()
	{
		try
		{
			File arquivo = new File("table_rpg.txt");
			if(!arquivo.exists())
			{
				System.out.println("Arquivo nao existe!!!!!");
				return;
			}
			Scanner sc = new Scanner(arquivo);
			sc.useDelimiter("\\s*,\\s*");
			String nomefoto = "";
			while(sc.hasNext())
			{
				id = sc.next();
				nomerpg = sc.next();
				marcarpg = sc.next();
				categoriarpg = sc.next();
				descricaorpg = sc.next();
				nomefoto = sc.next();
				System.out.println("lendo = "+id+nomefoto);
				
				RPG_Geany rrr = new RPG_Geany();
				rrr.setId(Integer.parseInt(id));
				rrr.setNome(nomerpg);
				rrr.setMarca(marcarpg);
				rrr.setCategoria(categoriarpg);
				rrr.setDescricao(descricaorpg);
				fotorpg = imageToByte(nomefoto);
				rrr.setFoto(fotorpg);
				if(procura(rrr))
					altera(rrr);
				else
					adicionar(rrr);
			}///while
			sc.close();
		}
		catch(Exception el)
		{ System.out.println("Erro Leitura = "+el);
			return;
		}	
	}
	
	/*
	public static void main(String args[])
	{  
		BancoSQLGeany b = new BancoSQLGeany("RPG.db");
        b.conectar();
        //b.gravandotxt();
        b.lendotxt();
        b.desconectar();
        
        ArrayList<RPG_Geany> listar = new ArrayList<RPG_Geany>();
        listar = b.getLista();
        for(int i = 0; i<listar.size(); i++)
        {
			System.out.println(""+listar.get(i).getId());
			System.out.println(""+listar.get(i).getNome());
		}
        //b.desconectar();
        
        RPG_Geany r1 = new RPG_Geany();
        r1.setNome("nome rpg teste");
        r1.setMarca("marca rpg teste");
        r1.setCategoria("categoria rpq teste");
        r1.setDescricao("descricao rpg teste");
        fotorpg = imageToByte(".\\ImagensGeany\\TormentaGeany.png");
        r1.setFoto(fotorpg);
        //b.adicionar(r1);
        r1.setId(3);
        r1.setDescricao("Jogo muito legal");
        r1.setNome("D&D");
        fotorpg = imageToByte(".\\ImagensGeany\\RPGAleatorio.jpg");
        r1.setFoto(fotorpg);
        b.altera(r1);
        b.desconectar();
	}//main*/
}//class
