package com.team.project;

import org.mybatis.spring.annotation.MapperScan;
import org.springframework.boot.SpringApplication;
import org.springframework.boot.autoconfigure.SpringBootApplication;
import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.ComponentScan;
import org.springframework.context.annotation.Configuration;
import org.springframework.http.converter.json.Jackson2ObjectMapperBuilder;
import org.springframework.http.converter.json.MappingJackson2HttpMessageConverter;
import org.springframework.web.servlet.config.annotation.WebMvcConfigurer;

import com.fasterxml.jackson.databind.ObjectMapper;

@SpringBootApplication
@ComponentScan({"data.*", "com.team.project"})
@MapperScan("data.*")
public class FinalProjectApplication {

	public static void main(String[] args) {
		SpringApplication.run(FinalProjectApplication.class, args);
	}
	@Configuration
	public class WebMvcConfig implements WebMvcConfigurer {

	    @Bean
	    public MappingJackson2HttpMessageConverter jsonEscapeConverter() {
	        // MappingJackson2HttpMessageConverter Default ObjectMapper 설정 및 ObjectMapper Config 설정
	        ObjectMapper objectMapper = Jackson2ObjectMapperBuilder.json().build();
	        objectMapper.getFactory().setCharacterEscapes(new HTMLCharacterEscapes());
	        return new MappingJackson2HttpMessageConverter(objectMapper);
	    }

	}

}
