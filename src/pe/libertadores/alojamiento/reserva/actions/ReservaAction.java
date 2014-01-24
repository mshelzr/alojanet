package pe.libertadores.alojamiento.reserva.actions;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.Cookie;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import net.sf.json.JSONObject;

import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;
import org.apache.struts2.ServletActionContext;
import org.apache.struts2.convention.annotation.Action;
import org.apache.struts2.convention.annotation.ParentPackage;
import org.apache.struts2.convention.annotation.Result;

import pe.libertadores.alojamiento.reserva.daos.ReservaDao;
import pe.libertadores.alojamiento.seguridad.dao.UsuarioDao;
import pe.libertadores.dto.AmbienteDTO;
import pe.libertadores.dto.ClienteDTO;
import pe.libertadores.dto.DetalleReservaDTO;
import pe.libertadores.dto.PersonaDTO;
import pe.libertadores.dto.ReservaDTO;

import com.google.gson.Gson;
import com.google.gson.reflect.TypeToken;
import com.opensymphony.xwork2.ActionSupport;

@SuppressWarnings("serial")
@ParentPackage(value="alojamiento")
public class ReservaAction extends ActionSupport {

	private static final Log _log = LogFactory.getLog(ReservaAction.class);

	private ReservaDao rdao=new ReservaDao();
	private UsuarioDao udao=new UsuarioDao();
	private String fInicio="";
	private String fFin="";
	private int flagBusquedaHome=0;
	private String message;
	private String tpoAmb;
	private String ambientesFromHome;	

	//transp ajax
	private String idReserva;
	private String idAmbiente;
	private String acompData;
	private String desde;
	private String hasta;
	
	//from login
	private String user;
	private String pwd;

	//registro
	private String nombres;
	private String apePaterno;
	private String apeMaterno;
	private String numDocumento;
	private int telf;
	private String email;

	private String flagNivelGetIdResera;

	@Action(value="/agregarReserva",results={@Result(location="reserva",name="success",type="tiles")})
	public String agregarReserva(){
		Gson gs=new Gson();

		List<AmbienteDTO> ambientes=new ArrayList<AmbienteDTO>();
		List<AmbienteDTO> ambienteCabs=new ArrayList<AmbienteDTO>();
		if(!"".equals(fInicio) && !"".equals(fFin)){
			if(tpoAmb.equals("1")){
				ambientes=rdao.buscarCabsDeReserva(fInicio, fFin);
				
				for (AmbienteDTO ambienteDTO : ambientes) {
					ambienteCabs.add(ambienteDTO.getAmbienteDTO());
				}
				ambientes=new ArrayList<AmbienteDTO>();
				for (AmbienteDTO ambCab : ambienteCabs) {
					boolean repetido=false;
					for (int i = 0; i < ambientes.size(); i++) {
						AmbienteDTO mnt = ambientes.get(i);
						if(ambCab.getIdAmbiente()==mnt.getIdAmbiente()){
							repetido=true;
						}
					}

					if(!repetido){
						ambientes.add(ambCab);
					}
				}
				ambientesFromHome=gs.toJson(ambientes);
				flagBusquedaHome=1;
				
			}else if(tpoAmb.equals("2")){
				ambientes=rdao.buscarConveDeReserva(fInicio, fFin);
				flagBusquedaHome=2;
				ambientesFromHome=gs.toJson(ambientes);
			}else{
				ambientes=rdao.buscarAmbienteDeReserva(fInicio, fFin);
				flagBusquedaHome=3;
				ambientesFromHome=gs.toJson(ambientes);
			}			
		}
		return SUCCESS;
	}

