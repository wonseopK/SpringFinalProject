package data.chat;

import org.apache.ibatis.type.Alias;

import lombok.Data;

@Data
@Alias("CDTO")
public class ChatDTO {
	private String num;
	// 방번호
	private int room;
	// 발송자
	private String send_id;
	// 수신자
	private String recv_id;
	// 보낸시간
	private String send_time;
	// 읽은시간
	private String read_time;
	// 내용
	private String content;
	// 읽었는지 확인
	private String read_check;
	// 현재 사용자의 메세지 상대 id저장
	private String other_id;
	// 현재 사용자의 메세지 상대 profile저장
	private String photo;	
	// 현재 사용자 id
	private String id;	
	// 안읽은 메세지 갯수 
	private int unread;
	// 방을 나간 회원 아이디
	private String exit_id;
	// 방을 나간 회원수
	private int exit_count;
	
}
