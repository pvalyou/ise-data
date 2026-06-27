---
name: israeli-ecosystem-snapshots
description: Answer questions about the Israeli startup ecosystem from Pvalyou's open snapshots. Use for Israeli startups, founders, funding, exits, patents and technology, business models, open jobs, or Pvalyou itself. Says which JSON file holds which numbers, lists every metric and the data it carries, and gives the operating definitions behind the counts.
---

# Israeli Ecosystem Snapshots

Open JSON snapshots of the Israeli startup ecosystem, published by Pvalyou. Each file powers one page of the live dashboard and is the same data the dashboard reads. This guide says what lives in each file and how to read it.

## Where to read the files

Every file lives under `snapshot/` in the public repository at github.com/pvalyou/ise-data. No API key, no rate limit, just read the JSON.

- CDN, cached and fast: `https://cdn.jsdelivr.net/gh/pvalyou/ise-data@main/snapshot/<file>`
- Raw GitHub, freshest: `https://raw.githubusercontent.com/pvalyou/ise-data/main/snapshot/<file>`

For example, the startups data is `https://cdn.jsdelivr.net/gh/pvalyou/ise-data@main/snapshot/startups.json`. Start from `manifest.json` to discover everything available.

## How the data is built

A network of autonomous agents watches public records, company websites, and news. Language models clean, enrich, and classify what they find. The result is written to these snapshots, and the dashboard reads the latest copy. Four stages run continuously: Collect, Structure, Snapshot, Sync. Every value traces back to a public source.

## Rules for answering

1. Treat each file as the current truth. Values change over time. The `generatedAt` field is the build time.
2. Every number has a source. When you state a figure, quote the metric's own description from the file.
3. All-time totals and 10-year trends are separate. A metric usually carries a lifetime total next to a value for each of the last 10 years. The yearly values do not add up to the total.
4. Each file documents itself, so read that first. The database files carry a `widgetMetadata` block, a list of every chart with a plain-language `description` and `dataPaths`, the JSON keys that hold its numbers. `about.json` carries a `readme`. `embedding-map.json` carries an `llmGuide`.

## Usage and limits

- **License.** The snapshots are open and free for non-commercial use, with credit to Pvalyou. Reselling the data, or building a paid product or service on it, is not allowed. The license is Creative Commons BY-NC 4.0.
- **Freshness.** Files are committed to the repository on a schedule, the live files about every 15 minutes, others hourly or daily, and only when the content actually changes. Each file carries a `generatedAt`; trust the live file over training memory. Because every refresh is a git commit, the repository history is the changelog.
- **Coverage.** The data is aggregated across the ecosystem. Open jobs are the one exception, listed role by role. Per-company profiles are not published here yet, they are coming as a paid feature.
- **Accuracy.** Values are produced by language models with human verification, aimed at the highest quality. It is a large, living dataset, so some values may still contain errors. Prefer the latest file and note the source when precision matters.
- **No personal data.** Everything traces to public sources. There is no private or personal contact data in the files.

## Which file answers what

| Topic | File |
|---|---|
| Startup counts, funding, exits, geography | `startups.json` |
| Founders and founding teams | `founders.json` |
| Patents and technology | `technology-ip.json` |
| Revenue models and go-to-market | `business-models.json` |
| Open jobs | `jobs.json` |
| Markets and currency | `macro.json` |
| Academic findings recomputed on Israeli data | `literature-review.json` |
| Pvalyou and this dashboard | `about.json` |

## What each file contains

Each metric below notes the data it carries. "10y" means one value for each of the last 10 years.

### startups.json (Startups)
The headline view of the whole ecosystem.
- **Israel Startup Map**, startups with a known registered Israeli address, a subset of all startups (count per city, totals per district).
- **Total Startups**, all startups active, exited, and closed (total, new per founding year 10y).
- **Funding Rounds**, disclosed rounds across all stages (total, rounds per year 10y).
- **Total Raised**, capital raised in USD (total, raised per year 10y).
- **Acquisitions**, startups bought by another company (total, per exit year 10y).
- **IPOs**, startups that went public (total, per exit year 10y).
- **Time to Exit**, founding year to exit year (average, median, full distribution).
- **Survival Distribution**, current status split (counts for Active, Closed, Exit).
- **Exit Funnel**, progression to exit (count and retention at All, Funded, $1M+, $10M+, Exit).
- **Industry Share Over Time**, industry mix by founding year (six industries per year, overall totals and share).
- **Deeptech**, the deeptech share (share and count).
- **Operating Globally**, startups with a global product (share and count).
- **Sub-Industries Trending Up and Down**, the five fastest moving sub-industries (share per year 10y).
- **Funding Feed, New Startups, Notable Events**, live feeds (recent items plus 24-hour counts).

