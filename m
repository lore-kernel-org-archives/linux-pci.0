Return-Path: <linux-kernel-owner@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <20150901163304.GA9769@red-moon>
References: <1441103408-8433-1-git-send-email-lftan@altera.com>
	<1441103408-8433-4-git-send-email-lftan@altera.com>
	<20150901163304.GA9769@red-moon>
Date: Fri, 4 Sep 2015 16:29:14 +0800
Message-ID: <CAFiDJ58WCjTNkU5PWtbHxj+-0oWNg1T+psfE-OaJD+4k-DBb-A@mail.gmail.com>
Subject: Re: [PATCH v6 3/6] pci:host: Add Altera PCIe host controller driver
From: Ley Foon Tan <lftan@altera.com>
To: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
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
	Rob Herring <robh+dt@kernel.org>,
	Pawel Moll <Pawel.Moll@arm.com>,
	Mark Rutland <Mark.Rutland@arm.com>,
	Ian Campbell <ijc+devicetree@hellion.org.uk>,
	Kumar Gala <galak@codeaurora.org>
Content-Type: text/plain; charset=UTF-8
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Wed, Sep 2, 2015 at 12:33 AM, Lorenzo Pieralisi
<lorenzo.pieralisi@arm.com> wrote:
>
> On Tue, Sep 01, 2015 at 11:30:05AM +0100, Ley Foon Tan wrote:
>
> [...]
>
> > +static void altera_pcie_retrain(struct pci_dev *dev)
> > +{
> > +       u16 linkcap, linkstat;
> > +
> > +       /*
> > +        * Set the retrain bit if the PCIe rootport support > 2.5GB/s, but
> > +        * current speed is 2.5 GB/s.
> > +        */
> > +       pcie_capability_read_word(dev, PCI_EXP_LNKCAP, &linkcap);
> > +
> > +       if ((linkcap & PCI_EXP_LNKCAP_SLS) <= PCI_EXP_LNKCAP_SLS_2_5GB)
> > +               return;
> > +
> > +       pcie_capability_read_word(dev, PCI_EXP_LNKSTA, &linkstat);
> > +       if ((linkstat & PCI_EXP_LNKSTA_CLS) == PCI_EXP_LNKSTA_CLS_2_5GB)
> > +               pcie_capability_set_word(dev, PCI_EXP_LNKCTL,
> > +                                        PCI_EXP_LNKCTL_RL);
> > +}
> > +DECLARE_PCI_FIXUP_EARLY(PCI_VENDOR_ID_ALTERA, PCI_ANY_ID, altera_pcie_retrain);
>
> This filtering is still arguable, since it unconditionally applies to
> all Altera PCI devices (I guess there are not any apart from this
> host controller).
This fixup is required for all Altera PCIe controller in all device families.
>
> > +
> > +static void altera_pcie_fixup_res(struct pci_dev *dev)
> > +{
> > +       /*
> > +        * Prevent enumeration of root port.
> > +        */
> > +       if (!dev->bus->parent && dev->devfn == 0) {
> > +               int i;
> > +
> > +               for (i = 0; i < PCI_NUM_RESOURCES; i++) {
> > +                       dev->resource[i].start = 0;
> > +                       dev->resource[i].end   = 0;
> > +                       dev->resource[i].flags   = 0;
> > +               }
> > +       }
> > +}
> > +DECLARE_PCI_FIXUP_HEADER(PCI_VENDOR_ID_ALTERA, PCI_ANY_ID,
> > +                        altera_pcie_fixup_res);
>
> Ditto, it is a quirk of your host controller, not a quirk for
> all Altera PCI devices.
Same here.

