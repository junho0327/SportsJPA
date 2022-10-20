package kopo.poly.dto;

import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@Builder
@NoArgsConstructor
@AllArgsConstructor
public class ProgramApiResponse {
    private String target; // 대상
    private String category; // 분야
    private String price; // 수강요금
    private String time; // 시간
    private String programNm; // 연번
    private String programDate; // 요일
    private String programMaxPeople; // 정원
    private String programName; // 프로그램 이름
}
