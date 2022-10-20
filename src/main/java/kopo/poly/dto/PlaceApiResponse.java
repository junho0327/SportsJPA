package kopo.poly.dto;

import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;

import java.util.List;


@Data
@Builder
@AllArgsConstructor
@NoArgsConstructor
public class PlaceApiResponse {
    private String size; // 규모
    private String address; // 소재지
    private String placeName; // 시설물명
    private String placeNm; // 연번
    private String placeTime; // 운영 시간
    private String mainService; // 주요 시설


    private List<ProgramApiResponse> programApiResponses;


}
