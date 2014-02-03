package pe.libertadores.alojamiento.reserva.actions;

import java.util.ArrayList;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;

import org.apache.struts2.ServletActionContext;
import org.apache.struts2.convention.annotation.Action;
import org.apache.struts2.convention.annotation.ParentPackage;
import org.apache.struts2.convention.annotation.Result;

import pe.libertadores.alojamiento.reserva.daos.ReservaDao;

import com.opensymphony.xwork2.ActionSupport;

@SuppressWarnings("serial")
@ParentPackage(value="alojamiento")
public class GestionarAction extends ActionSupport {
	
	private ReservaDao rdao=new ReservaDao();
	private List<String> count;	
	private List<Map<String, Object>> listaReservas;

	@Action(value="gestionarReserva",results=
		{@Result(location="gestionarReserva",name="success",type="tiles"),
		 @Result(location="gestionarReservaCliente",name="successcli",type="tiles")})
	public String gestionarReservaReserva(){
		HttpServletRequest request=ServletActionContext.getRequest();
		String idUsuario=MyUtil.getValueCookie(request, "idUsuario");
		String retornoTiles=SUCCESS;
		
		if(!"".equals(idUsuario) || null!=idUsuario){
			retornoTiles=MyUtil.getValueCookie(request, "idPerfil").equals("1")? "successcli" : SUCCESS;
			if(retornoTiles.equals("successcli")){
				
				listaReservas=rdao.listarReservasByIdCliente(Integer.parseInt(idUsuario));
				count=new ArrayList<String>();				
				
				for(Map<String, Object> obj : listaReservas){
					String idReserva=""+obj.get("idreserva");
					boolean flag=false;
					for (int i = 0; i < count.size(); i++) {
						String element=count.get(i);
						if(idReserva.equals(element)){
							flag=true;
							break;
						}
					}
					if(!flag){
						count.add(idReserva);
					}
				}
			}
		}
		
		
		return retornoTiles;
	}


	//getters and setters
	public List<Map<String, Object>> getListaReservas() {
		return listaReservas;
	}


	public void setListaReservas(List<Map<String, Object>> listaReservas) {
		this.listaReservas = listaReservas;
	}


	public List<String> getCount() {
		return count;
	}
	
}
