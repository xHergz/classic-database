CREATE TABLE Map
(
    Map_Id INT NOT NULL,
    Planet_Id INT NOT NULL,
    Name VARCHAR(50) NOT NULL,
    PRIMARY KEY (Map_Id),
    FOREIGN KEY (Planet_Id) REFERENCES Planet(Planet_Id)
);
