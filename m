Return-Path: <SRS0=Hjc+=ZX=rjwysocki.net=rjw@kernel.org>
Return-Path: <SRS0=Hjc+=ZX=rjwysocki.net=rjw@kernel.org>
From: "Rafael J. Wysocki" <rjw@rjwysocki.net>
To: Bjorn Helgaas <helgaas@kernel.org>, Lukas Wunner <lukas@wunner.de>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org, Bart Van Assche <bart.vanassche@sandisk.com>, Christoph Hellwig <hch@lst.de>, Yinghai Lu <yinghai@kernel.org>, "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>, Mika Westerberg <mika.westerberg@linux.intel.com>, Ashok Raj <ashok.raj@intel.com>, Keith Busch <keith.busch@intel.com>
Subject: Re: [GIT PULL] PCI fixes for v4.10
Date: Fri, 10 Feb 2017 13:39:24 +0100
Message-ID: <1601856.9nRGEkG20k@aspire.rjw.lan>
In-Reply-To: <20170209201154.GA22458@bhelgaas-glaptop.roam.corp.google.com>
References: <20170208192054.GA31395@bhelgaas-glaptop.roam.corp.google.com> <20170209150950.GA11905@bhelgaas-glaptop.roam.corp.google.com> <20170209201154.GA22458@bhelgaas-glaptop.roam.corp.google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
List-ID: <linux-pci.vger.kernel.org>

On Thursday, February 09, 2017 02:11:54 PM Bjorn Helgaas wrote:
> On Thu, Feb 09, 2017 at 09:09:50AM -0600, Bjorn Helgaas wrote:
> > [+cc Ashok, Keith]
> > 
> > On Thu, Feb 09, 2017 at 05:06:48AM +0100, Lukas Wunner wrote:
> > > On Wed, Feb 08, 2017 at 01:22:56PM -0600, Bjorn Helgaas wrote:
> > > > Bjorn Helgaas (1):
> > > >       Revert "PCI: pciehp: Add runtime PM support for PCIe hotplug ports"
> > > 
> > > What's the rationale for reverting this?
> > > 
> > > You've received patches to fix the issue on both affected machines,
> > > so a revert seems unnecessary:
> > > 
> > > https://patchwork.kernel.org/patch/9557113/
> > > https://patchwork.kernel.org/patch/9562007/
> > 
> > I don't think we've gotten to the root cause of the problem yet,
> > and I don't want to throw in fixes at the last minute without a better
> > understanding of it.
> > 
> > PCIe hotplug hardware is not very complicated, it hasn't changed in
> > many years, and at least for the Intel hardware in question, is
> > generally pretty well-tested with Windows.  So I want to be careful
> > about asserting that this new piece of hardware is broken.
> 
> I apologize: I had quirks on the brain, but neither of the patches
> above is device-specific.  So neither is claiming broken hardware.
> 
> However, 9557113 claims we get unwanted PME interrupts if the slot is
> occupied when we suspend to D3hot.  This is what I want to explore
> further, because that hardware behavior doesn't really make sense to
> me.
> 
> 9562007 apparently fixes something, but at this point it's a debugging
> patch (no changelog or signed-off-by) so not a candidate for tossing
> into v4.10 at this late date.

Right.

FWIW, my view on this is that it woundn't really hurt to allow Thunderbolt
ports only to use runtime PM for the time being while the more general
(PCIe hotplug ports) case is under investigation.

That shouldn't made the code in question excessively complex and the
Thunderbolt special case should be easy enough to get rid of when we
know what to do in general here.

OTOH, the users of the systems with Thunderbolt would benefit from
reduced energy consumption in the meantime.

Thanks,
Rafael
