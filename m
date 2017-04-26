Return-Path: <linux-arm-kernel-bounces+bjorn=helgaas.com@lists.infradead.org>
Return-Path: <linux-arm-kernel-bounces+bjorn=helgaas.com@lists.infradead.org>
Message-ID: <1493194200.27023.79.camel@mtkswgap22>
Subject: Re: [PATCH 1/2] PCI: mediatek: Add Mediatek PCIe host controller
 support
From: Ryder Lee <ryder.lee@mediatek.com>
To: Arnd Bergmann <arnd@arndb.de>
Date: Wed, 26 Apr 2017 16:10:00 +0800
In-Reply-To: <CAK8P3a39TFkJ5=jp8me+Dyg-Qi-N_1ZKxpJGvnhmPEo4csnFCw@mail.gmail.com>
References: <1492935543-18190-1-git-send-email-ryder.lee@mediatek.com>
 <1492935543-18190-2-git-send-email-ryder.lee@mediatek.com>
 <CAK8P3a39TFkJ5=jp8me+Dyg-Qi-N_1ZKxpJGvnhmPEo4csnFCw@mail.gmail.com>
MIME-Version: 1.0
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Cc: devicetree@vger.kernel.org, linux-pci <linux-pci@vger.kernel.org>, Linux
 Kernel Mailing List <linux-kernel@vger.kernel.org>,
 Rob Herring <robh+dt@kernel.org>, linux-mediatek@lists.infradead.org,
 Bjorn Helgaas <bhelgaas@google.com>,
 Linux ARM <linux-arm-kernel@lists.infradead.org>
Content-Type: text/plain; charset="us-ascii"
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+bjorn=helgaas.com@lists.infradead.org
List-ID: <linux-pci.vger.kernel.org>

Hi,

On Tue, 2017-04-25 at 14:38 +0200, Arnd Bergmann wrote:
> On Sun, Apr 23, 2017 at 10:19 AM, Ryder Lee <ryder.lee@mediatek.com> wrote:
> 
> > +static inline bool mtk_pcie_link_is_up(struct mtk_pcie_port *port)
> > +{
> > +       return !!(readl_relaxed(port->base + PCIE_LINK_STATUS) &
> > +                 PCIE_PORT_LINKUP);
> > +}
> 
> If this is not performance critical, please use the regular readl() instead
> of readl_relaxed().

I will correct it.

> > +static bool mtk_pcie_valid_device(struct mtk_pcie *pcie,
> > +                                 struct pci_bus *bus, int devfn)
> > +{
> > +       struct mtk_pcie_port *port;
> > +       struct pci_dev *dev;
> > +       struct pci_bus *pbus;
> > +
> > +       /* if there is no link, then there is no device */
> > +       list_for_each_entry(port, &pcie->ports, list) {
> > +               if (bus->number == 0 && port->index == PCI_SLOT(devfn) &&
> > +                   mtk_pcie_link_is_up(port)) {
> > +                       return true;
> > +               } else if (bus->number != 0) {
> > +                       pbus = bus;
> > +                       do {
> > +                               dev = pbus->self;
> > +                               if (port->index == PCI_SLOT(dev->devfn) &&
> > +                                   mtk_pcie_link_is_up(port)) {
> > +                                       return true;
> > +                               }
> > +                               pbus = dev->bus;
> > +                       } while (dev->bus->number != 0);
> > +               }
> > +       }
> > +
> > +       return false;
> > +}
> 
> 
> 
> 
> > +static int mtk_pcie_hw_rd_cfg(struct mtk_pcie *pcie, u32 bus, u32 devfn,
> > +                             int where, int size, u32 *val)
> > +{
> > +       writel(PCIE_CONF_ADDR(where, PCI_FUNC(devfn), PCI_SLOT(devfn), bus),
> > +              pcie->base + PCIE_CFG_ADDR);
> > +
> > +       *val = 0;
> > +
> > +       switch (size) {
> > +       case 1:
> > +               *val = readb(pcie->base + PCIE_CFG_DATA + (where & 3));
> > +               break;
> > +       case 2:
> > +               *val = readw(pcie->base + PCIE_CFG_DATA + (where & 2));
> > +               break;
> > +       case 4:
> > +               *val = readl(pcie->base + PCIE_CFG_DATA);
> > +               break;
> > +       }
> > +
> > +       return PCIBIOS_SUCCESSFUL;
> > +}
> 
> This is a fairly standard set of read/write operations. Can you change
> the pci_ops
> to use pci_generic_config_read/pci_generic_config_write and an appropriate
> map function instead?

