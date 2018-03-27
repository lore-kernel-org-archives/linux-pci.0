Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-wm0-f65.google.com ([74.125.82.65]:35994 "EHLO
        mail-wm0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751964AbeC0IQV (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 27 Mar 2018 04:16:21 -0400
Received: by mail-wm0-f65.google.com with SMTP id x82so19924546wmg.1
        for <linux-pci@vger.kernel.org>; Tue, 27 Mar 2018 01:16:20 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <20180314180449.GF27868@e107981-ln.cambridge.arm.com>
References: <1519734024-32253-1-git-send-email-l.subrahmanya@mobiveil.co.in> <20180314180449.GF27868@e107981-ln.cambridge.arm.com>
From: Subrahmanya Lingappa <l.subrahmanya@mobiveil.co.in>
Date: Tue, 27 Mar 2018 13:46:19 +0530
Message-ID: <CAFZiPx3WazcUGiy-c1vC+dzw6hoV1AmE8kvC7-57H1H-PPO+cw@mail.gmail.com>
Subject: Re: [PATCH v6 2/3] PCI: mobiveil: Add Mobiveil PCIe Host Bridge IP driver
To: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
Cc: linux-pci@vger.kernel.org, Bjorn Helgaas <bhelgaas@google.com>,
        Mingkai Hu <mingkai.hu@nxp.com>,
        Peter W Newton <peter.newton@nxp.com>,
        "M.h. Lian" <minghuan.lian@nxp.com>,
        Raj Raina <rajesh.raina@nxp.com>,
        Rajan Kapoor <rajan.kapoor@nxp.com>,
        Prabhjot Singh <prabhjot.singh@nxp.com>,
        Marc Zyngier <marc.zyngier@arm.com>, devicetree@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Lorenzo,
changed this to use handle_level_irq() and tested successfully, will
add this to the next version of patch.

Thanks.

On Wed, Mar 14, 2018 at 11:34 PM, Lorenzo Pieralisi
<lorenzo.pieralisi@arm.com> wrote:
> On Tue, Feb 27, 2018 at 07:20:24AM -0500, Subrahmanya Lingappa wrote:
>
> [...]
>
>> +static void mobiveil_mask_intx_irq(struct irq_data *data)
>> +{
>> +     struct irq_desc *desc = irq_to_desc(data->irq);
>> +     struct mobiveil_pcie *pcie;
>> +     unsigned long flags;
>> +     u32 mask;
>> +     u32 shifted_val;
>> +
>> +     pcie = irq_desc_get_chip_data(desc);
>> +     mask = 1 << ((data->hwirq + PAB_INTA_POS) - 1);
>> +     raw_spin_lock_irqsave(&pcie->intx_mask_lock, flags);
>> +     shifted_val = csr_readl(pcie, PAB_INTP_AMBA_MISC_ENB);
>> +     csr_writel(pcie, (shifted_val & (~mask)), PAB_INTP_AMBA_MISC_ENB);
>> +     raw_spin_unlock_irqrestore(&pcie->intx_mask_lock, flags);
>> +}
>> +
>> +static void mobiveil_unmask_intx_irq(struct irq_data *data)
>> +{
>> +     struct irq_desc *desc = irq_to_desc(data->irq);
>> +     struct mobiveil_pcie *pcie;
>> +     unsigned long flags;
>> +     u32 shifted_val;
>> +     u32 mask;
>> +
>> +     pcie = irq_desc_get_chip_data(desc);
>> +     mask = 1 << ((data->hwirq + PAB_INTA_POS) - 1);
>> +     raw_spin_lock_irqsave(&pcie->intx_mask_lock, flags);
>> +     shifted_val = csr_readl(pcie, PAB_INTP_AMBA_MISC_ENB);
>> +     csr_writel(pcie, (shifted_val | mask), PAB_INTP_AMBA_MISC_ENB);
>> +     raw_spin_unlock_irqrestore(&pcie->intx_mask_lock, flags);
>> +}
>> +
>> +static struct irq_chip intx_irq_chip = {
>> +     .name = "mobiveil_pcie:intx",
>> +     .irq_enable = mobiveil_unmask_intx_irq,
>> +     .irq_disable = mobiveil_mask_intx_irq,
>> +     .irq_mask = mobiveil_mask_intx_irq,
>> +     .irq_unmask = mobiveil_unmask_intx_irq,
>> +};
>> +
>> +/* routine to setup the INTx related data */
>> +static int mobiveil_pcie_intx_map(struct irq_domain *domain, unsigned int irq,
>> +             irq_hw_number_t hwirq)
>> +{
>> +     irq_set_chip_and_handler(irq, &intx_irq_chip, handle_simple_irq);
>
> The flow handler must be handle_level_irq(); INTX are level IRQs, with
> current code none of the above struct irq_chip methods would be called at
> all, please read handle_simple_irq() comments and update (and test) the code
> to handle_level_irq(). AFAICS the current driver does not handle IRQ
> masking and acking at all (because handle_simple_irq() does not call the
> relevant struct irq_chip methods).
>
> Thank you,
> Lorenzo
>
>> +     irq_set_chip_data(irq, domain->host_data);
>> +     return 0;
>> +}
>> +
>> +/* INTx domain operations structure */
>> +static const struct irq_domain_ops intx_domain_ops = {
>> +     .map = mobiveil_pcie_intx_map,
>> +     .xlate = pci_irqd_intx_xlate,
>> +};
>> +
>> +static int mobiveil_pcie_init_irq_domain(struct mobiveil_pcie *pcie)
>> +{
>> +     struct device *dev = &pcie->pdev->dev;
>> +     struct device_node *node = dev->of_node;
>> +     int ret;
>> +
>> +     /* setup INTx */
>> +     pcie->intx_domain = irq_domain_add_linear(node,
>> +                             PCI_NUM_INTX + 1, &intx_domain_ops, pcie);
>> +
>> +     if (!pcie->intx_domain) {
>> +             dev_err(dev, "Failed to get a INTx IRQ domain\n");
>> +             return -ENODEV;
>> +     }
>> +
>> +     raw_spin_lock_init(&pcie->intx_mask_lock);
>> +
>> +     return 0;
>> +}
>> +
>> +static int mobiveil_pcie_probe(struct platform_device *pdev)
>> +{
>> +     struct mobiveil_pcie *pcie;
>> +     struct pci_bus *bus;
>> +     struct pci_bus *child;
>> +     struct pci_host_bridge *bridge;
>> +     struct device *dev = &pdev->dev;
>> +     struct device_node *node = dev->of_node;
>> +     resource_size_t iobase;
>> +     int ret;
>> +
>> +     /* allocate the PCIe port */
>> +     bridge = devm_pci_alloc_host_bridge(dev, sizeof(*pcie));
>> +     if (!bridge)
>> +             return -ENODEV;
>> +
>> +     pcie = pci_host_bridge_priv(bridge);
>> +     if (!pcie)
>> +             return -ENOMEM;
>> +
>> +     pcie->pdev = pdev;
>> +
>> +     ret = mobiveil_pcie_parse_dt(pcie);
>> +     if (ret) {
>> +             dev_err(dev, "Parsing DT failed, ret: %x\n", ret);
>> +             return ret;
>> +     }
>> +
>> +     INIT_LIST_HEAD(&pcie->resources);
>> +
>> +     /* parse the host bridge base addresses from the device tree file */
>> +     ret = of_pci_get_host_bridge_resources(node,
>> +                     0, 0xff, &pcie->resources, &iobase);
>> +     if (ret) {
>> +             dev_err(dev, "Getting bridge resources failed\n");
>> +             return -ENOMEM;
>> +     }
>> +
>> +     /*
>> +      * configure all inbound and outbound windows and prepare the RC for
>> +      * config access
>> +      */
>> +     ret = mobiveil_host_init(pcie);
>> +     if (ret) {
>> +             dev_err(dev, "Failed to initialize host\n");
>> +             goto error;
>> +     }
>> +
>> +     /* fixup for PCIe class register */
>> +     csr_writel(pcie, 0x060402ab, PAB_INTP_AXI_PIO_CLASS);
>> +
>> +     /* initialize the IRQ domains */
>> +     ret = mobiveil_pcie_init_irq_domain(pcie);
>> +     if (ret) {
>> +             dev_err(dev, "Failed creating IRQ Domain\n");
>> +             goto error;
>> +     }
>> +
>> +     ret = devm_request_pci_bus_resources(dev, &pcie->resources);
>> +     if (ret)
>> +             goto error;
>> +
>> +     /* Initialize bridge */
>> +     list_splice_init(&pcie->resources, &bridge->windows);
>> +     bridge->dev.parent = dev;
>> +     bridge->sysdata = pcie;
>> +     bridge->busnr = pcie->root_bus_nr;
>> +     bridge->ops = &mobiveil_pcie_ops;
>> +     bridge->map_irq = of_irq_parse_and_map_pci;
>> +     bridge->swizzle_irq = pci_common_swizzle;
>> +
>> +     /* setup the kernel resources for the newly added PCIe root bus */
>> +     ret = pci_scan_root_bus_bridge(bridge);
>> +     if (ret)
>> +             goto error;
>> +
>> +     bus = bridge->bus;
>> +
>> +     pci_assign_unassigned_bus_resources(bus);
>> +     list_for_each_entry(child, &bus->children, node)
>> +             pcie_bus_configure_settings(child);
>> +     pci_bus_add_devices(bus);
>> +
>> +     platform_set_drvdata(pdev, pcie);
>> +
>> +     return 0;
>> +error:
>> +     pci_free_resource_list(&pcie->resources);
>> +     return ret;
>> +}
>> +
>> +static const struct of_device_id mobiveil_pcie_of_match[] = {
>> +     {.compatible = "mbvl,gpex40-pcie",},
>> +};
>> +
>> +MODULE_DEVICE_TABLE(of, mobiveil_pcie_of_match);
>> +
>> +static struct platform_driver mobiveil_pcie_driver = {
>> +     .probe = mobiveil_pcie_probe,
>> +     .driver = {
>> +                     .name = "mobiveil-pcie",
>> +                     .of_match_table = mobiveil_pcie_of_match,
>> +                     .suppress_bind_attrs = true,
>> +             },
>> +};
>> +
>> +builtin_platform_driver(mobiveil_pcie_driver);
>> +
>> +MODULE_LICENSE("GPL v2");
>> +MODULE_DESCRIPTION("Mobiveil PCIe host controller driver");
>> +MODULE_AUTHOR("Subrahmanya Lingappa <l.subrahmanya@mobiveil.co.in>");
>> --
>> 1.8.3.1
>>
