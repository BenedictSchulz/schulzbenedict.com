import { QuartzComponent, QuartzComponentConstructor, QuartzComponentProps } from "./types"

const RelatedLabel: QuartzComponent = ({ displayClass }: QuartzComponentProps) => {
  return (
    <div class={`related-label ${displayClass ?? ""}`}>
      <span>Related</span>
    </div>
  )
}

export default (() => RelatedLabel) satisfies QuartzComponentConstructor
