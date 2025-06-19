package boardV02;

public class UserDTO {
    private String userId;
    private String userPw;
    private String userName;
    private String userEmail;
    private String userBirth;
    private String createdAt;
    private String profileImg;

    public UserDTO() {}

    public UserDTO(String userId, String userPw, String userName, String userEmail, String userBirth, String createdAt) {
        this.userId = userId;
        this.userPw = userPw;
        this.userName = userName;
        this.userEmail = userEmail;
        this.userBirth = userBirth;
        this.createdAt = createdAt;
    }

    public String getUserId() { return userId; }
    public void setUserId(String userId) { this.userId = userId; }

    public String getUserPw() { return userPw; }
    public void setUserPw(String userPw) { this.userPw = userPw; }

    public String getUserName() { return userName; }
    public void setUserName(String userName) { this.userName = userName; }
    
    public String getUserEmail() { return userEmail; }
    public void setUserEmail(String userEmail) { this.userEmail = userEmail; }
    
    public String getUserBirth() { return userBirth; }
    public void setUserBirth(String userBirth) { this.userBirth = userBirth; }

    public String getCreatedAt() { return createdAt; }
    public void setCreatedAt(String createdAt) { this.createdAt = createdAt; }
    
    public String getProfileImg() { return profileImg; }
    public void setProfileImg(String profileImg) { this.profileImg = profileImg; }
}
