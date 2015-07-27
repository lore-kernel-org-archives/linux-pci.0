Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mx2.suse.de ([195.135.220.15]:51702 "EHLO mx2.suse.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753626AbbG0NIO (ORCPT <rfc822;linux-pci@vger.kernel.org>);
	Mon, 27 Jul 2015 09:08:14 -0400
Date: Mon, 27 Jul 2015 15:08:10 +0200
From: Joerg Roedel <jroedel@suse.de>
To: Bjorn Helgaas <bhelgaas@google.com>
Cc: linux-pci@vger.kernel.org, David Woodhouse <dwmw2@infradead.org>,
	iommu@lists.linux-foundation.org,
	Gregor Dick <gdick@solarflare.com>
Subject: Re: [PATCH v2 01/11] iommu/vt-d: Cache PCI ATS state and Invalidate
 Queue Depth
Message-ID: <20150727130810.GG27614@suse.de>
References: <20150721001243.28145.81610.stgit@bhelgaas-glaptop2.roam.corp.google.com>
 <20150721001357.28145.83631.stgit@bhelgaas-glaptop2.roam.corp.google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20150721001357.28145.83631.stgit@bhelgaas-glaptop2.roam.corp.google.com>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Mon, Jul 20, 2015 at 07:13:57PM -0500, Bjorn Helgaas wrote:
> We check the ATS state (enabled/disabled) and fetch the PCI ATS Invalidate
> Queue Depth in performance-sensitive paths.  It's easy to cache these,
> which removes dependencies on PCI.
> 
> Remember the ATS enabled state.  When enabling, read the queue depth once
> and cache it in the device_domain_info struct.  This is similar to what
> amd_iommu.c does.
> 
> Signed-off-by: Bjorn Helgaas <bhelgaas@google.com>
> ---
>  drivers/iommu/intel-iommu.c |   26 ++++++++++++++++----------
>  1 file changed, 16 insertions(+), 10 deletions(-)
> 
> diff --git a/drivers/iommu/intel-iommu.c b/drivers/iommu/intel-iommu.c
> index a98a7b2..50832f1 100644
> --- a/drivers/iommu/intel-iommu.c
> +++ b/drivers/iommu/intel-iommu.c
> @@ -408,6 +408,10 @@ struct device_domain_info {
>  	struct list_head global; /* link to global list */
>  	u8 bus;			/* PCI bus number */
>  	u8 devfn;		/* PCI devfn number */
> +	struct {
> +		int enabled:1;
> +		u8 qdep;
> +	} ats;			/* ATS state */
>  	struct device *dev; /* it's NULL for PCIe-to-PCI bridge */
>  	struct intel_iommu *iommu; /* IOMMU used by this device */
>  	struct dmar_domain *domain; /* pointer to domain */
> @@ -1391,19 +1395,26 @@ iommu_support_dev_iotlb (struct dmar_domain *domain, struct intel_iommu *iommu,
>  
>  static void iommu_enable_dev_iotlb(struct device_domain_info *info)
>  {
> +	struct pci_dev *pdev;
> +
>  	if (!info || !dev_is_pci(info->dev))
>  		return;
>  
> -	pci_enable_ats(to_pci_dev(info->dev), VTD_PAGE_SHIFT);
> +	pdev = to_pci_dev(info->dev);
> +	if (pci_enable_ats(pdev, VTD_PAGE_SHIFT))
> +		return;
> +
> +	info->ats.enabled = 1;
> +	info->ats.qdep = pci_ats_queue_depth(pdev);

Hmm, this is a place where the relaxed error handling in
pci_enable_ats() can get problematic. If ATS is (by accident or a bug
elsewhere) already enabled an the function returns -EINVAL, the IOMMU
driver considers ATS disabled and doesn't flush the IO/TLBs of the
device. This can cause data corruption later on, so we should make sure
that info->ats.enabled is consistent with pdev->ats_enabled.


	Joerg

