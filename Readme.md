# SWAPI (Star Wars API) PowerShell Module

## Overview

A PowerShell module to interface with the Star Wars API (SWAPI).

Tested on.

| OS | PowerShell Version |
| --- | --- | 
| Arch <span style="color:cyan">󰣇 </span>Linux 🐧 | 7.3.5 | 

## Current Known Issues

- Lack of [RFC 5988](https://datatracker.ietf.org/doc/html/rfc5988) support
  * It doesn't seem to be implmented in a way that lets `Invoke-RestMethod`'s `-FollowRelLink` to work.
  * This creates a need to implement a work around for pagination, the API return is quite slow.
  * Workaround, try to use parameters to filter the request instead of doing a get-all on the endpoint.

## To-Do

- [ ] Implement help for functions
- [ ] Implement 'wookiee' mode formatting


