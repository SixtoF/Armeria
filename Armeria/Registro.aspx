<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="Registro.aspx.cs" Inherits="Armeria.Registro" %>

<!DOCTYPE html>
<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <meta charset="utf-8" />
    <title>Armeria</title>
    <!-- Bootstrap 5 CSS -->
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css"
          rel="stylesheet"
          integrity="sha384-9ndCyUa6mY5D6+6vJbQ8aT+Yf3p3fXGTuBt+0H0tXr2c5V9F4wWf2S21f9zzT3Zg"
          crossorigin="anonymous" />
    <style>
        /* Fondo con degradado */
        body {
            background: radial-gradient(circle, #333 0%, #000 80%);
            color: #fff;
        }
    </style>
</head>
<body>
    <form id="form1" runat="server">
        <!-- Contenedor principal que centra vertical/horizontalmente y da un ancho completo -->
        <div class="container d-flex flex-column justify-content-center align-items-center" style="min-height: 100vh;">
            <div class="w-100">
                <!-- MultiView original, envuelto en un div para evitar error con "class" -->
                <asp:MultiView ID="MultiView1" runat="server" OnActiveViewChanged="MultiView1_ActiveViewChanged">
                    <br />
                    
                    <!-- ====================== VISTA 1: REGISTRO ====================== -->
                    <asp:View ID="View1" runat="server">
                        <!-- Tarjeta con fondo oscuro y borde -->
                        <div class="card mx-auto" style="max-width: 600px; background-color: #111; border: 1px solid #444;">
                            <div class="card-header text-center" style="border-bottom: 1px solid #444;">
                                <asp:Label ID="Label1" runat="server" Text="REGISTRO ARMERIA" 
                                           CssClass="fw-bold"
                                           style="font-size: 1.5rem; color: #fff;">
                                </asp:Label>
                            </div>
                            <div class="card-body">
                                <br />
                                <asp:Label ID="LblNombre" runat="server" Text="Nombre:" CssClass="text-white" />
                                &nbsp;<asp:TextBox ID="TbxNombre" runat="server" 
                                                   CssClass="form-control bg-dark text-white border-secondary" />
                                <br /><br />

                                <asp:Label ID="LblApellido" runat="server" Text="Apellido:" CssClass="text-white" />
                                &nbsp;<asp:TextBox ID="TbxApellido" runat="server" 
                                                   CssClass="form-control bg-dark text-white border-secondary" />
                                <br /><br />

                                <asp:Label ID="LblDni" runat="server" Text="Dni:" CssClass="text-white" />
                                &nbsp;<asp:TextBox ID="TbxDni" runat="server" 
                                                   CssClass="form-control bg-dark text-white border-secondary" />
                                <br /><br />

                                <asp:Label ID="LblCorreo" runat="server" Text="Correo:" CssClass="text-white" />
                                &nbsp;<asp:TextBox ID="TbxCorreo" runat="server" 
                                                   CssClass="form-control bg-dark text-white border-secondary" />
                                <br /><br />

                                <asp:Label ID="LblContrasena" runat="server" Text="Contraseña:" CssClass="text-white" />
                                &nbsp;<asp:TextBox ID="TbxContrasena" runat="server" 
                                                   CssClass="form-control bg-dark text-white border-secondary" />
                                <br /><br />

                                <asp:Label ID="LblTelefono" runat="server" Text="Telefono:" CssClass="text-white" />
                                &nbsp;<asp:TextBox ID="TbxTelefono" runat="server" 
                                                   CssClass="form-control bg-dark text-white border-secondary" />
                                <br /><br />

                                <asp:Label ID="LblFechaNacimiento" runat="server" Text="FechaNacimiento:" CssClass="text-white" />
                                &nbsp;<asp:TextBox ID="TbxFechaNac" runat="server" TextMode="Date" 
                                                   CssClass="form-control bg-dark text-white border-secondary" />
                                <br /><br />

                                <asp:Label ID="LblTipoUsu" runat="server" Text="Tipo Usuario" CssClass="text-white" />
                                <br /><br />
                                <asp:DropDownList ID="DropDownListRol" runat="server" AutoPostBack="True"
                                                  CssClass="form-select bg-dark text-white border-secondary w-auto">
                                    <asp:ListItem>Seleccione Rol</asp:ListItem>
                                    <asp:ListItem>Cliente</asp:ListItem>
                                    <asp:ListItem>Administrador</asp:ListItem>
                                </asp:DropDownList>
                                <br /><br />

                                <asp:Label ID="Label10" runat="server" Text="Antecedentes Penales" CssClass="text-white" />
                                <br />
                                <asp:RadioButton ID="RadioButtonSI" runat="server" Text="SI" 
                                                 CssClass="form-check-input me-1" />
                                &nbsp;&nbsp;
                                <asp:RadioButton ID="RadioButtonNo" runat="server" Text="No" 
                                                 CssClass="form-check-input me-1" />
                                <br /><br />

                                <!-- Botón Registrar con estilo de Bootstrap -->
                                <asp:Button ID="ButtonRegistrarse" runat="server" Text="Registrar" 
                                            OnClick="ButtonRegistrarse_Click"
                                            CssClass="btn btn-info fw-bold" />
                                <br /><br />

                                <asp:Label ID="LabelOK" runat="server" CssClass="fw-bold text-success"></asp:Label>
                                <br />
                            </div>
                        </div>
                    </asp:View>
                    <br />
                    
                    <!-- ====================== VISTA 2: INICIAR SESIÓN ====================== -->
                    <asp:View ID="View2" runat="server">
                        <div class="card mx-auto" style="max-width: 600px; background-color: #111; border: 1px solid #444;">
                            <div class="card-header text-center" style="border-bottom: 1px solid #444;">
                                <asp:Label ID="Label2" runat="server" Text="INICIAR SESION" 
                                           CssClass="fw-bold"
                                           style="font-size: 1.5rem; color: #fff;">
                                </asp:Label>
                            </div>
                            <div class="card-body">
                                <br />
                                <asp:Label ID="LblUsuario" runat="server" Text="Usuario" CssClass="text-white" />
                                &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
                                <asp:Label ID="Label3" runat="server" Text="Contaseña" CssClass="text-white" />
                                <br />
                                <asp:TextBox ID="TxtUsuario" runat="server" 
                                             CssClass="form-control bg-dark text-white border-secondary w-50 d-inline-block" />
                                &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
                                <asp:TextBox ID="TxtContrasena" runat="server" 
                                             CssClass="form-control bg-dark text-white border-secondary w-50 d-inline-block" />
                                <br /><br />

                                <!-- Botón Iniciar Sesión con estilo Bootstrap -->
                                <asp:Button ID="ButtonInicioSesion" runat="server" Text="Iniciar Sesion" 
                                            OnClick="ButtonInicioSesion_Click"
                                            CssClass="btn btn-success fw-bold" />
                                &nbsp;<asp:Label ID="LabelDatosErroneos" runat="server" CssClass="text-danger fw-bold"></asp:Label>
                                <br /><br />

                                <asp:Label ID="Label4" runat="server" Text="¿No estas Registrado?" CssClass="text-white" />
                                <asp:Button ID="BttRegis" runat="server" Text="Registrarse" 
                                            OnClick="BttRegis_Click" 
                                            CssClass="btn btn-outline-light btn-sm ms-2" />
                                <br />
                            </div>
                        </div>
                    </asp:View>
                    <br /><br />

                    <!-- ====================== VISTA 3: RESERVAS ====================== -->
                    <asp:View ID="View3" runat="server">
                        <div class="card mx-auto" style="max-width: 600px; background-color: #111; border: 1px solid #444;">
                            <div class="card-header text-center" style="border-bottom: 1px solid #444;">
                                <asp:Label ID="Label5" runat="server" Text="RESERVAS" 
                                           CssClass="fw-bold"
                                           style="font-size: 1.5rem; color: #fff;">
                                </asp:Label>
                            </div>
                            <div class="card-body">
                                <br />
                                <asp:Label ID="Label6" runat="server" Text="Selecciona Arma" CssClass="text-white" />
                                &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
                                <asp:Label ID="Label12" runat="server" Text="Ver Fechas Reservas" CssClass="text-white" />
                                <br />
                                <asp:DropDownList ID="DropDownList1" runat="server" AutoPostBack="True" 
                                                  CssClass="form-select bg-dark text-white border-secondary w-auto d-inline-block">
                                    <asp:ListItem>Selecciona Tipo Arma</asp:ListItem>
                                    <asp:ListItem>Pistola</asp:ListItem>
                                    <asp:ListItem>Francotirador</asp:ListItem>
                                    <asp:ListItem>Escopeta</asp:ListItem>
                                    <asp:ListItem>Fusil</asp:ListItem>
                                    <asp:ListItem>Subfusil</asp:ListItem>
                                </asp:DropDownList>
                                &nbsp;&nbsp;&nbsp;
                                <asp:DropDownList ID="ddlVerReserva" runat="server" AutoPostBack="True" 
                                                  OnSelectedIndexChanged="ddlVerReserva_SelectedIndexChanged"
                                                  CssClass="form-select bg-dark text-white border-secondary w-auto d-inline-block">
                                </asp:DropDownList>
                                <br /><br />

                                <asp:Label ID="Label7" runat="server" Text="Seleccionar Fecha" CssClass="text-white" />
                                <br />
                                <asp:TextBox ID="TextBoxFecha" runat="server" TextMode="Date" 
                                             CssClass="form-control bg-dark text-white border-secondary w-auto" />
                                <br /><br />

                                <asp:Label ID="Label8" runat="server" Text="Seleccionar Hora" CssClass="text-white" />
                                <br />
                                <asp:TextBox ID="TxbHoraReserva" runat="server" TextMode="Time" 
                                             CssClass="form-control bg-dark text-white border-secondary w-auto" />
                                <br /><br />

                                <asp:Label ID="Label9" runat="server" Text="Tipo Reserva" CssClass="text-white" />
                                <br />
                                <asp:DropDownList ID="DropDownList2" runat="server" AutoPostBack="True" 
                                                  CssClass="form-select bg-dark text-white border-secondary w-auto">
                                    <asp:ListItem>Selecciona Opcion</asp:ListItem>
                                    <asp:ListItem>Practica</asp:ListItem>
                                    <asp:ListItem>Competicion</asp:ListItem>
                                </asp:DropDownList>
                                <br /><br />

                                <asp:Label ID="Label11" runat="server" Text="Tipo Estado" CssClass="text-white" />
                                <br />
                                <asp:TextBox ID="TxbEstado" runat="server" 
                                             CssClass="form-control bg-dark text-white border-secondary w-auto" OnTextChanged="TxbEstado_TextChanged" />
                                <br /><br />

                                <!-- Botones con estilo Bootstrap -->
                                <asp:Button ID="ButtonReservar" runat="server" Text="Realizar Reserva" 
                                            OnClick="ButtonReservar_Click"
                                            CssClass="btn btn-warning fw-bold" />
                                <asp:Button ID="ButtonVerCompeticion" runat="server" 
                                            OnClick="ButtonVerCompeticion_Click" 
                                            Text="Ver Competiciones" 
                                            CssClass="btn btn-outline-warning ms-2" />
                                <asp:Button ID="ButtonCerrarSesion" runat="server" 
                                            OnClick="ButtonCerrarSesion_Click" 
                                            Text="Cerrar Sesion" 
                                            CssClass="btn btn-outline-light ms-2" />
                                <br /><br />

                                <asp:Label ID="lblReservas" runat="server" CssClass="text-success fw-bold"></asp:Label>
                                <br />
                            </div>
                        </div>
                    </asp:View>
                    <br />
                </asp:MultiView>
            </div>
        </div>
        
        <!-- Bootstrap 5 JS Bundle con Popper -->
        <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"
                integrity="sha384-ENjdO4Dr2bkBIFxQpeoC54W2LQzYt27NXFoaoApmYm81iuXoPkFOJwJ8ERdknLPM"
                crossorigin="anonymous"></script>
    </form>
</body>
</html>

