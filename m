Return-Path: <linux-kernel-owner@vger.kernel.org>
Date: Wed, 18 Nov 2015 08:48:45 +0000
From: Marc Zyngier <marc.zyngier@arm.com>
To: Ray Jui <rjui@broadcom.com>
Cc: Bjorn Helgaas <bhelgaas@google.com>, Arnd Bergmann <arnd@arndb.de>,
	"Hauke Mehrtens" <hauke@hauke-m.de>,
	<linux-kernel@vger.kernel.org>,
	<bcm-kernel-feedback-list@broadcom.com>,
	<linux-pci@vger.kernel.org>
Subject: Re: [PATCH 4/5] PCI: iproc: Add iProc PCIe MSI support
Message-ID: <20151118084845.49ba6304@arm.com>
In-Reply-To: <1447806715-30043-5-git-send-email-rjui@broadcom.com>
References: <1447806715-30043-1-git-send-email-rjui@broadcom.com>
	<1447806715-30043-5-git-send-email-rjui@broadcom.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Tue, 17 Nov 2015 16:31:54 -0800
Ray Jui <rjui@broadcom.com> wrote:

Hi Ray,

A few comments below.

> This patch adds PCIe MSI support for both PAXB and PAXC interfaces on
> all iProc based platforms. The patch follows the latest trend in the
> kernel to use MSI domain based implementation
> 
> This iProc event queue based MSI support should not be used with newer
> platforms with integrated MSI support in the GIC (e.g., giv2m or
> gicv3-its)
> 
> Signed-off-by: Ray Jui <rjui@broadcom.com>
> Reviewed-by: Anup Patel <anup.patel@broadcom.com>
> Reviewed-by: Vikram Prakash <vikramp@broadcom.com>
> Reviewed-by: Scott Branden <sbranden@broadcom.com>
> ---
>  drivers/pci/host/Kconfig          |   9 +
>  drivers/pci/host/Makefile         |   1 +
>  drivers/pci/host/pcie-iproc-msi.c | 434 ++++++++++++++++++++++++++++++++++++++
>  drivers/pci/host/pcie-iproc.c     |  19 ++
>  drivers/pci/host/pcie-iproc.h     |  12 ++
>  5 files changed, 475 insertions(+)
>  create mode 100644 drivers/pci/host/pcie-iproc-msi.c
> 
> diff --git a/drivers/pci/host/Kconfig b/drivers/pci/host/Kconfig
> index f131ba9..972e906 100644
> --- a/drivers/pci/host/Kconfig
> +++ b/drivers/pci/host/Kconfig
> @@ -126,6 +126,15 @@ config PCIE_IPROC
>  	  iProc family of SoCs. An appropriate bus interface driver also needs
>  	  to be enabled
>  
> +config PCIE_IPROC_MSI
> +	bool "Broadcom iProc PCIe MSI support"
> +	depends on ARCH_BCM_IPROC && PCI_MSI
> +	select PCI_MSI_IRQ_DOMAIN
> +	default ARCH_BCM_IPROC
> +	help
> +	  Say Y here if you want to enable MSI support for Broadcom's iProc
> +	  PCIe controller
> +
>  config PCIE_IPROC_PLATFORM
>  	tristate "Broadcom iProc PCIe platform bus driver"
>  	depends on ARCH_BCM_IPROC || (ARM && COMPILE_TEST)
> diff --git a/drivers/pci/host/Makefile b/drivers/pci/host/Makefile
> index 9d4d3c6..0e4e95e 100644
> --- a/drivers/pci/host/Makefile
> +++ b/drivers/pci/host/Makefile
> @@ -15,6 +15,7 @@ obj-$(CONFIG_PCI_XGENE_MSI) += pci-xgene-msi.o
>  obj-$(CONFIG_PCI_LAYERSCAPE) += pci-layerscape.o
>  obj-$(CONFIG_PCI_VERSATILE) += pci-versatile.o
>  obj-$(CONFIG_PCIE_IPROC) += pcie-iproc.o
> +obj-$(CONFIG_PCIE_IPROC_MSI) += pcie-iproc-msi.o
>  obj-$(CONFIG_PCIE_IPROC_PLATFORM) += pcie-iproc-platform.o
>  obj-$(CONFIG_PCIE_IPROC_BCMA) += pcie-iproc-bcma.o
>  obj-$(CONFIG_PCIE_ALTERA) += pcie-altera.o
> diff --git a/drivers/pci/host/pcie-iproc-msi.c b/drivers/pci/host/pcie-iproc-msi.c
> new file mode 100644
> index 0000000..a55c707
> --- /dev/null
> +++ b/drivers/pci/host/pcie-iproc-msi.c
> @@ -0,0 +1,434 @@
> +/*
> + * Copyright (C) 2015 Broadcom Corporation
> + *
> + * This program is free software; you can redistribute it and/or
> + * modify it under the terms of the GNU General Public License as
> + * published by the Free Software Foundation version 2.
> + *
> + * This program is distributed "as is" WITHOUT ANY WARRANTY of any
> + * kind, whether express or implied; without even the implied warranty
> + * of MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
> + * GNU General Public License for more details.
> + */
> +
> +#include <linux/irqchip/chained_irq.h>
> +#include <linux/irqdomain.h>
> +#include <linux/msi.h>
> +#include <linux/of_irq.h>
> +#include <linux/of_pci.h>
> +#include <linux/pci.h>
> +
> +#include "pcie-iproc.h"
> +
> +#define IPROC_MSI_INTS_EN_OFFSET       0x208
> +#define IPROC_MSI_INTR_EN_SHIFT        11
> +#define IPROC_MSI_INTR_EN              BIT(IPROC_MSI_INTR_EN_SHIFT)
> +#define IPROC_MSI_INT_N_EVENT_SHIFT    1
> +#define IPROC_MSI_INT_N_EVENT          BIT(IPROC_MSI_INT_N_EVENT_SHIFT)
> +#define IPROC_MSI_EQ_EN_SHIFT          0
> +#define IPROC_MSI_EQ_EN                BIT(IPROC_MSI_EQ_EN_SHIFT)
> +
> +#define IPROC_MSI_EQ_MASK              0x3f
> +
> +/* number of queues in each event queue */
> +#define IPROC_MSI_EQ_LEN               64
> +
> +/* size of each event queue memory region */
> +#define EQ_MEM_REGION_SIZE           SZ_4K
> +
> +/* size of each MSI message memory region */
> +#define MSI_MSG_MEM_REGION_SIZE      SZ_4K
> +
> +enum iproc_msi_reg {
> +	IPROC_MSI_EQ_PAGE = 0,
> +	IPROC_MSI_EQ_PAGE_UPPER,
> +	IPROC_MSI_PAGE,
> +	IPROC_MSI_PAGE_UPPER,
> +	IPROC_MSI_CTRL,
> +	IPROC_MSI_EQ_HEAD,
> +	IPROC_MSI_EQ_TAIL,
> +	IPROC_MSI_REG_SIZE,
> +};
> +
> +/**
> + * iProc event queue based MSI
> + *
> + * Only meant to be used on platforms without MSI support integrated into the
> + * GIC
> + *
> + * @pcie: pointer to iProc PCIe data
> + * @reg_offsets: MSI register offsets
> + * @irqs: pointer to an array that contains the interrupt IDs
> + * @nirqs: number of total interrupts
> + * @has_inten_reg: indicates the MSI interrupt enable register needs to be
> + * set explicitly (required for some legacy platforms)
> + * @used: bitmap to track usage of MSI
> + * @inner_domain: inner IRQ domain
> + * @msi_domain: MSI IRQ domain
> + * @bitmap_lock: lock to protect access to the IRQ bitmap
> + * @n_eq_region: required number of 4K aligned memory region for MSI event
> + * queues
> + * @n_msi_msg_region: required number of 4K aligned memory region for MSI
> + * posted writes
> + * @eq_base: pointer to allocated memory region for MSI event queues
> + * @msi_base: pointer to allocated memory region for MSI posted writes
> + */
> +struct iproc_msi {
> +	struct iproc_pcie *pcie;
> +	const u16 (*reg_offsets)[IPROC_MSI_REG_SIZE];
> +	int *irqs;
> +	int nirqs;
> +	bool has_inten_reg;
> +	DECLARE_BITMAP(used, IPROC_PCIE_MAX_NUM_IRQS);
> +	struct irq_domain *inner_domain;
> +	struct irq_domain *msi_domain;
> +	struct mutex bitmap_lock;
> +	unsigned int n_eq_region;
> +	unsigned int n_msi_msg_region;
> +	void *eq_base;
> +	void *msi_base;
> +};
> +
> +static const u16
> +iproc_msi_reg_paxb[IPROC_PCIE_MAX_NUM_IRQS][IPROC_MSI_REG_SIZE] = {
> +	{ 0x200, 0x2c0, 0x204, 0x2c4, 0x210, 0x250, 0x254 },
> +	{ 0x200, 0x2c0, 0x204, 0x2c4, 0x214, 0x258, 0x25c },
> +	{ 0x200, 0x2c0, 0x204, 0x2c4, 0x218, 0x260, 0x264 },
> +	{ 0x200, 0x2c0, 0x204, 0x2c4, 0x21c, 0x268, 0x26c },
> +	{ 0x200, 0x2c0, 0x204, 0x2c4, 0x220, 0x270, 0x274 },
> +	{ 0x200, 0x2c0, 0x204, 0x2c4, 0x224, 0x278, 0x27c },
> +};
> +
> +static const u16
> +iproc_msi_reg_paxc[IPROC_PCIE_MAX_NUM_IRQS][IPROC_MSI_REG_SIZE] = {
> +	{ 0xc00, 0xc04, 0xc08, 0xc0c, 0xc40, 0xc50, 0xc60 },
> +	{ 0xc10, 0xc14, 0xc18, 0xc1c, 0xc44, 0xc54, 0xc64 },
> +	{ 0xc20, 0xc24, 0xc28, 0xc2c, 0xc48, 0xc58, 0xc68 },
> +	{ 0xc30, 0xc34, 0xc38, 0xc3c, 0xc4c, 0xc5c, 0xc6c },
> +};
> +
> +static inline u32 iproc_msi_read_reg(struct iproc_msi *msi,
> +				     enum iproc_msi_reg reg,
> +				     unsigned int eq)
> +{
> +	struct iproc_pcie *pcie = msi->pcie;
> +
> +	return readl(pcie->base + msi->reg_offsets[eq][reg]);

Do you need the extra barrier implied by readl? readl_relaxed should be
enough.

> +}
> +
> +static inline void iproc_msi_write_reg(struct iproc_msi *msi,
> +				       enum iproc_msi_reg reg,
> +				       int eq, u32 val)
> +{
> +	struct iproc_pcie *pcie = msi->pcie;
> +
> +	writel(val, pcie->base + msi->reg_offsets[eq][reg]);

Same here for writel vs writel_relaxed.

> +}
> +
> +static struct irq_chip iproc_msi_top_irq_chip = {
> +	.name = "iProc MSI",
> +	.irq_enable = pci_msi_unmask_irq,
> +	.irq_disable = pci_msi_mask_irq,
> +	.irq_mask = pci_msi_mask_irq,
> +	.irq_unmask = pci_msi_unmask_irq,

There is no need to provide both enable/disable and mask/unmask. And
since pci_msi_{un}mask_irq is the default, you can get rid of these
function pointers anyway.

> +};
> +
> +static struct msi_domain_info iproc_msi_domain_info = {
> +	.flags = MSI_FLAG_USE_DEF_DOM_OPS | MSI_FLAG_USE_DEF_CHIP_OPS |
> +		MSI_FLAG_PCI_MSIX,
> +	.chip = &iproc_msi_top_irq_chip,
> +};
> +
> +static int iproc_msi_irq_set_affinity(struct irq_data *data,
> +				      const struct cpumask *mask, bool force)
> +{
> +	return -EINVAL;

I wish people would stop building stupid HW that prevents proper
affinity setting for MSI...

> +}
> +
> +static void iproc_msi_irq_compose_msi_msg(struct irq_data *data,
> +					  struct msi_msg *msg)
> +{
> +	struct iproc_msi *msi = irq_data_get_irq_chip_data(data);
> +	phys_addr_t addr;
> +
> +	addr = virt_to_phys(msi->msi_base) | (data->hwirq * 4);
> +	msg->address_lo = lower_32_bits(addr);
> +	msg->address_hi = upper_32_bits(addr);
> +	msg->data = data->hwirq;
> +}
> +
> +static struct irq_chip iproc_msi_bottom_irq_chip = {
> +	.name = "MSI",
> +	.irq_set_affinity = iproc_msi_irq_set_affinity,
> +	.irq_compose_msi_msg = iproc_msi_irq_compose_msi_msg,
> +};
> +
> +static int iproc_msi_irq_domain_alloc(struct irq_domain *domain,
> +				      unsigned int virq, unsigned int nr_irqs,
> +				      void *args)
> +{
> +	struct iproc_msi *msi = domain->host_data;
> +	int i, msi_irq;
> +
> +	mutex_lock(&msi->bitmap_lock);
> +
> +	for (i = 0; i < nr_irqs; i++) {
> +		msi_irq = find_first_zero_bit(msi->used, msi->nirqs);

This is slightly puzzling. Do you really have at most 6 MSIs? Usually,
we end up with a larger number of MSIs (32 or 64) multiplexed on top of
a small number of wired interrupts. Here, you seem to have a 1-1
mapping. Is that really the case?

If so (and assuming the wired interrupts are always contiguous), you
shouldn't represent this as a chained interrupt (a multiplexer), but as
a stacked irqchip, similar to what GICv2m does.

> +		if (msi_irq < msi->nirqs) {
> +			set_bit(msi_irq, msi->used);
> +		} else {
> +			mutex_unlock(&msi->bitmap_lock);
> +			return -ENOSPC;
> +		}
> +
> +		irq_domain_set_info(domain, virq + i, msi_irq,
> +				    &iproc_msi_bottom_irq_chip,
> +				    domain->host_data, handle_simple_irq,
> +				    NULL, NULL);
> +	}
> +
> +	mutex_unlock(&msi->bitmap_lock);
> +	return 0;
> +}
> +
> +static void iproc_msi_irq_domain_free(struct irq_domain *domain,
> +				      unsigned int virq, unsigned int nr_irqs)
> +{
> +	struct irq_data *data = irq_domain_get_irq_data(domain, virq);
> +	struct iproc_msi *msi = irq_data_get_irq_chip_data(data);
> +	unsigned int i;
> +
> +	mutex_lock(&msi->bitmap_lock);
> +
> +	for (i = 0; i < nr_irqs; i++) {
> +		struct irq_data *data = irq_domain_get_irq_data(domain,
> +								virq + i);
> +		if (!test_bit(data->hwirq, msi->used)) {
> +			dev_warn(msi->pcie->dev, "freeing unused MSI %lu\n",
> +				 data->hwirq);
> +		} else
> +			clear_bit(data->hwirq, msi->used);
> +	}
> +
> +	mutex_unlock(&msi->bitmap_lock);
> +	irq_domain_free_irqs_parent(domain, virq, nr_irqs);
> +}
> +
> +static const struct irq_domain_ops msi_domain_ops = {
> +	.alloc = iproc_msi_irq_domain_alloc,
> +	.free = iproc_msi_irq_domain_free,
> +};
> +
> +static void iproc_msi_enable(struct iproc_msi *msi)
> +{
> +	struct iproc_pcie *pcie = msi->pcie;
> +	int i, eq;
> +	u32 val;
> +
> +	/* program memory region for each event queue */
> +	for (i = 0; i < msi->n_eq_region; i++) {
> +		phys_addr_t addr =
> +			virt_to_phys(msi->eq_base + (i * EQ_MEM_REGION_SIZE));
> +
> +		iproc_msi_write_reg(msi, IPROC_MSI_EQ_PAGE, i,
> +				    lower_32_bits(addr));
> +		iproc_msi_write_reg(msi, IPROC_MSI_EQ_PAGE_UPPER, i,
> +				    upper_32_bits(addr));
> +	}
> +
> +	/* program memory region for MSI posted writes */
> +	for (i = 0; i < msi->n_msi_msg_region; i++) {
> +		phys_addr_t addr =
> +			virt_to_phys(msi->msi_base +
> +				     (i * MSI_MSG_MEM_REGION_SIZE));

You seem to be a victim of checkpatch. Please don't split statements
like this, it just make it harder to read. My terminal can wrap lines
very conveniently, and I don't care about the 80 character limit...

> +
> +		iproc_msi_write_reg(msi, IPROC_MSI_PAGE, i,
> +				    lower_32_bits(addr));
> +		iproc_msi_write_reg(msi, IPROC_MSI_PAGE_UPPER, i,
> +				    upper_32_bits(addr));
> +	}
> +
> +	for (eq = 0; eq < msi->nirqs; eq++) {
> +		/* enable MSI event queue */
> +		val = IPROC_MSI_INTR_EN | IPROC_MSI_INT_N_EVENT |
> +			IPROC_MSI_EQ_EN;
> +		iproc_msi_write_reg(msi, IPROC_MSI_CTRL, eq, val);
> +
> +		/*
> +		 * Some legacy platforms require the MSI interrupt enable
> +		 * register to be set explicitly
> +		 */
> +		if (msi->has_inten_reg) {
> +			val = readl(pcie->base + IPROC_MSI_INTS_EN_OFFSET);
> +			val |= BIT(eq);
> +			writel(val, pcie->base + IPROC_MSI_INTS_EN_OFFSET);
> +		}
> +	}
> +}
> +
> +static void iproc_msi_handler(struct irq_desc *desc)
> +{
> +	unsigned int irq = irq_desc_get_irq(desc);
> +	struct irq_chip *irq_chip = irq_desc_get_chip(desc);
> +	struct iproc_msi *msi;
> +	struct iproc_pcie *pcie;
> +	u32 eq, head, tail, num_events;
> +	int virq;
> +
> +	chained_irq_enter(irq_chip, desc);
> +
> +	msi = irq_get_handler_data(irq);
> +	pcie = msi->pcie;
> +
> +	eq = irq - msi->irqs[0];
> +	virq = irq_find_mapping(msi->inner_domain, eq);
> +	head = iproc_msi_read_reg(msi, IPROC_MSI_EQ_HEAD, eq) &
> +		IPROC_MSI_EQ_MASK;
> +	do {
> +		tail = iproc_msi_read_reg(msi, IPROC_MSI_EQ_TAIL, eq) &
> +			IPROC_MSI_EQ_MASK;
> +
> +		num_events = (tail < head) ?
> +			(IPROC_MSI_EQ_LEN - (head - tail)) : (tail - head);
> +		if (!num_events)
> +			break;
> +
> +		generic_handle_irq(virq);
> +
> +		head++;
> +		head %= IPROC_MSI_EQ_LEN;
> +		iproc_msi_write_reg(msi, IPROC_MSI_EQ_HEAD, eq, head);
> +	} while (true);

That's unusual. You seem to get only one interrupt for a bunch of MSIs,
all representing the same IRQ? That feels very weird, as you can
usually collapse edge interrupts.

> +
> +	chained_irq_exit(irq_chip, desc);
> +}
> +
> +int iproc_msi_init(struct iproc_pcie *pcie, struct device_node *node)
> +{
> +	struct iproc_msi *msi;
> +	struct device_node *parent_node;
> +	struct irq_domain *parent_domain;
> +	int i, ret;
> +
> +	if (!of_device_is_compatible(node, "brcm,iproc-msi"))
> +		return -ENODEV;
> +
> +	if (!of_find_property(node, "msi-controller", NULL))
> +		return -ENODEV;
> +
> +	parent_node = of_parse_phandle(node, "interrupt-parent", 0);
> +	if (!parent_node) {
> +		dev_err(pcie->dev, "unable to parse MSI interrupt parent\n");
> +		return -ENODEV;
> +	}
> +
> +	parent_domain = irq_find_host(parent_node);
> +	if (!parent_domain) {
> +		dev_err(pcie->dev, "unable to get MSI parent domain\n");
> +		return -ENODEV;
> +	}
> +
> +	msi = devm_kzalloc(pcie->dev, sizeof(*msi), GFP_KERNEL);
> +	if (!msi)
> +		return -ENOMEM;
> +
> +	msi->pcie = pcie;
> +	mutex_init(&msi->bitmap_lock);
> +
> +	switch (pcie->type) {
> +	case IPROC_PCIE_PAXB:
> +		msi->reg_offsets = iproc_msi_reg_paxb;
> +		break;
> +	case IPROC_PCIE_PAXC:
> +		msi->reg_offsets = iproc_msi_reg_paxc;
> +		break;
> +	default:
> +		dev_err(pcie->dev, "incompatible iProc PCIe interface\n");
> +		return -EINVAL;
> +	}
> +
> +	ret = of_property_read_u32(node, "brcm,num-eq-region",
> +				   &msi->n_eq_region);
> +	if (ret || msi->n_eq_region == 0) {
> +		dev_err(pcie->dev,
> +			"invalid property 'brcm,num-eq-region' %u\n",
> +			msi->n_eq_region);
> +		return -ENODEV;
> +	}
> +
> +	ret = of_property_read_u32(node, "brcm,num-msi-msg-region",
> +				   &msi->n_msi_msg_region);
> +	if (ret || msi->n_msi_msg_region == 0) {
> +		dev_err(pcie->dev,
> +			"invalid property 'brcm,num-msi-msg-region' %u\n",
> +			msi->n_msi_msg_region);
> +		return -ENODEV;
> +	}
> +
> +	/* reserve memory for MSI event queue */
> +	msi->eq_base = devm_kcalloc(pcie->dev, msi->n_eq_region + 1,
> +				    EQ_MEM_REGION_SIZE, GFP_KERNEL);
> +	if (!msi->eq_base)
> +		return -ENOMEM;
> +	msi->eq_base = PTR_ALIGN(msi->eq_base, EQ_MEM_REGION_SIZE);
> +
> +	/* reserve memory for MSI posted writes */
> +	msi->msi_base = devm_kcalloc(pcie->dev, msi->n_msi_msg_region + 1,
> +				     MSI_MSG_MEM_REGION_SIZE, GFP_KERNEL);
> +	if (!msi->msi_base)
> +		return -ENOMEM;
> +	msi->msi_base = PTR_ALIGN(msi->msi_base, MSI_MSG_MEM_REGION_SIZE);
> +
> +	if (of_find_property(node, "brcm,pcie-msi-inten", NULL))
> +		msi->has_inten_reg = true;
> +
> +	msi->nirqs = of_irq_count(node);
> +	if (!msi->nirqs) {
> +		dev_err(pcie->dev, "found no MSI interrupt in DT\n");
> +		return -ENODEV;
> +	}
> +	if (msi->nirqs > IPROC_PCIE_MAX_NUM_IRQS) {
> +		dev_warn(pcie->dev, "too many MSI interrupts defined %d\n",
> +			 msi->nirqs);
> +		msi->nirqs = IPROC_PCIE_MAX_NUM_IRQS;
> +	}
> +	msi->irqs = devm_kcalloc(pcie->dev, msi->nirqs, sizeof(*msi->irqs),
> +				 GFP_KERNEL);
> +	if (!msi->irqs)
> +		return -ENOMEM;
> +
> +	for (i = 0; i < msi->nirqs; i++) {
> +		msi->irqs[i] = irq_of_parse_and_map(node, i);
> +		if (!msi->irqs[i]) {
> +			dev_err(pcie->dev, "unable to parse/map interrupt\n");
> +			return -ENODEV;
> +		}
> +	}
> +
> +	msi->inner_domain = irq_domain_add_hierarchy(parent_domain, 0,
> +						     msi->nirqs, NULL,
> +						     &msi_domain_ops,
> +						     msi);
> +	if (!msi->inner_domain) {
> +		dev_err(pcie->dev, "failed to create inner domain\n");
> +		return -ENOMEM;
> +	}
> +
> +	msi->msi_domain = pci_msi_create_irq_domain(of_node_to_fwnode(node),
> +						    &iproc_msi_domain_info,
> +						    msi->inner_domain);
> +	if (!msi->msi_domain) {
> +		dev_err(pcie->dev, "failed to create MSI domain\n");
> +		irq_domain_remove(msi->inner_domain);
> +		return -ENOMEM;
> +	}
> +
> +	for (i = 0; i < msi->nirqs; i++)
> +		irq_set_chained_handler_and_data(msi->irqs[i],
> +						 iproc_msi_handler, msi);
> +
> +	iproc_msi_enable(msi);
> +
> +	return 0;
> +}
> +EXPORT_SYMBOL(iproc_msi_init);

