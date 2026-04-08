import { FullSlug, resolveRelative } from "../util/path"
import { classNames } from "../util/lang"
import { QuartzComponent, QuartzComponentConstructor, QuartzComponentProps } from "./types"
import style from "./styles/homeSections.scss"

const sections = [
  {
    title: "Thoughts",
    href: "thoughts" as FullSlug,
    description: "Personal reflections, questions, and unfinished ideas.",
  },
  {
    title: "Maths",
    href: "maths" as FullSlug,
    description: "Definitions and notes from the parts of mathematics I am learning.",
  },
]

const HomeSections: QuartzComponent = ({ fileData, displayClass }: QuartzComponentProps) => {
  return (
    <section class={classNames(displayClass, "home-sections")}>
      <h2>Start Here</h2>
      <div class="home-section-grid">
        {sections.map((section) => (
          <a
            key={section.href}
            class="home-section-card internal"
            href={resolveRelative(fileData.slug!, section.href)}
          >
            <h3>{section.title}</h3>
            <p>{section.description}</p>
          </a>
        ))}
      </div>
    </section>
  )
}

HomeSections.css = style

export default (() => HomeSections) satisfies QuartzComponentConstructor
