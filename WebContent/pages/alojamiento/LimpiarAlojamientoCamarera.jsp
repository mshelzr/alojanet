<%@ page contentType="text/html; charset=UTF-8"%>
<%@ taglib prefix="s" uri="/struts-tags"%>
<%@ taglib prefix="sj" uri="/struts-jquery-tags"%>
<%@ taglib prefix="sjg" uri="/struts-jquery-grid-tags"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<h3>Informe de Limpieza de alojamiento</h3>

<form>
	<br />
	<fieldset>
		<legend>Informe de habitaciones por limpiar : </legend>
		<br/>
		<label>Número hab: </label><input type="text" /><input type="button" value="Buscar" /><br/><br/>
		Resultado de busqueda:	
		<table border="1">
			<tr>
				<th>Cargar Hab</th>
				<th width="120">#Habitación</th>
				<th>Fecha Emitida</th>
			</tr>
			<tr>
				<td><input type="radio" name="radio" checked="checked"/></td>
				<td align="center">#H301</td>
				<td>20/10/2013</td>
			</tr>
			<tr>
				<td><input type="radio" name="radio" /></td>
				<td align="center">#H302</td>
				<td>20/10/2013</td>
			</tr>
			<tr>
				<td><input type="radio" name="radio" /></td>
				<td align="center">#H303</td>		
				<td>20/10/2013</td>
			</tr>
		</table>
	</fieldset>
	<br />
	<fieldset>
		<legend>Datos de la Habitacion</legend>
		<label>Foto: </label><img alt="hotel3" src="../resources/img/hotel3.jpg"><br />
		<label>#Cabaña:</label><input type="text" value="032"
			disabled="disabled" /><br><label>#Habitacion:</label><input type="text" value="#H301"
			disabled="disabled" />
			<br> <label>#Cuartos:</label><input
			type="text" value="4" disabled="disabled" /><br>
	</fieldset>
	<br />
	<fieldset>
		<legend>
			<s:property value="message" />
		</legend><br /> 
		<fieldset>
		<legend>Reporte de Bar:</legend>
		<br />
			<table border="1">
				<caption>Servicios que vienen con la habitación por defecto</caption>
				<tr>
					<th>Tipo de bebida</th>
					<th>Marca</th>
					<th>Cantidad</th>
				</tr>
				<tr>
					<td>Vino</td>
					<td>Cvne</td>
					<td>1</td>
				</tr>
				<tr>
					<td>Toalla</td>
					<td>Seda</td>
					<td>4</td>
				</tr>
				<tr>
					<td>Cerveza</td>
					<td>Pilsen</td>
					<td>3</td>
				</tr>
			</table><br/><br/>
			<b><label>Consumo: </label></b><br/>			
			<label>Tipo de bebida</label>
		<select>
			<option>Vino</option>
			<option>Champan</option>
			<option>Cerveza</option>
		</select>
		<label>Marca</label>		
		<select>
			<option>Cristal</option>
			<option>Pilsen</option>
		</select>
		<label>Cantidad</label><input type="text" value="4" size="3" /><input type="button" value="Agregar" />
		<br /> 
		<br/>
		<table border="1">
				<caption>Bebidas consumidas</caption>
				<tr>
					<th>Tipo de bebida</th>
					<th>Marca</th>
					<th>Cantidad</th>
				</tr>
				<tr>
					<td>Vino</td>
					<td>Cvne</td>
					<td>1</td>
				</tr>
				<tr>
					<td>Cerveza</td>
					<td>Cristal</td>
					<td>4</td>
				</tr>
				<tr>
					<td>Cerveza</td>
					<td>Pilsen</td>
					<td>3</td>
				</tr>
			</table>
		</fieldset>
		<br /> 
		<label>¿Imperfecciones?</label><input type="checkbox" /><br />
		<br> <label>Observacion: </label><br />
		<textarea rows="5" cols="45">Se encontró un ebrio</textarea>
		<br />
	</fieldset>

	<input type="button" value="Guardar" /> <input type="button"
		value="Cancelar" /> <br />
</form>