---
created: 2026-04-01
modified: 2026-04-01
published: 2026-04-01
---

#graphentheorie 
[[Adjazenzmatrix]] [[Adjazenzliste]]

### Definition
Die Adjazenzmatrix $A(G) \in \mathbb{R}^{|V| \times |V|}$ eines Graphen $G = (V, E)$ ist:
$$a_{ij} = \begin{cases} 1, & \text{falls } v_i \text{ und } v_j \text{ benachbart sind} \\ 0, & \text{sonst} \end{cases}$$

### Eigenschaften
- Bei **ungerichteten** Graphen ist $A$ immer **symmetrisch**: $A_{ij} = A_{ji}$
- Summe der Einträge in Zeile $i$ = **Grad** von $v_i$
- Diagonale ist 0 (keine Schleifen)

### Potenzen der Adjazenzmatrix
> $(A^k)_{ij}$ = Anzahl der **Kantenzüge der Länge $k$** von Knoten $i$ nach Knoten $j$

- $A^1$ = direkte Verbindungen (Länge 1)
- $A^2$ = Wege über einen Zwischenknoten (Länge 2)
- $A^3$ = Wege über zwei Zwischenknoten (Länge 3)

**Merkregel:** $(A^2)_{ii}$ = Grad von Knoten $i$ (jeder Nachbar ergibt einen Hin-und-Zurück-Weg).

### Beispiel
Graph: $V = \{1, 2, 3, 4\}$, $E = \{(1,2), (1,4), (2,4), (3,4)\}$

$$A(G) = \begin{pmatrix} 0 & 1 & 0 & 1 \\ 1 & 0 & 0 & 1 \\ 0 & 0 & 0 & 1 \\ 1 & 1 & 1 & 0 \end{pmatrix}$$

**Kantenzüge der Länge 2 von Knoten 1:**

$$(A^2)_{\cdot,1} = 1 \cdot \begin{pmatrix} 1 \\ 0 \\ 0 \\ 1 \end{pmatrix} + 1 \cdot \begin{pmatrix} 1 \\ 1 \\ 1 \\ 0 \end{pmatrix} = \begin{pmatrix} 2 \\ 1 \\ 1 \\ 1 \end{pmatrix}$$

Bedeutung: 2 Wege der Länge 2 von 1 nach 1: $(1 \to 2 \to 1)$ und $(1 \to 4 \to 1)$.
Je 1 Weg zu Knoten 2, 3, 4: $(1 \to 4 \to 2)$, $(1 \to 4 \to 3)$, $(1 \to 2 \to 4)$.

### Laplace-Matrix
$$L = D - A$$
wobei $D = \text{diag}(d_1, \ldots, d_n)$ die Diagonalmatrix der Knotengrade ist.


