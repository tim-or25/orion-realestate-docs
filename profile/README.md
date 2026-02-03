# System Settings Section

a “System Settings” section under the Profile page that lets the user:

Enable/Disable Mystic Guide per page

Enable/Disable Mystic Guide globally

Enable/Disable Mystic Voice (text-to-speech)

Enable/Disable KPI commentary

Enable/Disable AI commentary (future feature)

Choose tone (friendly, neutral, mentor, cosmic, humor)

Choose persona (Orb, Mystic Scientist, Minimalist, Silent Sage)

Below is:

⭐ THE FULL SYSTEM IMPLEMENTATION (clean, robust, scalable)

This extends your existing Mystic Engine with user preferences stored in localStorage (or Postgres if you want).

⭐ OVERVIEW – WHAT WE WILL ADD

1) New file: MysticSettings.ts

A centralized store for user preferences

Enable/disable Mystic Guide

Enable/disable voice

Per-page control

2) Update MysticProvider to respect settings

If a page is disabled → no intro, no warnings, no KPI insights

If voice is disabled → no TTS played

3) UI in Profile Page → System Settings Section

Toggle checkboxes for each page
Toggle global settings

Toggle voice

Save settings
Save settings