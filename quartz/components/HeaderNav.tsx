import { QuartzComponent, QuartzComponentConstructor, QuartzComponentProps } from "./types"

interface Options {
  links: Record<string, string>
}

export default ((opts?: Options) => {
  const HeaderNav: QuartzComponent = ({ displayClass }: QuartzComponentProps) => {
    const links = opts?.links ?? {}
    return (
      <nav class={`header-nav ${displayClass ?? ""}`}>
        <ul>
          {Object.entries(links).map(([text, href]) => (
            <li>
              <a href={href}>{text}</a>
            </li>
          ))}
        </ul>
      </nav>
    )
  }

  HeaderNav.css = `
    .header-nav {
      margin: 0;
      padding: 0;
    }

    .header-nav ul {
      list-style: none;
      padding: 0;
      margin: 0;
      display: flex;
      gap: 1.5rem;
    }

    .header-nav a {
      color: var(--darkgray);
      font-size: 0.9rem;
      font-weight: 400;
      text-decoration: none;
      letter-spacing: 0.01em;
      transition: color 0.2s ease;
    }

    .header-nav a:hover {
      color: var(--dark);
    }
  `

  return HeaderNav
}) satisfies QuartzComponentConstructor
