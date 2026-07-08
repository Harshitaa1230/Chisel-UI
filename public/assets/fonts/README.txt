Place the licensed custom font files here.

The stylesheet (@font-face in styles.css and the inline <style> blocks of
index.html / admin.html) expects these exact filenames:

  H1 display font — NCL Gasdrifo (Enxyclo Studio):
    NCLGasdrifo.woff2   (preferred)
    NCLGasdrifo.woff    (optional fallback)
    NCLGasdrifo.otf     (optional fallback)

  Body / all other sizes — TT Fors:
    TTfors.woff2        (preferred)
    TTfors.woff         (optional fallback)
    TTfors.otf          (optional fallback)

Until these files are added, the UI falls back to Audiowide (H1) and
DM Sans (body), so nothing breaks.
