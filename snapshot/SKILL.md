---
name: israeli-ecosystem-snapshots
description: Answer questions about the Israeli startup ecosystem from Pvalyou's open snapshots. Use for Israeli startups, founders, funding, exits, patents and technology, business models, open jobs, or Pvalyou itself. Says which JSON file holds which numbers, lists every metric and the data it carries, and gives the operating definitions behind the counts.
---

# Israeli Ecosystem Snapshots

Open JSON snapshots of the Israeli startup ecosystem, published by Pvalyou. Each file powers one page of the live dashboard and is the same data the dashboard reads. This guide says what lives in each file and how to read it.

## How the data is built

A network of autonomous agents watches public records, company websites, and news. Language models clean, enrich, and classify what they find. The result is written to these snapshots, and the dashboard reads the latest copy. Four stages run continuously: Collect, Structure, Snapshot, Sync. Every value traces back to a public source.

## Rules for answering

1. Treat each file as the current truth. Values change over time. The `generatedAt` field is the build time.
2. Every number has a source. When you state a figure, quote the metric's own description from the file.
3. All-time totals and 10-year trends are separate. A metric usually carries a lifetime total next to a value for each of the last 10 years. The yearly values do not add up to the total.
4. Each file documents itself, so read that first. The database files carry a `widgetMetadata` block, a list of every chart with a plain-language `description` and `dataPaths`, the JSON keys that hold its numbers. `about.json` carries a `readme`. `embedding-map.json` carries an `llmGuide`.

## Usage and limits

- **License.** The snapshots are open and free for non-commercial use, with credit to Pvalyou. Reselling the data, or building a paid product or service on it, is not allowed. The license is Creative Commons BY-NC 4.0.
- **Freshness.** A new snapshot is published every five to ten minutes. Most data points are refreshed daily or weekly. Read the live file and trust its `generatedAt` over training memory.
- **Coverage.** The data is aggregated across the ecosystem. Two files are row-level: open jobs, listed role by role, and unicorns, one row per billion-dollar company. Per-company profiles for the wider population are not published here yet, they are coming as a paid feature.
- **Accuracy.** Values are produced by language models with human verification, aimed at the highest quality. It is a large, living dataset, so some values may still contain errors. Prefer the latest file and note the source when precision matters.
- **No personal data.** Everything traces to public sources. There is no private or personal contact data in the files.

## Which file answers what

| Topic | File |
|---|---|
| Startup counts, funding, exits, geography | `startups.json` |
| Billion-dollar companies, one row each | `unicorns.json` |
| Founders and founding teams | `founders.json` |
| Angel investors and who backs early rounds | `angels.json` |
| Patents and technology | `technology-ip.json` |
| Revenue models and go-to-market | `business-models.json` |
| Open jobs | `jobs.json` |
| Markets and currency | `macro.json` |
| Academic findings recomputed on Israeli data | `literature-review.json` |
| Who is connected to whom, and IIA grant recipients | `network.json` |
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

### unicorns.json (Unicorns)
Israeli companies that reached a one billion dollar valuation. One row per company, not an aggregate, so this file answers company-level questions the other files cannot.

Each row carries the company (name, domain, logo, industry and sub-industry), when it started (founding year and date), how it got there (`unicornDate`, `yearsToUnicorn`, `valuationUsd`), the money (`raisedToUnicornUsd` before the milestone, `totalFundingUsd` all time), and where it stands now (`status`, `exitDate` where there was one).

Two fields carry the definitions:
- **`mechanism`**, how the billion was reached: `round` (a private funding round at that valuation), `acquisition` (bought for it), or `ipo` (public market valued it there). A company can reach the mark without ever raising at it.
- **`cohort`**, `hq-israel` for companies headquartered in Israel, `israeli-abroad` for Israeli-founded companies headquartered elsewhere. `hqCountry` gives the actual country. Both cohorts are in the total.

`status` is `private`, `public`, `acquired` or `inactive`, and is current, not the status at the time the company became a unicorn.

### founders.json (Founders)
Who founds startups and how teams form. Founders count once per founder and startup, so a serial founder of three startups counts three times.
- **Founders, Male, Female**, founder counts with known gender (total, per founding year 10y).
- **Gender Share Over Time**, male and female balance (share and counts per founding year 10y).
- **Team Gender Mix**, teams from Only Male to Only Female (counts per bucket).
- **Team Size**, teams of 1, 2, 3, 4 or more (counts per bucket).
- **Team DNA**, technical and non-technical mix in teams of two or three, counted only where every founder has a known DNA (counts and share per composition).
- **Founder Variables**, continuous founder traits (average, 10y trend, full distribution per variable).
- **Founder Indicators**, yes or no founder traits (share, per founding year 10y).
- **Team Interactions**, prior ties, studied together, worked together, both, shared surname (share, per founding year 10y).
- **Top Schools, Top Employers**, the 15 most common, with founder counts and share.

