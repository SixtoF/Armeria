<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="Principal.aspx.cs" Inherits="Armeria.Principal" %>
<!DOCTYPE html>
<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <meta charset="utf-8" />
    <title>Armeria - Bienvenido</title>
    <!-- Bootstrap 5 CSS -->
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" 
          rel="stylesheet"
          integrity="sha384-9ndCyUa6mY5D6+6vJbQ8aT+Yf3p3fXGTuBt+0H0tXr2c5V9F4wWf2S21f9zzT3Zg" 
          crossorigin="anonymous" />

    <style>
        /* Imagen de fondo que se actualiza con el Timer */
        .background-image {
            position: fixed;
            top: 0;
            left: 0;
            width: 100%;
            height: 100vh;
            z-index: -1;       /* Queda detrás del contenido */
            object-fit: cover; /* Mantiene proporción al ocupar todo */
        }
        /* Caja central con fondo negro y letras en blanco */
        .login-box {
            background-color: #000;  /* Fondo negro */
            color: #fff;            /* Texto en blanco */
            border-radius: 8px;
            padding: 2rem;
            max-width: 400px;       /* Ancho máximo de la caja */
            width: 100%;
        }
    </style>
</head>
<body style="background-color: #000;">
    <form id="form1" runat="server">
        <!-- ScriptManager y UpdatePanel para actualizar la imagen de fondo -->
        <asp:ScriptManager ID="ScriptManager1" runat="server"></asp:ScriptManager>
        <asp:UpdatePanel ID="UpdatePanel1" runat="server">
            <ContentTemplate>
                <asp:Timer ID="Timer1" runat="server" Interval="2000" OnTick="Timer1_Tick"></asp:Timer>
                <!-- Imagen de fondo que se actualiza -->
                <asp:Image ID="Image1" runat="server" 
                           ImageUrl="~/Imagenes/41.jpg" 
                           CssClass="background-image" />
            </ContentTemplate>
        </asp:UpdatePanel>

        <!-- Contenido centrado en la pantalla -->
        <div class="container vh-100 d-flex justify-content-center align-items-center">
            <div class="login-box text-center">
                <h1 class="mb-4">Bienvenido a Armeria</h1>
                <p class="mb-4">Inicia sesión o regístrate para continuar</p>
                
                <!-- Botones prioritarios de Registro e Iniciar Sesión -->
                <asp:Button ID="ButtonRegistro" 
                            runat="server"
                            Text="Registrarse"
                            OnClick="ButtonRegistro_Click"
                            PostBackUrl="~/Registro.aspx"
                            CssClass="btn btn-warning btn-lg w-100 mb-3" />

                <asp:Button ID="ButtonLogin" 
                            runat="server"
                            Text="Iniciar Sesión"
                            OnClick="ButtonLogin_Click"
                            PostBackUrl="~/Registro.aspx?view=1"
                            CssClass="btn btn-outline-light btn-lg w-100" />
            </div>
        </div>

        <!-- Bootstrap 5 JS Bundle (con Popper) -->
        <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"
                integrity="sha384-ENjdO4Dr2bkBIFxQpeoC54W2LQzYt27NXFoaoApmYm81iuXoPkFOJwJ8ERdknLPM"
                crossorigin="anonymous"></script>
    </form>
</body>
</html>

