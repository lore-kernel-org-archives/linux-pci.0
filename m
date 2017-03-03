Return-Path: <linux-arm-kernel-bounces+bjorn=helgaas.com@lists.infradead.org>
Return-Path: <linux-arm-kernel-bounces+bjorn=helgaas.com@lists.infradead.org>
Date: Fri, 3 Mar 2017 15:09:26 -0600
From: Bjorn Helgaas <helgaas@kernel.org>
To: Jean-Philippe Brucker <jean-philippe.brucker@arm.com>
Subject: Re: [RFC PATCH 03/30] PCI: Move ATS declarations outside of CONFIG_PCI
Message-ID: <20170303210926.GB31767@bhelgaas-glaptop.roam.corp.google.com>
References: <20170227195441.5170-1-jean-philippe.brucker@arm.com>
 <20170227195441.5170-4-jean-philippe.brucker@arm.com>
MIME-Version: 1.0
In-Reply-To: <20170227195441.5170-4-jean-philippe.brucker@arm.com>
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

On Mon, Feb 27, 2017 at 07:54:14PM +0000, Jean-Philippe Brucker wrote:
> Currently ATS helpers like pci_enable_ats are only defined when CONFIG_PCI
> is enabled. The ARM SMMU driver might get built with CONFIG_PCI disabled.
> It would thus have to wrap any use of ATS helpers around #ifdef
> CONFIG_PCI, which isn't ideal.
> 
> A nicer solution is to always define these helpers. Since CONFIG_PCI_ATS
> is only enabled in association with CONFIG_PCI, move defines outside of
> CONFIG_PCI to prevent build failure when PCI is disabled.
> 
> Signed-off-by: Jean-Philippe Brucker <jean-philippe.brucker@arm.com>

I don't think there's any reason to make a pci_ats_init() stub when
CONFIG_PCI is not enabled, because it's only called from the PCI core.
But it does make some sense to keep them all together in one place.

I think you could also remove the #ifdef CONFIG_PCI_ATS in
arm_smmu_enable_ats() ("[RFC PATCH 04/30] iommu/arm-smmu-v3: Add
support for PCI ATS"), right?

If you remove the #ifdef, we'll call pci_enable_ats(), and it will
fail if !pdev->ats_cap.

Acked-by: Bjorn Helgaas <bhelgaas@google.com>

> ---
>  include/linux/pci.h | 26 +++++++++++++-------------
>  1 file changed, 13 insertions(+), 13 deletions(-)
> 
> diff --git a/include/linux/pci.h b/include/linux/pci.h
> index 282ed32244ce..e606f289bf5f 100644
> --- a/include/linux/pci.h
> +++ b/include/linux/pci.h
> @@ -1418,19 +1418,6 @@ int  ht_create_irq(struct pci_dev *dev, int idx);
>  void ht_destroy_irq(unsigned int irq);
>  #endif /* CONFIG_HT_IRQ */
>  
> -#ifdef CONFIG_PCI_ATS
> -/* Address Translation Service */
> -void pci_ats_init(struct pci_dev *dev);
> -int pci_enable_ats(struct pci_dev *dev, int ps);
> -void pci_disable_ats(struct pci_dev *dev);
> -int pci_ats_queue_depth(struct pci_dev *dev);
> -#else
> -static inline void pci_ats_init(struct pci_dev *d) { }
> -static inline int pci_enable_ats(struct pci_dev *d, int ps) { return -ENODEV; }
> -static inline void pci_disable_ats(struct pci_dev *d) { }
> -static inline int pci_ats_queue_depth(struct pci_dev *d) { return -ENODEV; }
> -#endif
> -
>  #ifdef CONFIG_PCIE_PTM
>  int pci_enable_ptm(struct pci_dev *dev, u8 *granularity);
>  #else
> @@ -1616,6 +1603,19 @@ static inline int pci_get_new_domain_nr(void) { return -ENOSYS; }
>  #define dev_is_pf(d) (false)
>  #endif /* CONFIG_PCI */
>  
> +#ifdef CONFIG_PCI_ATS
> +/* Address Translation Service */
> +void pci_ats_init(struct pci_dev *dev);
> +int pci_enable_ats(struct pci_dev *dev, int ps);
> +void pci_disable_ats(struct pci_dev *dev);
> +int pci_ats_queue_depth(struct pci_dev *dev);
> +#else
> +static inline void pci_ats_init(struct pci_dev *d) { }
> +static inline int pci_enable_ats(struct pci_dev *d, int ps) { return -ENODEV; }
> +static inline void pci_disable_ats(struct pci_dev *d) { }
> +static inline int pci_ats_queue_depth(struct pci_dev *d) { return -ENODEV; }
> +#endif
> +
>  /* Include architecture-dependent settings and functions */
>  
>  #include <asm/pci.h>
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
