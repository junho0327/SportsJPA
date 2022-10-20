package kopo.poly.controller;

import kopo.poly.dto.ApiRequest;
import kopo.poly.dto.PlaceApiResponse;
import kopo.poly.dto.ProgramApiResponse;
import kopo.poly.service.impl.ApiServiceImpl;
import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RestController;

import java.util.List;

@RestController
@Slf4j
@RequiredArgsConstructor
public class ApiController {
    private final ApiServiceImpl apiService;


    @GetMapping("/places")
    public List<PlaceApiResponse> getPlace() throws Exception {
        return apiService.getPlaceInfoFromApi(ApiRequest.builder().page("1").build());

    }

    @GetMapping("/programs/{page}")
    public List<ProgramApiResponse> getProgram(@PathVariable String page) throws Exception {
        return apiService.getProgramInfoFromApi(ApiRequest.builder().page(page).build());

    }

    @GetMapping("/programs")
    public List<ProgramApiResponse> getProgramDefault() throws Exception {
        return apiService.getProgramInfoFromApi(ApiRequest.builder().page("1").build());

    }
}
