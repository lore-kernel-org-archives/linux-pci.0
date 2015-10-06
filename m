Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from 8bytes.org ([81.169.241.247]:35462 "EHLO theia.8bytes.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751611AbbJFKTz (ORCPT <rfc822;linux-pci@vger.kernel.org>);
	Tue, 6 Oct 2015 06:19:55 -0400
Date: Tue, 6 Oct 2015 12:19:52 +0200
From: Joerg Roedel <joro@8bytes.org>
To: Gerald Schaefer <gerald.schaefer@de.ibm.com>
Cc: iommu@lists.linux-foundation.org, linux-pci@vger.kernel.org,
	linux-kernel@vger.kernel.org, kvm@vger.kernel.org,
	Sebastian Ott <sebott@linux.vnet.ibm.com>,
	Martin Schwidefsky <schwidefsky@de.ibm.com>
Subject: Re: [PATCH] iommu/s390: add iommu api for s390 pci devices
Message-ID: <20151006101952.GA20886@8bytes.org>
References: <1440682383-27688-1-git-send-email-gerald.schaefer@de.ibm.com>
 <20150929124030.GI3036@8bytes.org>
 <20151001193028.73e48f7e@thinkpad>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20151001193028.73e48f7e@thinkpad>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Thu, Oct 01, 2015 at 07:30:28PM +0200, Gerald Schaefer wrote:
> Yes, the DMA API is already implemented in arch/s390/pci/pci_dma.c.
> I thought about moving it over to the new location in drivers/iommu/,
> but I don't see any benefit from it.

Okay, this is true for now. At some point we hopefully have a common
DMA-API implementation for all IOMMU driver, at which point s390 can
make use of it too and abandon its own implementation.

> Also, the two APIs are quite different on s390 and must not be mixed-up.
> For example, we have optimizations in the DMA API to reduce TLB flushes
> based on iommu bitmap wrap-around, which is not possible for the map/unmap
> logic in the IOMMU API. There is also the requirement that each device has
> its own DMA page table (not shared), which is important for DMA API device
> recovery and map/unmap on s390.

This sounds quite similar to what other IOMMU drivers also implement,
especially the AMD IOMMU driver. It also uses non-shared page-tables for
devices and implements the bitmap-allocator optimization.

> Hmm, not sure how this can replace my own struct. I need the struct to
> maintain a list of all devices that share a dma page table. And the
> devices need to be added and removed to/from that list in attach/detach_dev.
> 
> I also need that list during map/unmap, in order to do a TLB flush for
> all affected devices, and this happens under a spin lock.
> 
> So I guess I cannot use the iommu_group->devices list, which is managed
> in add/remove_device and under a mutex, if that was on your mind.

Yeah, right. Thanks for the explanation.


	Joerg

