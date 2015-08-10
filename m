Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-lb0-f194.google.com ([209.85.217.194]:36807 "EHLO
	mail-lb0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932359AbbHJLAr (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Mon, 10 Aug 2015 07:00:47 -0400
MIME-Version: 1.0
In-Reply-To: <55C4C448.4020102@arm.com>
References: <1438933382-2936-1-git-send-email-lftan@altera.com>
	<1438933382-2936-4-git-send-email-lftan@altera.com>
	<55C4C448.4020102@arm.com>
Date: Mon, 10 Aug 2015 19:00:44 +0800
Message-ID: <CAFiDJ58QQzDVBE1-0vvyYHv03R_PVs9Nk3t_0wcJAdozBSLz7Q@mail.gmail.com>
Subject: Re: [PATCH v3 3/5] pci: altera: Add Altera PCIe MSI driver
From: Ley Foon Tan <lftan@altera.com>
To: Marc Zyngier <marc.zyngier@arm.com>
Cc: Bjorn Helgaas <bhelgaas@google.com>,
	Russell King <linux@arm.linux.org.uk>,
	Arnd Bergmann <arnd@arndb.de>,
	Dinh Nguyen <dinguyen@opensource.altera.com>,
	"linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
	"devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
	"linux-arm-kernel@lists.infradead.org"
	<linux-arm-kernel@lists.infradead.org>,
	"linux-doc@vger.kernel.org" <linux-doc@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	Rob Herring <robh+dt@kernel.org>,
	Pawel Moll <pawel.moll@arm.com>,
	Mark Rutland <mark.rutland@arm.com>,
	Ian Campbell <ijc+devicetree@hellion.org.uk>,
	Kumar Gala <galak@codeaurora.org>
Content-Type: text/plain; charset=UTF-8
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Fri, Aug 7, 2015 at 10:44 PM, Marc Zyngier <marc.zyngier@arm.com> wrote:
> On 07/08/15 08:43, Ley Foon Tan wrote:
>> This patch adds Altera PCIe MSI driver. This soft IP supports configurable
>> number of vectors, which is a dts parameter.
>>
>> Signed-off-by: Ley Foon Tan <lftan@altera.com>
>> ---
>>  drivers/pci/host/Kconfig           |   8 +
>>  drivers/pci/host/Makefile          |   1 +
>>  drivers/pci/host/pcie-altera-msi.c | 309 +++++++++++++++++++++++++++++++++++++
>>  3 files changed, 318 insertions(+)
>>  create mode 100644 drivers/pci/host/pcie-altera-msi.c
>>
<snip>
>> +static int altera_irq_domain_alloc(struct irq_domain *domain, unsigned int virq,
>> +                                  unsigned int nr_irqs, void *args)
>> +{
>> +       struct altera_msi *msi = domain->host_data;
>> +       unsigned long bit;
>> +       u32 mask;
>> +
>
> As you cannot support multi-MSI, it would be good to have a
> WARN_ON(nr_irqs != 1) here. Just in case...
Noted.

>
>> +       mutex_lock(&msi->lock);
>> +
>> +       bit = find_first_zero_bit(msi->used, msi->num_of_vectors);
>> +       if (bit >= msi->num_of_vectors)
>> +               return -ENOSPC;
>> +
>> +       set_bit(bit, msi->used);
>> +
>> +       mutex_unlock(&msi->lock);
>> +
>> +       irq_domain_set_info(domain, virq, bit, &altera_msi_bottom_irq_chip,
>> +                           domain->host_data, handle_simple_irq,
>> +                           NULL, NULL);
>> +       set_irq_flags(virq, IRQF_VALID);
>> +
>> +       mask = msi_readl(msi, MSI_INTMASK);
>> +       mask |= 1 << bit;
>> +       msi_writel(msi, mask, MSI_INTMASK);
>> +
>> +       return 0;
>> +}
>> +
>> +static void altera_irq_domain_free(struct irq_domain *domain,
>> +                                  unsigned int virq, unsigned int nr_irqs)
>> +{
>> +       struct irq_data *d = irq_domain_get_irq_data(domain, virq);
>> +       struct altera_msi *msi = irq_data_get_irq_chip_data(d);
>> +       u32 mask;
>> +
>> +       mutex_lock(&msi->lock);
>> +
>> +       if (!test_bit(d->hwirq, msi->used)) {
>> +               dev_err(&msi->pdev->dev, "trying to free unused MSI#%lu\n",
>> +                       d->hwirq);
>> +       } else {
>> +               __clear_bit(d->hwirq, msi->used);
>> +               mask = msi_readl(msi, MSI_INTMASK);
>> +               mask &= ~(1 << d->hwirq);
>> +               msi_writel(msi, mask, MSI_INTMASK);
>> +       }
>> +
>> +       mutex_unlock(&msi->lock);
>> +}
>> +
>> +static const struct irq_domain_ops msi_domain_ops = {
>> +       .alloc  = altera_irq_domain_alloc,
>> +       .free   = altera_irq_domain_free,
>> +};
>> +
>> +static int altera_allocate_domains(struct altera_msi *msi)
>> +{
>> +       msi->inner_domain = irq_domain_add_linear(NULL, msi->num_of_vectors,
>> +                                            &msi_domain_ops, msi);
>> +       if (!msi->inner_domain) {
>> +               dev_err(&msi->pdev->dev, "failed to create IRQ domain\n");
>> +               return -ENOMEM;
>> +       }
>> +
>> +       msi->msi_domain = pci_msi_create_irq_domain(msi->pdev->dev.of_node,
>> +                               &altera_msi_domain_info, msi->inner_domain);
>> +       if (!msi->msi_domain) {
>> +               dev_err(&msi->pdev->dev, "failed to create MSI domain\n");
>> +               irq_domain_remove(msi->inner_domain);
>> +               return -ENOMEM;
>> +       }
>> +
>> +       return 0;
>> +}
>> +
>> +static void altera_free_domains(struct altera_msi *msi)
>> +{
>> +       irq_domain_remove(msi->msi_domain);
>> +       irq_domain_remove(msi->inner_domain);
>> +}
>> +
>> +static int altera_msi_remove(struct platform_device *pdev)
>> +{
>> +       struct altera_msi *msi = platform_get_drvdata(pdev);
>> +
>> +       msi_writel(msi, 0, MSI_INTMASK);
>> +       irq_set_chained_handler(msi->irq, NULL);
>> +       irq_set_handler_data(msi->irq, NULL);
>> +
>> +       altera_free_domains(msi);
>> +
>> +       platform_set_drvdata(pdev, NULL);
>> +       return 0;
>> +}
>> +
>> +static int altera_msi_probe(struct platform_device *pdev)
>> +{
>> +       struct altera_msi *msi;
>> +       struct device_node *np = pdev->dev.of_node;
>> +       struct resource *res;
>> +       int ret;
>> +
>> +       msi = devm_kzalloc(&pdev->dev, sizeof(struct altera_msi),
>> +                          GFP_KERNEL);
>> +       if (!msi)
>> +               return -ENOMEM;
>> +
>> +       mutex_init(&msi->lock);
>> +       msi->pdev = pdev;
>> +
>> +       res = platform_get_resource_byname(pdev, IORESOURCE_MEM, "csr");
>
> Error checking here.
Noted.
>
>> +       msi->csr_base = devm_ioremap_resource(&pdev->dev, res);
>> +       if (IS_ERR(msi->csr_base)) {
>> +               dev_err(&pdev->dev, "get csr resource failed\n");
>> +               return PTR_ERR(msi->csr_base);
>> +       }
>> +
>> +       res = platform_get_resource_byname(pdev, IORESOURCE_MEM,
>> +                                          "vector_slave");
>
> And here.
Noted.
>
>> +       msi->vector_base = devm_ioremap_resource(&pdev->dev, res);
>> +       if (IS_ERR(msi->vector_base)) {
>> +               dev_err(&pdev->dev, "get vector slave resource failed\n");
>> +               return PTR_ERR(msi->vector_base);
>> +       }
>> +
>> +       msi->vector_phy = res->start;
>> +
>> +       if (of_property_read_u32(np, "num-vectors", &msi->num_of_vectors)) {
>> +               dev_err(&pdev->dev, "failed to parse the number of vectors\n");
>> +               return -EINVAL;
>> +       }
>> +
>> +       ret = altera_allocate_domains(msi);
>> +       if (ret)
>> +               return ret;
>> +
>> +       msi->irq = platform_get_irq(pdev, 0);
>> +       if (msi->irq <= 0) {
>> +               dev_err(&pdev->dev, "failed to map IRQ: %d\n", msi->irq);
>> +               ret = -ENODEV;
>> +               goto err;
>> +       }
>> +
>> +       irq_set_chained_handler_and_data(msi->irq, altera_msi_isr, msi);
>> +       platform_set_drvdata(pdev, msi);
>> +
>> +       return 0;
>> +
>> +err:
>> +       altera_msi_remove(pdev);
>> +       return ret;
>> +}
>> +
>> +static const struct of_device_id altera_msi_of_match[] = {
>> +       { .compatible = "altr,msi-1.0", NULL },
>> +       { },
>> +};
>> +
>> +static struct platform_driver altera_msi_driver = {
>> +       .driver = {
>> +               .name = "altera-msi",
>> +               .of_match_table = altera_msi_of_match,
>> +       },
>> +       .probe = altera_msi_probe,
>> +       .remove = altera_msi_remove,
>> +};
>> +
>> +static int __init altera_msi_init(void)
>> +{
>> +       return platform_driver_register(&altera_msi_driver);
>> +}
>> +
>> +subsys_initcall(altera_msi_init);
>> +
>> +MODULE_AUTHOR("Ley Foon Tan <lftan@altera.com>");
>> +MODULE_DESCRIPTION("Altera PCIe MSI support");
>> +MODULE_LICENSE("GPL v2");
>> --
>> 1.8.2.1
>>
>
> Apart from the couple of nits above, this is starting to look good too.
> And as for the PCIe driver, you need to get the DT maintainers to review
> that part.
Okay, added DT maintainers to CC list.

Thanks for reviewing.

Regards
Ley Foon
