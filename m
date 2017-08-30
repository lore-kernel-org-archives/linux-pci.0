Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.99]:41234 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1750761AbdH3Vpn (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Wed, 30 Aug 2017 17:45:43 -0400
Date: Wed, 30 Aug 2017 16:45:41 -0500
From: Bjorn Helgaas <helgaas@kernel.org>
To: Jon Derrick <jonathan.derrick@intel.com>
Cc: iommu@lists.linux-foundation.org, linux-pci@vger.kernel.org,
        Keith Busch <keith.busch@intel.com>
Subject: Re: [PATCH v3] iommu: Prevent VMD child devices from being remapping
 targets
Message-ID: <20170830214541.GZ8154@bhelgaas-glaptop.roam.corp.google.com>
References: <1504127159-186529-1-git-send-email-jonathan.derrick@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1504127159-186529-1-git-send-email-jonathan.derrick@intel.com>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Wed, Aug 30, 2017 at 03:05:59PM -0600, Jon Derrick wrote:
> VMD child devices must use the VMD endpoint's ID as the requester.
> Because of this, there needs to be a way to link the parent VMD
> endpoint's iommu group and associated mappings to the VMD child devices
> such that attaching and detaching child devices modify the endpoint's
> mappings, while preventing early detaching on a singular device removal
> or unbinding.
> 
> The reassignment of individual VMD child devices devices to VMs is
> outside the scope of VMD, but may be implemented in the future. For now
> it is best to prevent any such attempts.
> 
> This patch prevents VMD child devices from returning an IOMMU, which
> prevents it from exposing an iommu_group sysfs directories and allowing
> subsequent binding by userspace-access drivers such as VFIO.
> 
> Signed-off-by: Jon Derrick <jonathan.derrick@intel.com>

Applied to pci/host-vmd for v4.14, thanks!

> ---
> v2->3, wrapped in x86 ifdef to avoid ia64 compilation errors
> 
>  drivers/iommu/intel-iommu.c | 7 +++++++
>  1 file changed, 7 insertions(+)
> 
> diff --git a/drivers/iommu/intel-iommu.c b/drivers/iommu/intel-iommu.c
> index 687f18f..2800a6e 100644
> --- a/drivers/iommu/intel-iommu.c
> +++ b/drivers/iommu/intel-iommu.c
> @@ -901,6 +901,13 @@ static struct intel_iommu *device_to_iommu(struct device *dev, u8 *bus, u8 *devf
>  		struct pci_dev *pf_pdev;
>  
>  		pdev = to_pci_dev(dev);
> +
> +#ifdef CONFIG_X86
> +		/* VMD child devices currently cannot be handled individually */
> +		if (is_vmd(pdev->bus))
> +			return NULL;
> +#endif
> +
>  		/* VFs aren't listed in scope tables; we need to look up
>  		 * the PF instead to find the IOMMU. */
>  		pf_pdev = pci_physfn(pdev);
> -- 
> 1.8.3.1
> 
