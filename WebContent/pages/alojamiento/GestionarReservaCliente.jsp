<%@ page contentType="text/html; charset=UTF-8"%>
<%@ taglib prefix="s" uri="/struts-tags"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<div class="page-header-customed">
	<input type="hidden" id="paginaActual" value="gestionar" />
	<input type="hidden" id="idDetalleReserva" />
	<h1 id="type">
		Gestionar <small>Reserva</small>
	</h1>
</div>
<div class="panel-group panel-cabs-searched panel-reserva-encontrada"
	id="panel-2">
	<br />
	<c:forEach items="${count}" var="m" varStatus="status">
		<div class="panel panel-default">
			<div class="panel-heading">
				<a class="panel-title" data-toggle="collapse" data-parent="#panel-2"
					href="#panel-element-${status.count}">Temporada #
					${status.count} <span class="glyphicon glyphicon-tasks"></span>
				</a>
			</div>
			<div id="panel-element-${status.count}"
				class="panel-collapse collapse <c:if test="${status.index eq 0}">in</c:if>">
				<div class="panel-body">
					<br />
					<div class="row">
						<div class="col-xs-5">
							<div class="input-group input-group-lg">
								<span class="input-group-addon">Código de la reserva</span> <input
									type="text" class="form-control" id="lblIdReserva" value="${m}"
									disabled />
							</div>
						</div>
					</div>
					<br />
					<table class="table table-hover">
						<legend class="text-primary">
							Datos de la reserva <span class="glyphicon glyphicon-list-alt"></span>
						</legend>
						<thead>
							<tr>
								<th>Nº Ambiente</th>
								<th><span class="glyphicon glyphicon-user"></span> Actual</th>
								<th>F. Inicio</th>
								<th>F. Fin</th>
								<th>Info.</th>
								<th>Estado.</th>
							</tr>
						</thead>
						<tbody id="rowDetalleReserva">
							<c:forEach items="${listaReservas}" var="n">
								<c:if test="${n.idreserva eq m }">
									<c:choose>
										<c:when test="${n.estado eq 0}">
											<c:set value="success" var="estiloRow" />
											<c:set value="Por activar" var="estadoDesc" />
											<c:set value="btnModalDetalleReserva" var="btnWhichModal" />
										</c:when>
										<c:when test="${n.estado eq 1}">
											<c:set value="warning" var="estiloRow" />
											<c:set value="Check-in" var="estadoDesc" />
											<c:set value="btnModalDetalleReservaCheckOut"
												var="btnWhichModal" />
										</c:when>
										<c:when test="${n.estado eq 2}">
											<c:set value="danger" var="estiloRow" />
											<c:set value="Check-out" var="estadoDesc" />
											<c:set value="btnModalDetalleReservaCheckOut"
												var="btnWhichModal" />
										</c:when>
										<c:otherwise>
											<c:set value="info" var="estiloRow" />
											<c:set value="Desactivado" var="estadoDesc" />
											<c:set value="btnModalDetalleReservaCheckOut"
												var="btnWhichModal" />
										</c:otherwise>
									</c:choose>
									<tr class="${estiloRow}">
										<td>${n.cabLocal}/${n.habLocal}</td>
										<td>${n.count}/${n.acomps}</td>
										<td>${n.fec_inicio}</td>
										<td>${n.fec_fin}</td>
										<td><a class="${btnWhichModal}" data-toggle="modal"
											href="#" data-action="${n.idDetalleReserva}"><span
												class="glyphicon glyphicon-eye-open"></span></a></td>
										<td>${estadoDesc}</td>
									</tr>
								</c:if>
							</c:forEach>
						</tbody>
					</table>
				</div>
			</div>
		</div>
	</c:forEach>
	<div class="row">
		<div class="col-md-8 col-md-offset-4 modal-footer">
			<a type="button" class="btn btn-primary" href="agregarReserva.action">Agregar
				nueva reserva</a> <a type="button" class="btn btn-default"
				href="javascript:history.go(-1);">Cancelar</a>
		</div>
	</div>
