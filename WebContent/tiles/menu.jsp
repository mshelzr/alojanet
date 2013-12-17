<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>

<div class="panel-group" id="panel-679024">
	<div class="panel panel-default">
		<div class="panel-heading">
			<a class="panel-title" data-parent="#panel-679024" href="javascript:void(0);">Inicio</a>
		</div>
	</div>
	<c:choose>
		<c:when test="${not empty s_usuario.idUsuario}">
			<c:set var="count" value="635208" scope="page" />

			<c:forEach var="p" items="${s_menuPadre}">
				<div class="panel panel-default">
					<div class="panel-heading">
						<a class="panel-title" data-toggle="collapse"
							data-parent="#panel-679024" href="#panel-element-${count}"> <c:out
								value="${p.label}" />
						</a>
					</div>
					<div id="panel-element-${count}" class="panel-collapse collapse <c:if test="${count == 635208 }">in</c:if>">
						<c:forEach var="h" items="${s_menuHijo}">
							<div class="panel-body">
								<a href="${h.description}"><c:out value="${h.label}" /></a>
							</div>
						</c:forEach>
					</div>
				</div>
				<c:set var="count" value="${count + 1}" scope="page" />
			</c:forEach>
		</c:when>
		<c:otherwise>
			<div class="panel panel-default">
				<div class="panel-heading">
					<a class="panel-title" data-toggle="collapse"
						data-parent="#panel-679024" href="#panel-element-635208">Reserva</a>
				</div>
				<div id="panel-element-635208" class="panel-collapse collapse in">
					<div class="panel-body"><a href="agregarReserva.action">Abrir Reserva</a></div>
					<div class="panel-body"><a href="#">...</a></div>
				</div>
			</div>
			<div class="panel panel-default">
				<div class="panel-heading">
					<a class="panel-title" data-toggle="collapse"
						data-parent="#panel-679024" href="#panel-element-635209">Carta</a>
				</div>
				<div id="panel-element-635209" class="panel-collapse collapse">
					<div class="panel-body"><a href="#">...</a></div>
				</div>
			</div>
		</c:otherwise>
	</c:choose>
	<!-- without session -->

</div>