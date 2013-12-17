<%@ page contentType="text/html; charset=UTF-8"%>
<%@ taglib prefix="s" uri="/struts-tags"%>
<%@ taglib prefix="sj" uri="/struts-jquery-tags"%>
<%@ taglib prefix="sjg" uri="/struts-jquery-grid-tags"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!-- Situación del tipo de actor-->
<label style="color: red">Actor:</label>
<select id="opcionActor" onchange="cambiarPorTipoDeActor();">
	<option value="1">Recepcionista</option>
	<option value="2">Cliente</option>
</select>

<h2>Gestionar Reserva</h2>
<fieldset id="busquedaPorRecepcionista">
	<legend>Buscar reserva: </legend>
	<br />
	<div id="partSearched" style="display: none">
		<label>Num de Reserva: </label> <input type="text" value="1"
			disabled="disabled" />
	</div>
	<div id="partBuscarReserva">
		<label>Num de Reserva: </label> <input type="text" /> <label>Buscar
			por:</label> <select id="tipoPersonaBusqueda"
			onchange="cambiarPorTipoDeBusqueda();">
			<option value="persona">Persona</option>
			<option value="empresa">Empresa</option>
		</select><br />
		<!-- 	persona -->
		<div id="bpersona">
			<label class="bpersona">Nombre o apellido:</label>
			&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; <label class="bpersona">Número
				de documento:</label> <br />
		</div>
		<div id="bempresa" style="display: none">
			<!-- 	empresa -->
			<label class="bempresa">Razón social:</label>
			&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
			<label class="bempresa">Ruc:</label> <br />
		</div>
		<input type="text" id="nombres" /> <input type="text" /> <input
			type="button" value="Buscar" id="evaluarObjBuscado" /> <br />
	</div>
	<div id="clienteNoEncontrado" style="display: none">
		<label>No se encontraron resultados. </label> <br />
	</div>
	<br />
	<div id="clientesEncontrados" style="display: none">
		<label>Resultado de la busqueda:</label> <br />
		<table border="1" id="pool" tabindex='1'>
			<tr>
				<th>Sel.</th>
				<th width="130">Nº Reserva</th>
				<th width="130">Persona</th>
				<th width="130">Documento</th>
			</tr>
			<tr>
				<td><input type="radio" name="searched"
					class="searchedGestionar"
					title="Se carga los datos de serva de los clientes buscados" /></td>
				<td>0001</td>
				<td>Rosita Garcia Davila</td>
				<td>44852412</td>
			</tr>
			<tr>
				<td><input type="radio" name="searched"
					class="searchedGestionar"
					title="Se carga los datos de serva de los clientes buscados" /></td>
				<td>0006</td>
				<td>Roberto Garcia Santos</td>
				<td>44852412</td>
			</tr>
		</table>
	</div>
</fieldset>

