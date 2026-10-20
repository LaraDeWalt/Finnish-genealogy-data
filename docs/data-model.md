# Data Model

This document will describe the design decisions behind the genealogy database.

The model will address historical-data challenges such as changing names, patronymics, household structures, residence over time, place identifiers, relationships between people, source references and uncertainty in archival records.

The data model will be documented alongside the SQL schema as the project develops.


## Core design principle

The database separates historical persons and places from observations found in archival sources.

A person or place represents an entity identified during research, while an observation represents what a particular historical source says about that entity at a specific time.

This distinction is important because historical sources may contain incomplete, conflicting or changing information.

## Main tables

The current data model consists of the following main tables:

- **Henkilöt (Persons)** – identified persons and their normalized basic information
- **Paikat (Places)** – identified historical places
- **Paikkahavainnot (Place observations)** – source-specific information about places, including historical hierarchy and place type
- **Havainnot (Observations)** – source-specific information recorded about a person at a particular place or time
- **Suhteet (Relationships)** – identified relationships between persons, such as parent-child relationships and marriages
- **Suhdelähteet (Relationship sources)** – source references and evidence supporting identified relationships
- **Lähteet (Sources)** – archival sources used in the research
- **Rippikirjamerkinnät (Communion book entries)** – recurring and special entries connected to a person's observation in a communion book

  
## Entity relationship diagram

The current database structure can be represented with the following entity relationship diagram.
```mermaid
erDiagram

    HENKILOT {
        string person_id PK
    }

    PAIKAT {
        string place_id PK
    }

    LAHTEET {
        string lahde_id PK
    }

    HAVAINNOT {
        string havainto_id PK
        string person_id FK
        string place_id FK
        string lahde_id FK
    }

    PAIKKAHAVAINNOT {
        string paikkahavainto_id PK
        string place_id FK
        string parent_place_id FK
        string lahde_id FK
    }

    SUHTEET {
        string suhde_id PK
        string person_id_1 FK
        string person_id_2 FK
    }

    SUHDELAHTEET {
        string suhdelahde_id PK
        string suhde_id FK
        string lahde_id FK
    }

    RIPPIKIRJAMERKINNAT {
        string merkinta_id PK
        string havainto_id FK
    }

    HENKILOT ||--o{ HAVAINNOT : records
    PAIKAT ||--o{ HAVAINNOT : location
    LAHTEET ||--o{ HAVAINNOT : source

    PAIKAT ||--o{ PAIKKAHAVAINNOT : observations
    LAHTEET ||--o{ PAIKKAHAVAINNOT : source

    HAVAINNOT ||--o{ RIPPIKIRJAMERKINNAT : entries

    HENKILOT ||--o{ SUHTEET : person
    SUHTEET ||--o{ SUHDELAHTEET : evidence
    LAHTEET ||--o{ SUHDELAHTEET : source
```
