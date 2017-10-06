Return-Path: <linux-arm-kernel-bounces+bjorn=helgaas.com@lists.infradead.org>
Return-Path: <linux-arm-kernel-bounces+bjorn=helgaas.com@lists.infradead.org>
Date: Fri, 6 Oct 2017 13:11:38 -0500
From: Bjorn Helgaas <helgaas@kernel.org>
To: Jean-Philippe Brucker <jean-philippe.brucker@arm.com>
Subject: Re: [RFCv2 PATCH 34/36] PCI: Make "PRG Response PASID Required"
 handling common
Message-ID: <20171006181138.GD25517@bhelgaas-glaptop.roam.corp.google.com>
References: <20171006133203.22803-1-jean-philippe.brucker@arm.com>
 <20171006133203.22803-35-jean-philippe.brucker@arm.com>
MIME-Version: 1.0
In-Reply-To: <20171006133203.22803-35-jean-philippe.brucker@arm.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Cc: mark.rutland@arm.com, xieyisheng1@huawei.com, gabriele.paoloni@huawei.com,
 linux-pci@vger.kernel.org, will.deacon@arm.com, okaya@codeaurora.org,
 yi.l.liu@intel.com, lorenzo.pieralisi@arm.com, ashok.raj@intel.com,
 tn@semihalf.com, joro@8bytes.org, robdclark@gmail.com,
 linux-acpi@vger.kernel.org, catalin.marinas@arm.com, rfranz@cavium.com,
 lenb@kernel.org, devicetree@vger.kernel.org, jacob.jun.pan@linux.intel.com,
 alex.williamson@redhat.com, robh+dt@kernel.org, thunder.leizhen@huawei.com,
 bhelgaas@google.com, linux-arm-kernel@lists.infradead.org, dwmw2@infradead.org,
 liubo95@huawei.com, rjw@rjwysocki.net, iommu@lists.linux-foundation.org,
 hanjun.guo@linaro.org, sudeep.holla@arm.com, robin.murphy@arm.com,
 nwatters@codeaurora.org
Content-Type: text/plain; charset="us-ascii"
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+bjorn=helgaas.com@lists.infradead.org
List-ID: <linux-pci.vger.kernel.org>

On Fri, Oct 06, 2017 at 02:32:01PM +0100, Jean-Philippe Brucker wrote:
> The PASID ECN to the PCIe spec added a bit in the PRI status register that
> allows a Function to declare whether a PRG Response should contain the
> PASID prefix or not.
> 
> Move the helper that accesses it from amd_iommu into the PCI subsystem,
> renaming it to be consistent with the current spec (PRPR - PRG Response
> PASID Required).
> 
> Signed-off-by: Jean-Philippe Brucker <jean-philippe.brucker@arm.com>

Acked-by: Bjorn Helgaas <bhelgaas@google.com>

I assume this will be merged with the rest of the series, probably via an
IOMMU tree.

