Return-Path: <SRS0=MNFI=H4=h08.hostsharing.net=foo00@kernel.org>
Return-Path: <SRS0=MNFI=H4=h08.hostsharing.net=foo00@kernel.org>
Date: Wed, 9 May 2018 15:16:00 +0200
From: Lukas Wunner <lukas@wunner.de>
To: Bjorn Helgaas <helgaas@kernel.org>
Cc: Paul Menzel <pmenzel+linux-pci@molgen.mpg.de>,
	Bjorn Helgaas <bhelgaas@google.com>, linux-pci@vger.kernel.org,
	linux-kernel@vger.kernel.org, Sinan Kaya <okaya@codeaurora.org>
Subject: Re: pciehp 0000:00:1c.0:pcie004: Timeout on hotplug command 0x1038
 (issued 65284 msec ago)
Message-ID: <20180509131600.GA3712@wunner.de>
References: <8770820b-85a0-172b-7230-3a44524e6c9f@molgen.mpg.de>
 <20180427192207.GG8199@bhelgaas-glaptop.roam.corp.google.com>
 <20180509114124.GA20639@wunner.de>
 <20180509125752.GA234395@bhelgaas-glaptop.roam.corp.google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20180509125752.GA234395@bhelgaas-glaptop.roam.corp.google.com>
List-ID: <linux-pci.vger.kernel.org>

On Wed, May 09, 2018 at 07:57:52AM -0500, Bjorn Helgaas wrote:
> On Wed, May 09, 2018 at 01:41:24PM +0200, Lukas Wunner wrote:
> > On Fri, Apr 27, 2018 at 02:22:07PM -0500, Bjorn Helgaas wrote:
> > > Sinan mooted the idea of using a "no-wait" path of sending the "don't
> > > generate hotplug interrupts" command.  I think we should work on this
> > > idea a little more.  If we're shutting down the whole system, I can't
> > > believe there's much value in *anything* we do in the pciehp_remove()
> > > path.
> > > 
> > > Maybe we should just get rid of pciehp_remove() (and probably
> > > pcie_port_remove_service() and the other service driver remove methods)
> > > completely.  That dates from when the service drivers could be modules that
> > > could be potentially unloaded, but unloading them hasn't been possible for
> > > years.
> > 
> > Every Thunderbolt device contains a PCIe switch with at least one
> > (downstream) hotplug port, so pciehp_remove() is executed on unplug
> > of a Thunderbolt device and the assumption that it's unnecessary
> > simply because it's builtin isn't correct.
> 
> I agree that simply being builtin isn't a sufficient argument for getting
> rid of pciehp_remove().
> 
> But if we do need pciehp_remove(), we should be able to make a rational
> case for why that is.  If we're about to turn off the power, it's not
> obvious why we would need to deallocate memory, remove sysfs stuff, etc.
> If we need to configure the hardware to make it easier for a kexec'd
> kernel, that's a possible argument but we should make it explicit.

With Thunderbolt, up to 6 devices may be daisy-chained.  This means that a
hotplug port may have further hotplug ports as (grand-)children.

If power is turned off manually via sysfs for a hotplug port, all children
(including hotplug ports) are removed by pciehp even though they physically
remain attached to the machine.  If such removed-in-software-but-physically-
still-present devices send an interrupt, and interrupts were not orderly
disabled on ->remove, they will be considered spurious interrupts by genirq
code.  In particular, level-triggered INTx interrupts will immediately lead
to an unpleasant user-visible splat and the interrupt will be switched to
polling.

So there's no way around orderly disabling interrupts in the ->remove path.

I agree that ->shutdown is a different story in principle and that disabling
devices seems superfluous and counter-intuitive.  I imagine kexec might not
be the only reason, but also devices passed through to VMs.  (What happens
if a VM hands a device back to the host in an unclean state on shutdown?)

Thanks,

Lukas
