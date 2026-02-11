import { QuartzComponent, QuartzComponentConstructor, QuartzComponentProps } from "./types"
import GraphComponent from "./Graph"

export default (() => {
  const GraphInner = GraphComponent()

  const MobileGraph: QuartzComponent = (props: QuartzComponentProps) => {
    return (
      <div class="mobile-graph">
        <GraphInner {...props} />
      </div>
    )
  }

  MobileGraph.css = GraphInner.css
  MobileGraph.afterDOMLoaded = GraphInner.afterDOMLoaded
  MobileGraph.beforeDOMLoaded = GraphInner.beforeDOMLoaded

  return MobileGraph
}) satisfies QuartzComponentConstructor
