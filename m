Return-Path: <linux-kernel-owner@vger.kernel.org>
Date: Mon, 8 Jun 2015 17:29:58 +0200
From: Joerg Roedel <joro@8bytes.org>
To: David Woodhouse <dwmw2@infradead.org>
Cc: "Li, Zhen-Hua" <zhen-hual@hp.com>, indou.takao@jp.fujitsu.com,
	bhe@redhat.com, vgoyal@redhat.com, dyoung@redhat.com,
	iommu@lists.linux-foundation.org, linux-kernel@vger.kernel.org,
	linux-pci@vger.kernel.org, kexec@lists.infradead.org,
	alex.williamson@redhat.com, ddutile@redhat.com,
	ishii.hironobu@jp.fujitsu.com, bhelgaas@google.com,
	doug.hatch@hp.com, jerry.hoemann@hp.com, tom.vaden@hp.com,
	li.zhang6@hp.com, lisa.mitchell@hp.com, billsumnerlinux@gmail.com,
	rwright@hp.com
Subject: Re: [PATCH v11 0/10] iommu/vt-d: Fix intel vt-d faults in kdump
 kernel
Message-ID: <20150608152957.GW20384@8bytes.org>
References: <1431337974-545-1-git-send-email-zhen-hual@hp.com>
 <1433773583.2952.52.camel@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1433773583.2952.52.camel@infradead.org>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Mon, Jun 08, 2015 at 03:26:23PM +0100, David Woodhouse wrote:
> There are some interesting corner cases to handle here.
> 
> Firstly, you don't seem to handle the case of extended root/context
> tables (where ecap_ecs is set). You need to preserve the DMA_RTADDR_RT
> bit in the Root Table Address register, surely?
> 
> I think we also need to cope with inheriting page tables from a kernel
> that *doesn't* use extended page tables, even on hardware that supports
> it. Which means the use of extended page tables in the new kernel would
> need to be contingent on something *other* than the pure hardware
> capabilities.

Hmm, I also limited this functionality to kdump kernels. Do we still
need to preserve these extended data structures even when there is no
upstream support for them yet?

> > 5. Keep using the old page tables before driver is loaded.
> > 6. After device driver is loaded, when it issues the first dma_map command, 
> >    free the dmar_domain structure for this device, and generate a new one, so 
> >    that the device can be assigned a new and empty page table. 
> 
> What if there were RMRRs for this device? Don't we need to ensure that
> those are present in the "new and empty page table" when we take it
> over?

That is still a problem, but not specific to this patch-set. RMRRs will
not be restored, because domains allocated out of the DMA-API path will
not get any RMRR mappings. This is also a problem with device hotplug
(unplug a device with RMRRs and replug it in and the RMRR mappings will
 be gone).

I agree that this needs to be fixed.


	Joerg

