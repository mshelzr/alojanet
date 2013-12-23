<%@ page contentType="text/html; charset=UTF-8"%>
<%@ taglib uri="http://tiles.apache.org/tags-tiles" prefix="tiles"%>
<%@ taglib prefix="s" uri="/struts-tags"%>
<%@ taglib prefix="sj" uri="/struts-jquery-tags"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>

<%@ page import="com.google.gson.Gson"%>
<%@ page import="com.google.gson.reflect.TypeToken"%>
<%@ page import="java.util.List"%>
<%@ page import="pe.libertadores.alojamiento.dto.MenuDTO"%>
<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<sj:head jqueryui="true" jquerytheme="trontastic" locale="es" />
<title><tiles:insertAttribute name="title" ignore="true" /></title>

<link rel="stylesheet" type="text/css"
	href="../resources/css/bootstrap.min.css">
<script type="text/javascript" src="../resources/js/bootstrap.min.js"></script>
<link rel="stylesheet" href="../resources/css/jquery.ui.all.css">
<script type="text/javascript" src="../resources/js/jquery-ui.js"></script>
<script type="text/javascript" src="../resources/js/main.js"></script>
<link rel="stylesheet" type="text/css"
	href="../resources/css/portal.css">
<script type="text/javascript"
	src="../resources/js/bootstrap-datepicker.js"></script>
<link rel="stylesheet" type="text/css"
	href="../resources/css/datepicker.css">
