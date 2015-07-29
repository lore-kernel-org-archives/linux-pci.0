Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from foss.arm.com ([217.140.101.70]:36314 "EHLO foss.arm.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751101AbbG2NS5 (ORCPT <rfc822;linux-pci@vger.kernel.org>);
	Wed, 29 Jul 2015 09:18:57 -0400
Date: Wed, 29 Jul 2015 14:19:36 +0100
From: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
To: Ley Foon Tan <lftan@altera.com>
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
	"lftan.linux@gmail.com" <lftan.linux@gmail.com>,
	Rob Herring <robh+dt@kernel.org>
Subject: Re: [PATCH 3/6] pci:host: Add Altera PCIe host controller driver
Message-ID: <20150729131936.GA6376@red-moon>
References: <1438080345-7233-1-git-send-email-lftan@altera.com>
 <1438080345-7233-4-git-send-email-lftan@altera.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1438080345-7233-4-git-send-email-lftan@altera.com>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Tue, Jul 28, 2015 at 11:45:42AM +0100, Ley Foon Tan wrote:

[...]

> +static int altera_pcie_parse_request_of_pci_ranges(struct altera_pcie *pcie)
> +{
> +       int err, res_valid = 0;
> +       struct device *dev = &pcie->pdev->dev;
> +       struct device_node *np = dev->of_node;
> +       resource_size_t iobase;
> +       struct resource_entry *win;
> +       int offset = 0;
> +
> +       err = of_pci_get_host_bridge_resources(np, 0, 0xff, &pcie->resources,
> +                                              &iobase);
> +       if (err)
> +               return err;

On top of Rob's comments on ARM bios32 dependency removal (ie rewrite
the driver so that it does not use pci_common_init_dev()), if you need IO
access you have to map iobase, see pci_remap_iospace() in pci-host-generic.c

Lorenzo

> +
> +       resource_list_for_each_entry(win, &pcie->resources) {
> +               struct resource *parent, *res = win->res;
> +
> +               switch (resource_type(res)) {
> +               case IORESOURCE_MEM:
> +                       parent = &iomem_resource;
> +                       res_valid |= !(res->flags & IORESOURCE_PREFETCH);
> +                       cra_writel(pcie, res->start,
> +                               A2P_ADDR_MAP_LO0 + offset);
> +                       cra_writel(pcie, 0,
> +                               A2P_ADDR_MAP_HI0 + offset);
> +                       offset += ATT_ENTRY_SIZE;
> +                       break;
> +               default:
> +                       continue;
> +               }
> +
> +               err = devm_request_resource(dev, parent, res);
> +               if (err)
> +                       goto out_release_res;
> +       }
> +
> +       if (!res_valid) {
> +               dev_err(dev, "non-prefetchable memory resource required\n");
> +               err = -EINVAL;
> +               goto out_release_res;
> +       }
> +
> +       return 0;
> +
> +out_release_res:
> +       altera_pcie_release_of_pci_ranges(pcie);
> +       return err;
> +}
> +
> +static void altera_pcie_free_irq_domain(struct altera_pcie *pcie)
> +{
> +       int i;
> +       u32 irq;
> +
> +       for (i = 0; i < INTX_NUM; i++) {
> +               irq = irq_find_mapping(pcie->irq_domain, i);
> +               if (irq > 0)
> +                       irq_dispose_mapping(irq);
> +       }
> +
> +       irq_domain_remove(pcie->irq_domain);
> +}
> +
> +static int altera_pcie_init_irq_domain(struct altera_pcie *pcie)
> +{
> +       struct device *dev = &pcie->pdev->dev;
> +       struct device_node *node = dev->of_node;
> +
> +       /* Setup INTx */
> +       pcie->irq_domain = irq_domain_add_linear(node, INTX_NUM,
> +                                       &intx_domain_ops, pcie);
> +       if (!pcie->irq_domain) {
> +               dev_err(dev, "Failed to get a INTx IRQ domain\n");
> +               return PTR_ERR(pcie->irq_domain);
> +       }
> +
> +       return 0;
> +}
> +
> +static int altera_pcie_parse_dt(struct altera_pcie *pcie)
> +{
> +       struct resource *cra;
> +       int ret;
> +       struct platform_device *pdev = pcie->pdev;
> +
> +       cra = platform_get_resource_byname(pdev, IORESOURCE_MEM, "Cra");
> +       pcie->cra_base = devm_ioremap_resource(&pdev->dev, cra);
> +       if (IS_ERR(pcie->cra_base)) {
> +               dev_err(&pdev->dev, "get Cra resource failed\n");
> +               return PTR_ERR(pcie->cra_base);
> +       }
> +
> +       /* setup IRQ */
> +       pcie->hwirq = platform_get_irq(pdev, 0);
> +       if (pcie->hwirq <= 0) {
> +               dev_err(&pdev->dev, "failed to get IRQ: %d\n", pcie->hwirq);
> +               return -EINVAL;
> +       }
> +       ret = devm_request_irq(&pdev->dev, pcie->hwirq, altera_pcie_isr,
> +                       IRQF_SHARED, pdev->name, pcie);
> +
> +       if (ret) {
> +               dev_err(&pdev->dev, "failed to request irq %d\n", pcie->hwirq);
> +               return ret;
> +       }
> +
> +       return 0;
> +}
> +
> +static int altera_pcie_probe(struct platform_device *pdev)
> +{
> +       struct altera_pcie *pcie;
> +       int ret;
> +
> +       pcie = devm_kzalloc(&pdev->dev, sizeof(*pcie), GFP_KERNEL);
> +       if (!pcie)
> +               return -ENOMEM;
> +
> +       pcie->pdev = pdev;
> +
> +       ret = altera_pcie_parse_dt(pcie);
> +       if (ret) {
> +               dev_err(&pdev->dev, "Parsing DT failed\n");
> +               return ret;
> +       }
> +
> +       INIT_LIST_HEAD(&pcie->resources);
> +
> +       ret = altera_pcie_parse_request_of_pci_ranges(pcie);
> +       if (ret) {
> +               dev_err(&pdev->dev, "Failed add resources\n");
> +               return ret;
> +       }
> +
> +       ret = altera_pcie_init_irq_domain(pcie);
> +       if (ret) {
> +               dev_err(&pdev->dev, "Failed creating IRQ Domain\n");
> +               return ret;
> +       }
> +
> +       pcie->root_bus_nr = -1;
> +
> +       /* clear all interrupts */
> +       cra_writel(pcie, P2A_INT_STS_ALL, P2A_INT_STATUS);
> +       /* enable all interrupts */
> +       cra_writel(pcie, P2A_INT_ENA_ALL, P2A_INT_ENABLE);
> +
> +       altera_pcie_hw.private_data = (void **)&pcie;
> +
> +       pci_common_init_dev(&pdev->dev, &altera_pcie_hw);
> +
> +       platform_set_drvdata(pdev, pcie);
> +       return ret;
> +}
> +
> +static int __exit altera_pcie_remove(struct platform_device *pdev)
> +{
> +       struct altera_pcie *pcie = platform_get_drvdata(pdev);
> +
> +       altera_pcie_free_irq_domain(pcie);
> +       platform_set_drvdata(pdev, NULL);
> +       return 0;
> +}
> +
> +static const struct of_device_id altera_pcie_of_match[] = {
> +       { .compatible = "altr,pcie-root-port-1.0", },
> +       {},
> +};
> +MODULE_DEVICE_TABLE(of, altera_pcie_of_match);
> +
> +static struct platform_driver altera_pcie_driver = {
> +       .probe          = altera_pcie_probe,
> +       .remove         = altera_pcie_remove,
> +       .driver = {
> +               .name   = "altera-pcie",
> +               .owner  = THIS_MODULE,
> +               .of_match_table = altera_pcie_of_match,
> +       },
> +};
> +
> +module_platform_driver(altera_pcie_driver);
> +
> +MODULE_AUTHOR("Ley Foon Tan <lftan@altera.com>");
> +MODULE_DESCRIPTION("Altera PCIe host controller driver");
> +MODULE_LICENSE("GPL v2");
> --
> 1.8.2.1
> 
> --
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
> 
