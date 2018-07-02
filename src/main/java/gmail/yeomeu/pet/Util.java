package gmail.yeomeu.pet;

import java.text.SimpleDateFormat;
import java.util.Date;

public class Util {

	// Util.today("yyyyMMdd");
	public static String today(String format ) {
		SimpleDateFormat sdf = new SimpleDateFormat(format);
		String today = sdf.format(new Date());
		return today;
	}
}
