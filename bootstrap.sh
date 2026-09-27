#!/bin/bash

# Exit immediately if a command exits with a non-zero status
set -e

echo "=== [1/5] Initializing Vite React & Tailwind CSS Project ==="
npm create vite@latest evidence-room -- --template react
cd evidence-room

echo "=== [2/5] Installing Dependencies (lucide-react, framer-motion, tailwindcss, postcss, autoprefixer) ==="
npm install
npm install framer-motion lucide-react
npm install -D tailwindcss postcss autoprefixer
npx tailwindcss init -p

echo "=== [3/5] Configuring Tailwind CSS Content Paths ==="
cat << 'EOF' > tailwind.config.js
/** @type {import('tailwindcss').Config} */
export default {
  content: [
    "./index.html",
    "./src/**/*.{js,ts,jsx,tsx}",
  ],
  theme: {
    extend: {},
  },
  plugins: [],
}
EOF

echo "=== [4/5] Writing Tailwind Directives to CSS ==="
cat << 'EOF' > src/index.css
@tailwind base;
@tailwind components;
@tailwind utilities;
EOF

echo "=== [5/5] Deploying Production-Ready App Component ==="
cat << 'EOF' > src/App.jsx
import React, { useState } from 'react';
import { motion, AnimatePresence } from 'framer-motion';
import { 
  ShieldAlert, 
  FileText, 
  Scale, 
  AlertTriangle, 
  ChevronRight, 
  Lock, 
  ExternalLink,
  Layers,
  Database
} from 'lucide-react';