> ---
>  drivers/iommu/amd_iommu.c     | 19 +------------------
>  drivers/pci/ats.c             | 17 +++++++++++++++++
>  include/linux/pci-ats.h       |  8 ++++++++
>  include/uapi/linux/pci_regs.h |  1 +
>  4 files changed, 27 insertions(+), 18 deletions(-)
> 
> diff --git a/drivers/iommu/amd_iommu.c b/drivers/iommu/amd_iommu.c
> index 51f8215877f5..45036a253d63 100644
> --- a/drivers/iommu/amd_iommu.c
> +++ b/drivers/iommu/amd_iommu.c
> @@ -2039,23 +2039,6 @@ static int pdev_iommuv2_enable(struct pci_dev *pdev)
>  	return ret;
>  }
>  
> -/* FIXME: Move this to PCI code */
> -#define PCI_PRI_TLP_OFF		(1 << 15)
> -
> -static bool pci_pri_tlp_required(struct pci_dev *pdev)
> -{
> -	u16 status;
> -	int pos;
> -
> -	pos = pci_find_ext_capability(pdev, PCI_EXT_CAP_ID_PRI);
> -	if (!pos)
> -		return false;
> -
> -	pci_read_config_word(pdev, pos + PCI_PRI_STATUS, &status);
> -
> -	return (status & PCI_PRI_TLP_OFF) ? true : false;
> -}
> -
>  /*
>   * If a device is not yet associated with a domain, this function
>   * assigns it visible for the hardware
> @@ -2084,7 +2067,7 @@ static int attach_device(struct device *dev,
>  
>  			dev_data->ats.enabled = true;
>  			dev_data->ats.qdep    = pci_ats_queue_depth(pdev);
> -			dev_data->pri_tlp     = pci_pri_tlp_required(pdev);
> +			dev_data->pri_tlp     = pci_prg_resp_requires_prefix(pdev);
>  		}
>  	} else if (amd_iommu_iotlb_sup &&
>  		   pci_enable_ats(pdev, PAGE_SHIFT) == 0) {
> diff --git a/drivers/pci/ats.c b/drivers/pci/ats.c
> index ad8ddbbbf245..f95e42df728b 100644
> --- a/drivers/pci/ats.c
> +++ b/drivers/pci/ats.c
> @@ -389,3 +389,20 @@ int pci_max_pasids(struct pci_dev *pdev)
>  }
>  EXPORT_SYMBOL_GPL(pci_max_pasids);
>  #endif /* CONFIG_PCI_PASID */
> +
> +#if defined(CONFIG_PCI_PASID) && defined(CONFIG_PCI_PRI)
> +bool pci_prg_resp_requires_prefix(struct pci_dev *pdev)
> +{
> +	u16 status;
> +	int pos;
> +
> +	pos = pci_find_ext_capability(pdev, PCI_EXT_CAP_ID_PRI);
> +	if (!pos)
> +		return false;
> +
> +	pci_read_config_word(pdev, pos + PCI_PRI_STATUS, &status);
> +
> +	return !!(status & PCI_PRI_STATUS_PRPR);
> +}
> +EXPORT_SYMBOL_GPL(pci_prg_resp_requires_prefix);
> +#endif /* CONFIG_PCI_PASID && CONFIG_PCI_PRI */
> diff --git a/include/linux/pci-ats.h b/include/linux/pci-ats.h
> index 782fb8e0755f..367ea9448441 100644
> --- a/include/linux/pci-ats.h
> +++ b/include/linux/pci-ats.h
> @@ -67,5 +67,13 @@ static inline int pci_max_pasids(struct pci_dev *pdev)
>  
>  #endif /* CONFIG_PCI_PASID */
>  
> +#if defined(CONFIG_PCI_PASID) && defined(CONFIG_PCI_PRI)
> +bool pci_prg_resp_requires_prefix(struct pci_dev *pdev);
> +#else
> +static inline bool pci_prg_resp_requires_prefix(struct pci_dev *pdev)
> +{
> +	return false;
> +}
> +#endif /* CONFIG_PCI_PASID && CONFIG_PCI_PRI */
>  
>  #endif /* LINUX_PCI_ATS_H*/
> diff --git a/include/uapi/linux/pci_regs.h b/include/uapi/linux/pci_regs.h
> index f8d58045926f..a0eeb16a2bfe 100644
> --- a/include/uapi/linux/pci_regs.h
> +++ b/include/uapi/linux/pci_regs.h
> @@ -862,6 +862,7 @@
>  #define  PCI_PRI_STATUS_RF	0x001	/* Response Failure */
>  #define  PCI_PRI_STATUS_UPRGI	0x002	/* Unexpected PRG index */
>  #define  PCI_PRI_STATUS_STOPPED	0x100	/* PRI Stopped */
> +#define  PCI_PRI_STATUS_PRPR	0x8000	/* PRG Response requires PASID prefix */
>  #define PCI_PRI_MAX_REQ		0x08	/* PRI max reqs supported */
>  #define PCI_PRI_ALLOC_REQ	0x0c	/* PRI max reqs allowed */
>  #define PCI_EXT_CAP_PRI_SIZEOF	16
> -- 
> 2.13.3
> 

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
