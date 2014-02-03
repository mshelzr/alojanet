//DOM ready
$(function () {

	////////////////////////////////////////////////////////////////////
	//Logueo por el navegador										  //
	////////////////////////////////////////////////////////////////////

	//calendario de la busqueda del portal
	$(".input-group.date").datepicker({ autoclose: true, todayHighlight: true, startDate: '-1d' });

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
		if(validarAddAcomp($(this))){
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
				}
			});
		}
	});

	////////////////////////////////////////////////////////////////////
	//Reserva
	////////////////////////////////////////////////////////////////////

	//btnBusquedaRapida
	$('body').on('click','#btnBusquedaRapida',function(){
		validarSinAviso($(this));
	});

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

		var $formrs=$(this).closest('form');
		$formrs.validate({
			errorPlacement: function(error,element){
			},submitHandler: function(form) {
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
			},errorElement:'span'
		});
	});

	$('#contenerCabs').on('click','.btnEscogerCaba', function (e) {
		$(this).parent().parent().parent().parent().children().children('.sinRaya').removeClass('active');
		$(this).parent().parent().toggleClass("active");
		$('#contenerHabs').children('div').remove();
		$("#ambienteCab").val($(this).attr("data-action"));
		jQuery.ajax({ 
			type: "post", 
			url: "buscarHabsReserva.action", 
			dataType:"json",
			data:{desde:$('#desdeCab').val(),hasta:$('#hastaCab').val(),idCab:$('#ambienteCab').val()}, 
			success:function(data){
				mensaje=jQuery.parseJSON(data.message);

				if(mensaje.error!='noResult'){
					var html="";
					$.each(mensaje.ambientes, function(i, field) {			
						html+='<div class="col-xs-6 col-md-4">' +
						'<a href="javascript:void(0)" class="thumbnail btnEscogerHab sinRaya" data-scope='+field.capacidadPersonas+' data-action="'+field.idAmbiente+'">' +
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
		$("#scopePersonasCab").val($(this).attr("data-scope"));
		$("#ambienteCab").val($(this).attr("data-action"));

		$('.btnEscogerHab').removeClass("active");
		$(this).addClass("active");
		$("#panel-acompanantes-hab-searched").removeClass("hidden");
	});

	$('#btnAddAcompCab').on('click', function (e) {
		var este=$(this);
		var scopeTo=$("#scopePersonasCab").val();
		var scopeIn=$("#tablaAcompCab").children('tr').length;
		if($('#incluirme').is(':checked')){
			scopeIn++;
		}

		if(validarAddAcomp(este)){
			if(scopeTo != scopeIn){
				agregarAcomp('Cab');
			}else{
				alert('El número acompañantes ha llegado a su límite.');
			}
		}
	});
	// -FIN CABS	

	//CONVE
	$(".btnEnterConvencion").click(function () {

		var $formrs=$(this).closest('form');
		$formrs.validate({
			errorPlacement: function(error,element){
			},submitHandler: function(form) {

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
								html+='<a href="javascript:void(0)" class="thumbnail sinRaya btnEscogerConve" data-scope='+field.capacidadPersonas+' data-action='+field.idAmbiente+'><li class="media">' +
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
					}, 
					error: function(xhr, textStatus, errorThrown) { 
						console.debug('Error buscarCabReserva!  Status = ' + xhr.status);
					}
				});	
			},errorElement:'span'
		});
	});

	$('body').on('click','.btnEscogerConve', function (e) {
		$("#scopePersonasConve").val($(this).attr("data-scope"));
		$("#ambienteConve").val($(this).attr("data-action"));
		$(this).toggleClass("active");
		$("#panel-acompanantes-cen-searched").removeClass('hidden');
	});

	$('#btnAgregarAcomp-Conve').on('click', function (e) {
		var scopeTo=$("#scopePersonasConve").val();
		var scopeIn=$("#tablaAcompConve").children('tr').length;
		if(validarAddAcomp($(this))){
			if(scopeTo != scopeIn){
				agregarAcomp('Conve');
			}else{
				alert('El número acompañantes ha llegado a su límite.');
			}
		}
	});
	//FIN DEL CONVE

	//AMBIENTE
	$(".btnEnterAmbiente").click(function () {

		if(validarAddAcomp($(this))){

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
					$("#panel-acompanantes-amb-searched").addClass('hidden');		
					$("#panel-tab-ambiente").removeClass('hidden');
				}, 
				error: function(xhr, textStatus, errorThrown) { 
					console.debug('Error buscarCabReserva!  Status = ' + xhr.status);
				}
			});
		}

	});

	$('body').on('click','.btnEscogerAmbiente', function (e) {
		$(this).toggleClass("active");
		$("#ambienteAmbiente").val($(this).attr("data-action"));
		$("#panel-acompanantes-amb-searched").removeClass('hidden');		

	});
	//-FIN DEL AMBIENTE

	//BTNS DE RESERVA
	var paramBasic={};
	var tab=0;

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
		este=$(this);
		var filtrador = false;

		var acomps=[];
		var acompData={};

		if($(this).attr('id')=='btnReservarCab'){

			if(validarTablaAcomps($(this))){
				filtrador = true;

				$.each($('.acompDataCab'), function(im, fieldm) {
					var values = {};		
					$.each($(this).children('td').children('div.divParaModificarInputs').children('input'), function(i, field) {			
						values[$(field).attr('namer')] = field.value;
					});
					acomps.push(values);
				});
				acompData=JSON.stringify(acomps);
				var $incluirme=$('#incluirme').is(':checked');

				paramBasic={idAmbiente:$('#ambienteCab').val(),acompData:acompData,desde:$('#desdeCab').val(),hasta:$('#hastaCab').val(),incluirme:$incluirme};
			}
			tab=1;

		}else if($(this).attr('id')=='btnReservarConve'){

			if(validarTablaAcomps($(this))){
				filtrador = true;
				if($('#incluirme').is(':checked')){
					scopeIn++;
				}

				$.each($('.acompDataConve'), function(im, fieldm) {
					var values = {};		
					$.each($(this).children('td').children('div.divParaModificarInputs').children('input'), function(i, field) {			
						values[$(field).attr('namer')] = field.value;
					});
					acomps.push(values);
				});
				acompData=JSON.stringify(acomps);

				paramBasic={idAmbiente:$('#ambienteConve').val(),acompData:acompData,desde:$('#desdeConve').val(),hasta:$('#hastaConve').val()};
			}
			tab=2;

		}else if($(this).attr('id')=='btnReservarAmbiente'){

			if(validarAddAcomp(este)){

				filtrador = true;
				paramBasic={idAmbiente:$("#ambienteAmbiente").val(),desde:$('#desdeAmbiente').val(),hasta:$('#hastaAmbiente').val()};
			}
			tab=3;
		}

		if(filtrador){		
			//EJECUCIÒN DESPUÉS DE CARGAR LA DATA
			var perfilLoggeado=$('#perfilLoggeado').val();

			if(''==perfilLoggeado || 2==perfilLoggeado){
				$('#modalQuestion').modal('show');
			}else if(1==perfilLoggeado){
				procesarReservaGo(paramBasic);
			}			
		}
	});

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
						'data-dismiss="modal" class="nroReservaSelectedReservaMain" datus='+rs.userTablaRs+' data-action='+f.idreserva+' /></td>' +
						'<td>'+f.idreserva+'</td>' +
						'<td>'+f.nombres+','+f.apepaterno+' '+f.apematerno+'</td>' +
						'<td>'+f.descripcion+' '+f.numdocumento+'</td>' +
						'</tr>';
					});
					$('#tablaReservasActivas').empty();
					$('#tablaReservasActivas').append(html);
					$('#modalReservasActivas').modal('show');
					$('#btnNuevoContenedor').attr('datus',rs.userTablaRs);						
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
		console.info(paramBasic);
		jQuery.ajax({
			type: "post",
			url: getActionTabSelected(),
			dataType:"json",
			data:paramBasic, 
			success:function(data){
				rs=jQuery.parseJSON(data.message);

				if(rs.tablaReservas.length>0){
					var userTablaRs=rs.userTablaRs;
					tablaReservas=rs.tablaReservas[0];
					var html="";
					$.each(rs.tablaReservas, function(i, f) {
						html+='<tr>' +
						'<td><input type="radio" name="nroReservaSelected" ' +
						'data-dismiss="modal" class="nroReservaSelectedReservaMain" datus='+rs.userTablaRs+' data-action='+f.idreserva+' /></td>' +
						'<td>'+f.idreserva+'</td>' +
						'<td>'+f.nombres+','+f.apepaterno+' '+f.apematerno+'</td>' +
						'<td>'+f.descripcion+' '+f.numdocumento+'</td>' +
						'</tr>';
					});

					$('#tablaReservasActivas').empty();
					$('#tablaReservasActivas').append(html);
					$('#modalReservasActivas').modal('show');
					$('#btnNuevoContenedor').attr('datus',userTablaRs);

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

	$('#modalRegister').on('click','#btnRegistrarse', function () {
		var $formrs=$('#registroPersonaXMSS');
		$formrs.validate({
			errorPlacement: function(error,element){
				element.closest('.inputval').append(error);
			},submitHandler: function(form) {
				
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
								var nomComp=$('input[name="nombresr"]').val()+', '+$('input[name="apePaternor"]').val()+' '+$('input[name="apeMaternor"]').val();
								var contra=$('input[name="nombresr"]').val().substring(0,1)+'' + $('input[name="apePaternor"]').val();
								$('#llblNombres').html(nomComp);
								$('#llblEmail').html($('input[name="emailr"]').val());
								$('#llblUser').html($('input[name="emailr"]').val());
								$('#llblPwd').html(contra);								
								
								$('#msjRegistroPersona').removeClass('hidden');
								$('#modalResultado').modal('show');
								$('#idFinA').removeClass('hidden');
								$('#idFinB').addClass('hidden');
								
							}else{
								var nomComp=$('input[name="nombresr"]').val()+', '+$('input[name="apePaternor"]').val()+' '+$('input[name="apeMaternor"]').val();
								var contra=$('input[name="nombresr"]').val().substring(0,1)+'' + $('input[name="apePaternor"]').val();
								$('#llblNombres').html(nomComp);
								$('#llblEmail').html($('input[name="emailr"]').val());
								$('#llblUser').html($('input[name="emailr"]').val());
								$('#llblPwd').html(contra);		
								
								$('#msjRegistroPersona').removeClass('hidden');
								$('#modalResultado').modal('show');
								$('#idFinA').addClass('hidden');
								$('#idFinB').removeClass('hidden');
							}

						}else{
							location.reload();
						}				

					}, 
					error: function(xhr, textStatus, errorThrown) { 
						console.debug('Error procesarReservaCab!  Status = ' + xhr.status);
					}
				});
			},errorElement:'span'
		});
	});

	$('#modalReservasActivas').on('click','.nroReservaSelectedReservaMain', function () {
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
					var h1=mensaje.desde;
					var h2=mensaje.hasta;
					var h3=mensaje.idReserva;
					if(2==perfilLoggeado){
						$('#llblidReserva').html('<small>Nro del grupo de reserva:</small> '+h3+'');
						$('#llblDesde').html(h1);
						$('#llblHasta').html(h2);							
						
						$('#msjReserva').removeClass('hidden');
						$('#modalResultado').modal('show');
						$('#idFinA').removeClass('hidden');
						$('#idFinB').addClass('hidden');
					}else{
						$('#llblidReserva').html('<small>Nro del grupo de reserva:</small> '+h3+'');
						$('#llblDesde').html(h1);
						$('#llblHasta').html(h2);			
						
						$('#modalResultado').modal('show');
						$('#msjReserva').removeClass('hidden');
						$('#idFinB').removeClass('hidden');
						$('#idFinA').addClass('hidden');
					}			
				}else{
					location.reload();
				}
			}, 
			error: function(xhr, textStatus, errorThrown) { 
				console.debug('Error procesarReservaCab!  Status = ' + xhr.status);
			}
		});		
	});