<div id="gestionarReserva" style="display: none">
	<form>
		<fieldset>
			<legend>-</legend>
			<br />
			<table border="1" id="pool" tabindex='1'>
				<tr>
					<th>Foto</th>
					<th width="130">Ambiente</th>
					<th width="130">Inicio</th>
					<th width="130">Fin</th>
					<th>Estado</th>
					<th>Modif.</th>

				</tr>
				<tr>
					<td><img alt="hotel2" src="../resources/img/hotel1.jpg" width="50"
						height="35"
						title="Nota Interna: Al darle click muestra una imagen panoramica"></td>
					<td>C003/H301</td>
					<td>02/11/2013</td>
					<td>22/12/2013</td>
					<td><img src="../resources/img/online_rs.PNG" title="Activado"></td>
					<td><a href="javascript:void(0);"
						class="modificarReservaGestionarReserva"><img alt=""
							src="../resources/img/ico_update.gif"></a></td>
				</tr>
				<tr>
					<td><img alt="hotel2" src="../resources/img/hotel2.jpg" width="50"
						height="35"
						title="Nota Interna Al darle click muestra una imagen panoramica"></td>
					<td>C003/H301</td>
					<td>02/11/2013</td>
					<td>22/12/2013</td>
					<td><a href="javascript:void(0);"><img
							src="../resources/img/ico_delete.PNG" title="Activación pendiente"
							onclick="confirm('¿Está seguro que desea eliminar la reserva?');" /></a></td>
					<td><a href="javascript:void(0);"
						class="modificarReservaGestionarReserva"><img alt=""
							src="../resources/img/ico_update.gif"></a></td>

				</tr>
				<tr>
					<td><img alt="hotel2" src="../resources/img/hotel3.jpg" width="50"
						height="35"
						title="Nota Interna: Al darle click muestra una imagen panoramica"></td>
					<td>C003/H302</td>
					<td>02/11/2013</td>
					<td>22/12/2013</td>
					<td><img src="../resources/img/online_rs.PNG" title="Activado" /></td>
					<td><a href="javascript:void(0);"
						class="modificarReservaGestionarReserva"><img alt=""
							src="../resources/img/ico_update.gif"></a></td>
				</tr>
				<tr>
					<td><img alt="hotel2" src="../resources/img/hotel1.jpg" width="50"
						height="35"
						title="To ECU: Al darle click muestra una imagen panoramica"></td>
					<td>C003/H303</td>
					<td>02/11/2013</td>
					<td>22/12/2013</td>
					<td><a href="javascript:void(0);"><img
							src="../resources/img/ico_delete.PNG" title="Activación pendiente"
							onclick="confirm('¿Está seguro que desea eliminar la reserva?');" /></a></td>
					<td><a href="javascript:void(0);"
						class="modificarReservaGestionarReserva"><img alt=""
							src="../resources/img/ico_update.gif"></a></td>

				</tr>
			</table>
		</fieldset>
		<br /> <input type="button" value="+ Agregar nueva reserva"
			id="agregarNuevaReserva" />
		<!-- Regresar -->
		<s:url id="category" action="Reserva.action" var="reserva">
			<s:param name="gojsp"></s:param>
		</s:url>
		<input type="button" value="Regresar"
			onclick="location.href='<s:property value="#reserva" />'" />
	</form>
