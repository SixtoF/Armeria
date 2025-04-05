using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Windows.Forms;

namespace Armeria
{
    public partial class Principal : System.Web.UI.Page
    {

        //variable global static para que no se altere su valor
        static int count = 0;
        protected void Page_Load(object sender, EventArgs e)
        {

        }

        protected void Timer1_Tick(object sender, EventArgs e)
        {
            //llamo a la funcion
            mostrar_imagenes();
        }

        void mostrar_imagenes()
        {
            //si sale de los casos estipulados se reinicia a 0
            if (count == 3)
            {
                count = 0;
            }

            switch (count)
            {
                case 0:
                    Image1.ImageUrl = "~/Imagenes/41.jpg";
                    break;
                
                case 1:
                    Image1.ImageUrl = "~/Imagenes/vip.jpg";
                    break;
            }
            count++;

        }

        protected void ButtonRegistro_Click(object sender, EventArgs e)
        {
            Response.Redirect("Registro.aspx?view=0");//registrarse
        }

        protected void ButtonLogin_Click(object sender, EventArgs e)
        {
            Response.Redirect("Registro.aspx?view=1");//inicio sesion
        }
    }
}