<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="GestionArmas.aspx.cs" Inherits="Armeria.GestionArmas" %>

<!DOCTYPE html>
<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <meta charset="utf-8" />
    <title>Gestión de Armas</title>
    <!-- Bootstrap 5 CSS -->
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css"
          rel="stylesheet"
          integrity="sha384-9ndCyUa6mY5D6+6vJbQ8aT+Yf3p3fXGTuBt+0H0tXr2c5V9F4wWf2S21f9zzT3Zg"
          crossorigin="anonymous" />
    <style>
        /*
            Fondo oscuro con:
            1) Patrón de puntos (radial-gradient) repetidos para simular marcas o “puntos de bala”.
            2) Varias “salpicaduras” con gradientes más grandes y semitransparentes.
        */
        body {
            background-color: #000;
            background-image:
                /* Puntos pequeños repetidos */
                radial-gradient(circle 2px at 2px 2px, #444 99%, transparent 100%),
                radial-gradient(circle 2px at 10px 10px, #444 99%, transparent 100%),
                /* Salpicaduras grandes */
                radial-gradient(circle 60px at 25% 35%, rgba(255, 0, 0, 0.3) 0%, transparent 70%),
                radial-gradient(circle 80px at 70% 60%, rgba(0, 255, 255, 0.3) 0%, transparent 80%),
                radial-gradient(circle 50px at 50% 80%, rgba(255, 255, 0, 0.3) 0%, transparent 80%);
            /*
                Explicación:
                - Los dos primeros gradientes son los puntos pequeños, repetidos en 20x20.
                - Los siguientes gradientes son las “salpicaduras” con distintos tamaños, colores y ubicaciones.
            */
            background-size:
                20px 20px, 20px 20px, /* Para los puntos */
                100% 100%, 100% 100%, 100% 100%; /*  salpicaduras  */
            background-repeat:
                repeat, repeat,
                no-repeat, no-repeat, no-repeat;
            color: #fff;
        }

        /* Tarjetas con borde blanco y un sutil resplandor */
        .card-custom {
            max-width: 800px;
            background-color: #111;
            border: 2px solid #fff; /* Borde blanco */
            box-shadow: 0 0 15px rgba(255, 255, 255, 0.5); /* Resplandor blanco */
        }

        /* Cabecera de la tarjeta con un ligero borde inferior */
        .card-header-custom {
            border-bottom: 2px solid #fff;
        }

        /* Títulos con sombra “neón” rosada */
        .card-header-custom h2, h2 {
            text-shadow: 0 0 8px #ff00ff;
        }

        /* Botones con efecto luminoso */
        .btn-luminescent {
            background: linear-gradient(90deg, #ff0, #0ff, #f0f);
            color: #000;
            border: none;
            font-weight: bold;
            box-shadow: 0 0 10px rgba(255, 0, 255, 0.7);
        }
        .btn-luminescent:hover {
            background: linear-gradient(90deg, #f0f, #ff0, #0ff);
        }
    </style>
</head>
<body>
    <form id="form1" runat="server">
        <!-- Contenedor que centra vertical/horizontalmente con altura completa -->
        <div class="container d-flex flex-column justify-content-center align-items-center" style="min-height: 100vh;">
            <div class="w-100">
                <!-- MultiView original -->
                <asp:MultiView ID="MultiViewGestionArmas" runat="server" ActiveViewIndex="0">
                    <br />
                    <!-- ====================== VISTA 1: LISTADO DE ARMAS ====================== -->
                    <asp:View ID="View1" runat="server">
                        <div class="card card-custom mx-auto">
                            <div class="card-header card-header-custom text-center">
                                <h2 class="fw-bold">Listado de Armas</h2>
                            </div>
                            <div class="card-body">
                                <!-- GridView con estilo oscuro -->
                                <asp:GridView ID="GridViewArmas" runat="server" AutoGenerateColumns="False" 
                                              BorderColor="Black" BorderWidth="1px"
                                              CssClass="table table-dark table-striped">
                                    <Columns>
                                        <asp:BoundField DataField="id" HeaderText="ID" />
                                        <asp:BoundField DataField="tipo" HeaderText="Tipo" />
                                        <asp:BoundField DataField="modelo" HeaderText="Modelo" />
                                        <asp:BoundField DataField="calibre" HeaderText="Calibre" />
                                        <asp:BoundField DataField="descripcion" HeaderText="Descripción" />
                                        <asp:BoundField DataField="stock_disponible" HeaderText="Stock Disponible" />
                                        <asp:TemplateField HeaderText="Acciones">
                                            <ItemTemplate>
                                                <asp:Button ID="btnEliminar" runat="server" Text="Eliminar" 
                                                            CommandName="Eliminar" 
                                                            CommandArgument='<%# Eval("id") %>' 
                                                            OnClick="btnEliminar_Click"
                                                            CssClass="btn btn-danger btn-sm" />
                                            </ItemTemplate>
                                        </asp:TemplateField>
                                    </Columns>
                                </asp:GridView>
                                <br />
                                <!-- Botones con efecto luminoso y outline -->
                                <asp:Button ID="btnIrAltaArma" runat="server" Text="Dar de Alta Nueva Arma" 
                                            OnClick="btnIrAltaArma_Click" 
                                            CssClass="btn btn-luminescent fw-bold" />
                                <asp:Button ID="ButtonIrComp" runat="server" OnClick="ButtonIrComp_Click" Text="Ir a Competiciones" 
                                            CssClass="btn btn-outline-light ms-2 fw-bold" />
                            </div>
                        </div>
                    </asp:View>
                    <br />

                    <!-- ====================== VISTA 2: DAR DE ALTA NUEVA ARMA ====================== -->
                    <asp:View ID="View2" runat="server">
                        <div class="card card-custom mx-auto">
                            <div class="card-header card-header-custom text-center">
                                <h2 class="fw-bold">Dar de Alta Nueva Arma</h2>
                            </div>
                            <div class="card-body">
                                <label for="txtTipo">Tipo:</label>
                                <asp:DropDownList ID="ddlTipo" runat="server" AutoPostBack="True"
                                                  CssClass="form-select bg-dark text-white border-secondary w-auto d-inline-block">
                                    <asp:ListItem Text="Subfusil" Value="Subfusil"></asp:ListItem>
                                    <asp:ListItem Text="Fusil" Value="Fusil"></asp:ListItem>
                                    <asp:ListItem Text="Francotirador" Value="Francotirador"></asp:ListItem>
                                    <asp:ListItem Text="Pistola" Value="Pistola"></asp:ListItem>
                                    <asp:ListItem Text="Escopeta" Value="Escopeta"></asp:ListItem>
                                </asp:DropDownList>
                                <br /><br />

                                <label for="txtModelo">Modelo:</label>
                                <asp:TextBox ID="txtModelo" runat="server" MaxLength="50"
                                             CssClass="form-control bg-dark text-white border-secondary w-auto" />
                                <br /><br />

                                <label for="txtCalibre">Calibre:</label>
                                <asp:TextBox ID="txtCalibre" runat="server" MaxLength="20"
                                             CssClass="form-control bg-dark text-white border-secondary w-auto" />
                                <br /><br />

                                <label for="txtDescripcion">Descripción:</label>
                                <asp:TextBox ID="txtDescripcion" runat="server" TextMode="MultiLine" Rows="4" Columns="50"
                                             CssClass="form-control bg-dark text-white border-secondary" />
                                <br /><br />

                                <label for="txtStock">Stock Disponible:</label>
                                <asp:TextBox ID="txtStock" runat="server" TextMode="Number"
                                             CssClass="form-control bg-dark text-white border-secondary w-auto" />
                                <br /><br />

                                <!-- Botones con efecto luminoso y outline -->
                                <asp:Button ID="btnGuardarArma" runat="server" Text="Guardar" 
                                            OnClick="btnGuardarArma_Click"
                                            CssClass="btn btn-luminescent fw-bold" />
                                <asp:Button ID="btnCancelar" runat="server" Text="Cancelar" 
                                            OnClick="btnCancelar_Click"
                                            CssClass="btn btn-outline-warning ms-2 fw-bold" />
                            </div>
                        </div>
                    </asp:View>
                    <br /><br />
                </asp:MultiView>
                <br />
            </div>
        </div>

        <!-- Bootstrap 5 JS Bundle con Popper -->
        <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"
                integrity="sha384-ENjdO4Dr2bkBIFxQpeoC54W2LQzYt27NXFoaoApmYm81iuXoPkFOJwJ8ERdknLPM"
                crossorigin="anonymous"></script>
    </form>
</body>
</html>