### angels.json (Angels)
Individual people who invested in Israeli startups, and how many of them are former founders recycling an exit. Counts are per angel and company, so backing three companies counts three times, and follow-on rounds into the same company still count as one investment.

This file covers identified angels only. Investor names arrive as raw strings and roughly half of the individual ones resolve to a real person, so every count is a floor rather than a census of Israeli angel activity. An investment is an equity round the person joined, money into the company for new shares.
- **Angels, Investments, Companies Backed**, the headline totals with 10 year trends, plus the startup population as the coverage denominator.
- **Age at First Check**, how old angels were on their first investment (percentiles, five-year bins on the founders 15-85 scale, and a 10 year trend of the average). Reconstructed from age when founded against founding year, so it only covers angels who are also founders.
- **Startup Experience**, every angel in one of three founder tiers, never founded, founded without an exit, founded and exited (angels, investments and mean portfolio per tier, plus how many were already investing before their exit), with the technical share alongside.
- **Exit to First Check**, years from a founder exit to the first investment, over angels who had an exit (one-year bins to 15+ and the median).
- **Most Active Angels**, the largest portfolios with companies founded and backed (portfolio and round counts, active years, founder exit flag).
- **Investments per Angel**, how concentrated the activity is (angels and share of investments per bucket).
- **Where Angels Enter**, the round stage they participate in, in ladder order (rounds and angels per stage, including an Other bucket for instruments such as SAFEs that the chart leaves off).
- **Where Angels Invest**, backed companies by subindustry (investments, angels, companies, median raised and exited count per subindustry).
- **Angel DNA**, Business, Technical or Product, the same classification used for founders (counts per class).
- **Where Angels Are Based**, an Israel, United States, rest-of-world split with per-group investments, companies and mean investments per angel, plus full per-country counts; angels with no recorded country are reported separately.
- **Where Angels Worked and Studied**, the companies they held a job at and the schools they attended, most common first (angels per employer and school).
- **Gender**, the split over angels with a known value (counts).
- **By Year**, investments, active angels, first-time angels and newly backed companies per year.

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
Live hiring demand, row-level like `unicorns.json`. It holds open roles with company, title, seniority, location, and industry, plus totals by company, industry, seniority, and city.

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
- **Israeli startup**, a company whose type is startup and which is operationally Israeli, either headquartered in Israel or registered as an Israeli legal entity after a flip abroad. Every figure is scoped to this population.
- **Status**, Active is still operating, Closed is shut down or dissolved, Exit is acquired or public.
- **Exit**, a completed acquisition or a completed public listing. Time to exit runs from founding year to exit year.
- **Equity round**, money paid into the company for newly issued shares, from pre-seed through late stage, including SAFEs and convertibles. Every funding figure counts these.
- **Funded**, raised at least one equity round. The exit funnel then steps up to $1M+ and $10M+ raised in total.
- **Angel**, an individual who joined an equity round in an Israeli startup, counted once per angel and company.
- **Unicorn**, a company that reached a one billion dollar valuation, whether by a funding round, an acquisition or a public listing.

Classifications:
- **Industry**, six top-level groups, IT and Telecom, Healthcare and Food, Consumer Goods and Services, Energy and Utilities, Financial Services, Media and Entertainment. Sub-industries roll up into these.
- **Deeptech**, needs heavy research, long development, specialized expertise, and large investment.
- **Operating globally**, has a product aimed at a global audience.
- **SaaS**, a product delivered as software as a service.
- **Patent family versus filing**, a family is one invention, a filing is one application in one jurisdiction, so one family usually spans several filings.
- **Founder DNA**, technical or non-technical background, assessed for teams of two or three. Technical is the tagged class, and non-technical is everyone else.
- **Business model dimensions**, customer segment (B2B, B2C, B2G, B2B2C), operating model, scalability, and revenue model (recurring, one-time, usage based).

## Visualization files

`network.json` and `embedding-map.{json,bin}` hold layout geometry, node positions for the interactive network graph and map coordinates with cluster ids for the similarity map.

The network graph draws five kinds of node: startups, their founders, the schools those founders attended, the companies they held a job at, and the angels who hold shares. One further node is the Israel Innovation Authority, joined to every company that won an approved grant. Schools and employers carry an `alumni` count, the agency a `funded` count, and each company the number of angels behind it. `counts` gives the totals for each kind.

For ecosystem figures, use the aggregate files above. The graph is scoped to Israeli startups that have a founder on record, so its startup total sits below the one in `startups.json`.

## Answering style

Name the file and quote the metric description behind a figure. If a number is not in these files, say so. The data describes the ecosystem, not Pvalyou's own adoption.

## Citing

Credit Pvalyou as the source. For example: Pvalyou, Israeli Startup Ecosystem Open Snapshots, https://pvalyou.com.
