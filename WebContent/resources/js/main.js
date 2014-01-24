$(function () {

	////////////////////////////////////////////////////////////////////
	//Logueo por el navegador										  //
	////////////////////////////////////////////////////////////////////

	//calendario de la busqueda del portal
	$(".input-group.date").datepicker({ autoclose: true, todayHighlight: true });

	//camuflaje dialog login nav
	$("#dialogLoginNav").dialog({
		autoOpen: false,   
		draggable: false,
		resizable: false,
		modal: false,
		position: "right top"
	});

	//logueo
	$("#btnLoginNav").click(function () {
		jQuery.ajax({ 
			type: "post", 
			url: "dialogLogueo.action", 
			dataType:"json",
			data:{user:$('#username').val(),pwd:$('#password').val()}, 
			success:function(data){
				mensaje=jQuery.parseJSON(data.mensaje);

				if(mensaje.success=='success'){
					window.location.href = mensaje.urlRedirect; 
				}else if(mensaje.errorpwd=='wrongpwd'){
					$('#btnLoginNav').attr('data-content','Datos Incorrectos.');
					$('#btnLoginNav').popover('toggle');
				}else{
					$('#btnLoginNav').attr('data-content','El usuario no existe.');
					$('#btnLoginNav').popover('toggle');
				}	          
			}, 
			error: function(xhr, textStatus, errorThrown) { 
				console.debug('Error!  Status = ' + xhr.status);
				console.error(textStatus);
				console.error(errorThrown);
			}
		}); 
	});

	////////////////////////////////////////////////////////////////////
	//Reserva
	////////////////////////////////////////////////////////////////////

	//Abrir reserva busqueda rápida
	var flag = $("#flagFromHome").val();
	if(flag != ''){
		var fecInicio=$("#fecInicioFromHome").val();
		var fecInicioFin=$("#fecFinFromHome").val();
		var ambientesFromHome=$("#ambientesFromHome").val();
		if(flag == '1'){
			var ambx=mensaje=jQuery.parseJSON(ambientesFromHome);
			var html="";
			$.each(ambx, function(i, field) {			
				html+='<div class="col-xs-6 col-md-3">' +
				'<a href="javascript:void(0)" class="thumbnail sinRaya">' + 
				'<img src='+field.urlimagen+' />' + 
				'<small><strong>'+ field.numberoLocal+'</strong><br/>'
				+ field.descripcion +'<br/>' +
				'Scope: '+field.capacidadPersonas +' <span class="glyphicon glyphicon-user"></span><br/>' +
				'Desde S/. '+ field.precio+'</small><br/>' +
				'<p><br/>' +
				'<button type="button" class="btn btn-primary btn-xs btnEscogerCaba" data-action="'+field.idAmbiente+'">Escoger</button>' +
				'</p>' +
				'</a>' +
				'</div>';
			});
			$('#contenerCabs').append(html);
			$("#panel-351682").removeClass('hidden');
			$("#panel-element-983044").collapse('show');
			
			$("#desdeCab").val(fecInicio);
			$("#hastaCab").val(fecInicioFin);
		}else if(flag == '2'){
			var ambx=mensaje=jQuery.parseJSON(ambientesFromHome);
			var html="";
			$.each(ambx, function(i, field) {	
				html+='<a href="javascript:void(0)" class="thumbnail sinRaya btnEscogerConve" data-action='+field.idAmbiente+'><li class="media">' +
				'<img class="pull-left" src='+field.urlimagen+' />' +
				'<div class="media-body">' +
				'<h4 class="media-heading">'+field.descripcion+' <button type="button" class="btn btn-primary btn-xs btnEscogerConve" data-action='+field.idAmbiente+'>Escoger</button></h4>' +
				'<p>Cras sit amet nibh libero, in gravida nulla. Nulla vel metus scelerisque ante' +
				'sollicitudin commodo. Cras purus odio, vestibulum in vulputate at, tempus viverra turpis.</p>' +
				'</div>' +
				'<input type="hidden" id="conveSelected" value='+field.idAmbiente+' />' +
				'</li></a>';
			});
			$('#contenedorConvens').append(html);
			
			$("#panel-convencion-searched").removeClass('hidden');
			$("#panel-acompanantes-cen-searched").removeClass('hidden');
			
			$("#desdeConve").val(fecInicio);
			$("#hastaConve").val(fecInicioFin);
		}else if(flag == '3'){
			var ambx=mensaje=jQuery.parseJSON(ambientesFromHome);
			var html="";
			$.each(ambx, function(i, field) {	
				html+='<div class="col-xs-6 col-md-3">' +
				'<a href="javascript:void(0)" data-action='+field.idAmbiente+' class="thumbnail sinRaya btnEscogerAmbiente">' +
				'<img src='+field.urlimagen+' />' +
				'<small><strong>'+field.numberoLocal+'</strong><br/>' 
				+field.descripcion+'<br/>' +
				'Scope: '+field.capacidadPersonas+' Personas<br/>' +
				'Desde S/. '+field.precio+'</small><br/>' +
				'</a>' +
				'</div>';

			});
			$('#contenedorAmbiente').append(html);

			$("#panel-tab-ambiente").removeClass('hidden');
			
			$("#desdeAmbiente").val(fecInicio);
			$("#hastaAmbiente").val(fecInicioFin);
		}	
		

	}//fin de reserv por busqueda rápida

	$("#eventChangeTipoPersona").change(function() {
		var tipoPersona=$('#eventChangeTipoPersona').val();

		if(tipoPersona=='pnatural'){
			$('.pjuridica').hide();
		}else if(tipoPersona=='pjuridica'){
			$('.pjuridica').show();
		}
	});

//	/////////////////////
//	NUEVA RESERVA
	//CABS
	$(".btnBuscarCabs").click(function () {
		$('#contenerCabs').children('div').remove();
		jQuery.ajax({ 
			type: "post", 
			url: "buscarCabReserva.action", 
			dataType:"json",
			data:{desde:$('#desdeCab').val(),hasta:$('#hastaCab').val()}, 
			success:function(data){
				mensaje=jQuery.parseJSON(data.message);

				if(mensaje.error!='noResult'){
					var html="";
					$.each(mensaje.ambientes, function(i, field) {			
						html+='<div class="col-xs-6 col-md-3">' +
						'<a href="javascript:void(0)" class="thumbnail sinRaya">' + 
						'<img src='+field.urlimagen+' />' + 
						'<small><strong>'+ field.numberoLocal+'</strong><br/>'
						+ field.descripcion +'<br/>' +
						'Scope: '+field.capacidadPersonas +' <span class="glyphicon glyphicon-user"></span><br/>' +
						'Desde S/. '+ field.precio+'</small><br/>' +
						'<p><br/>' +
						'<button type="button" class="btn btn-primary btn-xs btnEscogerCaba" data-action="'+field.idAmbiente+'">Escoger</button>' +
						'</p>' +
						'</a>' +
						'</div>';
					});
					$('#contenerCabs').append(html);
				};

				$("#panel-351682").removeClass('hidden');
				$("#panel-element-983044").collapse('show');
			}, 
			error: function(xhr, textStatus, errorThrown) { 
				console.debug('Error buscarCabReserva!  Status = ' + xhr.status);
			}
		});		

	});

	$('#contenerCabs').on('click','.btnEscogerCaba', function (e) {
		$(this).parent().parent().parent().parent().children().children('.sinRaya').removeClass('active');
		$(this).parent().parent().toggleClass("active");
		$('#contenerHabs').children('div').remove();
		$("#ambiente").val($(this).attr("data-action"));
		jQuery.ajax({ 
			type: "post", 
			url: "buscarHabsReserva.action", 
			dataType:"json",
			data:{desde:$('#desdeCab').val(),hasta:$('#hastaCab').val(),idCab:$('#ambiente').val()}, 
			success:function(data){
				mensaje=jQuery.parseJSON(data.message);

				if(mensaje.error!='noResult'){
					var html="";
					$.each(mensaje.ambientes, function(i, field) {			
						html+='<div class="col-xs-6 col-md-4">' +
						'<a href="javascript:void(0)" class="thumbnail btnEscogerHab sinRaya" data-action="'+field.idAmbiente+'">' +
						'<button type="button" class="btn btn-default btn-lg">' +
						'<span class="glyphicon glyphicon-picture"></span>' +
						'</button>' +
						'<small><strong>'+field.numberoLocal+'</strong><br/>' 
						+field.descripcion+'<br/>' +
						'Scope: '+field.capacidadPersonas+' <span class="glyphicon glyphicon-user"></span><br/>' +
						'Desde S/. '+field.precio+'</small>' +
						'</a>' +
						'</div>';
					});
					$('#contenerHabs').append(html);
				};

				$("#panel-acompanantes-hab-searched").addClass("hidden");  //aux
				$("#panel-habs-searched").removeClass("hidden");
				$("#panel-element-983044").collapse('toggle');
			}, 
			error: function(xhr, textStatus, errorThrown) { 
				console.debug('Error buscarHabsReserva!  Status = ' + xhr.status);
			}
		});
	});

	$('#contenerHabs').on('click','.btnEscogerHab', function (e) {

		$("#ambiente").val($(this).attr("data-action"));

		$('.btnEscogerHab').removeClass("active");
		$(this).addClass("active");
		$("#panel-acompanantes-hab-searched").removeClass("hidden");

	});

	$('#btnAgregarAcomp-Cab').on('click', function (e) {

		var nombres=$("#inputNombresAcomp-Cab").val();
		var apePaterno=$("#inputApePaternoAcomp-Cab").val();
		var apeMaterno=$("#inputApeMaternoAcomp-Cab").val();
		var tipoDoc=$("#inputTipoDocAcomp-Cab").val();
		var doc=$("#inputDocAcomp-Cab").val();		

		var html="";
		html='<tr class="acompDataCab">' +
		'<td><div class="divParaModificarInputs">' +
		'<input type="text" disabled class="input-sm" name="nombres" value="'+nombres+'" size="10" />' +
		'</div></td>' +
		'<td><div class="divParaModificarInputs">' +
		'<input type="text" disabled class="input-sm " name="apePaterno" value="'+apePaterno+'" size="12"/>' +
		'</div></td>' +
		'<td><div class="divParaModificarInputs">' +
		'<input type="text" disabled class="input-sm " name="apeMaterno" value="'+apeMaterno+'" size="12"/>' +
		'</div></td>' +
		'<td><div class="divParaModificarInputs">';		
		if(tipoDoc=="DNI"){
			html+='<input type="hidden" name="tipoDoc" value="dni" />'+
			'<select disabled class="input-sm">'+
			'<option>DNI</option>' +
			'<option title="Pasaporte">PASA</option></select>';
		}else{
			html+='<input type="hidden" disabled class="input-sm " name="tipoDoc" value="pasap" />'+
			'<select disabled class="input-sm">'+
			'<option title="Pasaporte">PASA</option>' +
			'<option >DNI</option></select>';
		}
		html+='</div>' +
		'</td>' +
		'<td><div class="divParaModificarInputs">' +
		'<input type="text" disabled class="input-sm" name="numDocumento" value="'+doc+'" size="7" />' +
		'</div>' +
		'</td>' +
		'<td><button type="button" class="btn btn-default btn-sm">' +
		'<span class="glyphicon glyphicon-floppy-save"></span>' +
		'</button></td>' +
		'<td><a href="javascript:void(0);"><span class="glyphicon glyphicon-trash"></span></a></td>' +
		'</tr>';	

		$('#tablaAcompCab').append(html);
		//clean inputs
		$("#inputNombresAcomp-Cab").val("");
		$("#inputApePaternoAcomp-Cab").val("");
		$("#inputApeMaternoAcomp-Cab").val("");
		$("#inputDocAcomp-Cab").val("");	

	});
	// -FIN CABS

	//CONVE
	$(".btnEnterConvencion").click(function () {
		$('#contenedorConvens').children('li').remove();
		jQuery.ajax({ 
			type: "post", 
			url: "buscarConveReserva.action", 
			dataType:"json",
			data:{desde:$('#desdeConve').val(),hasta:$('#hastaConve').val()}, 
			success:function(data){
				mensaje=jQuery.parseJSON(data.message);

				if(mensaje.error!='noResult'){
					var html="";
					$.each(mensaje.ambientes, function(i, field) {	
						html+='<a href="javascript:void(0)" class="thumbnail sinRaya btnEscogerConve" data-action='+field.idAmbiente+'><li class="media">' +
						'<img class="pull-left" src='+field.urlimagen+' />' +
						'<div class="media-body">' +
						'<h4 class="media-heading">'+field.descripcion+' <button type="button" class="btn btn-primary btn-xs btnEscogerConve" data-action='+field.idAmbiente+'>Escoger</button></h4>' +
						'<p>Cras sit amet nibh libero, in gravida nulla. Nulla vel metus scelerisque ante' +
						'sollicitudin commodo. Cras purus odio, vestibulum in vulputate at, tempus viverra turpis.</p>' +
						'</div>' +
						'<input type="hidden" id="conveSelected" value='+field.idAmbiente+' />' +
						'</li></a>';
					});
					$('#contenedorConvens').append(html);
				};

				$("#panel-convencion-searched").removeClass('hidden');
				$("#panel-acompanantes-cen-searched").removeClass('hidden');				
			}, 
			error: function(xhr, textStatus, errorThrown) { 
				console.debug('Error buscarCabReserva!  Status = ' + xhr.status);
			}
		});	
	});

	$('body').on('click','.btnEscogerConve', function (e) {
		$("#ambiente").val($(this).attr("data-action"));
		$(this).toggleClass("active");
	});

	$('#btnAgregarAcomp-Conve').on('click', function (e) {

		var nombres=$("#inputNombresAcomp-Conve").val();
		var apePaterno=$("#inputApePaternoAcomp-Conve").val();
		var apeMaterno=$("#inputApeMaternoAcomp-Conve").val();
		var tipoDoc=$("#inputTipoDocAcomp-Conve").val();
		var doc=$("#inputDocAcomp-Conve").val();		

		var html="";
		html='<tr class="acompDataConve">' +
		'<td><div class="divParaModificarInputs">' +
		'<input type="text" disabled class="input-sm" name="nombres" value="'+nombres+'" size="10" />' +
		'</div></td>' +
		'<td><div class="divParaModificarInputs">' +
		'<input type="text" disabled class="input-sm " name="apePaterno" value="'+apePaterno+'" size="12"/>' +
		'</div></td>' +
		'<td><div class="divParaModificarInputs">' +
		'<input type="text" disabled class="input-sm " name="apeMaterno" value="'+apeMaterno+'" size="12"/>' +
		'</div></td>' +
		'<td><div class="divParaModificarInputs">';		
		if(tipoDoc=="DNI"){
			html+='<input type="hidden" name="tipoDoc" value="dni" />'+
			'<select disabled class="input-sm">'+
			'<option>DNI</option>' +
			'<option title="Pasaporte">PASA</option></select>';
		}else{
			html+='<input type="hidden" disabled class="input-sm " name="tipoDoc" value="pasap" />'+
			'<select disabled class="input-sm">'+
			'<option title="Pasaporte">PASA</option>' +
			'<option >DNI</option></select>';
		}
		html+='</div>' +
		'</td>' +
		'<td><div class="divParaModificarInputs">' +
		'<input type="text" disabled class="input-sm" name="numDocumento" value="'+doc+'" size="7" />' +
		'</div>' +
		'</td>' +
		'<td><button type="button" class="btn btn-default btn-sm">' +
		'<span class="glyphicon glyphicon-floppy-save"></span>' +
		'</button></td>' +
		'<td><a href="javascript:void(0);"><span class="glyphicon glyphicon-trash"></span></a></td>' +
		'</tr>';	

		$('#tablaAcompConve').append(html);
		//clean inputs
		$("#inputNombresAcomp-Conve").val("");
		$("#inputApePaternoAcomp-Conve").val("");
		$("#inputApeMaternoAcomp-Conve").val("");
		$("#inputDocAcomp-Conve").val("");	

	});
	//FIN DEL CONVE

	//AMBIENTE
	$(".btnEnterAmbiente").click(function () {
		$('#contenedorAmbiente').children('div').remove();
		jQuery.ajax({ 
			type: "post",
			url: "buscarAmbienteReserva.action", 
			dataType:"json",
			data:{desde:$('#desdeAmbiente').val(),hasta:$('#hastaAmbiente').val()}, 
			success:function(data){
				mensaje=jQuery.parseJSON(data.message);

				if(mensaje.error!='noResult'){
					var html="";
					$.each(mensaje.ambientes, function(i, field) {	
						html+='<div class="col-xs-6 col-md-3">' +
						'<a href="javascript:void(0)" data-action='+field.idAmbiente+' class="thumbnail sinRaya btnEscogerAmbiente">' +
						'<img src='+field.urlimagen+' />' +
						'<small><strong>'+field.numberoLocal+'</strong><br/>' 
						+field.descripcion+'<br/>' +
						'Scope: '+field.capacidadPersonas+' Personas<br/>' +
						'Desde S/. '+field.precio+'</small><br/>' +
						'</a>' +
						'</div>';

					});
					$('#contenedorAmbiente').append(html);
				};
				$("#panel-tab-ambiente").removeClass('hidden');
			}, 
			error: function(xhr, textStatus, errorThrown) { 
				console.debug('Error buscarCabReserva!  Status = ' + xhr.status);
			}
		});
	});

	$('body').on('click','.btnEscogerAmbiente', function (e) {
		$(this).toggleClass("active");
		$("#ambiente").val($(this).attr("data-action"));	
	});
	//-FIN DEL CONVE

	//BTNS DE RESERVA
	var paramBasic={};
	var tab;

	function getActionTabSelected(){
		if(tab==1){ 
			return "procesarReservaCab";
		}else if(tab==2){ 
			return "procesarReservaConve";
		}else if(tab==3){ 
			return "procesarReservaAmbiente";
		}
	}

	$('.btnReservar').on('click', function () {

		var acomps=[];
		var acompData={};
		var hab=$("#ambiente").val();

		// Data without idReserva
		if($(this).attr('id')=='btnReservarCab'){
			$.each($('.acompDataCab'), function(im, fieldm) {
				var values = {};		
				$.each($(this).children('td').children('div.divParaModificarInputs').children('input'), function(i, field) {			
					values[field.name] = field.value;
				});
				acomps.push(values);
			});
			acompData=JSON.stringify(acomps);

			paramBasic={idAmbiente:hab,acompData:acompData,desde:$('#desdeCab').val(),hasta:$('#hastaCab').val()};
			tab=1;

		}else if($(this).attr('id')=='btnReservarConve'){
			$.each($('.acompDataConve'), function(im, fieldm) {
				var values = {};		
				$.each($(this).children('td').children('div.divParaModificarInputs').children('input'), function(i, field) {			
					values[field.name] = field.value;
				});
				acomps.push(values);
			});
			acompData=JSON.stringify(acomps);

			paramBasic={idAmbiente:hab,acompData:acompData,desde:$('#desdeConve').val(),hasta:$('#hastaConve').val()};
			tab=2;

		}else if($(this).attr('id')=='btnReservarAmbiente'){
			paramBasic={idAmbiente:hab,desde:$('#desdeAmbiente').val(),hasta:$('#hastaAmbiente').val()};
			tab=3;
		}

		var perfilLoggeado=$('#perfilLoggeado').val();

		if(''==perfilLoggeado || 2==perfilLoggeado){
			$('#modalQuestion').modal('show');
		}else if(1==perfilLoggeado){
			procesarReservaGo(paramBasic);
		}

	});

	var tablaReserva;

	function procesarReservaGo(paramBasic){
		paramBasic['flagNivelGetIdResera']="lvlProc";
		jQuery.ajax({
			type: "post",
			url: getActionTabSelected(),
			dataType:"json",
			data:paramBasic, 
			success:function(data){
				rs=jQuery.parseJSON(data.message);
				if(rs.tablaReservas.length>0){
					tablaReservas=rs.tablaReservas[0];
					var html="";
					$.each(rs.tablaReservas, function(i, f) {
						html+='<tr>' +
						'<td><input type="radio" name="nroReservaSelected" ' +
						'data-dismiss="modal" class="nroReservaSelected" data-action='+f.idreserva+' /></td>' +
						'<td>'+f.idreserva+'</td>' +
						'<td>'+f.nombres+','+f.apepaterno+' '+f.apematerno+'</td>' +
						'<td>'+f.descripcion+' '+f.numdocumento+'</td>' +
						'</tr>';
					});
					$('#tablaReservasActivas').empty();
					$('#tablaReservasActivas').append(html);
					$('#modalReservasActivas').modal('show');						
				}else{
					if(rs.result=='success'){
						if(''!=perfilLoggeado){
							$('#modalResultado').modal('show');	
							$('#remplazoSuccessResultCab').removeClass('hidden');
						}else{
							location.href="gestionarReserva.action";
						}
					}else{
						$('#btnLoginReserva').attr('data-content','Datos Incorrectos.');
						$('#btnLoginReserva').popover('toggle');
					}
				}
			}, 
			error: function(xhr, textStatus, errorThrown) { 
				console.debug('Error procesarReservaCab!  Status = ' + textStatus);
			}
		});
	}

	$('#btnLoginReserva').on('click', function () {
		var user=$("#userInput").val();
		var pwd=$("#pwdInput").val();
		paramBasic['user']=user;
		paramBasic['pwd']=pwd;
		paramBasic['flagNivelGetIdResera']="lvlLogin";
		jQuery.ajax({
			type: "post",
			url: getActionTabSelected(),
			dataType:"json",
			data:paramBasic, 
			success:function(data){
				rs=jQuery.parseJSON(data.message);

				if(rs.tablaReservas.length>0){
					tablaReservas=rs.tablaReservas[0];
					var html="";
					$.each(rs.tablaReservas, function(i, f) {
						html+='<tr>' +
						'<td><input type="radio" name="nroReservaSelected" ' +
						'data-dismiss="modal" class="nroReservaSelected" datus='+rs.userTablaRs+' data-action='+f.idreserva+' /></td>' +
						'<td>'+f.idreserva+'</td>' +
						'<td>'+f.nombres+','+f.apepaterno+' '+f.apematerno+'</td>' +
						'<td>'+f.descripcion+' '+f.numdocumento+'</td>' +
						'</tr>';
					});

					$('#tablaReservasActivas').empty();
					$('#tablaReservasActivas').append(html);
					$('#modalReservasActivas').modal('show');
					$('#btnNuevoContenedor').attr('datus',user);
					
				}else{
					if(rs.result=='success'){
						if(''!=perfilLoggeado){
							$('#modalResultado').modal('show');	
							$('#remplazoSuccessResultCab').removeClass('hidden');
						}else{
							location.href="gestionarReserva.action";
						}
					}else{
						$('#btnLoginReserva').attr('data-content','Datos Incorrectos.');
						$('#btnLoginReserva').popover('toggle');
					}
				}
			}, 
			error: function(xhr, textStatus, errorThrown) { 
				console.debug('Error procesarReservaCab!  Status = ' + xhr.status);
			}
		});	
	});

	$('#btnRegistrarse').on('click', function () {
		paramBasic['flagNivelGetIdResera']="lvlRegis";
		paramBasic['nombres']=$('input[name="nombresr"]').val();
		paramBasic['apePaterno']=$('input[name="apePaternor"]').val();
		paramBasic['apeMaterno']=$('input[name="apeMaternor"]').val();
		paramBasic['numDocumento']=$('input[name="numDocumentor"]').val();
		paramBasic['telf']=$('input[name="telfr"]').val();
		paramBasic['email']=$('input[name="emailr"]').val();
		jQuery.ajax({
			type: "post",
			url: getActionTabSelected(),
			data:paramBasic,
			success:function(data){
				rs=jQuery.parseJSON(data.message);

				//cuando el resultado es una discordancia con la bd
				if(rs.result=='success'){
					if(2==rs.perfil){
						$('#modalResultado').modal('show');
					}else{
						location.href="gestionarReserva.action";
					}

				}else{
					$('#remplazoDangerRegistroCab').removeClass('hidden');
				}				

			}, 
			error: function(xhr, textStatus, errorThrown) { 
				console.debug('Error procesarReservaCab!  Status = ' + xhr.status);
			}
		});		
	});

	$('#modalReservasActivas').on('click','.nroReservaSelected', function () {
		paramBasic['flagNivelGetIdResera']="lvlSelect";
		paramBasic['idReserva']=$(this).attr('data-action');
		paramBasic['user']=$(this).attr('datus');
		var perfilLoggeado=$('#perfilLoggeado').val();;	
		
		jQuery.ajax({
			type: "post",
			url: getActionTabSelected(),
			dataType: "json",
			data: paramBasic, 
			success:function(data){
				mensaje=jQuery.parseJSON(data.message);

				//proc el resultado de la valid
				if(mensaje.result=='success'){

					if(2==perfilLoggeado){ //recepcionista
						$('#modalResultado').modal('show');
					}else{
						location.href="gestionarReserva.action";
					}			
				}else{
					$('#remplazoDangerLoginCab').removeClass('hidden');
				}
			}, 
			error: function(xhr, textStatus, errorThrown) { 
				console.debug('Error procesarReservaCab!  Status = ' + xhr.status);
			}
		});		
	});
//	-FIN DE NUEVARESERVA	

//	/////////////////
//	CHECKIN

	//BTONS DE BUSQUEDA
	$('#btnBuscarByIdReserva').on('click', function (){
		var idReserva=$('#idReservaInput').val();
		buscarReserva(1,0,idReserva);
	});

	$('#btnBuscarByNombres').on('click', function (){
		var elselect=$('#comboNombreSelect').val();
		var elinput=$('#nombresBuscarInput').val();
		buscarReserva(2,elselect,elinput);
	});

	$('#btnBuscarByNumDocumento').on('click', function () {
		var tpo=$('#comboDocSelect').val();
		var elinput=$('#docBuscarInput').val();
		buscarReserva(3,tpo,elinput);
	});
	
//	///////////////////////////////////
	//RESULADO DE LA BUSQUEDA DE RESERVA
	function buscarReserva(btn, tipoDoc, value){
		var pagGestionar=$('#flagPagGestionar').val();
		jQuery.ajax({
			type: "post",
			url: "buscarReserva.action",
			dataType:"json",
			data:{btn:btn,tipoDoc:tipoDoc,value:value}, 
			success:function(data){
				mensaje=jQuery.parseJSON(data.message);

				var htmlRow;
				if(pagGestionar!='true'){ //SI LO ENCUENTRA A LA PRIMERA:

					if(mensaje.flag==true){
						var pers=jQuery.parseJSON(mensaje.pers);
						$('#idPersona').val(pers.idPersona);
						$('#lblNombres').append(pers.nombres);
						$('#lblApellidos').append(pers.apePaterno);
						$('#lblDni').append(pers.numDocumento);
						$('#lblTelf').append(pers.cel);
						$('#lblEmail').append(pers.email);					

						var flagCheck=$('#flagCheck').val();
						$.each(mensaje.listaDetalles, function(im, f) {
							if(f.estado==0){
								htmlRow+='<tr>';

//								if(flagCheck!='checkout'){
								htmlRow+='<td><input type="radio" name="val" value='+f.idDetalleReserva+' data-action='+f.idDetalleReserva+' /></td>';
//								}
								htmlRow+='<td>'+f.cabLocal+'/'+f.habLocal+'</td>' +
								'<td>'+f.count+'/'+f.acomps+'</td>' +
								'<td>'+f.fec_inicio+'</td>' +
								'<td>'+f.fec_fin+'</td>';					
								if(flagCheck!='checkout'){
									htmlRow+='<td><a data-toggle="modal" href="#" class="btnModalDetalleReserva" data-action='+f.idDetalleReserva+' > ' +
									'<span class="glyphicon glyphicon-eye-open"></span></a></td>';
								}else{
									htmlRow+='<td><a data-toggle="modal" href="#" class="btnModalDetalleReservaCheckOut" data-action='+f.idDetalleReserva+' > ' +
									'<span class="glyphicon glyphicon-eye-open"></span></a></td>';

								}
								htmlRow+='</tr>';					

								$('#lblIdReserva').val(f.idreserva);
							}
						});

						$('#rowDetalleReserva').append(htmlRow);

						//efecto visual
						$(".panel-busqueda").addClass("hidden");
						$(".panel-reserva-encontrada").removeClass("hidden");					

					}else{
						$('#rowReservaSearched').empty();
						if(mensaje.dataParaTabla.length>0){
							$.each(mensaje.dataParaTabla, function(im, f) {
								htmlRow+='<tr>' +
								'<td><input type="radio" name="nroReservaSelected" data-dismiss="modal" data-action='+f.idreserva+' class="nroReservaSelected"/></td>' +
								'<td>'+f.idreserva+'</td>' +
								'<td>'+f.nombres+' '+f.apepaterno+' '+f.apematerno+'</td>' +
								'<td>'+f.descripcion.substring(0,3)+' '+f.numdocumento+'</td>' +
								'</tr>';
							});

							$('#rowReservaSearched').append(htmlRow);
							$('#modalSearched').modal('show');
						}else{
							alert('cero valores');
						}
					}
				}else{ //si es gestionar

					if(mensaje.flag==true){

						$.each(mensaje.listaDetalles, function(im, f) {
							if(f.estado==0){
								htmlRow+='<tr class="success">';
							}else if(f.estado==1){
								htmlRow+='<tr class="warning">';
							}else if(f.estado==2){
								htmlRow+='<tr class="danger">';
							}else{
								htmlRow+='<tr class="info">';
							}
							
							htmlRow+='<td>'+f.cabLocal+'/'+f.habLocal+'</td>' +
							'<td>'+f.count+'/'+f.acomps+'</td>' +
							'<td>'+f.fec_inicio+'</td>' +
							'<td>'+f.fec_fin+'</td>';
							
							if(f.estado==0){
								htmlRow+='<td><a data-toggle="modal" href="#" data-action='+f.idDetalleReserva+' class="btnModalDetalleReserva"><span ' +
								'class="glyphicon glyphicon-eye-open"></span></a></td>';
								htmlRow+='<td><a href="javascript:void(0);">Por Activar</a></td>';
							}else if(f.estado==1){
								htmlRow+='<td><a data-toggle="modal" href="#" data-action='+f.idDetalleReserva+' class="btnModalDetalleReserva"><span ' +
								'class="glyphicon glyphicon-eye-open"></span></a></td>';
								htmlRow+='<td><a href="javascript:void(0);">Check-in </a></td>';
							}else if(f.estado==2){
								htmlRow+='<td><a disabled data-toggle="modal" data-action='+f.idDetalleReserva+'><span ' +
								'class="glyphicon glyphicon-eye-open"></span></a></td>';
								htmlRow+='<td><a href="javascript:void(0);">Check-out</a></td>';
							}else if(f.estado==3){
								htmlRow+='<td><a data-toggle="modal" href="#" data-action='+f.idDetalleReserva+' class="btnModalDetalleReserva"><span ' +
								'class="glyphicon glyphicon-eye-open"></span></a></td>';
								htmlRow+='<td><a href="javascript:void(0);">Desactivado</a></td>';
							}
							htmlRow+='</tr>';
							$('#lblIdReserva').val(f.idreserva);
						});

						$('#rowDetalleReserva').append(htmlRow);

						//efecto visual
						$(".panel-busqueda").addClass("hidden");
						$(".panel-reserva-encontrada").removeClass("hidden");					

					}else{
						$('#rowReservaSearched').empty();
						if(mensaje.dataParaTabla.length>0){
							$.each(mensaje.dataParaTabla, function(im, f) {
								htmlRow+='<tr>' +
								'<td><input type="radio" name="nroReservaSelected" data-dismiss="modal" data-action='+f.idreserva+' class="nroReservaSelected"/></td>' +
								'<td>'+f.idreserva+'</td>' +
								'<td>'+f.nombres+' '+f.apepaterno+' '+f.apematerno+'</td>' +
								'<td>'+f.descripcion.substring(0,3)+' '+f.numdocumento+'</td>' +
								'</tr>';
							});

							$('#rowReservaSearched').append(htmlRow);
							$('#modalSearched').modal('show');
						}else{
							alert('cero valores');
						}
					}
				}

			}, 
			error: function(xhr, textStatus, errorThrown) { 
				console.debug('Error procesarReservaCab!  Status = ' + xhr.status);
			}
		});
	}

//	AL SELECCIONAR LA RESERVA
	$('body').on('click','.nroReservaSelected', function (e) {
		var pagGestionar=$('#flagPagGestionar').val();
		$(".panel-busqueda").addClass("hidden");
		$(".panel-reserva-encontrada").removeClass("hidden");
		var idReserva=$(this).attr('data-action');
		$('#lblIdReserva').val(idReserva);

		jQuery.ajax({
			type: "post",
			url: "reservaBuscadaSelected.action",
			dataType:"json",
			data:{value:idReserva}, 
			success:function(data){
				mensaje=jQuery.parseJSON(data.message);

				var htmlRow;
				if(pagGestionar!='true'){
					var pers=jQuery.parseJSON(mensaje.pers);
					$('#idPersona').val(pers.idPersona);
					$('#lblNombres').append(pers.nombres);
					$('#lblApellidos').append(pers.apePaterno);
					$('#lblDni').append(pers.numDocumento);
					$('#lblTelf').append(pers.cel);
					$('#lblEmail').append(pers.email);					

					var flagCheck=$('#flagCheck').val();
					$.each(mensaje.listaDetalles, function(im, f) {
						if(f.estado==0){
							htmlRow+='<tr>';

//							if(flagCheck!='checkout'){
							htmlRow+='<td><input type="radio" value='+f.idDetalleReserva+' name="val" data-action='+f.idDetalleReserva+' /></td>';
//							}
							htmlRow+='<td>'+f.cabLocal+'/'+f.habLocal+'</td>' +
							'<td>'+f.count+'/'+f.acomps+'</td>' +
							'<td>'+f.fec_inicio+'</td>' +
							'<td>'+f.fec_fin+'</td>';					
							if(flagCheck!='checkout'){
								htmlRow+='<td><a data-toggle="modal" href="#" class="btnModalDetalleReserva" data-action='+f.idDetalleReserva+' > ' +
								'<span class="glyphicon glyphicon-eye-open"></span></a></td>' +
								'<td><a href="javascript:void(0);"><span class="glyphicon glyphicon-trash"></span></a></td>';
							}else{
								htmlRow+='<td><a data-toggle="modal" href="#" class="btnModalDetalleReservaCheckOut" data-action='+f.idDetalleReserva+' > ' +
								'<span class="glyphicon glyphicon-eye-open"></span></a></td>';

							}
							htmlRow+='</tr>';
						}
					});

					$('#rowDetalleReserva').append(htmlRow);

				}else{
					$.each(mensaje.listaDetalles, function(im, f) {
						if(f.estado==0){
							htmlRow+='<tr class="success">';
						}else if(f.estado==1){
							htmlRow+='<tr class="warning">';
						}else if(f.estado==2){
							htmlRow+='<tr class="danger">';
						}else{
							htmlRow+='<tr class="info">';
						}
						htmlRow+='<td>'+f.cabLocal+'/'+f.habLocal+'</td>' +
						'<td>'+f.count+'/'+f.acomps+'</td>' +
						'<td>'+f.fec_inicio+'</td>' +
						'<td>'+f.fec_fin+'</td>';
						if(f.estado==0){
							htmlRow+='<td><a data-toggle="modal" href="#" data-action='+f.idDetalleReserva+' class="btnModalDetalleReserva"><span ' +
							'class="glyphicon glyphicon-eye-open"></span></a></td>';
							htmlRow+='<td><a href="javascript:void(0);">Por Activar</a></td>';
						}else if(f.estado==1){
							htmlRow+='<td><a data-toggle="modal" href="#" data-action='+f.idDetalleReserva+' class="btnModalDetalleReserva"><span ' +
							'class="glyphicon glyphicon-eye-open"></span></a></td>';
							htmlRow+='<td><a href="javascript:void(0);">Check-in </a></td>';
						}else if(f.estado==2){
							htmlRow+='<td><a data-toggle="modal" href="#" data-action='+f.idDetalleReserva+' class="btnModalDetalleReserva"><span ' +
							'class="glyphicon glyphicon-eye-open"></span></a></td>';
							htmlRow+='<td><a href="javascript:void(0);">Check-out</a></td>';
						}else if(f.estado==3){
							htmlRow+='<td><a data-toggle="modal" href="#" data-action='+f.idDetalleReserva+' class="btnModalDetalleReserva"><span ' +
							'class="glyphicon glyphicon-eye-open"></span></a></td>';
							htmlRow+='<td><a href="javascript:void(0);">Desactivado</a></td>';
						}
						htmlRow+='</tr>';
						$('#lblIdReserva').val(f.idreserva);
					});

					$('#rowDetalleReserva').append(htmlRow);
				}

			}, 
			error: function(xhr, textStatus, errorThrown) { 
				console.debug('Error procesarReservaCab!  Status = ' + xhr.status);
			}
		});
	});

	$('body').on('click','.btnModalDetalleReserva', function () {
		var idDetalleReserva=$(this).attr('data-action');
		$('#idDetalleReserva').val(idDetalleReserva);

		jQuery.ajax({
			type: "post",
			url: "irModalDetalleReserva.action",
			dataType:"json",
			data:{value:idDetalleReserva}, 
			success:function(data){
				rs=jQuery.parseJSON(data.message);
				//limpiamos los anteriores valores
				$('#lblHab').empty();
				$('#lblCapacidad').empty();
				$('#lblDescripcion').empty();

				$('#lblDesde').val(rs.detalleReserva.fec_inicio);
				$('#lblHasta').val(rs.detalleReserva.fec_fin);
				$('#lblHab').append(rs.detalleReserva.habLocal);
				$('#lblCapacidad').append(rs.detalleReserva.capacidadPersonas);
				$('#lblDescripcion').append(rs.detalleReserva.descripcion);			

				var acomps=jQuery.parseJSON(rs.listaAcompanantes);
				var html;

				$.each(acomps, function(im, f) {
					html+='<tr  class="acompData">' +
					'<td><div class="divParaModificarInputs">' +
					'<input type="text" disabled class="input-sm" name="nombres" value="'+f.nombres+'" size="10" />' +
					'</div></td>' +
					'<td><div class="divParaModificarInputs">' +
					'<input type="text" disabled class="input-sm " name="apePaterno" value="'+f.apePaterno+'" size="12"/>' +
					'</div></td>' +
					'<td><div class="divParaModificarInputs">' +
					'<input type="text" disabled class="input-sm " name="apeMaterno" value="'+f.apeMaterno+'" size="12"/>' +
					'</div></td>' +
					'<td><div class="divParaModificarInputs">';		
					if(f.idTipoDocumento==1){
						html+='<input type="hidden" name="tipoDoc" value="dni" />'+
						'<select disabled class="input-sm">'+
						'<option>DNI</option>' +
						'<option title="Pasaporte">PASA</option></select>';
					}else{
						html+='<input type="hidden" disabled class="input-sm " name="tipoDoc" value="pasap" />'+
						'<select disabled class="input-sm">'+
						'<option title="Pasaporte">PASA</option>' +
						'<option >DNI</option></select>';
					}
					html+='</div>' +
					'</td>' +
					'<td><div class="divParaModificarInputs">' +
					'<input type="text" disabled class="input-sm" name="numDocumento" value="'+f.numDocumento+'" size="7" />' +
					'</div>' +
					'</td>' +
					'<td><div class="divParaModificarInputs">' +
					'<input type="hidden" name="idPersona" value="'+f.idPersona+'"/>' +
					'</div>' +
					'</td>' +
					'<td><button type="button" class="btn btn-default btn-sm guardarCambiosAcomp" data-action='+f.idPersona+'>' +
					'<span class="glyphicon glyphicon-floppy-save"></span>' +
					'</button></td>' +
					'<td><a href="javascript:void(0);"><span class="glyphicon glyphicon-trash"></span></a></td>' +
					'</tr>';
				});
				if(rs.detalleReserva.count<rs.detalleReserva.capacidadPersonas){
					$('#panelAgregarAcompCheckIn').removeClass('hidden');
				}

				$('#contenerParaAgregarAcompCheckIn').empty();
				$('#contenerParaAgregarAcompCheckIn').append(html);

			}, 
			error: function(xhr, textStatus, errorThrown) { 
				console.debug('Error procesarReservaCab!  Status = ' + xhr.status);
			}
		});	

		$('#modalDetalleReserva').modal('show');
	});

//	AGREGAR ACOMPS CHECKIN
	$('#btnAgregarAcomp').on('click',function(){
		var nombres=$("#inputNombresAcomp").val();
		var apePaterno=$("#inputApePaternoAcomp").val();
		var apeMaterno=$("#inputApeMaternoAcomp").val();
		var tipoDoc=$("#inputTipoDocAcomp").val();
		var doc=$("#inputDocAcomp").val();		

		var html="";
		html='<tr class="acompData">' +
		'<td><div class="divParaModificarInputs">' +
		'<input type="text" disabled class="input-sm" name="nombres" value="'+nombres+'" size="10" />' +
		'</div></td>' +
		'<td><div class="divParaModificarInputs">' +
		'<input type="text" disabled class="input-sm " name="apePaterno" value="'+apePaterno+'" size="12"/>' +
		'</div></td>' +
		'<td><div class="divParaModificarInputs">' +
		'<input type="text" disabled class="input-sm " name="apeMaterno" value="'+apeMaterno+'" size="12"/>' +
		'</div></td>' +
		'<td><div class="divParaModificarInputs">';		
		if(tipoDoc=="DNI"){
			html+='<input type="hidden" name="tipoDoc" value="dni" />'+
			'<select disabled class="input-sm">'+
			'<option>DNI</option>' +
			'<option title="Pasaporte">PASA</option></select>';
		}else{
			html+='<input type="hidden" disabled class="input-sm " name="tipoDoc" value="pasap" />'+
			'<select disabled class="input-sm">'+
			'<option title="Pasaporte">PASA</option>' +
			'<option >DNI</option></select>';
		}
		html+='</div>' +
		'</td>' +
		'<td><div class="divParaModificarInputs">' +
		'<input type="text" disabled class="input-sm" name="numDocumento" value="'+doc+'" size="7" />' +
		'</div>' +
		'</td>' +
		'<td><div class="divParaModificarInputs">' +
		'<input type="hidden" name="idPersona" value="0" />' +
		'</div>' +
		'</td>' +
		'<td><button type="button" class="btn btn-default btn-sm">' +
		'<span class="glyphicon glyphicon-floppy-save"></span>' +
		'</button></td>' +
		'<td><a href="javascript:void(0);"><span class="glyphicon glyphicon-trash"></span></a></td>' +
		'</tr>';	

		$('#contenerParaAgregarAcompCheckIn').append(html);
		//clean inputs
		$("#inputNombresAcomp").val("");
		$("#inputApePaternoAcomp").val("");
		$("#inputApeMaternoAcomp").val("");
		$("#inputDocAcomp").val("");	
	});

	$('body').on('click','.guardarCambiosAcomp',function(){

		var idDetalleReserva=$('#idDetalleReserva').val();
		var idPersona=$(this).attr('data-action');
		var myObject={};

		myObject['idPersona'] = idPersona;
		$.each($(this).parent().parent().children('td').children('div.divParaModificarInputs').children('input'), function(i, field) {			
			myObject[field.name] = field.value;
		});

		newMyObject=JSON.stringify(myObject);
		jQuery.ajax({
			type: "post",
			url: "guardarAcompByDetalleReserva.action",
			dataType:"json",
			data:{value:newMyObject,aIdParam:idDetalleReserva}, 
			success:function(data){
				mensaje=jQuery.parseJSON(data.message);


			}, 
			error: function(xhr, textStatus, errorThrown) { 
				console.debug('Error procesarReservaCab!  Status = ' + xhr.status);
			}
		});

	});

	$('#btnConsultaDisponibilidad').on('click',function(){
		$('#bot-fec_disponible').addClass('hidden');	
		$('#bot-fec_nondisponible').addClass('hidden');	

		var desde=$('#lblDesde').val();
		var hasta=$('#lblHasta').val();		
		idDetalleReserva=$('#idDetalleReserva').val();

		jQuery.ajax({
			type: "post",
			url: "consultarDisponibilidadAmbiente.action",
			dataType:"json",
			data:{value:idDetalleReserva,desde:desde,hasta:hasta}, 
			success:function(data){
				rs=jQuery.parseJSON(data.message);

				if(rs.flagDisp=='y'){
					$('#bot-fec_disponible').toggleClass('hidden');
					$('#btnSaveModalCheckIn').attr('data-action','y');
				}else{
					$('#bot-fec_nondisponible').toggleClass('hidden');
				}

			}, 
			error: function(xhr, textStatus, errorThrown) { 
				console.debug('Error procesarReservaCab!  Status = ' + xhr.status);
			}
		});
	});
	
	//aqui yo
	$('#btnSaveModalCheckIn').on('click', function (e) {
		var idDetalleReserva=$('#idDetalleReserva').val();
		var idReserva=$('#lblIdReserva').val();
		
		//individual
		var tarjetaIndividual=$('#numeroTarjeta').val();
		var idPersona=$('#idPersona').val();
		
		var acomps=[];
		var acompData={};
		$.each($('.acompData'), function(im, fieldm) {
			var values = {};		
			$.each($(this).children('td').children('div.divParaModificarInputs').children('input'), function(i, field) {			
				values[field.name] = field.value;
			});
			console.info(values);
			acomps.push(values);
		});
		acompData=JSON.stringify(acomps);		
		
		console.info(idDetalleReserva);
		console.info(idReserva);
		console.info(acompData);
		console.info(tarjetaIndividual);
		console.info(idPersona);
		
		jQuery.ajax({
			type: "post",
			url: "eventCheckIn.action",
			dataType:"json",
			data:{idPersona:idPersona,idReserva:idReserva,idDetalleReserva:idDetalleReserva,acompData:acompData,tarjetaIndividual:tarjetaIndividual}, 
			success:function(data){		
			}, 
			error: function(xhr, textStatus, errorThrown) { 
				console.debug('Error procesarReservaCab!  Status = ' + xhr.status);
			}
		});

	});
	
	//leer mas
	$('.btnActivarTextoSobrante').on('click', function (e) {
		$(this).toggle();
		$("#textoSobrante").toggleClass('hidden').collapse('toggle');
	});

	//click input para modificar acomp
	$('body').on('click','.divParaModificarInputs', function (e) {
		$(this).children().removeAttr("disabled");
	});

	// CHECKOUT
	$('.closeModalSegundo').click( function () {
		$('#modalConsumosAcomp').modal('hide');
	});
	
	$('body').on('click','.btnModalDetalleReservaCheckOut', function () {
		var idDetalleReserva=$(this).attr('data-action');
		$('#idDetalleReserva').val(idDetalleReserva);

		jQuery.ajax({
			type: "post",
			url: "irModalDetalleReservaCheckOut.action",
			dataType:"json",
			data:{value:idDetalleReserva}, 
			success:function(data){
				rs=jQuery.parseJSON(data.message);
				//limpiamos los anteriores valores
				$('#lblHab').empty();
				$('#lblCapacidad').empty();
				$('#lblDescripcion').empty();

				$('#lblDesde').val(rs.detalleReserva.fec_inicio);
				$('#lblHasta').val(rs.detalleReserva.fec_fin);
				$('#lblHab').append(rs.detalleReserva.habLocal);
				$('#lblCapacidad').append(rs.detalleReserva.capacidadPersonas);
				$('#lblDescripcion').append(rs.detalleReserva.descripcion);			

				var html;
				$.each(rs.listaAcompConConsumo, function(im, f) {
					html+='<tr>'+
					'<td>'+f.nombres+'</td>';
					if(f.idtipodocumento==1){
						html+='<td>DNI</td>';
					}else{
						html+='<td>PASAP</td>';
					}
					html+='<td>'+f.numdocumento+'</td>'+
					'<td><input type="checkbox" disabled checked /></td>'+
					'<td>'+f.consumo+'</td>'+
					'<td><button data-toggle="modal" href="#modalConsumosAcomp"'+
							'type="button" class="btn btn-default btn-sm">'+
							'<span class="glyphicon glyphicon-list"></span>'+
						'</button></td>'+
					'</tr>';
				});
				
				$('#contenerParaAgregarAcomp').empty();
				$('#contenerParaAgregarAcomp').append(html);

			}, 
			error: function(xhr, textStatus, errorThrown) { 
				console.debug('Error procesarReservaCab!  Status = ' + xhr.status);
			}
		});	

		$('#modalDetalleReserva').modal('show');
	}); // FIN DEL CHECKOUT

	//spinner para la limpieza de habitaciones
	var spinner1 = $( "#spinner1" ).spinner();
	var spinner2 = $( "#spinner2" ).spinner();
	var spinner3 = $( "#spinner3" ).spinner();

	$( "#setvalue1" ).click(function() {
		spinner1.spinner( "value", 12 );
	});

	$( "#setvalue2" ).click(function() {
		spinner2.spinner( "value", 8 );
	});

	$( "#setvalue3" ).click(function() {
		spinner3.spinner( "value", 8 );
	});
	
	//Registrar Persona desde el header
	$('#btnRegistro').on('click',function(){
		var v1=$('input[name="nombres"]').val();
		var v2=$('input[name="apePaterno"]').val();
		var v3=$('input[name="apeMaterno"]').val();
		var v4=$('input[name="numDocumento"]').val();
		var v6=$('input[name="telf"]').val();
		var v7=$('input[name="email"]').val();
		
		jQuery.ajaxSubmit({
			type: "post",
			url: "registro.action",
			dateType:"json",
			data:{nombres:v1,apePaterno:v2,apeMaterno:v3,numDocumento:v4,telf:v6,email:v7}, 
			success:function(data){
				rs=jQuery.parseJSON(data.mensaje);
				if(rs.result=='success'){
					location.href="agregarReserva.action";
				}else{
					console.info('error');
				}

			}, 
			error: function(xhr, textStatus, errorThrown) { 
				console.debug('Error procesarReservaCab!  Status = ' + xhr.status);
			}
		});	
		

		
//		reutilizar para gestionar 
//		$('#btnSaveModalCheckIn').on('click', function (e) {
//			var disponible=$(this).attr('data-action');
	//
//			if(disponible){
//				var idDetalleReserva=$('#idDetalleReserva').val();
//				var desde=$('#lblDesde').val();
//				var hasta=$('#lblHasta').val();
	//
//				jQuery.ajax({
//					type: "post",
//					url: "guardarNuevoRangoDeReserva.action",
//					dataType:"json",
//					data:{value:idDetalleReserva,desde:desde,hasta:hasta}, 
//					success:function(data){
	//
//					}, 
//					error: function(xhr, textStatus, errorThrown) { 
//						console.debug('Error procesarReservaCab!  Status = ' + xhr.status);
//					}
//				});
//			}
//		});
		
		
		
	});
});