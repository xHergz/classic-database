CREATE TABLE Monster
(
    Monster_Id INT AUTO_INCREMENT,
    Monster_Type_Id INT AUTO_INCREMENT,
    Name VARCHAR(50) NOT NULL,
    Level INT NOT NULL,
    PRIMARY KEY(Monster_Id),
    FOREIGN KEY(Monster_Type_Id) REFERENCES Planet(Monster_Type_Id)
);
