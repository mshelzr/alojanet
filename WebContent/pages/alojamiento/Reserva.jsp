<%@ page contentType="text/html; charset=UTF-8"%>
<%@ taglib prefix="s" uri="/struts-tags"%>
<%@ taglib prefix="sj" uri="/struts-jquery-tags"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jstl/fmt_rt"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<jsp:useBean id="fechita" class="java.util.Date" />

<input type="hidden" id="perfilLoggeado"
	value="${cookie.idPerfil.value}" />
<input type="hidden" value="${flagBusquedaHome}" id="flagFromHome" />
<input type="hidden" value='${ambientesFromHome}' id="ambientesFromHome" />
<input type="hidden" id="tabSelected" />
<input type="hidden" value='<s:property value="fInicio"/>'
	id="fecInicioFromHome" />
<input type="hidden" value='<s:property value="fFin"/>'
	id="fecFinFromHome" />
<input type="hidden" name="habitacion" id="habitacion" class="required" />
<input type="hidden" id="tabSelected" value="1" />
<input type="hidden" id="ambiente" />

<ul id="myTab" class="nav nav-tabs">
	<li
		class=" <c:if test="${flagBusquedaHome eq 1 || flagBusquedaHome eq 0}">active </c:if>"><a
		href="#tone" data-toggle="tab">Cabaña</a></li>
	<li class=" <c:if test="${flagBusquedaHome eq 2}">active </c:if>"><a
		href="#ttwo" data-toggle="tab">Convención</a></li>
	<li class=" <c:if test="${flagBusquedaHome eq 3}">active </c:if>"><a
		href="#tthree" data-toggle="tab">Ambientes</a></li>
