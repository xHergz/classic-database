CREATE TABLE Monster_Spawn
(
    Monster_Id INT NOT NULL,
    Map_Id INT NOT NULL,
    FOREIGN KEY Monster_Id REFERENCES Monster(Monster_Id),
    FOREIGN KEY Map_Id REFERENCES Map(Map_Id)
);
