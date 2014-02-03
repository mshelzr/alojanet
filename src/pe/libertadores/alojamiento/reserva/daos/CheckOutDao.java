package pe.libertadores.alojamiento.reserva.daos;

import java.io.IOException;
import java.io.Reader;
import java.util.ArrayList;
import java.util.List;
import java.util.Map;

import org.apache.ibatis.io.Resources;
import org.apache.ibatis.session.SqlSession;
import org.apache.ibatis.session.SqlSessionFactory;
import org.apache.ibatis.session.SqlSessionFactoryBuilder;

public class CheckOutDao {
	
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
	public List<Map<String, Object>> listarConsumosPorDetalleReserva(int idDetalleReserva){
		SqlSession session = sqlMapper.openSession();
		List<Map<String, Object>> result=new ArrayList<Map<String, Object>>();
		try {
			result =(List<Map<String, Object>>) session.selectList("q_listarConsumosPorDetalleReserva", idDetalleReserva);
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			session.close();
		}
		return result;
	}
	
	@SuppressWarnings("unchecked")
	public List<Map<String, Object>> consumoByPersonaTarjeta(int idTarjetaPersona){
		SqlSession session = sqlMapper.openSession();
		try {
			return (List<Map<String, Object>>) session.selectList("q_consumoByPersonaTarjeta", idTarjetaPersona);
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			session.close();
		}
		return new ArrayList<Map<String, Object>>();
	}
	
}
