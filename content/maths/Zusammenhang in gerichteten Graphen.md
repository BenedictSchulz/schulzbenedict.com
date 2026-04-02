---
created: 2026-02-13
modified: 2026-02-13
published: 2026-04-01
---

#graphentheorie

> Die Begriffe **stark** und **schwach zusammenhängend** existieren nur für **gerichtete Graphen** (Digraphen).  
> Bei ungerichteten Graphen spricht man einfach von _zusammenhängend_ oder _nicht zusammenhängend_.

---

## Stark zusammenhängend

### Definition

Ein [[gerichteter Graph]] $G = (V, E)$ heißt **stark zusammenhängend**, wenn es für **jedes** geordnete Knotenpaar $(u, v)$ mit $u, v \in V$ sowohl

- einen gerichteten Pfad von $u$ nach $v$, **als auch**
- einen gerichteten Pfad von $v$ nach $u$

gibt. Die **Richtung der Kanten wird beachtet**.

### Beispiel

$$
G = (V, E)
$$

$$
V = {A, B, C, D}
$$

$$
E = {(A, B),; (B, D),; (D, C),; (C, A)}
$$

```
A → B
↑   ↓
C ← D
```

**Erklärung:** Man kann den Zyklus $A \to B \to D \to C \to A$ ablaufen und erreicht so von **jedem** Knoten **jeden** anderen entlang der Pfeilrichtungen.

---

## Schwach zusammenhängend

### Definition

Ein [[gerichteter Graph]] $G = (V, E)$ heißt **schwach zusammenhängend**, wenn der **zugrunde liegende ungerichtete Graph** $G'$ zusammenhängend ist.

Das bedeutet: Ersetzt man jede gerichtete Kante $(u, v) \in E$ durch eine ungerichtete Kante ${u, v}$, so ist der resultierende Graph $G'$ zusammenhängend.

> **Achtung:** Mit Richtungen muss man **nicht** zwingend von jedem Knoten zu jedem anderen kommen!

### Beispiel

$$
G = (V, E)
$$

$$
V = {A, B, C, D}
$$

$$
E = {(A, B),; (B, C),; (C, D)}
$$

```
A → B → C → D
```

**Erklärung:** Ignoriert man die Richtungen, ist der Graph zusammenhängend ($A - B - C - D$). Aber es gibt z. B. **keinen** gerichteten Pfad von $D$ nach $A$. Daher: schwach zusammenhängend, aber **nicht** stark zusammenhängend.

---

## Zusammenfassung

| Eigenschaft                 | Richtung beachten? | Bedingung                                                                                      |
| --------------------------- | ------------------ | ---------------------------------------------------------------------------------------------- |
| **Stark zusammenhängend**   | Ja                 | $\forall; u, v \in V$: es existiert ein gerichteter Pfad $u \leadsto v$ **und** $v \leadsto u$ |
| **Schwach zusammenhängend** | Nein               | Der zugrunde liegende ungerichtete Graph ist zusammenhängend                                   |

$$
\text{stark zusammenhängend} \implies \text{schwach zusammenhängend}
$$

Die Umkehrung gilt **nicht**.
