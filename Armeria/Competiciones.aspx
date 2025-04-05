<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="Competiciones.aspx.cs" Inherits="Armeria.Competiciones" %>

<!DOCTYPE html>
<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <meta charset="utf-8" />
    <title>Competiciones</title>
    <!-- Bootstrap 5 CSS -->
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css"
          rel="stylesheet"
          integrity="sha384-9ndCyUa6mY5D6+6vJbQ8aT+Yf3p3fXGTuBt+0H0tXr2c5V9f4wWf2S21f9zzT3Zg"
          crossorigin="anonymous" />
    <style>
        /* 
           Fondo tipo “camuflaje” en tonos verdes y oscuros, 
        */
        body {
            color: #fff;
            background-color: #000;
            background-image:
                /* Patrón punteado */
                radial-gradient(circle 2px at 2px 2px, #032 99%, transparent 100%),
                radial-gradient(circle 2px at 10px 10px, #041 99%, transparent 100%),
                /* Grandes salpicaduras verdes simulando camuflaje */
                radial-gradient(circle 80px at 30% 40%, rgba(0,128,0,0.3) 0%, transparent 70%),
                radial-gradient(circle 100px at 70% 80%, rgba(0,100,0,0.3) 0%, transparent 80%),
                radial-gradient(circle 60px at 50% 60%, rgba(34,139,34,0.3) 0%, transparent 80%);
            background-size:
                20px 20px,
                20px 20px,
                100% 100%, 
                100% 100%, 
                100% 100%;
            background-repeat:
                repeat, 
                repeat,
                no-repeat, 
                no-repeat, 
                no-repeat;
        }

        /* Contenedor relativo para ubicar las dos GridView */
        .grid-container {
            position: relative;
            min-height: 300px;
        }

        /* Botones estilo neón en verde brillante */
        .btn-neon-green {
            background: linear-gradient(45deg, #7fff00, #0f0);
            border: 1px solid #0c0;
            color: #000;
            font-weight: bold;
            box-shadow: 0 0 8px rgba(0, 255, 0, 0.8);
        }
        .btn-neon-green:hover {
            background: linear-gradient(45deg, #0f0, #7fff00);
            box-shadow: 0 0 12px rgba(127, 255, 0, 1);
        }

        /* Otros botones con un outline verde */
        .btn-outline-green {
            border-color: #0f0;
            color: #0f0;
        }
        .btn-outline-green:hover {
            background-color: #0f0;
            color: #000;
        }
    </style>
</head>
<body>
    <form id="form1" runat="server">
        <div class="container py-4">
            <br />
            <!-- Título principal -->
            <asp:Label ID="Label1" runat="server" Text="COMPETICION SEMANAL" 
                       CssClass="fw-bold" style="font-size:1.5rem;"></asp:Label>
            <br />

            <asp:MultiView ID="MultiViewCompeticiones" runat="server" ActiveViewIndex="0" OnActiveViewChanged="MultiViewCompeticiones_ActiveViewChanged">
                <br />
                <!-- ========================= VISTA 1 ========================= -->
                <asp:View ID="View1" runat="server">
                    <br /><br />
                    <div class="grid-container">
                        <!-- GridView1 queda a la izquierda -->
                        <asp:GridView ID="GridView1" runat="server" OnSelectedIndexChanged="GridView1_SelectedIndexChanged">
                        </asp:GridView>

                        <!-- GridView2 (position:absolute) para alinearse a la derecha -->
                        <asp:GridView ID="GridView2" runat="server"
                                      style="text-align: center; z-index: 1; left: 316px; top: 182px; position: absolute; height: 152px; width: 232px; right: 925px"
                                      OnSelectedIndexChanged="GridView2_SelectedIndexChanged">
                        </asp:GridView>
                    </div>
                    <!-- Botones  .btn-neon-green -->
                    <asp:Button ID="ButtonMostrarGanadores" runat="server" OnClick="Button1_Click" Text="Mostrar Ganadores"
                                CssClass="btn btn-neon-green mt-3" />
                    <br /><br />
                    <!-- Otros botones con diferentes estilos para variedad -->
                    <asp:Button ID="ButtonEditarGanador" runat="server" Text="Añadir Ganador" OnClick="ButtonEditarGanador_Click"
                                CssClass="btn btn-neon-green" />
                    <asp:Button ID="ButtonAnadirC" runat="server" OnClick="ButtonAnadirC_Click" Text="Añadir Competicion"
                                CssClass="btn btn-outline-green ms-2" />
                    <asp:Button ID="ButtonSalir" runat="server" OnClick="ButtonSalir_Click" Text="Salir"
                                CssClass="btn btn-outline-light ms-2" />
                    <br /><br />
                    <asp:Label ID="LabelMensajeAlerta" runat="server"></asp:Label>
                    &nbsp;<asp:Label ID="LabelAlerta2" runat="server"></asp:Label>
                    <br /><br />
                </asp:View>
                <br /><br />

                <!-- ========================= VISTA 2 ========================= -->
                <asp:View ID="View2" runat="server">
                    <asp:Label ID="Label2" runat="server" Text="Añadir Competicion" 
                               CssClass="fw-bold" style="font-size:1.25rem;"></asp:Label>
                    <br /><br />
                    <asp:Label ID="Label3" runat="server" Text="Para Editar Dime el ID"></asp:Label>
                    <asp:TextBox ID="txtID" runat="server" style="margin-left: 13px" AutoPostBack="True" OnTextChanged="txtID_TextChanged"></asp:TextBox>
                    <br /><br />
                    <label for="txtNombreCompeticion">Nombre de la Competición:</label>
                    <asp:TextBox ID="txtNombreCompeticion" runat="server" MaxLength="100"></asp:TextBox>
                    <br /><br />
                    <label for="txtFecha">Fecha:</label>
                    <asp:TextBox ID="txtFecha" runat="server" TextMode="Date"></asp:TextBox>
                    <asp:RequiredFieldValidator ID="rfvFecha" runat="server" ControlToValidate="txtFecha"
                        ErrorMessage="La fecha es obligatoria" ForeColor="Red" Display="Dynamic" />
                    <br /><br />
                    <label for="txtHora">Hora:</label>
                    <asp:TextBox ID="txtHora" runat="server" TextMode="Time"></asp:TextBox>
                    <asp:RequiredFieldValidator ID="rfvHora" runat="server" ControlToValidate="txtHora"
                        ErrorMessage="La hora es obligatoria" ForeColor="Red" Display="Dynamic" />
                    <br /><br />
                    <label for="ddlNivel">Nivel:</label>
                    <asp:DropDownList ID="ddlNivel" runat="server">
                        <asp:ListItem Text="Principiante" Value="Principiante"></asp:ListItem>
                        <asp:ListItem Text="Intermedio" Value="Intermedio"></asp:ListItem>
                        <asp:ListItem Text="Avanzado" Value="Avanzado"></asp:ListItem>
                    </asp:DropDownList>
                    <br /><br />
                    <label for="txtDescripcion">Descripción:</label>
                    <asp:TextBox ID="txtDescripcion" runat="server" TextMode="MultiLine" Rows="4" Columns="50"></asp:TextBox>
                    <br /><br />
                    <asp:Button ID="btnGuardar" runat="server" Text="Guardar Competición" OnClick="btnGuardar_Click"
                                CssClass="btn btn-neon-green" />
                    <asp:Button ID="ButtonEditarCompeticion" runat="server" OnClick="ButtonEditarCompeticion_Click" Text="EditarCompeticion"
                                CssClass="btn btn-outline-green ms-2" />
                    <asp:Button ID="Button1" runat="server" OnClick="Button1_Click1" Text="Atras"
                                CssClass="btn btn-outline-light ms-2" />
                    <br /><br />
                    <asp:Label ID="lblExcep" runat="server"></asp:Label>
                    <asp:Label ID="lblActuali" runat="server"></asp:Label>
                    <br /><br />
                </asp:View>
                <br />

                <!-- ========================= VISTA 3 ========================= -->
                <asp:View ID="View3" runat="server">
                    <br />
                    <h2>Ver Nombre Competicion y Usuarios Registrados</h2>
                    <label for="ddlCompeticiones">Ver Competiciones:</label>
                    <asp:DropDownList ID="ddlCompeticiones" runat="server"
                        AutoPostBack="True"
                        OnSelectedIndexChanged="ddlCompeticiones_SelectedIndexChanged">
                    </asp:DropDownList>
                    <br /><br />
                    <label for="ddlUsuarios">Ver Usuarios:</label>
                    <asp:DropDownList ID="ddlUsuarios" runat="server" OnSelectedIndexChanged="ddlUsuarios_SelectedIndexChanged" AutoPostBack="True"></asp:DropDownList>
                    <br /><br />
                    <h2>Gestionar Ganador</h2>
                    <fieldset>
                        <legend>Información del Ganador</legend>
                        <asp:Label ID="lblUsuarioId" runat="server" Text="id_usuario"></asp:Label>
                        &nbsp;<asp:TextBox ID="txtIdUsuario" runat="server"></asp:TextBox>
                        <br /><br />
                        <asp:Label ID="lblCompeId" runat="server" Text="id_competicion"></asp:Label>
                        &nbsp;<asp:TextBox ID="txtCompId" runat="server"></asp:TextBox>
                        <br /><br />
                        <asp:Label ID="lblPosicion" runat="server" Text="posicion"></asp:Label>
                        &nbsp;<asp:TextBox ID="txtPosicion" runat="server"></asp:TextBox>
                        <br /><br />
                        <asp:Label ID="lblPuntuacion" runat="server" Text="puntuacion"></asp:Label>
                        &nbsp;<asp:TextBox ID="txtPuntuacion" runat="server"></asp:TextBox>
                        <br /><br />
                        <asp:Button ID="btnRegistrarGanador" runat="server" Text="Registrar Ganador"
                            OnClick="btnRegistrarGanador_Click" Visible="True" 
                            CssClass="btn btn-neon-green" />
                        <asp:Button ID="ButtonAtras" runat="server" OnClick="ButtonAtras_Click" Text="Volver"
                            CssClass="btn btn-outline-light ms-2" />
                    </fieldset>
                    <br />
                    <asp:Label ID="lblMensaje" runat="server" ForeColor="Red"></asp:Label>
                    <br />
                </asp:View>
            </asp:MultiView>
            <br />
        </div>

        <!-- Bootstrap 5 JS Bundle (con Popper) -->
        <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"
                integrity="sha384-ENjdO4Dr2bkBIFxQpeoC54W2LQzYt27NXFoaoApmYm81iuXoPkFOJwJ8ERdknLPM"
                crossorigin="anonymous"></script>
    </form>
</body>
</html>

