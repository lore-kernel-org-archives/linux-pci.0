Return-Path: <SRS0=BcYr=DJ=rjwysocki.net=rjw@kernel.org>
Return-Path: <SRS0=BcYr=DJ=rjwysocki.net=rjw@kernel.org>
From: "Rafael J. Wysocki" <rjw@rjwysocki.net>
To: Thomas Gleixner <tglx@linutronix.de>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, Bjorn Helgaas <helgaas@kernel.org>, Maarten Lankhorst <dev@mblankhorst.nl>, Michal Hocko <mhocko@kernel.org>, Andy Lutomirski <luto@kernel.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, the arch/x86 maintainers <x86@kernel.org>, Daniel Vetter <daniel.vetter@intel.com>, Bjorn Helgaas <bhelgaas@google.com>, "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>, linux-pci@vger.kernel.org, linux-pm@vger.kernel.org
Subject: Re: Linux 4.15-rc2: Regression in resume from ACPI S3
Date: Wed, 13 Dec 2017 23:39:24 +0100
Message-ID: <2011671.y8uyto1vn5@aspire.rjw.lan>
In-Reply-To: <alpine.DEB.2.20.1712131856130.1885@nanos>
References: <168050887.sZlTFXWCmO@aspire.rjw.lan> <CA+55aFw-SZLey5FaQfSLSbDU1sYhoGDrWoOngswkHMFfHW3O6w@mail.gmail.com> <alpine.DEB.2.20.1712131856130.1885@nanos>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
List-ID: <linux-pci.vger.kernel.org>

On Wednesday, December 13, 2017 7:19:17 PM CET Thomas Gleixner wrote:
> On Wed, 13 Dec 2017, Linus Torvalds wrote:
> 
> > On Wed, Dec 13, 2017 at 8:41 AM, Thomas Gleixner <tglx@linutronix.de> wrote:
> > >
> > > Definitely. That was fragile forever but puzzles me is that I can't figure
> > > out what now causes that spurious interrupt to surface out of the blue.
> > 
> > Perhaps just timing?
> 
> That's what I'm trying to figure out right now, because that is the only
> sensible explanation left. The whole machinery of suspend is exactly the
> same with and without the vector changes. I instrumented all functions
> involved and the picture is the same. I even do not see any fundamental
> timing differences where one would say: That's it.
> 
> What puzzles me even more is that in the range of commits I'm fiddling with
> there is no other change than the vector management stuff and the point
> where it breaks makes no sense at all. The point Maarten bisected it to
> works nicely here, so that might just point to a very subtle timing issue.
> 
> > How hard would it be to change the ordering to just redirect irqs first?
> 
> The whole interrupt redirection happens when the non boot CPUs are brought
> down, which is the very last step before the actual suspend happens.
> 
> We could probably do that earlier, but that's something Rafael needs to
> answer ultimately.

Well, that's both flattering and concerning. ;-)

Anyway, yes, we can do that earlier AFAICS.  Action handlers are not going to
run after we've called suspend_device_irqs() which happens before the final
stage of PCI devices suspend (suspend_noirq) and it doesn't matter which CPU
gets the interrupt from that point on (it is either wakeup or unwanted then).

Thanks,
Rafael