</div>

<!-- MODAL DETALL_RESERVA -->
<div class="modal fade" id="modalDetalleReserva" tabindex="1"
	role="dialog" data-width="760" aria-labelledby="myModalLabel"
	aria-hidden="true">
	<div class="modal-header">
		<button type="button" class="close" data-dismiss="modal"
			aria-hidden="true">&times;</button>
		<h4 class="modal-title">Detalle de la reserva</h4>
	</div>
	<div class="modal-body">
		<!-- cuerpo del modal -->
		<form>
		<table>
			<tr>
				<td>
					<div class="input-group date " id="e" data-date="16-01-2014"
						data-date-format="dd-mm-yyyy">
						<span class="input-group-addon">Desde</span> <input
							class="form-control input-sm required" name="lblDesde" id="lblDesde" type="text" /> <span
							class="input-group-addon"><i
							class="glyphicon glyphicon-calendar"></i></span>
					</div>
				</td>
				<td>
					<div class="input-group date " id="e2" data-date="16-02-2014"
						data-date-format="dd-mm-yyyy">
						<span class="input-group-addon">Hasta</span> <input
							class="form-control input-sm required" greaterThan="#lblDesde" name="lblHasta" type="text" id="lblHasta">
						<span class="input-group-addon"><i
							class="glyphicon glyphicon-calendar"></i></span>
					</div>
				</td>
				<td>
					<button type="submit" class="btn btn-primary btn-sm active"
						data-action="" id="btnConsultaDisponibilidad">
						<span class="glyphicon glyphicon-search"></span>
					</button>
				</td>
				<td></td>
				<td>
					<div class="btn-success btn-sm hidden" id="bot-fec_disponible">
						<span class="glyphicon glyphicon-ok"></span> Rango disponible
					</div>
					<div class="btn-danger btn-sm hidden" id="bot-fec_nondisponible">
						<span class="glyphicon glyphicon-remove"></span> Rango Ocupado
					</div>
				</td>
			</tr>
		</table>
		</form>
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
		<form>
			<legend class="text-primary hidden panelAgregarAcomp">
				Agregar nuevo acompañante <span class="glyphicon glyphicon-plus"></span>
				<span class="glyphicon glyphicon-user"></span>
			</legend>
			<div class="row hidden panelAgregarAcomp">
				<div class="col-xs-3">
					<input placeholder="Nombres" id="inputNombresAcomp"
						name="nombreAddAcomp" class="form-control input-sm required"
						type="text">
				</div>
				<div class="col-xs-2">
					<input placeholder="A. Paterno" type="text"
						name="apePaternoAddAcomp" class="form-control input-sm required"
						id="inputApePaternoAcomp" size="6">
				</div>
				<div class="col-xs-2">
					<input placeholder="A. Materno" type="text"
						name="apeMaternoAddAcomp" class="form-control input-sm required"
						id="inputApeMaternoAcomp">
				</div>
				<div class="col-xs-5">
					<div class="input-group">
						<span class="input-group-btn"> <select class="input-sm"
							id="inputTipoDocAcomp">
								<option>DNI</option>
								<option title="Pasaporte">PASA</option>
						</select>
						</span> <input placeholder="Número" type="text" name="numberoAddAcomp"
							class="form-control input-sm required number" id="inputDocAcomp">
						<span class="input-group-addon"> <input type="submit"
							class="hidden" id="btnAgregarAcomp" /> <a
							href="javascript:void(0);"
							onclick="$('#btnAgregarAcomp').trigger('click');"> <span
								class="glyphicon glyphicon-plus"></span> <span
								class="glyphicon glyphicon-user"></span></a>
						</span>
					</div>
				</div>
			</div>
		</form>
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
	</div>
	<div class="modal-footer">
		<button type="button" class="btn btn-danger" data-dismiss="modal"
			id="btnSaveModalGestionar">Guardar Cambios</button>
		<button type="button" class="btn btn-default" data-dismiss="modal">Cerrar</button>
	</div>
</div>