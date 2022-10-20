package kopo.poly.dto;

import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Getter;

@Getter
@Builder
@AllArgsConstructor
public class ApiRequest {
    private String page; // page 번호 // can be null
    private String perPage; // 장당 표시 수 // can be null
}
