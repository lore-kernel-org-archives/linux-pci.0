Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:51784 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754049AbaKOPX0 (ORCPT <rfc822;linux-pci@vger.kernel.org>);
	Sat, 15 Nov 2014 10:23:26 -0500
Message-ID: <1416064996.27937.177.camel@ul30vt.home>
Subject: Re: DMA_ALIAS_DEVFN issue
From: Alex Williamson <alex.williamson@redhat.com>
To: Bjorn Helgaas <bhelgaas@google.com>
Cc: "Allan, Bruce W" <bruce.w.allan@intel.com>,
	"linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
	"iommu@lists.linux-foundation.org" <iommu@lists.linux-foundation.org>
Date: Sat, 15 Nov 2014 08:23:16 -0700
In-Reply-To: <CAErSpo7m9xMy9buOmF==8H_VSkBBqPZD1_OCPYjEz_1Q1n4y0Q@mail.gmail.com>
References: <CAErSpo7m9xMy9buOmF==8H_VSkBBqPZD1_OCPYjEz_1Q1n4y0Q@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Fri, 2014-11-14 at 21:25 -0700, Bjorn Helgaas wrote:
> [+cc Alex, add a subject]
> 
> On Fri, Nov 14, 2014 at 6:49 PM, Allan, Bruce W <bruce.w.allan@intel.com> wrote:
> > Let's try this again as plain text...
> >
> > For a PCIe device with SR-IOV support enabled (e.g. the PF device ID
> is 0xf001 at 0000:07:00.0 and the 16 VFs have device ID 0xf002 at
> 0000:07:01.0 through 0000:07:02.7), if the hardware attempts a DMA
> read/write of memory that was mapped by the PF devfn but instead uses
> a requester id of one of the VF devfns (enabled but not yet assigned
> to a VM) it fails and generates log messages similar to:
> >
> > [  416.800881] dmar: DRHD: handling fault status reg 2
> > [  416.800887] dmar: DMAR:[DMA Read] Request device [07:02.2] fault addr ffff0000
> > DMAR:[fault reason 02] Present bit in context entry is clear

This is exactly what IOMMU isolation is meant to do.  A buffer mapped
for one device should not be accessible from another device.  It really
doesn't matter if the devices are related as VF/PF, VF/VF, or PF/PF.

> > Shouldn't a DMA alias quirk that sets the
> PCI_DEV_FLAGS_DMA_ALIAS_DEVFN flag and dma_alias_devfn to the PF devfn
> for all VF devfns work-around this issue, or am I misunderstanding
> what a DMA alias quirk is supposed to do?  If a DMA alias quirk cannot
> resolve this, what is the most appropriate way to handle this?

The buffer needs to be mapped for each VF.  If for some reason the VF
needs implicit access to a PF mapped buffer then this devices is
completely broken from an isolation perspective and using DMA aliases to
fix it means that individual VFs will never be assignable to guests.
Thanks,

Alex

