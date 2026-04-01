---
created: 2026-04-01
modified: 2026-04-01
published: 2026-04-01
---

### Linearkombination
Seien $v_1, \ldots, v_n \in V$ Vektoren und $\lambda_1, \ldots, \lambda_n \in \mathbb{R}$ Skalare. Dann heißt
$$\lambda_1 v_1 + \lambda_2 v_2 + \cdots + \lambda_n v_n$$
eine **Linearkombination** der Vektoren $v_1, \ldots, v_n$.

### Spann (Lineare Hülle)
Die Menge **aller** möglichen Linearkombinationen von $v_1, \ldots, v_n$ heißt Spann:
$$\text{span}\{v_1, \ldots, v_n\} = \left\{ \sum_{j=1}^n \lambda_j v_j \ \middle|\ \lambda_1, \ldots, \lambda_n \in \mathbb{R} \right\}$$

> Der Spann ist immer ein **Unterraum** von $V$.

**Beispiel:**
$$\text{span}\left\{ \begin{pmatrix} 1 \\ 0 \end{pmatrix}, \begin{pmatrix} 0 \\ 1 \end{pmatrix} \right\} = \mathbb{R}^2 \qquad \text{(ganzer Raum)}$$
$$\text{span}\left\{ \begin{pmatrix} 1 \\ 0 \\ 0 \end{pmatrix}, \begin{pmatrix} 0 \\ 1 \\ 0 \end{pmatrix} \right\} = \left\{ \begin{pmatrix} \lambda_1 \\ \lambda_2 \\ 0 \end{pmatrix} \middle| \lambda_1, \lambda_2 \in \mathbb{R} \right\} \subsetneq \mathbb{R}^3 \qquad \text{(nur die } x_1\text{-}x_2\text{-Ebene)}$$

### Lineare Unabhängigkeit
Die Vektoren $v_1, \ldots, v_n$ heißen **linear unabhängig**, wenn gilt:
$$\lambda_1 v_1 + \lambda_2 v_2 + \cdots + \lambda_n v_n = \vec{0} \quad \Rightarrow \quad \lambda_1 = \lambda_2 = \cdots = \lambda_n = 0$$

> **Intuition:** Keiner der Vektoren lässt sich als Linearkombination der anderen schreiben.

**Linear abhängig** heißt: Mindestens ein Vektor ist aus den anderen erzeugbar.

**Beispiel abhängig:**
$$v_1 = \begin{pmatrix} 1 \\ 0 \\ 0 \end{pmatrix},\ v_2 = \begin{pmatrix} 0 \\ 1 \\ 0 \end{pmatrix},\ v_3 = \begin{pmatrix} 2 \\ 3 \\ 0 \end{pmatrix} \quad \text{abhängig, weil } v_3 = 2v_1 + 3v_2$$

**Beispiel unabhängig:**
$$e_1 = \begin{pmatrix} 1 \\ 0 \end{pmatrix},\ e_2 = \begin{pmatrix} 0 \\ 1 \end{pmatrix} \quad \text{unabhängig, keiner ist Vielfaches des anderen}$$

### Basis
Eine **Basis** von $V$ ist eine Menge $\{v_1, \ldots, v_m\}$, die zwei Bedingungen erfüllt:
1. $v_1, \ldots, v_m$ sind **linear unabhängig**
2. $\text{span}\{v_1, \ldots, v_m\} = V$ (sie spannen den ganzen Raum auf)

> Jeder Vektor $w \in V$ lässt sich dann **eindeutig** als Linearkombination darstellen:
> $$w = \lambda_1 v_1 + \cdots + \lambda_m v_m$$
> Die Koeffizienten $\lambda_1, \ldots, \lambda_m$ heißen **Koordinaten** von $w$ bzgl. der Basis.

### Dimension
$$\dim V = \text{Anzahl der Basisvektoren}$$

- $\dim \mathbb{R}^n = n$
- Standardbasis des $\mathbb{R}^3$: $\left\{ \begin{pmatrix} 1 \\ 0 \\ 0 \end{pmatrix}, \begin{pmatrix} 0 \\ 1 \\ 0 \end{pmatrix}, \begin{pmatrix} 0 \\ 0 \\ 1 \end{pmatrix} \right\}$

### Wichtige Zusammenhänge
Für Vektoren im $\mathbb{R}^n$ gilt:
- **Weniger als $n$** linear unabhängige Vektoren $\Rightarrow$ spannen **nicht** den ganzen $\mathbb{R}^n$ auf
- **Genau $n$** linear unabhängige Vektoren $\Rightarrow$ **Basis** des $\mathbb{R}^n$
- **Mehr als $n$** Vektoren $\Rightarrow$ **müssen** linear abhängig sein

> Jede linear unabhängige Menge kann durch Hinzufügen von Vektoren zu einer Basis ergänzt werden. Umgekehrt kann aus jeder Menge, die $V$ aufspannt, durch Weglassen eine Basis gewonnen werden.