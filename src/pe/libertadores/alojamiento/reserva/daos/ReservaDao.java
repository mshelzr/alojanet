package pe.libertadores.alojamiento.reserva.daos;

import java.io.IOException;
import java.io.Reader;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.apache.ibatis.io.Resources;
import org.apache.ibatis.session.SqlSession;
import org.apache.ibatis.session.SqlSessionFactory;
import org.apache.ibatis.session.SqlSessionFactoryBuilder;

import pe.libertadores.dto.AmbienteDTO;
import pe.libertadores.dto.PersonaDTO;

public class ReservaDao {

	SqlSessionFactory sqlMapper = null;
	{
		String archivo = "mybatis/ConfiguracionIbatis.xml";
		try {
			Reader reader = Resources.getResourceAsReader(archivo);
			sqlMapper = new SqlSessionFactoryBuilder().build(reader);
		} catch (IOException e) {
			e.printStackTrace();
		}
	}
	
	@SuppressWarnings("unchecked")
	public List<AmbienteDTO> buscarCabsDeReserva(String desde, String hasta){
		SqlSession session = sqlMapper.openSession();
		List<AmbienteDTO> ambiente=new ArrayList<AmbienteDTO>();
		try {
			Map<String, String> param=new HashMap<String, String>();
			param.put("desde", desde);
			param.put("hasta",hasta);			
			ambiente =(List<AmbienteDTO>) session.selectList("q_buscarCabsAbrirReserva",param );
			return ambiente;
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			session.close();
		}
		return null;
	}
	
	@SuppressWarnings("unchecked")
	public List<AmbienteDTO> buscarConveDeReserva(String desde, String hasta){
		SqlSession session = sqlMapper.openSession();
		List<AmbienteDTO> ambiente=new ArrayList<AmbienteDTO>();
		try {
			Map<String, String> param=new HashMap<String, String>();
			param.put("desde", desde);
			param.put("hasta",hasta);			
			ambiente =(List<AmbienteDTO>) session.selectList("q_buscarConveAbrirReserva",param );
			return ambiente;
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			session.close();
		}
		return null;
	}
	
	@SuppressWarnings("unchecked")
	public List<AmbienteDTO> buscarAmbienteDeReserva(String desde, String hasta){
		SqlSession session = sqlMapper.openSession();
		List<AmbienteDTO> ambiente=new ArrayList<AmbienteDTO>();
		try {
			Map<String, String> param=new HashMap<String, String>();
			param.put("desde", desde);
			param.put("hasta",hasta);			
			ambiente =(List<AmbienteDTO>) session.selectList("q_buscarAmbAbrirReserva",param );
			return ambiente;
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			session.close();
		}
		return null;
	}
	
	@SuppressWarnings("unchecked")
	public List<Map<String, Object>> busquedaReservaParamPersona(PersonaDTO p){
		SqlSession session = sqlMapper.openSession();
		
		try {
			return (List<Map<String, Object>>) session.selectList("busquedaReservaParamPersona", p);
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			session.close();
		}
		return new ArrayList<Map<String, Object>>();
	}
	
	@SuppressWarnings("unchecked")
	public List<Map<String, Object>> buscarReservaByLogged(int idUsuario){
		SqlSession session = sqlMapper.openSession();
		try {
			return session.selectList("q_buscarReservaByLogged", idUsuario);			
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			session.close();
		}
		return new ArrayList<Map<String, Object>>();
	}
	
	@SuppressWarnings("unchecked")
	public List<Map<String, Object>> buscarReservaByUsuario(String user,String pwd){
		SqlSession session = sqlMapper.openSession();
		try {
			Map<String, String> param=new HashMap<String, String>();
			param.put("desde", user);
			param.put("hasta",pwd);			
			return session.selectList("q_buscarReservaByUsuario", param);			
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			session.close();
		}
		return new ArrayList<Map<String, Object>>();
	}
	
	public void qdml_insertDetalleReserva(String idReserva, String idAmbiente, String desde, String hasta){
		SqlSession session = sqlMapper.openSession();
		
		try {
			Map<String, String> param=new HashMap<String, String>();
			param.put("param1", idReserva);
			param.put("param2", idAmbiente);
			param.put("param3", desde);
			param.put("param4", hasta);
			session.selectOne("qdml_insertDetalleReserva",param);			
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			session.close();
		}
	}
	
	@SuppressWarnings("unchecked")
	public List<Map<String, Object>> listarReservasByIdCliente(int idUsuario){
		SqlSession session = sqlMapper.openSession();
		List<Map<String, Object>> result=new ArrayList<Map<String, Object>>();
		try {
			result =(List<Map<String, Object>>) session.selectList("q_listarReservasByIdUsuario", idUsuario);
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			session.close();
		}
		return result;
	}
}
