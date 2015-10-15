Return-Path: <linux-kernel-owner@vger.kernel.org>
Date: Thu, 15 Oct 2015 15:11:35 -0500
From: Bjorn Helgaas <helgaas@kernel.org>
To: Marc Zyngier <marc.zyngier@arm.com>
Cc: Rob Herring <robh+dt@kernel.org>,
	Jason Cooper <jason@lakedaemon.net>,
	Thomas Gleixner <tglx@linutronix.de>,
	Bjorn Helgaas <bhelgaas@google.com>,
	linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	linux-pci@vger.kernel.org, Mark Rutland <Mark.Rutland@arm.com>,
	David Daney <ddaney.cavm@gmail.com>,
	Robin Murphy <robin.murphy@arm.com>
Subject: Re: [PATCH v2 8/8] PCI/MSI: Allow the MSI domain to be
 device-specific
Message-ID: <20151015201135.GE10442@localhost>
References: <1444151043-31084-1-git-send-email-marc.zyngier@arm.com>
 <1444151043-31084-9-git-send-email-marc.zyngier@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1444151043-31084-9-git-send-email-marc.zyngier@arm.com>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Tue, Oct 06, 2015 at 06:04:03PM +0100, Marc Zyngier wrote:
> So far, we've always considered that for a given PCI device, its
> MSI controller was either set by the architecture-specific
> pcibios hook, or simply inherited from the host bridge.
> 
> This doesn't cover things like firmware-defined topologies like
> msi-map (DT) or IORT (ACPI), which can provide information about
> which MSI controller to use on a per-device basis.
> 
> This patch adds the necessary hook into the MSI code to allow this
> feature, and provides the msi-map functionnality as a first
> implementation.
> 
> Signed-off-by: Marc Zyngier <marc.zyngier@arm.com>

Acked-by: Bjorn Helgaas <bhelgaas@google.com>

I assume somebody other than me will merge this series.

> ---
>  drivers/pci/msi.c   | 17 +++++++++++++++++
>  drivers/pci/probe.c |  8 ++++++++
>  include/linux/msi.h |  6 ++++++
>  3 files changed, 31 insertions(+)
> 
> diff --git a/drivers/pci/msi.c b/drivers/pci/msi.c
> index 81a2798..3daff31 100644
> --- a/drivers/pci/msi.c
> +++ b/drivers/pci/msi.c
> @@ -1357,4 +1357,21 @@ u32 pci_msi_domain_get_msi_rid(struct irq_domain *domain, struct pci_dev *pdev)
>  
>  	return rid;
>  }
> +
> +/**
> + * pci_msi_get_device_domain - Get the MSI domain for a given PCI device
> + * @pdev:	The PCI device
> + *
> + * Use the firmware data to find a device-specific MSI domain
> + * (i.e. not one that is ste as a default).
> + *
> + * Returns: The coresponding MSI domain or NULL if none has been found.
> + */
> +struct irq_domain *pci_msi_get_device_domain(struct pci_dev *pdev)
> +{
> +	u32 rid = 0;
> +
> +	pci_for_each_dma_alias(pdev, get_msi_id_cb, &rid);
> +	return of_msi_map_get_device_domain(&pdev->dev, rid);
> +}
>  #endif /* CONFIG_PCI_MSI_IRQ_DOMAIN */
> diff --git a/drivers/pci/probe.c b/drivers/pci/probe.c
> index 7c333f8..f14a970 100644
> --- a/drivers/pci/probe.c
> +++ b/drivers/pci/probe.c
> @@ -1639,6 +1639,14 @@ static struct irq_domain *pci_dev_msi_domain(struct pci_dev *dev)
>  	if (d)
>  		return d;
>  
> +	/*
> +	 * Let's see if we have a firmware interface able to provide
> +	 * the domain.
> +	 */
> +	d = pci_msi_get_device_domain(dev);
> +	if (d)
> +		return d;
> +
>  	return NULL;
>  }
>  
> diff --git a/include/linux/msi.h b/include/linux/msi.h
> index 56e3b76..375be7c 100644
> --- a/include/linux/msi.h
> +++ b/include/linux/msi.h
> @@ -294,6 +294,12 @@ irq_hw_number_t pci_msi_domain_calc_hwirq(struct pci_dev *dev,
>  int pci_msi_domain_check_cap(struct irq_domain *domain,
>  			     struct msi_domain_info *info, struct device *dev);
>  u32 pci_msi_domain_get_msi_rid(struct irq_domain *domain, struct pci_dev *pdev);
> +struct irq_domain *pci_msi_get_device_domain(struct pci_dev *pdev);
> +#else
> +static inline struct irq_domain *pci_msi_get_device_domain(struct pci_dev *pdev)
> +{
> +	return NULL;
> +}
>  #endif /* CONFIG_PCI_MSI_IRQ_DOMAIN */
>  
>  #endif /* LINUX_MSI_H */
> -- 
> 2.1.4
> 
> --
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
