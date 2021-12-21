package data.notice;

import java.util.HashMap;
import java.util.List;

import org.apache.ibatis.annotations.Mapper;
import org.springframework.stereotype.Service;

@Service
public class NoticeService {
	
	@Mapper
	NoticeMapper mapper;

//	public List<NoticeDTO> getNoticeList() {
//		return mapper.getNoticeList();
//		
//	}
//	public int getTotalCount() {
//		
//		return mapper.getTotalCount();
//	}
	
}
