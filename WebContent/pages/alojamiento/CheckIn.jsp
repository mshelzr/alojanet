<%@ page contentType="text/html; charset=UTF-8"%>
<%@ taglib prefix="s" uri="/struts-tags"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jstl/fmt_rt"%>
<jsp:useBean id="fechita" class="java.util.Date" />

<input type="hidden" id="paginaActual" value="checkin" />
<input type="hidden" id="idDetalleReserva" />
<input type="hidden" id="idPersona" />
<input type="hidden" id="tipoAmbiente" />
<input type="hidden" id="dataScope" />

<div class="page-header-customed">
	<h1 id="type">
		Activación de la reserva <small>Check-in</small>
	</h1>
</div>
<form>
<div class="row panel-busqueda">
<br />
	<legend class="text-primary">
		Buscar reserva <span class="glyphicon glyphicon-search"></span>
	</legend>
	<div class="col-xs-3">
		<input placeholder="Nombres" id="nombres-search"
			class="form-control input-sm" type="text">
	</div>
	<div class="col-xs-2">
		<input placeholder="A. Paterno" type="text"
			class="form-control input-sm" id="apePaterno-search" size="6">
	</div>
	<div class="col-xs-2">
		<input placeholder="A. Materno" type="text"
			class="form-control input-sm" id="apeMaterno-search">
	</div>
	<div class="col-xs-2">
		<input placeholder="Dni, ruc, ..." type="text"
			class="form-control input-sm" id="numero-search">
	</div>
	<button type="button" class="btn btn-primary btn-sm"
		id="btnBusquedaReserva">
		Buscar <span class="glyphicon glyphicon-search"></span>
	</button>
</div>
</form>

<!-- Modal -->
<div class="modal fade" id="modalSearched" tabindex="-1" role="dialog"
	aria-labelledby="myModalLabel" aria-hidden="true">
	<div class="modal-header">
		<button type="button" class="close" data-dismiss="modal"
			aria-hidden="true">&times;</button>
		<h4 class="modal-title">Resultado de busqueda</h4>
	</div>
	<div class="modal-body">

		<table class="table table-hover">
			<thead>
				<tr>
					<th>Sel.</th>
					<th>Nº Reserva</th>
					<th>Persona</th>
					<th>Documento</th>
				</tr>
			</thead>
			<tbody id="rowReservaSearched">

			</tbody>
		</table>
	</div>
	<div class="modal-footer">
		<button type="button" class="btn btn-default" data-dismiss="modal">Cerrar</button>
	</div>
</div>
<!-- / FIN del modal -->

<div class="panel-reserva-encontrada hidden">
	<!-- hidden -->
	<br />
	<div class="row">
		<div class="col-xs-4">
			<div class="input-group input-group-lg">
				<span class="input-group-addon">Nº Reserva</span> <input type="text"
					class="form-control" id="lblIdReserva" disabled />
			</div>
			<!-- /input-group -->
		</div>
		<!-- /.col-lg- -->
	</div>
	<br />
	<legend class="text-primary">
		Datos de la persona <span class="glyphicon glyphicon-user"></span>
	</legend>
	<dl class="dl-horizontal">
		<dt>Tipo de persona</dt>
		<dd>Natural</dd>
		<dt>Nombres</dt>
		<dd id="lblNombres"></dd>
		<dt>Apellidos</dt>
		<dd id="lblApellidos"></dd>
		<dt>DNI</dt>
		<dd id="lblDni"></dd>
		<dd>
			<a href="javascript:void(0);" class="btnActivarTextoSobrante">Ver
				más <b class="caret"></b>
			</a>
		</dd>
		<div class="hidden" id="textoSobrante">
			<dt>Teléfono</dt>
			<dd id="lblTelf"></dd>
			<dt>Email</dt>
			<dd id="lblEmail"></dd>
		</div>
	</dl>
	<legend class="text-primary">
		Datos de la reserva <span class="glyphicon glyphicon-lock"></span>
	</legend>
	<form action="modificarEstadoCheckIn" id="formModificarEstadoCheckIn">
		<table class="table table-hover">
			<thead>
				<tr>
					<th>Nº Ambiente</th>
					<th><span class="glyphicon glyphicon-user"></span> Actual</th>
					<th>F. Inicio</th>
					<th>F. Fin</th>
					<th>Selc.</th>
				</tr>
			</thead>
			<tbody id="rowDetalleReserva">

			</tbody>
		</table>
	</form>
	<div class="row">
		<div class="col-md-8 col-md-offset-4 modal-footer">
			<button type="button" class="btn btn-default" onclick="javascript:history.go(-1);" id="btnCancelar">Cancelar</button>
		</div>
	</div>
</div>

<div id="modalResultado" class="modal fade" tabindex="-1"
	style="display: none;">
	<div class="modal-header">
		<button type="button" class="close" data-dismiss="modal"
			aria-hidden="true">×</button>
		<h4 class="modal-title">Operación completa</h4>
	</div>
	<div class="modal-body">
		<div class="alert alert-success" id="remplazoSuccessResult">
			<strong>Success!</strong> Se operación se realizó sin problemas.
		</div>
		<div class="alert alert-danger hidden" id="remplazoDangerResult">
			<strong>Oh snap!</strong> Debido a Pellentesque in ipsum id orci
			porta dapibus. Donec sollicitudin molestie malesuada.
		</div>
	</div>
	<div class="modal-footer">
		<div class="row">
			<a type="button" class="btn btn-danger" href="checkin.action">Finalizar</a>
		</div>
	</div>
</div>