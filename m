Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.136]:52958 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S932538AbcHVQzf (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Mon, 22 Aug 2016 12:55:35 -0400
Date: Mon, 22 Aug 2016 11:55:24 -0500
From: Bjorn Helgaas <helgaas@kernel.org>
To: Keith Busch <keith.busch@intel.com>
Cc: linux-pci@vger.kernel.org, Bjorn Helgaas <bhelgaas@google.com>
Subject: Re: [PATCH 2/2] pci: Add ignore indicator quirk for devices
Message-ID: <20160822165524.GC18628@localhost>
References: <1470687542-30155-1-git-send-email-keith.busch@intel.com>
 <1470687542-30155-2-git-send-email-keith.busch@intel.com>
 <20160815174002.GB9790@localhost>
 <20160815192316.GB18083@localhost.localdomain>
 <20160817213745.GE27353@localhost>
 <20160817230951.GD25146@localhost.localdomain>
 <20160818195656.GH27353@localhost>
 <20160818224610.GA28276@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20160818224610.GA28276@localhost.localdomain>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Thu, Aug 18, 2016 at 06:46:10PM -0400, Keith Busch wrote:
> On Thu, Aug 18, 2016 at 02:56:56PM -0500, Bjorn Helgaas wrote:
> > On Wed, Aug 17, 2016 at 07:09:51PM -0400, Keith Busch wrote:
> > > We've augmented 'ledmon' with libpci and toggles these indicators very
> > > similar to how 'setpci' can change PCI config registers. It is done only
> > > after the storage device is up and registered, which is well outside
> > > the time when pciehp is actively using the slot control.
> > 
> > I assume this means ledmon writes Slot Control to manage the LEDs.
> 
> Correct, the registers that are defined for AttnCtrl and PwrCtrl are
> what's being redefined for the new pattern.
> 
> We are definitely not dead set on requiring we let ledmon have direct
> access to SlotCtl through libpci. That's just the one way we thought of
> that didn't require new kernel dependencies.
> 
> > That sounds pretty scary to me because it's impossible to enforce the
> > assumption that ledmon only uses Slot Control when pciehp isn't using
> > it.  Hotplug includes surprise events, and I think pciehp is entitled
> > to assume it is the sole owner of Slot Control.
> 
> I understand the concern here. You don't want independent programs
> vying to mask/unmask bits in SlotCtl and end up with a state neither
> intended. The only scenario that I can come up with where that could
> happen is if ledmon changes the LED on a slot at the same time the drive
> is removed, but there is no MRL or attention buttons on this hardware,
> and the rest that we do care about looks totally harmless on these slots.
> 
> This condition also isn't really new. While probably not recommended,
> I could blink the standard Attn and Pwr LED's like this (user, of course,
> assumes all the risks):
> 
>   # setpci -s <B:D.f> CAP_EXP+18.w=280:3c0

Definitely not recommended.  If you use setpci, all bets are off and
we can't really support the system afterwards.  In fact, we probably
should taint the kernel when users write to config space.

If we tainted the kernel and put something in dmesg on the first user
config space write, I might be OK with the original quirk to make
pciehp ignore the attention and power indicators.

The only reason I suggest a dmesg note is because while we can't
*imagine* a scenario where pciehp and ledmon stomp on each other, that
doesn't mean such a scenario doesn't exist, and a problem would be
hard to reproduce and hard to debug.

> > I wonder if there's some way to implement the LED control in pciehp,
> > e.g., by enhancing pciehp_set_attention_status().  I assume the
> > desired indicator state is coming from some in-kernel storage driver,
> > and ledmon learns about that somehow, then fiddles with Slot Control
> > behind the kernel's back?  That looping from kernel to user and back
> > to kernel sounds a little dodgy and fragile.
> 
> That is definitely an interesting possibility if you are open to
> this. We'd "just" need the kernel to comprehend these vendor specific
> bit patterns for this particular generation of hardware.
> 
> If you're okay with that, then I'm more than happy to propose a patch
> for consideration. We can then have ledmon subscribe to the sysfs entry
> point instead of going through libpci, no problem.

I was imagining these LEDs as some sort of extension to the PCIe
hotplug model, but I think that was a mistake: logically, they have
nothing to do with hotplug, and the only reason they're currently
associated with hotplug is because you chose to re-use a bus (VPP)
that happens to be connected to the Slot Control registers.

>From an architectural point of view, these LEDs seem device-specific
or storage-specific, with no connection to PCIe at all, so I don't
know why we would put them in the PCIe spec or teach pciehp about
them.

> > Can you share any details about how you plan to implement this on the
> > next generation of devices?  Maybe we can enhance pciehp indicator
> > control in a way that supports both Sky Lake and future devices.
> 
> One possibility is to define through PCI-SIG
> SlotCap2 and SlotCtl2 with this kind of LED control.
> 
> Another possibilities I hear about through the NVMe-MI working group
> is creating similar type of devices as SES (SCSI Enclosure Services)
> for PCIe SSD enclosures.

> Since these are specific to VMD domains, there are folks at Intel who
> want to see the VMD driver mask off these capabilities from the driver.
> There is never a case where a slot in this domain should advertise these,
> so masking off the bits at the config read level would achieve the desired
> result. It'd be isolated to the VMD driver, and the quirk wouldn't need
> to be maintained as addtional vendor devices implementing the same quirk
> are made.

My biggest concern is the ownership problem, and this strategy doesn't
address that.

> ---
> diff --git a/arch/x86/pci/vmd.c b/arch/x86/pci/vmd.c
> index b73da50..aa2791f 100644
> --- a/arch/x86/pci/vmd.c
> +++ b/arch/x86/pci/vmd.c
> @@ -452,6 +452,7 @@ static int vmd_pci_read(struct pci_bus *bus,
> unsigned int devfn, int reg,
>  {
>  	struct vmd_dev *vmd = vmd_from_bus(bus);
>  	char __iomem *addr = vmd_cfg_addr(vmd, bus, devfn, reg, len);
> +	struct pci_dev *dev;
>  	unsigned long flags;
>  	int ret = 0;
>  
> @@ -474,6 +475,17 @@ static int vmd_pci_read(struct pci_bus *bus,
> unsigned int devfn, int reg,
>  		break;
>  	}
>  	spin_unlock_irqrestore(&vmd->cfg_lock, flags);
> +
> +	list_for_each_entry(dev, &bus->devices, bus_list) {
> +		if (dev->devfn == devfn) {
> +			if (dev->pcie_cap &&
> +					reg == dev->pcie_cap + PCI_EXP_SLTCAP)
> +				*value &= ~(PCI_EXP_SLTCAP_AIP |
> +					    PCI_EXP_SLTCAP_PIP);
> +			break;
> +		}
> +	}
> +
>  	return ret;
>  }
>  
> --
