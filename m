Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-oi0-f54.google.com ([209.85.218.54]:34283 "EHLO
	mail-oi0-f54.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750892AbbG2QHI (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Wed, 29 Jul 2015 12:07:08 -0400
Received: by oigi136 with SMTP id i136so7531304oig.1
        for <linux-pci@vger.kernel.org>; Wed, 29 Jul 2015 09:07:07 -0700 (PDT)
Date: Wed, 29 Jul 2015 11:07:01 -0500
From: Bjorn Helgaas <bhelgaas@google.com>
To: linux-pci@vger.kernel.org, Joerg Roedel <jroedel@suse.de>,
	David Woodhouse <dwmw2@infradead.org>
Cc: iommu@lists.linux-foundation.org,
	Gregor Dick <gdick@solarflare.com>
Subject: Re: [PATCH v2 00/11] PCI: Fix ATS deadlock
Message-ID: <20150729160701.GC31170@google.com>
References: <20150721001243.28145.81610.stgit@bhelgaas-glaptop2.roam.corp.google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20150721001243.28145.81610.stgit@bhelgaas-glaptop2.roam.corp.google.com>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Mon, Jul 20, 2015 at 07:13:49PM -0500, Bjorn Helgaas wrote:
> Gregor reported a deadlock [1] when enabling a VF that supports ATS.
> This series is intended to fix that.  The second patch should be enough to
> fix the deadlock; the rest are simplification and cleanup.
> 
> These are based on v4.2-rc2.
> 
> [1] http://permalink.gmane.org/gmane.linux.kernel.iommu/9433
> 
> Changes between v1 and v2:
>   - Remove use of pci_ats_enabled() (intel-iommu.c)
>   - Call pci_ats_queue_depth() only once per device and cache result
>     (intel-iommu.c)
>   - Remove pci_ats_enabled() interface
>   - Stop caching queue depth in pci_dev to save space
>   - Add PF refcount of how many associated VFs have ATS enabled
>   - Add comment that ATS must be enabled on PF before on VFs
>   - Require ATS to be disabled on all VFs and PF before changing STU
> 
> 
> ---
> 
> Bjorn Helgaas (11):
>       iommu/vt-d: Cache PCI ATS state and Invalidate Queue Depth
>       PCI: Allocate ATS struct during enumeration
>       PCI: Embed ATS info directly into struct pci_dev
>       PCI: Reduce size of ATS structure elements
>       PCI: Rationalize pci_ats_queue_depth() error checking
>       PCI: Inline the ATS setup code into pci_ats_init()
>       PCI: Use pci_physfn() rather than looking up physfn by hand
>       PCI: Clean up ATS error handling
>       PCI: Move ATS declarations to linux/pci.h so they're all together
>       PCI: Stop caching ATS Invalidate Queue Depth
>       PCI: Remove pci_ats_enabled()

I applied these to a pci/iommu branch for v4.3.  Let me know if you see any
issues.
