package fr.istic.tlctp1;

import com.googlecode.objectify.Key;
import com.googlecode.objectify.annotation.Entity;
import com.googlecode.objectify.annotation.Id;

import java.util.Date;

/**
 * Created by ramage on 20/01/16.
 */
@Entity
public class Advertisement {
    public Date date;
    public String title;
    public Float price;
    @Id
    public Long id;

    public String author_email;
    public String author_id;


    /**
     * Simple constructor just sets the date
     **/
    public Advertisement() {
        date = new Date();
    }

    /**
     * A connivence constructor
     **/
    public Advertisement(String title, float price) {
        this();
        if( title != null ) {
            this.title = title;
            this.price = price;
        }

    }

    /**
     * Takes all important fields
     **/
    public Advertisement(String book, float price, String author_id, String email) {
        this(book, price);
        this.author_email = email;
        this.author_id = author_id;
    }

}