//	-FIN DE NUEVARESERVA	

//	NEUTRO
	$('body').on('click','.btnEliminarRow', function (e) {
		$(this).closest('tr').remove();
	});

//	/////////////////
//	CHECKIN

	//BTONS DE BUSQUEDA
	$('#btnBusquedaReserva').on('click', function (){

		var paginaActual=$('#paginaActual').val();

		var nombres=$('#nombres-search').val();
		var apePaterno=$('#apePaterno-search').val();
		var apeMaterno=$('#apeMaterno-search').val();
		var numero=$('#numero-search').val();

		jQuery.ajax({
			type: "post",
			url: "buscarReserva.action",
			dataType:"json",
			data:{nombres:nombres,apePaterno:apePaterno,apeMaterno:apeMaterno,numero:numero}, 
			success:function(data){
				rs=jQuery.parseJSON(data.message);
				var htmlRow="";
				$('#rowReservaSearched').empty();
				if(rs.dataParaTabla.length>0){
					$.each(rs.dataParaTabla, function(im, f) {
						if(paginaActual=='checkin'){
							if(f.estado==0){
								htmlRow+='<tr>' +
								'<td><input type="radio" name="nroReservaSelected" data-dismiss="modal" data-action='+f.idreserva+' data-idpersona='+f.idpersona+' class="nroReservaSelected"/></td>' +
								'<td>'+f.idreserva+'</td>' +
								'<td>'+f.nombres+' '+f.apepaterno+' '+f.apematerno+'</td>' +
								'<td>'+f.descripcion.substring(0,3)+' '+f.numdocumento+'</td>' +
								'</tr>';
							}
						}else if(paginaActual=='checkout'){
							if(f.estado==1){
								htmlRow+='<tr>' +
								'<td><input type="radio" name="nroReservaSelected" data-dismiss="modal" data-action='+f.idreserva+' data-idpersona='+f.idpersona+' class="nroReservaSelected"/></td>' +
								'<td>'+f.idreserva+'</td>' +
								'<td>'+f.nombres+' '+f.apepaterno+' '+f.apematerno+'</td>' +
								'<td>'+f.descripcion.substring(0,3)+' '+f.numdocumento+'</td>' +
								'</tr>';
							}
						}else{ //GESTIONAR
							htmlRow+='<tr>' +
							'<td><input type="radio" name="nroReservaSelected" data-dismiss="modal" data-action='+f.idreserva+' data-idpersona='+f.idpersona+' class="nroReservaSelected"/></td>' +
							'<td>'+f.idreserva+'</td>' +
							'<td>'+f.nombres+' '+f.apepaterno+' '+f.apematerno+'</td>' +
							'<td>'+f.descripcion.substring(0,3)+' '+f.numdocumento+'</td>' +
							'</tr>';
						}
					});

					$('#rowReservaSearched').append(htmlRow);
					$('#modalSearched').modal('show');
				}else{
					alert('cero valores');
				}

			},error: function(xhr, textStatus, errorThrown) { 
				console.info('Error validarLoginAmbiente!  Status = ' + xhr.status);
			}
		});
//		}
	});