OK I will add a .map_bus() like this:
{ .

  writel(PCIE_CONF_ADDR(where, fun, slot, bus), base + PCIE_CFG_ADDR);

  return base + PCIE_CFG_DATA + (where & 3);

}
> > +static int mtk_pcie_enable_ports(struct mtk_pcie *pcie)
> > +{
> > +       struct device *dev = pcie->dev;
> > +       struct mtk_pcie_port *port, *tmp;
> > +       int err, linkup = 0;
> > +
> > +       list_for_each_entry_safe(port, tmp, &pcie->ports, list) {
> > +               err = clk_prepare_enable(port->sys_ck);
> > +               if (err) {
> > +                       dev_err(dev, "failed to enable port%d clock\n",
> > +                               port->index);
> > +                       continue;
> > +               }
> > +
> > +               /* assert RC */
> > +               reset_control_assert(port->reset);
> > +               /* de-assert RC */
> > +               reset_control_deassert(port->reset);
> > +
> > +               /* power on PHY */
> > +               err = phy_power_on(port->phy);
> > +               if (err) {
> > +                       dev_err(dev, "failed to power on port%d phy\n",
> > +                               port->index);
> > +                       goto err_phy_on;
> > +               }
> > +
> > +               mtk_pcie_assert_ports(port);
> > +
> 
> Similar to the comment I had for the binding, I wonder if it would be
> better to keep all the information about the ports in one place and
> then just deal with it at the root level.
> 
> Alternatively, we could decide to standardize on the properties
> you have added to the pcie port node, but then I would handle
> them in the pcieport driver rather than in the host bridge driver.

Sorry, I'm not sure what you want me to do here.

I could move all clock operation in root level. But we need to keep the
reset and PHY operation sequence in the loop, In addition, we could
easily free resources if ports link fail.

How about moving this function to mtk_pcie_parse_and_add_res()? 


> > +/*
> > + * This IP lacks interrupt status register to check or map INTx from
> > + * different devices at the same time.
> > + */
> > +static int __init mtk_pcie_map_irq(const struct pci_dev *dev, u8 slot, u8 pin)
> > +{
> > +       struct mtk_pcie *pcie = dev->bus->sysdata;
> > +       struct mtk_pcie_port *port;
> > +
> > +       list_for_each_entry(port, &pcie->ports, list)
> > +               if (port->index == slot)
> > +                       return port->irq;
> > +
> > +       return -1;
> > +}
> 
> This looks odd, what is it needed for specifically? It looks like
> it's broken for devices behind bridges, and the interrupt mapping
> should normally come from the interrupt-map property, without
> the need for a driver specific map_irq override.

Our hardware just has a GIC for each port and lacks interrupt status for
host driver to distinguish INTx. So I return port IRQ here.


> > +static int mtk_pcie_register_ports(struct mtk_pcie *pcie)
> > +{
> > +       struct pci_bus *bus, *child;
> > +
> > +       bus = pci_scan_root_bus(pcie->dev, 0, &mtk_pcie_ops, pcie,
> > +                               &pcie->resources);
> 
> Can you use the new pci_register_host_bridge() method instead of
> pci_scan_root_bus() here?

May I know what's difference between pci_scan_root_bus() and using
pci_register_host_bridge() directly? What situation should we use it?
It seems that just tegra use this new method currently.

I'm not sure whether I can still use pci_scan_root_bus() here? 

>        ARnd


Thanks for the review!



_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
