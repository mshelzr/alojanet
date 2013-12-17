<%@ page contentType="text/html; charset=UTF-8"%>
<%@ taglib prefix="s" uri="/struts-tags"%>
<%@ taglib prefix="sj" uri="/struts-jquery-tags"%>
<%@ taglib prefix="sjg" uri="/struts-jquery-grid-tags"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<h3>Reporte general de Ama de Llaves</h3>
<form>
<fieldset>
<legend><s:property value="message" /></legend>
<br/>
<table border="1">
	<tr>
		<th width="90">#Departamento</th>
		<th width="90">Consumo de Bar</th>
		<th width="90">Daños</th>
		<th width="140">Camarera</th>
	</tr>
	<tr>
		<td>H301</td>
		<td align="center">Sí<a href="#" title="Información del consumo"><img align="right" alt="buscar" src="../resources/img/filter.png"/></a></td>
		<td align="center">No</td>
		<td>Carmen Pan Duro</td>
	</tr>
	<tr>
		<td>H302</td>
		<td align="center">No</td>
		<td align="center">Sí<a href="#" title="Información de la reparación"><img align="right" alt="buscar" src="../resources/img/filter.png"/></a></td>
		<td>Rocio Diaz</td>
	</tr>
	<tr>
		<td>H303</td>
		<td align="center">No</td>
		<td align="center">No</td>
		<td>Ana Mamany</td>
	</tr>
</table>
<br/>
<label>Informe general: </label><br/>
<textarea rows="3" cols="60">Se inundo el pasillo de la cabaña 1 y 2.	
</textarea>
<br/>
<br/>
</fieldset>
<input type="button" value="Grabar"/>
<input type="button" value="Cancelar"/>
</form>