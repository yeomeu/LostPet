package gmail.yeomeu.pet.dto;

public class User {
	
	private String email;
	private String password;
	private String created;
	private String stime;
	private String etime;
	
	public User(){}

	public User(String email, String password, String created) {
		super();
		this.email = email;
		this.password = password;
		this.created = created;
	}


	public String getEmail() {
		return email;
	}
	public void setEmail(String email) {
		this.email = email;
	}
	public String getPassword() {
		return password;
	}
	public void setPassword(String password) {
		this.password = password;
	}
	public String getCreated() {
		return created;
	}

	public void setCreated(String created) {
		this.created = created;
	}

	
	/**
	 * @return the stime
	 */
	public String getStime() {
		return stime;
	}

	/**
	 * @param stime the stime to set
	 */
	public void setStime(String stime) {
		this.stime = stime;
	}

	/**
	 * @return the etime
	 */
	public String getEtime() {
		return etime;
	}

	/**
	 * @param etime the etime to set
	 */
	public void setEtime(String etime) {
		this.etime = etime;
	}

	/* (non-Javadoc)
	 * @see java.lang.Object#toString()
	 */
	@Override
	public String toString() {
		return "User [email=" + email + ", password=" + password + ", created=" + created + "]";
	}
	
}