>
> > +static inline void cra_writel(struct altera_pcie *pcie, u32 value, u32 reg)
> > +{
> > +       writel_relaxed(value, pcie->cra_base + reg);
> > +}
> > +
> > +static inline u32 cra_readl(struct altera_pcie *pcie, u32 reg)
> > +{
> > +       return readl_relaxed(pcie->cra_base + reg);
> > +}
> > +
> > +static void tlp_read_rx(struct altera_pcie *pcie,
> > +                       struct tlp_rp_regpair_t *tlp_rp_regdata)
> > +{
> > +       tlp_rp_regdata->ctrl = cra_readl(pcie, RP_RXCPL_STATUS);
> > +       tlp_rp_regdata->reg0 = cra_readl(pcie, RP_RXCPL_REG0);
> > +       tlp_rp_regdata->reg1 = cra_readl(pcie, RP_RXCPL_REG1);
> > +}
> > +
> > +static void tlp_write_tx(struct altera_pcie *pcie,
> > +                        struct tlp_rp_regpair_t *tlp_rp_regdata)
> > +{
> > +       cra_writel(pcie, tlp_rp_regdata->reg0, RP_TX_REG0);
> > +       cra_writel(pcie, tlp_rp_regdata->reg1, RP_TX_REG1);
> > +       cra_writel(pcie, tlp_rp_regdata->ctrl, RP_TX_CNTRL);
> > +}
> > +
> > +static bool altera_pcie_link_is_up(struct altera_pcie *pcie)
> > +{
> > +       return !!(cra_readl(pcie, RP_LTSSM) & LTSSM_L0);
> > +}
> > +
> > +static bool altera_pcie_valid_config(struct altera_pcie *pcie,
> > +                                    struct pci_bus *bus, int dev)
> > +{
> > +       /* If there is no link, then there is no device */
> > +       if (bus->number != pcie->root_bus_nr) {
> > +               if (!altera_pcie_link_is_up(pcie))
> > +                       return false;
> > +       }
>
> Can you explain to pls me why you have to check this for every config
> transaction ? Isn't it something that can prevent probing the
> host controller altogether ?
In our PCIe hardware spec, it stated that software should check the
link status before issuing a configuration request to downstream
ports.
BTW, other pci controllers have similar implementation as well, eg: dw
pci, mvebu pci.
>
> > +
> > +       /* access only one slot on each root port */
> > +       if (bus->number == pcie->root_bus_nr && dev > 0)
> > +               return false;
> > +
> > +       /*
> > +        * Do not read more than one device on the bus directly attached
> > +        * to RC.
>
> You should also explain why.
Okay.

>
> > +        */
> > +       if (bus->primary == pcie->root_bus_nr && dev > 0)
> > +               return false;
> > +
> > +        return true;
> > +}
> > +
> > +static int tlp_read_packet(struct altera_pcie *pcie, u32 *value)
> > +{
> > +       u8 loop;
> > +       struct tlp_rp_regpair_t tlp_rp_regdata;
> > +
> > +       for (loop = 0; loop < TLP_LOOP; loop++) {
> > +               tlp_read_rx(pcie, &tlp_rp_regdata);
> > +               if (tlp_rp_regdata.ctrl & RP_RXCPL_EOP) {
> > +                       if (value)
> > +                               *value = tlp_rp_regdata.reg0;
> > +                       return PCIBIOS_SUCCESSFUL;
> > +               }
> > +               udelay(5);
>
> Could you comment please on the chosen udelay/TLP_LOOP values (ie how
> did you come up with them) ?
For udelay value, we just want to have small delay between each read.
For TLP_LOOP value, minimum 2 loops to read tlp headers and 1 loop to
read data payload. So, we choose to poll 10 loops for maximum.

>
> > +       }
> > +
> > +       return -ENOENT;
> > +}
> > +
> > +static void tlp_write_packet_unaligned(struct altera_pcie *pcie, u32 *headers,
> > +                                      u32 data)
> > +{
> > +       struct tlp_rp_regpair_t tlp_rp_regdata;
> > +
> > +       tlp_rp_regdata.reg0 = headers[0];
> > +       tlp_rp_regdata.reg1 = headers[1];
> > +       tlp_rp_regdata.ctrl = RP_TX_SOP;
> > +       tlp_write_tx(pcie, &tlp_rp_regdata);
> > +
> > +       tlp_rp_regdata.reg0 = headers[2];
> > +       tlp_rp_regdata.reg1 = data;
> > +       tlp_rp_regdata.ctrl = RP_TX_EOP;
> > +       tlp_write_tx(pcie, &tlp_rp_regdata);
> > +}
> > +
> > +static void tlp_write_packet_aligned(struct altera_pcie *pcie, u32 *headers,
> > +                                    u32 data)
> > +{
> > +       struct tlp_rp_regpair_t tlp_rp_regdata;
> > +
> > +       tlp_rp_regdata.reg0 = headers[0];
> > +       tlp_rp_regdata.reg1 = headers[1];
> > +       tlp_rp_regdata.ctrl = RP_TX_SOP;
> > +       tlp_write_tx(pcie, &tlp_rp_regdata);
> > +
> > +       tlp_rp_regdata.reg0 = headers[2];
> > +       tlp_rp_regdata.reg1 = 0;
> > +       tlp_rp_regdata.ctrl = 0;
> > +       tlp_write_tx(pcie, &tlp_rp_regdata);
> > +
> > +       tlp_rp_regdata.reg0 = data;
> > +       tlp_rp_regdata.reg1 = 0;
> > +       tlp_rp_regdata.ctrl = RP_TX_EOP;
> > +       tlp_write_tx(pcie, &tlp_rp_regdata);
> > +}
>
> I do not think you need two functions here, a flag can do.
Okay, will merge these 2 functions.
>
> > +static int tlp_cfg_dword_read(struct altera_pcie *pcie, u8 bus, u32 devfn,
> > +                             int where, u32 *value)
> > +{
> > +       int ret;
> > +       u32 headers[TLP_HDR_SIZE];
> > +
> > +       if (bus == pcie->root_bus_nr)
> > +               headers[0] = TLP_CFG_DW0(TLP_FMTTYPE_CFGRD0);
> > +       else
> > +               headers[0] = TLP_CFG_DW0(TLP_FMTTYPE_CFGRD1);
> > +
> > +       headers[1] = TLP_CFG_DW1(TLP_REQ_ID(pcie->root_bus_nr, devfn),
> > +                                       TLP_READ_TAG);
> > +       headers[2] = TLP_CFG_DW2(bus, devfn, where);
> > +
> > +       tlp_write_packet_unaligned(pcie, headers, 0);
> > +
> > +       ret = tlp_read_packet(pcie, value);
> > +       if (ret != PCIBIOS_SUCCESSFUL)
> > +               *value = ~0UL;  /* return 0xFFFFFFFF if error */
> > +
> > +       return ret;
> > +}
> > +
> > +static int tlp_cfg_dword_write(struct altera_pcie *pcie, u8 bus, u32 devfn,
> > +                              int where, u32 value)
> > +{
> > +       u32 headers[TLP_HDR_SIZE];
> > +       int ret;
> > +
> > +       if (bus == pcie->root_bus_nr)
> > +               headers[0] = TLP_CFG_DW0(TLP_FMTTYPE_CFGWR0);
> > +       else
> > +               headers[0] = TLP_CFG_DW0(TLP_FMTTYPE_CFGWR1);
> > +
> > +       headers[1] = TLP_CFG_DW1(TLP_REQ_ID(pcie->root_bus_nr, devfn),
> > +                                       TLP_WRITE_TAG);
> > +       headers[2] = TLP_CFG_DW2(bus, devfn, where);
> > +
> > +       /* check alignment to Qword */
> > +       if ((where & 0x7) == 0)
> > +               tlp_write_packet_aligned(pcie, headers, value);
> > +       else
> > +               tlp_write_packet_unaligned(pcie, headers, value);
> > +
> > +       ret = tlp_read_packet(pcie, NULL);
> > +       if (ret != PCIBIOS_SUCCESSFUL)
> > +               return ret;
> > +
> > +       /* Keep an eye out for changes to the root bus number */
> > +       if ((bus == pcie->root_bus_nr) && (where == PCI_PRIMARY_BUS))
> > +               pcie->root_bus_nr = (u8)(value);
>
> Essentially you are polling the rootport bridge programming here, correct ?
> I think you should describe this a bit better along with the assumptions
> you are making.
Yes, you are right. Will update description here.
>
[...]

> > +
> > +static void altera_pcie_release_of_pci_ranges(struct altera_pcie *pcie)
> > +{
> > +       pci_free_resource_list(&pcie->resources);
> > +}
> > +
> > +static int altera_pcie_parse_request_of_pci_ranges(struct altera_pcie *pcie)
> > +{
> > +       int err, res_valid = 0;
> > +       struct device *dev = &pcie->pdev->dev;
> > +       struct device_node *np = dev->of_node;
> > +       resource_size_t iobase;
> > +       struct resource_entry *win;
> > +
> > +       err = of_pci_get_host_bridge_resources(np, 0, 0xff, &pcie->resources,
> > +                                              &iobase);
>
> Nit: I do not see the point of passing iobase. You do not support IO space,
> if there is an IO address space in DT you want the function to barf,
> you do not want the function to initialize iobase silently.
>
> So, you should pass iobase as NULL, if there is an IO space in DT:
>
> of_pci_get_host_bridge_resources()
>
> will barf and that's what you want to flag FW misconfigurations up.
Okay, will pass in NULL for iobase.
>
> [...]
>
> > +static int altera_pcie_probe(struct platform_device *pdev)
> > +{
> > +       struct altera_pcie *pcie;
> > +       struct pci_bus *bus;
> > +       int ret;
> > +
> > +       pcie = devm_kzalloc(&pdev->dev, sizeof(*pcie), GFP_KERNEL);
> > +       if (!pcie)
> > +               return -ENOMEM;
> > +
> > +       pcie->pdev = pdev;
> > +
> > +       ret = altera_pcie_parse_dt(pcie);
> > +       if (ret) {
> > +               dev_err(&pdev->dev, "Parsing DT failed\n");
> > +               return ret;
> > +       }
> > +
> > +       INIT_LIST_HEAD(&pcie->resources);
> > +
> > +       ret = altera_pcie_parse_request_of_pci_ranges(pcie);
> > +       if (ret) {
> > +               dev_err(&pdev->dev, "Failed add resources\n");
> > +               return ret;
> > +       }
> > +
> > +       ret = altera_pcie_init_irq_domain(pcie);
> > +       if (ret) {
> > +               dev_err(&pdev->dev, "Failed creating IRQ Domain\n");
> > +               return ret;
> > +       }
> > +
> > +       pcie->root_bus_nr = 0;
>
> Nit: It is already 0.
Okay. Will remove it.
>
> > +
> > +       /* clear all interrupts */
> > +       cra_writel(pcie, P2A_INT_STS_ALL, P2A_INT_STATUS);
> > +       /* enable all interrupts */
> > +       cra_writel(pcie, P2A_INT_ENA_ALL, P2A_INT_ENABLE);
> > +
> > +       bus = pci_scan_root_bus(&pdev->dev, pcie->root_bus_nr, &altera_pcie_ops,
> > +                               pcie, &pcie->resources);
> > +       if (!bus)
> > +               return -ENOMEM;
> > +
> > +       pci_fixup_irqs(pci_common_swizzle, of_irq_parse_and_map_pci);
> > +       pci_assign_unassigned_bus_resources(bus);
>
> I think you are missing a call to pcie_bus_configure_settings(),
> see drivers/pci/host/pci-host-generic.c
Other pci controller drivers like xgene and iproc don't call to this
function, but it call in
arch/arm/kernel/bios32.c:pci_common_init_dev().
Do we really need this?

Thanks for reviewing.

Regards
Ley Foon
