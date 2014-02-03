<%@ page contentType="text/html; charset=UTF-8"%>
<%@ taglib prefix="s" uri="/struts-tags"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<table class="table table-hover">
	<thead>
		<tr>
			<th>Select</th>
			<th>#Habitación</th>
			<th>Fecha Emitida</th>
		</tr>
	</thead>
	<tbody>
		<tr class="success">
			<td><a href="goHabToLimpiar.action">this</a></td>
			<td>#H301</td>
			<td>20/10/2013</td>
		</tr>
		<tr class="success">
			<td><a href="goHabToLimpiar.action">this</a></td>
			<td>#H301</td>
			<td>20/10/2013</td>
		</tr>
		<tr class="warning">
			<td><a href="goHabToLimpiar.action">this</a></td>
			<td>#H301</td>
			<td>20/10/2013</td>
		</tr>
	</tbody>
</table>
<ul class="pager">
	<li class="previous disabled"><a href="#">&larr; Older</a></li>
	<li class="next"><a href="#">Newer &rarr;</a></li>
</ul>
<div class="row">
	<div class="col-md-8 col-md-offset-4 modal-footer">
		<button type="button" class="btn btn-default">Cancelar</button>
	</div>
</div>