</ul>
<div id="myTabContent" class="tab-content">

	<!-- 		DIV-UNO -->
	<div
		class="tab-pane fade <c:if test="${flagBusquedaHome eq 1 || flagBusquedaHome eq 0}">active in</c:if>"
		id="tone">
		<br />
		<form>
			<table>
				<tr>
					<td>
						<div class="input-group date " id="e" data-date="2014-01-21"
							data-date-format="yyyy-mm-dd">
							<span class="input-group-addon">Desde</span> <input
								class="form-control input-sm required" name="desdeCab"
								id="desdeCab" type="text" /> <span class="input-group-addon"><i
								class="glyphicon glyphicon-calendar"></i></span>
						</div>
					</td>
					<td>
						<div class="input-group date " id="e" data-date="2014-01-22"
							data-date-format="yyyy-mm-dd">
							<span class="input-group-addon">Hasta</span> <input
								class="form-control input-sm required" greaterThan="#desdeCab"
								name="hastaCab" id="hastaCab" type="text"> <span
								class="input-group-addon"><i
								class="glyphicon glyphicon-calendar"></i></span>
						</div>
					</td>
					<td>
						<button type="submit" class="btn btn-primary btn-sm btnBuscarCabs">
							<span class="glyphicon glyphicon-search"></span>
						</button>
					</td>
				</tr>
			</table>
		</form>
		<br />

		<div class="panel-group panel-cabs-searched hidden" id="panel-351682">
			<div class="row">
				<legend class="text-primary">
					Cabañas <span class="glyphicon glyphicon-lock"></span>
				</legend>
				<div class="panel panel-default">
					<div class="panel-heading">
						<a class="panel-title" data-toggle="collapse"
							data-parent="#panel-351682" href="#panel-element-983044">Cabañas
							disponibles <span class="glyphicon glyphicon-tasks"></span>
						</a>
					</div>
					<div id="panel-element-983044" class="panel-collapse collapse">
						<div class="panel-body">
							<div class="row" id="contenerCabs"></div>
						</div>
					</div>
				</div>
			</div>
		</div>
		<br />
		<div class="hidden" id="panel-habs-searched">
			<input type="hidden" id="scopePersonasCab" />
			<div class="row" id="contenerHabs">
				<legend class="text-primary">
					Habitaciones <span class="glyphicon glyphicon-list-alt"></span>
				</legend>
			</div>
		</div>
		<div class="hidden" id="panel-acompanantes-hab-searched">
			<div class="row">
				<form>
					<legend class="text-primary">
						Acompañantes <span class="glyphicon glyphicon-user"></span>
					</legend>					
					<div class="col-sm-offset-10" class="incluirme">
						<div class="checkbox" class="incluirme">
							<label> <input type="checkbox" name="incluirme" id="incluirme" /> Incluirme <span
								class="glyphicon glyphicon-user"></span>
							</label>
						</div>
					</div>
					<div class="col-xs-3">
						<input placeholder="Nombres" name="nombres"
							id="inputNombresAcompCab" class="form-control input-sm required"
							type="text">
					</div>
					<div class="col-xs-2">
						<input placeholder="A. Paterno" name="apePaterno" type="text"
							class="form-control input-sm required"
							id="inputApePaternoAcompCab">
					</div>
					<div class="col-xs-2">
						<input placeholder="A. Materno" name="apeMaterno" type="text"
							class="form-control input-sm required"
							id="inputApeMaternoAcompCab">
					</div>
					<div class="col-xs-5">
						<div class="input-group">
							<span class="input-group-btn"> <select class="input-sm"
								id="inputTipoDocAcomp-Cab">
									<option value="DNI">DNI</option>
									<option value="PASA" title="Pasaporte">PASA</option>
							</select>
							</span> <input placeholder="Número" name="numero" type="text"
								class="form-control input-sm required number"
								id="inputDocAcompCab"> <span class="input-group-addon">
								<input type="submit" class="hidden" id="btnAddAcompCab" /> <a
								id="btnAgregarAcompCab" href="javascript:void(0);"
								onclick="$('#btnAddAcompCab').trigger('click');"> <span
									class="glyphicon glyphicon-plus"></span> <span
									class="glyphicon glyphicon-user"></span></a>
							</span>
						</div>
					</div>
				</form>
			</div>
			<form>
				<table class="table table-hover">
					<thead>
						<tr>
							<th>Nombres</th>
							<th>A. Paterno</th>
							<th>A. Materno</th>
							<th>Documento</th>
							<th>Nº</th>
							<th>Elim.</th>
						</tr>
					</thead>
					<tbody id="tablaAcompCab">

					</tbody>
				</table>
				<div class="row">
					<div class="col-md-8 col-md-offset-4 modal-footer">
						<input type="hidden" name="ambienteCab" id="ambienteCab" />
						<button type="submit" class="btn btn-primary btnReservar"
							id="btnReservarCab">Reservar</button>
						<button type="button" onclick="javascript:history.go(-1);"
							class="btn btn-default">Cancelar</button>
					</div>
				</div>
			</form>
		</div>
	</div>
	<!-- 		DIV: NUMERO DOS -->
	<div
		class="tab-pane fade <c:if test="${flagBusquedaHome eq 2}">active in</c:if>"
		id="ttwo">
		<br />
		<form>
			<table>
				<tr>
					<td>
						<div class="input-group date " id="e" data-date="2014-01-21"
							data-date-format="yyyy-mm-dd">
							<span class="input-group-addon">Desde</span> <input
								class="form-control input-sm required" name="desdeConve"
								id="desdeConve" type="text" /> <span class="input-group-addon"><i
								class="glyphicon glyphicon-calendar"></i></span>
						</div>
					</td>
					<td>
						<div class="input-group date " id="e" data-date="2014-01-22"
							data-date-format="yyyy-mm-dd">
							<span class="input-group-addon">Hasta</span> <input
								class="form-control input-sm required" greaterThan="#desdeConve"
								name="hastaConve" id="hastaConve" type="text"> <span
								class="input-group-addon"><i
								class="glyphicon glyphicon-calendar"></i></span>
						</div>
					</td>
					<td>
						<button type="submit"
							class="btn btn-primary btn-sm btnEnterConvencion">
							<span class="glyphicon glyphicon-search"></span>
						</button>
					</td>
				</tr>
			</table>
		</form>
		<br />

		<div class="row hidden" id="panel-convencion-searched">
			<input type="hidden" id="scopePersonasConve" />
			<ul class="media-list" id="contenedorConvens">

			</ul>
		</div>

		<div class="hidden" id="panel-alojados-searched">
			<div class="row">
				<h3>Agregar Invitados</h3>
				<div class="col-xs-6 col-sm-4 sidebar-offcanvas" id="sidebar"
					role="navigation" style="float: left">
					<div class="well sidebar-nav">
						<ul class="listConScroll">
							<li><strong>Select a subject</strong></li>
							<li class="active"><input type="checkbox" />Maths</li>
							<li><input type="checkbox" />English</li>
						</ul>
					</div>
				</div>
				<div class="bs-callout bs-callout-warning">
					<h4>Personas que se encuentran alojadas</h4>
					<p>Praesent sapien massa, convallis a pellentesque nec, egestas
						non nisi. Vestibulum ante ipsum primis in faucibus orci luctus et
						ultrices posuere cubilia Curae.</p>
				</div>
			</div>
		</div>

		<div class="hidden" id="panel-acompanantes-cen-searched">
			<form>
				<div class="row">
					<legend class="text-primary">
						Acompañantes <span class="glyphicon glyphicon-user"></span>
					</legend>
					<div class="col-xs-3">
						<input placeholder="Nombres" name="nombresConve"
							id="inputNombresAcompConve"
							class="form-control input-sm required" type="text">
					</div>
					<div class="col-xs-2">
						<input placeholder="A. Paterno" name="apePaternoConve" type="text"
							class="form-control input-sm required"
							id="inputApePaternoAcompConve" size="6">
					</div>
					<div class="col-xs-2">
						<input placeholder="A. Materno" name="apeMaternoConve" type="text"
							class="form-control input-sm required"
							id="inputApeMaternoAcompConve">
					</div>
					<div class="col-xs-5">
						<div class="input-group">
							<span class="input-group-btn"> <select class="input-sm"
								id="inputTipoDocAcompConve">
									<option>DNI</option>
									<option title="Pasaporte">PASA</option>
							</select>
							</span> <input placeholder="Número" type="text"
								class="form-control input-sm required number" name="numeroConve"
								id="inputDocAcompConve"> <input type="submit"
								class="hidden" id="btnAgregarAcomp-Conve" /> <span
								class="input-group-addon"> <a href="javascript:void(0);"
								id="btnAddAcompConve"
								onclick="$('#btnAgregarAcomp-Conve').trigger('click');"> <span
									class="glyphicon glyphicon-plus"></span> <span
									class="glyphicon glyphicon-user"></span></a>
							</span>
						</div>
					</div>
				</div>
			</form>
			<form>
				<table class="table table-hover">
					<thead>
						<tr>
							<th>Nombres</th>
							<th>A. Paterno</th>
							<th>A. Materno</th>
							<th>Documento</th>
							<th>Nº</th>
							<th>Elim.</th>
						</tr>
					</thead>
					<tbody id="tablaAcompConve">

					</tbody>
				</table>
				<div class="row">
					<div class="col-md-8 col-md-offset-4 modal-footer">
						<input type="hidden" name="ambienteConve" id="ambienteConve" />
						<button type="button" class="btn btn-primary btnReservar"
							id="btnReservarConve">Reservar</button>
						<button type="button" class="btn btn-default"
							onclick="javascript:history.go(-1);">Cancelar</button>
					</div>
				</div>
			</form>
		</div>
		<!-- Fin de la tabla acompañantes -->
	</div>
	<!-- 		DIV -TRES				 -->
	<div
		class="tab-pane fade <c:if test="${flagBusquedaHome eq 3}">active in</c:if>"
		id="tthree">
		<br />
		<form>
			<table>
				<tr>
					<td>
						<div class="input-group date " id="e" data-date="2014-01-21"
							data-date-format="yyyy-mm-dd">
							<span class="input-group-addon">Desde</span> <input
								class="form-control input-sm required" name="desdeAmbiente"
								id="desdeAmbiente" type="text" /> <span
								class="input-group-addon"><i
								class="glyphicon glyphicon-calendar"></i></span>
						</div>
					</td>
					<td>
						<div class="input-group date " id="e" data-date="2014-01-22"
							data-date-format="yyyy-mm-dd">
							<span class="input-group-addon">Hasta</span> <input
								class="form-control input-sm required"
								greaterThan="#desdeAmbiente" name="hastaAmbiente"
								id="hastaAmbiente" type="text"> <span
								class="input-group-addon"><i
								class="glyphicon glyphicon-calendar"></i></span>
						</div>
					</td>
					<td>
						<button type="submit"
							class="btn btn-primary btn-sm btnEnterAmbiente">
							<span class="glyphicon glyphicon-search"></span>
						</button>
					</td>
				</tr>
			</table>
		</form>
		<br />
		<div class="row hidden" id="panel-tab-ambiente">
			<blockquote>
				<h3>Aviso:</h3>
				<p>Para poder reservar un ambiente necesitas haber reservado una
					cabaña</p>
			</blockquote>
			</br>
			<legend class="text-primary">
				Ambientes disponibles <span class="glyphicon glyphicon-list-alt"></span>
			</legend>
			<div class="panel-body">
				<div class="row" id="contenedorAmbiente"></div>
			</div>
		</div>
		<form>
			<div class="row hidden" id="panel-acompanantes-amb-searched">
				<div class="col-md-8 col-md-offset-4 modal-footer">
					<input type="text" class="hidden required" name="ambienteAmbiente"
						id="ambienteAmbiente" />
					<button type="submit" class="btn btn-primary btnReservar"
						id="btnReservarAmbiente">Reservar</button>
					<button type="button" class="btn btn-default"
						onclick="javascript:history.go(-1);">Cancelar</button>
				</div>
			</div>
		</form>
	</div>
	<!-- fin tab tres -->
