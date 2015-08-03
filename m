Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-lb0-f171.google.com ([209.85.217.171]:35739 "EHLO
	mail-lb0-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751705AbbHCKhd (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Mon, 3 Aug 2015 06:37:33 -0400
MIME-Version: 1.0
In-Reply-To: <55BB6621.9060505@arm.com>
References: <1438337715-22594-1-git-send-email-lftan@altera.com>
	<1438337715-22594-4-git-send-email-lftan@altera.com>
	<55BB6621.9060505@arm.com>
Date: Mon, 3 Aug 2015 18:37:30 +0800
Message-ID: <CAFiDJ5-5eZEBFwbuzrPB+XKX_E2Fd0qEeP-_H3Wz2jT8pcbJfQ@mail.gmail.com>
Subject: Re: [PATCH v2 3/5] pci: altera: Add Altera PCIe MSI driver
From: Ley Foon Tan <lftan@altera.com>
To: Marc Zyngier <marc.zyngier@arm.com>
Cc: Bjorn Helgaas <bhelgaas@google.com>,
	Russell King <linux@arm.linux.org.uk>,
	Arnd Bergmann <arnd@arndb.de>,
	Dinh Nguyen <dinguyen@opensource.altera.com>,
	devicetree@vger.kernel.org,
	"linux-doc@vger.kernel.org" <linux-doc@vger.kernel.org>,
	linux-pci@vger.kernel.org,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	Rob Herring <robh+dt@kernel.org>,
	linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset=UTF-8
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Fri, Jul 31, 2015 at 8:12 PM, Marc Zyngier <marc.zyngier@arm.com> wrote:
> On 31/07/15 11:15, Ley Foon Tan wrote:
>> This patch adds Altera PCIe MSI driver. This soft IP supports configurable
>> number of vectors, which is a dts parameter.
>
> I've reviewed the initial drop of this code; basic courtesy would be to
> keep me CCed on the follow-up series.
Will keep you in CC for the following revision. Sorry about this.

>>
>> Signed-off-by: Ley Foon Tan <lftan@altera.com>
>> ---
>>  drivers/pci/host/Kconfig           |   7 +
>>  drivers/pci/host/Makefile          |   1 +
>>  drivers/pci/host/pcie-altera-msi.c | 324 +++++++++++++++++++++++++++++++++++++
>>  3 files changed, 332 insertions(+)
>>  create mode 100644 drivers/pci/host/pcie-altera-msi.c
>>
>> diff --git a/drivers/pci/host/Kconfig b/drivers/pci/host/Kconfig
>> index 108500a..51d0468 100644
>> --- a/drivers/pci/host/Kconfig
>> +++ b/drivers/pci/host/Kconfig
>> @@ -153,4 +153,11 @@ config PCIE_ALTERA
>>         Say Y here if you want to enable PCIe controller support for Altera
>>         SoCFPGA family of SoCs.
>>
>> +config PCIE_ALTERA_MSI
>> +     bool "Altera PCIe MSI feature"
>> +     depends on PCI_MSI
>> +     help
>> +       Say Y here if you want PCIe MSI support for the Altera SocFPGA SoC.
>> +       This MSI driver supports Altera MSI to GIC controller IP.
>> +
>>  endmenu
>> diff --git a/drivers/pci/host/Makefile b/drivers/pci/host/Makefile
>> index 6954f76..6c4913d 100644
>> --- a/drivers/pci/host/Makefile
>> +++ b/drivers/pci/host/Makefile
>> @@ -18,3 +18,4 @@ obj-$(CONFIG_PCIE_IPROC) += pcie-iproc.o
>>  obj-$(CONFIG_PCIE_IPROC_PLATFORM) += pcie-iproc-platform.o
>>  obj-$(CONFIG_PCIE_IPROC_BCMA) += pcie-iproc-bcma.o
>>  obj-$(CONFIG_PCIE_ALTERA) += pcie-altera.o
>> +obj-$(CONFIG_PCIE_ALTERA_MSI) += pcie-altera-msi.o
>> diff --git a/drivers/pci/host/pcie-altera-msi.c b/drivers/pci/host/pcie-altera-msi.c
>> new file mode 100644
>> index 0000000..6014719
>> --- /dev/null
>> +++ b/drivers/pci/host/pcie-altera-msi.c
>> @@ -0,0 +1,324 @@
>> +/*
>> + * Copyright Altera Corporation (C) 2013-2015. All rights reserved
>> + *
>> + * This program is free software; you can redistribute it and/or modify it
>> + * under the terms and conditions of the GNU General Public License,
>> + * version 2, as published by the Free Software Foundation.
>> + *
>> + * This program is distributed in the hope it will be useful, but WITHOUT
>> + * ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or
>> + * FITNESS FOR A PARTICULAR PURPOSE.  See the GNU General Public License for
>> + * more details.
>> + *
>> + * You should have received a copy of the GNU General Public License along with
>> + * this program.  If not, see <http://www.gnu.org/licenses/>.
>> + */
>> +#include <linux/interrupt.h>
>> +#include <linux/irqchip/chained_irq.h>
>> +#include <linux/module.h>
>> +#include <linux/msi.h>
>> +#include <linux/of_address.h>
>> +#include <linux/of_irq.h>
>> +#include <linux/of_pci.h>
>> +#include <linux/pci.h>
>> +#include <linux/platform_device.h>
>> +#include <linux/slab.h>
>> +
>> +#define MSI_STATUS           0x0
>> +#define MSI_ERROR            0x4
>> +#define MSI_INTMASK          0x8
>> +
>> +#define MAX_MSI_VECTORS              32
>> +struct altera_msi {
>> +     DECLARE_BITMAP(used, MAX_MSI_VECTORS);
>> +     struct mutex            lock;   /* proctect used variable */
>> +     struct platform_device  *pdev;
>> +     struct irq_domain               *msi_domain;
>> +     struct irq_domain               *inner_domain;
>> +     void __iomem            *csr_base;
>> +     void __iomem            *vector_base;
>> +     phys_addr_t             vector_phy;
>> +     u32                     num_of_vectors;
>> +     int                     irq;
>> +};
>> +
>> +static inline void msi_writel(struct altera_msi *msi, u32 value, u32 reg)
>> +{
>> +     writel_relaxed(value, msi->csr_base + reg);
>> +}
>> +
>> +static inline u32 msi_readl(struct altera_msi *msi, u32 reg)
>> +{
>> +     return readl_relaxed(msi->csr_base + reg);
>> +}
>> +
>> +static void altera_msi_isr(unsigned int irq, struct irq_desc *desc)
>> +{
>> +     struct irq_chip *chip = irq_desc_get_chip(desc);
>> +     struct altera_msi *msi;
>> +     unsigned long status;
>> +     u32 num_of_vectors;
>> +     u32 bit;
>> +
>> +     chained_irq_enter(chip, desc);
>> +     msi = irq_desc_get_handler_data(desc);
>> +     num_of_vectors = msi->num_of_vectors;
>> +
>> +     do {
>> +             status = msi_readl(msi, MSI_STATUS);
>> +             if (!status)
>> +                     break;
>> +
>> +             do {
>> +                     bit = find_first_bit(&status, num_of_vectors);
>> +                     /* Dummy read from vector to clear the interrupt */
>> +                     readl_relaxed(msi->vector_base + (bit * sizeof(u32)));
>> +
>> +                     irq = irq_find_mapping(msi->inner_domain, bit);
>
> Use of irq is a bit confusing, as this is a parameter describing the
> chaining interrupt. Consider using a different name for this variable.
Okay, will change it to 'virq'.

>
>> +                     if (irq) {
>> +                             if (test_bit(bit, msi->used))
>> +                                     generic_handle_irq(irq);
>> +                             else
>> +                                     dev_info(&msi->pdev->dev, "unhandled MSI\n");
>> +                     } else
>> +                             dev_info(&msi->pdev->dev, "unexpected MSI\n");
>
> The whole statement could be rewritten as:
>
> if (irq && test_bit(bit, msi->used))
>         generic_handle_irq(irq);
> else
>         dev_err(...);
>
> In all cases, this is a grave error, so dev_info is not appropriate here.
Noted.

>
>> +
>> +                     /* Clear the bit from status and repeat without reading
>> +                      * again status register. */
>> +                     clear_bit(bit, &status);
>
> You don't need an atomic operation here, so __clear_bit() should be enough.
Noted.

>
>> +             } while (status);
>> +     } while (1);
>> +
>> +     chained_irq_exit(chip, desc);
>> +}
>> +
>> +static struct irq_chip altera_msi_irq_chip = {
>> +     .name = "Altera PCIe MSI",
>> +     .irq_enable = pci_msi_unmask_irq,
>> +     .irq_disable = pci_msi_mask_irq,
>> +     .irq_mask = pci_msi_mask_irq,
>> +     .irq_unmask = pci_msi_unmask_irq,
>> +};
>> +
>> +static struct msi_domain_info altera_msi_domain_info = {
>> +     .flags  = (MSI_FLAG_USE_DEF_DOM_OPS | MSI_FLAG_USE_DEF_CHIP_OPS |
>> +                  MSI_FLAG_PCI_MSIX),
>> +     .chip   = &altera_msi_irq_chip,
>> +};
>> +
>> +static void altera_compose_msi_msg(struct irq_data *data, struct msi_msg *msg)
>> +{
>> +     u32 mask;
>> +     struct altera_msi *msi = irq_data_get_irq_chip_data(data);
>> +     u64 addr = msi->vector_phy + (data->hwirq * sizeof(u32));
>
> Use phys_addr_t.
Noted.

>
>> +
>> +     msg->address_lo = lower_32_bits(addr);
>> +     msg->address_hi = upper_32_bits(addr);
>> +     msg->data = data->hwirq;
>> +
>> +     mask = msi_readl(msi, MSI_INTMASK);
>> +     mask |= 1 << data->hwirq;
>> +     msi_writel(msi, mask, MSI_INTMASK);
>
> It feels a bit weird to unmask the interrupt when you compose the
> message. I'd expect this to be done in the mask/unmask methods.
Do you refer to these 2 callbacks?
.irq_mask = pci_msi_mask_irq,
.irq_unmask = pci_msi_unmask_irq,

How about we move this INTMASK code above to altera_irq_domain_alloc()?
We have unmask code in altera_irq_domain_free() now.

>
>> +     dev_dbg(&msi->pdev->dev, "msi#%d address_lo 0x%x\n", (int)data->hwirq,
>> +             msg->address_lo);
>
> You may want to print the whole address here.
Noted.

>
>> +}
>> +
>> +static int altera_msi_set_affinity(struct irq_data *irq_data,
>> +                              const struct cpumask *mask, bool force)
>> +{
>> +      return -EINVAL;
>> +}
>> +
>> +static struct irq_chip altera_msi_bottom_irq_chip = {
>> +     .name                   = "Altera MSI",
>> +     .irq_compose_msi_msg    = altera_compose_msi_msg,
>> +     .irq_set_affinity       = altera_msi_set_affinity,
>> +};
>> +
>> +static int altera_irq_domain_alloc(struct irq_domain *domain, unsigned int virq,
>> +                               unsigned int nr_irqs, void *args)
>> +{
>> +     struct altera_msi *msi = domain->host_data;
>> +     int bit;
>> +
>> +     mutex_lock(&msi->lock);
>> +
>> +     bit = find_first_zero_bit(msi->used, msi->num_of_vectors);
>> +     if (bit < msi->num_of_vectors)
>> +             set_bit(bit, msi->used);
>> +
>> +     mutex_unlock(&msi->lock);
>> +
>> +     if (bit < 0)
>> +             return bit;
>
> How can "bit" be negative here? find_first_zero_bit returns an unsigned
> long... You probably want to change the type of "bit" to reflect that.
Okay, will change to "unsigned long" type.
>
>> +     else if (bit >= msi->num_of_vectors)
>
> Useless "else" anyway.

I think we still need to check for failing case, if we don't have
available unused bit.
This could be rewritten  as below:

bit = find_first_zero_bit(msi->used, msi->num_of_vectors);
if (bit < msi->num_of_vectors)
      set_bit(bit, msi->used);
else
      return -ENOSPC;

>
>> +             return -ENOSPC;
>> +
>> +     irq_domain_set_info(domain, virq, bit, &altera_msi_bottom_irq_chip,
>> +                         domain->host_data, handle_simple_irq,
>> +                         NULL, NULL);
>> +     set_irq_flags(virq, IRQF_VALID);
>> +
>> +     return 0;
>> +}
>> +
>> +static void altera_irq_domain_free(struct irq_domain *domain,
>> +                               unsigned int virq, unsigned int nr_irqs)
>> +{
>> +     struct irq_data *d = irq_domain_get_irq_data(domain, virq);
>> +     struct altera_msi *msi = irq_data_get_irq_chip_data(d);
>> +     u32 mask;
>> +
>> +     mutex_lock(&msi->lock);
>> +
>> +     if (!test_bit(d->hwirq, msi->used))
>> +             dev_err(&msi->pdev->dev, "trying to free unused MSI#%lu\n",
>> +             d->hwirq);
>
> Put this statement in { } so that it matches the "else" construct.
Noted.

>
>> +     else {
>> +             clear_bit(d->hwirq, msi->used);
>
> No need for an atomic operation here, you own the mutex.
Okay, change to __clear_bit.


>
>> +             mask = msi_readl(msi, MSI_INTMASK);
>> +             mask &= ~(1 << d->hwirq);
>> +             msi_writel(msi, mask, MSI_INTMASK);
>> +     }
>> +
>> +     mutex_unlock(&msi->lock);
>> +}
>> +
>> +static const struct irq_domain_ops msi_domain_ops = {
>> +     .alloc  = altera_irq_domain_alloc,
>> +     .free   = altera_irq_domain_free,
>> +};
>> +
>> +static int altera_allocate_domains(struct altera_msi *msi)
>> +{
>> +     msi->inner_domain = irq_domain_add_linear(NULL, msi->num_of_vectors,
>> +                                          &msi_domain_ops, msi);
>> +     if (!msi->inner_domain) {
>> +             dev_err(&msi->pdev->dev, "failed to create IRQ domain\n");
>> +             return -ENOMEM;
>> +     }
>> +
>> +     msi->msi_domain = pci_msi_create_irq_domain(
>> +                             msi->pdev->dev.of_node,
>
> Please put at least one argument to the function on the same line. This
> is otherwise very hard to read.
Okay.

>
>> +                             &altera_msi_domain_info, msi->inner_domain);
>> +     if (!msi->msi_domain) {
>> +             dev_err(&msi->pdev->dev, "failed to create MSI domain\n");
>> +             irq_domain_remove(msi->inner_domain);
>> +             return -ENOMEM;
>> +     }
>> +
>> +     return 0;
>> +}
>> +
>> +static void altera_free_domains(struct altera_msi *msi)
>> +{
>> +     irq_domain_remove(msi->msi_domain);
>> +     irq_domain_remove(msi->inner_domain);
>> +}
>> +
>> +
>> +static int altera_msi_remove(struct platform_device *pdev)
>> +{
>> +     struct altera_msi *msi = platform_get_drvdata(pdev);
>> +
>> +     msi_writel(msi, 0, MSI_INTMASK);
>> +     irq_set_chained_handler(msi->irq, NULL);
>> +     irq_set_handler_data(msi->irq, NULL);
>> +
>> +     altera_free_domains(msi);
>> +
>> +     platform_set_drvdata(pdev, NULL);
>> +     return 0;
>> +}
>> +
>> +int altera_msi_probe(struct platform_device *pdev)
>
> Make this static.
Okay.

>
>> +{
>> +     struct altera_msi *msi;
>> +     struct device_node *np = pdev->dev.of_node;
>> +     struct resource *res;
>> +     int ret;
>> +
>> +     msi = devm_kzalloc(&pdev->dev, sizeof(struct altera_msi),
>> +             GFP_KERNEL);
>> +     if (!msi)
>> +             return -ENOMEM;
>> +
>> +     mutex_init(&msi->lock);
>> +     msi->pdev = pdev;
>> +
>> +     res = platform_get_resource_byname(pdev, IORESOURCE_MEM, "csr");
>> +     msi->csr_base = devm_ioremap_resource(&pdev->dev, res);
>> +     if (IS_ERR(msi->csr_base)) {
>> +             dev_err(&pdev->dev, "get csr resource failed\n");
>> +             return PTR_ERR(msi->csr_base);
>> +     }
>> +
>> +     res = platform_get_resource_byname(pdev, IORESOURCE_MEM,
>> +                     "vector_slave");
>> +     msi->vector_base = devm_ioremap_resource(&pdev->dev, res);
>> +     if (IS_ERR(msi->vector_base)) {
>> +             dev_err(&pdev->dev, "get vector slave resource failed\n");
>> +             return PTR_ERR(msi->vector_base);
>> +     }
>> +
>> +     msi->vector_phy = res->start;
>> +
>> +     if (of_property_read_u32(np, "num-vectors", &msi->num_of_vectors)) {
>> +             dev_err(&pdev->dev, "failed to parse the number of vectors\n");
>> +             return -EINVAL;
>> +     }
>> +
>> +     ret = altera_allocate_domains(msi);
>> +     if (ret)
>> +             return ret;
>> +
>> +     msi->irq = platform_get_irq(pdev, 0);
>> +     if (msi->irq <= 0) {
>> +             dev_err(&pdev->dev, "failed to map IRQ: %d\n", msi->irq);
>> +             ret = -ENODEV;
>> +             goto err;
>> +     }
>> +
>> +     irq_set_chained_handler(msi->irq, altera_msi_isr);
>> +     ret = irq_set_handler_data(msi->irq, msi);
>
> Use irq_set_chained_handler_and_data.
Okay.

>
>> +     if (ret) {
>> +             dev_err(&pdev->dev, "failed to register IRQ handler: %d\n",
>> +                     ret);
>> +             goto err;
>> +     }
>> +
>> +     platform_set_drvdata(pdev, msi);
>> +
>> +     return 0;
>> +
>> +err:
>> +     altera_msi_remove(pdev);
>> +     return ret;
>> +}
>> +
>> +static const struct of_device_id altera_msi_of_match[] = {
>> +     { .compatible = "altr,msi-1.0", NULL },
>> +     { },
>> +};
>> +MODULE_DEVICE_TABLE(of, altera_msi_of_match);
>> +
>> +static struct platform_driver altera_msi_driver = {
>> +     .driver = {
>> +             .name = "altera-msi",
>> +             .owner = THIS_MODULE,
>
> Remove this .owner assignment, the core code deals with it.
Okay.

>
>> +             .of_match_table = altera_msi_of_match,
>> +     },
>> +     .probe = altera_msi_probe,
>> +     .remove = altera_msi_remove,
>> +};
>> +
>> +static int __init altera_msi_init(void)
>> +{
>> +     return platform_driver_register(&altera_msi_driver);
>> +}
>> +
>> +subsys_initcall(altera_msi_init);
>
> Hmmm. if you're initializing this as part of the core kernel, it will
> never be a module. What is the point of the MODULE_DEVICE_TABLE above?
Okay, will remove MODULE_DEVICE_TABLE.

Thanks for reviewing.

Regards
Ley Foon
