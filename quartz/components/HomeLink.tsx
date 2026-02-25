import { pathToRoot } from "../util/path"
import { QuartzComponent, QuartzComponentConstructor, QuartzComponentProps } from "./types"
import { classNames } from "../util/lang"

const HomeLink: QuartzComponent = ({ fileData, displayClass }: QuartzComponentProps) => {
  const baseDir = pathToRoot(fileData.slug!)
  return (
    <a href={baseDir} class={classNames(displayClass, "home-link")} aria-label="Home">
      <svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 24 24">
        <path d="M3 10.5L12 3l9 7.5V20a1 1 0 0 1-1 1h-5v-6H9v6H4a1 1 0 0 1-1-1z" />
      </svg>
    </a>
  )
}

HomeLink.css = `
.home-link {
  display: flex;
  align-items: center;
  margin-right: auto;
  text-decoration: none !important;
}

.home-link svg {
  width: 18px;
  height: 18px;
  fill: none;
  stroke: var(--darkgray);
  stroke-width: 2;
  stroke-linecap: round;
  stroke-linejoin: round;
  transition: stroke 0.2s ease;
}

.home-link:hover svg {
  stroke: var(--secondary);
}
`

export default (() => HomeLink) satisfies QuartzComponentConstructor
