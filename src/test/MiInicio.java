package test;
import java.lang.reflect.Method;
import java.util.ArrayList;
import java.util.List;


public class MiInicio {

	public static void main(String[] args) {
		try {
			MenuDTO m = new MenuDTO();
			m.setIdMenu(1);
			m.setDescripcion("Menu1");
			m.setUrl("micasa");
	
			MenuDTO m2 = new MenuDTO();
			m2.setIdMenu(2);
			m2.setDescripcion("Menu2");
			m2.setUrl("micasa2");
			
			MenuDTO m3 = new MenuDTO();
			m3.setIdMenu(3);
			m3.setDescripcion("Menu3");
			m3.setUrl("micasa3");
			
			MenuDTO m4 = new MenuDTO();
			m4.setIdMenu(1);
			m4.setDescripcion("Menu4");
			m4.setUrl("micasa4");
			
			List<MenuDTO> lst = new ArrayList<MenuDTO>();
			lst.add(m);
			lst.add(m2);
			lst.add(m3);
			lst.add(m4);
			
			List<Object> rs = new MiInicio().eliminarRepeticiones(lst, "getIdMenu");
		
			for (Object object : rs) {
				System.out.println(object);
			}
		} catch (Exception e) {
			e.printStackTrace();
		}
	}

	public List<Object> eliminarRepeticiones(List<?> l, String method){

		ArrayList<Object> o = new ArrayList<Object>();

		for (Object obj : l) {
			long val = returnId(obj, method);
			boolean flagRepeat = false;

			for (Object obj2 : o) {
				long val2 = returnId(obj2, method);
				if(val == val2){
					System.out.println(val + " == " + val2);
					flagRepeat = true;
					break;
				}
			}
			
			if(!flagRepeat){
				o.add(obj);
			}
		}
		return o;
	}

	private long returnId(Object entity, String method){
		long val = 0;
		
		try {			
			Object ent = entity;
			Method met = ent.getClass().getMethod(method);
			val = (long) met.invoke(ent);
		} catch (Exception e) {
			e.printStackTrace();
		}

		return val;
	}

}
