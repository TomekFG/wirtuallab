package com.example.accessingdatamysql;

import static net.bytebuddy.matcher.ElementMatchers.is;
import static org.hamcrest.Matchers.containsString;
import static org.springframework.test.web.servlet.request.MockMvcRequestBuilders.get;
import static org.springframework.test.web.servlet.request.MockMvcRequestBuilders.post;
import static org.springframework.test.web.servlet.result.MockMvcResultHandlers.print;
import static org.springframework.test.web.servlet.result.MockMvcResultMatchers.content;
import static org.springframework.test.web.servlet.result.MockMvcResultMatchers.status;

import com.fasterxml.jackson.annotation.JsonAutoDetect;
import com.fasterxml.jackson.annotation.JsonIgnore;
import com.fasterxml.jackson.annotation.PropertyAccessor;
import com.fasterxml.jackson.databind.ObjectMapper;
import org.assertj.core.api.Assertions;
import org.json.JSONArray;
import org.json.JSONObject;
import org.junit.jupiter.api.Test;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.boot.test.autoconfigure.web.servlet.AutoConfigureMockMvc;
import org.springframework.boot.test.context.SpringBootTest;
import org.springframework.http.MediaType;
import org.springframework.test.web.servlet.MockMvc;
import org.springframework.test.web.servlet.MvcResult;
import org.springframework.test.web.servlet.result.MockMvcResultMatchers;

import java.nio.charset.StandardCharsets;

@SpringBootTest
@AutoConfigureMockMvc
@JsonAutoDetect(fieldVisibility = JsonAutoDetect.Visibility.ANY)
class MainControllerTests {


    @Autowired
    private MockMvc mvc;

    @Autowired
    private ObjectMapper mapper;

    @Test
    void test_allStations() throws Exception {
        this.mvc.perform(get("/SQL/allStations")
                .contentType(MediaType.APPLICATION_JSON))
                .andExpect(status().isOk())
                .andExpect(content().contentTypeCompatibleWith(MediaType.APPLICATION_JSON));
    }

    @Test
    void test_stationById() throws Exception {
        this.mvc.perform(get("/SQL/stationByID?id=1")
                .contentType(MediaType.APPLICATION_JSON))
                .andExpect(status().isOk())
                .andExpect(content().contentTypeCompatibleWith(MediaType.APPLICATION_JSON));
    }

    @Test
    void test_allDevices() throws Exception {
        this.mvc.perform(get("/SQL/allDevices")
                .contentType(MediaType.APPLICATION_JSON))
                .andExpect(status().isOk())
                .andExpect(content().contentTypeCompatibleWith(MediaType.APPLICATION_JSON));
    }

    @Test
    void test_DeviceById() throws Exception {
        this.mvc.perform(get("/SQL/deviceByID?id=1")
                .contentType(MediaType.APPLICATION_JSON))
                .andExpect(status().isOk())
                .andExpect(content().contentTypeCompatibleWith(MediaType.APPLICATION_JSON));
    }

    @Test
    void test_DeviceByStationId() throws Exception {
        this.mvc.perform(get("/SQL/deviceByStationID?id=1")
                .contentType(MediaType.APPLICATION_JSON))
                .andExpect(status().isOk())
                .andExpect(content().contentTypeCompatibleWith(MediaType.APPLICATION_JSON));
    }

    @Test
    void test_allReadings() throws Exception {
        this.mvc.perform(get("/SQL/allReadings")
                .contentType(MediaType.APPLICATION_JSON))
                .andExpect(status().isOk())
                .andExpect(content().contentTypeCompatibleWith(MediaType.APPLICATION_JSON));
    }

    @Test
    void test_ReadingById() throws Exception {
        this.mvc.perform(get("/SQL/readingByID?id=1")
                .contentType(MediaType.APPLICATION_JSON))
                .andExpect(status().isOk())
                .andExpect(content().contentTypeCompatibleWith(MediaType.APPLICATION_JSON));
    }

    @Test
    void test_ReadingByDeviceId() throws Exception {
        this.mvc.perform(get("/SQL/readingByDeviceId?id=1")
                .contentType(MediaType.APPLICATION_JSON))
                .andExpect(status().isOk())
                .andExpect(content().contentTypeCompatibleWith(MediaType.APPLICATION_JSON));
    }

    @Test
    void test_addReading() throws Exception {


        MvcResult result = this.mvc.perform(post("/SQL/addReading?zapOpis='Wykonano pomiar temperatury'&zapCzas=2021-05-11&czuId=1&zapWartosc=20")
                .contentType(MediaType.APPLICATION_JSON)
                .accept(MediaType.APPLICATION_JSON)).andExpect(MockMvcResultMatchers.status().isOk())
                .andReturn();

        Assertions.assertThat(result).isNotNull();

    }

    @Test
    void test_addReading_Bad() throws Exception {


        MvcResult result = this.mvc.perform(post("/SQL/addReading?zapOpis='Wykonano pomiar temperatury'&zapCzas=2021-05-11&czuId=1")
                .contentType(MediaType.APPLICATION_JSON)
                .accept(MediaType.APPLICATION_JSON)).andExpect(MockMvcResultMatchers.status().isBadRequest())
                .andReturn();

        Assertions.assertThat(result).isNotNull();

    }

    @Test
    void test_updateReading() throws Exception {


        MvcResult result = this.mvc.perform(post("/SQL/updateReading?id=1&zapOpis='Wykonano pomiar temperatury (edytowano)'&zapCzas=2021-05-11&czuId=1&zapWartosc=30")
                .contentType(MediaType.APPLICATION_JSON)
                .accept(MediaType.APPLICATION_JSON)).andExpect(MockMvcResultMatchers.status().isOk())
                .andReturn();

        Assertions.assertThat(result).isNotNull();

    }

    @Test
    void test_updateReading_Bad() throws Exception {


        MvcResult result = this.mvc.perform(post("/SQL/updateReading?zapOpis='Wykonano pomiar temperatury (edytowano)'&zapCzas=2021-05-11&czuId=1&zapWartosc=30")
                .contentType(MediaType.APPLICATION_JSON)
                .accept(MediaType.APPLICATION_JSON)).andExpect(MockMvcResultMatchers.status().isBadRequest())
                .andReturn();

        Assertions.assertThat(result).isNotNull();

    }
}