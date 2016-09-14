Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.136]:34184 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1765396AbcINVQX (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Wed, 14 Sep 2016 17:16:23 -0400
Date: Wed, 14 Sep 2016 16:16:18 -0500
From: Bjorn Helgaas <helgaas@kernel.org>
To: Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>
Cc: horms@verge.net.au, bhelgaas@google.com, linux-pci@vger.kernel.org,
        linux-renesas-soc@vger.kernel.org
Subject: Re: [PATCH] pcie-rcar: MSI range allocation support
Message-ID: <20160914211618.GA16581@localhost>
References: <2520843.q5xC3E7R5B@wasted.cogentembedded.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <2520843.q5xC3E7R5B@wasted.cogentembedded.com>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Thu, Sep 08, 2016 at 10:32:59PM +0300, Sergei Shtylyov wrote:
> From: Grigory Kletsko <grigory.kletsko@cogentembedded.com>
> 
> Impelment MSI setup_irqs() method which enables allocation of several MSIs
> at once.
> 
> [Sergei Shtylyov: removed unrelated/unneeded changes, fixed too long lines,
> reordered the variable declarations, reworded the summary/description.]
> 
> Signed-off-by: Grigory Kletsko <grigory.kletsko@cogentembedded.com>
> Signed-off-by: Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>

Applied with Simon's ack to pci/host-rcar for v4.9, thanks!

> ---
> The patch is against the 'next' branch of Bjorn Helgaas' 'pci.git' repo plus
> the patch posted yesterday.
> 
>  drivers/pci/host/pcie-rcar.c |   72 +++++++++++++++++++++++++++++++++++++++++--
>  1 file changed, 70 insertions(+), 2 deletions(-)
> 
> Index: pci/drivers/pci/host/pcie-rcar.c
> ===================================================================
> --- pci.orig/drivers/pci/host/pcie-rcar.c
> +++ pci/drivers/pci/host/pcie-rcar.c
> @@ -673,6 +673,18 @@ static int rcar_msi_alloc(struct rcar_ms
>  	return msi;
>  }
>  
> +static int rcar_msi_alloc_region(struct rcar_msi *chip, int no_irqs)
> +{
> +	int msi;
> +
> +	mutex_lock(&chip->lock);
> +	msi = bitmap_find_free_region(chip->used, INT_PCI_MSI_NR,
> +				      order_base_2(no_irqs));
> +	mutex_unlock(&chip->lock);
> +
> +	return msi;
> +}
> +
>  static void rcar_msi_free(struct rcar_msi *chip, unsigned long irq)
>  {
>  	mutex_lock(&chip->lock);
> @@ -768,7 +780,7 @@ static int rcar_msi_setup_irq(struct msi
>  	if (hwirq < 0)
>  		return hwirq;
>  
> -	irq = irq_create_mapping(msi->domain, hwirq);
> +	irq = irq_find_mapping(msi->domain, hwirq);
>  	if (!irq) {
>  		rcar_msi_free(msi, hwirq);
>  		return -EINVAL;
> @@ -785,6 +797,58 @@ static int rcar_msi_setup_irq(struct msi
>  	return 0;
>  }
>  
> +static int rcar_msi_setup_irqs(struct msi_controller *chip,
> +			       struct pci_dev *pdev, int nvec, int type)
> +{
> +	struct rcar_pcie *pcie = container_of(chip, struct rcar_pcie, msi.chip);
> +	struct rcar_msi *msi = to_rcar_msi(chip);
> +	struct msi_desc *desc;
> +	struct msi_msg msg;
> +	unsigned int irq;
> +	int hwirq;
> +	int i;
> +
> +	/* MSI-X interrupts are not supported */
> +	if (type == PCI_CAP_ID_MSIX)
> +		return -EINVAL;
> +
> +	WARN_ON(!list_is_singular(&pdev->dev.msi_list));
> +	desc = list_entry(pdev->dev.msi_list.next, struct msi_desc, list);
> +
> +	hwirq = rcar_msi_alloc_region(msi, nvec);
> +	if (hwirq < 0)
> +		return -ENOSPC;
> +
> +	irq = irq_find_mapping(msi->domain, hwirq);
> +	if (!irq)
> +		return -ENOSPC;
> +
> +	for (i = 0; i < nvec; i++) {
> +		/*
> +		 * irq_create_mapping() called from rcar_pcie_probe() pre-
> +		 * allocates descs,  so there is no need to allocate descs here.
> +		 * We can therefore assume that if irq_find_mapping() above
> +		 * returns non-zero, then the descs are also successfully
> +		 * allocated.
> +		 */
> +		if (irq_set_msi_desc_off(irq, i, desc)) {
> +			/* TODO: clear */
> +			return -EINVAL;
> +		}
> +	}
> +
> +	desc->nvec_used = nvec;
> +	desc->msi_attrib.multiple = order_base_2(nvec);
> +
> +	msg.address_lo = rcar_pci_read_reg(pcie, PCIEMSIALR) & ~MSIFE;
> +	msg.address_hi = rcar_pci_read_reg(pcie, PCIEMSIAUR);
> +	msg.data = hwirq;
> +
> +	pci_write_msi_msg(irq, &msg);
> +
> +	return 0;
> +}
> +
>  static void rcar_msi_teardown_irq(struct msi_controller *chip, unsigned int irq)
>  {
>  	struct rcar_msi *msi = to_rcar_msi(chip);
> @@ -819,12 +883,13 @@ static int rcar_pcie_enable_msi(struct r
>  	struct platform_device *pdev = to_platform_device(pcie->dev);
>  	struct rcar_msi *msi = &pcie->msi;
>  	unsigned long base;
> -	int err;
> +	int err, i;
>  
>  	mutex_init(&msi->lock);
>  
>  	msi->chip.dev = pcie->dev;
>  	msi->chip.setup_irq = rcar_msi_setup_irq;
> +	msi->chip.setup_irqs = rcar_msi_setup_irqs;
>  	msi->chip.teardown_irq = rcar_msi_teardown_irq;
>  
>  	msi->domain = irq_domain_add_linear(pcie->dev->of_node, INT_PCI_MSI_NR,
> @@ -834,6 +899,9 @@ static int rcar_pcie_enable_msi(struct r
>  		return -ENOMEM;
>  	}
>  
> +	for (i = 0; i < INT_PCI_MSI_NR; i++)
> +		irq_create_mapping(msi->domain, i);
> +
>  	/* Two irqs are for MSI, but they are also used for non-MSI irqs */
>  	err = devm_request_irq(&pdev->dev, msi->irq1, rcar_pcie_msi_irq,
>  			       IRQF_SHARED | IRQF_NO_THREAD,
> 
> --
> To unsubscribe from this list: send the line "unsubscribe linux-pci" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
