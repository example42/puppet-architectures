= Sample Nodes Inheritances + Site module Puppet setup

This a sample setup based on nodes inheritance.

== Structure:

- site.pp:
-- Sets identifying variables via nodes inheritance
-- Includes the site class in each node

- Module site:
-- Provides local files and templates
-- Manages classes grouping logic (here a general + role classes)
-- Defines infrastructure variables in site::settings according to top scope vars and site logic
-- Uses explicit class declarations with parameters style

- Hiera is not used.
- ENC is not used.

== Alternatives

- Data moved to Hiera and no class declarations with parameters style in site module
