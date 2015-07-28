Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from foss.arm.com ([217.140.101.70]:60668 "EHLO foss.arm.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752180AbbG1R6q (ORCPT <rfc822;linux-pci@vger.kernel.org>);
	Tue, 28 Jul 2015 13:58:46 -0400
Message-ID: <55B7C2D0.8080107@arm.com>
Date: Tue, 28 Jul 2015 18:58:40 +0100
From: Marc Zyngier <marc.zyngier@arm.com>
MIME-Version: 1.0
To: Ley Foon Tan <lftan@altera.com>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Russell King <linux@arm.linux.org.uk>,
	Arnd Bergmann <arnd@arndb.de>,
	Dinh Nguyen <dinguyen@opensource.altera.com>
CC: devicetree@vger.kernel.org, lftan.linux@gmail.com,
	linux-doc@vger.kernel.org, linux-pci@vger.kernel.org,
	linux-kernel@vger.kernel.org, Rob Herring <robh+dt@kernel.org>,
	linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH 4/6] pci: altera: Add Altera PCIe MSI driver
References: <1438080345-7233-1-git-send-email-lftan@altera.com> <1438080345-7233-5-git-send-email-lftan@altera.com>
In-Reply-To: <1438080345-7233-5-git-send-email-lftan@altera.com>
Content-Type: text/plain; charset=windows-1252
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Hi Ley,

On 28/07/15 11:45, Ley Foon Tan wrote:
> This patch adds Altera PCIe MSI driver. This soft IP supports configurable
> number of vectors, which is a dts parameter.

Can't you read this configuration from the HW?

> 
> Signed-off-by: Ley Foon Tan <lftan@altera.com>
> ---
>  drivers/pci/host/Kconfig           |   7 +
>  drivers/pci/host/Makefile          |   1 +
>  drivers/pci/host/pcie-altera-msi.c | 318 +++++++++++++++++++++++++++++++++++++
>  3 files changed, 326 insertions(+)
>  create mode 100644 drivers/pci/host/pcie-altera-msi.c
> 
> diff --git a/drivers/pci/host/Kconfig b/drivers/pci/host/Kconfig
> index af19039..a8b87fd 100644
> --- a/drivers/pci/host/Kconfig
> +++ b/drivers/pci/host/Kconfig
> @@ -154,4 +154,11 @@ config PCIE_ALTERA
>  	  Say Y here if you want to enable PCIe controller support for Altera
>  	  SoCFPGA family of SoCs.
>  
> +config PCIE_ALTERA_MSI
> +	bool "Altera PCIe MSI feature"
> +	depends on PCI_MSI && PCIE_ALTERA

What is the dependency with PCIE_ALTERA? Isn't that module standalone?

