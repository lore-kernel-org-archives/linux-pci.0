Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.99]:53122 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751731AbdHNVEz (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Mon, 14 Aug 2017 17:04:55 -0400
Date: Mon, 14 Aug 2017 16:04:51 -0500
From: Bjorn Helgaas <helgaas@kernel.org>
To: Robin Murphy <robin.murphy@arm.com>
Cc: linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
        marc.zyngier@arm.com, david.daney@cavium.com,
        alex.williamson@redhat.com
Subject: Re: [PATCH v2] PCI/MSI: Improve MSI alias detection
Message-ID: <20170814210451.GG32525@bhelgaas-glaptop.roam.corp.google.com>
References: <63f5b8eef3c6d903bf97ca7fea0daa2e832be02f.1501610322.git.robin.murphy@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <63f5b8eef3c6d903bf97ca7fea0daa2e832be02f.1501610322.git.robin.murphy@arm.com>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Tue, Aug 01, 2017 at 06:59:08PM +0100, Robin Murphy wrote:
> Currently, we handle all DMA aliases equally when calculating MSI
> requester IDs for the generic infrastructure. This turns out to be the
> wrong thing to do in the face of pure DMA quirks like those of Marvell
> SATA cards, where in the usual case the last thing seen in the alias
> walk is the DMA phantom function: we end up configuring the MSI
> doorbell to expect that alias, then find we have no interrupts since
> the MSI writes still come from the 'real' RID, thus get filtered out
> and ignored.
> 
> Improve the alias walk to only account for the topological aliases that
> matter, based on the logic from the Intel IRQ remapping code.
> 
> Signed-off-by: Robin Murphy <robin.murphy@arm.com>

Applied with Marc's ack to pci/msi for v4.14, thanks!

I used the subject line:

  PCI/MSI: Assume MSIs use real Requester ID, not an alias

> ---
> 
> v2: Properly document the rationale.
> 
>  drivers/pci/msi.c | 27 ++++++++++++++++++++++-----
>  1 file changed, 22 insertions(+), 5 deletions(-)
> 
> diff --git a/drivers/pci/msi.c b/drivers/pci/msi.c
> index 253d92409bb3..2f0dd02d78b7 100644
> --- a/drivers/pci/msi.c
> +++ b/drivers/pci/msi.c
> @@ -1458,13 +1458,30 @@ struct irq_domain *pci_msi_create_irq_domain(struct fwnode_handle *fwnode,
>  }
>  EXPORT_SYMBOL_GPL(pci_msi_create_irq_domain);
>  
> +/*
> + * Users of the generic MSI infrastructure expect a device to have a single ID,
> + * so with DMA aliases we have to pick the least-worst compromise. Devices with
> + * DMA phantom functions tend to still emit MSIs from the real function number,
> + * so we ignore those and only consider topological aliases where either the
> + * alias device or RID appears on a different bus number. We also make the
> + * reasonable assumption that bridges are walked in an upstream direction (so
> + * the last one seen wins), and the much braver assumption that the most likely
> + * case is that of PCI->PCIe so we should always use the alias RID. This echoes
> + * the logic from intel_irq_remapping's set_msi_sid(), which presumably works
> + * well enough in practice; in the face of the horrible PCIe<->PCI-X conditions
> + * for taking ownership all we can really do is close our eyes and hope...
> + */
>  static int get_msi_id_cb(struct pci_dev *pdev, u16 alias, void *data)
>  {
>  	u32 *pa = data;
> +	u8 bus = PCI_BUS_NUM(*pa);
> +
> +	if (pdev->bus->number != bus || PCI_BUS_NUM(alias) != bus)
> +		*pa = alias;
>  
> -	*pa = alias;
>  	return 0;
>  }
> +
>  /**
>   * pci_msi_domain_get_msi_rid - Get the MSI requester id (RID)
>   * @domain:	The interrupt domain
> @@ -1478,7 +1495,7 @@ static int get_msi_id_cb(struct pci_dev *pdev, u16 alias, void *data)
>  u32 pci_msi_domain_get_msi_rid(struct irq_domain *domain, struct pci_dev *pdev)
>  {
>  	struct device_node *of_node;
> -	u32 rid = 0;
> +	u32 rid = PCI_DEVID(pdev->bus->number, pdev->devfn);
>  
>  	pci_for_each_dma_alias(pdev, get_msi_id_cb, &rid);
>  
> @@ -1494,14 +1511,14 @@ u32 pci_msi_domain_get_msi_rid(struct irq_domain *domain, struct pci_dev *pdev)
>   * @pdev:	The PCI device
>   *
>   * Use the firmware data to find a device-specific MSI domain
> - * (i.e. not one that is ste as a default).
> + * (i.e. not one that is set as a default).
>   *
> - * Returns: The coresponding MSI domain or NULL if none has been found.
> + * Returns: The corresponding MSI domain or NULL if none has been found.
>   */
>  struct irq_domain *pci_msi_get_device_domain(struct pci_dev *pdev)
>  {
>  	struct irq_domain *dom;
> -	u32 rid = 0;
> +	u32 rid = PCI_DEVID(pdev->bus->number, pdev->devfn);
>  
>  	pci_for_each_dma_alias(pdev, get_msi_id_cb, &rid);
>  	dom = of_msi_map_get_device_domain(&pdev->dev, rid);
> -- 
> 2.12.2.dirty
> 
