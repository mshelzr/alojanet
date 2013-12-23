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
			<a class="navbar-brand" href="#">Libertadores</a>
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
						<a href="#" id="linkLogeo"><c:out
								value="${cookie.idUsuario.value}" /></a>
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
								placeholder="Enter email">
						</div>
						<div class="form-group">
							<label class="sr-only" for="exampleInputPassword2">Password</label>
							<input type="password" name="password"
								class="form-control input-sm" id="password"
								placeholder="Password">
						</div>
						<button id="btnLoginNav" type="button" class="btn btn-default"
							data-container="body" data-toggle="popover"
							data-placement="bottom" data-original-title="" title="">
							<span class="glyphicon glyphicon-share-alt"></span>
						</button>
						o <a data-toggle="modal" href="#modalregistro">Registrate</a>
					</form>
					<div class="modal fade" id="modalregistro" tabindex="-1" role="dialog"
						aria-labelledby="myModalLabel" aria-hidden="true">
						<div class="modal-dialog">
							<div class="modal-content">
								<div class="modal-header">
									<button type="button" class="close" data-dismiss="modal"
										aria-hidden="true">&times;</button>
									<h4 class="modal-title">Registrate, falta poco para
										disfrutes de nuestros servicios</h4>
								</div>
								<div class="modal-body">
									<div class="panel panel-primary">
										<div class="panel-heading">
											<h3 class="panel-title">Mediante tu cuenta de red
												social.</h3>
										</div>
										<div class="panel-body">
											<button type="button"
												class="btn btn-default btn-lg btn-block">Facebook</button>
											<button type="button"
												class="btn btn-default btn-lg btn-block">Twitter</button>
										</div>
									</div>
									<div class="panel panel-success">
										<div class="panel-heading">
											<h3 class="panel-title">Registro clasico.</h3>
										</div>
										<div class="panel-body">
											<form>
												<table>
													<tr>
														<td>Tipo de persona:</td>
														<td><select id="myself">
																<option value="pnatural">Natural</option>
																<option value="pjuridica">Juridica</option>
														</select></td>
													</tr>
													<tr class="pjuridica" style="display: none">
														<td><br /></td>
													</tr>
													<tr class="pjuridica" style="display: none">
														<td colspan="4">Datos de la empresa</td>
													</tr>
													<tr class="pjuridica" style="display: none">
														<td>Empresa</td>
														<td><input type="text" name="nombreEmpresa"></td>
													</tr>
													<tr class="pjuridica" style="display: none">
														<td>Ruc</td>
														<td><input type="text" name="ruc"></td>
														<td>Confirmar Ruc</td>
														<td><input type="text" name="confRuc"></td>
													</tr>
													<tr>
														<td><br /></td>
													</tr>
													<tr class="pjuridica" style="display: none">
														<td colspan="4">Datos del representante</td>
													</tr>
													<tr>
														<td>Nombre</td>
														<td><input type="text" name="nombre"></td>
														<td>Apellidos</td>
														<td><input type="text" name="apellidos" /></td>
													</tr>
													<tr>
														<td>Tipo de Documento</td>
														<td><select>
																<option>DNI</option>
																<option>PASAPORTE</option>
														</select></td>
													</tr>
													<tr>
														<td>Num Documento</td>
														<td><input type="text" name="numDocumento"></td>
														<td>Confirmar Num Documento</td>
														<td><input type="text" name="conifNumDocumento"></td>
													</tr>
													<tr>
														<td>Dirección</td>
														<td><input type="text" name="direccion" /></td>
														<td>Teléfono</td>
														<td><input type="text" name="telefono"></td>
													</tr>
													<tr>
														<td>Email</td>
														<td><input type="text" name="email"></td>
														<td>Confirmar Email</td>
														<td><input type="text" name="confemail"></td>
													</tr>
													<tr>
														<td>Fecha</td>
														<td><input type="text" disabled="disabled"
															value="<fmt:formatDate value="${fechita}" type="date" pattern="dd/MM/yyyy" />"
															name="fecha"></td>
													</tr>
												</table>
												<div class="form-group">
													<br> <label for="inputCaptcha">¿Eres un Robot?</label>
													<br /> <img id="captchaImage"
														src="http://raincaptcha.driversworld.us/api/v1/image/1a5185142695015ea37c63759d6ba95d?rand261014&amp;morerandom=2269">
													<input type="text" class="input-sm" id="inputCaptcha"
														name="captcha" autocomplete="off" required="">

													<button class="btn btn-danger" type="button"
														onclick="document.getElementById('captchaImage').src = 'http://raincaptcha.driversworld.us/api/v1/image/1a5185142695015ea37c63759d6ba95d?rand261014&amp;morerandom=' + Math.floor(Math.random() * 10000);">
														<span class="glyphicon glyphicon-repeat"></span>
													</button>

													<br> <br>

													<div class="input-group"></div>
												</div>

												<input type="submit" class="btn btn-lg btn-primary"
													value="Submit">
											</form>
										</div>
									</div>
								</div>
								<div class="modal-footer">
									<button type="button" class="btn btn-default"
										data-dismiss="modal">Close</button>
									<!-- 				          <button type="button" class="btn btn-primary">Save changes</button> -->
								</div>
							</div>
							<!-- /.modal-content -->
						</div>
						<!-- /.modal-dialog -->
					</div>
				</c:otherwise>
			</c:choose>
		</div>
	</nav>
	<!-- Fin de la UpCabecera -->
</div>