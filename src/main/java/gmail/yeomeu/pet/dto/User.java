package gmail.yeomeu.pet.dto;

public class User {
	
	private String email;
	private String password;
	private String created;
	
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
	
	/* (non-Javadoc)
	 * @see java.lang.Object#toString()
	 */
	@Override
	public String toString() {
		return "User [email=" + email + ", password=" + password + ", created=" + created + "]";
	}
	
}