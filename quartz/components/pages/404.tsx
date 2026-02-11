import { QuartzComponent, QuartzComponentConstructor, QuartzComponentProps } from "../types"

const NotFound: QuartzComponent = ({ cfg }: QuartzComponentProps) => {
  const url = new URL(`https://${cfg.baseUrl ?? "example.com"}`)
  const baseDir = url.pathname

  return (
    <article class="popover-hint not-found">
      <p class="not-found-code">404</p>
      <p class="not-found-message">This page doesn't exist yet.</p>
      <a href={baseDir}>Back to notes</a>
    </article>
  )
}

NotFound.css = `
  .not-found {
    text-align: center;
    padding: 4rem 0;
  }

  .not-found-code {
    font-family: "Source Sans 3", var(--headerFont), sans-serif;
    font-size: 4rem;
    font-weight: 600;
    color: var(--darkgray);
    margin: 0;
    letter-spacing: -0.02em;
  }

  .not-found-message {
    color: var(--gray);
    font-size: 1.1rem;
    margin: 0.5rem 0 2rem;
  }

  .not-found a {
    color: var(--secondary);
    border-bottom: 1px solid var(--highlight);
    transition: border-color 0.3s ease;
  }

  .not-found a:hover {
    border-bottom-color: var(--secondary);
  }
`

export default (() => NotFound) satisfies QuartzComponentConstructor
