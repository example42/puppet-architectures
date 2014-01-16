= Sample NodeLess + Site module Puppet setup

Structure:
- site.pp:
-- Sets identifying variables as top scope, according to hostname or other facts
-- Just includes the site class
-- No nodes declarations

- Module site:
-- Provides local files and templates
-- Manages classes grouping logic (here a general + role classes)
-- Defines infrastructure variables in site::settings according to top scope vars and site logic
-- Uses explicit class declarations with parameters style

- Hiera is not used.
- ENC is not used.

