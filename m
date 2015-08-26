Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-lb0-f195.google.com ([209.85.217.195]:33578 "EHLO
	mail-lb0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751737AbbHZNTA (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Wed, 26 Aug 2015 09:19:00 -0400
MIME-Version: 1.0
In-Reply-To: <55DC5406.3080703@arm.com>
References: <1440495348-2666-1-git-send-email-lftan@altera.com>
	<1440495348-2666-3-git-send-email-lftan@altera.com>
	<55DC5406.3080703@arm.com>
Date: Wed, 26 Aug 2015 21:18:58 +0800
Message-ID: <CAFiDJ5_A0jO5aBXGDMpm8QCizNbWpvHp+v_v3f4p86wrrA96Vg@mail.gmail.com>
Subject: Re: [PATCH v5 2/5] pci:host: Add Altera PCIe host controller driver
From: Ley Foon Tan <lftan@altera.com>
To: Marc Zyngier <marc.zyngier@arm.com>
Cc: Bjorn Helgaas <bhelgaas@google.com>,
	Russell King <linux@arm.linux.org.uk>,
	Arnd Bergmann <arnd@arndb.de>,
	Dinh Nguyen <dinguyen@opensource.altera.com>,
	linux-pci@vger.kernel.org, devicetree@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
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

On Tue, Aug 25, 2015 at 7:39 PM, Marc Zyngier <marc.zyngier@arm.com> wrote:
>

> > +
> > +static void altera_pcie_retrain(struct pci_dev *dev)
> > +{
> > +     u16 linkcap, linkstat;
> > +
> > +     /*
> > +      * Set the retrain bit if the PCIe rootport support > 2.5GB/s, but
> > +      * current speed is 2.5 GB/s.
> > +      */
> > +     pcie_capability_read_word(dev, PCI_EXP_LNKCAP, &linkcap);
> > +
> > +     if ((linkcap & PCI_EXP_LNKCAP_SLS) <= PCI_EXP_LNKCAP_SLS_2_5GB)
> > +             return;
> > +
> > +     pcie_capability_read_word(dev, PCI_EXP_LNKSTA, &linkstat);
> > +     if ((linkstat & PCI_EXP_LNKSTA_CLS) == PCI_EXP_LNKSTA_CLS_2_5GB)
> > +             pcie_capability_set_word(dev, PCI_EXP_LNKCTL,
> > +                                      PCI_EXP_LNKCTL_RL);
> > +}
> > +DECLARE_PCI_FIXUP_EARLY(PCI_ANY_ID, PCI_ANY_ID, altera_pcie_retrain);
>
> Do I read this correctly? This function is being called on any PCI
> device, without any filtering? What if the platform is not using this
> driver despite the driver being compiled in?
Will change it to Altera vendor ID.

>
> > +
> > +static void altera_pcie_fixup_res(struct pci_dev *dev)
> > +{
> > +     /*
> > +      * Prevent enumeration of root port.
> > +      */
> > +     if (!dev->bus->parent && dev->devfn == 0) {
> > +             int i;
> > +
> > +             for (i = 0; i < PCI_NUM_RESOURCES; i++) {
> > +                     dev->resource[i].start = 0;
> > +                     dev->resource[i].end   = 0;
> > +                     dev->resource[i].flags   = 0;
> > +             }
> > +     }
> > +}
> > +DECLARE_PCI_FIXUP_HEADER(PCI_ANY_ID, PCI_ANY_ID, altera_pcie_fixup_res);
>
> Same here. I also question the validity of nuking the resources, but I'm
> not a PCI expert.
We want to hide the host BARs from kernel as their content doesn't fix
well in the resource management and cause the pci enumeration failed.
Some other controllers also using same way to hide the host BARs resources.
>
> > +
> > +static inline void cra_writel(struct altera_pcie *pcie, u32 value, u32 reg)
> > +{
> > +     writel_relaxed(value, pcie->cra_base + reg);
> > +}
> > +
> > +static inline u32 cra_readl(struct altera_pcie *pcie, u32 reg)
> > +{
> > +     return readl_relaxed(pcie->cra_base + reg);
> > +}
> > +
> > +static void tlp_read_rx(struct altera_pcie *pcie,
> > +                     struct tlp_rp_regpair_t *tlp_rp_regdata)
> > +{
> > +     tlp_rp_regdata->ctrl = cra_readl(pcie, RP_RXCPL_STATUS);
> > +     tlp_rp_regdata->reg0 = cra_readl(pcie, RP_RXCPL_REG0);
> > +     tlp_rp_regdata->reg1 = cra_readl(pcie, RP_RXCPL_REG1);
> > +}
> > +
> > +static void tlp_write_tx(struct altera_pcie *pcie,
> > +                      struct tlp_rp_regpair_t *tlp_rp_regdata)
> > +{
> > +     cra_writel(pcie, tlp_rp_regdata->reg0, RP_TX_REG0);
> > +     cra_writel(pcie, tlp_rp_regdata->reg1, RP_TX_REG1);
> > +     cra_writel(pcie, tlp_rp_regdata->ctrl, RP_TX_CNTRL);
> > +}
> > +
> > +static bool altera_pcie_link_is_up(struct altera_pcie *pcie)
> > +{
> > +     return !!(cra_readl(pcie, RP_LTSSM) & LTSSM_L0);
> > +}
> > +
> > +static bool altera_pcie_valid_config(struct altera_pcie *pcie,
> > +                                  struct pci_bus *bus, int dev)
> > +{
> > +     /* If there is no link, then there is no device */
> > +     if (bus->number != pcie->root_bus_nr) {
> > +             if (!altera_pcie_link_is_up(pcie))
> > +                     return false;
> > +     }
> > +
> > +     /* access only one slot on each root port */
> > +     if (bus->number == pcie->root_bus_nr && dev > 0)
> > +             return false;
> > +
> > +     /*
> > +      * Do not read more than one device on the bus directly attached
> > +      * to RC.
> > +      */
> > +     if (bus->primary == pcie->root_bus_nr && dev > 0)
> > +             return false;
> > +
> > +      return true;
> > +}
> > +
> > +static int tlp_read_packet(struct altera_pcie *pcie, u32 *value)
> > +{
> > +     u8 loop;
> > +     struct tlp_rp_regpair_t tlp_rp_regdata;
> > +
> > +     for (loop = 0; loop < TLP_LOOP; loop++) {
> > +             tlp_read_rx(pcie, &tlp_rp_regdata);
> > +             if (tlp_rp_regdata.ctrl & RP_RXCPL_EOP) {
> > +                     if (value)
> > +                             *value = tlp_rp_regdata.reg0;
> > +                     return PCIBIOS_SUCCESSFUL;
> > +             }
> > +             udelay(5);
> > +     }
> > +
> > +     return -ENOENT;
> > +}
> > +
> > +static void tlp_write_packet_unaligned(struct altera_pcie *pcie, u32 *headers,
> > +                                    u32 data)
> > +{
> > +     struct tlp_rp_regpair_t tlp_rp_regdata;
> > +
> > +     tlp_rp_regdata.reg0 = headers[0];
> > +     tlp_rp_regdata.reg1 = headers[1];
> > +     tlp_rp_regdata.ctrl = RP_TX_SOP;
> > +     tlp_write_tx(pcie, &tlp_rp_regdata);
> > +
> > +     tlp_rp_regdata.reg0 = headers[2];
> > +     tlp_rp_regdata.reg1 = data;
> > +     tlp_rp_regdata.ctrl = RP_TX_EOP;
> > +     tlp_write_tx(pcie, &tlp_rp_regdata);
> > +}
> > +
> > +static void tlp_write_packet_aligned(struct altera_pcie *pcie, u32 *headers,
> > +                                  u32 data)
> > +{
> > +     struct tlp_rp_regpair_t tlp_rp_regdata;
> > +
> > +     tlp_rp_regdata.reg0 = headers[0];
> > +     tlp_rp_regdata.reg1 = headers[1];
> > +     tlp_rp_regdata.ctrl = RP_TX_SOP;
> > +     tlp_write_tx(pcie, &tlp_rp_regdata);
> > +
> > +     tlp_rp_regdata.reg0 = headers[2];
> > +     tlp_rp_regdata.reg1 = 0;
> > +     tlp_rp_regdata.ctrl = 0;
> > +     tlp_write_tx(pcie, &tlp_rp_regdata);
> > +
> > +     tlp_rp_regdata.reg0 = data;
> > +     tlp_rp_regdata.reg1 = 0;
> > +     tlp_rp_regdata.ctrl = RP_TX_EOP;
> > +     tlp_write_tx(pcie, &tlp_rp_regdata);
> > +}
> > +
> > +static int tlp_cfg_dword_read(struct altera_pcie *pcie, u8 bus, u32 devfn,
> > +                           int where, u32 *value)
> > +{
> > +     int ret;
> > +     u32 headers[TLP_HDR_SIZE];
> > +
> > +     if (bus == pcie->root_bus_nr)
> > +             headers[0] = TLP_CFG_DW0(TLP_FMTTYPE_CFGRD0);
> > +     else
> > +             headers[0] = TLP_CFG_DW0(TLP_FMTTYPE_CFGRD1);
> > +
> > +     headers[1] = TLP_CFG_DW1(TLP_REQ_ID(pcie->root_bus_nr, devfn),
> > +                                     TLP_READ_TAG);
> > +     headers[2] = TLP_CFG_DW2(bus, devfn, where);
> > +
> > +     tlp_write_packet_unaligned(pcie, headers, 0);
> > +
> > +     ret = tlp_read_packet(pcie, value);
> > +     if (ret != PCIBIOS_SUCCESSFUL)
> > +             *value = ~0UL;  /* return 0xFFFFFFFF if error */
> > +
> > +     return ret;
> > +}
> > +
> > +static int tlp_cfg_dword_write(struct altera_pcie *pcie, u8 bus, u32 devfn,
> > +                            int where, u32 value)
> > +{
> > +     u32 headers[TLP_HDR_SIZE];
> > +     int ret;
> > +
> > +     if (bus == pcie->root_bus_nr)
> > +             headers[0] = TLP_CFG_DW0(TLP_FMTTYPE_CFGWR0);
> > +     else
> > +             headers[0] = TLP_CFG_DW0(TLP_FMTTYPE_CFGWR1);
> > +
> > +     headers[1] = TLP_CFG_DW1(TLP_REQ_ID(pcie->root_bus_nr, devfn),
> > +                                     TLP_WRITE_TAG);
> > +     headers[2] = TLP_CFG_DW2(bus, devfn, where);
> > +
> > +     /* check alignment to Qword */
> > +     if ((where & 0x7) == 0)
> > +             tlp_write_packet_aligned(pcie, headers, value);
> > +     else
> > +             tlp_write_packet_unaligned(pcie, headers, value);
> > +
> > +     ret = tlp_read_packet(pcie, NULL);
> > +     if (ret != PCIBIOS_SUCCESSFUL)
> > +             return ret;
> > +
> > +     /* Keep an eye out for changes to the root bus number */
> > +     if ((bus == pcie->root_bus_nr) && (where == PCI_PRIMARY_BUS))
> > +             pcie->root_bus_nr = (u8)(value);
> > +
> > +     return PCIBIOS_SUCCESSFUL;
> > +}
> > +
> > +static int altera_pcie_cfg_read(struct pci_bus *bus, unsigned int devfn,
> > +                             int where, int size, u32 *value)
> > +{
> > +     struct altera_pcie *pcie = bus->sysdata;
> > +     int ret;
> > +
> > +     if (!altera_pcie_valid_config(pcie, bus, PCI_SLOT(devfn))) {
> > +             *value = ~0UL;
> > +             return PCIBIOS_DEVICE_NOT_FOUND;
> > +     }
> > +
> > +     ret = tlp_cfg_dword_read(pcie, bus->number, devfn,
> > +                              (where & ~DWORD_MASK), value);
> > +     if (ret != PCIBIOS_SUCCESSFUL)
> > +             return ret;
> > +
> > +     if (size == 1)
> > +             *value = (*value >> (8 * (where & 0x3))) & 0xff;
> > +     else if (size == 2)
> > +             *value = (*value >> (8 * (where & 0x2))) & 0xffff;
>
> Please write this as a switch/case statement, with a default handling case.
Okay.

>
> > +
> > +     return PCIBIOS_SUCCESSFUL;
> > +}
> > +
> > +static int altera_pcie_cfg_write(struct pci_bus *bus, unsigned int devfn,
> > +                              int where, int size, u32 value)
> > +{
> > +     struct altera_pcie *pcie = bus->sysdata;
> > +     u32 data32 = value;
> > +     u32 shift = 8 * (where & 3);
> > +     int ret;
> > +
> > +     if (!altera_pcie_valid_config(pcie, bus, PCI_SLOT(devfn)))
> > +             return PCIBIOS_DEVICE_NOT_FOUND;
> > +
> > +     /* write partial */
> > +     if (size != sizeof(u32)) {
> > +             ret = tlp_cfg_dword_read(pcie, bus->number, devfn,
> > +                                      where & ~DWORD_MASK, &data32);
> > +             if (ret)
> > +                     return ret;
> > +
> > +             if (size == 2)
> > +                     data32 = (data32 & ~(0xffff << shift)) |
> > +                                     ((value & 0xffff) << shift);
> > +              else if (size == 1)
> > +                     data32 = (data32 & ~(0xff << shift)) |
> > +                                     ((value & 0xff) << shift);
>
> Same here.
Okay.

> > +     }
> > +
> > +     return tlp_cfg_dword_write(pcie, bus->number, devfn,
> > +             (where & ~DWORD_MASK), data32);
> > +}
> > +
> > +static struct pci_ops altera_pcie_ops = {
> > +     .read = altera_pcie_cfg_read,
> > +     .write = altera_pcie_cfg_write,
> > +};
> > +
> > +static int altera_pcie_intx_map(struct irq_domain *domain, unsigned int irq,
> > +                             irq_hw_number_t hwirq)
> > +{
> > +     irq_set_chip_and_handler(irq, &dummy_irq_chip, handle_simple_irq);
> > +     irq_set_chip_data(irq, domain->host_data);
> > +     set_irq_flags(irq, IRQF_VALID);
> > +
> > +     return 0;
> > +}
> > +
> > +static const struct irq_domain_ops intx_domain_ops = {
> > +     .map = altera_pcie_intx_map,
> > +};
> > +
> > +static void altera_pcie_isr(unsigned int irq, struct irq_desc *desc)
> > +{
> > +     struct irq_chip *chip = irq_desc_get_chip(desc);
> > +     struct altera_pcie *pcie;
> > +     unsigned long status;
> > +     u32 bit;
> > +     u32 virq;
> > +
> > +     chained_irq_enter(chip, desc);
> > +     pcie = irq_desc_get_handler_data(desc);
> > +
> > +     do {
> > +             status = cra_readl(pcie, P2A_INT_STATUS) & P2A_INT_STS_ALL;
> > +             if (!status)
> > +                     break;
> > +
> > +             do {
> > +                     bit = find_first_bit(&status, INTX_NUM);
> > +                     /* clear interrupts */
> > +                     cra_writel(pcie, 1 << bit, P2A_INT_STATUS);
> > +
> > +                     virq = irq_find_mapping(pcie->irq_domain, bit + 1);
> > +                     if (virq)
> > +                             generic_handle_irq(virq);
> > +                     else
> > +                             dev_info(&pcie->pdev->dev, "unexpected IRQ\n");
> > +
> > +                     /* Clear the bit from status and repeat without reading
> > +                      * again status register. */
> > +                     __clear_bit(bit, &status);
> > +             } while (status);
> > +     } while (1);
>
> Please rewrite similarily to the way I proposed in your MSI driver.
Okay.

Thanks.

Regards
Ley Foon
