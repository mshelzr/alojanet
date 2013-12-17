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
			<p class="navbar-text">
				<a href="#">O Facebook</a>
			</p>
			<p class="navbar-text">
				<a href="#">O Twitter</a>
			</p>
			<p class="navbar-text">
				<a href="#">O Google+</a>
			</p>
			<c:choose>
				<c:when test="${not empty s_usuario.idUsuario}">
					<p class="navbar-text navbar-right">
						Conectado como <a href="#" id="linkLogeo"><c:out
								value="${s_usuario.user}" /></a>
						<s:url action="logout.action" var="cerrarSesion"></s:url>
						<a href="<s:property value="#cerrarSesion" />">(Salir)</a>
					</p>
				</c:when>
				<c:otherwise>
					<p class="navbar-text navbar-right">
						<a href="javascript:void(0);" class="disabled">Registrate</a> o <a
							href="javascript:void(0);" id="linkLogeo">Inicia Sesión</a>
					</p>
				</c:otherwise>
			</c:choose>
		</div>
		<div id="dialogLoginNav" title="Indentificación">
			<form name="login">
				<label>Usuario:&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</label>
				<s:textfield size="14" name="username" id="username" />
				<br /> <label>Contraseña:</label>
				<s:password size="14" name="password" id="password" />
				<br /> <input class="btn btn-default" type="button" value="Entrar" id="btnLoginNav"
					tabindex="1" /> <input class="btn btn-default" type="button" value="Olvidé contraseña" />
			</form>
			<div id="resultLogin"></div>
		</div>
	</nav>
	<!-- Fin de la UpCabecera -->
	<div class="jumbotron">
		<div class="container">
			<h2 class="portal-text">El mejor lugar para alojarte!</h2>
			<p class="portal-text">
				This is a template for a simple marketing or informational website.
				<a class="btn btn-primary btn-large" href="#">Ver más</a>
			</p>
		</div>
	</div>
</div>