</div>
<!-- Modal -->
<div id="modalQuestion" class="modal fade" tabindex="-1"
	style="display: none;">
	<div class="modal-header">
		<button type="button" class="close" data-dismiss="modal"
			aria-hidden="true">×</button>
		<h4 class="modal-title">Seleccione el tipo de identificación</h4>
	</div>
	<div class="modal-body">
		<input type="button" value="¿Es tu primera vez reservando?"
			class="demo btn btn-primary btn-sm" data-toggle="modal"
			href="#modalRegister" /> / <input type="button"
			value="¿Ya eres cliente?" class="demo btn btn-primary btn-sm"
			data-toggle="modal" href="#modalLogin" />
	</div>
</div>

<div id="modalLogin" class="modal fade" tabindex="-1"
	style="display: none;">
	<div class="modal-header">
		<button type="button" class="close" data-dismiss="modal"
			aria-hidden="true">×</button>
		<h4 class="modal-title">Identificación</h4>
	</div>
	<div class="modal-body">
		<form class="cuerpo-modal">
			<label>Usuario: </label><input type="text" id="userInput" /><br />
			<label>Contrasena</label><input type="text" id="pwdInput" /><br />
			<input type="button" value="Identificarse" id="btnLoginReserva"
				data-container="body" data-toggle="popover" data-placement="bottom" />
			<input type="button" value="Olvidé contraseña" />
		</form>
		<br />
		<div class="alert alert-danger hidden" id="remplazoDangerLoginCab">
			<strong>Oh snap!</strong> Debido a Pellentesque in ipsum id orci
			porta dapibus. Donec sollicitudin molestie malesuada.
		</div>
	</div>
