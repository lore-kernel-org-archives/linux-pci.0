Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-we0-f175.google.com ([74.125.82.175]:35212 "EHLO
	mail-we0-f175.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752588Ab3FKNhu (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Tue, 11 Jun 2013 09:37:50 -0400
Received: by mail-we0-f175.google.com with SMTP id t59so5969474wes.34
        for <linux-pci@vger.kernel.org>; Tue, 11 Jun 2013 06:37:48 -0700 (PDT)
From: Grant Likely <grant.likely@secretlab.ca>
Subject: Re: [PATCH v2 4/8] irqchip: armada-370-xp: implement MSI support
To: Thomas Petazzoni <thomas.petazzoni@free-electrons.com>,
	Bjorn Helgaas <bhelgaas@google.com>, linux-pci@vger.kernel.org,
	Arnd Bergmann <arnd@arndb.de>,
	Jason Gunthorpe <jgunthorpe@obsidianresearch.com>,
	Thierry Reding <thierry.reding@avionic-design.de>
Cc: Lior Amsalem <alior@marvell.com>, Andrew Lunn <andrew@lunn.ch>,
	Jason Cooper <jason@lakedaemon.net>,
	Maen Suleiman <maen@marvell.com>,
	Ezequiel Garcia <ezequiel.garcia@free-electrons.com>,
	Gregory Clement <gregory.clement@free-electrons.com>,
	linux-arm-kernel@lists.infradead.org
In-Reply-To: <1370536888-8871-5-git-send-email-thomas.petazzoni@free-electrons.com>
References: <1370536888-8871-1-git-send-email-thomas.petazzoni@free-electrons.com> <1370536888-8871-5-git-send-email-thomas.petazzoni@free-electrons.com>
Date: Tue, 11 Jun 2013 14:37:45 +0100
Message-Id: <20130611133745.514CA3E0A90@localhost>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Thu,  6 Jun 2013 18:41:24 +0200, Thomas Petazzoni <thomas.petazzoni@free-electrons.com> wrote:
> This commit introduces the support for the MSI interrupts in the
> armada-370-xp interrupt controller driver. It registers an MSI chip to
> the MSI chip registry, which will be used by the Marvell PCIe host
> controller driver.
> 
> The MSI interrupts use the 16 high doorbells, and are therefore
> notified using IRQ1 of the main interrupt controller.
> 
> Signed-off-by: Thomas Petazzoni <thomas.petazzoni@free-electrons.com>
> ---
>  drivers/irqchip/irq-armada-370-xp.c | 166 +++++++++++++++++++++++++++++++++++-
>  1 file changed, 165 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/irqchip/irq-armada-370-xp.c b/drivers/irqchip/irq-armada-370-xp.c
> index 26adc74..c7c904d 100644
> --- a/drivers/irqchip/irq-armada-370-xp.c
> +++ b/drivers/irqchip/irq-armada-370-xp.c
> @@ -22,6 +22,8 @@
>  #include <linux/of_address.h>
>  #include <linux/of_irq.h>
>  #include <linux/irqdomain.h>
> +#include <linux/slab.h>
> +#include <linux/msi.h>
>  #include <asm/mach/arch.h>
>  #include <asm/exception.h>
>  #include <asm/smp_plat.h>
> @@ -51,12 +53,22 @@
>  #define IPI_DOORBELL_START                      (0)
>  #define IPI_DOORBELL_END                        (8)
>  #define IPI_DOORBELL_MASK                       0xFF
> +#define PCI_MSI_DOORBELL_START                  (16)
> +#define PCI_MSI_DOORBELL_NR                     (16)
> +#define PCI_MSI_DOORBELL_END                    (32)
> +#define PCI_MSI_DOORBELL_MASK                   0xFFFF0000
>  
>  static DEFINE_RAW_SPINLOCK(irq_controller_lock);
>  
>  static void __iomem *per_cpu_int_base;
>  static void __iomem *main_int_base;
>  static struct irq_domain *armada_370_xp_mpic_domain;
> +#ifdef CONFIG_PCI_MSI
> +static struct irq_domain *armada_370_xp_msi_domain;
> +static DECLARE_BITMAP(msi_used, PCI_MSI_DOORBELL_NR);
> +static DEFINE_MUTEX(msi_used_lock);
> +static phys_addr_t msi_doorbell_addr;
> +#endif
>  
>  /*
>   * In SMP mode:
> @@ -87,6 +99,126 @@ static void armada_370_xp_irq_unmask(struct irq_data *d)
>  				ARMADA_370_XP_INT_CLEAR_MASK_OFFS);
>  }
>  
> +#ifdef CONFIG_PCI_MSI
> +static int armada_370_xp_alloc_msi(void)
> +{
> +	int hwirq;
> +
> +	mutex_lock(&msi_used_lock);
> +	hwirq = find_first_zero_bit(&msi_used, PCI_MSI_DOORBELL_NR);
> +	if (hwirq >= PCI_MSI_DOORBELL_NR)
> +		hwirq = -ENOSPC;
> +	else
> +		set_bit(hwirq, msi_used);
> +	mutex_unlock(&msi_used_lock);
> +
> +	return hwirq;
> +}
> +
> +static void armada_370_xp_free_msi(int hwirq)
> +{
> +	mutex_lock(&msi_used_lock);
> +	if (!test_bit(hwirq, msi_used))
> +		pr_err("trying to free unused MSI#%d\n", hwirq);
> +	else
> +		clear_bit(hwirq, msi_used);
> +       mutex_unlock(&msi_used_lock);
> +}
> +
> +static int armada_370_xp_setup_msi_irq(struct msi_chip *chip,
> +				       struct pci_dev *pdev,
> +				       struct msi_desc *desc)
> +{
> +	struct msi_msg msg;
> +	int hwirq, irq;
> +
> +	hwirq = armada_370_xp_alloc_msi();
> +	if (hwirq < 0)
> +		return hwirq;
> +
> +	irq = irq_create_mapping(armada_370_xp_msi_domain, hwirq);
> +	if (!irq) {
> +		armada_370_xp_free_msi(hwirq);
> +		return -EINVAL;
> +	}

This looks like something that the irq_domain should handle for you.
It would be good to have a variant of irq_create_mapping() that keeps
track of available hwirqs, allocates a free one, and maps it all with
one function call. I can see that being useful by other MSI interrupt
controllers and would eliminate needing to open-code it above.

take a look at the irqdomain/test branch on git://git.secretlab.ca/git/linux

I'm hoping to push that series into v3.11 and it simplifies the
irq_domain code quite a bit. It would be easy to build an
irq_create_mapping() variant on top of that. Take a look at
irq_create_direct_mapping() for inspiration (although that function does
it the other way around. It allocates a virq and uses that number for
the hwirq number)

> +static int armada_370_xp_msi_init(struct device_node *node)
> +{
> +	struct msi_chip *msi_chip;
> +	u32 reg;
> +
> +	msi_chip = kzalloc(sizeof(*msi_chip), GFP_KERNEL);

devm_kzalloc() so it gets freed on failure or unbind; although for this
device you may not care.

> +	if (!msi_chip)
> +		return -ENOMEM;
> +
> +	armada_370_xp_msi_domain =
> +		irq_domain_add_linear(NULL, PCI_MSI_DOORBELL_NR,
> +				      &armada_370_xp_msi_irq_ops, NULL);
> +	if (!armada_370_xp_msi_domain) {
> +		kfree(msi_chip);
> +		return -ENOMEM;
> +	}
> +
> +	msi_chip->of_node = node;
> +	msi_chip->setup_irq = armada_370_xp_setup_msi_irq;
> +	msi_chip->teardown_irq = armada_370_xp_teardown_msi_irq;
> +
> +	msi_chip_add(msi_chip);
> +
> +	reg = readl(per_cpu_int_base + ARMADA_370_XP_IN_DRBEL_MSK_OFFS)
> +		| PCI_MSI_DOORBELL_MASK;
> +
> +	writel(reg, per_cpu_int_base +
> +	       ARMADA_370_XP_IN_DRBEL_MSK_OFFS);
> +
> +	/* Unmask IPI interrupt */
> +	writel(1, per_cpu_int_base + ARMADA_370_XP_INT_CLEAR_MASK_OFFS);
> +
> +	return 0;
> +}
> +#else
> +static inline int armada_370_xp_msi_init(struct device_node *node) { return 0; }
> +#endif
> +
>  #ifdef CONFIG_SMP
>  static int armada_xp_set_affinity(struct irq_data *d,
>  				  const struct cpumask *mask_val, bool force)
> @@ -214,12 +346,39 @@ armada_370_xp_handle_irq(struct pt_regs *regs)
>  		if (irqnr > 1022)
>  			break;
>  
> -		if (irqnr > 0) {
> +		if (irqnr > 1) {
>  			irqnr =	irq_find_mapping(armada_370_xp_mpic_domain,
>  					irqnr);
>  			handle_IRQ(irqnr, regs);
>  			continue;
>  		}
> +
> +#ifdef CONFIG_PCI_MSI
> +		/* MSI handling */
> +		if (irqnr == 1) {
> +			u32 msimask, msinr;
> +
> +			msimask = readl_relaxed(per_cpu_int_base +
> +						ARMADA_370_XP_IN_DRBEL_CAUSE_OFFS)
> +				& PCI_MSI_DOORBELL_MASK;
> +
> +			writel(~PCI_MSI_DOORBELL_MASK, per_cpu_int_base +
> +			       ARMADA_370_XP_IN_DRBEL_CAUSE_OFFS);
> +
> +			for (msinr = PCI_MSI_DOORBELL_START;
> +			     msinr < PCI_MSI_DOORBELL_END; msinr++) {
> +				int irq;
> +
> +				if (!(msimask & BIT(msinr)))
> +					continue;
> +
> +				irq = irq_find_mapping(armada_370_xp_msi_domain,
> +						       msinr - 16);
> +				handle_IRQ(irq, regs);
> +			}
> +		}
> +#endif
> +
>  #ifdef CONFIG_SMP
>  		/* IPI Handling */
>  		if (irqnr == 0) {
> @@ -269,6 +428,9 @@ static int __init armada_370_xp_mpic_of_init(struct device_node *node,
>  				   resource_size(&per_cpu_int_res));
>  	BUG_ON(!per_cpu_int_base);
>  
> +	msi_doorbell_addr = main_int_res.start +
> +		ARMADA_370_XP_SW_TRIG_INT_OFFS;
> +
>  	control = readl(main_int_base + ARMADA_370_XP_INT_CONTROL);
>  
>  	armada_370_xp_mpic_domain =
> @@ -292,6 +454,8 @@ static int __init armada_370_xp_mpic_of_init(struct device_node *node,
>  
>  #endif
>  
> +	armada_370_xp_msi_init(node);
> +
>  	set_handle_irq(armada_370_xp_handle_irq);
>  
>  	return 0;
> -- 
> 1.8.1.2
> 
> 
> _______________________________________________
> linux-arm-kernel mailing list
> linux-arm-kernel@lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel

-- 
Grant Likely, B.Sc, P.Eng.
Secret Lab Technologies, Ltd.
