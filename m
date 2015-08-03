Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-la0-f45.google.com ([209.85.215.45]:32896 "EHLO
	mail-la0-f45.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751773AbbHCKen (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Mon, 3 Aug 2015 06:34:43 -0400
MIME-Version: 1.0
In-Reply-To: <55BB6B45.7010705@arm.com>
References: <1438337715-22594-1-git-send-email-lftan@altera.com>
	<1438337715-22594-3-git-send-email-lftan@altera.com>
	<55BB6B45.7010705@arm.com>
Date: Mon, 3 Aug 2015 18:34:41 +0800
Message-ID: <CAFiDJ59i89hhj94KN3JwcPCxkpX4-KmV3uCg=-vn+1Y1hHdL2g@mail.gmail.com>
Subject: Re: [PATCH v2 2/5] pci:host: Add Altera PCIe host controller driver
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

On Fri, Jul 31, 2015 at 8:34 PM, Marc Zyngier <marc.zyngier@arm.com> wrote:
> On 31/07/15 11:15, Ley Foon Tan wrote:
>> This patch adds the Altera PCIe host controller driver.
>>
>> Signed-off-by: Ley Foon Tan <lftan@altera.com>
>> ---
>>  drivers/pci/host/Kconfig       |   8 +
>>  drivers/pci/host/Makefile      |   1 +
>>  drivers/pci/host/pcie-altera.c | 526 +++++++++++++++++++++++++++++++++++++++++
>>  3 files changed, 535 insertions(+)
>>  create mode 100644 drivers/pci/host/pcie-altera.c
>>
>> diff --git a/drivers/pci/host/Kconfig b/drivers/pci/host/Kconfig
>> index 675c2d1..108500a 100644
>> --- a/drivers/pci/host/Kconfig
>> +++ b/drivers/pci/host/Kconfig
>> @@ -145,4 +145,12 @@ config PCIE_IPROC_BCMA
>>         Say Y here if you want to use the Broadcom iProc PCIe controller
>>         through the BCMA bus interface
>>
>> +config PCIE_ALTERA
>> +     tristate "Altera PCIe controller"
>> +     depends on ARCH_SOCFPGA
>> +     select PCI_MSI_IRQ_DOMAIN if PCI_MSI
>
> Why would you select this here? MSI support is in another driver, so I
> don't see the point.
Will move select PCI_MSI_IRQ_DOMAIN to config  PCIE_ALTERA_MSI section.

>
>> +     help
>> +       Say Y here if you want to enable PCIe controller support for Altera
>> +       SoCFPGA family of SoCs.
>> +
>>  endmenu

>> +static const struct irq_domain_ops intx_domain_ops = {
>> +     .map = altera_pcie_intx_map,
>> +};
>> +
>> +static irqreturn_t altera_pcie_isr(int irq, void *arg)
>> +{
>> +     struct altera_pcie *pcie = arg;
>> +     u32 status, i;
>> +
>> +     status = cra_readl(pcie, P2A_INT_STATUS) & P2A_INT_STS_ALL;
>> +
>> +     /* clear interrupts */
>> +     cra_writel(pcie, status, P2A_INT_STATUS);
>> +
>> +     for (i = 0; i < INTX_NUM; i++) {
>> +             if (status & (1 << i))
>
> find_first/next_set_bit?
Yes, change this to find_first_bit().

>
>> +                     generic_handle_irq(irq_find_mapping(pcie->irq_domain,
>> +                                                     i + 1));
>
> Rule of thumb: if you're calling generic_handle_irq from an interrupt
> handler, this is a chained IRQ controller. Please implement it as such.
Okay, will change this to chained_irq_enter/chained_irq_exit implementation.
>
>> +     }
>> +
>> +     return IRQ_HANDLED;
>> +}
>> +
>> +static void altera_pcie_release_of_pci_ranges(struct altera_pcie *pcie)
>> +{
>> +     pci_free_resource_list(&pcie->resources);
>> +}
>> +
>> +static int altera_pcie_parse_request_of_pci_ranges(struct altera_pcie *pcie)
>> +{
>> +     int err, res_valid = 0;
>> +     struct device *dev = &pcie->pdev->dev;
>> +     struct device_node *np = dev->of_node;
>> +     resource_size_t iobase;
>> +     struct resource_entry *win;
>> +     int offset = 0;
>> +
>> +     err = of_pci_get_host_bridge_resources(np, 0, 0xff, &pcie->resources,
>> +                                            &iobase);
>> +     if (err)
>> +             return err;
>> +
>> +     resource_list_for_each_entry(win, &pcie->resources) {
>> +             struct resource *parent, *res = win->res;
>> +
>> +             switch (resource_type(res)) {
>> +             case IORESOURCE_MEM:
>> +                     parent = &iomem_resource;
>> +                     res_valid |= !(res->flags & IORESOURCE_PREFETCH);
>> +                     cra_writel(pcie, res->start,
>> +                             A2P_ADDR_MAP_LO0 + offset);
>> +                     cra_writel(pcie, 0,
>> +                             A2P_ADDR_MAP_HI0 + offset);
>> +                     offset += ATT_ENTRY_SIZE;
>> +                     break;
>> +             default:
>> +                     continue;
>> +             }
>> +
>> +             err = devm_request_resource(dev, parent, res);
>> +             if (err)
>> +                     goto out_release_res;
>> +     }
>> +
>> +     if (!res_valid) {
>> +             dev_err(dev, "non-prefetchable memory resource required\n");
>> +             err = -EINVAL;
>> +             goto out_release_res;
>> +     }
>> +
>> +     return 0;
>> +
>> +out_release_res:
>> +     altera_pcie_release_of_pci_ranges(pcie);
>> +     return err;
>> +}
>> +
>> +static void altera_pcie_free_irq_domain(struct altera_pcie *pcie)
>> +{
>> +     int i;
>> +     u32 irq;
>> +
>> +     for (i = 0; i < INTX_NUM; i++) {
>> +             irq = irq_find_mapping(pcie->irq_domain, i);
>> +             if (irq > 0)
>> +                     irq_dispose_mapping(irq);
>> +     }
>> +
>> +     irq_domain_remove(pcie->irq_domain);
>> +}
>> +
>> +static int altera_pcie_init_irq_domain(struct altera_pcie *pcie)
>> +{
>> +     struct device *dev = &pcie->pdev->dev;
>> +     struct device_node *node = dev->of_node;
>> +
>> +     /* Setup INTx */
>> +     pcie->irq_domain = irq_domain_add_linear(node, INTX_NUM,
>> +                                     &intx_domain_ops, pcie);
>> +     if (!pcie->irq_domain) {
>> +             dev_err(dev, "Failed to get a INTx IRQ domain\n");
>> +             return PTR_ERR(pcie->irq_domain);
>> +     }
>> +
>> +     return 0;
>> +}
>> +
>> +static int altera_pcie_parse_dt(struct altera_pcie *pcie)
>> +{
>> +     struct resource *cra;
>> +     int ret;
>> +     struct platform_device *pdev = pcie->pdev;
>> +
>> +     cra = platform_get_resource_byname(pdev, IORESOURCE_MEM, "Cra");
>> +     pcie->cra_base = devm_ioremap_resource(&pdev->dev, cra);
>> +     if (IS_ERR(pcie->cra_base)) {
>> +             dev_err(&pdev->dev, "get Cra resource failed\n");
>> +             return PTR_ERR(pcie->cra_base);
>> +     }
>> +
>> +     /* setup IRQ */
>> +     pcie->hwirq = platform_get_irq(pdev, 0);
>> +     if (pcie->hwirq <= 0) {
>
> This is definitely not a hardware interrupt number. It is completely
> virtual. I suggest you give it a better name.
Noted.

>
>> +             dev_err(&pdev->dev, "failed to get IRQ: %d\n", pcie->hwirq);
>> +             return -EINVAL;
>> +     }
>> +     ret = devm_request_irq(&pdev->dev, pcie->hwirq, altera_pcie_isr,
>> +                     IRQF_SHARED, pdev->name, pcie);
>
> You're implementing a cascading interrupt controller again. Please fix
> it just like you did for your MSI support.
Sure, will change to irq_set_chained_handler_and_data here.


Thanks for reviewing.

Regards
Ley Foon
