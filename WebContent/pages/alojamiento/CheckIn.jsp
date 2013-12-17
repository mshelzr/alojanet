<%@ page contentType="text/html; charset=UTF-8"%>
<%@ taglib prefix="s" uri="/struts-tags"%>
<%@ taglib prefix="sj" uri="/struts-jquery-tags"%>
<%@ taglib prefix="sjg" uri="/struts-jquery-grid-tags"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jstl/fmt_rt"%>
<jsp:useBean id="fechita" class="java.util.Date" />
<h3>Formulario de Entrada</h3>
<br />
<s:url id="category" action="Reserva.action" var="reserva">
	<s:param name="gojsp">reserva</s:param>
</s:url>
<fieldset>
	<legend>
		<s:property value="message" />
	</legend>
	<form>
		<br />
		<fieldset>
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
				<label>No se encontraron resultados. Tiene la opción de: </label><input
					type="button" value="Hacer nueva Reserva"
					onclick="location.href='<s:property value="#reserva" />'"
					width="30" height="30" /> <br />
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
						<td><input type="radio" name="searched" class="searched"
							title="Se carga los datos de serva del buscados" /></td>
						<td>0001</td>
						<td>Rosita Garcia Davila</td>
						<td>44852412</td>
					</tr>
					<tr>
						<td><input type="radio" name="searched" class="searched"
							title="Se carga los datos de serva del buscados" /></td>
						<td>0006</td>
						<td>Roberto Garcia Santos</td>
						<td>44852412</td>
					</tr>
				</table>
			</div>
		</fieldset>
		<br />
		<div id="reservasDelClienteBuscado" style="display: none">
			<fieldset id="datosPersonales" disabled="disabled">
				<legend>Datos del reservante</legend>
				<table>
					<tr>
						<td>Tipo de persona:</td>
						<td><select id="myself">
								<option value="pjuridica">Natural</option>
								<option value="pnatural">Juridica</option>
						</select></td>
					</tr>
					<tr>
						<td>Nombre</td>
						<td><input type="text" name="nombre" value="Rosita"></td>
						<td>Apellidos</td>
						<td><input type="text" name="apellidos" value="Garcia Davila" /></td>
					</tr>
					<tr>
						<td>DNI</td>
						<td><input type="text" name="dni" value="44852412" /></td>
						<td>Teléfono</td>
						<td><input type="text" name="telefono" value="55555555"></td>
					</tr>
					<tr>
						<td>Direccion</td>
						<td><input type="text" name="Direccion" value="Su casa"></td>
						<td>F. Registrada</td>
						<td><input type="text" disabled="disabled"
							value="<fmt:formatDate value="${fechita}" type="date" pattern="dd/MM/yyyy" />"
							name="fecha"></td>
					</tr>
				</table>
			</fieldset>
			<br />
			<fieldset>
				<legend>Datos de la reserva</legend>
				<br /> <label>Lista de Ambientes reservadas</label> <br />
				<table border="1" id="pool" tabindex='1'>
					<tr>
						<th>Select</th>
						<th width="130">Ambiente</th>
						<th width="130">F.Inicio</th>
						<th width="130">F.Fin</th>
						<th>Modif.</th>
						<th>Elim.</th>
					</tr>
					<tr>
						<td><input type="radio" name="linkListaAcomIn"
							onclick="$('#acompañantesCheckIn').show('slow');"
							class="linkListaAcomIn"
							title="Listar acompañantes del seleccionado" /></td>
						<td>C003/H301</td>
						<td>02/11/2013</td>
						<td>02/12/2013</td>
						<td><a href="javascript:void(0);"><img alt=""
								src="../resources/img/ico_update.gif"
								class="modificarReservaGestionarReserva"></a></td>
						<td><a href="javascript:void(0);"><img alt=""
								src="../resources/img/ico_delete.PNG"
								onclick="confirm('¿Está seguro que desea eliminar la reserva?');"></a></td>
					</tr>
					<tr>
						<td><input type="radio" name="linkListaAcomIn"
							onclick="$('#acompañantesCheckIn').show('slow');"
							class="linkListaAcomIn"
							title="Listar acompañantes del seleccionado" /></td>
						<td>Canchita Futbol</td>
						<td>02/11/2013</td>
						<td>02/12/2013</td>
						<td><a href="javascript:void(0);"><img alt=""
								src="../resources/img/ico_update.gif"
								class="modificarReservaGestionarReserva"></a></td>
						<td><a href="javascript:void(0);"><img alt=""
								src="../resources/img/ico_delete.PNG"
								onclick="confirm('¿Está seguro que desea eliminar la reserva?');"></a></td>
					</tr>
				</table>
				<br />
				<br /> <label>Lista de Acompañante por Ambiente</label>
				<div id="acompañantesCheckIn" style="display: none">
					<table border="1" id="pool" tabindex='1'>
						<tr>
							<th width="130">Acompañante</th>
							<th width="130">Documento</th>
							<th width="130">#Tarjeta</th>
							<th>Modif.</th>
							<th>Elim.</th>
						</tr>
						<tr>
							<td>Pepito</td>
							<td>DNI 49555555</td>
							<td><input type="text" value="T051" /></td>
							<td><img alt="" src="../resources/img/ico_update.gif"></td>
							<td><a href="javascript:void(0);"><img alt=""
									src="../resources/img/ico_delete.PNG"
									onclick="confirm('¿Está seguro que desea eliminar la reserva?');"></a></td>
						</tr>
						<tr>
							<td>Luisito</td>
							<td>PASAP. 555555n</td>
							<td><input type="text" /></td>
							<td><img alt="" src="../resources/img/ico_update.gif"></td>
							<td><a href="javascript:void(0);"><img alt=""
									src="../resources/img/ico_delete.PNG"
									onclick="confirm('¿Está seguro que desea eliminar la reserva?');"></a></td>
						</tr>
					</table>
				</div>
			</fieldset>
		</div>
		<br /> <input type="button" value="Activar Reserva" /> <input
			type="button" value="Cancelar" />
	</form>
</fieldset>
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
				<div id="cargarCabañasB">
					<table border="1">
						<caption>Seleccione la Cabaña</caption>
						<tr>
							<th>Sel.</th>
							<th width="60">Foto</th>
							<th width="130">Número</th>
							<th width="130">Cant Habitaciones</th>
						</tr>
						<tr>
							<td><input type="radio" name="numcabaña" checked="checked" /></td>
							<td><img alt="cabaña1" src="../resources/img/cabana1.jpg"
								width="50" height="50"></td>
							<td>C001</td>
							<td>50</td>
						</tr>
						<tr>
							<td><input type="radio" name="numcabaña" /></td>
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
							<th width="130">#Cabaña</th>
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
				<div id="cargarAcompañantesB">
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