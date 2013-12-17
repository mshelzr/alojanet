<%@ page contentType="text/html; charset=UTF-8"%>
<%@ taglib prefix="s" uri="/struts-tags"%>
<%@ taglib prefix="sj" uri="/struts-jquery-tags"%>
<%@ taglib prefix="sjg" uri="/struts-jquery-grid-tags"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jstl/fmt_rt"%>
<jsp:useBean id="fechita" class="java.util.Date" />
<h3>Formulario de Salida</h3>
<br />
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
				<label>No se encontraron resultados.</label> <br />
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
				<br /> <label>Ambiente reservada</label> <br />
				<table border="1" id="pool" tabindex='1'>
					<tr>
						<th>Select</th>
						<th width="130">Ambiente</th>
						<th width="130">F. Inicio</th>
						<th width="130">F. Fin</th>
					</tr>
					<tr>
						<td><input type="radio" name="ambiente"
							title="NT: Se carga la lista de acompañantes" /></td>
						<td>C003/H301</td>
						<td>02/11/2013</td>
						<td>02/12/2013</td>
					</tr>
				</table>
				<br /> <br />
				<table border="1">
					<caption>Acompañantes de la habitación</caption>
					<tr>
						<th>Acompañante</th>
						<th>Servicio</th>
						<th>Monto</th>
						<th>Lugar</th>
						<th>¿Entregó tarjeta?</th>
					</tr>
					<tr>
						<td>Gregorio Sanchez</td>
						<td>Vino</td>
						<td>40.0</td>
						<td>Centro de Convenciones</td>
						<td><input type="checkbox" disabled="disabled" /></td>
					</tr>
					<tr>
						<td>Bill Gates</td>
						<td>Champan</td>
						<td>50.0</td>
						<td>Centro de Recreacion</td>
						<td><input type="checkbox" checked="checked"
							disabled="disabled" /></td>
					</tr>
					<tr>
						<td>Steven Jobs</td>
						<td>Menu [Aji de gallina]</td>
						<td>20.0</td>
						<td>Restaurante</td>
						<td><input type="checkbox" checked="checked"
							disabled="disabled" /></td>
					</tr>
				</table>
				<br /> <br /> <label>Total a pagar por los servicio S/.</label> <input
					type="text" value="110" disabled="disabled" /> <br />
			</fieldset>
		</div>
		<br /> <input type="button" value="Grabar" /> <input type="button"
			value="Cancelar" />
	</form>
</fieldset>