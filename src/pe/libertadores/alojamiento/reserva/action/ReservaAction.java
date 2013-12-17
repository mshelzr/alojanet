package pe.libertadores.alojamiento.reserva.action;

import org.apache.struts2.convention.annotation.Action;
import org.apache.struts2.convention.annotation.ParentPackage;
import org.apache.struts2.convention.annotation.Result;

import com.opensymphony.xwork2.ActionSupport;

@ParentPackage(value="alojamiento")
public class ReservaAction extends ActionSupport {

	private static final long serialVersionUID = -4753048779190212810L;
	private String gojsp;
	private String data="";
	private String trackingLine="";
	private String timeout="";
	private String derror="";

	@Action(value="agregarReserva",results={@Result(location="reserva",name="success",type="tiles")})
	public String generarReserva(){

		return SUCCESS;
	}
	
	@Action(value="gestionarReserva",results={@Result(location="gestionarReserva",name="success",type="tiles")})
	public String gestionarReservaReserva(){

		return SUCCESS;
	}
	
	@Action(value="checkin",results={@Result(location="checkin",name="success",type="tiles")})
	public String checkin(){

		return SUCCESS;
	}
	
	@Action(value="checkout",results={@Result(location="checkout",name="success",type="tiles")})
	public String checkout(){

		return SUCCESS;
	}
	
	@Action(value="preRevisarHabitacion",results={@Result(location="limpiaralojamientocamarera",name="success",type="tiles")})
	public String preRevisarHabitacion(){

		return SUCCESS;
	}
	/**
	 * Provide default valuie for Message property.
	 */
	public static final String MESSAGE = "HelloWorld.message";

	/**
	 * Field for Message property.
	 */
	private String message;

	/**
	 * Return Message property.
	 *
	 * @return Message property
	 */
	public String getMessage() {
		return message;
	}

	/**
	 * Set Message property.
	 *
	 * @param message Text to display on HelloWorld page.
	 */
	public void setMessage(String message) {
		this.message = message;
	}

	public String getGojsp() {
		return gojsp;
	}

	public void setGojsp(String gojsp) {
		this.gojsp = gojsp;
	}

	public String getData() {
		return data;
	}

	public void setData(String data) {
		this.data = data;
	}

	public String getDerror() {
		return derror;
	}

	public void setDerror(String derror) {
		this.derror = derror;
	}

	public String getTimeout() {
		return timeout;
	}

	public String getTrackingLine() {
		return trackingLine;
	}

}