export default function DigitalEvidenceRoom() {
  const [activeTab, setActiveTab] = useState('overview');

  const timelineEvents = [
    {
      year: '2017',
      title: 'Holdover Initiation',
      description: 'Chelsea Partners initiates a certificate-of-occupancy (CO) based holdover proceeding against Apartment 1A, alleging unlawful residential occupancy.',
      category: 'Litigation'
    },
    {
      year: 'Oct 2018',
      title: 'Discovery Order (Judge Chinea)',
      description: 'Court rules that rent regulatory status is directly relevant to the holdover action, ordering production of rent histories, J-51 records, and legalization documentation.',
      category: 'Discovery'
    },
    {
      year: 'Jan 2020',
      title: 'Decision & Order (Judge Ortiz)',
      description: 'Denies summary judgment to both sides, finding Chelsea failed to prove exhaustion of remedies, final DOB denial, or undue burden, while explicitly noting that rent-stabilized status would "clearly" require dismissal.',
      category: 'Rulings'
    },
    {
      year: 'Oct 2020',
      title: 'Motion for Sanctions & Penalties',
      description: 'Tenant details Chelsea’s continued failure to produce required rent ledgers, variance records, and J-51 compliance history.',
      category: 'Litigation'
    },
    {
      year: 'Mar 2021',
      title: 'Reargument Order (Judge Ortiz)',
      description: 'Denies reargument, introducing the "not ripe until after trial" sequencing rule that makes the landlord’s future exhaustion proof a mandatory prerequisite to adjudicating tenant status.',
      category: 'Rulings'
    },
    {
      year: 'Jan 2025',
      title: 'Administrative Promotion',
      description: 'Hon. Frances Ortiz is publicly appointed as Supervising Judge of New York County Housing Court, centralizing administrative oversight of the exact court where these rulings were rendered.',
      category: 'Administration'
    }
  ];

  const contradictionData = [
    {
      topic: 'Legalization & Exhaustion',
      landlordBurden: 'Failed to prove final DOB denial, exhaustion of remedies, or variance pursuit.',
      initialCourtFinding: 'Acknowledged absence of proof; noted objection could be addressed with plan examiner.',
      reargumentShift: 'Made future trial on landlord exhaustion a mandatory prerequisite to status determination.',
      inversionEffect: 'Landlord’s failure of proof becomes a procedural shield preserving the holdover.'
    },
    {
      topic: 'Rent Stabilization Status',
      landlordBurden: 'Argued unit was commercial/nonregulated based on CO violation.',
      initialCourtFinding: 'Acknowledged that if regulated, petition must be dismissed as pleaded.',
      reargumentShift: 'Ruled status was not "ripe" until after the landlord\'s exhaustion trial.',
      inversionEffect: 'Dispositive statutory defense deferred until opposing party cures its own evidence gap.'
    },
    {
      topic: 'Discovery & Compliance',
      landlordBurden: 'Failed to produce historical rent ledgers and J-51 records.',
      initialCourtFinding: 'Found records missing and J-51 representations contradictory.',
      reargumentShift: 'Denied sanctions and preserved case integrity.',
      inversionEffect: 'Noncompliant party protected from ordinary procedural preclusion.'
    }
  ];

  return (
    <div className="min-h-screen bg-slate-950 text-slate-100 font-sans selection:bg-red-500 selection:text-white">
      <div className="bg-red-950/40 border-b border-red-900/50 px-4 py-2 text-xs flex justify-between items-center text-red-400 tracking-wider uppercase font-mono">
        <span className="flex items-center gap-2">
          <ShieldAlert className="w-4 h-4 animate-pulse" /> Public Record Evidence Room // Docket: LT-081870-17/NY
        </span>
        <span className="hidden md:inline">Secure Verification Node Active</span>
      </div>

      <header className="border-b border-slate-800 bg-slate-900/50 backdrop-blur sticky top-0 z-50">
        <div className="max-w-7xl mx-auto px-6 h-20 flex items-center justify-between">
          <div>
            <h1 className="text-xl font-bold tracking-tight text-white flex items-center gap-2">
              <Scale className="w-5 h-5 text-red-500" /> OPERATION REVERSAL
            </h1>
            <p className="text-xs text-slate-400 font-mono">Documented Procedural Inversion & Judicial Oversight Record</p>
          </div>
          
          <nav className="hidden md:flex gap-1 bg-slate-950 p-1 rounded-lg border border-slate-800">
            {['overview', 'chronology', 'contradictions', 'vault'].map((tab) => (
              <button
                key={tab}
                onClick={() => setActiveTab(tab)}
                className={`px-4 py-2 rounded-md text-xs font-mono uppercase transition-all ${
                  activeTab === tab 
                    ? 'bg-red-600 text-white shadow-lg shadow-red-900/20' 
                    : 'text-slate-400 hover:text-slate-200 hover:bg-slate-900'
                }`}
              >
                {tab}
              </button>
            ))}
          </nav>
        </div>
      </header>

      <main className="max-w-7xl mx-auto px-6 py-10">
        <AnimatePresence mode="wait">
          {activeTab === 'overview' && (
            <motion.div
              key="overview"
              initial={{ opacity: 0, y: 10 }}
              animate={{ opacity: 1, y: 0 }}
              exit={{ opacity: 0, y: -10 }}
              transition={{ duration: 0.3 }}
              className="space-y-8"
            >
              <div className="bg-gradient-to-r from-slate-900 via-slate-900 to-red-950/20 border border-slate-800 rounded-2xl p-8 shadow-2xl relative overflow-hidden">
                <div className="absolute right-0 top-0 translate-x-12 -translate-y-12 w-96 h-96 bg-red-500/5 rounded-full blur-3xl pointer-events-none" />
                
                <span className="text-xs font-mono text-red-500 uppercase tracking-widest bg-red-950/50 px-3 py-1 rounded border border-red-900/40">
                  Executive Dossier
                </span>
                
                <h2 className="text-3xl font-extrabold text-white mt-4 mb-4 tracking-tight">
                  Exposing Institutional Procedural Inversion in Manhattan Housing Court
                </h2>
                
                <p className="text-slate-300 text-lg leading-relaxed max-w-4xl">
                  This digital evidence room documents how Manhattan Housing Court utilized structural procedural inversions to preserve a deficient landlord holdover petition while deferring statutory rent-stabilization and overcharge protections.
                </p>

                <div className="grid grid-cols-1 md:grid-cols-3 gap-6 mt-8 pt-8 border-t border-slate-800/80 font-mono">
                  <div className="bg-slate-950/60 p-4 rounded-xl border border-slate-800/60">
                    <div className="text-red-500 text-2xl font-bold mb-1">01</div>
                    <div className="text-xs text-slate-400 uppercase">The Baseline Rule</div>
                    <div className="text-sm text-slate-200 mt-2">Illegal occupancy under a CO does not automatically exempt a unit from rent stabilization.</div>
                  </div>
                  <div className="bg-slate-950/60 p-4 rounded-xl border border-slate-800/60">
                    <div className="text-red-500 text-2xl font-bold mb-1">02</div>
                    <div className="text-xs text-slate-400 uppercase">The Deficit</div>
                    <div className="text-sm text-slate-200 mt-2">Landlord failed to prove final agency denial, exhaustion, variance, or undue burden.</div>
                  </div>
                  <div className="bg-slate-950/60 p-4 rounded-xl border border-slate-800/60">
                    <div className="text-red-500 text-2xl font-bold mb-1">03</div>
                    <div className="text-xs text-slate-400 uppercase">The Inversion</div>
                    <div className="text-sm text-slate-200 mt-2">Landlord's unproven failure converted into a procedural shield preserving the case.</div>
                  </div>
                </div>
              </div>

              <div className="grid grid-cols-1 md:grid-cols-2 gap-6">
                <div className="bg-slate-900/60 border border-slate-800 rounded-xl p-6">
                  <h3 className="text-lg font-semibold text-white mb-3 flex items-center gap-2">
                    <Layers className="w-5 h-5 text-red-500" /> Core Investigative Findings
                  </h3>
                  <ul className="space-y-3 text-slate-300 text-sm">
                    <li className="flex items-start gap-2">
                      <ChevronRight className="w-4 h-4 text-red-500 shrink-0 mt-1" />
                      <span>The court recognized that termination is barred unless the apartment cannot be legalized.</span>
                    </li>
                    <li className="flex items-start gap-2">
                      <ChevronRight className="w-4 h-4 text-red-500 shrink-0 mt-1" />
                      <span>Despite identifying contradictory zoning records and missing rent ledgers, sanctions were denied.</span>
                    </li>
                    <li className="flex items-start gap-2">
                      <ChevronRight className="w-4 h-4 text-red-500 shrink-0 mt-1" />
                      <span>The March 2021 reargument order established that tenant status would not be "ripe" until after landlord exhaustion trials.</span>
                    </li>
                  </ul>
                </div>

                <div className="bg-slate-900/60 border border-slate-800 rounded-xl p-6">
                  <h3 className="text-lg font-semibold text-white mb-3 flex items-center gap-2">
                    <Database className="w-5 h-5 text-red-500" /> Administrative Context
                  </h3>
                  <p className="text-slate-300 text-sm leading-relaxed">
                    Hon. Frances Ortiz authored the January 2020 and March 2021 rulings. In January 2025, she was publicly appointed as the Supervising Judge of New York County Housing Court, centralizing administrative oversight of the exact court where these matters were adjudicated.
                  </p>
                </div>
              </div>
            </motion.div>
          )}

          {activeTab === 'chronology' && (
            <motion.div
              key="chronology"
              initial={{ opacity: 0, y: 10 }}
              animate={{ opacity: 1, y: 0 }}
              exit={{ opacity: 0, y: -10 }}
              transition={{ duration: 0.3 }}
              className="space-y-6"
            >
              <div className="border-b border-slate-800 pb-4 mb-6">
                <h2 className="text-2xl font-bold text-white tracking-tight">Master Chronology Matrix</h2>
                <p className="text-sm text-slate-400 font-mono">Verified court filings, discovery orders, and judicial rulings (2017–2025)</p>
              </div>

              <div className="relative border-l border-slate-800 ml-4 space-y-8 py-4">
                {timelineEvents.map((event, index) => (
                  <div key={index} className="relative pl-8 group">
                    <div className="absolute -left-[9px] top-1.5 w-4 h-4 rounded-full bg-slate-900 border-2 border-red-500 group-hover:bg-red-500 transition-colors" />
                    
                    <div className="bg-slate-900/80 border border-slate-800 rounded-xl p-5 shadow-lg hover:border-slate-700 transition-all">
                      <div className="flex items-center justify-between mb-2">
                        <span className="text-xs font-mono px-2.5 py-0.5 rounded bg-red-950/80 text-red-400 border border-red-900/50">
                          {event.year}
                        </span>
                        <span className="text-xs font-mono text-slate-500 uppercase">{event.category}</span>
                      </div>
                      <h3 className="text-lg font-semibold text-white mb-1">{event.title}</h3>
                      <p className="text-slate-300 text-sm leading-relaxed">{event.description}</p>
                    </div>
                  </div>
                ))}
              </div>
            </motion.div>
          )}

          {activeTab === 'contradictions' && (
            <motion.div
              key="contradictions"
              initial={{ opacity: 0, y: 10 }}
              animate={{ opacity: 1, y: 0 }}
              exit={{ opacity: 0, y: -10 }}
              transition={{ duration: 0.3 }}
              className="space-y-6"
            >
              <div className="border-b border-slate-800 pb-4 mb-6">
                <h2 className="text-2xl font-bold text-white tracking-tight">Contradiction & Inversion Matrix</h2>
                <p className="text-sm text-slate-400 font-mono">Side-by-side analysis exposing internal flaws across court orders</p>
              </div>

              <div className="space-y-6">
                {contradictionData.map((item, idx) => (
                  <div key={idx} className="bg-slate-900/80 border border-slate-800 rounded-xl p-6 shadow-xl">
                    <h3 className="text-lg font-bold text-red-400 font-mono mb-4 flex items-center gap-2">
                      <AlertTriangle className="w-5 h-5" /> {item.topic}
                    </h3>
                    
                    <div className="grid grid-cols-1 md:grid-cols-4 gap-4 text-sm font-mono">
                      <div className="bg-slate-950/50 p-4 rounded-lg border border-slate-800/80">
                        <div className="text-xs text-slate-500 uppercase mb-1">Landlord Burden</div>
                        <div className="text-slate-300">{item.landlordBurden}</div>
                      </div>
                      <div className="bg-slate-950/50 p-4 rounded-lg border border-slate-800/80">
                        <div className="text-xs text-slate-500 uppercase mb-1">Initial Finding (Jan 2020)</div>
                        <div className="text-slate-300">{item.initialCourtFinding}</div>
                      </div>
                      <div className="bg-slate-950/50 p-4 rounded-lg border border-slate-800/80">
                        <div className="text-xs text-slate-500 uppercase mb-1">Reargument Shift (Mar 2021)</div>
                        <div className="text-slate-300">{item.reargumentShift}</div>
                      </div>
                      <div className="bg-red-950/20 p-4 rounded-lg border border-red-900/30">
                        <div className="text-xs text-red-400 uppercase mb-1">Inversion Effect</div>
                        <div className="text-red-200 font-semibold">{item.inversionEffect}</div>
                      </div>
                    </div>
                  </div>
                ))}
              </div>
            </motion.div>
          )}

          {activeTab === 'vault' && (
            <motion.div
              key="vault"
              initial={{ opacity: 0, y: 10 }}
              animate={{ opacity: 1, y: 0 }}
              exit={{ opacity: 0, y: -10 }}
              transition={{ duration: 0.3 }}
              className="space-y-6"
            >
              <div className="border-b border-slate-800 pb-4 mb-6">
                <h2 className="text-2xl font-bold text-white tracking-tight">Primary Source Vault</h2>
                <p className="text-sm text-slate-400 font-mono">Verified public record exhibits and court filings</p>
              </div>

              <div className="grid grid-cols-1 md:grid-cols-2 gap-6">
                {[
                  { title: 'January 21, 2020 Decision & Order', desc: 'Authored by Judge Frances Ortiz denying summary judgment and outlining exhaustion requirements.', tag: 'Primary Ruling' },
                  { title: 'March 1, 2021 Reargument Order', desc: 'Denies motion for leave to reargue, establishing the post-trial ripeness sequence.', tag: 'Reargument Order' },
                  { title: 'October 12, 2018 Discovery Order', desc: 'Judge Chinea ruling rent regulatory status and J-51 records directly relevant to holdover action.', tag: 'Discovery Order' },
                  { title: 'October 2020 Motion for Sanctions', desc: 'Formal filings detailing missing rent ledgers and contradictory J-51 disclosures.', tag: 'Motion Papers' }
                ].map((doc, i) => (
                  <div key={i} className="bg-slate-900/80 border border-slate-800 rounded-xl p-6 flex flex-col justify-between hover:border-slate-700 transition-all">
                    <div>
                      <div className="flex justify-between items-center mb-3">
                        <span className="text-xs font-mono px-2.5 py-1 rounded bg-slate-800 text-slate-300 border border-slate-700">
                          {doc.tag}
                        </span>
                        <Lock className="w-4 h-4 text-slate-500" />
                      </div>
                      <h3 className="text-lg font-semibold text-white mb-2">{doc.title}</h3>
                      <p className="text-sm text-slate-300 mb-6">{doc.desc}</p>
                    </div>
                    
                    <button className="w-full bg-slate-950 hover:bg-slate-800 border border-slate-800 text-slate-200 text-xs font-mono uppercase py-2.5 rounded-lg flex items-center justify-center gap-2 transition-colors">
                      <FileText className="w-4 h-4 text-red-500" /> Inspect Certified Record <ExternalLink className="w-3 h-3 text-slate-500" />
                    </button>
                  </div>
                ))}
              </div>
            </motion.div>
          )}
        </AnimatePresence>
      </main>

      <footer className="border-t border-slate-800 bg-slate-900/40 mt-20 py-8 text-center text-xs text-slate-500 font-mono">
        <p>Digital Evidence Room // Maintained for Independent Public Review</p>
      </footer>
    </div>
  );
}
EOF

echo "=== Build Verification ==="
npm run build

echo "=== Starting Development Server ==="
npm run dev -- --host
