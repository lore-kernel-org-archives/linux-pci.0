Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.99]:60974 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1033038AbdEWUdZ (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Tue, 23 May 2017 16:33:25 -0400
Date: Tue, 23 May 2017 15:33:22 -0500
From: Bjorn Helgaas <helgaas@kernel.org>
To: Ashok Raj <ashok.raj@intel.com>
Cc: Bjorn Helgaas <bhelgaas@google.com>,
        Joerg Roedel <joro@8bytes.org>, linux-pci@vger.kernel.org,
        CQ Tang <cq.tang@intel.com>,
        Jean-Phillipe Brucker <jean-philippe.brucker@arm.com>,
        David Woodhouse <dwmw2@infradead.org>,
        iommu@lists.linux-foundation.org
Subject: Re: [PATCH 1/2] PCI: Save properties required to handle FLR for
 replay purposes.
Message-ID: <20170523203322.GA15055@bhelgaas-glaptop.roam.corp.google.com>
References: <1494441543-8216-1-git-send-email-ashok.raj@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1494441543-8216-1-git-send-email-ashok.raj@intel.com>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Wed, May 10, 2017 at 11:39:02AM -0700, Ashok Raj wrote:
> From: CQ Tang <cq.tang@intel.com>
> 
> Requires: https://patchwork.kernel.org/patch/9593891

I'm not sure what the status of the patch above is.  I acked it, but it's
part of a 30-patch IOMMU series, so I expect it to be merged via an IOMMU
tree.

In any case, it's not in v4.12-rc1, so I can't apply *this* patch yet.

> After a FLR, pci-states need to be restored. This patch saves PASID features
> and PRI reqs cached.
> 
> Cc: Jean-Phillipe Brucker <jean-philippe.brucker@arm.com>
> Cc: David Woodhouse <dwmw2@infradead.org>
> Cc: iommu@lists.linux-foundation.org
> 
> Signed-off-by: CQ Tang <cq.tang@intel.com>
> Signed-off-by: Ashok Raj <ashok.raj@intel.com>
> ---
>  drivers/pci/ats.c       | 65 +++++++++++++++++++++++++++++++++++++------------
>  drivers/pci/pci.c       |  3 +++
>  include/linux/pci-ats.h | 10 ++++++++
>  include/linux/pci.h     |  6 +++++
>  4 files changed, 69 insertions(+), 15 deletions(-)
> 
> diff --git a/drivers/pci/ats.c b/drivers/pci/ats.c
> index 2126497..a769955 100644
> --- a/drivers/pci/ats.c
> +++ b/drivers/pci/ats.c
> @@ -160,17 +160,16 @@ int pci_enable_pri(struct pci_dev *pdev, u32 reqs)
>  	if (!pos)
>  		return -EINVAL;
>  
> -	pci_read_config_word(pdev, pos + PCI_PRI_CTRL, &control);
>  	pci_read_config_word(pdev, pos + PCI_PRI_STATUS, &status);
> -	if ((control & PCI_PRI_CTRL_ENABLE) ||
> -	    !(status & PCI_PRI_STATUS_STOPPED))
> +	if (!(status & PCI_PRI_STATUS_STOPPED))
>  		return -EBUSY;
>  
>  	pci_read_config_dword(pdev, pos + PCI_PRI_MAX_REQ, &max_requests);
>  	reqs = min(max_requests, reqs);
> +	pdev->pri_reqs_alloc = reqs;
>  	pci_write_config_dword(pdev, pos + PCI_PRI_ALLOC_REQ, reqs);
>  
> -	control |= PCI_PRI_CTRL_ENABLE;
> +	control = PCI_PRI_CTRL_ENABLE;
>  	pci_write_config_word(pdev, pos + PCI_PRI_CTRL, control);
>  
>  	pdev->pri_enabled = 1;
> @@ -206,6 +205,29 @@ void pci_disable_pri(struct pci_dev *pdev)
>  EXPORT_SYMBOL_GPL(pci_disable_pri);
>  
>  /**
> + * pci_restore_pri_state - Restore PRI
> + * @pdev: PCI device structure
> + *
> + */
> +void pci_restore_pri_state(struct pci_dev *pdev)
> +{
> +   u16 control = PCI_PRI_CTRL_ENABLE;
> +   u32 reqs = pdev->pri_reqs_alloc;
> +   int pos;
> +
> +   pos = pci_find_ext_capability(pdev, PCI_EXT_CAP_ID_PRI);
> +   if (!pos)
> +       return;
> +
> +   if (!pdev->pri_enabled)
> +       return;
> +
> +   pci_write_config_dword(pdev, pos + PCI_PRI_ALLOC_REQ, reqs);
> +   pci_write_config_word(pdev, pos + PCI_PRI_CTRL, control);
> +}
> +EXPORT_SYMBOL_GPL(pci_restore_pri_state);
> +
> +/**
>   * pci_reset_pri - Resets device's PRI state
>   * @pdev: PCI device structure
>   *
> @@ -224,12 +246,7 @@ int pci_reset_pri(struct pci_dev *pdev)
>  	if (!pos)
>  		return -EINVAL;
>  
> -	pci_read_config_word(pdev, pos + PCI_PRI_CTRL, &control);
> -	if (control & PCI_PRI_CTRL_ENABLE)
> -		return -EBUSY;
> -
> -	control |= PCI_PRI_CTRL_RESET;
> -
> +	control = PCI_PRI_CTRL_RESET;
>  	pci_write_config_word(pdev, pos + PCI_PRI_CTRL, control);
>  
>  	return 0;
> @@ -259,12 +276,7 @@ int pci_enable_pasid(struct pci_dev *pdev, int features)
>  	if (!pos)
>  		return -EINVAL;
>  
> -	pci_read_config_word(pdev, pos + PCI_PASID_CTRL, &control);
>  	pci_read_config_word(pdev, pos + PCI_PASID_CAP, &supported);
> -
> -	if (control & PCI_PASID_CTRL_ENABLE)
> -		return -EINVAL;
> -
>  	supported &= PCI_PASID_CAP_EXEC | PCI_PASID_CAP_PRIV;
>  
>  	/* User wants to enable anything unsupported? */
> @@ -272,6 +284,7 @@ int pci_enable_pasid(struct pci_dev *pdev, int features)
>  		return -EINVAL;
>  
>  	control = PCI_PASID_CTRL_ENABLE | features;
> +	pdev->pasid_features = features;
>  
>  	pci_write_config_word(pdev, pos + PCI_PASID_CTRL, control);
>  
> @@ -305,6 +318,28 @@ void pci_disable_pasid(struct pci_dev *pdev)
>  EXPORT_SYMBOL_GPL(pci_disable_pasid);
>  
>  /**
> + * pci_restore_pasid_state - Restore PASID capabilities.
> + * @pdev: PCI device structure
> + *
> + */
> +void pci_restore_pasid_state(struct pci_dev *pdev)
> +{
> +   u16 control;
> +   int pos;
> +
> +   pos = pci_find_ext_capability(pdev, PCI_EXT_CAP_ID_PASID);
> +   if (!pos)
> +       return;
> +
> +   if (!pdev->pasid_enabled)
> +       return;
> +
> +   control = PCI_PASID_CTRL_ENABLE | pdev->pasid_features;
> +   pci_write_config_word(pdev, pos + PCI_PASID_CTRL, control);
> +}
> +EXPORT_SYMBOL_GPL(pci_restore_pasid_state);
> +
> +/**
>   * pci_pasid_features - Check which PASID features are supported
>   * @pdev: PCI device structure
>   *
> diff --git a/drivers/pci/pci.c b/drivers/pci/pci.c
> index 7904d02..c9a6510 100644
> --- a/drivers/pci/pci.c
> +++ b/drivers/pci/pci.c
> @@ -28,6 +28,7 @@
>  #include <linux/pm_runtime.h>
>  #include <linux/pci_hotplug.h>
>  #include <linux/vmalloc.h>
> +#include <linux/pci-ats.h>
>  #include <asm/setup.h>
>  #include <asm/dma.h>
>  #include <linux/aer.h>
> @@ -1171,6 +1172,8 @@ void pci_restore_state(struct pci_dev *dev)
>  
>  	/* PCI Express register must be restored first */
>  	pci_restore_pcie_state(dev);
> +	pci_restore_pasid_state(dev);
> +	pci_restore_pri_state(dev);
>  	pci_restore_ats_state(dev);
>  	pci_restore_vc_state(dev);
>  
> diff --git a/include/linux/pci-ats.h b/include/linux/pci-ats.h
> index 57e0b82..782fb8e 100644
> --- a/include/linux/pci-ats.h
> +++ b/include/linux/pci-ats.h
> @@ -7,6 +7,7 @@
>  
>  int pci_enable_pri(struct pci_dev *pdev, u32 reqs);
>  void pci_disable_pri(struct pci_dev *pdev);
> +void pci_restore_pri_state(struct pci_dev *pdev);
>  int pci_reset_pri(struct pci_dev *pdev);
>  
>  #else /* CONFIG_PCI_PRI */
> @@ -20,6 +21,10 @@ static inline void pci_disable_pri(struct pci_dev *pdev)
>  {
>  }
>  
> +static inline void pci_restore_pri_state(struct pci_dev *pdev)
> +{
> +}
> +
>  static inline int pci_reset_pri(struct pci_dev *pdev)
>  {
>  	return -ENODEV;
> @@ -31,6 +36,7 @@ static inline int pci_reset_pri(struct pci_dev *pdev)
>  
>  int pci_enable_pasid(struct pci_dev *pdev, int features);
>  void pci_disable_pasid(struct pci_dev *pdev);
> +void pci_restore_pasid_state(struct pci_dev *pdev);
>  int pci_pasid_features(struct pci_dev *pdev);
>  int pci_max_pasids(struct pci_dev *pdev);
>  
> @@ -45,6 +51,10 @@ static inline void pci_disable_pasid(struct pci_dev *pdev)
>  {
>  }
>  
> +static inline void pci_restore_pasid_state(struct pci_dev *pdev)
> +{
> +}
> +
>  static inline int pci_pasid_features(struct pci_dev *pdev)
>  {
>  	return -EINVAL;
> diff --git a/include/linux/pci.h b/include/linux/pci.h
> index bee980e..1ddb8e0 100644
> --- a/include/linux/pci.h
> +++ b/include/linux/pci.h
> @@ -395,6 +395,12 @@ struct pci_dev {
>  	u8		ats_stu;	/* ATS Smallest Translation Unit */
>  	atomic_t	ats_ref_cnt;	/* number of VFs with ATS enabled */
>  #endif
> +#ifdef CONFIG_PCI_PRI
> +	u32		pri_reqs_alloc; /* Number of PRI requests allocated */
> +#endif
> +#ifdef CONFIG_PCI_PASID
> +	u16		pasid_features;
> +#endif
>  	phys_addr_t rom; /* Physical address of ROM if it's not from the BAR */
>  	size_t romlen; /* Length of ROM if it's not from the BAR */
>  	char *driver_override; /* Driver name to force a match */
> -- 
> 2.7.4
> 
