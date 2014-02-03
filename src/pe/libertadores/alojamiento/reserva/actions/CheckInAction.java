package pe.libertadores.alojamiento.reserva.actions;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import net.sf.json.JSONObject;

import org.apache.struts2.convention.annotation.Action;
import org.apache.struts2.convention.annotation.ParentPackage;
import org.apache.struts2.convention.annotation.Result;

import pe.libertadores.alojamiento.reserva.daos.CheckinDao;
import pe.libertadores.alojamiento.reserva.daos.ReservaDao;
import pe.libertadores.alojamiento.seguridad.dao.UsuarioDao;
import pe.libertadores.dto.DetalleReservaDTO;
import pe.libertadores.dto.PersonaDTO;
import pe.libertadores.dto.ReservaDTO;
import pe.libertadores.dto.TipoDocumentoDTO;

import com.google.gson.Gson;
import com.google.gson.reflect.TypeToken;
import com.opensymphony.xwork2.ActionSupport;

@SuppressWarnings("serial")
@ParentPackage(value="alojamiento")
public class CheckInAction extends ActionSupport {
	//	combo:combo,tipoDoc:tipoDoc,value:value}
	private CheckinDao cdao=new CheckinDao();
	private UsuarioDao udao=new UsuarioDao();
	
	private String value;
	private String message;
	private String desde;
	private String hasta;
	
	//busqueda de reserva
	private String nombres;
	private String apePaterno;
	private String apeMaterno;
	private String numero;
	
	//modal checkin
	private int idDetalleReserva;
	private String acompData;
	private int tarjetaIndividual;
	private int idReserva;
	private int idPersona;
	
	//modificar estado del checkin
	private int val;
	
	/////////
//	BUSQUEDA DE RESERVA
	@Action(value="/buscarReserva",results={@Result(name="success",type="json")})
	public String buscarReserva(){

		ReservaDao rdao=new ReservaDao();
		Map<String,Object> resultMap=new HashMap<String,Object>();
		
		//reservas encontradas para el modal
		List<Map<String, Object>> reservasFound=new ArrayList<Map<String, Object>>();
		
		PersonaDTO pin=new PersonaDTO();
		pin.setNombres(nombres.equals("")? nombres : nombres.concat("%"));
		pin.setApePaterno(apePaterno.equals("")? apePaterno : apePaterno.concat("%"));
		pin.setApeMaterno(apeMaterno.equals("")? apeMaterno : apeMaterno.concat("%"));
		pin.setNumDocumento(numero.equals("")? numero : numero.concat("%"));	
		
		System.out.println(pin);
		reservasFound=rdao.busquedaReservaParamPersona(pin);

		resultMap.put("dataParaTabla", reservasFound);

		JSONObject js=JSONObject.fromObject(resultMap);
		this.setMessage(js.toString());
		return SUCCESS;
	}

	@Action(value="/reservaBuscadaSelected",results={@Result(name="success",type="json")})
	public String reservaBuscadaSelected(){
		//result to ajax
		Map<String,Object> resultMap=new HashMap<String,Object>();
		Gson gs=new Gson();

		PersonaDTO pers=new PersonaDTO();
		
		List<Map<String, Object>> listaDetalles=new ArrayList<Map<String, Object>>();

		pers=cdao.getPersonaByIdPersona(idPersona);
		listaDetalles=cdao.listarDetalleReservaByIdReserva(idReserva);

		String dtoToJsonPersona=gs.toJson(pers);
		double lblTotal=udao.q_consumoTotalByIdPersona(idPersona);
		
		resultMap.put("pers", dtoToJsonPersona);
		resultMap.put("listaDetalles", listaDetalles);
		resultMap.put("totalPagar", lblTotal);

		JSONObject js=JSONObject.fromObject(resultMap);
		this.setMessage(js.toString());
		return SUCCESS;
	}

	@Action(value="/irModalDetalleReserva",results={@Result(name="success",type="json")})
	public String irModalDetalleReserva(){

		Map<String,Object> resultMap=new HashMap<String,Object>();
		Gson gs=new Gson();

		Map<String, Object> detalleReserva=new HashMap<String, Object>();
		List<PersonaDTO> listaAcompanantes=new ArrayList<PersonaDTO>();

		int idDetalleReserva=Integer.parseInt(value);
		
		detalleReserva=cdao.getDetalleReserva(idDetalleReserva);
		listaAcompanantes=cdao.listarAcompanantes(idDetalleReserva);
		
		String dtoToJsonAcomps=gs.toJson(listaAcompanantes);

		resultMap.put("detalleReserva", detalleReserva);
		resultMap.put("listaAcompanantes", dtoToJsonAcomps);

		JSONObject js=JSONObject.fromObject(resultMap);
		this.setMessage(js.toString());
		return SUCCESS;
	}

