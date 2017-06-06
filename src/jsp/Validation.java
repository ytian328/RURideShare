package jsp;

import javax.mail.internet.AddressException;
import javax.mail.internet.InternetAddress;

public class Validation {
	public static boolean validEmail(String email) {
		boolean result = true;
		   try {
		      InternetAddress emailAddr = new InternetAddress(email);
		      emailAddr.validate();
		   } catch (AddressException ex) {
		      result = false;
		   }
		   return result;
	}
	
	public static boolean validPassword(String pwd) {
		if(pwd.length() < 6 || pwd.length() > 20) return false;
		String numRegex   = ".*[0-9].*";
		String alphaRegex = ".*[A-Z].*";

		return pwd.matches(numRegex) && pwd.matches(alphaRegex);
		
	}
}
