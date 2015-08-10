Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-la0-f67.google.com ([209.85.215.67]:35573 "EHLO
	mail-la0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932290AbbHJLCL (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Mon, 10 Aug 2015 07:02:11 -0400
MIME-Version: 1.0
In-Reply-To: <55C4C1E2.7080205@arm.com>
References: <1438933382-2936-1-git-send-email-lftan@altera.com>
	<1438933382-2936-3-git-send-email-lftan@altera.com>
	<55C4C1E2.7080205@arm.com>
Date: Mon, 10 Aug 2015 19:02:08 +0800
Message-ID: <CAFiDJ5-3MTjMQDgXH4Om_-S8d0MTLPeg2V7pQQhzPCow0E9jeQ@mail.gmail.com>
Subject: Re: [PATCH v3 2/5] pci:host: Add Altera PCIe host controller driver
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

On Fri, Aug 7, 2015 at 10:34 PM, Marc Zyngier <marc.zyngier@arm.com> wrote:
> On 07/08/15 08:42, Ley Foon Tan wrote:
>> This patch adds the Altera PCIe host controller driver.
>>
>> Signed-off-by: Ley Foon Tan <lftan@altera.com>
>> ---
>>  drivers/pci/host/Kconfig       |   7 +
>>  drivers/pci/host/Makefile      |   1 +
>>  drivers/pci/host/pcie-altera.c | 532 +++++++++++++++++++++++++++++++++++++++++
>>  3 files changed, 540 insertions(+)
>>  create mode 100644 drivers/pci/host/pcie-altera.c

<snip>

>> +static int tlp_read_packet(struct altera_pcie *pcie, u32 *value)
>> +{
>> +       u8 loop;
>> +       struct tlp_rp_regpair_t tlp_rp_regdata;
>> +
>> +       for (loop = TLP_LOOP; loop > 0; loop--) {
>
> I'd prefer to see the more common idiom:
>
>         for (loop = 0; loop < TLP_LOOP; loop++) {
Okay, will change this.

>> +               tlp_read_rx(pcie, &tlp_rp_regdata);
>> +               if (tlp_rp_regdata.ctrl & RP_RXCPL_EOP) {
>> +                       if (value)
>> +                               *value = tlp_rp_regdata.reg0;
>> +                       return PCIBIOS_SUCCESSFUL;
>> +               }
>
> Don't you need some form of relaxation here? A delay of some sort?
> Repeatedly polling the HW is usually not helping it to recover...
Yes, will add udelay here.

<snip>

>> +static int altera_pcie_init_irq_domain(struct altera_pcie *pcie)
>> +{
>> +       struct device *dev = &pcie->pdev->dev;
>> +       struct device_node *node = dev->of_node;
>> +
>> +       /* Setup INTx */
>> +       pcie->irq_domain = irq_domain_add_linear(node, INTX_NUM,
>> +                                       &intx_domain_ops, pcie);
>> +       if (!pcie->irq_domain) {
>> +               dev_err(dev, "Failed to get a INTx IRQ domain\n");
>> +               return PTR_ERR(pcie->irq_domain);
>
> Err, no. irq_domain_add returns NULL on error, so PTR_ERR(NULL) is still
> going to be zero.

Change to return -ENOMEM.

>
>> +       }
>> +
>> +       return 0;
>> +}
>> +
>> +static int altera_pcie_parse_dt(struct altera_pcie *pcie)
>> +{
>> +       struct resource *cra;
>> +       struct platform_device *pdev = pcie->pdev;
>> +
>> +       cra = platform_get_resource_byname(pdev, IORESOURCE_MEM, "Cra");
>
> Probably worth checking that this hasn't failed.
Noted. Will add error checking.
>
>> +       pcie->cra_base = devm_ioremap_resource(&pdev->dev, cra);
>> +       if (IS_ERR(pcie->cra_base)) {
>> +               dev_err(&pdev->dev, "get Cra resource failed\n");
>> +               return PTR_ERR(pcie->cra_base);
>> +       }
>> +
>> +       /* setup IRQ */
>> +       pcie->irq = platform_get_irq(pdev, 0);
>> +       if (pcie->irq <= 0) {
>> +               dev_err(&pdev->dev, "failed to get IRQ: %d\n", pcie->irq);
>> +               return -EINVAL;
>> +       }
>> +
>> +       irq_set_chained_handler_and_data(pcie->irq, altera_pcie_isr, pcie);
>> +
>> +       return 0;
>> +}
>> +
>> +static int altera_pcie_probe(struct platform_device *pdev)
>> +{
>> +       struct altera_pcie *pcie;
>> +       struct pci_bus *bus;
>> +       int ret;
>> +
>> +       pcie = devm_kzalloc(&pdev->dev, sizeof(*pcie), GFP_KERNEL);
>> +       if (!pcie)
>> +               return -ENOMEM;
>> +
>> +       pcie->pdev = pdev;
>> +
>> +       ret = altera_pcie_parse_dt(pcie);
>> +       if (ret) {
>> +               dev_err(&pdev->dev, "Parsing DT failed\n");
>> +               return ret;
>> +       }
>> +
>> +       INIT_LIST_HEAD(&pcie->resources);
>> +
>> +       ret = altera_pcie_parse_request_of_pci_ranges(pcie);
>> +       if (ret) {
>> +               dev_err(&pdev->dev, "Failed add resources\n");
>> +               return ret;
>> +       }
>> +
>> +       ret = altera_pcie_init_irq_domain(pcie);
>> +       if (ret) {
>> +               dev_err(&pdev->dev, "Failed creating IRQ Domain\n");
>> +               return ret;
>> +       }
>> +
>> +       pcie->root_bus_nr = 0;
>> +
>> +       /* clear all interrupts */
>> +       cra_writel(pcie, P2A_INT_STS_ALL, P2A_INT_STATUS);
>> +       /* enable all interrupts */
>> +       cra_writel(pcie, P2A_INT_ENA_ALL, P2A_INT_ENABLE);
>> +
>> +       bus = pci_scan_root_bus(&pdev->dev, pcie->root_bus_nr, &altera_pcie_ops,
>> +                               pcie, &pcie->resources);
>> +       if (!bus)
>> +               return -ENOMEM;
>> +
>> +       pci_fixup_irqs(pci_common_swizzle, of_irq_parse_and_map_pci);
>> +       pci_assign_unassigned_bus_resources(bus);
>> +       pci_bus_add_devices(bus);
>> +
>> +       platform_set_drvdata(pdev, pcie);
>> +       return ret;
>> +}
>> +
>> +static int __exit altera_pcie_remove(struct platform_device *pdev)
>> +{
>> +       struct altera_pcie *pcie = platform_get_drvdata(pdev);
>> +
>> +       altera_pcie_free_irq_domain(pcie);
>> +       platform_set_drvdata(pdev, NULL);
>> +       return 0;
>> +}
>> +
>> +static const struct of_device_id altera_pcie_of_match[] = {
>> +       { .compatible = "altr,pcie-root-port-1.0", },
>> +       {},
>> +};
>> +MODULE_DEVICE_TABLE(of, altera_pcie_of_match);
>> +
>> +static struct platform_driver altera_pcie_driver = {
>> +       .probe          = altera_pcie_probe,
>> +       .remove         = altera_pcie_remove,
>> +       .driver = {
>> +               .name   = "altera-pcie",
>> +               .of_match_table = altera_pcie_of_match,
>> +       },
>> +};
>> +
>> +module_platform_driver(altera_pcie_driver);
>> +
>> +MODULE_AUTHOR("Ley Foon Tan <lftan@altera.com>");
>> +MODULE_DESCRIPTION("Altera PCIe host controller driver");
>> +MODULE_LICENSE("GPL v2");
>> --
>> 1.8.2.1
>>
>
> This is starting to look better. You should get someone to review the DT
> parts though.
I have CC-ed DT maintainers. Hope someone can help to review.


Thanks for reviewing.

Regards
Ley Foon
