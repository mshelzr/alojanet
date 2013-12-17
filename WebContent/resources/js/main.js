$(function () {
	$("#alojantedata").dialog({
		autoOpen: false,
		modal: true
	});	
	$("#question").dialog({
		autoOpen: false,
		modal: true
	});	
	$("#dialogLogueo").dialog({
		autoOpen: false,
		modal: true
	});	
	$("#agregarReserva").dialog({
		autoOpen: false,
		modal: true
	});
	$("#modificarReserva").dialog({
		autoOpen: false,
		modal: true
	});

	$("#btnGuardarCambios").click(function () {
		$("#question").dialog("option", "width", 380);
		$("#question").dialog("open");
	});

	$("#myself").change(function() {
		var tipoPersona=$('#myself').val();

		if(tipoPersona=='pnatural'){
			$('.pjuridica').hide();
		}else if(tipoPersona=='pjuridica'){
			$('.pjuridica').show();
		}
	});
	$("#btnLogueo").click(function () {
		$("#dialogLogueo").dialog("open");
	});
	$("#btnQuestion").click(function () {
		$("#alojantedata").dialog("option", "width", 600);
		$("#alojantedata").dialog("option", "height", 467);
		$("#alojantedata").dialog("open");
	});
	$("#Registrar").click(function () {
		alert('¡Usuario Creado! Usuario: lgonzales Contrasena: lgonzales. Conserve estos datos para la gestión de su reserva');
	});
	$(".btnGeneralDeReserva").click(function () {
		$('#question').dialog('close');
		$('#alojantedata').dialog('close');
		$('#pool').show('slow');
		$('#pool').focus();
		restablecerTodo();
		document.formReserva.reset();
	});
	
	$("#btnGeneralDeReservaLogin").click(function () {
		$('#question').dialog('close');
		$('#dialogLogueo').dialog('close');
		$('#pool').show('slow');
		$('#pool').focus();
		restablecerTodo();
		document.formReserva.reset();
	});
	
	//dialog login nav
	$("#dialogLoginNav").dialog({
		autoOpen: false,   
		draggable: false,
		resizable: false,
		modal: false,
		position: "right top"
	});
	$("#linkLogeo").click(function () {
    	$('#resultLogin').empty();
		document.login.reset();
		
		$('#dialogLoginNav').dialog('open');
	});
	$("#btnLoginNav").click(function () {
		
		jQuery.ajax({ 
	        type: "post", 
	        url: "dialogLogueo.action", 
	        dataType:"json",
	        data:{username:$('#username').val(),password:$('#password').val()}, 
	        success:function(data){
	        	$('#resultLogin').empty();
	        	mensaje=jQuery.parseJSON(data.mensaje);

	            if(mensaje.success=='success'){
	            	window.location.href = mensaje.urlRedirect; 
	            }else if(mensaje.errorpwd=='wrongpwd'){
	            	$('#resultLogin').append("Datos Incorrectos");
	            }else{
	            	$('#resultLogin').append("El usuario no existe");
	 	           
	            }	          
	        }, 
	        error: function(xhr, textStatus, errorThrown) { 
	            console.info('Error!  Status = ' + xhr.status); 
	         }

	    }); 
	});
	$("#btnCargarCabanas").click(function () {
		$('#cargarCabanas').show('slow');
	});
	$(".linkCargarCabanas").click(function () {
		$('#cargarHabitaciones').show('slow');
	});
	$(".linkCargarAcompanantes").click(function () {
		$('#cargarAcompanantes').show('slow');
		$('#btnGuardarCambios').show();
	});
	$("#btnBuscarCabanasRecreacion").click(function () {
		$('#cargarCabanasRecreacion').show('slow');
	});

	//GS
	$(".linkCargarAcompanantesGS").click(function () {
		$('#cargarAcompanantes').show('slow');
		$('#btnAgregarReservaGS').show();
	});
	$(".linkCargarAcompanantesCabanaGS").click(function () {
		$('#cargarAcompanantesRecreacion').show('slow');
		$('#btnAgregarReservaGS').show();
	});
	$("#btnBuscarCabanasAmbienteGS").click(function () {
		$('#btnAgregarReservaGS').show();
	});

	$(".linkCargarAcompanantesCabana").click(function () {
		$('#cargarAcompanantesRecreacion').show('slow');
		$('#btnGuardarCambios').show();
	});
	$("#btnBuscarCabanasAmbiente").click(function () {
		$('#cargarCabanasAmbiente').show('slow');
	});
	$("#linkCargarBtnGuardarCambios").click(function () {
		$('#btnGuardarCambios').show();
	});	

	$("#evaluarObjBuscado").click(function () {
		evaluarBuscado();
	});
	$(".searched").click(function () {
		$('#clientesEncontrados').hide();
		$('#partBuscarReserva').hide();
		$('#partSearched').show();
		$('#reservasDelClienteBuscado').show('slow');

	});
	$(".searchedGestionar").click(function () {
		$('#clientesEncontrados').hide();
		$('#partBuscarReserva').hide();
		$('#partSearched').show();
		$('#gestionarReserva').show('slow');

	});
	$(".linkListaAcomIn").click(function () {
		$('#acompanantesCheckIn').show('slow');

	});
	$(".modificarReservaGestionarReserva").click(function () {
		$('#modificarReserva').dialog('open');
		$('#modificarReserva').dialog('option', 'width', 600);
		$('#modificarReserva').dialog('option', 'height', 650);
	});

	$("#agregarNuevaReserva").click(function () {
		$('#agregarReserva').dialog('open');
		$('#agregarReserva').dialog('option', 'width', 610);
		$('#agregarReserva').dialog('option', 'height', 650);
	});
	$("#btnGuardarCambiosB").click(function () {
		$('#modificarReserva').dialog('close');
	});
	$("#btnAgregarReservaGS").click(function () {
		$("#agregarReserva").dialog("close");
	});
});

function restablecerTodo(){
	$('#cargarCabanas').hide();
	$('#cargarHabitaciones').hide();
	$('#cargarAcompanantes').hide();

	$('#cargarCabanasRecreacion').hide();
	$('#cargarAcompanantesRecreacion').hide();

	$('#cargarCabanasAmbiente').hide();
}
function cambiarPorTipoDeActor(){
	var opcionActor=$('#opcionActor').val();

	if(opcionActor=='1'){
		$('#busquedaPorRecepcionista').show();
	}else if(opcionActor=='2'){
		$('#busquedaPorRecepcionista').hide();
		$('#gestionarReserva').show();
	}
}
function evaluarBuscado(){
	$('#clientesEncontrados').hide();
	$('#clienteNoEncontrado').hide();
	var nombre=$('#nombres').val();

	if(nombre=='Garcia'){
		$('#clientesEncontrados').show('slow');
	}
	else{
		$('#clienteNoEncontrado').show('slow');
	}
}

function cambiarPorTipoDeBusqueda(){
	var tipoPersona=$('#tipoPersonaBusqueda').val();

	if(tipoPersona=='persona'){
		$('#bempresa').hide();
		$('#bpersona').show();
	}else if(tipoPersona=='empresa'){
		$('#bpersona').hide();
		$('#bempresa').show();
	}
}