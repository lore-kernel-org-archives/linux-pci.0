Return-Path: <linux-kernel-owner@vger.kernel.org>
Date: Thu, 1 Oct 2015 19:30:28 +0200
From: Gerald Schaefer <gerald.schaefer@de.ibm.com>
To: Joerg Roedel <joro@8bytes.org>
Cc: iommu@lists.linux-foundation.org, linux-pci@vger.kernel.org,
	linux-kernel@vger.kernel.org, kvm@vger.kernel.org,
	Sebastian Ott <sebott@linux.vnet.ibm.com>,
	Martin Schwidefsky <schwidefsky@de.ibm.com>
Subject: Re: [PATCH] iommu/s390: add iommu api for s390 pci devices
Message-ID: <20151001193028.73e48f7e@thinkpad>
In-Reply-To: <20150929124030.GI3036@8bytes.org>
References: <1440682383-27688-1-git-send-email-gerald.schaefer@de.ibm.com>
	<20150929124030.GI3036@8bytes.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Tue, 29 Sep 2015 14:40:30 +0200
Joerg Roedel <joro@8bytes.org> wrote:

> Hi Gerald,
> 
> thanks for your patch. It looks pretty good and addresses my previous
> review comments. I have a few questions, first one is how this
> operates with DMA-API on s390. Is there a seperate DMA-API
> implementation besides the IOMMU-API one for PCI devices?

Yes, the DMA API is already implemented in arch/s390/pci/pci_dma.c.
I thought about moving it over to the new location in drivers/iommu/,
but I don't see any benefit from it.

Also, the two APIs are quite different on s390 and must not be mixed-up.
For example, we have optimizations in the DMA API to reduce TLB flushes
based on iommu bitmap wrap-around, which is not possible for the map/unmap
logic in the IOMMU API. There is also the requirement that each device has
its own DMA page table (not shared), which is important for DMA API device
recovery and map/unmap on s390.

> 
> My other question is inline:
> 
> On Thu, Aug 27, 2015 at 03:33:03PM +0200, Gerald Schaefer wrote:
> > +struct s390_domain_device {
> > +	struct list_head	list;
> > +	struct zpci_dev		*zdev;
> > +};
> 
> Instead of using your own struct here, have you considered using the
> struct iommu_group instead? The struct devices contains a pointer to an
> iommu_group and the struct itself contains pointers to the domain it is
> currently bound to.

Hmm, not sure how this can replace my own struct. I need the struct to
maintain a list of all devices that share a dma page table. And the
devices need to be added and removed to/from that list in attach/detach_dev.

I also need that list during map/unmap, in order to do a TLB flush for
all affected devices, and this happens under a spin lock.

So I guess I cannot use the iommu_group->devices list, which is managed
in add/remove_device and under a mutex, if that was on your mind.

Regards,
Gerald

