using MySql.Data.MySqlClient;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Runtime.Remoting.Messaging;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Windows.Forms;
using static System.Windows.Forms.VisualStyles.VisualStyleElement;

namespace Armeria
{
    public partial class Competiciones : System.Web.UI.Page
    {

        MySqlConnection conexion = new MySqlConnection("DataBase=armeria;DataSource=localhost;user=root;Port=3306");
        static MySqlDataReader datareader;
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                CargarCompeticiones();  // Cargar las competiciones en el GridView

            }
        }

        private void CargarCompeticiones()//cargo competiciones en mi gridview1
        {
            conexion.Open();
            MySqlCommand comando = new MySqlCommand("SELECT * FROM competiciones", conexion);
            
            GridView1.DataSource = comando.ExecuteReader();
            GridView1.DataBind();
            conexion.Close();
        }
        protected void btnGuardar_Click(object sender, EventArgs e)//insertar competicion
        {
            MySqlCommand comando = new MySqlCommand("INSERT INTO competiciones VALUES(NULL, @nombreCompeticion, @fecha, @hora, @nivel, @descripcion)", conexion);
            MySqlParameter NomCompeti = comando.Parameters.Add("@nombreCompeticion", MySqlDbType.VarChar);
            MySqlParameter Fecha = comando.Parameters.Add("@fecha", MySqlDbType.Date);
            MySqlParameter Hora = comando.Parameters.Add("@hora", MySqlDbType.Time);
            MySqlParameter Level = comando.Parameters.Add("@nivel", MySqlDbType.VarChar);
            MySqlParameter Resumen = comando.Parameters.Add("@descripcion", MySqlDbType.Text);

            NomCompeti.Value = txtNombreCompeticion.Text;
            Fecha.Value = DateTime.Parse(txtFecha.Text).ToString("yyyy-MM-dd");
            Hora.Value = TimeSpan.Parse(txtHora.Text);
            Level.Value = ddlNivel.SelectedValue;
            Resumen.Value = txtDescripcion.Text;

            //conexiones de apertura y cierre a la base de datos
            conexion.Open();
            comando.ExecuteNonQuery();
            conexion.Close();
        }
        protected void btnRegistrarGanador_Click(object sender, EventArgs e)
        {
            
                conexion.Open();
                MySqlCommand comando = new MySqlCommand("INSERT INTO resultadoscompeticiones (id_usuario, id_competicion, posicion, puntuacion) VALUES (@id_usuario, @id_competicion, @posicion, @puntuacion)", conexion);

                comando.Parameters.AddWithValue("@id_usuario", Convert.ToInt32(txtIdUsuario.Text));
                comando.Parameters.AddWithValue("@id_competicion",Convert.ToInt32(txtCompId.Text));
                comando.Parameters.AddWithValue("@posicion",Convert.ToInt32(txtPosicion.Text));
                comando.Parameters.AddWithValue("@puntuacion",Convert.ToInt32(txtPuntuacion.Text));

                comando.ExecuteNonQuery();
                conexion.Close();

                lblMensaje.Text = "Ganador registrado exitosamente.";
                lblMensaje.ForeColor = System.Drawing.Color.Green;
          
        }

        protected void ddlCompeticiones_SelectedIndexChanged(object sender, EventArgs e)//
        {
            
        }

        protected void GridView1_SelectedIndexChanged(object sender, EventArgs e)//cargar ganadores en Gridview2
        {
            conexion.Open();
            MySqlCommand comando = new MySqlCommand("SELECT u.ID, u.nombre, r.posicion, r.puntuacion FROM resultadoscompeticiones r INNER JOIN usuarios u ON r.id_usuario = u.ID WHERE r.id_competicion = @id_competicion", conexion);
            comando.Parameters.AddWithValue("@id_competicion", ddlCompeticiones.SelectedValue);

            MySqlDataReader reader = comando.ExecuteReader();
            GridView2.DataSource = reader;
            GridView2.DataBind();
            conexion.Close();
        }

        protected void Button1_Click(object sender, EventArgs e)//mostrar ganadores
        {
            conexion.Open();
            MySqlCommand comando = new MySqlCommand("SELECT u.ID, u.nombre, r.posicion, r.puntuacion FROM resultadoscompeticiones r INNER JOIN usuarios u ON r.id_usuario = u.ID", conexion);
            

            MySqlDataReader reader = comando.ExecuteReader();
            GridView2.DataSource = reader;
            GridView2.DataBind();
            conexion.Close();
        }

        protected void ddlUsuarios_SelectedIndexChanged(object sender, EventArgs e)
        {
            
        }

        protected void ButtonEditarCompeticion_Click(object sender, EventArgs e)
        {
            /*try
            {*/
                MySqlCommand comando = new MySqlCommand("UPDATE competiciones SET nombreCompeticion = @nombreCompeticion, fecha = @fecha, hora = @hora, nivel = @nivel, descripcion = @descripcion WHERE ID = @ID", conexion);
                MySqlParameter NomCompeti = comando.Parameters.Add("@nombreCompeticion", MySqlDbType.VarChar);
                MySqlParameter Fecha = comando.Parameters.Add("@fecha", MySqlDbType.Date);
                MySqlParameter Hora = comando.Parameters.Add("@hora", MySqlDbType.Time);
                MySqlParameter Level = comando.Parameters.Add("@nivel", MySqlDbType.VarChar);
                MySqlParameter Resumen = comando.Parameters.Add("@descripcion", MySqlDbType.Text);
                MySqlParameter id = comando.Parameters.Add("@ID", MySqlDbType.Int16);

                id.Value = int.Parse(txtID.Text);
                NomCompeti.Value = txtNombreCompeticion.Text;
                Fecha.Value = DateTime.Parse(txtFecha.Text).ToString("yyyy-MM-dd");
                //Hora.Value = DateTime.Parse(txtHora.Text).ToString(@"hh\:mm\:ss");
                Hora.Value = TimeSpan.Parse(txtHora.Text);
                Level.Value = ddlNivel.SelectedValue;
                Resumen.Value = txtDescripcion.Text;

                //conexiones de apertura y cierre a la base de datos
                conexion.Open();
                comando.ExecuteNonQuery();
                conexion.Close();
            lblActuali.Text = "Actualizacion de datos completa";
           /* }catch(MySqlException ex){
                lblExcep.Text = "Error en la base de datos";
            }*/
            
        }

        protected void ButtonEditarGanador_Click(object sender, EventArgs e)//añadir ganador
        {
            LabelAlerta2.Text = "";//limpia alert

            //redirigimos segun el rol del usuario
            if (Session["TipoUsuario"].ToString() == "Cliente")
            {
                // Si el nombre y la contraseña coinciden, iniciar sesión
                LabelMensajeAlerta.Text = "No puedes acceder no eres el administrador";
                

            }
            else if (Session["TipoUsuario"].ToString() == "Administrador")
            {
                conexion.Open();
                MySqlCommand comando = new MySqlCommand("SELECT nombreCompeticion FROM competiciones", conexion);
                MySqlDataReader reader = comando.ExecuteReader();

                while (reader.Read())
                {
                    ddlCompeticiones.Items.Add(reader.GetString(0));
                    
                }
                reader.Close();

                //añádimos los nombres de usuarios a la ddl
                MySqlCommand comandoUsuarios = new MySqlCommand("SELECT nombre FROM usuarios", conexion);
                MySqlDataReader readerUsuarios = comandoUsuarios.ExecuteReader();

                while (readerUsuarios.Read())
                {
                    ddlUsuarios.Items.Add(readerUsuarios.GetString(0));

                }
                readerUsuarios.Close();
                conexion.Close();

                MultiViewCompeticiones.ActiveViewIndex = 2;
            }

        }

        protected void ButtonAnadirC_Click(object sender, EventArgs e)
        {
            LabelMensajeAlerta.Text = ""; // Limpia la alerta

            //redirigimos segun el rol del usuario
            if (Session["TipoUsuario"].ToString() == "Cliente")
            {
                // Si el nombre y la contraseña coinciden, iniciar sesión
                LabelAlerta2.Text = "No puedes acceder no eres el administrador";
                
            }
            else if (Session["TipoUsuario"].ToString() == "Administrador")
            {
                MultiViewCompeticiones.ActiveViewIndex = 1;
            }
        }

        //buscar por id y se tiene que activar autopostback
        protected void txtID_TextChanged(object sender, EventArgs e)
        {
            MySqlCommand comando = new MySqlCommand("Select * from competiciones where id = @ID", conexion);
            MySqlParameter id = comando.Parameters.Add("@ID", MySqlDbType.String);
            id.Value = txtID.Text;
            conexion.Open();

            //se guarda la consulta y cuando se utiliza una Select se utiliza ExecuteReader()
            datareader = comando.ExecuteReader();


            if (datareader.HasRows)//se pregunta si tiene filas
            {
                datareader.Read();//se lee
                                  //se devuelve en el orden que se establece
                txtNombreCompeticion.Text = datareader.GetString(1);
                txtFecha.Text = datareader.GetString(2);
                txtHora.Text = datareader.GetString(3);
                ddlNivel.Text = datareader.GetString(4);
                txtDescripcion.Text = datareader.GetString(5);

            }
            else
            {
                MessageBox.Show("no se han encontrado el registro");

            }
            //hay que cerrar el registro y la conexion para evitar errores
            datareader.Close();
            conexion.Close();
        }

        protected void GridView2_SelectedIndexChanged(object sender, EventArgs e)//rellenar mi gridview2 con los ganadores
        {
            /* SELECT usuarios.ID, usuarios.nombre, resultadoscompeticiones.posicion, resultadoscompeticiones.puntuacion FROM resultadoscompeticiones 
                INNER JOIN usuarios ON resultadoscompeticiones.id_usuario = usuarios.ID;*/
            conexion.Open();
            MySqlCommand comando = new MySqlCommand("SELECT u.ID, u.nombre, r.posicion, r.puntuacion FROM resultadoscompeticiones r INNER JOIN usuarios u ON r.id_usuario = u.ID WHERE r.id_competicion = @id_competicion", conexion);
            comando.Parameters.AddWithValue("@id_competicion", ddlCompeticiones.SelectedValue);
            MySqlDataReader reader = comando.ExecuteReader();

            GridView2.DataSource = reader;
            GridView2.DataBind();
            conexion.Close();
        }

        protected void MultiViewCompeticiones_ActiveViewChanged(object sender, EventArgs e)
        {

        }

        protected void ButtonSalir_Click(object sender, EventArgs e)
        {
            Session.Abandon();
            Response.Redirect("Principal.aspx");
        }

        protected void Button1_Click1(object sender, EventArgs e)
        {
            MultiViewCompeticiones.ActiveViewIndex = 0;
        }

        protected void ButtonAtras_Click(object sender, EventArgs e)
        {
            MultiViewCompeticiones.ActiveViewIndex = 0;
        }
    }
}