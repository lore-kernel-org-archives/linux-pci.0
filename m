Return-Path: <SRS0=SB5a=DJ=linutronix.de=tglx@kernel.org>
Return-Path: <SRS0=SB5a=DJ=linutronix.de=tglx@kernel.org>
Date: Wed, 13 Dec 2017 17:41:55 +0100 (CET)
From: Thomas Gleixner <tglx@linutronix.de>
To: Bjorn Helgaas <helgaas@kernel.org>
cc: Maarten Lankhorst <dev@mblankhorst.nl>, Michal Hocko <mhocko@kernel.org>,
    Linus Torvalds <torvalds@linux-foundation.org>,
    "Rafael J. Wysocki" <rjw@rjwysocki.net>, Andy Lutomirski <luto@kernel.org>,
    Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
    the arch/x86 maintainers <x86@kernel.org>,
    Daniel Vetter <daniel.vetter@intel.com>,
    Bjorn Helgaas <bhelgaas@google.com>,
    "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>,
    linux-pci@vger.kernel.org, linux-pm@vger.kernel.org
Subject: Re: Linux 4.15-rc2: Regression in resume from ACPI S3
In-Reply-To: <20171213162336.GG53955@bhelgaas-glaptop.roam.corp.google.com>
Message-ID: <alpine.DEB.2.20.1712131738020.1885@nanos>
References: <168050887.sZlTFXWCmO@aspire.rjw.lan> <CA+55aFwsMuHUBQz5kDNwRf17JnasXMWjvmLq5qXGH-694yeq1w@mail.gmail.com> <20171206121452.GA6320@dhcp22.suse.cz> <db81e89d-eee6-868c-dc10-c028f4c4be84@mblankhorst.nl> <alpine.DEB.2.20.1712061344560.1724@nanos>
 <0f1d3d63-fa10-5cef-8014-81753dc60243@mblankhorst.nl> <alpine.DEB.2.20.1712061514420.1724@nanos> <57c8679e-1b88-c9ad-2299-2bea7560b28f@mblankhorst.nl> <alpine.DEB.2.20.1712081129450.1840@nanos> <alpine.DEB.2.20.1712131507160.1885@nanos>
 <20171213162336.GG53955@bhelgaas-glaptop.roam.corp.google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
List-ID: <linux-pci.vger.kernel.org>

On Wed, 13 Dec 2017, Bjorn Helgaas wrote:
> [+cc linux-pci, linux-pm]
> 
> On Wed, Dec 13, 2017 at 04:57:56PM +0100, Thomas Gleixner wrote:
> > So I was finally able to figure out what the hell is going on:
> > 
> > Suspend:
> > 
> >  - The device suspend code puts the graphics card into a power
> >    state != PCI_D0.
> > 
> >  - Offline non boot CPUs
> > 
> >  - Break interrupt affinity. Allocate new vector on CPU 0, compose and
> >    write MSI message which ends up in:
> > 
> >    __pci_write_msi_msg(entry, msg)
> >    {
> > 	if (dev->current_state != PCI_D0 || pci_dev_is_disconnected(dev)) {
> > 	   /* Don't touch the hardware now */
> > 	} else {
> > 	   ....
> > 	}
> > 	entry->msg = *msg;
> >    }
> >  
> >   So because the device is not in PCI_D0 the message is not written. It's
> >   written in the device resume path.
> 
> I'm not a PM guru, but this ordering seems fragile.  If we offline
> CPUs before re-targeting interrupts directed at those CPUs, aren't we
> always going to be at risk of sending interrupts to an offline CPU?
> 
> Even if the device is now asleep and therefore should not generate an
> interrupt, it seems like there's a window when the device returns to
> PCI_D0 where it could generate an interrupt before we have a chance to
> update the MSI message.

Definitely. That was fragile forever but puzzles me is that I can't figure
out what now causes that spurious interrupt to surface out of the blue.

Thanks,

	tglx
