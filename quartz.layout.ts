import { PageLayout, SharedLayout } from "./quartz/cfg"
import * as Component from "./quartz/components"

// components shared across all pages
export const sharedPageComponents: SharedLayout = {
  head: Component.Head(),
  header: [
    Component.Search(),
    Component.Darkmode(),
    Component.SidebarToggle(),
  ],
  afterBody: [
    Component.ConditionalRender({
      component: Component.RecentNotes({
        title: "Recent Notes",
        limit: 100,
        showTags: false,
        filter: (f) => f.slug !== "index" && f.slug !== "impressum" && f.slug !== "datenschutz",
      }),
      condition: (page) => page.fileData.slug === "index",
    }),
    Component.ConditionalRender({
      component: Component.RelatedLabel(),
      condition: (page) => page.fileData.slug !== "index" && page.fileData.slug !== "impressum" && page.fileData.slug !== "datenschutz" && page.fileData.slug !== "404",
    }),
    Component.ConditionalRender({
      component: Component.MobileGraph(),
      condition: (page) => page.fileData.slug !== "index" && page.fileData.slug !== "impressum" && page.fileData.slug !== "datenschutz" && page.fileData.slug !== "404",
    }),
    Component.ConditionalRender({
      component: Component.Backlinks(),
      condition: (page) => page.fileData.slug !== "index" && page.fileData.slug !== "impressum" && page.fileData.slug !== "datenschutz" && page.fileData.slug !== "404",
    }),
  ],
  footer: Component.Footer({
    links: {
      Impressum: "/impressum",
      Datenschutz: "/datenschutz",
    },
  }),
}

// components for pages that display a single page (e.g. a single note)
export const defaultContentPageLayout: PageLayout = {
  beforeBody: [
    Component.ArticleTitle(),
    Component.ContentMeta(),
    Component.TagList(),

  ],
  left: [],
  right: [
    Component.Graph(),
    Component.Explorer({
      title: "Folders",
      folderClickBehavior: "link",
      folderDefaultState: "collapsed",
    }),
  ],
}

// components for pages that display lists of pages  (e.g. tags or folders)
export const defaultListPageLayout: PageLayout = {
  beforeBody: [Component.ArticleTitle(), Component.ContentMeta()],
  left: [],
  right: [
    Component.Graph(),
    Component.Explorer({
      title: "Folders",
      folderClickBehavior: "link",
      folderDefaultState: "collapsed",
    }),
  ],
}