</div>

<div class="modal fade" id="modalRegister" tabindex="-1" role="dialog"
	data-width="600" aria-labelledby="myModalLabel" aria-hidden="true">
	<div class="modal-header">
		<button type="button" class="close" data-dismiss="modal"
			aria-hidden="true">&times;</button>
		<h4 class="modal-title">Registrate, falta poco para disfrutes de
			nuestros servicios</h4>
	</div>
	<form id="registroPersonaXMSS">
		<div class="modal-body">
			<div class="panel panel-success">
				<div class="panel-heading">
					<h3 class="panel-title">Registro clasico.</h3>
				</div>
				<div class="panel-body">
					<table>
						<tr>
							<td>Nombre</td>
							<td class="inputval"><input type="text" name="nombresr"
								class="required"></td>
							<td>A. Paterno</td>
							<td class="inputval"><input type="text" name="apePaternor"
								class="required" /></td>
						</tr>
						<tr>
							<td>A. Materno</td>
							<td class="inputval"><input type="text" name="apeMaternor"
								class="required" /></td>
							<td>Tipo de Documento</td>
							<td><select>
									<option>DNI</option>
									<option>PASAPORTE</option>
							</select></td>
						</tr>
						<tr>
							<td>Nº Documento</td>
							<td class="inputval"><input type="text" name="numDocumentor"
								id="numDocumentor" class="required number"></td>
							<td>Confirmar Nº Documento</td>
							<td class="inputval"><input type="text"
								name="conifNumDocumento" class="required number"
								title="No coincide" equalTo="#numDocumentor"></td>
						</tr>
						<tr>
							<td>Dirección</td>
							<td class="inputval"><input type="text" name="direccionr"
								class="required" /></td>
							<td>Teléfono</td>
							<td class="inputval"><input type="text" name="telfr"
								class="required number"></td>
						</tr>
						<tr>
							<td>Email</td>
							<td class="inputval"><input type="text" name="emailr"
								id="emailr" class="required email"></td>
							<td>Confirmar Email</td>
							<td class="inputval"><input type="text" name="confemailr"
								class="required email" equalTo="#emailr"></td>
						</tr>
					</table>
				</div>
			</div>
		</div>
		<div class="modal-footer">
		<button type="submit" id="btnRegistrarse" class="btn btn-primary">Registrarse</button>
		<button type="button" class="btn btn-default" data-dismiss="modal">Close</button>
		</div>
	</form>