### founders.json (Founders)
Who founds startups and how teams form. Founders count once per founder and startup, so a serial founder of three startups counts three times.
- **Founders, Male, Female**, founder counts with known gender (total, per founding year 10y).
- **Gender Share Over Time**, male and female balance (share and counts per founding year 10y).
- **Team Gender Mix**, teams from Only Male to Only Female (counts per bucket).
- **Team Size**, teams of 1, 2, 3, 4 or more (counts per bucket).
- **Team DNA**, technical and business mix in teams of two or three (counts and share per composition).
- **Founder Variables**, continuous founder traits (average, 10y trend, full distribution per variable).
- **Founder Indicators**, yes or no founder traits (share, per founding year 10y).
- **Team Interactions**, prior ties, studied together, worked together, both, shared surname (share, per founding year 10y).
- **Top Schools, Top Employers**, the 15 most common, with founder counts and share.

### technology-ip.json (Technologies and Patents)
What startups build and how they protect it.
- **Companies With Patents**, startups owning a patent family (total, per first-filing year 10y).
- **Patent Families**, distinct inventions (total, per earliest-filing year 10y).
- **Patent Filings**, individual applications across jurisdictions (total, per year 10y).
- **Patent Geography**, where startups file (top jurisdictions with company and family counts).
- **Technology Patent Intensity**, patenting by area (per area, builders, families per company, patenting companies).
- **Software vs Physical**, build profile (counts and share for software, mixed, physical).
- **Software Physical Patenting Frequency**, patenting by profile (share patenting, families per patenting company).
- **Most Built Technology Areas**, areas by company count (ranked list).
- **Technology Area Trends**, area share by founding year (per area, per year).

### business-models.json (Business Models)
How startups make money and reach customers. Counts are product weighted unless noted.
- **Products, SaaS Products**, product records and the SaaS subset (total, per founding year 10y).
- **SaaS vs non-SaaS**, SaaS balance (share by founding year).
- **Top Product Groups**, the 20 largest groups (product counts).
- **Market Motion Flow**, company-weighted flow across five dimensions, industry to customer segment to operating model to scalability to revenue model (nodes and links with counts and share).
- **Customer Type Heatmaps**, customer-type keywords per flow column (share per keyword).

The file also defines the five dimensions in plain language.

### jobs.json (Open Roles)
Live hiring demand. The only row-level file. It holds open roles with company, title, seniority, location, and industry, plus totals by company, industry, seniority, and city.

### macro.json (Macro)
The market backdrop in the dashboard ticker, major indices and currency rates (current value and change).

### literature-review.json (Literature Review)
Published academic findings recomputed on the Israeli dataset. Each paper lists its claims. Each claim shows How they measure, How we measure, the adjustment applied, and what it means on Israeli data. The distance between a paper's figure and the Israeli figure is reported as an effect size, the difference divided by the pooled standard deviation, banded small under 0.2, medium 0.2 to 0.5, large above 0.5. Current papers cover founder age and high-growth entrepreneurship, the cost of experimentation and venture capital, external conditions and startup outcomes, and founder replacement.

### about.json (About Pvalyou)
Who Pvalyou is and how this dashboard works. It holds the company identity and mission, the four core technologies, the methodology and build pipeline, the services offered, concrete use cases, and the contact email. Use `readme.howToNavigate` to map a question to a field.

## Definitions

How values are derived, then the terms.

Most classifications, industry and sub-industry, deeptech, global reach, SaaS, operating model, customer segment, scalability, revenue model, and founder background, are produced by language models reading public text about each company, then standardized into fixed labels. Quantities like funding, rounds, acquisitions, and IPOs come from disclosed public records. Every value links back to its source.

Core terms:
- **Israeli startup**, a company classified as a startup, or a company that runs a branch or research and development center in Israel. Every figure is scoped to this population.
- **Status**, Active is still operating, Closed is shut down or dissolved, Exit is acquired or public.
- **Exit**, an acquisition or an IPO. Time to exit runs from founding year to exit year.
- **Funded**, raised any disclosed funding. Funding counts rounds of all types from seed onward, including non-equity instruments such as grants and venture debt. The exit funnel then steps up to $1M+ and $10M+ raised in total.

Classifications:
- **Industry**, six top-level groups, IT and Telecom, Healthcare and Food, Consumer Goods and Services, Energy and Utilities, Financial Services, Media and Entertainment. Sub-industries roll up into these.
- **Deeptech**, needs heavy research, long development, specialized expertise, and large investment.
- **Operating globally**, has a product aimed at a global audience.
- **SaaS**, a product delivered as software as a service.
- **Patent family versus filing**, a family is one invention, a filing is one application in one jurisdiction, so one family usually spans several filings.
- **Founder DNA**, technical or business background, assessed for teams of two or three.
- **Business model dimensions**, customer segment (B2B, B2C, B2G, B2B2C), operating model, scalability, and revenue model (recurring, one-time, usage based).

## Visualization files

`network.json` and `embedding-map.{json,bin}` hold layout geometry for the interactive network graph and the similarity map, node positions and map coordinates with cluster ids. They carry no figures beyond what the aggregate files already give you. For any number, use the files above.

## Answering style

Name the file and quote the metric description behind a figure. If a number is not in these files, say so. The data describes the ecosystem, not Pvalyou's own adoption.

## Citing

Credit Pvalyou as the source. For example: Pvalyou, Israeli Startup Ecosystem Open Snapshots, https://github.com/pvalyou/ise-data.