//	AL SELECCIONAR LA RESERVA
	$('body').on('click','.nroReservaSelected', function (e) {
		var paginaActual=$('#paginaActual').val();

		$(".panel-busqueda").addClass("hidden");
		$(".panel-reserva-encontrada").removeClass("hidden");

		var idReserva=$(this).attr('data-action');
		var idPersona=$(this).attr('data-idpersona');
		$('#lblIdReserva').val(idReserva);

		jQuery.ajax({
			type: "post",
			url: "reservaBuscadaSelected.action",
			dataType:"json",
			data:{idReserva:idReserva,idPersona:idPersona}, 
			success:function(data){
				mensaje=jQuery.parseJSON(data.message);

				var htmlRow="";
				if(paginaActual!='gestionar'){
					//CHECK-IN - OUT

					var pers=jQuery.parseJSON(mensaje.pers);
					$('#idPersona').val(pers.idPersona);
					$('#lblNombres').append(pers.nombres);
					$('#lblApellidos').append(pers.apePaterno);
					$('#lblDni').append(pers.numDocumento);
					$('#lblTelf').append(pers.cel);
					$('#lblEmail').append(pers.email);
					$('#lblTotalPagar').text('S/. ' + mensaje.totalPagar + '.00');

					$.each(mensaje.listaDetalles, function(im, f) {
						if(paginaActual=='checkin'){
							if(f.estado==0){
								htmlRow+='<tr>'+
								'<td>'+f.cabLocal+'/'+f.habLocal+'</td>' +
								'<td>'+f.count+'/'+f.acomps+'</td>' +
								'<td>'+f.fec_inicio+'</td>' +
								'<td>'+f.fec_fin+'</td>' +
								'<td><a data-toggle="modal" data-flag='+f.codAmbiente+' data-scope='+f.acomps+' href="#" class="btnModalDetalleReserva" data-action='+f.idDetalleReserva+' > ' +
								'<span class="glyphicon glyphicon-eye-open"></span></a></td>' +
								'</tr>';
							}
						}else{
							if(f.estado==1){
								htmlRow+='<tr>'+
								'<td>'+f.cabLocal+'/'+f.habLocal+'</td>' +
								'<td>'+f.count+'/'+f.acomps+'</td>' +
								'<td>'+f.fec_inicio+'</td>' +
								'<td>'+f.fec_fin+'</td>' +
								'<td><a data-toggle="modal" data-flag='+f.codAmbiente+' href="#" class="btnModalDetalleReservaCheckOut" data-action='+f.idDetalleReserva+' > ' +
								'<span class="glyphicon glyphicon-eye-open"></span></a></td>';
								'</tr>';
							}
						}
					});

					$('#rowDetalleReserva').append(htmlRow);

				}else{
					//AL SELECCIONAR EL RADIO DEL LB RESERVA
					//GESTIONAR
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
							htmlRow+='<td><a data-toggle="modal" href="#" data-action='+f.idDetalleReserva+' class="btnModalDetalleReservaCheckOut"><span ' +
							'class="glyphicon glyphicon-eye-open"></span></a></td>';
							htmlRow+='<td><a href="javascript:void(0);">Check-in </a></td>';
						}else if(f.estado==2){
							htmlRow+='<td><a data-toggle="modal" href="#" data-action='+f.idDetalleReserva+' class="btnModalDetalleReservaCheckOut"><span ' +
							'class="glyphicon glyphicon-eye-open"></span></a></td>';
							htmlRow+='<td><a href="javascript:void(0);">Check-out</a></td>';
						}else if(f.estado==3){
							htmlRow+='<td><a data-toggle="modal" href="#" data-action='+f.idDetalleReserva+' class="btnModalDetalleReservaCheckOut"><span ' +
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
		var paginaActual=$('#paginaActual').val();
		este=$(this);
		$('#tipoAmbiente').val(este.attr('data-flag'));
		$('#dataScope').val(este.attr('data-scope'));

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

				htmlRowHeadTable='<th>Nombres</th>' +
				'<th>A. Paterno</th>' +
				'<th>A. Materno</th>' +
				'<th>Documento</th>' +
				'<th>Nº</th>';

				$('.cabAcomps').html(htmlRowHeadTable);

				$('.thg').remove();
				//logica de tarjeta del checkin
				if((este.attr('data-flag')=='3' || este.attr('data-flag')=='4') && paginaActual!='gestionar' ){
					$('.cabAcomps').append('<th class="thg">Tarjeta</th><th class="thg">Elim.</th>');
					$('#rowInputNumTarjeta').addClass('hidden');
				}else if(este.attr('data-flag')=='2' && paginaActual!='gestionar'){
					$('#rowInputNumTarjeta').removeClass('hidden');
					$('.cabAcomps').append('<th class="thg">Elim.</th>');
				}

				var acomps=jQuery.parseJSON(rs.listaAcompanantes);
				var html='';

				$.each(acomps, function(im, f) {
					html+='<tr  class="acompData">' +
					'<td><div class="divParaModificarInputs">' +
					'<input type="text" disabled class="input-sm" name="nombres" namer="nombres" value="'+f.nombres+'" size="10" />' +
					'</div></td>' +
					'<td><div class="divParaModificarInputs">' +
					'<input type="text" disabled class="input-sm " name="apePaterno" namer="apePaterno" value="'+f.apePaterno+'" size="12"/>' +
					'</div></td>' +
					'<td><div class="divParaModificarInputs">' +
					'<input type="text" disabled class="input-sm " name="apeMaterno" namer="apeMaterno" value="'+f.apeMaterno+'" size="12"/>' +
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
					'<input type="text" disabled class="input-sm" name="numDocumento" namer="numDocumento" value="'+f.numDocumento+'" size="7" />' +
					'</div>' +
					'</td>';
					//num de tarjeta per persona
					if(este.attr('data-flag')!='2' && paginaActual!='gestionar'){
						html+='<td><div class="divParaModificarInputs">' +
						'<input type="text" class="input-sm" name="telf" namer="telf" value="0" size="4" />' +
						'</div>' +
						'</td>';
					}
					html+='<td><a href="javascript:void(0);" class="btnEliminarRowGestion"><span class="glyphicon glyphicon-trash"></span></a></td>' +
					'<td><div class="divParaModificarInputs">' +
					'<input type="hidden" name="idPersona" namer="idPersona" value="'+f.idPersona+'"/>' +
					'</div>' +
					'</td>' +
					'<td class="estadoRastreado"><div class="divParaModificarInputs">' +
					'<input type="hidden" name="estado" namer="estado" value="0" />' +
					'</div></td>' +
					'</tr>';
				});
				if(rs.detalleReserva.count<rs.detalleReserva.capacidadPersonas){
					$('.panelAgregarAcomp').removeClass('hidden');
				}

				$('#contenerParaAgregarAcomp').html(html);

			}, 
			error: function(xhr, textStatus, errorThrown) { 
				console.debug('Error procesarReservaCab!  Status = ' + xhr.status);
			}
		});	

		$('#modalDetalleReserva').modal('show');
	});

//	AGREGAR ACOMPS CHECKIN
	$('body').on('click','#btnAgregarAcomp',function(){
		var number = 1 + Math.floor(Math.random() * 1E6);
		var scopeTo=$('#dataScope').val();
		var scopeIn=$("#contenerParaAgregarAcomp").children('tr').length;

		if(validarAddAcomp($(this),'')){
			if(scopeIn != scopeTo){

				var nombres=$("#inputNombresAcomp").val();
				var apePaterno=$("#inputApePaternoAcomp").val();
				var apeMaterno=$("#inputApeMaternoAcomp").val();
				var tipoDoc=$("#inputTipoDocAcomp").val();
				var doc=$("#inputDocAcomp").val();		

				var paginaActual=$('#paginaActual').val();
				var tipoAmbiente=$('#tipoAmbiente').val();

				var html="";
				html='<tr class="acompData">' +
				'<td><div class="divParaModificarInputs">' +
				'<input type="text" disabled class="input-sm required" name="nombres'+number+'" namer="nombres" value="'+nombres+'" size="10" />' +
				'</div></td>' +
				'<td><div class="divParaModificarInputs">' +
				'<input type="text" disabled class="input-sm required" name="apePaterno'+number+'" namer="apePaterno" value="'+apePaterno+'" size="12"/>' +
				'</div></td>' +
				'<td><div class="divParaModificarInputs">' +
				'<input type="text" disabled class="input-sm required" name="apeMaterno'+number+'" namer="apeMaterno" value="'+apeMaterno+'" size="12"/>' +
				'</div></td>' +
				'<td><div class="divParaModificarInputs">';		
				if(tipoDoc=="DNI"){
					html+='<input type="hidden" name="tipoDoc'+number+'" namer="tipoDoc" value="dni" />'+
					'<select disabled class="input-sm">'+
					'<option>DNI</option>' +
					'<option title="Pasaporte">PASA</option></select>';
				}else{
					html+='<input type="hidden" namer="tipoDoc" name="tipoDoc'+number+'" value="pasap" />'+
					'<select disabled class="input-sm">'+
					'<option title="Pasaporte">PASA</option>' +
					'<option >DNI</option></select>';
				}
				html+='</div>' +
				'</td>' +
				'<td><div class="divParaModificarInputs">' +
				'<input type="text" disabled class="input-sm required" name="numDocumento'+number+'" namer="numDocumento" value="'+doc+'" size="7" />' +
				'</div>' +
				'</td>';
				//num de tarjeta per persona
				if(tipoAmbiente!='2' && paginaActual!='gestionar'){
					html+='<td><div class="divParaModificarInputs">' +
					'<input type="text" class="input-sm required" name="telf'+number+'" namer="telf" value="0" size="4" />' +
					'</div>' +
					'</td>';
				}
				html+='<td><a href="javascript:void(0);" class="btnEliminarRow"><span class="glyphicon glyphicon-trash"></span></a></td>' +
				'<td><div class="divParaModificarInputs">' +
				'<input type="hidden" name="idPersona" namer="idPersona" value="0" />' +
				'</div>' +
				'</td>' +
				'<td class="estadoRastreado"><div class="divParaModificarInputs">' +
				'<input type="hidden" name="estado" namer="estado" value="0" />' +
				'</div>' +
				'</td>' +
				'</tr>';

				$('#contenerParaAgregarAcomp').append(html);
				//clean inputs
				$("#inputNombresAcomp").val("");
				$("#inputApePaternoAcomp").val("");
				$("#inputApeMaternoAcomp").val("");
				$("#inputDocAcomp").val("");
			}else{
				alert('El número acompañantes ha llegado a su límite.');
			}
		}
	});

	$('body').on('click','.btnEliminarRowGestion', function (e) {
		$(this).closest('td').siblings('.estadoRastreado').children('div.divParaModificarInputs').children('input').val('1');
		$(this).closest('tr').addClass('hidden');
	});

	$('body').on('click','#btnSaveModalCheckIn', function (e) {
		var este=$(this);		
		var tarjetaIndividual=$('#numeroTarjeta').val();
//		var tipoAmbiente=$('#tipoAmbiente').val();

		//data del ajax
		var idDetalleReserva=$('#idDetalleReserva').val();
		var idReserva=$('#lblIdReserva').val();
		var idPersona=$('#idPersona').val();

		if(validarTablaAcomps(este)){
			tarjetaIndividual=0;

			var acomps=[];
			var acompData={};

			$.each($('.acompData'), function(im, fieldm) {
				var values = {};		
				$.each($(this).children('td').children('div.divParaModificarInputs').children('input'), function(i, field) {			
					values[$(field).attr('namer')] = field.value;
				});
				acomps.push(values);
			});
			acompData=JSON.stringify(acomps);

			jQuery.ajax({
				type: "post",
				url: "eventCheckIn.action",
				dataType:"json",
				data:{idPersona:idPersona,idReserva:idReserva,idDetalleReserva:idDetalleReserva,acompData:acompData,tarjetaIndividual:tarjetaIndividual}, 
				success:function(data){
					location.reload();
				}, 
				error: function(xhr, textStatus, errorThrown) { 
					console.debug('Error procesarReservaCab!  Status = ' + xhr.status);
				}
			});
		}
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

				htmlRowHeadTable='<th>Nombres</th>' +
				'<th>Tipo Doc</th>' +
				'<th>Nº Documento</th>' +
				'<th>Tarjeta</th>' +
				'<th>Gasto en servicios.</th>' +
				'<th>Detalle</th>';

				$('.cabAcomps').html(htmlRowHeadTable);

				var html="";
				$.each(rs.listaAcompConConsumo, function(im, f) {
					var consumoSoles = f.consumo != null ? f.consumo : "0";

					html+='<tr>'+
					'<td>'+f.nombres+'</td>';
					if(f.idtipodocumento==1){
						html+='<td>DNI</td>';
					}else{
						html+='<td>PASAP</td>';
					}
					html+='<td>'+f.numdocumento+'</td>'+
					'<td><input type="checkbox" disabled checked /></td>'+
					'<td>S/. '+consumoSoles+'.00</td>'+
					'<td><button data-toggle="modal" '+
					'type="button" data-idTarjetaPersona='+f.idtarjetapersona+' class="btn btn-default btn-sm btnCargarConsumo">'+
					'<span class="glyphicon glyphicon-list"></span>'+
					'</button></td>'+
					'</tr>';
				});

				$('#contenerParaAgregarAcomp').html(html);

			}, 
			error: function(xhr, textStatus, errorThrown) { 
				console.debug('Error procesarReservaCab!  Status = ' + xhr.status);
			}
		});	

		$('#modalDetalleReserva').modal('show');
	});

	$('body').on('click','.btnCargarConsumo', function () {
		var idTarjetaPersona=$(this).attr('data-idTarjetaPersona');

		jQuery.ajax({
			type: "post",
			url: "consumoByPersonaTarjeta.action",
			dataType:"json",
			data:{idTarjetaPersona:idTarjetaPersona}, 
			success:function(data){
				rs=jQuery.parseJSON(data.message);
				htmlRowsConsumo="";

				$.each(rs.consumos, function(im, f) {
					htmlRowsConsumo+='<tr>' +
					'<td>'+f.descripcion+'</td>' +
					'<td>S/. '+f.preciograbado+'.00</td>' +
					'<td>'+f.cantidad+'</td>' +
					'<td>S/. '+f.subtotal+'.00</td>' +
					'</tr>';
				});

				$('#contenedorConsumos').empty();
				$('#contenedorConsumos').append(htmlRowsConsumo);
				$('#modalConsumosAcomp').modal('show');
			}, 
			error: function(xhr, textStatus, errorThrown) { 
				console.info('Error btnCargarConsumo!  Status = ' + xhr.status);
			}
		});		
	});

	$('body').on('click','#btnSaveModalCheckOut', function () {
		var idDetalleReserva=$('#idDetalleReserva').val();

		jQuery.ajax({
			type: "post",
			url: "modificarEstadoCheckOut.action",
			dataType:"json",
			data:{val:idDetalleReserva}, 
			success:function(data){
				location.reload();
			}, 
			error: function(xhr, textStatus, errorThrown) { 
				console.info('Error btnSaveModalCheckOut!  Status = ' + xhr.status);
			}
		});		
	});
	// FIN DEL CHECKOUT
	//////////////////////////////////

	/////////////////////////////////////////
	//GESTIONAR
	$('body').on('click','#btnConsultaDisponibilidad',function(){

		if(validarAddAcomp($(this))){
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
						$('#bot-fec_disponible').removeClass('hidden');
						$('#btnSaveModalGestionar').attr('data-action','y');
					}else{
						$('#bot-fec_nondisponible').removeClass('hidden');
					}
				}, 
				error: function(xhr, textStatus, errorThrown) { 
					console.debug('Error procesarReservaCab!  Status = ' + xhr.status);
				}
			});
		}		
	});

