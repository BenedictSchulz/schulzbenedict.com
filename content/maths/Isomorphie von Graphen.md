---
created: 2026-03-26
modified: 2026-03-26
published: 2026-04-01
---

#graphentheorie

## Definition

Zwei Graphen $G_{1} = (V_{1}, E_{1})$ und $G_{2} = (V_{2}, E_{2})$ heißen **isomorph**, wenn es eine eineindeutige (bijektive) Abbildung $\phi$ von $V_{1}$ nach $V_2$ gibt, so dass für alle $(x, y) \in E_{1}$ gilt: $(\phi(x), \phi(y)) \in E_{2}$

Einfacher gesagt: Zwei Graphen sind isomorph, wenn sie **die gleiche Struktur** haben – sie sehen vielleicht anders gezeichnet aus, aber man kann die Knoten so umbenennen, dass die Kanten übereinstimmen.

## Wie prüft man Isomorphie in der Klausur?

**Schritt 1 – Notwendige Bedingungen prüfen:**

- $|V_1| = |V_2|$ (gleiche Knotenanzahl)
- $|E_1| = |E_2|$ (gleiche Kantenanzahl)
- Gradfolgen stimmen überein
- Gleiche chromatische Zahl $\chi$
- Beide planar oder beide nicht planar

> Wenn eine Bedingung verletzt ist $\Rightarrow$ **nicht isomorph**, fertig.

**Schritt 2 – Abbildung $\varphi$ konstruieren:**

- Knoten nach Grad zuordnen (gleicher Grad $\to$ mögliche Partner)
- Knoten mit eindeutigem Grad zuerst zuordnen

**Schritt 3 – Probe (alle Kanten prüfen):**

- Für jede Kante $(x, y) \in E_1$ prüfen: $(\varphi(x), \varphi(y)) \in E_2$?

---

### Beispiel

**Gegeben:**

$$
G_1 = (\{A, B, C\},\ \{(A,B),\ (B,C)\})
$$

$$
G_2 = (\{1, 2, 3\},\ \{(1,3),\ (2,3)\})
$$

**Schritt 1 – Notwendige Bedingungen:**

- $|V_1| = |V_2| = 3$ ✓
- $|E_1| = |E_2| = 2$ ✓
- Gradfolge $G_1$: $(1, 1, 2)$, Gradfolge $G_2$: $(1, 1, 2)$ ✓

**Schritt 2 – Abbildung $\varphi$:**

| Knoten | Grad | $\varphi$ | Knoten | Grad |
| ------ | ---- | --------- | ------ | ---- |
| $A$    | $1$  | $\to$     | $1$    | $1$  |
| $B$    | $2$  | $\to$     | $3$    | $2$  |
| $C$    | $1$  | $\to$     | $2$    | $1$  |

$B$ ist der einzige Knoten mit Grad 2 in $G_1$, und $3$ ist der einzige mit Grad 2 in $G_2$, also $\varphi(B) = 3$.

**Schritt 3 – Probe:**

$$
\begin{aligned}
(A, B) \in E_1 &\Rightarrow (\varphi(A), \varphi(B)) = (1, 3) \in E_2 \checkmark \\
(B, C) \in E_1 &\Rightarrow (\varphi(B), \varphi(C)) = (3, 2) \in E_2 \checkmark
\end{aligned}
$$

**Ergebnis:** $G_1$ und $G_2$ sind isomorph mit $\varphi(A) = 1,\ \varphi(B) = 3,\ \varphi(C) = 2$.
