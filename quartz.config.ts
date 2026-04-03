import { QuartzConfig } from "./quartz/cfg"
import * as Plugin from "./quartz/plugins"

/**
 * Quartz 4 Configuration
 *
 * See https://quartz.jzhao.xyz/configuration for more information.
 */
const config: QuartzConfig = {
  configuration: {
    pageTitle: "Benedict Schulz",
    pageTitleSuffix: "",
    enableSPA: true,
    enablePopovers: true,
    analytics: null,
    locale: "en-US",
    baseUrl: "schulzbenedict.com",
    ignorePatterns: ["private", "templates", ".obsidian"],
    defaultDateType: "modified",
    theme: {
      fontOrigin: "googleFonts",
      cdnCaching: true,
      typography: {
        header: "Source Sans 3",
        body: "EB Garamond",
        code: "JetBrains Mono",
      },
      colors: {
        lightMode: {
          light: "#faf8f4",
          lightgray: "#ddd8cf",
          gray: "#8a8479",
          darkgray: "#2a2826",
          dark: "#2a2826",
          secondary: "#907a4a",
          tertiary: "#a08a55",
          highlight: "rgba(144, 122, 74, 0.07)",
          textHighlight: "rgba(144, 122, 74, 0.12)",
        },
        darkMode: {
          light: "#1a1917",
          lightgray: "#2e2d2a",
          gray: "#6b665e",
          darkgray: "#9a948b",
          dark: "#e8e4df",
          secondary: "#bfa77d",
          tertiary: "#cbb48e",
          highlight: "rgba(191, 167, 125, 0.08)",
          textHighlight: "rgba(191, 167, 125, 0.15)",
        },
      },
    },
  },
  plugins: {
    transformers: [
      Plugin.FrontMatter(),
      Plugin.CreatedModifiedDate({
        priority: ["frontmatter", "git", "filesystem"],
      }),
      Plugin.SyntaxHighlighting({
        theme: {
          light: "github-light",
          dark: "github-dark",
        },
        keepBackground: false,
      }),
      Plugin.ObsidianFlavoredMarkdown({ enableInHtmlEmbed: false, disableBrokenWikilinks: true }),
      Plugin.GitHubFlavoredMarkdown(),
      Plugin.TableOfContents(),
      Plugin.CrawlLinks({ markdownLinkResolution: "shortest" }),
      Plugin.Description(),
      Plugin.Latex({ renderEngine: "katex" }),
    ],
    filters: [Plugin.RemoveDrafts()],
    emitters: [
      Plugin.AliasRedirects(),
      Plugin.ComponentResources(),
      Plugin.ContentPage(),
      Plugin.FolderPage(),
      Plugin.TagPage(),
      Plugin.ContentIndex({
        enableSiteMap: true,
        enableRSS: true,
      }),
      Plugin.Assets(),
      Plugin.Static(),
      Plugin.Favicon(),
      Plugin.NotFoundPage(),
      Plugin.CustomOgImages(),
    ],
  },
}

export default config