//	reutilizar para gestionar 
	$('#btnSaveModalGestionar').on('click', function (e) {
		var disponible=$(this).attr('data-action');

		if(disponible == 'y'){
			var idDetalleReserva=$('#idDetalleReserva').val();
			var desde=$('#lblDesde').val();
			var hasta=$('#lblHasta').val();

			jQuery.ajax({
				type: "post",
				url: "guardarNuevoRangoDeReserva.action",
				dataType:"json",
				data:{value:idDetalleReserva,desde:desde,hasta:hasta}, 
				success:function(data){
					location.reload();
				}, 
				error: function(xhr, textStatus, errorThrown) { 
					console.debug('Error procesarReservaCab!  Status = ' + xhr.status);
				}
			});
		}
	});

//	FIN DE GESTIONAR	
/////////////////////////////////////////////////////


//	ETC
	//Registrar Persona desde el header
	$('body').on('click','#btnRegistro',function(){
		var $formrs=$("#registroPersonaXMS");
		$formrs.validate({
			errorPlacement: function(error,element){
				element.closest('.inputval').append(error);
			},submitHandler: function(form) {

				var v1=$('input[name="nombres"]').val();
				var v2=$('input[name="apePaterno"]').val();
				var v3=$('input[name="apeMaterno"]').val();
				var v4=$('input[name="numDocumento"]').val();
				var v6=$('input[name="telf"]').val();
				var v7=$('input[name="email"]').val();

				$.ajax({
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
			},errorElement:'span'
		});
	});
});

