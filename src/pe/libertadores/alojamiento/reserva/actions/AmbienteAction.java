package pe.libertadores.alojamiento.reserva.actions;

import java.util.ArrayList;
import java.util.List;
import java.util.Map;
import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;
import org.apache.struts2.convention.annotation.Action;
import org.apache.struts2.convention.annotation.ParentPackage;
import org.apache.struts2.convention.annotation.Result;
import pe.libertadores.alojamiento.reserva.daos.AmbienteDao;
import pe.libertadores.alojamiento.seguridad.actions.LoginAction;
import pe.libertadores.dto.AmbienteDTO;
import com.opensymphony.xwork2.ActionContext;
import com.opensymphony.xwork2.ActionSupport;

@SuppressWarnings("serial")
@ParentPackage(value="alojamiento")
public class AmbienteAction extends ActionSupport {

	private static final Log _log = LogFactory.getLog(LoginAction.class);
	private List<AmbienteDTO> ambientes;
	private List<AmbienteDTO> codigos;
	private AmbienteDao daoambiente = new AmbienteDao();
	private Integer rows = 0, page = 0, total = 0, records = 0;
	private Map<String, Object> sesion = ActionContext.getContext().getSession();
	private AmbienteDTO amb;
	private String descripcion,numberoLocal, urlimagen, mensaje;
	private String idAmbiente,capacidadPersonas, codAmbiente, estado, flagAmbienteOferta,flagMiniBar,idAmbientePadre,piso, cantAsientosConPrivilegios, cantCuartos, cantMinReservasParaPromocion;
	double precio;

	public String getMensaje() {
		return mensaje;
	}
	public void setMensaje(String mensaje) {
		this.mensaje = mensaje;
	}
	public String getCapacidadPersonas() {
		return capacidadPersonas;
	}
	public void setCapacidadPersonas(String capacidadPersonas) {
		this.capacidadPersonas = capacidadPersonas;
	}
	public String getCantAsientosConPrivilegios() {
		return cantAsientosConPrivilegios;
	}
	public void setCantAsientosConPrivilegios(String cantAsientosConPrivilegios) {
		this.cantAsientosConPrivilegios = cantAsientosConPrivilegios;
	}
	public String getCantCuartos() {
		return cantCuartos;
	}
	public void setCantCuartos(String cantCuartos) {
		this.cantCuartos = cantCuartos;
	}
	public String getCantMinReservasParaPromocion() {
		return cantMinReservasParaPromocion;
	}
	public void setCantMinReservasParaPromocion(String cantMinReservasParaPromocion) {
		this.cantMinReservasParaPromocion = cantMinReservasParaPromocion;
	}
	public String getDescripcion() {
		return descripcion;
	}
	public void setDescripcion(String descripcion) {
		this.descripcion = descripcion;
	}
	public String getNumberoLocal() {
		return numberoLocal;
	}
	public void setNumberoLocal(String numberoLocal) {
		this.numberoLocal = numberoLocal;
	}
	public String getUrlimagen() {
		return urlimagen;
	}
	public void setUrlimagen(String urlimagen) {
		this.urlimagen = urlimagen;
	}
	public String getIdAmbiente() {
		return idAmbiente;
	}
	public void setIdAmbiente(String idAmbiente) {
		this.idAmbiente = idAmbiente;
	}
	public String getCodAmbiente() {
		return codAmbiente;
	}
	public void setCodAmbiente(String codAmbiente) {
		this.codAmbiente = codAmbiente;
	}
	public String getEstado() {
		return estado;
	}
	public void setEstado(String estado) {
		this.estado = estado;
	}
	public String getFlagAmbienteOferta() {
		return flagAmbienteOferta;
	}
	public void setFlagAmbienteOferta(String flagAmbienteOferta) {
		this.flagAmbienteOferta = flagAmbienteOferta;
	}
	public String getFlagMiniBar() {
		return flagMiniBar;
	}
	public void setFlagMiniBar(String flagMiniBar) {
		this.flagMiniBar = flagMiniBar;
	}
	public String getIdAmbientePadre() {
		return idAmbientePadre;
	}
	public void setIdAmbientePadre(String idAmbientePadre) {
		this.idAmbientePadre = idAmbientePadre;
	}
	public String getPiso() {
		return piso;
	}
	public void setPiso(String piso) {
		this.piso = piso;
	}
	public double getPrecio() {
		return precio;
	}
	public void setPrecio(double precio) {
		this.precio = precio;
	}
	public AmbienteDTO getAmb() {
		return amb;
	}
	public void setAmb(AmbienteDTO amb) {
		this.amb = amb;
	}
	public List<AmbienteDTO> getCodigos() {
		return codigos;
	}
	public void setCodigos(List<AmbienteDTO> codigos) {
		this.codigos = codigos;
	}
	public AmbienteDao getDaoambiente() {
		return daoambiente;
	}
	public void setDaoambiente(AmbienteDao daoambiente) {
		this.daoambiente = daoambiente;
	}
	public Integer getRows() {
		return rows;
	}
	public void setRows(Integer rows) {
		this.rows = rows;
	}
	public Integer getPage() {
		return page;
	}
	public void setPage(Integer page) {
		this.page = page;
	}
	public Integer getTotal() {
		return total;
	}
	public void setTotal(Integer total) {
		this.total = total;
	}
	public Integer getRecords() {
		return records;
	}
	public void setRecords(Integer records) {
		this.records = records;
	}
	public List<AmbienteDTO> getAmbientes() {
		return ambientes;
	}
	public void setAmbientes(List<AmbienteDTO> ambientes) {
		this.ambientes = ambientes;
	}
	@Action(value="/listaFullambientes", results = { @Result(location = "/ambienteConsultaGrid.jsp", name = "success") })
	public String listaFullAmbientes(){
		try {
			List<AmbienteDTO>  data = daoambiente.listFullAmbs();
			sesion.put("keyAmbiente", data);			
		} catch (Exception e) {
			e.printStackTrace();
		}
		return SUCCESS;
	}
	@Action(value = "/listaAmbienteGrid", results = { @Result(name = "success", type = "json") })
	public String listaAmbienteGrid() {
		try {
			@SuppressWarnings("unchecked")
			List<AmbienteDTO> data = (ArrayList<AmbienteDTO>) sesion.get("keyAmbiente");
			records = data.size();
			int hasta = (rows * page);
			int desde = hasta - rows;
			if (hasta > records)
				hasta = records;
			ambientes = data.subList(desde, hasta);
			total = (int) Math.ceil((double) records / (double) rows);
		} catch (Exception e) {
			e.printStackTrace();
		}
		return SUCCESS;
	}

