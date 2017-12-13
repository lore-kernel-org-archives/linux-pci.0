Return-Path: <SRS0=BcYr=DJ=rjwysocki.net=rjw@kernel.org>
Return-Path: <SRS0=BcYr=DJ=rjwysocki.net=rjw@kernel.org>
From: "Rafael J. Wysocki" <rjw@rjwysocki.net>
To: Thomas Gleixner <tglx@linutronix.de>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, Bjorn Helgaas <helgaas@kernel.org>, Maarten Lankhorst <dev@mblankhorst.nl>, Michal Hocko <mhocko@kernel.org>, Andy Lutomirski <luto@kernel.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, the arch/x86 maintainers <x86@kernel.org>, Daniel Vetter <daniel.vetter@intel.com>, Bjorn Helgaas <bhelgaas@google.com>, "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>, linux-pci@vger.kernel.org, linux-pm@vger.kernel.org
Subject: Re: Linux 4.15-rc2: Regression in resume from ACPI S3
Date: Wed, 13 Dec 2017 23:48:45 +0100
Message-ID: <15300261.gs7DNfzHs2@aspire.rjw.lan>
In-Reply-To: <alpine.DEB.2.20.1712132201380.1885@nanos>
References: <168050887.sZlTFXWCmO@aspire.rjw.lan> <alpine.DEB.2.20.1712132149420.1885@nanos> <alpine.DEB.2.20.1712132201380.1885@nanos>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
List-ID: <linux-pci.vger.kernel.org>

On Wednesday, December 13, 2017 10:06:40 PM CET Thomas Gleixner wrote:
> On Wed, 13 Dec 2017, Thomas Gleixner wrote:
> > On Wed, 13 Dec 2017, Thomas Gleixner wrote:
> > > On Wed, 13 Dec 2017, Linus Torvalds wrote:
> > > 
> > > > On Wed, Dec 13, 2017 at 8:41 AM, Thomas Gleixner <tglx@linutronix.de> wrote:
> > > > >
> > > > > Definitely. That was fragile forever but puzzles me is that I can't figure
> > > > > out what now causes that spurious interrupt to surface out of the blue.
> > > > 
> > > > Perhaps just timing?
> > > 
> > > That's what I'm trying to figure out right now, because that is the only
> > > sensible explanation left. The whole machinery of suspend is exactly the
> > > same with and without the vector changes. I instrumented all functions
> > > involved and the picture is the same. I even do not see any fundamental
> > > timing differences where one would say: That's it.
> > > 
> > > What puzzles me even more is that in the range of commits I'm fiddling with
> > > there is no other change than the vector management stuff and the point
> > > where it breaks makes no sense at all. The point Maarten bisected it to
> > > works nicely here, so that might just point to a very subtle timing issue.
> > 
> > After doing more debugging on this it turns out that this looks like a
> > legacy interrupt coming in. The vector number is always 55, which is legacy
> > IRQ 7 as seen from the PIC. The corresponding IOAPIC interrupt pin is
> > masked and vector 55 is completely unused.
> > 
> > More questions than answers. Still investigating.
> 
> And it does not explain Maartens report which gets a spurious vector 33 on
> CPU4 after the non boot cpus have been brought online again. And that's the
> vector which was assigned before the affinity was moved by unplugging CPU4.
> 
> Hrmpf. Even more mystery to solve.

Any chance to look at /proc/interrupts from a machine where that can be
reproduced?

I'm also curious if that can be reproduced by doing CPU offline/online
without suspending?
