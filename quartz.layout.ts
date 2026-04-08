import { PageLayout, SharedLayout } from "./quartz/cfg"
import * as Component from "./quartz/components"

// components shared across all pages
export const sharedPageComponents: SharedLayout = {
  head: Component.Head(),
  header: [
    Component.HomeLink(),
    Component.Search(),
    Component.Darkmode(),
    Component.SidebarToggle(),
  ],
  afterBody: [
    Component.ConditionalRender({
      component: Component.HomeSections(),
      condition: (page) => page.fileData.slug === "index",
    }),
    Component.ConditionalRender({
      component: Component.RecentNotes({
        title: "Recent Notes",
        limit: 6,
        showTags: false,
        filter: (f) => f.slug !== "index" && f.slug !== "impressum" && f.slug !== "datenschutz",
      }),
      condition: (page) => page.fileData.slug === "index",
    }),
    Component.ConditionalRender({
      component: Component.Backlinks({ hideWhenEmpty: true }),
      condition: (page) =>
        page.fileData.slug !== "index" &&
        page.fileData.slug !== "impressum" &&
        page.fileData.slug !== "datenschutz" &&
        page.fileData.slug !== "404",
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
  beforeBody: [Component.ArticleTitle(), Component.ContentMeta(), Component.TagList()],
  left: [],
  right: [
    Component.ConditionalRender({
      component: Component.Graph(),
      condition: (page) => page.fileData.slug !== "index",
    }),
    Component.ConditionalRender({
      component: Component.Explorer({
        title: "Browse",
        folderClickBehavior: "link",
        folderDefaultState: "collapsed",
        filterFn: (node) => node.slugSegment !== "impressum" && node.slugSegment !== "datenschutz",
      }),
      condition: (page) => page.fileData.slug !== "index",
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
      title: "Browse",
      folderClickBehavior: "link",
      folderDefaultState: "collapsed",
      filterFn: (node) => node.slugSegment !== "impressum" && node.slugSegment !== "datenschutz",
    }),
  ],
}
