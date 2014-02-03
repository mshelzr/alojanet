package pe.libertadores.alojamiento.reserva.actions;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import net.sf.json.JSONObject;

import org.apache.struts2.convention.annotation.Action;
import org.apache.struts2.convention.annotation.ParentPackage;
import org.apache.struts2.convention.annotation.Result;

import pe.libertadores.alojamiento.reserva.daos.CheckOutDao;
import pe.libertadores.alojamiento.reserva.daos.CheckinDao;
import pe.libertadores.alojamiento.seguridad.dao.UsuarioDao;

import com.google.gson.Gson;
import com.opensymphony.xwork2.ActionSupport;

@SuppressWarnings("serial")
@ParentPackage(value="alojamiento")
public class CheckOutAction extends ActionSupport {
	private UsuarioDao udao=new UsuarioDao();	
	private CheckinDao cdao=new CheckinDao();
	private CheckOutDao coutdao=new CheckOutDao();
	
	private String value;
	private String message;

	@Action(value="/irModalDetalleReservaCheckOut",results={@Result(name="success",type="json")})
	public String irModalDetalleReserva(){

		Map<String,Object> resultMap=new HashMap<String,Object>();

		Map<String, Object> detalleReserva=new HashMap<String, Object>();

		int idDetalleReserva=Integer.parseInt(value);
		detalleReserva=cdao.getDetalleReserva(idDetalleReserva);
		List<Map<String, Object>> listaDetalles=coutdao.listarConsumosPorDetalleReserva(idDetalleReserva);
		
		resultMap.put("detalleReserva", detalleReserva);
		resultMap.put("listaAcompConConsumo", listaDetalles);

		JSONObject js=JSONObject.fromObject(resultMap);
		this.setMessage(js.toString());
		return SUCCESS;
	}
	//modificar estado del checkout
	
	private int val;
	@Action(value="modificarEstadoCheckOut",results={@Result(name="success",type="json")})
	public String modificarEstadoCheckOut(){
		//+ remplazar: update acomp_reserva
		udao.dml_modificarDetalleReservaToCheck(val, "2");		
		return SUCCESS;
	}
	
	private String idTarjetaPersona;
	
	@Action(value="consumoByPersonaTarjeta",results={@Result(name="success",type="json")})
	public String consumoByPersonaTarjeta(){
		int idTarjetaPersonaInt=!idTarjetaPersona.equals("undefined") ? Integer.parseInt(idTarjetaPersona) : 0;
		List<Map<String, Object>> consumos=coutdao.consumoByPersonaTarjeta(idTarjetaPersonaInt);
		
		consumos=consumos==null ? new ArrayList<Map<String, Object>>() : consumos;
		Map<String, Object> returnAjax=new HashMap<String, Object>();
		
		returnAjax.put("consumos", consumos);
		
		this.setMessage(new Gson().toJson(returnAjax));
		
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

	public void setVal(int val) {
		this.val = val;
	}

	public void setIdTarjetaPersona(String idTarjetaPersona) {
		this.idTarjetaPersona = idTarjetaPersona;
	}
	
}
