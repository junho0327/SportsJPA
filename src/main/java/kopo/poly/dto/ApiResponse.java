package kopo.poly.dto;

import lombok.Data;

import java.util.List;
import java.util.Map;

@Data
public class ApiResponse {
    private String currentCount;

    private List<Map<String, Object>> data;
}
