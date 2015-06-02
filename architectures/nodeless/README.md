# Sample NodeLess + Site module Puppet setup

## Structure

- site.pp:
 - Sets identifying variables as top scope, according to hostname or other facts
 - Just includes the site class
 - No nodes declarations

- Module site:
 - Provides local files and templates
 - Manages classes grouping logic (here a general + role classes)
 - Uses a stack::logstash class for logs management

- Hiera:
 - Used for data.

- ENC is not used.

