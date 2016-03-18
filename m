Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.136]:54025 "EHLO mail.kernel.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1757361AbcCROOC (ORCPT <rfc822;linux-pci@vger.kernel.org>);
	Fri, 18 Mar 2016 10:14:02 -0400
Date: Fri, 18 Mar 2016 09:13:53 -0500
From: Bjorn Helgaas <helgaas@kernel.org>
To: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
Cc: Murali Karicheri <m-karicheri2@ti.com>,
	Bjorn Helgaas <bhelgaas@google.com>,
	"linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>
Subject: Re: PCI IO resource question.
Message-ID: <20160318141353.GA14429@localhost>
References: <56E987B8.1090904@ti.com>
 <20160316164531.GA28797@localhost>
 <56E9A12F.50008@ti.com>
 <20160316192904.GA2703@localhost>
 <56E9BE6A.6090107@ti.com>
 <20160316214733.GA11542@localhost>
 <56EB217F.8070603@ti.com>
 <20160318112802.GA1810@red-moon>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20160318112802.GA1810@red-moon>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Fri, Mar 18, 2016 at 11:28:02AM +0000, Lorenzo Pieralisi wrote:
> On Thu, Mar 17, 2016 at 05:28:31PM -0400, Murali Karicheri wrote:
> 
> [...]
> 
> > > The only ways I see that PCI_PROBE_ONLY can be set on ARM are if you have
> > > "linux,pci-probe-only" in your DT or you boot with "pci=firmware".
> > > 
> > > I expect you're in this path:
> > > 
> > >   ahci_init_one
> > >     pcim_enable_device
> > >       pci_enable_device
> > >         pci_enable_device_flags(dev, IORESOURCE_MEM | IORESOURCE_IO)
> > >           # build "bars" mask
> > >           do_pci_enable_device(dev, bars)
> > >             pcibios_enable_device
> > >               if (pci_has_flag(PCI_PROBE_ONLY))
> > >                 return 0;
> > >               pci_enable_resources
> > > 
> > > Can you add a little debug code like this to verify that we're in this
> > > path?
> > 
> > Yes we are in the path.
> > 
> > 
> > [    1.557561] ahci_init_one
> > [    1.560214] ahci 0000:01:00.0: version 3.0
> > [    1.564302] pcim_enable_device
> > [    1.567349] pci_enable_device
> > [    1.570340] pci_enable_device_flags
> > [    1.573824] do_pci_enable_device
> > [    1.577042] pcibios_enable_device
> > [    1.580380] pci_enable_resources
> 
> So resources are actually enabled (ie PCI_PROBE_ONLY is not set)
> and that makes sense otherwise you would not be able to use the
> MEM resources anyway (ie they would not be enabled).
> 
> I suspect the PCI dev IO resources were reset in reset_resource() in
> assign_requested_resource_sorted(), hence the bar mask that is built
> in pci_enable_device_flags() does not contain the IO resources,
> it would be helpful if you can print the bar mask passed to
> pcibios_enable_device() (ie the mask parameter).

I didn't look at the code to try to validate this theory, but it seems
plausible, and Murali could easily test it.

The very existence of reset_resource(), which clears res->flags, is a
problem because it means we're losing information about a hardware
BAR.  The fact that Linux throws away that information certainly
doesn't keep the device from responding based on the BAR contents.

If we're unable to assign any I/O BARs for a device, and we use
reset_resource() on them, pci_enable_resources() would not find any
IORESOURCE_IO BARs, so it would not turn on PCI_COMMAND_IO, so things
might appear to "work".  But pci_enable_resources() never turns
PCI_COMMAND_IO *off*, so if firmware left it enabled, we could still
have an issue.

We definitely have a problem if a device has two I/O BARs and we
assign one but call reset_resource() on the other.  Then
pci_enable_resources() won't know about the second one, so it will
turn on PCI_COMMAND_IO.  Then we have a potential conflict because the
second BAR is enabled but we don't know its contents.

> Not saying that's what should happen, I think that's what's happening,
> that's the only reason I see why you do not have pci_enable_resources()
> failures when you remove the IO range from the host bridge.

Makes a lot of sense; thanks for looking at this.

> > [    1.583608] ahci 0000:01:00.0: limiting MRRS to 256
> > [    1.588595] ahci 0000:01:00.0: AHCI 0001.0000 32 slots 2 ports 6 Gbps 0x3 impl SATA mode
> > [    1.596716] ahci 0000:01:00.0: flags: 64bit ncq sntf led only pmp fbs pio slum part sxs 
> > [    1.606183] scsi host0: ahci
> > [    1.609448] scsi host1: ahci
> > [    1.612636] ata1: SATA max UDMA/133 abar m512@0x60000000 port 0x60000100 irq 82
> > [    1.619974] ata2: SATA max UDMA/133 abar m512@0x60000000 port 0x60000180 irq 82
> > 
> > > 
> > >> I looked at pci_enable_resources()
> > >>
> > >> 	for (i = 0; i < PCI_NUM_RESOURCES; i++) {
> > >> 		if (!(mask & (1 << i)))
> > >> 			continue;
> > >>
> > >> 		r = &dev->resource[i];
> > > 
> > >                 dev_info(&dev->dev, "BAR %d %pR mask %#04x parent %p\n", i, r, mask, r->parent);
> > > 
> > >>
> > >> 		if (!(r->flags & (IORESOURCE_IO | IORESOURCE_MEM)))
> > >> 			continue;
> > >> 		if ((i == PCI_ROM_RESOURCE) &&
> > >> 				(!(r->flags & IORESOURCE_ROM_ENABLE)))
> > >> 			continue;
> > >>
> > >> 		if (r->flags & IORESOURCE_UNSET) {
> > >> 			dev_err(&dev->dev, "can't enable device: BAR %d %pR not assigned\n",
> > >> 				i, r);
> > >> 			return -EINVAL;
> > >> 		}
> > >>
> > >> 		if (!r->parent) {
> > >> 			dev_err(&dev->dev, "can't enable device: BAR %d %pR not claimed\n",
> > >> 				i, r);
> > >> 			return -EINVAL;
> > >> 		}
> > >>
> > >> I don't see the error "can't enable device: BAR %d %pR not assigned" , so it doesn't
> > >> depend on IO bar as you mention below or is it in a different function?
> > > 
> > 
> > 
> > -- 
> > Murali Karicheri
> > Linux Kernel, Keystone
> > --
> > To unsubscribe from this list: send the line "unsubscribe linux-pci" in
> > the body of a message to majordomo@vger.kernel.org
> > More majordomo info at  http://vger.kernel.org/majordomo-info.html
> > 
> --
> To unsubscribe from this list: send the line "unsubscribe linux-pci" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
