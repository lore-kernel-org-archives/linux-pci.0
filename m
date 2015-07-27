Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-ig0-f172.google.com ([209.85.213.172]:34028 "EHLO
	mail-ig0-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754401AbbG0Wy6 (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Mon, 27 Jul 2015 18:54:58 -0400
Received: by igk11 with SMTP id 11so83015150igk.1
        for <linux-pci@vger.kernel.org>; Mon, 27 Jul 2015 15:54:58 -0700 (PDT)
Date: Mon, 27 Jul 2015 17:54:53 -0500
From: Bjorn Helgaas <bhelgaas@google.com>
To: Joerg Roedel <jroedel@suse.de>
Cc: linux-pci@vger.kernel.org, David Woodhouse <dwmw2@infradead.org>,
	iommu@lists.linux-foundation.org,
	Gregor Dick <gdick@solarflare.com>
Subject: Re: [PATCH v2 01/11] iommu/vt-d: Cache PCI ATS state and Invalidate
 Queue Depth
Message-ID: <20150727225453.GB24401@google.com>
References: <20150721001243.28145.81610.stgit@bhelgaas-glaptop2.roam.corp.google.com>
 <20150721001357.28145.83631.stgit@bhelgaas-glaptop2.roam.corp.google.com>
 <20150727130810.GG27614@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20150727130810.GG27614@suse.de>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Hi Joerg,

Thanks for all your help reviewing this!

On Mon, Jul 27, 2015 at 03:08:10PM +0200, Joerg Roedel wrote:
> On Mon, Jul 20, 2015 at 07:13:57PM -0500, Bjorn Helgaas wrote:
> > We check the ATS state (enabled/disabled) and fetch the PCI ATS Invalidate
> > Queue Depth in performance-sensitive paths.  It's easy to cache these,
> > which removes dependencies on PCI.
> > 
> > Remember the ATS enabled state.  When enabling, read the queue depth once
> > and cache it in the device_domain_info struct.  This is similar to what
> > amd_iommu.c does.
> > 
> > Signed-off-by: Bjorn Helgaas <bhelgaas@google.com>
> > ---
> >  drivers/iommu/intel-iommu.c |   26 ++++++++++++++++----------
> >  1 file changed, 16 insertions(+), 10 deletions(-)
> > 
> > diff --git a/drivers/iommu/intel-iommu.c b/drivers/iommu/intel-iommu.c
> > index a98a7b2..50832f1 100644
> > --- a/drivers/iommu/intel-iommu.c
> > +++ b/drivers/iommu/intel-iommu.c
> > @@ -408,6 +408,10 @@ struct device_domain_info {
> >  	struct list_head global; /* link to global list */
> >  	u8 bus;			/* PCI bus number */
> >  	u8 devfn;		/* PCI devfn number */
> > +	struct {
> > +		int enabled:1;
> > +		u8 qdep;
> > +	} ats;			/* ATS state */
> >  	struct device *dev; /* it's NULL for PCIe-to-PCI bridge */
> >  	struct intel_iommu *iommu; /* IOMMU used by this device */
> >  	struct dmar_domain *domain; /* pointer to domain */
> > @@ -1391,19 +1395,26 @@ iommu_support_dev_iotlb (struct dmar_domain *domain, struct intel_iommu *iommu,
> >  
> >  static void iommu_enable_dev_iotlb(struct device_domain_info *info)
> >  {
> > +	struct pci_dev *pdev;
> > +
> >  	if (!info || !dev_is_pci(info->dev))
> >  		return;
> >  
> > -	pci_enable_ats(to_pci_dev(info->dev), VTD_PAGE_SHIFT);
> > +	pdev = to_pci_dev(info->dev);
> > +	if (pci_enable_ats(pdev, VTD_PAGE_SHIFT))
> > +		return;
> > +
> > +	info->ats.enabled = 1;
> > +	info->ats.qdep = pci_ats_queue_depth(pdev);
> 
> Hmm, this is a place where the relaxed error handling in
> pci_enable_ats() can get problematic. 

By "relaxed error handling," do you mean the fact that in v4.1,
pci_enable_ats() has a BUG_ON(is_enabled), while now it merely
returns -EINVAL?

(BTW, I did change it to add a WARN_ON and return -EBUSY as you suggested.)

> If ATS is (by accident or a bug
> elsewhere) already enabled an the function returns -EINVAL, the IOMMU
> driver considers ATS disabled and doesn't flush the IO/TLBs of the
> device. This can cause data corruption later on, so we should make sure
> that info->ats.enabled is consistent with pdev->ats_enabled.

I'm not quite sure I understand this.  In the patch above, we only set
"info->ats.enabled = 1" if pci_enable_ats() has succeeded.  The amd_iommu.c
code is similar.

Are you concerned about the case where future code enables ATS before
intel-iommu, the pci_enable_ats() in intel-iommu fails, intel-iommu
believes ATS is disabled, intel-iommu calls iommu_flush_dev_iotlb(), but it
doesn't flush the IOTLB?

I guess I could make intel-iommu handle -EBUSY differently from -EINVAL.
Would that help?  It seems sort of clumsy, but ...?

Bjorn
