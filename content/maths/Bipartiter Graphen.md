---
created: 2026-03-26
modified: 2026-04-03
published: 2026-04-01
---

#graphentheorie

> [!definiton] Bipartier Graph
> Ein Graph G = (V, E) heißt **bipartit**, wenn sich die Knotenmenge in zwei Gruppen V₁ und V₂ aufteilen lässt, sodass **jede Kante** einen Knoten aus V₁ mit einem aus V₂ verbindet – also keine Kanten innerhalb derselben Gruppe.

- Jeder bipartite Graph kann mit **genau 2 Farben** gefärbt werden (V₁ bekommt Farbe 1, V₂ Farbe 2)
- Umgekehrt: Wenn ein Graph 2-färbbar ist, dann ist er bipartit

- **Jeder Baum** (kreisfreier Graph) **ist bipartit** (Korollar 3.3)
- Ein Graph ist **genau dann nicht bipartit**, wenn er einen **[[Kreis bei einem Graphen | Kreis]] ungerader Länge** enthält

## Test

Man färbt einen Knoten mit Farbe 1, dessen Nachbarn mit Farbe 2, deren Nachbarn wieder mit Farbe 1 usw. Stößt man auf einen Knoten, der schon die „falsche" Farbe hat → nicht bipartit → Kreis ungerader Länge gefunden.

## Beispiel

„Jeder Graph, für dessen Knotenfärbung man mindestens zwei Farben benötigt, ist bipartit."

- Aufpassen hier steht nicht genau 2. Mindestens zwei Farben benötigt heißt nur: Der Graph hat überhaupt eine Kante. Dein $k_3$ (Dreieck) braucht **3 Farben** und 3 ist auch mindestens 2.
