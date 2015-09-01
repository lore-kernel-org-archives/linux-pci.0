Return-Path: <linux-kernel-owner@vger.kernel.org>
Date: Tue, 1 Sep 2015 17:33:04 +0100
From: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
To: Ley Foon Tan <lftan@altera.com>
Cc: Bjorn Helgaas <bhelgaas@google.com>,
	Russell King <linux@arm.linux.org.uk>,
	Marc Zyngier <Marc.Zyngier@arm.com>,
	Arnd Bergmann <arnd@arndb.de>,
	Dinh Nguyen <dinguyen@opensource.altera.com>,
	"linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
	"devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
	"linux-arm-kernel@lists.infradead.org"
	<linux-arm-kernel@lists.infradead.org>,
	"linux-doc@vger.kernel.org" <linux-doc@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"lftan.linux@gmail.com" <lftan.linux@gmail.com>,
	Rob Herring <robh+dt@kernel.org>,
	Pawel Moll <Pawel.Moll@arm.com>,
	Mark Rutland <Mark.Rutland@arm.com>,
	Ian Campbell <ijc+devicetree@hellion.org.uk>,
	Kumar Gala <galak@codeaurora.org>
Subject: Re: [PATCH v6 3/6] pci:host: Add Altera PCIe host controller driver
Message-ID: <20150901163304.GA9769@red-moon>
References: <1441103408-8433-1-git-send-email-lftan@altera.com>
 <1441103408-8433-4-git-send-email-lftan@altera.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1441103408-8433-4-git-send-email-lftan@altera.com>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Tue, Sep 01, 2015 at 11:30:05AM +0100, Ley Foon Tan wrote:

[...]

> +static void altera_pcie_retrain(struct pci_dev *dev)
> +{
> +       u16 linkcap, linkstat;
> +
> +       /*
> +        * Set the retrain bit if the PCIe rootport support > 2.5GB/s, but
> +        * current speed is 2.5 GB/s.
> +        */
> +       pcie_capability_read_word(dev, PCI_EXP_LNKCAP, &linkcap);
> +
> +       if ((linkcap & PCI_EXP_LNKCAP_SLS) <= PCI_EXP_LNKCAP_SLS_2_5GB)
> +               return;
> +
> +       pcie_capability_read_word(dev, PCI_EXP_LNKSTA, &linkstat);
> +       if ((linkstat & PCI_EXP_LNKSTA_CLS) == PCI_EXP_LNKSTA_CLS_2_5GB)
> +               pcie_capability_set_word(dev, PCI_EXP_LNKCTL,
> +                                        PCI_EXP_LNKCTL_RL);
> +}
> +DECLARE_PCI_FIXUP_EARLY(PCI_VENDOR_ID_ALTERA, PCI_ANY_ID, altera_pcie_retrain);

This filtering is still arguable, since it unconditionally applies to
all Altera PCI devices (I guess there are not any apart from this
host controller).

> +
> +static void altera_pcie_fixup_res(struct pci_dev *dev)
> +{
> +       /*
> +        * Prevent enumeration of root port.
> +        */
> +       if (!dev->bus->parent && dev->devfn == 0) {
> +               int i;
> +
> +               for (i = 0; i < PCI_NUM_RESOURCES; i++) {
> +                       dev->resource[i].start = 0;
> +                       dev->resource[i].end   = 0;
> +                       dev->resource[i].flags   = 0;
> +               }
> +       }
> +}
> +DECLARE_PCI_FIXUP_HEADER(PCI_VENDOR_ID_ALTERA, PCI_ANY_ID,
> +                        altera_pcie_fixup_res);

Ditto, it is a quirk of your host controller, not a quirk for
all Altera PCI devices.

