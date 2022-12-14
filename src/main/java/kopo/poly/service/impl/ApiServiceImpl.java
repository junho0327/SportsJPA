package kopo.poly.service.impl;

import kopo.poly.dto.ApiRequest;
import kopo.poly.dto.ApiResponse;
import kopo.poly.dto.PlaceApiResponse;
import kopo.poly.dto.ProgramApiResponse;
import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import org.springframework.core.env.Environment;
import org.springframework.http.*;
import org.springframework.stereotype.Service;
import org.springframework.web.client.RestTemplate;

import java.net.URI;
import java.util.LinkedList;
import java.util.List;
import java.util.Map;

import static kopo.poly.constants.ApiConstants.PLACE_API_END_POINT;
import static kopo.poly.constants.ApiConstants.PROGRAM_API_END_POINT;

@Service
@Slf4j
@RequiredArgsConstructor
public class ApiServiceImpl {
    private final Environment env;

    private final RestTemplate restTemplate;


    public List<PlaceApiResponse> getPlaceInfoFromApi(final ApiRequest request) throws Exception {

        final URI uri = makeUri(PLACE_API_END_POINT, request);

        HttpHeaders headers = new HttpHeaders();
        headers.setContentType(MediaType.APPLICATION_JSON);
        headers.add("Authorization", env.getProperty("openApi.serviceKey"));

        HttpEntity<Map<String, Object>> entity = new HttpEntity<>(headers);

        ResponseEntity<ApiResponse> response = restTemplate.exchange(uri, HttpMethod.GET, entity, ApiResponse.class);


        List<PlaceApiResponse> result = mappingMapToPlaceApiResponse(response.getBody().getData());

        log.info("Result size : " + result.size());

        return result;

    }

    public List<ProgramApiResponse> getProgramInfoFromApi(final ApiRequest request) throws Exception {


        final URI uri = makeUri(PROGRAM_API_END_POINT, request);

        HttpHeaders headers = new HttpHeaders();
        headers.setContentType(MediaType.APPLICATION_JSON);
        headers.add("Authorization", env.getProperty("openApi.serviceKey"));

        HttpEntity<Map<String, Object>> entity = new HttpEntity<>(headers);

        ResponseEntity<ApiResponse> response = restTemplate.exchange(uri, HttpMethod.GET, entity, ApiResponse.class);


        List<ProgramApiResponse> result = mappingMapToProgramApiResponse(response.getBody().getData());


        return result;

    }

    private List<PlaceApiResponse> mappingMapToPlaceApiResponse(List<Map<String, Object>> data) {

        log.info("ApiResponse Size : " + data.size());

        List<PlaceApiResponse> placeApiResponses = new LinkedList<>();
        for (int i = 0; i < data.size(); i++) {
            placeApiResponses.add(PlaceApiResponse.builder()
                    .size(String.valueOf(data.get(i).get("??????")))
                    .address(String.valueOf(data.get(i).get("?????????")))
                    .placeName(String.valueOf(data.get(i).get("????????????")))
                    .placeNm(String.valueOf(data.get(i).get("??????")))
                    .placeTime(String.valueOf(data.get(i).get("????????????")))
                    .mainService(String.valueOf(data.get(i).get("????????????"))).build());


        }


        return placeApiResponses;

    }

    private List<ProgramApiResponse> mappingMapToProgramApiResponse(List<Map<String, Object>> data) {

        log.info("ApiResponse Size : " + data.size());

        List<ProgramApiResponse> programApiResponses = new LinkedList<>();

        for (int i = 0; i < data.size(); i++) {
            programApiResponses.add(ProgramApiResponse.builder()
                    .target(String.valueOf(data.get(i).get("??????")))
                    .category(String.valueOf(data.get(i).get("??????")))
                    .price(String.valueOf(data.get(i).get("????????????")))
                    .time(String.valueOf(data.get(i).get("??????")))
                    .programNm(String.valueOf(data.get(i).get("??????")))
                    .programDate(String.valueOf(data.get(i).get("??????")))
                    .programMaxPeople(String.valueOf(data.get(i).get("??????")))
                    .programName(String.valueOf(data.get(i).get("????????????"))).build());


        }


        return programApiResponses;

    }

    private URI makeUri(final String url, final ApiRequest request) throws Exception {
        return new URI(url
                + "?page=" + String.valueOf(request.getPage())
                + "&perPage=" + String.valueOf(request.getPerPage())
                + "&serviceKey=" + "9jk%2FOV%2BWGjezmyxbgwaMrhnRmMqlZA6eirdAFva46bSKZRsrf%2B6KJovpVq1Nx0VJnfbdXOYvqWDtZlSoT0FcqA%3D%3D");
    }


}
