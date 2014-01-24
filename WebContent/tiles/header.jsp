<%@ page contentType="text/html; charset=UTF-8"%>
<%@ taglib prefix="s" uri="/struts-tags"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>

<div class="col-md-12 column">
	<nav class="navbar navbar-default" role="navigation">
		<div class="navbar-header">
			<button type="button" class="navbar-toggle" data-toggle="collapse"
				data-target="#bs-example-navbar-collapse-1">
				<span class="sr-only">Toggle navigation</span><span class="icon-bar"></span><span
					class="icon-bar"></span><span class="icon-bar"></span>
			</button>
			<a class="navbar-brand" href="home.action">Libertadores</a>
		</div>

		<div class="collapse navbar-collapse"
			id="bs-example-navbar-collapse-1">
			<p class="navbar-text facebook">
				<a href="#">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;acebook</a>
			</p>
			<p class="navbar-text twitter">
				<a href="#">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;Twitter</a>
			</p>
			<p class="navbar-text googleplus">
				<a href="#">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; Google+</a>
			</p>
			<!-- 			parte derecha de la cabecera -->
			<c:choose>
				<c:when test="${not empty cookie.idUsuario.value}">
					<p class="navbar-text navbar-right">
						Conectado como <span class="glyphicon glyphicon-user"></span>
						<a href="#" id="linkLogeo">
						
						<c:out value="${cookie.jsNombreCompleto.value}" /></a>
						<s:url action="logout.action" var="cerrarSesion"></s:url>
						<a href="<s:property value="#cerrarSesion" />">(Salir)</a>
					</p>
				</c:when>
				<c:otherwise>
					<form class="navbar-form navbar-right" role="form">
						<div class="form-group">
							<label class="sr-only" for="exampleInputEmail2">Email
								address</label> <input type="email" name="username"
								class="form-control input-sm" id="username"
								placeholder="Enter user or email">
						</div>
						<div class="form-group">
							<label class="sr-only" for="exampleInputPassword2">Password</label>
							<input type="password" name="password"
								class="form-control input-sm" id="password"
								placeholder="Password">
						</div>
						<button id="btnLoginNav" type="button" class="btn btn-default"
							data-container="body" data-toggle="popover" data-placement="bottom">
							<span class="glyphicon glyphicon-share-alt"></span>
						</button>
						o <a data-toggle="modal" href="#modalregistro">Registrate</a>
					</form>
					<div class="modal fade" id="modalregistro" tabindex="-1" role="dialog"  data-width="600"
						aria-labelledby="myModalLabel" aria-hidden="true">
							<div class="modal-header">
								<button type="button" class="close" data-dismiss="modal"
									aria-hidden="true">&times;</button>
								<h4 class="modal-title">Registrate, falta poco para
									disfrutes de nuestros servicios</h4>
							</div>
								<div class="modal-body">
									<div class="panel panel-success">
										<div class="panel-heading">
											<h3 class="panel-title">Registro clasico.</h3>
										</div>
										<div class="panel-body">
											<form>
												<table>
													<tr>
														<td>Nombre</td>
														<td><input type="text"name="nombres" required="" ></td>
														<td>A. Paterno</td>
														<td><input type="text" name="apePaterno" required=""/></td>
													</tr>
													<tr>
														<td>A. Materno</td>
														<td><input type="text" name="apeMaterno" required=""/></td>
														<td>Tipo de Documento</td>
														<td><select>
																<option>DNI</option>
																<option>PASAPORTE</option>
														</select></td>
													</tr>
													<tr>
														<td>Nº Documento</td>
														<td><input type="text" name="numDocumento"></td>
														<td>Confirmar Nº Documento</td>
														<td><input type="text" name="conifNumDocumento"></td>
													</tr>
													<tr>
														<td>Dirección</td>
														<td><input type="text" name="direccion" /></td>
														<td>Teléfono</td>
														<td><input type="text" name="telf"></td>
													</tr>
													<tr>
														<td>Email</td>
														<td><input type="text" name="email"></td>
														<td>Confirmar Email</td>
														<td><input type="text" name="confemail"></td>
													</tr>
												</table>
											</form>
										</div>
									</div>
								</div>
								<div class="modal-footer">
									<button type="button" id="btnRegistro" class="btn btn-primary">Registrarse</button>
									<button type="button" class="btn btn-default" data-dismiss="modal">Close</button>								
								</div>
							</div>
				</c:otherwise>
			</c:choose>
		</div>
	</nav>
	<!-- Fin de la UpCabecera -->
</div>