	@Action(value = "/listaCodigoAmbs", results = { @Result(name = "success", type = "json") })
	public String listaCodigoAmbs(){
		codigos = daoambiente.listaCodigoAmbs();
		return SUCCESS;
	}
	
	
	@Action(value = "/registraAmbiente", results = { @Result(location = "/vendedorMantenimientoGrid.jsp",name = "success") })
	public String registraAmbiente(){	
		try{
			amb = new AmbienteDTO();
			amb.setCantAsientosConPrivilegios(Integer.parseInt(cantAsientosConPrivilegios));
			amb.setCantCuartos(Integer.parseInt(cantCuartos));
			amb.setCantMinReservasParaPromocion(Integer.parseInt(cantMinReservasParaPromocion));
			amb.setCapacidadPersonas(Integer.parseInt(capacidadPersonas));
			amb.setCodAmbiente(Integer.parseInt(codAmbiente));
			amb.setDescripcion(descripcion);
			amb.setEstado(Integer.parseInt(estado));
			amb.setFlagAmbienteOferta(Integer.parseInt(flagAmbienteOferta));
			amb.setFlagMiniBar(Integer.parseInt(flagMiniBar));
			
			AmbienteDTO ambx=new AmbienteDTO();			
			ambx.setIdAmbiente(Integer.parseInt(idAmbientePadre));
			
			amb.setAmbienteDTO(ambx);
			amb.setNumberoLocal(numberoLocal);
			amb.setPiso(Integer.parseInt(piso));
			amb.setPrecio(precio);
			amb.setUrlimagen(urlimagen);
			daoambiente.registraAmbiente(amb);
		}
		catch(Exception e){
			_log.info(e.getMessage());
		}
		return listaFullAmbientes();
	}

	@Action(value = "/actualizaAmbiente", results = { @Result(location = "/vendedorMantenimientoGrid.jsp",name = "success") })
	public String updateAmbiente(){
		try{
			amb = new AmbienteDTO();
			amb.setIdAmbiente(Integer.parseInt(idAmbiente));
			amb.setCantAsientosConPrivilegios(Integer.parseInt(cantAsientosConPrivilegios));
			amb.setCantCuartos(Integer.parseInt(cantCuartos));
			amb.setCantMinReservasParaPromocion(Integer.parseInt(cantMinReservasParaPromocion));
			amb.setCapacidadPersonas(Integer.parseInt(capacidadPersonas));
			amb.setCodAmbiente(Integer.parseInt(codAmbiente));
			amb.setDescripcion(descripcion);
			amb.setEstado(Integer.parseInt(estado));
			amb.setFlagAmbienteOferta(Integer.parseInt(flagAmbienteOferta));
			amb.setFlagMiniBar(Integer.parseInt(flagMiniBar));

			AmbienteDTO ambx=new AmbienteDTO();			
			ambx.setIdAmbiente(Integer.parseInt(idAmbientePadre));

			amb.setAmbienteDTO(ambx);
			amb.setNumberoLocal(numberoLocal);
			amb.setPiso(Integer.parseInt(piso));
			amb.setPrecio(precio);
			amb.setUrlimagen(urlimagen);
			daoambiente.updateAmbientes(amb);
		}
		catch(Exception e){
			_log.info(e.getMessage());
		}
		return listaFullAmbientes();
	}
	@SuppressWarnings("unchecked")
	@Action(value = "/eliminaAmbiente", results = { @Result(location = "/vendedorMantenimientoGrid.jsp", name = "success") })
	public String eliminaAmbiente() throws Exception {
		ambientes =(ArrayList<AmbienteDTO>)sesion.get("keyAmbiente");		
		if(ambientes== null ||  ambientes.size()==0){
			mensaje="Se debería haber realizado una selección";
			return SUCCESS;
		}		
		if(idAmbiente == null||  idAmbiente.length()==0){
			mensaje="Se debería haber seleccionado un registro";
			return SUCCESS;
		}		
		daoambiente.eliminaVendedor(Integer.parseInt(idAmbiente));
		idAmbiente = null;
		
		return listaFullAmbientes();
	}
}
