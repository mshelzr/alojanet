<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>

<%@ page import="com.google.gson.Gson"%>
<%@ page import="com.google.gson.reflect.TypeToken"%>
<%@ page import="java.util.List"%>
<%@ page import="pe.libertadores.dto.MenuDTO"%>

<div class="panel-group" id="panel-679024">
	<div class="panel panel-default">
		<div class="panel-heading">
			<a class="panel-title" data-parent="#panel-679024"
				href="home.action">Inicio</a>
		</div>
	</div>
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
			<div class="panel panel-default">
				<div class="panel-heading">
					<a class="panel-title" data-toggle="collapse"
						data-parent="#panel-679024" href="#panel-element-${count}"> <c:out
							value="<%=mp.getLabel()%>" />
					</a>
				</div>
				<div id="panel-element-${count}"
					class="panel-collapse collapse <c:if test="${count == 635208 }">in</c:if>">
					<%-- 						<c:forEach var="h" items="${s_menuHijo}"> --%>
					<%
						String jsMenuHijo = (String) pageContext
											.getAttribute("jsmHijo");

									List<MenuDTO> listMenuHijo = gs.fromJson(jsMenuHijo,
											new TypeToken<List<MenuDTO>>() {
											}.getType());
									for (MenuDTO mh : listMenuHijo) {
					%>
					<div class="panel-body">
						<a href="<%=mh.getDescription()%>">&nbsp;<c:out
								value="<%=mh.getLabel()%>" /></a>
					</div>
					<%
						}
					%>
				</div>
			</div>
			<c:set var="count" value="${count + 1}" scope="page" />
			<%
				}
			%>
		</c:when>
		<c:otherwise>
			<div class="panel panel-default">
				<div class="panel-heading">
					<a class="panel-title" data-toggle="collapse"
						data-parent="#panel-679024" href="#panel-element-635208">Reserva</a>
				</div>
				<div id="panel-element-635208" class="panel-collapse collapse in">
					<div class="panel-body">
						<a href="agregarReserva.action">Abrir Reserva</a>
					</div>
					<div class="panel-body">
						<a href="#">...</a>
					</div>
				</div>
			</div>
			<div class="panel panel-default">
				<div class="panel-heading">
					<a class="panel-title" data-toggle="collapse"
						data-parent="#panel-679024" href="#panel-element-635209">Carta</a>
				</div>
				<div id="panel-element-635209" class="panel-collapse collapse">
					<div class="panel-body">
						<a href="#">...</a>
					</div>
				</div>
			</div>
		</c:otherwise>
	</c:choose>
	<!-- without session -->

</div>