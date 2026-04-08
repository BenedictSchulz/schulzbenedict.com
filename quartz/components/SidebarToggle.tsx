// @ts-ignore
import sidebarToggleScript from "./scripts/sidebartoggle.inline"
import styles from "./styles/sidebartoggle.scss"
import { QuartzComponent, QuartzComponentConstructor, QuartzComponentProps } from "./types"
import { classNames } from "../util/lang"

const SidebarToggle: QuartzComponent = ({ displayClass }: QuartzComponentProps) => {
  return (
    <button class={classNames(displayClass, "sidebar-toggle")} aria-label="Toggle sidebar">
      <svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 24 24">
        <line x1="3" y1="6" x2="21" y2="6" />
        <line x1="3" y1="12" x2="21" y2="12" />
        <line x1="3" y1="18" x2="21" y2="18" />
      </svg>
    </button>
  )
}

SidebarToggle.afterDOMLoaded = sidebarToggleScript
SidebarToggle.css = styles

export default (() => SidebarToggle) satisfies QuartzComponentConstructor