	//CABS
	@Action(value="buscarCabReserva", results = { @Result(name = "success", type = "json") })
	public String buscarCab(){

		HttpServletResponse response= ServletActionContext.getResponse();
		response.setContentType("text/html");

		List<AmbienteDTO> ambientes=new ArrayList<AmbienteDTO>();
		List<AmbienteDTO> ambienteCabs=new ArrayList<AmbienteDTO>();
		List<AmbienteDTO> ambienteCabsFiltrados=new ArrayList<AmbienteDTO>();
		List<AmbienteDTO> ambienteHabs=new ArrayList<AmbienteDTO>();
		ambientes=rdao.buscarCabsDeReserva(desde, hasta);

		for (AmbienteDTO ambienteDTO : ambientes) {
			ambienteCabs.add(ambienteDTO.getAmbienteDTO());
			ambienteHabs.add(ambienteDTO);
		}

		//eliminamos las cabs repetidas
		for (AmbienteDTO ambCab : ambienteCabs) {
			boolean repetido=false;

			for (int i = 0; i < ambienteCabsFiltrados.size(); i++) {
				AmbienteDTO mnt = ambienteCabsFiltrados.get(i);
				if(ambCab.getIdAmbiente()==mnt.getIdAmbiente()){
					repetido=true;
				}
			}

			if(!repetido){
				ambienteCabsFiltrados.add(ambCab);

			}
		}
		Map<String,Object> resultMap=new HashMap<String,Object>();

		Gson gs=new Gson();
		//cookies
		Cookie cokHabsBuCab=new Cookie("habsBuCab", gs.toJson(ambienteHabs));
		cokHabsBuCab.setMaxAge(60*60);
		response.addCookie(cokHabsBuCab);

		if(0!=ambienteCabsFiltrados.size()){
			resultMap.put("ambientes", ambienteCabsFiltrados);
		}else{
			resultMap.put("error", "noResult");
		}

		this.setMessage(gs.toJson(resultMap));
		return SUCCESS;
	}

	//CABS HABS
	@Action(value="buscarHabsReserva", results = { @Result(name = "success", type = "json") })
	public String buscarHabsReserva(){
		HttpServletRequest request = ServletActionContext.getRequest();

		List<AmbienteDTO> ambientes=new ArrayList<AmbienteDTO>();
		List<AmbienteDTO> listAmbs=new ArrayList<AmbienteDTO>();
		ambientes=rdao.buscarCabsDeReserva(desde, hasta);

		for (AmbienteDTO ambienteDTO : ambientes) {
			listAmbs.add(ambienteDTO);
		}

		int idCab=Integer.parseInt(request.getParameter("idCab"));
		List<AmbienteDTO> ambsByIdCab=new ArrayList<AmbienteDTO>();

		for (AmbienteDTO amb : listAmbs) {
			if(amb.getAmbienteDTO().getIdAmbiente()==idCab){
				ambsByIdCab.add(amb);
			}
		}

		Map<String,Object> resultMap=new HashMap<String,Object>();

		if(0!=ambsByIdCab.size()){
			resultMap.put("ambientes", ambsByIdCab);
		}else{
			resultMap.put("error", "noResult");
		}

		JSONObject js=JSONObject.fromObject(resultMap);
		this.setMessage(js.toString());
		return SUCCESS;
	}

	//CONVE
	@Action(value="buscarConveReserva", results = { @Result(name = "success", type = "json") })
	public String buscarConve(){

		List<AmbienteDTO> ambientes=new ArrayList<AmbienteDTO>();
		ambientes=rdao.buscarConveDeReserva(desde, hasta);

		Map<String,Object> resultMap=new HashMap<String,Object>();

		if(0!=ambientes.size()){
			resultMap.put("ambientes", ambientes);
		}else{
			resultMap.put("error", "noResult");
		}

		JSONObject js=JSONObject.fromObject(resultMap);
		this.setMessage(js.toString());
		return SUCCESS;
	}

	//AMBIENTE
	@Action(value="buscarAmbienteReserva", results = { @Result(name = "success", type = "json") })
	public String buscarAmbiente(){
		HttpServletResponse response= ServletActionContext.getResponse();
		response.setContentType("text/html");

		List<AmbienteDTO> ambientes=new ArrayList<AmbienteDTO>();
		ambientes=rdao.buscarAmbienteDeReserva(desde, hasta);

		Map<String,Object> resultMap=new HashMap<String,Object>();

		if(0!=ambientes.size()){
			resultMap.put("ambientes", ambientes);
		}else{
			resultMap.put("error", "noResult");
		}

		JSONObject js=JSONObject.fromObject(resultMap);
		this.setMessage(js.toString());
		_log.info(js.toString());
		return SUCCESS;
	}

