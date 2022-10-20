package kopo.poly.controller;

import kopo.poly.dto.ApiRequest;
import kopo.poly.dto.ApiResponse;
import kopo.poly.dto.PlaceApiResponse;
import kopo.poly.dto.ProgramApiResponse;
import kopo.poly.service.impl.ApiServiceImpl;
import kopo.poly.util.CmmUtil;
import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import java.util.ArrayList;
import java.util.List;

@Slf4j
@Controller
@RequiredArgsConstructor
public class SportsController {

    private final ApiServiceImpl apiService;

    @GetMapping(value = "/index1")
    public String Index1(ModelMap model) throws Exception {
        log.info(this.getClass().getName()+".Index1 Start!");

        List<PlaceApiResponse> placeApiResponses =  apiService.getPlaceInfoFromApi(ApiRequest.builder().page("1").build());
        List<ProgramApiResponse> programApiResponses = apiService.getProgramInfoFromApi(ApiRequest.builder().page("1").build());

        model.addAttribute("placeList", placeApiResponses);
        model.addAttribute("programList", programApiResponses);

        return "/index1";

    }

    @RequestMapping(value = "sports/main")
    public String main(ModelMap model)
            throws Exception {

        // 로그 찍기(추후 찍은 로그를 통해 이 함수에 접근했는지 파악하기 용이하다.)
        log.info(this.getClass().getName() + ".main start!");


        // 로그 찍기(추후 찍은 로그를 통해 이 함수 호출이 끝났는지 파악하기 용이하다.)
        log.info(this.getClass().getName() + ".main end!");

        // 함수 처리가 끝나고 보여줄 JSP 파일명(/WEB-INF/view/notice/NoticeList.jsp)
        return "/sports/main";

    }

    @RequestMapping(value = "sports/apimain")
    public String apimain(HttpServletRequest request, ModelMap model) throws Exception {

        // 로그 찍기(추후 찍은 로그를 통해 이 함수에 접근했는지 파악하기 용이하다.)
        log.info(this.getClass().getName() + ".apimain start!");

        List<PlaceApiResponse> placeApiResponses =  apiService.getPlaceInfoFromApi(ApiRequest.builder().page("1").build());

        model.addAttribute("placeList", placeApiResponses);

        // 로그 찍기(추후 찍은 로그를 통해 이 함수 호출이 끝났는지 파악하기 용이하다.)
        log.info(this.getClass().getName() + ".apimain end!");

        // 함수 처리가 끝나고 보여줄 JSP 파일명(/WEB-INF/view/notice/NoticeList.jsp)
        return "/sports/apimain";

    }

    @RequestMapping(value = "sports/program")
    public String program(ModelMap model)
            throws Exception {

        // 로그 찍기(추후 찍은 로그를 통해 이 함수에 접근했는지 파악하기 용이하다.)
        log.info(this.getClass().getName() + ".program start!");

        List<ProgramApiResponse> programApiResponses = apiService.getProgramInfoFromApi(ApiRequest.builder().page("1").build());

        model.addAttribute("programList", programApiResponses);

        // 로그 찍기(추후 찍은 로그를 통해 이 함수 호출이 끝났는지 파악하기 용이하다.)
        log.info(this.getClass().getName() + ".program end!");

        // 함수 처리가 끝나고 보여줄 JSP 파일명(/WEB-INF/view/notice/NoticeList.jsp)
        return "/sports/program";

    }

    @RequestMapping(value = "sports/test")
    public String test(ModelMap model)
            throws Exception {

        // 로그 찍기(추후 찍은 로그를 통해 이 함수에 접근했는지 파악하기 용이하다.)
        log.info(this.getClass().getName() + ".test start!");


        // 로그 찍기(추후 찍은 로그를 통해 이 함수 호출이 끝났는지 파악하기 용이하다.)
        log.info(this.getClass().getName() + ".test end!");

        // 함수 처리가 끝나고 보여줄 JSP 파일명(/WEB-INF/view/notice/NoticeList.jsp)
        return "/sports/test";

    }


}
