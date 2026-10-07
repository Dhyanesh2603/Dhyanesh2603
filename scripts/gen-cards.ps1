$ErrorActionPreference = 'Stop'
$out = Join-Path $PSScriptRoot '..\assets\v2'
New-Item -ItemType Directory -Force $out | Out-Null

function Esc($s) { $s.Replace('&','&amp;').Replace('<','&lt;').Replace('>','&gt;') }

$projects = @(
  @{ id='nous'; n='01'; cat='DEVELOPER TOOLS'; name='Nous'; pos='Software architecture intelligence platform';
     prob='Turns large, unfamiliar codebases into a navigable architectural model.';
     hi=@('Polyglot AST parsing with Tree-sitter','Dependency graphs, layering and cycle detection','AI reasoning grounded in static analysis');
     tech=@('TypeScript','Python','FastAPI','React') },
  @{ id='codemap'; n='02'; cat='CODE INTELLIGENCE'; name='CodeMap'; pos='Change impact and architecture drift analysis';
     prob='Shows what a change will break before it is merged.';
     hi=@('Repositories compiled into knowledge graphs','Architecture drift detection over time','Impact simulation for pull request review');
     tech=@('Python','AST','Graphs','LLM') },
  @{ id='mockforge'; n='03'; cat='AI PLATFORM'; name='MockForge'; pos='AI technical interview and coding platform';
     prob='Realistic interview practice with feedback that adapts to the candidate.';
     hi=@('Adaptive AI interviewer with SWOT analysis','Real-time 1v1 multiplayer code battles','In-browser multi-language compiler sandbox');
     tech=@('JavaScript','Node.js','WebSockets','LLM') },
  @{ id='vaultix'; n='04'; cat='INFRASTRUCTURE'; name='Vaultix'; pos='Multi-tenant cloud storage platform';
     prob='Storage that scales efficiently without duplicating data.';
     hi=@('Content-addressed deduplication','Tenant isolation and developer APIs','In-browser editors for stored files');
     tech=@('Python','FastAPI','SQLAlchemy','PostgreSQL') },
  @{ id='arete'; n='05'; cat='PRODUCT'; name='Arete'; pos='Engineering productivity workspace';
     prob='Replaces scattered notes, tasks and study plans with one workspace.';
     hi=@('Modular block-based document editor','Spaced repetition for DSA mastery','Roadmaps, focus sessions and daily planning');
     tech=@('Dart','Flutter Web','Riverpod','Supabase') },
  @{ id='justdeal'; n='06'; cat='APPLIED ML'; name='JustDeal'; pos='AI real estate investment advisor';
     prob='Explainable Buy / Hold / Avoid decisions for property investment.';
     hi=@('Price, rent and appreciation ML models','Fusion engine for personalised recommendations','Locality insights and risk analysis');
     tech=@('Python','Machine Learning','React','FastAPI') }
)

foreach ($p in $projects) {
  $chips = ''
  $x = 32
  foreach ($t in $p.tech) {
    $w = [int]($t.Length * 7.3 + 26)
    $cx = $x + $w / 2
    $chips += "<rect x=`"$x`" y=`"300`" width=`"$w`" height=`"26`" rx=`"13`" fill=`"none`" stroke=`"#27272a`"/><text x=`"$cx`" y=`"317`" text-anchor=`"middle`">$(Esc $t)</text>"
    $x += $w + 8
  }
  $hl = ''
  $y = 222
  foreach ($h in $p.hi) {
    $hl += "<rect x=`"32`" y=`"$($y-5)`" width=`"6`" height=`"1.5`" fill=`"#52525b`"/><text x=`"48`" y=`"$y`">$(Esc $h)</text>"
    $y += 24
  }
  $svg = @"
<svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 600 350" width="600" height="350" role="img" aria-label="$(Esc $p.name) - $(Esc $p.pos)">
  <style>
    .mono{font-family:ui-monospace,SFMono-Regular,Menlo,Consolas,monospace}
    .sans{font-family:-apple-system,BlinkMacSystemFont,'Segoe UI',Inter,Helvetica,Arial,sans-serif}
    .sweep{animation:s 5s ease-in-out infinite}
    @keyframes s{0%{transform:translateX(-200px)}60%,100%{transform:translateX(620px)}}
  </style>
  <defs>
    <linearGradient id="bg" x1="0" y1="0" x2="1" y2="1"><stop offset="0" stop-color="#0d0d0f"/><stop offset="1" stop-color="#08080a"/></linearGradient>
    <linearGradient id="hl" x1="0" x2="1"><stop offset="0" stop-color="#fff" stop-opacity="0"/><stop offset=".5" stop-color="#fff" stop-opacity=".45"/><stop offset="1" stop-color="#fff" stop-opacity="0"/></linearGradient>
  </defs>
  <rect x=".5" y=".5" width="599" height="349" rx="14" fill="url(#bg)" stroke="#1f1f22"/>
  <rect x="0" y="0" width="160" height="1" fill="url(#hl)" class="sweep"/>
  <text x="32" y="44" class="mono" font-size="11" fill="#52525b" letter-spacing="2">$($p.n) &#8212; $($p.cat)</text>
  <text x="568" y="44" text-anchor="end" class="mono" font-size="13" fill="#52525b">&#8599;</text>
  <text x="32" y="94" class="sans" font-size="32" font-weight="600" fill="#fafafa" letter-spacing="-1">$(Esc $p.name)</text>
  <text x="32" y="122" class="sans" font-size="16" fill="#a1a1aa">$(Esc $p.pos)</text>
  <text x="32" y="164" class="sans" font-size="14" fill="#d4d4d8">$(Esc $p.prob)</text>
  <line x1="32" y1="190" x2="568" y2="190" stroke="#18181b"/>
  <g class="sans" font-size="14" fill="#a1a1aa">$hl</g>
  <g class="mono" font-size="12" fill="#a1a1aa">$chips</g>
</svg>
"@
  [IO.File]::WriteAllText((Join-Path $out "$($p.id).svg"), $svg, (New-Object Text.UTF8Encoding $false))
}
"generated"
