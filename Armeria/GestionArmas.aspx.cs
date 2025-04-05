using MySql.Data.MySqlClient;
using System;
using System.Collections.Generic;
using System.Data;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace Armeria
{
    public partial class GestionArmas : System.Web.UI.Page
    {

        MySqlConnection conexion = new MySqlConnection("DataBase=armeria;DataSource=localhost;user=root;Port=3306");
      
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                //cargas datos en la gridView
                cargarArmas();
            }
        }

        private void cargarArmas() {

            MySqlCommand comando = new MySqlCommand("SELECT id, tipo, modelo, calibre, descripcion, stock_disponible FROM armas" ,conexion);
            MySqlDataAdapter adaptador = new MySqlDataAdapter(comando);
            DataTable tabla = new DataTable();
            adaptador.Fill(tabla);

            GridViewArmas.DataSource = tabla;
            GridViewArmas.DataBind();
        }
        protected void btnGuardarArma_Click(object sender, EventArgs e)
        {
            string Tipo_Arma = ddlTipo.SelectedValue;

            MySqlCommand comando = new MySqlCommand("INSERT INTO armas VALUES(NULL, @tipo, @modelo, @calibre, @descripcion, @stock_disponible)", conexion);
            comando.Parameters.Add("@tipo", MySqlDbType.String).Value = Tipo_Arma;
            
            MySqlParameter Modelo = comando.Parameters.Add("@modelo", MySqlDbType.String);
            MySqlParameter Calibre = comando.Parameters.Add("@calibre", MySqlDbType.String);
            MySqlParameter Descripcion = comando.Parameters.Add("@descripcion", MySqlDbType.String);
            MySqlParameter Cantidad = comando.Parameters.Add("@stock_disponible", MySqlDbType.String);



            Modelo.Value = txtModelo.Text;
            Calibre.Value = txtCalibre.Text;
            Descripcion.Value = txtDescripcion.Text;
            Cantidad.Value = int.Parse(txtStock.Text);

            //conexiones de apertura y cierre a la base de datos
            conexion.Open();
            comando.ExecuteNonQuery();
            conexion.Close();
        }

        protected void btnCancelar_Click(object sender, EventArgs e)
        {
            MultiViewGestionArmas.ActiveViewIndex = 0;
        }

        protected void btnIrAltaArma_Click(object sender, EventArgs e)
        {
            MultiViewGestionArmas.ActiveViewIndex = 1;
        }

        protected void btnEliminar_Click(object sender, EventArgs e)
        {
            //se obtiene el id del arma
            int idArma = Convert.ToInt32(((System.Web.UI.WebControls.Button)sender).CommandArgument);

            //eliminar un arma de la base de datos
            MySqlCommand comando = new MySqlCommand("DELETE FROM armas WHERE id = @id", conexion);
            comando.Parameters.Add("@id" , MySqlDbType.Int32).Value = idArma;

            //conexion cierre y ejecucion del comando
            conexion.Open();
            comando.ExecuteNonQuery();
            conexion.Close();

            //volvemos a cargar las armas a la gridview
            cargarArmas();
        }

        protected void ButtonIrComp_Click(object sender, EventArgs e)
        {
            Response.Redirect("Competiciones.aspx?view=0"); //tabla competiciones
        }
    }
}