	@Action(value="/consultarDisponibilidadAmbiente",results={@Result(name="success",type="json")})
	public String consultarDisponibilidadAmbiente(){

		Map<String,Object> resultMap=new HashMap<String,Object>();
		int rsDisp=0;
		
		rsDisp=cdao.consultarDisponibilidadAmbiente(value,desde,hasta);
		
		if(rsDisp==0){
			resultMap.put("flagDisp", 'y');
		}else{
			resultMap.put("flagDisp", 'n');
		}

		JSONObject js=JSONObject.fromObject(resultMap);
		this.setMessage(js.toString());
		return SUCCESS;
	}
	
	@Action(value="/guardarNuevoRangoDeReserva",results={@Result(name="success",type="json")})
	public String guardarNuevoRangoDeReserva(){

		Map<String,Object> resultMap=new HashMap<String,Object>();

		cdao.guardarNuevoRangoDeReserva(value,desde,hasta);

		JSONObject js=JSONObject.fromObject(resultMap);
		this.setMessage(js.toString());
		return SUCCESS;
	}
	
	@Action(value="/guardarAcompByDetalleReserva",results={@Result(name="success",type="json")})
	public String guardarAcompByDetalleReserva(){

		Map<String,Object> resultMap=new HashMap<String,Object>();
		Gson gs=new Gson();
		
		TipoDocumentoDTO tpoDoc=new TipoDocumentoDTO();
		tpoDoc.setIdTipoDocumento(1);
		
		PersonaDTO objParsed = gs.fromJson(value,new TypeToken<PersonaDTO>(){}.getType());
		objParsed.setTipoDocumentoDTO(tpoDoc);
		
		JSONObject js=JSONObject.fromObject(resultMap);
		this.setMessage(js.toString());
		return SUCCESS;
	}

	@Action(value="checkin",results={@Result(location="checkin",name="success",type="tiles")})
	public String checkin(){
		return SUCCESS;
	}
	
	@Action(value="modificarEstadoCheckIn",results={@Result(location="checkin",name="success",type="tiles")})
	public String modificarEstadoCheckIn(){
		udao.dml_modificarDetalleReservaToCheck(val, "1");		
		return SUCCESS;
	}
	
	@Action(value="eventCheckIn",results={@Result(name="success",type="json")})
	public String eventCheckIn(){

		udao.dml_modificarDetalleReservaToCheck(idDetalleReserva, "1");
		List<PersonaDTO> objParsed = new Gson().fromJson(acompData,new TypeToken<List<PersonaDTO>>(){}.getType());
		List<PersonaDTO> acompAntiguas=new ArrayList<PersonaDTO>();
		List<PersonaDTO> acompNuevos=new ArrayList<PersonaDTO>();
		
		for (PersonaDTO p : objParsed) {
			if(p.getIdPersona()!=0)
				acompAntiguas.add(p);
			else{
				acompNuevos.add(p);
			}
		}
		
		udao.modificarAcomp(acompAntiguas);
		DetalleReservaDTO dr=new DetalleReservaDTO();
		
		dr.setIdDetalleReserva(idDetalleReserva);
		udao.registrarAcompByIdDetalleReserva(dr, acompNuevos);
		
		ReservaDTO r=new ReservaDTO();
		r.setIdReserva(idReserva);
		
		if(tarjetaIndividual!=0){

			PersonaDTO p=new PersonaDTO();
			p.setIdPersona(idPersona);
			p.setTelf(tarjetaIndividual);
			udao.registrarTarjetaPorIdUsuario(r,p);			
		}else{
			udao.registrarTarjetaAcomp(r, objParsed);
		}
		
		Map<String, Object> backAjax=new HashMap<String, Object>();
		
		backAjax.put("listaDetalles", cdao.listarDetalleReservaByIdReserva(idReserva));
		
		this.setMessage(new Gson().toJson(backAjax));
		
		return SUCCESS;
	}	
	
	//GETTERS AND SETTERS
	public void setValue(String value) {
		this.value = value;
	}
	public String getMessage() {
		return message;
	}
	public void setMessage(String message) {
		this.message = message;
	}
	public void setDesde(String desde) {
		this.desde = desde;
	}
	public void setHasta(String hasta) {
		this.hasta = hasta;
	}
	public void setVal(int val) {
		this.val = val;
	}
	public void setIdDetalleReserva(int idDetalleReserva) {
		this.idDetalleReserva = idDetalleReserva;
	}
	public void setAcompData(String acompData) {
		this.acompData = acompData;
	}

	public void setTarjetaIndividual(int tarjetaIndividual) {
		this.tarjetaIndividual = tarjetaIndividual;
	}

	public void setIdReserva(int idReserva) {
		this.idReserva = idReserva;
	}

	public void setIdPersona(int idPersona) {
		this.idPersona = idPersona;
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

	public void setNumero(String numero) {
		this.numero = numero;
	}

}