function validarSinAviso(este){
	var $formrs=este.closest('form');
	$formrs.validate({
		errorPlacement: function(error,element){},
		submitHandler: function(form) {
			form.submit();
		}
	});
}

function validarAddAcomp(este){
	var $formrs=este.closest('form');
	$formrs.validate({
		errorPlacement: function(error,element){},
		submitHandler: function(form) {
		},errorElement:'span'
	});
	return $formrs.valid();
}

function validarTablaAcomps(este){

	var $formrs=este.closest('form');
	$formrs.validate({
		submitHandler: function(form) {

		},
		showErrors: function(errorMap, errorList) {
			$.each(this.successList, function(index, value) {
				return $(value).popover("hide");
			});
			return $.each(errorList, function(index, value) {
				var _popover;
				_popover = $(value.element).popover({
					trigger: "manual",
					placement: "top",
					content: value.message,
					template: "<div class=\"popover\"><div class=\"arrow\"></div><div class=\"popover-inner\"><div class=\"popover-content\"><p></p></div></div></div>"
				});
				_popover.data("bs.popover").options.content = value.message;
				return $(value.element).popover("show");
			});
		}
	});

	return $formrs.valid();
}

//UTILITARIO PARA CAB Y CONVE	
function agregarAcomp(three){

	var nombres=$('#inputNombresAcomp'+three+'').val();
	var apePaterno=$('#inputApePaternoAcomp'+three+'').val();
	var apeMaterno=$('#inputApeMaternoAcomp'+three+'').val();
	var tipoDoc=$('#inputTipoDocAcomp'+three+'').val();
	var doc=$('#inputDocAcomp'+three+'').val();

	$('#tablaAcomp'+three+'').append(htmlAgregarAcomp(three, nombres, apePaterno, apeMaterno, tipoDoc, doc));
	//clean inputs
	$('#inputNombresAcomp'+three+'').val("");
	$('#inputApePaternoAcomp'+three+'').val("");
	$('#inputApeMaternoAcomp'+three+'').val("");
	$('#inputDocAcomp'+three+'').val("");
}