	//COMMIT CAB
	@Action(value="procesarReservaCab", results = { @Result(name = "success", type = "json") })
	public String procesarReservaCab(){
		_log.info("procesarReservaCab");

		//data logica
		HttpServletRequest request = ServletActionContext.getRequest();
		HttpServletResponse response = ServletActionContext.getResponse();
		List<Map<String, Object>> rs=null;
		Gson gs=new Gson();

		//data negocio
		List<PersonaDTO> listAmbs = gs.fromJson(acompData,new TypeToken<List<PersonaDTO>>(){}.getType());

		//data result
		Map<String,Object> rt=new HashMap<String,Object>();

		//		objetivo: obtener el idReserva para insertar
		if("lvlProc".equals(flagNivelGetIdResera)){
			String idUsuario=MyUtil.getValueCookie(request, "idUsuario");
			rs=rdao.buscarReservaByLogged(Integer.parseInt(idUsuario));
			if(rs.size()>0){
				rt.put("tablaReservas", rs);
			}else{
				_log.info("insers proc cab");
				ClienteDTO cli=udao.getClienteByIdUsuario(idUsuario);
				
				ReservaDTO r=new ReservaDTO();
				r.setClienteDTO(cli);
				
				DetalleReservaDTO dr=new DetalleReservaDTO();
				dr.setReservaDTO(r);
				
				AmbienteDTO amb=new AmbienteDTO();
				amb.setIdAmbiente(Integer.parseInt(idAmbiente));
				dr.setAmbienteDTO(amb);
				dr.setFecInicio(desde);
				dr.setFecFin(hasta);
				
				udao.registroReservaDetalleReservaPersonaWithCliente(r, dr, listAmbs);
							
			}
		}else if("lvlLogin".equals(flagNivelGetIdResera)){
			boolean existe=MyUtil.esUsuario(user, pwd);
			if(existe){
				rs=rdao.buscarReservaByUsuario(user, pwd);
				if(rs.size()>0){
					if(MyUtil.getValueCookie(request, "idPerfil").equals("")){
						MyUtil.iniciarSesion(response, user);					
					}
					rt.put("userTablaRs", user);
					rt.put("tablaReservas", rs);
				}else{
					ClienteDTO cli=udao.getClienteByIdUsuario(user);
					ReservaDTO r=new ReservaDTO();
					r.setClienteDTO(cli);
					DetalleReservaDTO dr=new DetalleReservaDTO();
					dr.setReservaDTO(r);
					AmbienteDTO amb=new AmbienteDTO();
					amb.setIdAmbiente(Integer.parseInt(idAmbiente));
					dr.setAmbienteDTO(amb);
					dr.setFecInicio(desde);
					dr.setFecFin(hasta);
					udao.registroReservaDetalleReservaPersonaWithCliente(r, dr, listAmbs);
					
					if(MyUtil.getValueCookie(request, "idPerfil").equals("")){
						MyUtil.iniciarSesion(response, user);					
					}
					_log.info("insers login cab");
				}
			}else{
				
			}
		}else if("lvlRegis".equals(flagNivelGetIdResera)){
			//			insert amps
			PersonaDTO p=new PersonaDTO();
			p.setNombres(nombres);
			p.setApePaterno(apePaterno);
			p.setApeMaterno(apeMaterno);
			p.setNumDocumento(numDocumento);
			p.setTelf(telf);
			p.setEmail(email);
			ClienteDTO cli=udao.registroPersonaUsuarioClienteWithPersona(p);
			ReservaDTO r=new ReservaDTO();
			r.setClienteDTO(cli);
			DetalleReservaDTO dr=new DetalleReservaDTO();
			dr.setReservaDTO(r);
			AmbienteDTO amb=new AmbienteDTO();
			amb.setIdAmbiente(Integer.parseInt(idAmbiente));
			dr.setAmbienteDTO(amb);
			dr.setFecInicio(desde);
			dr.setFecFin(hasta);
			udao.registroReservaDetalleReservaPersonaWithCliente(r, dr, listAmbs);

			String idPerfil=MyUtil.getValueCookie(request, "idPerfil");
			if(idPerfil.equals("")){
				String userGenered=p.getNombres().substring(0,1).concat(p.getApePaterno());			
				MyUtil.iniciarSesion(response, userGenered);				
			}
			
			rt.put("result","success");
			rt.put("perfil",idPerfil);
			
		}else if("lvlSelect".equals(flagNivelGetIdResera)){
			if(idReserva.equals("nuevoContenedor")){
				ClienteDTO cli=udao.getClienteByIdUsuario(user);
				
				ReservaDTO r=new ReservaDTO();
				r.setClienteDTO(cli);
				
				DetalleReservaDTO dr=new DetalleReservaDTO();
				dr.setReservaDTO(r);
				
				AmbienteDTO amb=new AmbienteDTO();
				amb.setIdAmbiente(Integer.parseInt(idAmbiente));
				dr.setAmbienteDTO(amb);
				dr.setFecInicio(desde);
				dr.setFecFin(hasta);
				
				udao.registroReservaDetalleReservaPersonaWithCliente(r, dr, listAmbs);
			}else{
				ClienteDTO cli=udao.getClienteByIdUsuario(user);
				
				ReservaDTO r=new ReservaDTO();
				r.setIdReserva(Integer.parseInt(idReserva));
				r.setClienteDTO(cli);
				
				DetalleReservaDTO dr=new DetalleReservaDTO();
				dr.setReservaDTO(r);
				
				AmbienteDTO amb=new AmbienteDTO();
				amb.setIdAmbiente(Integer.parseInt(idAmbiente));
				dr.setAmbienteDTO(amb);
				dr.setFecInicio(desde);
				dr.setFecFin(hasta);
				
				udao.registroReservaDetalleReservaPersonaWithCliente(r, dr, listAmbs);
			}
			rt.put("result","success");
			_log.info("insers select cab");
		}

		this.setMessage(gs.toJson(rt));
		return SUCCESS;
	}

