using System;
using System.Collections.Generic;
using System.Data;
using System.Data.SqlClient;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Windows.Forms;

//referencias
using MySql.Data;
using MySql.Data.MySqlClient;

namespace Armeria
{
    public partial class Registro : System.Web.UI.Page
    {

        MySqlConnection conexion = new MySqlConnection("DataBase=armeria;DataSource=localhost;user=root;Port=3306");
        //static MySqlDataReader datareader;
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                // Verifica si se pasó el parámetro "view"
                string viewIndex = Request.QueryString["view"];
                  
                MultiView1.ActiveViewIndex = Convert.ToInt16(viewIndex);

                // Solo la primera vez que carga la página
                TxbEstado.Text = "En espera";
            }
        }

        protected void ButtonRegistrarse_Click(object sender, EventArgs e)
        {
            //validar antecedentes penales
            if (RadioButtonSI.Checked)
            {
                LabelOK.Text = "Lo siento no puedes tener antecedentes penales para usar nuestras intalaciones";
                RadioButtonSI.Checked = false;
            }
            else if (RadioButtonNo.Checked)
            {
                string TipoUsuario = DropDownListRol.SelectedValue;

                // **Nueva validación**: Solo permitir "Cliente"
                if (TipoUsuario != "Cliente")
                {
                    LabelOK.Text = "Solo se permiten altas de usuarios con rol Cliente.";
                    return;  // Se interrumpe el proceso, sin insertar
                }

                MySqlCommand comando = new MySqlCommand("INSERT INTO usuarios VALUES(NULL, @nombre, @apellido, @dni, @correo, @contraseña, @telefono, @fecha_nacimiento, @tipo_Usuario)", conexion);
                MySqlParameter Nombre = comando.Parameters.Add("@nombre", MySqlDbType.String);
                MySqlParameter Apellido = comando.Parameters.Add("@apellido", MySqlDbType.String);
                MySqlParameter Dni = comando.Parameters.Add("@dni", MySqlDbType.String);
                MySqlParameter Correo = comando.Parameters.Add("@correo", MySqlDbType.String);
                MySqlParameter Contrasena = comando.Parameters.Add("@contraseña", MySqlDbType.String);
                MySqlParameter Telefono = comando.Parameters.Add("@telefono", MySqlDbType.String);
                MySqlParameter FechaNacimiento = comando.Parameters.Add("@fecha_nacimiento", MySqlDbType.String);
                comando.Parameters.Add("@tipo_Usuario", MySqlDbType.String).Value = TipoUsuario;

                Nombre.Value = TbxNombre.Text;
                Apellido.Value = TbxApellido.Text;
                Dni.Value = TbxDni.Text;
                Correo.Value = TbxCorreo.Text;
                Contrasena.Value = TbxContrasena.Text;
                Telefono.Value = TbxTelefono.Text;
                FechaNacimiento.Value = TbxFechaNac.Text;

                //conexiones de apertura y cierre a la base de datos
                conexion.Open();
                comando.ExecuteNonQuery();
                conexion.Close();

                LabelOK.Text = "Registro correcto";

                //activar view2
                MultiView1.ActiveViewIndex = 1;
            }
            else
            {
                LabelOK.Text = "Debes rellenar todos los datos";
            }
            

        }

        protected void ButtonInicioSesion_Click(object sender, EventArgs e)
        {
            //consulta sql para verificar credenciales
            MySqlCommand comando = new MySqlCommand("SELECT tipo_Usuario FROM usuarios WHERE nombre = @nombre AND contraseña = @contraseña", conexion);

            MySqlParameter Nombre = comando.Parameters.Add("@nombre", MySqlDbType.String);
            MySqlParameter Contrasena = comando.Parameters.Add("@contraseña", MySqlDbType.String);

            Nombre.Value = TxtUsuario.Text;
            Contrasena.Value = TxtContrasena.Text;

            //apertura base de datos
            conexion.Open();

            // Ejecutar la consulta y obtener el rol del usuario
            object resultado = comando.ExecuteScalar();

            //cierre de base de datos
            conexion.Close();

            // Verificar si las credenciales son correctas
            if (resultado != null) {

                //guardar datos de sesion
                Session["Usuario"] = TxtUsuario.Text;
                Session["TipoUsuario"] = resultado.ToString();

                //redirigimos segun el rol del usuario
                if (Session["TipoUsuario"].ToString() == "Cliente")
                {
                    // Si el nombre y la contraseña coinciden, iniciar sesión
                    //MessageBox.Show("Bienvenido");

                    // Cambiar a la vista deseada donde el usuario está autenticado
                    MultiView1.ActiveViewIndex = 2; // activamos la vista 3
                }
                else if (Session["TipoUsuario"].ToString() == "Administrador")
                {
                    // Redirigir a la página que contiene MultiViewGestionArmas
                    Response.Redirect("GestionArmas.aspx?view=0");
                }
                else
                {
                    // Si las credenciales no coinciden
                    //MessageBox.Show("Nombre de usuario o contraseña incorrectos");
                    LabelDatosErroneos.Text = "Usuario o contraseña incorrectos";
                }
            }
        }

        protected void BttRegis_Click(object sender, EventArgs e)
        {
            MultiView1.ActiveViewIndex = 0;
        }

        protected void ButtonReservar_Click(object sender, EventArgs e)
        {
            // Verificamos que el usuario esté identificado
            if (Session["Usuario"] == null)
            {
                lblReservas.Text = "Usuario no identificado";
                return;
            }

            // Asumimos que en Session["Usuario"] se almacena el nombre del usuario
            string nombreUsuario = Session["Usuario"].ToString();
            int usuarioId = 0;

            // Consulta para obtener el ID del usuario a partir del nombre
            string queryUser = "SELECT id FROM usuarios WHERE nombre = @nombre LIMIT 1";
            MySqlCommand cmdUser = new MySqlCommand(queryUser, conexion);
            cmdUser.Parameters.AddWithValue("@nombre", nombreUsuario);

            // Abrimos la conexión y ejecutamos la consulta para el usuario
            conexion.Open();
            object resultUser = cmdUser.ExecuteScalar();
            if (resultUser == null)
            {
                lblReservas.Text = "Usuario no encontrado.";
                conexion.Close();
                return;
            }
            usuarioId = Convert.ToInt32(resultUser);
            conexion.Close();

            // Ahora, obtenemos el id_arma desde la tabla armas según el tipo seleccionado en el DropDownList1
            string tipoArma = DropDownList1.SelectedValue; // Ejemplo: "Pistola", "Francotirador", etc.
            int armaId = 0;
            string queryArma = "SELECT ID FROM armas WHERE tipo = @tipo LIMIT 1";
            MySqlCommand cmdArma = new MySqlCommand(queryArma, conexion);
            cmdArma.Parameters.AddWithValue("@tipo", tipoArma);

            conexion.Open();
            object resultArma = cmdArma.ExecuteScalar();
            if (resultArma == null)
            {
                lblReservas.Text = "Arma no encontrada.";
                conexion.Close();
                return;
            }
            armaId = Convert.ToInt32(resultArma);
            conexion.Close();

            MySqlCommand comando = new MySqlCommand("INSERT INTO reservas VALUES(NULL, @id_usuario, @id_arma, @fecha, @hora, @tipo, @estado)", conexion);
            MySqlParameter Usuario = comando.Parameters.Add("@id_usuario", MySqlDbType.Int32);
            MySqlParameter Arma = comando.Parameters.Add("@id_arma", MySqlDbType.Int32);
            MySqlParameter Fecha = comando.Parameters.Add("@fecha", MySqlDbType.Date);
            MySqlParameter Hora = comando.Parameters.Add("@hora", MySqlDbType.Time);
            MySqlParameter Tipo = comando.Parameters.Add("@tipo", MySqlDbType.String);
            MySqlParameter Estado = comando.Parameters.Add("@estado", MySqlDbType.String);


            Usuario.Value = usuarioId;
            Arma.Value = armaId;
            Fecha.Value = DateTime.Parse(TextBoxFecha.Text);
            Hora.Value = TimeSpan.Parse(TxbHoraReserva.Text);
            Tipo.Value = DropDownList2.SelectedValue;
            Estado.Value = TxbEstado.Text;

            //conexiones de apertura y cierre a la base de datos
            conexion.Open();
            comando.ExecuteNonQuery();
            conexion.Close();


            // Limpiar el dropdown
            ddlVerReserva.Items.Clear();

            // Abrir la conexión si no está abierta
            if (conexion.State != ConnectionState.Open)
            {
                conexion.Open();
            }

            // Consulta que une reservas con usuarios y filtra por el nombre de usuario
            string query = "SELECT r.fecha " +
                           "FROM reservas r " +
                           "INNER JOIN usuarios u ON r.id_usuario = u.id " +
                           "WHERE u.nombre = @nombre";

            MySqlCommand comandoReservas = new MySqlCommand(query, conexion);
            comandoReservas.Parameters.AddWithValue("@nombre", nombreUsuario);

            MySqlDataReader readerReservas = comandoReservas.ExecuteReader();

            while (readerReservas.Read())
            {
                // Suponiendo que 'fecha' es de tipo DateTime y se formatea a "dd/MM/yyyy"
                DateTime fecha = readerReservas.GetDateTime(0);
                ddlVerReserva.Items.Add(fecha.ToString("dd/MM/yyyy"));
            }

            readerReservas.Close();
            conexion.Close();

            lblReservas.Text = "Reserva realizada con exito!";
        }

        protected void MultiView1_ActiveViewChanged(object sender, EventArgs e)
        {

        }

        protected void ButtonVerCompeticion_Click(object sender, EventArgs e)
        {
           
               Response.Redirect("Competiciones.aspx?view=0"); //tabla competiciones
        }

        protected void ddlVerReserva_SelectedIndexChanged(object sender, EventArgs e)
        {

        }

        protected void ButtonCerrarSesion_Click(object sender, EventArgs e)
        {
            Session.Abandon();
            Response.Redirect("Principal.aspx");
        }

        protected void TxbEstado_TextChanged(object sender, EventArgs e)
        {

        }
    }
}