</div>
<!--  DIALOG -->
<div id="agregarReserva">
	<sj:tabbedpanel id="localtabs" cssClass="list" title="Reserva"
		label="Reserva">
		<sj:tab id="tab1" target="tone" label="Cabana" />
		<sj:tab id="tab2" target="ttwo" label="Centro de Convenciones" />
		<sj:tab id="tab3" target="tthree" label="Ambientes" />
		<!-- 		DIV-UNO -->
		<form name="formReserva">
			<div id="tone">

				<fieldset id="fsreservahotel">
					<legend>Reservar Habitacion</legend>
					<label>F. Inicio</label>
					<sj:datepicker size="18" id="idFechaInitHotel" timepicker="true"
						displayFormat="yy-mm-dd" showButtonPanel="true" showOn="button" />
					<label>F. Fin</label>
					<sj:datepicker size="18" id="idFechaEndHotel" timepicker="true"
						displayFormat="yy-mm-dd" showButtonPanel="true" showOn="button" />
					<label>Con Minibar: </label> <input type="checkbox" /> <input
						id="btnCargarCabanas" value="Buscar" type="button" /> <br /> <br />
					<div id="cargarCabanas" style="display: none">
						<table border="1">
							<caption>Seleccione la Cabana</caption>
							<tr>
								<th>Sel.</th>
								<th width="60">Foto</th>
								<th width="130">Número</th>
								<th width="130">Cant Habitaciones</th>
							</tr>
							<tr>
								<td><input type="radio" name="numcabana"
									class="linkCargarCabanas" /></td>
								<td><img alt="cabana1" src="../resources/img/cabana1.jpg"></td>
								<td>C001</td>
								<td>50</td>
							</tr>
							<tr>
								<td><input type="radio" name="numcabana"
									class="linkCargarCabanas" /></td>
								<td><img alt="cabana2" src="../resources/img/cabana2.jpg"></td>
								<td>C002</td>
								<td>49</td>
							</tr>
						</table>
					</div>
					<div id="cargarHabitaciones" style="display: none">
						<table border="1">
							<caption>Seleccione la habitacion</caption>
							<tr>
								<th>Sel.</th>
								<th width="60">Foto</th>
								<th width="130">#Cabana</th>
								<th width="130">#Habitaciones</th>
								<th>Precio</th>
							</tr>
							<tr>
								<td><input type="radio" name="numhabitacion"
									class="linkCargarAcompanantesGS" /></td>
								<td><img alt="hotel1" src="../resources/img/hotel1.jpg"></td>
								<td>C001</td>
								<td>3</td>
								<td>S/. 300</td>
							</tr>
							<tr>
								<td><input type="radio" name="numhabitacion"
									class="linkCargarAcompanantesGS" /></td>
								<td><img alt="hotel2" src="../resources/img/hotel2.jpg"></td>
								<td>C001</td>
								<td>4</td>
								<td>S/. 400</td>
							</tr>
							<tr>
								<td><input type="radio" name="numhabitacion"
									class="linkCargarAcompanantesGS" /></td>
								<td><img alt="hotel3" src="../resources/img/hotel3.jpg"></td>
								<td>C001</td>
								<td>4</td>
								<td>S/. 500</td>
							</tr>
						</table>
					</div>
					<div id="cargarAcompanantes" style="display: none">
						<br /> <br /> <label>Acompanante: </label> <br /> <br /> <label>Nombre
							completo: </label> <input type="text" size="40" />&nbsp;&nbsp;&nbsp;<input
							type="checkbox" name="habitacion" /><label>Incluirme</label> <br />
						<label>Tipo de Documento: </label> <select>
							<option>DNI</option>
							<option>Pasaporte</option>
						</select> <label>Num Documento: </label> <input type="text" /> <input
							type="button" value="Agregar" /> <br />
						<br />
						<table border="1">
							<tr>
								<th width="130">Nombre Completo</th>
								<th width="130">Documento</th>
								<th width="130">NumDocumento</th>
								<th>Mod.</th>
								<th>Elim.</th>
							</tr>
							<tr>
								<td>Gregorio Santos</td>
								<td>DNI</td>
								<td>44666444</td>
								<td><a href="javascript:void(0);"><img alt=""
										src="../resources/img/ico_update.gif"></a></td>
								<td><a href="javascript:void(0);"
									onclick="confirm('¿Está seguro que desea eliminar la reserva?');"><img
										alt="" src="../resources/img/ico_delete.PNG"></a></td>
							</tr>
							<tr>
								<td>Oliver Atom</td>
								<td>Pasaporte</td>
								<td>1044666444</td>
								<td><a href="javascript:void(0);"><img alt=""
										src="../resources/img/ico_update.gif"></a></td>
								<td><a href="javascript:void(0);"
									onclick="confirm('¿Está seguro que desea eliminar la reserva?');"><img
										alt="" src="../resources/img/ico_delete.PNG"></a></td>
							</tr>
							<tr>
								<td>...</td>
								<td>...</td>
								<td>...</td>
								<td><a href="javascript:void(0);"><img alt=""
										src="../resources/img/ico_update.gif"></a></td>
								<td><a href="javascript:void(0);"
									onclick="confirm('¿Está seguro que desea eliminar la reserva?');"><img
										alt="" src="../resources/img/ico_delete.PNG"></a></td>
							</tr>
						</table>
					</div>
					<br />
				</fieldset>
			</div>
		</form>
		<!-- 		DIV: NUMERO DOS -->
		<div id="ttwo">
			<form>
				<fieldset id="fsreservacentrorecreacional">
					<legend>Reservar Centro de Convenciones</legend>
					<label>Inicio</label>
					<sj:datepicker id="idFechaInitCentroRecreacional" timepicker="true"
						displayFormat="yy-mm-dd" showButtonPanel="true" showOn="button" />
					<label>Fin</label>
					<sj:datepicker id="idFechaEndCentroRecreacional" timepicker="true"
						displayFormat="yy-mm-dd" showButtonPanel="true" showOn="button" />
					<input type="button" value="Buscar" id="btnBuscarCabanasRecreacion" />
					<br /> <br />
					<div id="cargarCabanasRecreacion" style="display: none">
						<table border="1">
							<tr>
								<th>Sel.</th>
								<th width="60">Foto</th>
								<th width="130">Descripcion</th>
								<th width="130">Aforo</th>
								<th width="130">Cant. Asientos VIP</th>
								<th>Precio</th>
							</tr>
							<tr>
								<td><input type="radio" name="numhabitacion"
									class="linkCargarAcompanantesCabanaGS" /></td>
								<td><img alt="cabana1"
									src="../resources/img/centro-convenciones.jpg"></td>
								<td>Centro Recreacional</td>
								<td>150</td>
								<td>15</td>
								<td>S/. 1300</td>
							</tr>
						</table>
					</div>
					<div id="cargarAcompanantesRecreacion" style="display: none">
						<br /> <br /> <label>Acompanante: </label> <br /> <br /> <label>Nombre
							completo: </label> <input type="text" size="40" /> &nbsp;&nbsp;&nbsp;<input
							type="checkbox" /> <label>Incluir a Asiento VIP</label><br /> <label>Tipo
							de Documento: </label> <select>
							<option>DNI</option>
							<option>Pasaporte</option>
						</select> <label>Num Documento: </label> <input type="text" /> <input
							type="button" value="Agregar" /> <br />
						<br />
						<table border="1">
							<tr>
								<th width="130">Nombre Completo</th>
								<th width="130">Documento</th>
								<th width="130">NumDocumento</th>
								<th>Mod.</th>
								<th>Elim.</th>
							</tr>
							<tr>
								<td>Gregorio Santos</td>
								<td>DNI</td>
								<td>44666444</td>
								<td><img alt="" src="../resources/img/ico_update.gif"></td>
								<td><img alt="" src="../resources/img/ico_delete.PNG"
									onclick="confirm('¿Está seguro que desea eliminar la reserva?');"></td>
							</tr>
							<tr>
								<td>Oliver Atom</td>
								<td>Pasaporte</td>
								<td>1044666444</td>
								<td><img alt="" src="../resources/img/ico_update.gif"></td>
								<td><img alt="" src="../resources/img/ico_delete.PNG"
									onclick="confirm('¿Está seguro que desea eliminar la reserva?');"></td>
							</tr>
							<tr>
								<td>...</td>
								<td>...</td>
								<td>...</td>
								<td><img alt="" src="../resources/img/ico_update.gif"></td>
								<td><img alt="" src="../resources/img/ico_delete.PNG"></td>
							</tr>
						</table>
					</div>
				</fieldset>
			</form>
		</div>
		<!-- 		DIV -TRES				 -->
		<div id="tthree">
			<form>
				<p>
					<b>Aviso:</b> Para poner reservar un <b>ambiente</b> necesitas
					haber reservado una <b>cabana</b>
				</p>
				<fieldset id="fsambiente" tabindex="1">
					<legend>Reservar Ambiente</legend>
					<label>Inicio</label>
					<sj:datepicker id="idFechaInitAmbiente" timepicker="true"
						displayFormat="yy-mm-dd" showButtonPanel="true" showOn="button" />
					<label>Fin</label>
					<sj:datepicker id="idFechaEndAmbiente" timepicker="true"
						displayFormat="yy-mm-dd" showButtonPanel="true" showOn="button" />
					<input type="button" value="Buscar" id="btnBuscarCabanasAmbiente" />
					<br /> <br />
					<div id="cargarCabanasAmbiente" style="display: none">
						<table border="1">
							<tr>
								<th>Sel.</th>
								<th width="60">Foto</th>
								<th width="130">Número</th>
								<th width="130">Máximo de Personas</th>
								<th>Precio</th>
							</tr>
							<tr>
								<td><input type="radio" name="numhabitacion"
									class="linkCargarBtnGuardarCambiosGS" /></td>
								<td><img alt="cabana1" src="../resources/img/ambiente1.jpg"></td>
								<td>C001</td>
								<td>100</td>
								<td>S/. 1100</td>
							</tr>
							<tr>
								<td><input type="radio" name="numhabitacion"
									class="linkCargarBtnGuardarCambiosGS" /></td>
								<td><img alt="cabana2" src="../resources/img/ambiente2.jpg"></td>
								<td>C002</td>
								<td>120</td>
								<td>S/. 1200</td>
							</tr>
						</table>
					</div>
					<br />
				</fieldset>
			</form>
		</div>
		<input type="reset" value="Reservar" id="btnAgregarReservaGS"
			style="display: none" />
	</sj:tabbedpanel>