	//COMMIT CONVE
	@Action(value="procesarReservaConve", results = { @Result(name = "success", type = "json") })
	public String procesarReservaConve(){
		_log.info("procesarReservaCab");

		//data logica
		HttpServletRequest request = ServletActionContext.getRequest();
		HttpServletResponse response = ServletActionContext.getResponse();
		List<Map<String, Object>> rs=null;
		Gson gs=new Gson();

		//data negocio
		List<PersonaDTO> listAmbs = gs.fromJson(acompData,new TypeToken<List<PersonaDTO>>(){}.getType());

		//data result
		Map<String,Object> rt=new HashMap<String,Object>();

		//		objetivo: obtener el idReserva para insertar
		if("lvlProc".equals(flagNivelGetIdResera)){
			String idUsuario=MyUtil.getValueCookie(request, "idUsuario");
			rs=rdao.buscarReservaByLogged(Integer.parseInt(idUsuario));
			if(rs.size()>0){
				rt.put("tablaReservas", rs);
			}else{
				_log.info("insers proc cab");
				ClienteDTO cli=udao.getClienteByIdUsuario(idUsuario);
				
				ReservaDTO r=new ReservaDTO();
				r.setClienteDTO(cli);
				
				DetalleReservaDTO dr=new DetalleReservaDTO();
				dr.setReservaDTO(r);
				
				AmbienteDTO amb=new AmbienteDTO();
				amb.setIdAmbiente(Integer.parseInt(idAmbiente));
				dr.setAmbienteDTO(amb);
				dr.setFecInicio(desde);
				dr.setFecFin(hasta);
				
				udao.registroReservaDetalleReservaPersonaWithCliente(r, dr, listAmbs);
							
			}
		}else if("lvlLogin".equals(flagNivelGetIdResera)){
			boolean existe=MyUtil.esUsuario(user, pwd);
			if(existe){
				rs=rdao.buscarReservaByUsuario(user, pwd);
				if(rs.size()>0){
					if(MyUtil.getValueCookie(request, "idPerfil").equals("")){
						MyUtil.iniciarSesion(response, user);					
					}
					rt.put("userTablaRs", user);
					rt.put("tablaReservas", rs);
				}else{
					ClienteDTO cli=udao.getClienteByIdUsuario(user);
					ReservaDTO r=new ReservaDTO();
					r.setClienteDTO(cli);
					DetalleReservaDTO dr=new DetalleReservaDTO();
					dr.setReservaDTO(r);
					AmbienteDTO amb=new AmbienteDTO();
					amb.setIdAmbiente(Integer.parseInt(idAmbiente));
					dr.setAmbienteDTO(amb);
					dr.setFecInicio(desde);
					dr.setFecFin(hasta);
					udao.registroReservaDetalleReservaPersonaWithCliente(r, dr, listAmbs);
					
					if(MyUtil.getValueCookie(request, "idPerfil").equals("")){
						MyUtil.iniciarSesion(response, user);					
					}
					_log.info("insers login cab");
				}
			}else{
				
			}
		}else if("lvlRegis".equals(flagNivelGetIdResera)){
			//			insert amps
			PersonaDTO p=new PersonaDTO();
			p.setNombres(nombres);
			p.setApePaterno(apePaterno);
			p.setApeMaterno(apeMaterno);
			p.setNumDocumento(numDocumento);
			p.setTelf(telf);
			p.setEmail(email);
			ClienteDTO cli=udao.registroPersonaUsuarioClienteWithPersona(p);
			ReservaDTO r=new ReservaDTO();
			r.setClienteDTO(cli);
			DetalleReservaDTO dr=new DetalleReservaDTO();
			dr.setReservaDTO(r);
			AmbienteDTO amb=new AmbienteDTO();
			amb.setIdAmbiente(Integer.parseInt(idAmbiente));
			dr.setAmbienteDTO(amb);
			dr.setFecInicio(desde);
			dr.setFecFin(hasta);
			udao.registroReservaDetalleReservaPersonaWithCliente(r, dr, listAmbs);

			String idPerfil=MyUtil.getValueCookie(request, "idPerfil");
			if(idPerfil.equals("")){
				String userGenered=p.getNombres().substring(0,1).concat(p.getApePaterno());			
				MyUtil.iniciarSesion(response, userGenered);				
			}
			
			rt.put("result","success");
			rt.put("perfil",idPerfil);
			
		}else if("lvlSelect".equals(flagNivelGetIdResera)){
			if(idReserva.equals("nuevoContenedor")){
				ClienteDTO cli=udao.getClienteByIdUsuario(user);
				
				ReservaDTO r=new ReservaDTO();
				r.setClienteDTO(cli);
				
				DetalleReservaDTO dr=new DetalleReservaDTO();
				dr.setReservaDTO(r);
				
				AmbienteDTO amb=new AmbienteDTO();
				amb.setIdAmbiente(Integer.parseInt(idAmbiente));
				dr.setAmbienteDTO(amb);
				dr.setFecInicio(desde);
				dr.setFecFin(hasta);
				
				udao.registroReservaDetalleReservaPersonaWithCliente(r, dr, listAmbs);
			}else{
				ClienteDTO cli=udao.getClienteByIdUsuario(user);
				
				ReservaDTO r=new ReservaDTO();
				r.setIdReserva(Integer.parseInt(idReserva));
				r.setClienteDTO(cli);
				
				DetalleReservaDTO dr=new DetalleReservaDTO();
				dr.setReservaDTO(r);
				
				AmbienteDTO amb=new AmbienteDTO();
				amb.setIdAmbiente(Integer.parseInt(idAmbiente));
				dr.setAmbienteDTO(amb);
				dr.setFecInicio(desde);
				dr.setFecFin(hasta);
				
				udao.registroReservaDetalleReservaPersonaWithCliente(r, dr, listAmbs);
			}
			rt.put("result","success");
			_log.info("insers select cab");
		}

		this.setMessage(gs.toJson(rt));
		return SUCCESS;
	}

