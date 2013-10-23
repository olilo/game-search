package de.olivelo.gamesearch.mvc;

import org.apache.solr.client.solrj.beans.Field;
import org.hibernate.validator.constraints.NotEmpty;

import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import java.util.List;

@Entity
public class Game {

    @Id
    @GeneratedValue(strategy = GenerationType.AUTO)
    @Field("id")
    private long id;

    @Field("name")
    @NotEmpty
    private String name;

    @Field("year")
    @NotEmpty
    private Integer year;

    @Field("rating")
    private Integer rating;

    @Field("genre")
    private List<String> genre;

    protected Game() {
        // empty constructor to comply with bean contract
    }

    public long getId() {
        return id;
    }

    public String getName() {
        return name;
    }

    public void setName(String name) {
        this.name = name;
    }

    public Integer getYear() {
        return year;
    }

    public void setYear(Integer year) {
        this.year = year;
    }

    public Integer getRating() {
        return rating;
    }

    public void setRating(Integer rating) {
        this.rating = rating;
    }

    public List<String> getGenre() {
        return genre;
    }

    public void setGenre(List<String> genre) {
        this.genre = genre;
    }
}
