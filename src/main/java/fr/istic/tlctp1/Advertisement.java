package fr.istic.tlctp1;

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
    public float price;
    @Id
    public Long id;
    public String author_email;
}