function htmlAgregarAcomp(three, nombres, apePaterno, apeMaterno, tipoDoc, doc){
	var number = 1 + Math.floor(Math.random() * 1E6);
	var html="";
	html='<tr class="acompData'+three+'" >' +
	'<td><div class="divParaModificarInputs">' +
	'<input type="text" disabled class="input-sm required" name="nombres'+number+'" namer="nombres" value="'+nombres+'" size="10" />' +
	'</div></td>' +
	'<td><div class="divParaModificarInputs">' +
	'<input type="text" disabled class="input-sm required" name="apePaterno'+number+'" namer="apePaterno" value="'+apePaterno+'" size="12"/>' +
	'</div></td>' +
	'<td><div class="divParaModificarInputs">' +
	'<input type="text" disabled class="input-sm required" name="apeMaterno'+number+'" namer="apeMaterno" value="'+apeMaterno+'" size="12"/>' +
	'</div></td>' +
	'<td><div class="divParaModificarInputs">';		
	if(tipoDoc=="DNI"){
		html+='<input type="hidden" name="tipoDoc'+number+'" namer="tipoDoc" value="dni" />'+
		'<select disabled class="input-sm" >'+
		'<option>DNI</option>' +
		'<option title="Pasaporte">PASA</option></select>';
	}else{
		html+='<input type="hidden" name="tipoDoc'+number+'" namer="tipoDoc" value="pasap" />'+
		'<select disabled class="input-sm" >'+
		'<option title="Pasaporte">PASA</option>' +
		'<option >DNI</option></select>';
	}
	html+='</div>' +
	'</td>' +
	'<td><div class="divParaModificarInputs">' +
	'<input type="text" disabled class="input-sm required number" name="numDocumento'+number+'" namer="numDocumento" value="'+doc+'" size="7" />' +
	'</div>' +
	'</td>' +
	'<td><a href="javascript:void(0);" class="btnEliminarRow"><span class="glyphicon glyphicon-trash"></span></a></td>' +
	'</tr>';		
	return html;
}

jQuery.validator.addMethod("greaterThan", 
		function(value, element, params) {

	if (!/Invalid|NaN/.test(new Date(value))) {
		return new Date(value) > new Date($(params).val());
	}

	return isNaN(value) && isNaN($(params).val()) 
	|| (Number(value) > Number($(params).val())); 
},'Must be greater than {0}.');