Do you really intend for this to be built as a standalone module?

> diff --git a/drivers/pci/host/pcie-iproc.c b/drivers/pci/host/pcie-iproc.c
> index 24d5b62..a575ef3 100644
> --- a/drivers/pci/host/pcie-iproc.c
> +++ b/drivers/pci/host/pcie-iproc.c
> @@ -440,6 +440,21 @@ static int iproc_pcie_map_ranges(struct iproc_pcie *pcie,
>  	return 0;
>  }
>  
> +static int iproc_pcie_msi_enable(struct iproc_pcie *pcie)
> +{
> +	struct device_node *msi_node;
> +
> +	msi_node = of_parse_phandle(pcie->dev->of_node, "msi-parent", 0);
> +	if (!msi_node)
> +		return -ENODEV;
> +
> +	/*
> +	 * If another MSI controller is being used, the call below should fail
> +	 * but that is okay
> +	 */
> +	return iproc_msi_init(pcie, msi_node);
> +}
> +
>  int iproc_pcie_setup(struct iproc_pcie *pcie, struct list_head *res)
>  {
>  	int ret;
> @@ -507,6 +522,10 @@ int iproc_pcie_setup(struct iproc_pcie *pcie, struct list_head *res)
>  
>  	iproc_pcie_enable(pcie);
>  
> +	if (IS_ENABLED(CONFIG_PCI_MSI))
> +		if (iproc_pcie_msi_enable(pcie))
> +			dev_info(pcie->dev, "not using iProc MSI\n");
> +
>  	pci_scan_child_bus(bus);
>  	pci_assign_unassigned_bus_resources(bus);
>  	pci_fixup_irqs(pci_common_swizzle, pcie->map_irq);
> diff --git a/drivers/pci/host/pcie-iproc.h b/drivers/pci/host/pcie-iproc.h
> index 051b651..17317ef 100644
> --- a/drivers/pci/host/pcie-iproc.h
> +++ b/drivers/pci/host/pcie-iproc.h
> @@ -14,6 +14,8 @@
>  #ifndef _PCIE_IPROC_H
>  #define _PCIE_IPROC_H
>  
> +#define IPROC_PCIE_MAX_NUM_IRQS 6
> +

I don't see the point in putting this in an include file, as it is only
used in a single location.

>  /**
>   * iProc PCIe interface type
>   *
> @@ -74,4 +76,14 @@ struct iproc_pcie {
>  int iproc_pcie_setup(struct iproc_pcie *pcie, struct list_head *res);
>  int iproc_pcie_remove(struct iproc_pcie *pcie);
>  
> +#ifdef CONFIG_PCI_MSI
> +int iproc_msi_init(struct iproc_pcie *pcie, struct device_node *node);
> +#else
> +static inline int iproc_msi_init(struct iproc_pcie *pcie,
> +				 struct device_node *node)
> +{
> +	return -ENODEV;
> +}
> +#endif
> +
>  #endif /* _PCIE_IPROC_H */

Thanks,

	M.
-- 
Jazz is not dead. It just smells funny.
