Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.99]:58268 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1750746AbeEJXJv (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Thu, 10 May 2018 19:09:51 -0400
Date: Thu, 10 May 2018 18:09:48 -0500
From: Bjorn Helgaas <helgaas@kernel.org>
To: Gil Kupfer <gilkup@gmail.com>
Cc: joro@8bytes.org, dwmw2@infradead.org, bhelgaas@google.com,
        iommu@lists.linux-foundation.org, linux-pci@vger.kernel.org,
        linux-kernel@vger.kernel.org, nadav.amit@gmail.com,
        Gil Kupfer <gilkup@cs.technion.ac.il>
Subject: Re: [RFC/RFT] Add noats flag to boot parameters
Message-ID: <20180510230948.GF190385@bhelgaas-glaptop.roam.corp.google.com>
References: <1525025808-2365-1-git-send-email-gilkup@cs.technion.ac.il>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1525025808-2365-1-git-send-email-gilkup@cs.technion.ac.il>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Sun, Apr 29, 2018 at 09:16:48PM +0300, Gil Kupfer wrote:
> This patch adds noats option to the pci boot parameter.
> When noats is selected, all ATS related functions fail immediately and
> the IOMMU is configured to not use device-iotlb.
> 
> Any function that checks for ATS capabilities directly against the
> devices should also check this flag. (Currently, such functions exist
> only in IOMMU drivers, and they are covered by this patch.)
> 
> The motivation behind this patch is the existence of malicious devices.
> Lots of research has been done about how to utilitize the IOMMU as a
> protection from such devices. When ATS is supported, any I/O device can
> access any physical access by faking device-IOTLB entries.
> Adding the ability to ignore these entries lets sysadmins enhance system
> security.
> 
> Signed-off-by: Gil Kupfer <gilkup@cs.technion.ac.il>

Applied with Joerg's ack to pci/virtualization for v4.18, thanks!

> ---
> This patch is intended to add the ability to disable ATS at boot time.
> 
> My IOMMU has the ATS ecap but I don't have any PCI device that supports
> ATS so I can't fully test it. However, I did ran it (with and without the
> new boot flag) on QEMU with virtualized IOMMU with the device-iotlb flag
> and it seems that at least the machine does not crush.
> 
> QEMU version:
> 	master branch from Jul 11 2017
> 	commit aa916e409c04 ("Merge 29741be b876804")
> ---
>  Documentation/admin-guide/kernel-parameters.txt |  2 ++
>  drivers/iommu/amd_iommu.c                       | 11 ++++++++---
>  drivers/iommu/intel-iommu.c                     |  3 ++-
>  drivers/pci/ats.c                               |  3 +++
>  drivers/pci/pci.c                               |  7 +++++++
>  include/linux/pci.h                             |  2 ++
>  6 files changed, 24 insertions(+), 4 deletions(-)
> 
> diff --git a/Documentation/admin-guide/kernel-parameters.txt b/Documentation/admin-guide/kernel-parameters.txt
> index 7737ab5..f443362 100644
> --- a/Documentation/admin-guide/kernel-parameters.txt
> +++ b/Documentation/admin-guide/kernel-parameters.txt
> @@ -3000,6 +3000,8 @@
>  		pcie_scan_all	Scan all possible PCIe devices.  Otherwise we
>  				only look for one device below a PCIe downstream
>  				port.
> +		noats		[PCIE, Intel-IOMMU, AMD-IOMMU]
> +				do not use PCIe ATS (and IOMMU device-iotlb).
>  
>  	pcie_aspm=	[PCIE] Forcibly enable or disable PCIe Active State Power
>  			Management.
> diff --git a/drivers/iommu/amd_iommu.c b/drivers/iommu/amd_iommu.c
> index 0f1219f..2aa757e 100644
> --- a/drivers/iommu/amd_iommu.c
> +++ b/drivers/iommu/amd_iommu.c
> @@ -388,6 +388,9 @@ static bool pci_iommuv2_capable(struct pci_dev *pdev)
>  	};
>  	int i, pos;
>  
> +	if (is_pcie_ats_disabled())
> +		return false;
> +
>  	for (i = 0; i < 3; ++i) {
>  		pos = pci_find_ext_capability(pdev, caps[i]);
>  		if (pos == 0)
> @@ -3602,9 +3605,11 @@ int amd_iommu_device_info(struct pci_dev *pdev,
>  
>  	memset(info, 0, sizeof(*info));
>  
> -	pos = pci_find_ext_capability(pdev, PCI_EXT_CAP_ID_ATS);
> -	if (pos)
> -		info->flags |= AMD_IOMMU_DEVICE_FLAG_ATS_SUP;
> +	if (!is_pcie_ats_disabled()) {
> +		pos = pci_find_ext_capability(pdev, PCI_EXT_CAP_ID_ATS);
> +		if (pos)
> +			info->flags |= AMD_IOMMU_DEVICE_FLAG_ATS_SUP;
> +	}
>  
>  	pos = pci_find_ext_capability(pdev, PCI_EXT_CAP_ID_PRI);
>  	if (pos)
> diff --git a/drivers/iommu/intel-iommu.c b/drivers/iommu/intel-iommu.c
> index fc2765c..7ac4adc 100644
> --- a/drivers/iommu/intel-iommu.c
> +++ b/drivers/iommu/intel-iommu.c
> @@ -2434,7 +2434,8 @@ static struct dmar_domain *dmar_insert_one_dev_info(struct intel_iommu *iommu,
>  	if (dev && dev_is_pci(dev)) {
>  		struct pci_dev *pdev = to_pci_dev(info->dev);
>  
> -		if (ecap_dev_iotlb_support(iommu->ecap) &&
> +		if (!is_pcie_ats_disabled() &&
> +		    ecap_dev_iotlb_support(iommu->ecap) &&
>  		    pci_find_ext_capability(pdev, PCI_EXT_CAP_ID_ATS) &&
>  		    dmar_find_matched_atsr_unit(pdev))
>  			info->ats_supported = 1;
> diff --git a/drivers/pci/ats.c b/drivers/pci/ats.c
> index eeb9fb2..619024d 100644
> --- a/drivers/pci/ats.c
> +++ b/drivers/pci/ats.c
> @@ -21,6 +21,9 @@ void pci_ats_init(struct pci_dev *dev)
>  {
>  	int pos;
>  
> +	if (is_pcie_ats_disabled())
> +		return;
> +
>  	pos = pci_find_ext_capability(dev, PCI_EXT_CAP_ID_ATS);
>  	if (!pos)
>  		return;
> diff --git a/drivers/pci/pci.c b/drivers/pci/pci.c
> index 563901c..eb77590 100644
> --- a/drivers/pci/pci.c
> +++ b/drivers/pci/pci.c
> @@ -109,6 +109,10 @@ unsigned int pcibios_max_latency = 255;
>  /* If set, the PCIe ARI capability will not be used. */
>  static bool pcie_ari_disabled;
>  
> +/* If set, the PCIe ATS capability will not be used. */
> +static bool pcie_ats_disabled;
> +bool is_pcie_ats_disabled(void) { return pcie_ats_disabled; }
> +
>  /* Disable bridge_d3 for all PCIe ports */
>  static bool pci_bridge_d3_disable;
>  /* Force bridge_d3 for all PCIe ports */
> @@ -5430,6 +5434,9 @@ static int __init pci_setup(char *str)
>  		if (*str && (str = pcibios_setup(str)) && *str) {
>  			if (!strcmp(str, "nomsi")) {
>  				pci_no_msi();
> +			} else if (!strncmp(str, "noats", 5)) {
> +				pr_info("PCIe: ATS is disabled\n");
> +				pcie_ats_disabled = true;
>  			} else if (!strcmp(str, "noaer")) {
>  				pci_no_aer();
>  			} else if (!strncmp(str, "realloc=", 8)) {
> diff --git a/include/linux/pci.h b/include/linux/pci.h
> index 8039f9f..58fe5fb 100644
> --- a/include/linux/pci.h
> +++ b/include/linux/pci.h
> @@ -1420,6 +1420,8 @@ int  ht_create_irq(struct pci_dev *dev, int idx);
>  void ht_destroy_irq(unsigned int irq);
>  #endif /* CONFIG_HT_IRQ */
>  
> +bool is_pcie_ats_disabled(void);
> +
>  #ifdef CONFIG_PCI_ATS
>  /* Address Translation Service */
>  void pci_ats_init(struct pci_dev *dev);
> -- 
> 2.7.4
> 