	//COMMIT AMBIENTE
	@Action(value="procesarReservaAmbiente", results = { @Result(name = "success", type = "json") })
	public String procesarReservaAmbiente(){
		_log.info("procesarReservaAmbiente.action");

		//data logica
		HttpServletRequest request = ServletActionContext.getRequest();
		HttpServletResponse response = ServletActionContext.getResponse();
		List<Map<String, Object>> rs=null;
		Gson gs=new Gson();

		//data negocio
		List<PersonaDTO> listAmbs = new ArrayList<PersonaDTO>();

		//data result
		Map<String,Object> rt=new HashMap<String,Object>();

		//		objetivo: obtener el idReserva para insertar
		if("lvlProc".equals(flagNivelGetIdResera)){
			String idUsuario=MyUtil.getValueCookie(request, "idUsuario");
			rs=rdao.buscarReservaByLogged(Integer.parseInt(idUsuario));
			if(rs.size()>0){
				rt.put("tablaReservas", rs);
			}else{
				_log.info("insers proc cab");
				ClienteDTO cli=udao.getClienteByIdUsuario(idUsuario);
				
				ReservaDTO r=new ReservaDTO();
				r.setClienteDTO(cli);
				
				DetalleReservaDTO dr=new DetalleReservaDTO();
				dr.setReservaDTO(r);
				
				AmbienteDTO amb=new AmbienteDTO();
				amb.setIdAmbiente(Integer.parseInt(idAmbiente));
				dr.setAmbienteDTO(amb);
				dr.setFecInicio(desde);
				dr.setFecFin(hasta);
				
				udao.registroReservaDetalleReservaPersonaWithCliente(r, dr, listAmbs);
							
			}
		}else if("lvlLogin".equals(flagNivelGetIdResera)){
			boolean existe=MyUtil.esUsuario(user, pwd);
			if(existe){
				rs=rdao.buscarReservaByUsuario(user, pwd);
				if(rs.size()>0){
					if(MyUtil.getValueCookie(request, "idPerfil").equals("")){
						MyUtil.iniciarSesion(response, user);					
					}
					rt.put("userTablaRs", user);
					rt.put("tablaReservas", rs);
				}else{
					ClienteDTO cli=udao.getClienteByIdUsuario(user);
					ReservaDTO r=new ReservaDTO();
					r.setClienteDTO(cli);
					DetalleReservaDTO dr=new DetalleReservaDTO();
					dr.setReservaDTO(r);
					AmbienteDTO amb=new AmbienteDTO();
					amb.setIdAmbiente(Integer.parseInt(idAmbiente));
					dr.setAmbienteDTO(amb);
					dr.setFecInicio(desde);
					dr.setFecFin(hasta);
					udao.registroReservaDetalleReservaPersonaWithCliente(r, dr, listAmbs);
					
					if(MyUtil.getValueCookie(request, "idPerfil").equals("")){
						MyUtil.iniciarSesion(response, user);					
					}
					_log.info("insers login cab");
				}
			}else{
				
			}
		}else if("lvlRegis".equals(flagNivelGetIdResera)){
			//			insert amps
			PersonaDTO p=new PersonaDTO();
			p.setNombres(nombres);
			p.setApePaterno(apePaterno);
			p.setApeMaterno(apeMaterno);
			p.setNumDocumento(numDocumento);
			p.setTelf(telf);
			p.setEmail(email);
			ClienteDTO cli=udao.registroPersonaUsuarioClienteWithPersona(p);
			ReservaDTO r=new ReservaDTO();
			r.setClienteDTO(cli);
			DetalleReservaDTO dr=new DetalleReservaDTO();
			dr.setReservaDTO(r);
			AmbienteDTO amb=new AmbienteDTO();
			amb.setIdAmbiente(Integer.parseInt(idAmbiente));
			dr.setAmbienteDTO(amb);
			dr.setFecInicio(desde);
			dr.setFecFin(hasta);
			udao.registroReservaDetalleReservaPersonaWithCliente(r, dr, listAmbs);

			String idPerfil=MyUtil.getValueCookie(request, "idPerfil");
			if(idPerfil.equals("")){
				String userGenered=p.getNombres().substring(0,1).concat(p.getApePaterno());			
				MyUtil.iniciarSesion(response, userGenered);				
			}
			
			rt.put("result","success");
			rt.put("perfil",idPerfil);
			
		}else if("lvlSelect".equals(flagNivelGetIdResera)){
			if(idReserva.equals("nuevoContenedor")){
				ClienteDTO cli=udao.getClienteByIdUsuario(user);
				
				ReservaDTO r=new ReservaDTO();
				r.setClienteDTO(cli);
				
				DetalleReservaDTO dr=new DetalleReservaDTO();
				dr.setReservaDTO(r);
				
				AmbienteDTO amb=new AmbienteDTO();
				amb.setIdAmbiente(Integer.parseInt(idAmbiente));
				dr.setAmbienteDTO(amb);
				dr.setFecInicio(desde);
				dr.setFecFin(hasta);
				
				udao.registroReservaDetalleReservaPersonaWithCliente(r, dr, listAmbs);
			}else{
				ClienteDTO cli=udao.getClienteByIdUsuario(user);
				
				ReservaDTO r=new ReservaDTO();
				r.setIdReserva(Integer.parseInt(idReserva));
				r.setClienteDTO(cli);
				
				DetalleReservaDTO dr=new DetalleReservaDTO();
				dr.setReservaDTO(r);
				
				AmbienteDTO amb=new AmbienteDTO();
				amb.setIdAmbiente(Integer.parseInt(idAmbiente));
				dr.setAmbienteDTO(amb);
				dr.setFecInicio(desde);
				dr.setFecFin(hasta);
				
				udao.registroReservaDetalleReservaPersonaWithCliente(r, dr, listAmbs);
			}
			rt.put("result","success");
		}

		this.setMessage(gs.toJson(rt));
		return SUCCESS;
	}

//	private String gracioso;
//	public String getGracioso() {
//		return gracioso;
//	}
//	public void setGracioso(String gracioso) {
//		this.gracioso = gracioso;
//	}
//	@Action(value="/actionTest",results={@Result(location="reserva",name="success",type="tiles")})
//	public String actionTest(){
//		_log.info("init actionTest");
//		_log.info(gracioso);
//		
//		return SUCCESS;
//	}
	
