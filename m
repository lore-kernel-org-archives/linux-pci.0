Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mx2.suse.de ([195.135.220.15]:45717 "EHLO mx2.suse.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754745AbbG1HOW (ORCPT <rfc822;linux-pci@vger.kernel.org>);
	Tue, 28 Jul 2015 03:14:22 -0400
Date: Tue, 28 Jul 2015 09:14:18 +0200
From: Joerg Roedel <jroedel@suse.de>
To: Bjorn Helgaas <bhelgaas@google.com>
Cc: linux-pci@vger.kernel.org, David Woodhouse <dwmw2@infradead.org>,
	iommu@lists.linux-foundation.org,
	Gregor Dick <gdick@solarflare.com>
Subject: Re: [PATCH v2 01/11] iommu/vt-d: Cache PCI ATS state and Invalidate
 Queue Depth
Message-ID: <20150728071417.GK27614@suse.de>
References: <20150721001243.28145.81610.stgit@bhelgaas-glaptop2.roam.corp.google.com>
 <20150721001357.28145.83631.stgit@bhelgaas-glaptop2.roam.corp.google.com>
 <20150727130810.GG27614@suse.de>
 <20150727225453.GB24401@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20150727225453.GB24401@google.com>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Hi Bjorn,

On Mon, Jul 27, 2015 at 05:54:53PM -0500, Bjorn Helgaas wrote:
> > Hmm, this is a place where the relaxed error handling in
> > pci_enable_ats() can get problematic. 
> 
> By "relaxed error handling," do you mean the fact that in v4.1,
> pci_enable_ats() has a BUG_ON(is_enabled), while now it merely
> returns -EINVAL?
> 
> (BTW, I did change it to add a WARN_ON and return -EBUSY as you suggested.)

Okay, great.

> > If ATS is (by accident or a bug
> > elsewhere) already enabled an the function returns -EINVAL, the IOMMU
> > driver considers ATS disabled and doesn't flush the IO/TLBs of the
> > device. This can cause data corruption later on, so we should make sure
> > that info->ats.enabled is consistent with pdev->ats_enabled.
> 
> I'm not quite sure I understand this.  In the patch above, we only set
> "info->ats.enabled = 1" if pci_enable_ats() has succeeded.  The amd_iommu.c
> code is similar.
> 
> Are you concerned about the case where future code enables ATS before
> intel-iommu, the pci_enable_ats() in intel-iommu fails, intel-iommu
> believes ATS is disabled, intel-iommu calls iommu_flush_dev_iotlb(), but it
> doesn't flush the IOTLB?
> 
> I guess I could make intel-iommu handle -EBUSY differently from -EINVAL.
> Would that help?  It seems sort of clumsy, but ...?

I was concerned that it was harder now to spot bugs in ATS
enabling/disabling, when pci_enable_ats just returns -EINVAL when ATS is
already enabled.

But with the WARN_ON now we will notice these bugs early again, thanks
for adding it.



	Joerg

