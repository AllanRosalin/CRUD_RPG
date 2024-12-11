package database;

//RPG.java
public class RPGvsCode
{
   private static long id_rpg;
   private static String nomerpg, marcarpg, categoriarpg, descricaorpg;
   private static byte[] fotorpg;
   
   
   public RPGvsCode()
   {
      setId(0);
      setNome("");
      setMarca("");
      setDescricao("");
      setCategoria("");
      setFoto(null);
   }
   
   public static void setId(long i)
   {  id_rpg = i; }
   
   public static void setNome(String n)
   {  nomerpg = n; }
   
   public static void setMarca(String m)
   {   marcarpg = m; }
   
   public static void setDescricao(String d)
   {    descricaorpg = d;}
   
   public static void setCategoria(String c)
   {  categoriarpg = c; }
   
   public static long getId()
   { return id_rpg; }
   
   public static String getNome()
   { return nomerpg;}
 
   public static String getMarca()
   { return marcarpg;  }
   
   public static String getDescricao()
   {  return descricaorpg; }
   
   public static String getCategoria()
   { return categoriarpg;}

   public static void setFoto(byte[] f)
   { fotorpg = f; }
   
   public static byte[] getFoto()
   { return fotorpg; }

}// fim CLASSE
