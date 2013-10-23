package de.olivelo.gamesearch.mvc;

import org.springframework.data.solr.repository.SolrCrudRepository;

import java.util.List;

public interface SolrGameRepository extends SolrCrudRepository<Game, String> {

    List<Game> findByGenre(String name);

}