> +static inline void cra_writel(struct altera_pcie *pcie, u32 value, u32 reg)
> +{
> +       writel_relaxed(value, pcie->cra_base + reg);
> +}
> +
> +static inline u32 cra_readl(struct altera_pcie *pcie, u32 reg)
> +{
> +       return readl_relaxed(pcie->cra_base + reg);
> +}
> +
> +static void tlp_read_rx(struct altera_pcie *pcie,
> +                       struct tlp_rp_regpair_t *tlp_rp_regdata)
> +{
> +       tlp_rp_regdata->ctrl = cra_readl(pcie, RP_RXCPL_STATUS);
> +       tlp_rp_regdata->reg0 = cra_readl(pcie, RP_RXCPL_REG0);
> +       tlp_rp_regdata->reg1 = cra_readl(pcie, RP_RXCPL_REG1);
> +}
> +
> +static void tlp_write_tx(struct altera_pcie *pcie,
> +                        struct tlp_rp_regpair_t *tlp_rp_regdata)
> +{
> +       cra_writel(pcie, tlp_rp_regdata->reg0, RP_TX_REG0);
> +       cra_writel(pcie, tlp_rp_regdata->reg1, RP_TX_REG1);
> +       cra_writel(pcie, tlp_rp_regdata->ctrl, RP_TX_CNTRL);
> +}
> +
> +static bool altera_pcie_link_is_up(struct altera_pcie *pcie)
> +{
> +       return !!(cra_readl(pcie, RP_LTSSM) & LTSSM_L0);
> +}
> +
> +static bool altera_pcie_valid_config(struct altera_pcie *pcie,
> +                                    struct pci_bus *bus, int dev)
> +{
> +       /* If there is no link, then there is no device */
> +       if (bus->number != pcie->root_bus_nr) {
> +               if (!altera_pcie_link_is_up(pcie))
> +                       return false;
> +       }

Can you explain to pls me why you have to check this for every config
transaction ? Isn't it something that can prevent probing the
host controller altogether ?

> +
> +       /* access only one slot on each root port */
> +       if (bus->number == pcie->root_bus_nr && dev > 0)
> +               return false;
> +
> +       /*
> +        * Do not read more than one device on the bus directly attached
> +        * to RC.

You should also explain why.

> +        */
> +       if (bus->primary == pcie->root_bus_nr && dev > 0)
> +               return false;
> +
> +        return true;
> +}
> +
> +static int tlp_read_packet(struct altera_pcie *pcie, u32 *value)
> +{
> +       u8 loop;
> +       struct tlp_rp_regpair_t tlp_rp_regdata;
> +
> +       for (loop = 0; loop < TLP_LOOP; loop++) {
> +               tlp_read_rx(pcie, &tlp_rp_regdata);
> +               if (tlp_rp_regdata.ctrl & RP_RXCPL_EOP) {
> +                       if (value)
> +                               *value = tlp_rp_regdata.reg0;
> +                       return PCIBIOS_SUCCESSFUL;
> +               }
> +               udelay(5);

Could you comment please on the chosen udelay/TLP_LOOP values (ie how
did you come up with them) ?

> +       }
> +
> +       return -ENOENT;
> +}
> +
> +static void tlp_write_packet_unaligned(struct altera_pcie *pcie, u32 *headers,
> +                                      u32 data)
> +{
> +       struct tlp_rp_regpair_t tlp_rp_regdata;
> +
> +       tlp_rp_regdata.reg0 = headers[0];
> +       tlp_rp_regdata.reg1 = headers[1];
> +       tlp_rp_regdata.ctrl = RP_TX_SOP;
> +       tlp_write_tx(pcie, &tlp_rp_regdata);
> +
> +       tlp_rp_regdata.reg0 = headers[2];
> +       tlp_rp_regdata.reg1 = data;
> +       tlp_rp_regdata.ctrl = RP_TX_EOP;
> +       tlp_write_tx(pcie, &tlp_rp_regdata);
> +}
> +
> +static void tlp_write_packet_aligned(struct altera_pcie *pcie, u32 *headers,
> +                                    u32 data)
> +{
> +       struct tlp_rp_regpair_t tlp_rp_regdata;
> +
> +       tlp_rp_regdata.reg0 = headers[0];
> +       tlp_rp_regdata.reg1 = headers[1];
> +       tlp_rp_regdata.ctrl = RP_TX_SOP;
> +       tlp_write_tx(pcie, &tlp_rp_regdata);
> +
> +       tlp_rp_regdata.reg0 = headers[2];
> +       tlp_rp_regdata.reg1 = 0;
> +       tlp_rp_regdata.ctrl = 0;
> +       tlp_write_tx(pcie, &tlp_rp_regdata);
> +
> +       tlp_rp_regdata.reg0 = data;
> +       tlp_rp_regdata.reg1 = 0;
> +       tlp_rp_regdata.ctrl = RP_TX_EOP;
> +       tlp_write_tx(pcie, &tlp_rp_regdata);
> +}

I do not think you need two functions here, a flag can do.

