package gmail.yeomeu.pet.dto;

import java.util.Date;

public class LostPet {

	private Integer seq;
	private User owner;
	private String email;
	private String petBreed;
	private Double lng;
	private Double lat;
	private Date lostTime;
	private String title;
	private String desc;
	private Integer reward;
	
	public Integer getSeq() {
		return seq;
	}
	public void setSeq(Integer seq) {
		this.seq = seq;
	}
	public User getOwner() {
		return owner;
	}
	public void setOwner(User owner) {
		this.owner = owner;
	}
	public String getEmail() {
		return email;
	}
	public void setEmail(String email) {
		this.email = email;
	}
	public String getPetBreed() {
		return petBreed;
	}
	public void setPetBreed(String petBreed) {
		this.petBreed = petBreed;
	}
	public Double getLng() {
		return lng;
	}
	public void setLng(Double lng) {
		this.lng = lng;
	}
	public Double getLat() {
		return lat;
	}
	public void setLat(Double lat) {
		this.lat = lat;
	}
	public Date getLostTime() {
		return lostTime;
	}
	public void setLostTime(Date lostTime) {
		this.lostTime = lostTime;
	}
	public String getTitle() {
		return title;
	}
	public void setTitle(String title) {
		this.title = title;
	}
	public String getDesc() {
		return desc;
	}
	public void setDesc(String desc) {
		this.desc = desc;
	}
	public Integer getReward() {
		return reward;
	}
	public void setReward(Integer reward) {
		this.reward = reward;
	}
	
	@Override
	public String toString() {
		return "LostPet [seq=" + seq + ", owner=" + owner + ", petBreed=" + petBreed + ", lng=" + lng + ", lat=" + lat
				+ ", lostTime=" + lostTime + ", desc=" + desc + ", reward=" + reward + "]";
	}
}