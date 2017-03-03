Return-Path: <linux-arm-kernel-bounces+bjorn=helgaas.com@lists.infradead.org>
Return-Path: <linux-arm-kernel-bounces+bjorn=helgaas.com@lists.infradead.org>
Date: Fri, 3 Mar 2017 15:12:16 -0600
From: Bjorn Helgaas <helgaas@kernel.org>
To: Jean-Philippe Brucker <jean-philippe.brucker@arm.com>
Subject: Re: [RFC PATCH 19/30] PCI: Cache PRI and PASID bits in pci_dev
Message-ID: <20170303211216.GD31767@bhelgaas-glaptop.roam.corp.google.com>
References: <20170227195441.5170-1-jean-philippe.brucker@arm.com>
 <20170227195441.5170-20-jean-philippe.brucker@arm.com>
MIME-Version: 1.0
In-Reply-To: <20170227195441.5170-20-jean-philippe.brucker@arm.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Cc: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
 Shanker Donthineni <shankerd@qti.qualcomm.com>, kvm@vger.kernel.org,
 Catalin Marinas <catalin.marinas@arm.com>, Joerg Roedel <joro@8bytes.org>,
 Sinan Kaya <okaya@qti.qualcomm.com>, Will Deacon <will.deacon@arm.com>,
 Alex Williamson <alex.williamson@redhat.com>,
 Harv Abdulhamid <harba@qti.qualcomm.com>, iommu@lists.linux-foundation.org,
 linux-pci@vger.kernel.org, Bjorn Helgaas <bhelgaas@google.com>,
 Robin Murphy <robin.murphy@arm.com>, David Woodhouse <dwmw2@infradead.org>,
 linux-arm-kernel@lists.infradead.org,
 Nate Watterson <nwatters@qti.qualcomm.com>
Content-Type: text/plain; charset="us-ascii"
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+bjorn=helgaas.com@lists.infradead.org
List-ID: <linux-pci.vger.kernel.org>

On Mon, Feb 27, 2017 at 07:54:30PM +0000, Jean-Philippe Brucker wrote:
> Device drivers need to check if an IOMMU enabled ATS, PRI and PASID in
> order to know when they can use the SVM API. Cache PRI and PASID bits in
> the pci_dev structure, similarly to what is currently done for ATS.
> 
> Signed-off-by: Jean-Philippe Brucker <jean-philippe.brucker@arm.com>

Acked-by: Bjorn Helgaas <bhelgaas@google.com>

> ---
>  drivers/pci/ats.c   | 23 +++++++++++++++++++++++
>  include/linux/pci.h |  2 ++
>  2 files changed, 25 insertions(+)
> 
> diff --git a/drivers/pci/ats.c b/drivers/pci/ats.c
> index 331376e9bb8b..486dc2208119 100644
> --- a/drivers/pci/ats.c
> +++ b/drivers/pci/ats.c
> @@ -153,6 +153,9 @@ int pci_enable_pri(struct pci_dev *pdev, u32 reqs)
>  	u32 max_requests;
>  	int pos;
>  
> +	if (WARN_ON(pdev->pri_enabled))
> +		return -EBUSY;
> +
>  	pos = pci_find_ext_capability(pdev, PCI_EXT_CAP_ID_PRI);
>  	if (!pos)
>  		return -EINVAL;
> @@ -170,6 +173,8 @@ int pci_enable_pri(struct pci_dev *pdev, u32 reqs)
>  	control |= PCI_PRI_CTRL_ENABLE;
>  	pci_write_config_word(pdev, pos + PCI_PRI_CTRL, control);
>  
> +	pdev->pri_enabled = 1;
> +
>  	return 0;
>  }
>  EXPORT_SYMBOL_GPL(pci_enable_pri);
> @@ -185,6 +190,9 @@ void pci_disable_pri(struct pci_dev *pdev)
>  	u16 control;
>  	int pos;
>  
> +	if (WARN_ON(!pdev->pri_enabled))
> +		return;
> +
>  	pos = pci_find_ext_capability(pdev, PCI_EXT_CAP_ID_PRI);
>  	if (!pos)
>  		return;
> @@ -192,6 +200,8 @@ void pci_disable_pri(struct pci_dev *pdev)
>  	pci_read_config_word(pdev, pos + PCI_PRI_CTRL, &control);
>  	control &= ~PCI_PRI_CTRL_ENABLE;
>  	pci_write_config_word(pdev, pos + PCI_PRI_CTRL, control);
> +
> +	pdev->pri_enabled = 0;
>  }
>  EXPORT_SYMBOL_GPL(pci_disable_pri);
>  
> @@ -207,6 +217,9 @@ int pci_reset_pri(struct pci_dev *pdev)
>  	u16 control;
>  	int pos;
>  
> +	if (WARN_ON(pdev->pri_enabled))
> +		return -EBUSY;
> +
>  	pos = pci_find_ext_capability(pdev, PCI_EXT_CAP_ID_PRI);
>  	if (!pos)
>  		return -EINVAL;
> @@ -239,6 +252,9 @@ int pci_enable_pasid(struct pci_dev *pdev, int features)
>  	u16 control, supported;
>  	int pos;
>  
> +	if (WARN_ON(pdev->pasid_enabled))
> +		return -EBUSY;
> +
>  	pos = pci_find_ext_capability(pdev, PCI_EXT_CAP_ID_PASID);
>  	if (!pos)
>  		return -EINVAL;
> @@ -259,6 +275,8 @@ int pci_enable_pasid(struct pci_dev *pdev, int features)
>  
>  	pci_write_config_word(pdev, pos + PCI_PASID_CTRL, control);
>  
> +	pdev->pasid_enabled = 1;
> +
>  	return 0;
>  }
>  EXPORT_SYMBOL_GPL(pci_enable_pasid);
> @@ -273,11 +291,16 @@ void pci_disable_pasid(struct pci_dev *pdev)
>  	u16 control = 0;
>  	int pos;
>  
> +	if (WARN_ON(!pdev->pasid_enabled))
> +		return;
> +
>  	pos = pci_find_ext_capability(pdev, PCI_EXT_CAP_ID_PASID);
>  	if (!pos)
>  		return;
>  
>  	pci_write_config_word(pdev, pos + PCI_PASID_CTRL, control);
> +
> +	pdev->pasid_enabled = 0;
>  }
>  EXPORT_SYMBOL_GPL(pci_disable_pasid);
>  
> diff --git a/include/linux/pci.h b/include/linux/pci.h
> index e606f289bf5f..47c353ca9957 100644
> --- a/include/linux/pci.h
> +++ b/include/linux/pci.h
> @@ -351,6 +351,8 @@ struct pci_dev {
>  	unsigned int	msix_enabled:1;
>  	unsigned int	ari_enabled:1;	/* ARI forwarding */
>  	unsigned int	ats_enabled:1;	/* Address Translation Service */
> +	unsigned int	pasid_enabled:1;	/* Process Address Space ID */
> +	unsigned int	pri_enabled:1;		/* Page Request Interface */
>  	unsigned int	is_managed:1;
>  	unsigned int    needs_freset:1; /* Dev requires fundamental reset */
>  	unsigned int	state_saved:1;
> -- 
> 2.11.0
> 
> 
> _______________________________________________
> linux-arm-kernel mailing list
> linux-arm-kernel@lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