> +static int tlp_cfg_dword_read(struct altera_pcie *pcie, u8 bus, u32 devfn,
> +                             int where, u32 *value)
> +{
> +       int ret;
> +       u32 headers[TLP_HDR_SIZE];
> +
> +       if (bus == pcie->root_bus_nr)
> +               headers[0] = TLP_CFG_DW0(TLP_FMTTYPE_CFGRD0);
> +       else
> +               headers[0] = TLP_CFG_DW0(TLP_FMTTYPE_CFGRD1);
> +
> +       headers[1] = TLP_CFG_DW1(TLP_REQ_ID(pcie->root_bus_nr, devfn),
> +                                       TLP_READ_TAG);
> +       headers[2] = TLP_CFG_DW2(bus, devfn, where);
> +
> +       tlp_write_packet_unaligned(pcie, headers, 0);
> +
> +       ret = tlp_read_packet(pcie, value);
> +       if (ret != PCIBIOS_SUCCESSFUL)
> +               *value = ~0UL;  /* return 0xFFFFFFFF if error */
> +
> +       return ret;
> +}
> +
> +static int tlp_cfg_dword_write(struct altera_pcie *pcie, u8 bus, u32 devfn,
> +                              int where, u32 value)
> +{
> +       u32 headers[TLP_HDR_SIZE];
> +       int ret;
> +
> +       if (bus == pcie->root_bus_nr)
> +               headers[0] = TLP_CFG_DW0(TLP_FMTTYPE_CFGWR0);
> +       else
> +               headers[0] = TLP_CFG_DW0(TLP_FMTTYPE_CFGWR1);
> +
> +       headers[1] = TLP_CFG_DW1(TLP_REQ_ID(pcie->root_bus_nr, devfn),
> +                                       TLP_WRITE_TAG);
> +       headers[2] = TLP_CFG_DW2(bus, devfn, where);
> +
> +       /* check alignment to Qword */
> +       if ((where & 0x7) == 0)
> +               tlp_write_packet_aligned(pcie, headers, value);
> +       else
> +               tlp_write_packet_unaligned(pcie, headers, value);
> +
> +       ret = tlp_read_packet(pcie, NULL);
> +       if (ret != PCIBIOS_SUCCESSFUL)
> +               return ret;
> +
> +       /* Keep an eye out for changes to the root bus number */
> +       if ((bus == pcie->root_bus_nr) && (where == PCI_PRIMARY_BUS))
> +               pcie->root_bus_nr = (u8)(value);

Essentially you are polling the rootport bridge programming here, correct ?
I think you should describe this a bit better along with the assumptions
you are making.

> +
> +       return PCIBIOS_SUCCESSFUL;
> +}
> +
> +static int altera_pcie_cfg_read(struct pci_bus *bus, unsigned int devfn,
> +                               int where, int size, u32 *value)
> +{
> +       struct altera_pcie *pcie = bus->sysdata;
> +       int ret;
> +       u32 data;
> +
> +       if (!altera_pcie_valid_config(pcie, bus, PCI_SLOT(devfn))) {
> +               *value = ~0UL;
> +               return PCIBIOS_DEVICE_NOT_FOUND;
> +       }
> +
> +       ret = tlp_cfg_dword_read(pcie, bus->number, devfn,
> +                                (where & ~DWORD_MASK), &data);
> +       if (ret != PCIBIOS_SUCCESSFUL)
> +               return ret;
> +
> +       switch (size) {
> +       case 1:
> +               *value = (data >> (8 * (where & 0x3))) & 0xff;
> +               break;
> +       case 2:
> +               *value = (data >> (8 * (where & 0x2))) & 0xffff;
> +               break;
> +       default:
> +               *value = data;
> +               break;
> +       }
> +
> +       return PCIBIOS_SUCCESSFUL;
> +}
> +
> +static int altera_pcie_cfg_write(struct pci_bus *bus, unsigned int devfn,
> +                                int where, int size, u32 value)
> +{
> +       struct altera_pcie *pcie = bus->sysdata;
> +       u32 data32;
> +       u32 shift = 8 * (where & 3);
> +       int ret;
> +
> +       if (!altera_pcie_valid_config(pcie, bus, PCI_SLOT(devfn)))
> +               return PCIBIOS_DEVICE_NOT_FOUND;
> +
> +       /* write partial */
> +       if (size != sizeof(u32)) {
> +               ret = tlp_cfg_dword_read(pcie, bus->number, devfn,
> +                                        where & ~DWORD_MASK, &data32);
> +               if (ret)
> +                       return ret;
> +       }
> +
> +       switch (size) {
> +       case 1:
> +               data32 = (data32 & ~(0xff << shift)) |
> +                               ((value & 0xff) << shift);
> +               break;
> +       case 2:
> +               data32 = (data32 & ~(0xffff << shift)) |
> +                               ((value & 0xffff) << shift);
> +               break;
> +       default:
> +               data32 = value;
> +               break;
> +       }
> +
> +       return tlp_cfg_dword_write(pcie, bus->number, devfn,
> +               (where & ~DWORD_MASK), data32);
> +}
> +
> +static struct pci_ops altera_pcie_ops = {
> +       .read = altera_pcie_cfg_read,
> +       .write = altera_pcie_cfg_write,
> +};
> +
> +static int altera_pcie_intx_map(struct irq_domain *domain, unsigned int irq,
> +                               irq_hw_number_t hwirq)
> +{
> +       irq_set_chip_and_handler(irq, &dummy_irq_chip, handle_simple_irq);
> +       irq_set_chip_data(irq, domain->host_data);
> +       set_irq_flags(irq, IRQF_VALID);
> +
> +       return 0;
> +}
> +
> +static const struct irq_domain_ops intx_domain_ops = {
> +       .map = altera_pcie_intx_map,
> +};
> +
> +static void altera_pcie_isr(unsigned int irq, struct irq_desc *desc)
> +{
> +       struct irq_chip *chip = irq_desc_get_chip(desc);
> +       struct altera_pcie *pcie;
> +       unsigned long status;
> +       u32 bit;
> +       u32 virq;
> +
> +       chained_irq_enter(chip, desc);
> +       pcie = irq_desc_get_handler_data(desc);
> +
> +       while ((status = cra_readl(pcie, P2A_INT_STATUS)
> +               & P2A_INT_STS_ALL) != 0) {
> +               for_each_set_bit(bit, &status, INTX_NUM) {
> +                       /* clear interrupts */
> +                       cra_writel(pcie, 1 << bit, P2A_INT_STATUS);
> +
> +                       virq = irq_find_mapping(pcie->irq_domain, bit + 1);
> +                       if (virq)
> +                               generic_handle_irq(virq);
> +                       else
> +                               dev_err(&pcie->pdev->dev, "unexpected IRQ\n");
> +               }
> +       }
> +
> +       chained_irq_exit(chip, desc);
> +}
> +
> +static void altera_pcie_release_of_pci_ranges(struct altera_pcie *pcie)
> +{
> +       pci_free_resource_list(&pcie->resources);
> +}
> +
> +static int altera_pcie_parse_request_of_pci_ranges(struct altera_pcie *pcie)
> +{
> +       int err, res_valid = 0;
> +       struct device *dev = &pcie->pdev->dev;
> +       struct device_node *np = dev->of_node;
> +       resource_size_t iobase;
> +       struct resource_entry *win;
> +
> +       err = of_pci_get_host_bridge_resources(np, 0, 0xff, &pcie->resources,
> +                                              &iobase);

Nit: I do not see the point of passing iobase. You do not support IO space,
if there is an IO address space in DT you want the function to barf,
you do not want the function to initialize iobase silently.

So, you should pass iobase as NULL, if there is an IO space in DT:

of_pci_get_host_bridge_resources()

will barf and that's what you want to flag FW misconfigurations up.

[...]

> +static int altera_pcie_probe(struct platform_device *pdev)
> +{
> +       struct altera_pcie *pcie;
> +       struct pci_bus *bus;
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
> +       pcie->root_bus_nr = 0;

Nit: It is already 0.

> +
> +       /* clear all interrupts */
> +       cra_writel(pcie, P2A_INT_STS_ALL, P2A_INT_STATUS);
> +       /* enable all interrupts */
> +       cra_writel(pcie, P2A_INT_ENA_ALL, P2A_INT_ENABLE);
> +
> +       bus = pci_scan_root_bus(&pdev->dev, pcie->root_bus_nr, &altera_pcie_ops,
> +                               pcie, &pcie->resources);
> +       if (!bus)
> +               return -ENOMEM;
> +
> +       pci_fixup_irqs(pci_common_swizzle, of_irq_parse_and_map_pci);
> +       pci_assign_unassigned_bus_resources(bus);

I think you are missing a call to pcie_bus_configure_settings(),
see drivers/pci/host/pci-host-generic.c

Thanks,
Lorenzo

> +       pci_bus_add_devices(bus);

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