> +	help
> +	  Say Y here if you want PCIe MSI support for the Altera SocFPGA SoC.
> +	  This MSI driver supports Altera MSI to GIC controller IP.
> +
>  endmenu
> diff --git a/drivers/pci/host/Makefile b/drivers/pci/host/Makefile
> index 6954f76..6c4913d 100644
> --- a/drivers/pci/host/Makefile
> +++ b/drivers/pci/host/Makefile
> @@ -18,3 +18,4 @@ obj-$(CONFIG_PCIE_IPROC) += pcie-iproc.o
>  obj-$(CONFIG_PCIE_IPROC_PLATFORM) += pcie-iproc-platform.o
>  obj-$(CONFIG_PCIE_IPROC_BCMA) += pcie-iproc-bcma.o
>  obj-$(CONFIG_PCIE_ALTERA) += pcie-altera.o
> +obj-$(CONFIG_PCIE_ALTERA_MSI) += pcie-altera-msi.o
> diff --git a/drivers/pci/host/pcie-altera-msi.c b/drivers/pci/host/pcie-altera-msi.c
> new file mode 100644
> index 0000000..b852b51
> --- /dev/null
> +++ b/drivers/pci/host/pcie-altera-msi.c
> @@ -0,0 +1,318 @@
> +/*
> + * Copyright Altera Corporation (C) 2013-2015. All rights reserved
> + *
> + * This program is free software; you can redistribute it and/or modify it
> + * under the terms and conditions of the GNU General Public License,
> + * version 2, as published by the Free Software Foundation.
> + *
> + * This program is distributed in the hope it will be useful, but WITHOUT
> + * ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or
> + * FITNESS FOR A PARTICULAR PURPOSE.  See the GNU General Public License for
> + * more details.
> + *
> + * You should have received a copy of the GNU General Public License along with
> + * this program.  If not, see <http://www.gnu.org/licenses/>.
> + */
> +#include <linux/interrupt.h>
> +#include <linux/module.h>
> +#include <linux/msi.h>
> +#include <linux/of_address.h>
> +#include <linux/of_irq.h>
> +#include <linux/of_pci.h>
> +#include <linux/pci.h>
> +#include <linux/platform_device.h>
> +#include <linux/slab.h>
> +
> +#define MSI_STATUS		0x0
> +#define MSI_ERROR		0x4
> +#define MSI_INTMASK		0x8
> +
> +#define MAX_MSI_VECTORS		32
> +struct altera_msi {
> +	DECLARE_BITMAP(used, MAX_MSI_VECTORS);
> +	struct mutex		lock;	/* proctect used variable */
> +	struct platform_device	*pdev;
> +	struct irq_domain		*msi_domain;
> +	void __iomem		*csr_base;
> +	void __iomem		*vector_base;
> +	u32			vector_phy;

This should be a phys_addr_t. Not everything is 32bit.

> +	u32			num_of_vectors;
> +	int			irq;
> +};
> +
> +static inline void msi_writel(struct altera_msi *msi, u32 value, u32 reg)
> +{
> +	writel(value, msi->csr_base + reg);

You should be able to use the relaxed accessors.

> +}
> +
> +static inline u32 msi_readl(struct altera_msi *msi, u32 reg)
> +{
> +	return readl(msi->csr_base + reg);

Same here.

> +}
> +
> +static irqreturn_t altera_msi_isr(int irq, void *data)
> +{
> +	struct altera_msi *msi = data;
> +	unsigned long status;
> +	u32 num_of_vectors = msi->num_of_vectors;
> +	u32 processed = 0;
> +	u32 offset;
> +
> +	do {
> +		status = msi_readl(msi, MSI_STATUS);
> +		if (!status)
> +			break;
> +
> +		do {
> +			offset = find_first_bit(&status, num_of_vectors);
> +			/* Dummy read from vector to clear the interrupt */
> +			readl(msi->vector_base + (offset * sizeof(u32)));

readl_relaxed

> +
> +			irq = irq_find_mapping(msi->msi_domain->parent, offset);

This would tend to indicate that you don't really need to store the
msi_domain pointer, but the inner_domain pointer instead.

> +			if (irq) {
> +				if (test_bit(offset, msi->used))
> +					generic_handle_irq(irq);
> +				else
> +					dev_info(&msi->pdev->dev, "unhandled MSI\n");
> +			} else
> +				dev_info(&msi->pdev->dev, "unexpected MSI\n");
> +
> +			/* Clear the bit from status and repeat without reading
> +			 * again status register. */
> +			clear_bit(offset, &status);
> +			processed++;
> +		} while (status);
> +	} while (1);
> +
> +	return processed > 0 ? IRQ_HANDLED : IRQ_NONE;

This shouldn't be a simple interrupt interrupt handler, but instead a
chained irqchip. See pci-xgene-msi.c for an example of such a thing.

> +}
> +
> +static struct irq_chip altera_msi_irq_chip = {
> +	.name = "Altera PCIe MSI",
> +	.irq_enable = pci_msi_unmask_irq,
> +	.irq_disable = pci_msi_mask_irq,
> +	.irq_mask = pci_msi_mask_irq,
> +	.irq_unmask = pci_msi_unmask_irq,
> +};
> +
> +static struct msi_domain_info altera_msi_domain_info = {
> +	.flags	= (MSI_FLAG_USE_DEF_DOM_OPS | MSI_FLAG_USE_DEF_CHIP_OPS),

So you don't support MSIX? That's a bit weird.

> +	.chip	= &altera_msi_irq_chip,
> +};
> +
> +static void altera_compose_msi_msg(struct irq_data *data, struct msi_msg *msg)
> +{
> +	struct altera_msi *msi = irq_data_get_irq_chip_data(data);
> +	u32 mask;
> +
> +	msg->address_lo = msi->vector_phy + (data->hwirq * sizeof(u32));

Each MSI has a separate doorbell? Interesting... Please use
lower_32_bits on the above expression.

> +	/* 32 bit address only */
> +	msg->address_hi = 0;

So this HW will never be used in a 64bit platform? Oddly enough, I
cannot believe it. Please use upper_32_bits() as the complement of the
above. At least, we'll be future proof.

> +	msg->data = data->hwirq;
> +
> +	mask = msi_readl(msi, MSI_INTMASK);
> +	mask |= 1 << data->hwirq;
> +	msi_writel(msi, mask, MSI_INTMASK);
> +	dev_dbg(&msi->pdev->dev, "msi#%d address_lo 0x%x\n", (int)data->hwirq,
> +		msg->address_lo);
> +}
> +
> +static int altera_msi_set_affinity(struct irq_data *irq_data,
> +				 const struct cpumask *mask, bool force)
> +{
> +	 return irq_set_affinity(irq_data->hwirq, mask);

There is no way this can be right. irq_data->hwirq can *never* be passed
as a Linux IRQ. This really should be the IRQ to the GIC.

Which raises another issue: as you only have a single interrupt to the
GIC, changing the affinity of a single MSI is going to affect all the
other MSIs as well. This doesn't seem like a desirable behaviour.

> +}
> +
> +static struct irq_chip altera_msi_bottom_irq_chip = {
> +	.name			= "Altera MSI",
> +	.irq_compose_msi_msg	= altera_compose_msi_msg,
> +	.irq_set_affinity	= altera_msi_set_affinity,
> +};
> +
> +static int altera_irq_domain_alloc(struct irq_domain *domain, unsigned int virq,
> +				  unsigned int nr_irqs, void *args)
> +{
> +	struct altera_msi *msi = domain->host_data;
> +	int bit;
> +
> +	mutex_lock(&msi->lock);
> +
> +	bit = find_first_zero_bit(msi->used, msi->num_of_vectors);
> +	if (bit < msi->num_of_vectors)
> +		set_bit(bit, msi->used);
> +	else
> +		bit = -ENOSPC;

You can loose the "else" clause...

> +
> +	mutex_unlock(&msi->lock);
> +
> +	if (bit < 0)
> +		return bit;

... and test for bit >= msi->num_of_vectors, returning -ENOSPC if out of
vectors.

> +
> +	irq_domain_set_info(domain, virq, bit, &altera_msi_bottom_irq_chip,
> +			    domain->host_data, handle_simple_irq,
> +			    NULL, NULL);
> +	set_irq_flags(virq, IRQF_VALID);
> +
> +	return 0;
> +}
> +
> +static void altera_irq_domain_free(struct irq_domain *domain,
> +				  unsigned int virq, unsigned int nr_irqs)
> +{
> +	struct irq_data *d = irq_domain_get_irq_data(domain, virq);
> +	struct altera_msi *msi = irq_data_get_irq_chip_data(d);
> +	u32 mask;
> +
> +	mutex_lock(&msi->lock);
> +
> +	if (!test_bit(d->hwirq, msi->used))
> +		dev_err(&msi->pdev->dev, "trying to free unused MSI#%lu\n",
> +		d->hwirq);
> +	else {
> +		clear_bit(d->hwirq, msi->used);
> +		mask = msi_readl(msi, MSI_INTMASK);
> +		mask &= ~(1 << d->hwirq);
> +		msi_writel(msi, mask, MSI_INTMASK);
> +	}
> +
> +	mutex_unlock(&msi->lock);
> +}
> +
> +static const struct irq_domain_ops msi_domain_ops = {
> +	.alloc	= altera_irq_domain_alloc,
> +	.free	= altera_irq_domain_free,
> +};
> +
> +static int altera_allocate_domains(struct altera_msi *msi)
> +{
> +	struct irq_domain *inner_domain;
> +
> +	inner_domain = irq_domain_add_linear(NULL, msi->num_of_vectors,
> +					     &msi_domain_ops, msi);
> +	if (!inner_domain) {
> +		dev_err(&msi->pdev->dev, "failed to create IRQ domain\n");
> +		return -ENOMEM;
> +	}
> +
> +	msi->msi_domain = pci_msi_create_irq_domain(
> +				msi->pdev->dev.of_node,
> +				&altera_msi_domain_info, inner_domain);
> +	if (!msi->msi_domain) {
> +		dev_err(&msi->pdev->dev, "failed to create MSI domain\n");
> +		irq_domain_remove(inner_domain);
> +		return -ENOMEM;
> +	}
> +
> +	return 0;
> +}
> +
> +static void altera_free_domains(struct altera_msi *msi)
> +{
> +	struct irq_domain *inner_domain = msi->msi_domain->parent;
> +
> +	irq_domain_remove(msi->msi_domain);
> +	irq_domain_remove(inner_domain);
> +}
> +
> +int altera_msi_probe(struct platform_device *pdev)
> +{
> +	struct altera_msi *msi;
> +	struct device_node *np = pdev->dev.of_node;
> +	struct resource *res;
> +	int ret;
> +
> +	msi = devm_kzalloc(&pdev->dev, sizeof(struct altera_msi),
> +		GFP_KERNEL);
> +	if (!msi)
> +		return -ENOMEM;
> +
> +	mutex_init(&msi->lock);
> +	msi->pdev = pdev;
> +
> +	res = platform_get_resource_byname(pdev, IORESOURCE_MEM, "csr");
> +	msi->csr_base = devm_ioremap_resource(&pdev->dev, res);
> +	if (IS_ERR(msi->csr_base)) {
> +		dev_err(&pdev->dev, "get csr resource failed\n");
> +		return -EADDRNOTAVAIL;

You're being quite creative when it comes to error codes. I'd expect
this to be used for networking (pci-tegra also uses it, which is even
more disturbing). I'd be more confident with an -ENOMEM.

> +	}
> +
> +	res = platform_get_resource_byname(pdev, IORESOURCE_MEM,
> +			"vector_slave");
> +	msi->vector_base = devm_ioremap_resource(&pdev->dev, res);
> +	if (IS_ERR(msi->vector_base)) {
> +		dev_err(&pdev->dev, "get vector slave resource failed\n");
> +		return -EADDRNOTAVAIL;
> +	}
> +
> +	msi->vector_phy = res->start;
> +
> +	if (of_property_read_u32(np, "num-vectors", &msi->num_of_vectors)) {
> +		dev_err(&pdev->dev, "failed to parse the number of vectors\n");
> +		return -EINVAL;
> +	}

Since this is a configurable IP, you should have a register telling you
the number of configured MSI, shouldn't you? Or is the HW really, really
dumb?

> +
> +	ret = altera_allocate_domains(msi);
> +	if (ret)
> +		return ret;
> +
> +	msi->irq = platform_get_irq(pdev, 0);
> +	if (msi->irq <= 0) {
> +		dev_err(&pdev->dev, "failed to map IRQ: %d\n", msi->irq);
> +		ret = -ENODEV;
> +		goto err;
> +	}
> +
> +	ret = devm_request_irq(&pdev->dev, msi->irq, altera_msi_isr, 0,
> +				altera_msi_irq_chip.name, msi);
> +	if (ret) {
> +		dev_err(&pdev->dev, "failed to request IRQ: %d\n", ret);
> +		goto err;
> +	}

Turn this into a call to irq_set_chained_handler.

> +
> +	platform_set_drvdata(pdev, msi);
> +
> +	return 0;
> +
> +err:
> +	irq_domain_remove(msi->msi_domain);

You're leaking the inner domain here.

> +	return ret;
> +}
> +
> +static int altera_msi_remove(struct platform_device *pdev)
> +{
> +	struct altera_msi *msi = platform_get_drvdata(pdev);
> +
> +	msi_writel(msi, 0, MSI_INTMASK);
> +
> +	altera_free_domains(msi);
> +
> +	platform_set_drvdata(pdev, NULL);
> +	return 0;
> +}
> +
> +static const struct of_device_id altera_msi_of_match[] = {
> +	{ .compatible = "altr,msi-1.0", NULL },
> +	{ },
> +};
> +MODULE_DEVICE_TABLE(of, altera_msi_of_match);
> +
> +static struct platform_driver altera_msi_driver = {
> +	.driver = {
> +		.name = "altera-msi",
> +		.owner = THIS_MODULE,
> +		.of_match_table = altera_msi_of_match,
> +	},
> +	.probe = altera_msi_probe,
> +	.remove = altera_msi_remove,
> +};
> +
> +static int __init altera_msi_init(void)
> +{
> +	return platform_driver_register(&altera_msi_driver);
> +}
> +
> +subsys_initcall(altera_msi_init);
> +
> +MODULE_AUTHOR("Ley Foon Tan <lftan@altera.com>");
> +MODULE_DESCRIPTION("Altera PCIe MSI support");
> +MODULE_LICENSE("GPL v2");
> 

Thanks,

	M.
-- 
Jazz is not dead. It just smells funny...
