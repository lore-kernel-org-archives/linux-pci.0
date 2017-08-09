Return-Path: <SRS0=/PPU=7N=intel.com=jonathan.derrick@kernel.org>
Return-Path: <SRS0=/PPU=7N=intel.com=jonathan.derrick@kernel.org>
Subject: Re: [PATCH 3/3] iommu: prevent VMD child devices from being remapping
 targets
To: Robin Murphy <robin.murphy@arm.com>, linux-pci@vger.kernel.org,
 iommu@lists.linux-foundation.org
Cc: linux-kernel@vger.kernel.org, Keith Busch <keith.busch@intel.com>,
 Bjorn Helgaas <helgaas@kernel.org>, David Fugate <david.fugate@intel.com>,
 David Woodhouse <dwmw2@infradead.org>, Scott Bauer <scott.bauer@intel.com>
References: <20170807195713.10963-1-jonathan.derrick@intel.com>
 <20170807195713.10963-3-jonathan.derrick@intel.com>
 <fda8e2c5-11da-7189-794c-59a68273e4d8@arm.com>
From: Jon Derrick <jonathan.derrick@intel.com>
Message-ID: <e1ead7c8-0891-f1b2-e5b0-d601d1af80e0@intel.com>
Date: Wed, 9 Aug 2017 11:13:30 -0600
MIME-Version: 1.0
In-Reply-To: <fda8e2c5-11da-7189-794c-59a68273e4d8@arm.com>
Content-Type: text/plain; charset=utf-8
List-ID: <linux-pci.vger.kernel.org>

Hi Robin, thanks for the reply.

On 08/11/2017 12:25 PM, Robin Murphy wrote:
> On 07/08/17 20:57, Jon Derrick wrote:
>> VMD child devices must use the VMD endpoint's ID as the DMA source.
>> Because of this, there needs to be a way to link the parent VMD
>> endpoint's DMAR domain to the VMD child devices' DMAR domain such that
>> attaching and detaching child devices modify the endpoint's DMAR mapping
>> and prevents early detaching.
> > That sounds like either pci_device_group() needs modifying, or perhaps
> that intel-iommu needs its own extended iommu_ops::device_group
> implementation, to ensure that VMD child devices get put in the same
> group as their parent - if they share requester IDs they can't feasibly
> be attached to different domains anyway.
> 
> Robin.
Yes it seems like that to me too. I have a high-level understanding of
the changes required but not too much in the nitty-gritty details. It's
a bit more complicated anyways because VMD emerges a set of root ports,
and AFAICT, PCI ACS end at the root ports and iommu groups rely on ACS
to group devices. Either way it's not within the scope of VMD.
