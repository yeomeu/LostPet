package gmail.yeomeu.pet.dto;

public class RemoteLostPet {

	Long seq;
	Long desertionNo;	// 유기번호
	String careAddr;	// 보호장소
	double lat ;
	double lng ;
	String careNm;		// 보호소이름
	String careTel;		// 보호소전화번호
	String chargeNm;	// 담당자
	String popfile;		// 유기동물 사진
	String happenDt;	// 접수일 (YYYYMMDD)
	String happenPlace;	// 발견장소
	String kindCd;		// 품종
	String sexCd;		// 성별 (M,F,Q)
	String noticeSdt;	// 공고시작일 (YYYYMMDD)
	String noticeEdt;	// 공고종료일 (YYYYMMDD)
	String noticeNo;	// 공고번호 
	String officeTel;	// 담당자연락처
	
	/**
	 * @return the seq
	 */
	public Long getSeq() {
		return seq;
	}
	/**
	 * @param seq the seq to set
	 */
	public void setSeq(Long seq) {
		this.seq = seq;
	}
	/**
	 * @return the desertionNo
	 */
	public Long getDesertionNo() {
		return desertionNo;
	}
	/**
	 * @param desertionNo the desertionNo to set
	 */
	public void setDesertionNo(Long desertionNo) {
		this.desertionNo = desertionNo;
	}
	/**
	 * @return the careAddr
	 */
	public String getCareAddr() {
		return careAddr;
	}
	/**
	 * @param careAddr the careAddr to set
	 */
	public void setCareAddr(String careAddr) {
		this.careAddr = careAddr;
	}
	/**
	 * @return the careNm
	 */
	public String getCareNm() {
		return careNm;
	}
	/**
	 * @param careNm the careNm to set
	 */
	public void setCareNm(String careNm) {
		this.careNm = careNm;
	}
	/**
	 * @return the careTel
	 */
	public String getCareTel() {
		return careTel;
	}
	/**
	 * @param careTel the careTel to set
	 */
	public void setCareTel(String careTel) {
		this.careTel = careTel;
	}
	/**
	 * @return the chargeNm
	 */
	public String getChargeNm() {
		return chargeNm;
	}
	/**
	 * @param chargeNm the chargeNm to set
	 */
	public void setChargeNm(String chargeNm) {
		this.chargeNm = chargeNm;
	}
	/**
	 * @return the popfile
	 */
	public String getPopfile() {
		return popfile;
	}
	/**
	 * @param popfile the popfile to set
	 */
	public void setPopfile(String popfile) {
		this.popfile = popfile;
	}
	/**
	 * @return the happenDt
	 */
	public String getHappenDt() {
		return happenDt;
	}
	/**
	 * @param happenDt the happenDt to set
	 */
	public void setHappenDt(String happenDt) {
		this.happenDt = happenDt;
	}
	/**
	 * @return the happenPlace
	 */
	public String getHappenPlace() {
		return happenPlace;
	}
	/**
	 * @param happenPlace the happenPlace to set
	 */
	public void setHappenPlace(String happenPlace) {
		this.happenPlace = happenPlace;
	}
	/**
	 * @return the kindCd
	 */
	public String getKindCd() {
		return kindCd;
	}
	/**
	 * @param kindCd the kindCd to set
	 */
	public void setKindCd(String kindCd) {
		this.kindCd = kindCd;
	}
	/**
	 * @return the sexCd
	 */
	public String getSexCd() {
		return sexCd;
	}
	/**
	 * @param sexCd the sexCd to set
	 */
	public void setSexCd(String sexCd) {
		this.sexCd = sexCd;
	}
	/**
	 * @return the noticeSdt
	 */
	public String getNoticeSdt() {
		return noticeSdt;
	}
	/**
	 * @param noticeSdt the noticeSdt to set
	 */
	public void setNoticeSdt(String noticeSdt) {
		this.noticeSdt = noticeSdt;
	}
	/**
	 * @return the noticeEdt
	 */
	public String getNoticeEdt() {
		return noticeEdt;
	}
	/**
	 * @param noticeEdt the noticeEdt to set
	 */
	public void setNoticeEdt(String noticeEdt) {
		this.noticeEdt = noticeEdt;
	}
	/**
	 * @return the noticeNo
	 */
	public String getNoticeNo() {
		return noticeNo;
	}
	/**
	 * @param noticeNo the noticeNo to set
	 */
	public void setNoticeNo(String noticeNo) {
		this.noticeNo = noticeNo;
	}
	/**
	 * @return the officeTel
	 */
	public String getOfficeTel() {
		return officeTel;
	}
	/**
	 * @param officeTel the officeTel to set
	 */
	public void setOfficeTel(String officeTel) {
		this.officeTel = officeTel;
	}
	/**
	 * @return the lat
	 */
	public double getLat() {
		return lat;
	}
	/**
	 * @param lat the lat to set
	 */
	public void setLat(double lat) {
		this.lat = lat;
	}
	/**
	 * @return the lng
	 */
	public double getLng() {
		return lng;
	}
	/**
	 * @param lng the lng to set
	 */
	public void setLng(double lng) {
		this.lng = lng;
	}
	/* (non-Javadoc)
	 * @see java.lang.Object#toString()
	 */
	@Override
	public String toString() {
		return "RemoteLostPet [seq=" + seq + ", desertionNo=" + desertionNo + ", careAddr=" + careAddr + ", lat=" + lat
				+ ", lng=" + lng + ", careNm=" + careNm + ", careTel=" + careTel + ", chargeNm=" + chargeNm
				+ ", popfile=" + popfile + ", happenDt=" + happenDt + ", happenPlace=" + happenPlace + ", kindCd="
				+ kindCd + ", sexCd=" + sexCd + ", noticeSdt=" + noticeSdt + ", noticeEdt=" + noticeEdt + ", noticeNo="
				+ noticeNo + ", officeTel=" + officeTel + "]";
	}
}