</div>
<!-- MODIFICAR -->
<div id="modificarReserva">
	<sj:tabbedpanel id="localtabsB" cssClass="list" title="Reserva"
		label="Reserva">
		<form name="formReservaB">
			<fieldset id="fsreservahotelB">
				<legend>Modificar Reserva</legend>
				<label>F. Inicio</label>
				<sj:datepicker size="18" id="idFechaInitHotelB" timepicker="true"
					displayFormat="yy-mm-dd" value="02/11/2013" showButtonPanel="true"
					showOn="button" />
				<label>F. Fin</label>
				<sj:datepicker size="18" id="idFechaEndHotelB" timepicker="true"
					displayFormat="yy-mm-dd" value="22/12/2013" showButtonPanel="true"
					showOn="button" />
				<label>Con Minibar: </label> <input type="checkbox" /> <input
					value="Buscar" type="button" /> <br /> <br />
				<div id="cargarCabanasB">
					<table border="1">
						<caption>Seleccione la Cabana</caption>
						<tr>
							<th>Sel.</th>
							<th width="60">Foto</th>
							<th width="130">Número</th>
							<th width="130">Cant Habitaciones</th>
						</tr>
						<tr>
							<td><input type="radio" name="numcabana" checked="checked" /></td>
							<td><img alt="cabana1" src="../resources/img/cabana1.jpg"
								width="50" height="50"></td>
							<td>C001</td>
							<td>50</td>
						</tr>
						<tr>
							<td><input type="radio" name="numcabana" /></td>
							<td><img alt="cabana2" src="../resources/img/cabana2.jpg"
								width="50" height="50"></td>
							<td>C002</td>
							<td>49</td>
						</tr>
					</table>
				</div>
				<div id="cargarHabitacionesB">
					<table border="1">
						<caption>Seleccione la habitacion</caption>
						<tr>
							<th>Sel.</th>
							<th width="60">Foto</th>
							<th width="130">#Cabana</th>
							<th width="130">#Habitaciones</th>
							<th>Precio</th>
						</tr>
						<tr>
							<td><input type="radio" name="numhabitacion" /></td>
							<td><img alt="hotel1" src="../resources/img/hotel1.jpg" width="50"
								height="50"></td>
							<td>C001</td>
							<td>3</td>
							<td>S/. 400</td>
						</tr>
						<tr>
							<td><input type="radio" name="numhabitacion"
								checked="checked" /></td>
							<td><img alt="hotel2" src="../resources/img/hotel2.jpg" width="50"
								height="50"></td>
							<td>C001</td>
							<td>4</td>
							<td>S/. 200</td>
						</tr>
						<tr>
							<td><input type="radio" name="numhabitacion" /></td>
							<td><img alt="hotel3" src="../resources/img/hotel3.jpg" width="50"
								height="50"></td>
							<td>C001</td>
							<td>4</td>
							<td>S/. 300</td>
						</tr>
					</table>
				</div>
				<div id="cargarAcompanantesB">
					<br /> <br /> <label>Acompañante: </label> <br /> <br /> <label>Nombre
						completo: </label> <input type="text" size="40" />&nbsp;&nbsp;&nbsp;<input
						type="checkbox" name="habitacion" /><label>Incluirme</label> <br />
					<label>Tipo de Documento: </label> <select>
						<option>DNI</option>
						<option>Pasaporte</option>
					</select> <label>Num Documento: </label> <input type="text" /> <input
						type="button" value="Agregar" /> <br /> <br />
					<table border="1">
						<tr>
							<th width="130">Nombre Completo</th>
							<th width="130">Documento</th>
							<th width="130">NumDocumento</th>
							<th>Mod.</th>
							<th>Elim.</th>
						</tr>
						<tr>
							<td>Gregorio Santos</td>
							<td>DNI</td>
							<td>44666444</td>
							<td><a href="javascript:void(0);"><img alt=""
									src="../resources/img/ico_update.gif"></a></td>
							<td><a href="javascript:void(0);"><img alt=""
									src="../resources/img/ico_delete.PNG"></a></td>
						</tr>
						<tr>
							<td>Oliver Atom</td>
							<td>Pasaporte</td>
							<td>1044666444</td>
							<td><a href="javascript:void(0);"><img alt=""
									src="../resources/img/ico_update.gif"></a></td>
							<td><a href="javascript:void(0);"><img alt=""
									src="../resources/img/ico_delete.PNG"></a></td>
						</tr>
						<tr>
							<td>...</td>
							<td>...</td>
							<td>...</td>
							<td><a href="javascript:void(0);"><img alt=""
									src="../resources/img/ico_update.gif"></a></td>
							<td><a href="javascript:void(0);"><img alt=""
									src="../resources/img/ico_delete.PNG"></a></td>
						</tr>
					</table>
				</div>
				<br />
			</fieldset>
		</form>
		<input type="reset" value="Grabar" id="btnGuardarCambiosB" />
	</sj:tabbedpanel>
</div>
