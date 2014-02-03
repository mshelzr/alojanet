<%@ page contentType="text/html; charset=UTF-8"%>
<%@ taglib prefix="s" uri="/struts-tags"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jstl/fmt_rt"%>
<jsp:useBean id="fechita" class="java.util.Date" />

<input type="hidden" id="paginaActual" value="checkout" />
<input type="hidden" id="idDetalleReserva" />
<input type="hidden" id="idPersona" />

<div class="page-header-customed">
	<h1 id="type">
		Realizar <small>Check-out</small>
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
		<!--<button type="button" class="btn btn-primary">Save changes</button> -->
	</div>
</div>
<!-- /.modal -->
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
		Datos de la persona<span class="glyphicon glyphicon-user"></span>
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
	<form action="modificarEstadoCheckOut" id="formModificarEstadoCheckOut">
		<table class="table table-hover">
			<thead>
				<tr>
					<th>Nº Ambiente</th>
					<th><span class="glyphicon glyphicon-user"></span> Actual</th>
					<th>F. Inicio</th>
					<th>F. Fin</th>
					<th>Cons.</th>
				</tr>
			</thead>
			<tbody id="rowDetalleReserva">

			</tbody>
		</table>
	</form>
	<!-- Modal de detalle reserva-->
	<div class="modal fade" id="modalDetalleReserva" tabindex="1"
		role="dialog" data-width="760" aria-labelledby="myModalLabel"
		aria-hidden="true">
		<!-- 				tamanoModalAcompCheckin -->
		<div class="modal-header">
			<button type="button" class="close" data-dismiss="modal"
				aria-hidden="true">&times;</button>
			<h4 class="modal-title">Detalle de la reserva</h4>
		</div>
		<div class="modal-body">
			<!-- cuerpo del modal -->
			<table>
				<tr>
					<td>
						<div class="input-group date " id="e" data-date="16-01-2014"
							data-date-format="dd-mm-yyyy">
							<span class="input-group-addon">Desde</span> <input
								class="form-control input-sm" id="lblDesde" type="text" disabled />
							<span class="input-group-addon"><i
								class="glyphicon glyphicon-calendar"></i></span>
						</div>
					</td>
					<td>
						<div class="input-group date " id="e2" data-date="16-02-2014"
							data-date-format="dd-mm-yyyy">
							<span class="input-group-addon">Hasta</span> <input
								class="form-control input-sm" type="text" id="lblHasta" disabled>
							<span class="input-group-addon"><i
								class="glyphicon glyphicon-calendar"></i></span>
						</div>
					</td>
				</tr>
			</table>
			<br />

			<legend class="text-primary">
				Información de la Habitación <span
					class="glyphicon glyphicon-list-alt"></span>
			</legend>
			<div class="media">
				<a class="pull-left" href="#"> <img data-src="holder.js/300x200"
					alt="300x200" style="width: 300px; height: 200px;"
					src="data:image/png;base64,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">
				</a>
				<div class="media-body">
					<h4 class="media-heading">Habitación:</h4>
					<p id="lblHab"></p>
					<h4 class="media-heading">
						Scope <span class="glyphicon glyphicon-user"></span>:
					</h4>
					<p id="lblCapacidad"></p>
					<h4 class="media-heading">Descripción:</h4>
					<p id="lblDescripcion"></p>
				</div>
			</div>
			<br />
			<br />
			<table class="table table-hover">
				<legend class="text-primary">
					Acompañantes <span class="glyphicon glyphicon-user"></span>
				</legend>
				<thead>
					<tr class="cabAcomps">
					</tr>
				</thead>
				<tbody id="contenerParaAgregarAcomp">
				</tbody>
			</table>
			<div class="modal fadex" id="modalConsumosAcomp" tabindex="-1"
				role="dialog" aria-labelledby="myModalLabelx" aria-hidden="true">
				<div class="modal-header">
					<button type="button" class="close closeModalSegundo"
						aria-hidden="true">&times;</button>
					<h4 class="modal-title">Consumo del acompañante</h4>
				</div>
				<div class="modal-body">
					<table class="table table-hover">
						<thead>
							<tr>
								<th>Servicio / Producto</th>
								<th>Precio</th>
								<th>Cantidad</th>
								<th>Sub Total</th>
							</tr>
						</thead>
						<tbody id="contenedorConsumos">
						</tbody>
					</table>
				</div>
				<div class="modal-footer">
					<button type="button" class="btn btn-default closeModalSegundo"
						data-dismiss="modal">Cerrar</button>
					<!--<button type="button" class="btn btn-primary">Save changes</button> -->
				</div>
				<!-- -body hijo -->
			</div>
		</div>
		<!-- -budy padre  -->
		<div class="modal-footer">
			<button type="button" class="btn btn-danger" data-dismiss="modal"
				id="btnSaveModalCheckOut">Check-out</button>
			<button type="button" class="btn btn-default" data-dismiss="modal">Cerrar</button>
		</div>
	</div>
	<!-- fin del modal detalleReserva  -->

	<br />
	<div class="row">
		<div class="col-md-6 col-md-offset-3 col-xs-5">
			<div class="input-group input-group-lg">
				<span class="input-group-addon">Monto a pagar</span> <label
					id="lblTotalPagar" class="form-control"></label>
			</div>
		</div>
		<!-- /.col-lg- -->
	</div>
	<br />

	<div class="row">
		<div class="col-md-8 col-md-offset-4 modal-footer">
			<button type="button" class="btn btn-default"
				onclick="javascript:history.go(-1);" id="btnCancelar">Cancelar</button>
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