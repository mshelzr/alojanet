<%@ page contentType="text/html; charset=UTF-8"%>
<%@ taglib prefix="s" uri="/struts-tags"%>
<%@ taglib prefix="sj" uri="/struts-jquery-tags"%>
<%@ taglib prefix="sjg" uri="/struts-jquery-grid-tags"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jstl/fmt_rt"%>
<jsp:useBean id="fechita" class="java.util.Date" />
<h3>Formulario de Reserva</h3>
<br />
<table border="1" id="pool" tabindex='1' style="display: none">
	<tr>
		<th width="130">Detalle Reserva</th>
		<th width="130">Inicio</th>
		<th width="130">Fin</th>
		<th>Modif.</th>
		<th>Elim.</th>

	</tr>
	<tr>
		<td>C003/H301</td>
		<td>02/11/2013</td>
		<td>02/12/2013</td>
		<td><a href="javascript:void(0);"><img alt=""
				src="../resources/img/ico_update.gif"></a></td>
		<td><a href="javascript:void(0);"><img alt=""
				src="../resources/img/ico_delete.PNG"
				onclick="confirm('¿Está seguro que desea eliminar la reserva?');"></a></td>
	</tr>
</table>
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
					type="button" value="Buscar" id="btnCargarCabanas" /> <br /> <br />
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
								class="linkCargarAcompanantes" /></td>
							<td><img alt="hotel1" src="../resources/img/hotel1.jpg"></td>
							<td>C001</td>
							<td>3</td>
							<td>S/. 300</td>
						</tr>
						<tr>
							<td><input type="radio" name="numhabitacion"
								class="linkCargarAcompanantes" /></td>
							<td><img alt="hotel2" src="../resources/img/hotel2.jpg"></td>
							<td>C001</td>
							<td>4</td>
							<td>S/. 400</td>
						</tr>
						<tr>
							<td><input type="radio" name="numhabitacion"
								class="linkCargarAcompanantes" /></td>
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
								class="linkCargarAcompanantesCabana" /></td>
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
				<b>Aviso:</b> Para poner reservar un <b>ambiente</b> necesitas haber
				reservado una <b>cabana</b>
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
								class="linkCargarBtnGuardarCambios" /></td>
							<td><img alt="cabana1" src="../resources/img/ambiente1.jpg"></td>
							<td>C001</td>
							<td>100</td>
							<td>S/. 1100</td>
						</tr>
						<tr>
							<td><input type="radio" name="numhabitacion"
								class="linkCargarBtnGuardarCambios" /></td>
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
	<input type="reset" value="Reservar" id="btnGuardarCambios"
		style="display: none" />
</sj:tabbedpanel>
<div id="question">
	<input type="button" value="¿Es tu primera vez reservando?"
		id="btnQuestion" /> / <input type="button" value="¿Ya eres cliente?"
		id="btnLogueo" />
</div>
<div id="dialogLogueo" title="Indentificación">
	<form>
		<label>Usuario: </label>
		<input type="text" id="user"/> <br /> 
		<label>Contrasena</label>
		<input type="text" id="pwd" />
		<br /> <input type="button" value="Entrar" id="btnGeneralDeReservaLogin" /> 
		<input type="button" value="Olvidé contraseña" />
	</form>
</div>
<div id="alojantedata">
	<h3>Registro</h3>

	<fieldset id="datosPersonales">
		<legend>
			<s:property value="message" />
		</legend>
		<form>
			<table>
				<tr>
					<td>Tipo de persona:</td>
					<td><select id="myself">
							<option value="pnatural">Natural</option>
							<option value="pjuridica">Juridica</option>
					</select></td>
				</tr>
				<tr class="pjuridica" style="display: none">
					<td><br /></td>
				</tr>
				<tr class="pjuridica" style="display: none">
					<td colspan="4">Datos de la empresa</td>
				</tr>
				<tr class="pjuridica" style="display: none">
					<td>Empresa</td>
					<td><input type="text" name="nombreEmpresa"></td>
				</tr>
				<tr class="pjuridica" style="display: none">
					<td>Ruc</td>
					<td><input type="text" name="ruc"></td>
					<td>Confirmar Ruc</td>
					<td><input type="text" name="confRuc"></td>
				</tr>
				<tr>
					<td><br /></td>
				</tr>
				<tr class="pjuridica" style="display: none">
					<td colspan="4">Datos del representante</td>
				</tr>
				<tr>
					<td>Nombre</td>
					<td><input type="text" name="nombre"></td>
					<td>Apellidos</td>
					<td><input type="text" name="apellidos" /></td>
				</tr>
				<tr>
					<td>Tipo de Documento</td>
					<td><select>
							<option>DNI</option>
							<option>PASAPORTE</option>
					</select></td>
				</tr>
				<tr>
					<td>Num Documento</td>
					<td><input type="text" name="numDocumento"></td>
					<td>Confirmar Num Documento</td>
					<td><input type="text" name="conifNumDocumento"></td>
				</tr>
				<tr>
					<td>Dirección</td>
					<td><input type="text" name="direccion" /></td>
					<td>Teléfono</td>
					<td><input type="text" name="telefono"></td>
				</tr>
				<tr>
					<td>Email</td>
					<td><input type="text" name="email"></td>
					<td>Confirmar Email</td>
					<td><input type="text" name="confemail"></td>
				</tr>
				<tr>
					<td>Fecha</td>
					<td><input type="text" disabled="disabled"
						value="<fmt:formatDate value="${fechita}" type="date" pattern="dd/MM/yyyy" />"
						name="fecha"></td>
				</tr>
			</table>
		</form>
	</fieldset>
	<input type="button" value="Registrarse" id="Registrar"
		class="btnGeneralDeReserva" /> <br />
</div>
<!--  fin data alojantedata -->