	@Action(value="checkout",results={@Result(location="checkout",name="success",type="tiles")})
	public String checkout(){

		return SUCCESS;
	}

	@Action(value="preRevisarHabitacion",results={@Result(location="limpiaralojamientocamarera",name="success",type="tiles")})
	public String preRevisarHabitacion(){

		return SUCCESS;
	}

	@Action(value="goHabToLimpiar",results={@Result(location="habToLimpiar",name="success",type="tiles")})
	public String goHabToLimpiar(){

		return SUCCESS;
	}

	//GETTERS AND SETTERS
	public String getMessage() {
		return message;
	}
	public void setMessage(String message) {
		this.message = message;
	}
	public String getFInicio() {
		return fInicio;
	}
	public void setFInicio(String fInicio) {
		this.fInicio = fInicio;
	}
	public String getFFin() {
		return fFin;
	}
	public void setFFin(String fFin) {
		this.fFin = fFin;
	}
	public int getFlagBusquedaHome() {
		return flagBusquedaHome;
	}
	public void setDesde(String desde) {
		this.desde = desde;
	}
	public void setHasta(String hasta) {
		this.hasta = hasta;
	}
	public void setIdAmbiente(String idAmbiente) {
		this.idAmbiente = idAmbiente;
	}
	public void setAcompData(String acompData) {
		this.acompData = acompData;
	}
	public void setUser(String user) {
		this.user = user;
	}
	public void setPwd(String pwd) {
		this.pwd = pwd;
	}
	public void setFlagNivelGetIdResera(String flagNivelGetIdResera) {
		this.flagNivelGetIdResera = flagNivelGetIdResera;
	}

	public void setIdReserva(String idReserva) {
		this.idReserva = idReserva;
	}

	public void setNombres(String nombres) {
		this.nombres = nombres;
	}

	public void setApePaterno(String apePaterno) {
		this.apePaterno = apePaterno;
	}

	public void setApeMaterno(String apeMaterno) {
		this.apeMaterno = apeMaterno;
	}

	public void setNumDocumento(String numDocumento) {
		this.numDocumento = numDocumento;
	}
	public void setTelf(int telf) {
		this.telf = telf;
	}

	public void setEmail(String email) {
		this.email = email;
	}

	public void setTpoAmb(String tpoAmb) {
		this.tpoAmb = tpoAmb;
	}

	public String getAmbientesFromHome() {
		return ambientesFromHome;
	}

	public void setAmbientesFromHome(String ambientesFromHome) {
		this.ambientesFromHome = ambientesFromHome;
	}
}