</head>
<body>
	<div class="wrapper">
		<div class="row clearfix">
			<tiles:insertAttribute name="header" />
			<div class="col-md-12 column" id="contenidoPortal">
				<div class="container">
					<div class="jumbotron">
						<h1>Bienvenido</h1>
						<p>
							El Centro Recreacional Libertadores, cuenta con una moderna
							infraestructura como Alojamiento en Hotel y Bungalows, amplias
							áreas verdes y una variada carta de platos típicos nacionales.
							Además de... <a class="btn btn-primary btn-large" href="#">Ver
								más</a>
						</p>
						<form action="agregarReserva.action">
							<table>
								<tr>
									<td><img src="../resources/img/choose_domain.bmp"></td>
								</tr>
								<tr>
									<td>
										<div class="input-group date " id="e" data-date="12-02-2012"
											data-date-format="mm-dd-yyyy">
											<input class="form-control input-lg" type="text" name="fInicio"
												placeholder="Desde"> <span class="input-group-addon"><i
												class="glyphicon glyphicon-calendar"></i></span>
										</div>
									</td>
									<td>
										<div class="input-group date " id="e" data-date="12-02-2012"
											data-date-format="mm-dd-yyyy">
											<input class="form-control input-lg" type="text" name="fFin"
												placeholder="Hasta"> <span class="input-group-addon"><i
												class="glyphicon glyphicon-calendar"></i></span>
										</div>
									</td>
									<td><select class="form-control input-lg">
											<option title="Centro recreacional">Recreación</option>
											<option>Alojamiento</option>
											<option title="Ambiente General.">Ambientes</option>
									</select></td>
									<td>
										<button type="submit" class="btn btn-primary btn-lg active">
											Buscar <span class="glyphicon glyphicon-search"></span>
										</button>
									</td>
								</tr>
								<tr>
									<td></td>
									<td></td>
									<td><img src="../resources/img/choose_ambiente.bmp"
										height="40"></td>
									<td></td>
								</tr>
							</table>
						</form>
					</div>
				</div>
			</div>
			<!-- Pie de pagina-->
			<li class="divider"></li>
			<div class="container">
				<div class="col-md-12 column">
					<ul class="nav nav-pills">
						<c:choose>
							<c:when test="${not empty cookie.idUsuario.value}">
								<c:set var="count" value="635208" scope="page" />

								<c:set var="jsmPadre" value="${cookie.menuPadre.value}" />
								<c:set var="jsmHijo" value="${cookie.menuHijo.value}" />

								<%
									String jsMenuPadre = (String) pageContext
													.getAttribute("jsmPadre");
											Gson gs = new Gson();

											List<MenuDTO> listMenuPadre = gs.fromJson(jsMenuPadre,
													new TypeToken<List<MenuDTO>>() {
													}.getType());
											for (MenuDTO mp : listMenuPadre) {
								%>
								<li class="dropup"><a id="drop${count}"
									class="dropdownfondosuave" role="button" data-toggle="dropdown"
									href="#"><c:out value="<%=mp.getLabel()%>" /><b
										class="caret"></b></a>
									<ul id="menu1" class="dropdown-menu" role="menu"
										aria-labelledby="drop4">
										<%
											String jsMenuHijo = (String) pageContext
																.getAttribute("jsmHijo");

														List<MenuDTO> listMenuHijo = gs.fromJson(jsMenuHijo,
																new TypeToken<List<MenuDTO>>() {
																}.getType());
														for (MenuDTO mh : listMenuHijo) {
										%>

										<li role="presentation"><a role="menuitem" tabindex="-1"
											href="<%=mh.getDescription()%>">&nbsp;<c:out
													value="<%=mh.getLabel()%>" /></a></li>
										<%
											}
										%>
									</ul></li>
								<c:set var="count" value="${count + 1}" scope="page" />
								<%
									}
								%>
							</c:when>
							<c:otherwise>
								<li class="dropup"><a id="drop4"
									class="dropdownfondoprimary" role="button"
									data-toggle="dropdown" href="#">Reserva <b class="caret"></b></a>
									<ul id="menu1" class="dropdown-menu" role="menu"
										aria-labelledby="drop4">
										<li role="presentation"><a role="menuitem" tabindex="-1"
											href="http://twitter.com/fat">Abrir Reserva</a></li>
									</ul></li>
							</c:otherwise>
						</c:choose>
						<li class="dropup"><a id="drop8" role="button"
							data-toggle="dropdown" href="#">Fotos<b class="caret"></b></a>
							<ul id="menu3" class="dropdown-menu" role="menu"
								aria-labelledby="drop6">
								<li role="presentation"><a role="menuitem" tabindex="-1"
									href="http://twitter.com/fat">¿Quiénes Somos?</a></li>
								<li role="presentation"><a role="menuitem" tabindex="-1"
									href="http://twitter.com/fat">Grupo Libertadores</a></li>
								<li role="presentation"><a role="menuitem" tabindex="-1"
									href="http://twitter.com/fat">Libertadores en la sociedad</a></li>
							</ul></li>
						<li class="dropup"><a id="drop5" role="button"
							class="dropdownfondoprimary" data-toggle="dropdown" href="#">Carta<b
								class="caret"></b></a>
							<ul id="menu2" class="dropdown-menu" role="menu"
								aria-labelledby="drop5">
								<li role="presentation"><a role="menuitem" tabindex="-1"
									href="http://twitter.com/fat">Platos de la Selva</a></li>
								<li role="presentation"><a role="menuitem" tabindex="-1"
									href="http://twitter.com/fat">Platos de la Sierra</a></li>
								<li role="presentation"><a role="menuitem" tabindex="-1"
									href="http://twitter.com/fat">Platos de la Costa</a></li>
								<li role="presentation" class="divider"></li>
								<li role="presentation"><a role="menuitem" tabindex="-1"
									href="http://twitter.com/fat">Bebidas</a></li>
							</ul></li>
						<li class="dropup"><a id="drop7" role="button"
							data-toggle="dropdown" href="#">Promociones<b class="caret"></b></a></li>
						<li class="dropup"><a id="drop8" role="button"
							class="dropdownfondoprimary" data-toggle="dropdown" href="#">Convenios
								<b class="caret"></b>
						</a></li>
						<li class="dropup"><a id="drop8" role="button"
							data-toggle="dropdown" href="#">Conocenos<b class="caret"></b></a>
							<ul id="menu3" class="dropdown-menu" role="menu"
								aria-labelledby="drop6">
								<li role="presentation"><a role="menuitem" tabindex="-1"
									href="http://twitter.com/fat">¿Quiénes Somos?</a></li>
								<li role="presentation"><a role="menuitem" tabindex="-1"
									href="http://twitter.com/fat">Grupo Libertadores</a></li>
								<li role="presentation"><a role="menuitem" tabindex="-1"
									href="http://twitter.com/fat">Libertadores en la sociedad</a></li>
							</ul></li>
					</ul>

					<!-- /tabs -->

				</div>
				<li class="divider"></li>
				<li class="divider"></li>
				<div class="col-md-9 column">
					<div id="left_content">
						<div class="content_title">
							<h1>Una organizaciòn estable
								&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;become
								a professional</h1>
						</div>
						<div class="monster_row">
							<div class="monster">
								<div class="monster_picture">

									<img src="../resources/img/analyze.gif">
								</div>

								<div class="monster_description">Every free account comes
									with unlimited domains and easy 1-click registration system.</div>
								<div class="monster_link">
									Create custom DNS records, Nameserver and URL Forwarding in
									real-time - no waiting time. Choose any of the <b>57</b> domain
									extensions available.
								</div>
							</div>
						</div>
						<!--monster_row-->

						<div class="monster_row">
							<div class="monster">
								<div class="monster_picture">
									<img src="../resources/img/enterprise.gif">
								</div>
								<div class="monster_description">If you are looking for
									batch domain registration &amp; setup you will love our PRO
									membership level.</div>
								<div class="monster_link">
									As PRO member you can choose from <b>9</b> extra high-quality
									domain extensions &amp; automate all your domain needs. More
									info <a href="pro_tour.php" style="color: black;">here</a>.
								</div>
							</div>
						</div>

						<!--monster_row-->
						<div class="monster_row">
							<div class="content_title">
								<h1>Nuestros mejores clientes</h1>
							</div>
							<div class="monster_row">
								<div class="monster_message">With over 3.5 million
									registered domains in the past 4 years we have taken the next
									step. As one of the industry leaders in free domain names we
									now create a new standard with the relaunch of our service.</div>
								<img src="../resources/img/news.gif">
							</div>
						</div>
					</div>
					<!--monster_row-->
				</div>
				<div class="col-md-3 column">
					<div class="pie-contactanos">
						<div class="operadora"></div>
						<h4>Contáctanos</h4>
						<div class="llamada">
							<p>Nuestras Operadoras telefónicas</p>
							<em class="pie-icono"></em>
							<p class="pie-numero">311 9000</p>
							<p class="pie-texto">311 9000
								&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;(Lima)</p>
							<p class="pie-texto">0 801 00802 &nbsp;(Provincias)</p>
						</div>
						<div class="contacto-forma">
							<em class="icono-p1"></em>
							<div class="forma-texto">
								<a href="" title="Servicio al cliente">Servicio al cliente</a>
							</div>
							<br class="both">
						</div>
						<div class="contacto-forma">
							<em class="icono-p2"></em>
							<div class="forma-texto sin-border">
								<a href="" title="Nuestros puntos de atención">Nuestros
									puntos de atención</a>
							</div>
							<br class="both">
						</div>
						<!-- <div class="contacto-forma"> <em class="icono-p3"></em> <div class="forma-texto sin-border"><a href="#" title="Chat online">Chat online</a></div> <br class="both" /> </div> -->
						<div class="footer-logo"></div>
					</div>
				</div>
			</div>
		</div>
	</div>

</body>
</html>