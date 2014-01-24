<%@ page contentType="text/html; charset=UTF-8"%>
<%@ taglib prefix="s" uri="/struts-tags"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<legend class="text-primary">
	Información de la Habitación <span class="glyphicon glyphicon-list-alt"></span>
</legend>
<div class="media">
	<a class="pull-left" href="#"> <img data-src="holder.js/300x200"
		alt="300x200" style="width: 300px; height: 200px;"
		src="data:image/png;base64,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">
	</a>
	<div class="media-body">
		<h4 class="media-heading">Cabaña:</h4>
		C001
		<h4 class="media-heading">Habitación:</h4>
		H001
		<h4 class="media-heading">Descripción:</h4>
		n Cras sit amet nibh libero, sollicitudin commodo. Cras purus odio,
		vestibulum in vulputate at, tempus viverra turpis. Fusce condimentum
		nunc ac nisi vulputate fringilla. Donec lacinia congue felis in
		faucibus.
	</div>
</div>
<br />
<table class="table table-hover">
	<legend class="text-primary">
		Reporte de consumo del Minibar <span class="glyphicon glyphicon-glass"></span>
	</legend>
	<thead>
		<tr>
			<th>Tipo de bebida</th>
			<th>Marca</th>
			<th>Cantidad <br />por defecto
			</th>
			<th>Cantidad <br />consumido
			</th>
			<th></th>
		</tr>
	</thead>
	<tbody>
		<tr>
			<td>Vino</td>
			<td>Cvne</td>
			<td>12</td>
			<td><input id="spinner1" name="value" size="3"></td>
			<td><a id="setvalue1" class="btn btn-default btn-sm">Todo</span></a></td>
		</tr>
		<tr>
			<td>Toalla</td>
			<td>Seda</td>
			<td>8</td>
			<td><input id="spinner2" name="value" size="3"></td>
			<td><a id="setvalue2" class="btn btn-default btn-sm">Todo</span></a></td>
		</tr>
		<tr>
			<td>Cerveza</td>
			<td>Pilsen</td>
			<td>8</td>
			<td><input id="spinner3" name="value" size="3"></td>
			<td><a id="setvalue3" class="btn btn-default btn-sm">Todo</span></a></td>
		</tr>
	</tbody>
</table>
<ul class="pager">
	<li class="previous disabled"><a href="#">&larr; Older</a></li>
	<li class="next"><a href="#">Newer &rarr;</a></li>
</ul>
<legend class="text-primary">
	Inperfecciones <span class="glyphicon glyphicon-wrench"></span>
</legend>
<div class="checkbox">
	<label> <input type="checkbox">
		<h4>¿Hay algo anormal en la habitación?</h4>
	</label>
</div>
<textarea class="form-control" rows="3"></textarea>
<div class="row">
	<div class="col-md-8 col-md-offset-4 modal-footer">
		<button type="button" class="btn btn-primary">Guardar</button>
		<button type="button" class="btn btn-default">Cancelar</button>
	</div>
</div>