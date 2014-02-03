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

import pe.libertadores.dto.PersonaDTO;

public class CheckinDao {
	
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
	
	public PersonaDTO getPersonaByIdPersona(int idPersona){
		SqlSession session = sqlMapper.openSession();
		PersonaDTO personanew=new PersonaDTO();
		try {
			personanew =(PersonaDTO) session.selectOne("q_getPersonaByIdPersona", idPersona);			
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			session.close();
		}
		return personanew;
	}
	
	@SuppressWarnings("unchecked")
	public List<Map<String, Object>> listarDetalleReservaByIdReserva(int idReserva){
		SqlSession session = sqlMapper.openSession();
		List<Map<String, Object>> result=new ArrayList<Map<String, Object>>();
		try {
			result =(List<Map<String, Object>>) session.selectList("q_listarDetalleReservaByIdReserva", idReserva);
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			session.close();
		}
		return result;
	}
	
	@SuppressWarnings("unchecked")
	public Map<String, Object> getDetalleReserva(int idDetalleReserva){
		SqlSession session = sqlMapper.openSession();
		Map<String, Object> dr=new HashMap<String, Object>();
		try {
			dr =(Map<String, Object>) session.selectOne("q_getDetalleReservaByIdDetalleReserva",idDetalleReserva );
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			session.close();
		}
		return dr;
	}
	
	@SuppressWarnings("unchecked")
	public List<PersonaDTO> listarAcompanantes(int idDetalleReserva){
		SqlSession session = sqlMapper.openSession();
		List<PersonaDTO> persona=new ArrayList<PersonaDTO>();
		try {
			persona =(List<PersonaDTO>) session.selectList("q_listarAcompanantes",idDetalleReserva );
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			session.close();
		}
		return persona;
	}
	
	public int consultarDisponibilidadAmbiente(String idDetalleReserva, String desde, String hasta){
		SqlSession session = sqlMapper.openSession();
		int rs=0;
		try {
			Map<String, String> param=new HashMap<String, String>();
			param.put("desde", desde);
			param.put("hasta",hasta);
			param.put("param1",idDetalleReserva);
			rs=(int) session.selectOne("q_consultarDisponibilidadAmbiente",param );
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			session.close();
		}
		return rs;
	}
	
	public void guardarNuevoRangoDeReserva(String idDetalleReserva, String desde, String hasta){
		SqlSession session = sqlMapper.openSession();
		try {
			Map<String, String> param=new HashMap<String, String>();
			param.put("desde", desde);
			param.put("hasta",hasta);
			param.put("param1",idDetalleReserva);
			session.selectOne("q_guardarNuevoRangoDeReserva",param );
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			session.close();
		}
	}
	
}
