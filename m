Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from gate.crashing.org ([63.228.1.57]:51917 "EHLO gate.crashing.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751807AbbBRVWE (ORCPT <rfc822;linux-pci@vger.kernel.org>);
	Wed, 18 Feb 2015 16:22:04 -0500
Message-ID: <1424293393.26254.19.camel@kernel.crashing.org>
Subject: Re: [PATCH RESEND v2 7/7] PCI/hotplug: PowerPC PowerNV PCI hotplug
 driver
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Bjorn Helgaas <bhelgaas@google.com>
Cc: Gavin Shan <gwshan@linux.vnet.ibm.com>, linuxppc-dev@ozlabs.org,
	"linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
	linux-mm@kvack.org,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Date: Thu, 19 Feb 2015 08:03:13 +1100
In-Reply-To: <CAErSpo6vMyy2SoqZ4ca2D_BUxd3J4W5jASsQu0NM9opFzR5mfg@mail.gmail.com>
References: <1424157203-691-1-git-send-email-gwshan@linux.vnet.ibm.com>
	 <1424157203-691-8-git-send-email-gwshan@linux.vnet.ibm.com>
	 <20150217220916.GA26424@google.com> <20150218001620.GA22042@shangw>
	 <1424219432.21410.113.camel@kernel.crashing.org>
	 <CAErSpo6vMyy2SoqZ4ca2D_BUxd3J4W5jASsQu0NM9opFzR5mfg@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Wed, 2015-02-18 at 08:30 -0600, Bjorn Helgaas wrote:
> 
> So the hypervisor call that removes the device from the partition will
> fail if there are any translations that reference the memory of the
> device.
> 
> Let me go through this in excruciating detail to see if I understand
> what's going on:
> 
>   - PCI core enumerates device D1
>   - PCI core sets device D1 BAR 0 = 0x1000
>   - driver claims D1
>   - driver ioremaps 0x1000 at virtual address V
>   - translation V -> 0x1000 is in TLB
>   - driver iounmaps V (but V -> 0x1000 translation may remain in TLB)
>   - driver releases D1
>   - hot-remove D1 (without vm_unmap_aliases(), hypervisor would fail
> this)
>   - it would be a bug to reference V here, but if we did, the
> virt-to-phys translation would succeed and we'd have a Master Abort or
> Unsupported Request on PCI/PCIe
>   - hot-add D2
>   - PCI core enumerates device D2
>   - PCI core sets device D2 BAR 0 = 0x1000
>   - it would be a bug to reference V here (before ioremapping), but if
> we did, the reference would reach D2
> 
> I don't see anything hypervisor-specific here except for the fact that
> the hypervisor checks for existing translations and most other
> platforms don't.  But it seems like the unexpected PCI aborts could
> happen on any platform.

Well, only if we incorrectly dereferenced an ioremap'ed address for
which the driver who owns it is long gone so fairly unlikely. I'm not
saying you shouldn't put the vm_unmap_aliases() in the generic unplug
code, I wouldn't mind that, but I don't think we have a nasty bug to
squash here :)

> Are we saying that those PCI aborts are OK, since it's a bug to make
> those references in the first place?  Or would we rather take a TLB
> miss fault instead so the references never make it to PCI?

I think a miss fault which is basically a page fault -> oops is
preferable for debugging (after all that MMIO might hvae been reassigned
to another device, so that abort might actually instead turn into
writing to the wrong device... bad).

However I also think the scenario is very unlikely.

> I would think there would be similar issues when unmapping and
> re-mapping plain old physical memory.  But I don't see
> vm_unmap_aliases() calls there, so those issues must be handled
> differently.  Should we handle this PCI hotplug issue the same way we
> handle RAM?

If we don't have a vm_unmap_aliases() in the memory unplug path we
probably have a bug on those HVs too :-)

Cheers,
Ben.