</div>
<div id="modalReservasActivas" class="modal fade" tabindex="-1"
	style="display: none;">
	<div class="modal-header">
		<button type="button" class="close" data-dismiss="modal"
			aria-hidden="true">×</button>
		<h4 class="modal-title">Reservas activas, seleccione uno:</h4>
	</div>
	<div class="modal-body">
		<table class="table table-hover cuerpo-modal">
			<thead>
				<tr>
					<th>Sel.</th>
					<th>Nº Reserva</th>
					<th>Persona</th>
					<th>Documento</th>
				</tr>
			</thead>
			<tbody id="tablaReservasActivas">
			</tbody>
		</table>
		<br />
		<div class="alert alert-danger hidden"
			id="remplazoDangerReservasActivasCab">
			<strong>Oh snap!</strong> Debido a Pellentesque in ipsum id orci
			porta dapibus. Donec sollicitudin molestie malesuada.
		</div>
	</div>
	<div class="modal-footer">
		<div class="row">
			<button type="button"
				class="btn btn-danger nroReservaSelectedReservaMain"
				id="btnNuevoContenedor" data-action="nuevoContenedor">Crear
				nuevo contenedor de Reserva</button>
			<button type="button" class="btn btn-default" data-dismiss="modal">Cancelar</button>
		</div>
	</div>
</div>

<div id="modalResultado" class="modal fade" tabindex="-1"
	style="display: none;">
	<div class="modal-header">
		<button type="button" class="close" data-dismiss="modal"
			aria-hidden="true">×</button>
		<h4 class="modal-title">¡Felicitaciones!</h4>
	</div>
	<div class="modal-body">
		<div class="hidden" id="msjRegistroPersona">
			<dl class="dl-horizontal">
				<dt>Nombres:</dt>
				<dd id="llblNombres"></dd>
				<dt>Email:</dt>
				<dd id="llblEmail"></dd>
				<br>
				<div class="well well-sm">
					<dt>Usuario:</dt>
					<dd id="llblUser"></dd>
					<dt>Contraseña:</dt>
					<dd id="llblPwd"></dd>
				</div>
			</dl>
		</div>
		<div class="hidden" id="msjReserva">
			<div class="page-header-customed">
				<h1 id="llblidReserva">
				</h1>
			</div>
			<dl class="dl-horizontal">
				<br>
				<div class="well well-sm">
					<dt>Desde:</dt>
					<dd id="llblDesde"></dd>
					<dt>Hasta:</dt>
					<dd id="llblHasta"></dd>
				</div>
			</dl>
		</div>
	</div>
	<div class="modal-footer">
		<div class="row">
			<a type="button" class="btn btn-danger hidden" href="agregarReserva.action" id="idFinA">Finalizar</a>
			<a type="button" class="btn btn-danger hidden" href="gestionarReserva.action" id="idFinB">Finalizar</a>
		</div>
	</div>
</div>