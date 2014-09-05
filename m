Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mout.kundenserver.de ([212.227.126.130]:52678 "EHLO
	mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756087AbaIEIoS (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Fri, 5 Sep 2014 04:44:18 -0400
From: Arnd Bergmann <arnd@arndb.de>
To: "Minghuan.Lian@freescale.com" <Minghuan.Lian@freescale.com>
Cc: "linux-arm-kernel@lists.infradead.org"
	<linux-arm-kernel@lists.infradead.org>,
	"linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
	"Mingkai.Hu@freescale.com" <Mingkai.Hu@freescale.com>,
	Roy Zang <tie-fei.zang@freescale.com>
Subject: Re: =?UTF-8?B?562U5aSNOg==?= [PATCH 2/2] PCI: Layerscape: Add Layerscape PCIe driver
Date: Fri, 05 Sep 2014 10:44:10 +0200
Message-ID: <7284910.vZQKmpeMI1@wuerfel>
In-Reply-To: <1409930568256.17564@freescale.com>
References: <1409856338-1730-1-git-send-email-Minghuan.Lian@freescale.com> <2799937.bNtU9KXR6t@wuerfel> <1409930568256.17564@freescale.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Friday 05 September 2014 07:22:08 Minghuan.Lian@freescale.com wrote:
> Hi Arnd,
> 
> Please see my comments inline.

Please use the usual reply style in the future, using '>' characters to
properly give attribution. I'm fixing this up manually in my reply
here, so others can follow the discussion.

> > On Thursday 04 September 2014 18:45:38 Minghuan Lian wrote:
> > > +
> > > +#define PCIE_LS1021A_BASE    0x3400000
> > > +#define PCIE_LS1021A_REG_SIZE        0x0100000
> > 
> > This does not belong here. All addresses must come from DT,
> > and you should not do the calculation below based on the address.
> [Minghuan] LS1021A contains two PCI controllers. I use them to 
> calculation the PCI controller index.
> There are several separate registers for PEX1 and PEX2 in SCFG
> register space. It is hard to get them address from DTS. Could
> you tell me a way to get PCI controller index?

The easiest way would be to put the index as a property in the
device tree itself.

> > +struct ls_pcie {
> > +     struct list_head node;
> > +     struct device *dev;
> > +     struct pci_bus *bus;
> > +     void __iomem *dbi;
> > +     void __iomem *scfg;
> > +     struct pcie_port pp;
> > +     int id;
> > +     int index;
> > +     int irq;
> > +     int msi_irq;
> > +     int pme_irq;
> > +};
> 
> irq and pme_irq seem to be completely unused, so better
> not add them until they are actually used.
> [Minghuan] Ok, I will remove them.
> 
> The scfg registers seem to belong to another device that
> is responsible for multiple instances. Unfortunately,
> this "fsl,ls1021a-scfg" device is not documented anywhere
> that I can see.
> 
> Is this some sort of syscon node, or is it specific to the
> pcie controller(s)?
> 
> [Minghaun] SCFG provides SoC specific configuration and status
> registers for the device including PCI USB eTSEC SATA ...
> The platform patches that contains SCFG code are being upstream.

This sounds like it should be a syscon node, and you should use
syscon_regmap_lookup_by_phandle() to find the scfg node from each
of those drivers, rather than scanning the DT yourself in each
of the drivers using it.

This can also be a place to put the index, such as 

	scfg = <&scfg 0>;

for the first PCIe node. The probe function then extracts both
the phandle for the syscon and the index from that property.

> > +static int ls_pcie_link_up(struct pcie_port *pp)
> > +{
> > +     u32 rc, tmp;
> > +     struct ls_pcie *pcie = to_ls_pcie(pp);
> > +
> > +     tmp = ioread32(pcie->scfg + SCFG_SCFGREVCR_OFF);
> > +     iowrite32(SCFG_NO_BIT_REVERSE, pcie->scfg + SCFG_SCFGREVCR_OFF);
> > +
> > +     rc = (ioread32(pcie->scfg + PEXMSCPORTSR(pcie->index)) >>
> > +          LTSSM_STATE_SHIFT) & LTSSM_STATE_MASK;
> > +
> > +     iowrite32(tmp, pcie->scfg + SCFG_SCFGREVCR_OFF);
> > +
> > +     if (rc < LTSSM_PCIE_L0)
> > +             return 0;
> > +
> > +     return 1;
> > +}
> 
> This looks like it is really a phy driver, although a pretty minimal
> one.
> 
> [Minghuan] I read SCFG register. SCFG provides SoC specific configuration
> and status registers for the device including PCI USB eTSEC SATA ...

I'm guessing that a lot of that is phy related information though.
A nicer way to deal with this, compared to using syscon directly is
to have a phy driver for your chip, and have that deal with all
the phy related setup. In this case you would have a reference in
the client driver like

	phys = <&scfgphy LS1021A_PHY_PCIE0>;
	phy-names = "pcie";

And in the pcie driver you just call devm_phy_get(dev, "pcie") to get a reference
to that phy node, and then you can use the phy API to perform actions on
it (init, power_on, power_off, exit).

This keeps all knowledge about the phy registers inside of the scfg area
in one place, and you only have to add a new phy driver for a future SoC
that has the same PCIe core but different scfg.

> > +static u32 ls_pcie_get_msi_addr(struct pcie_port *pp)
> > +{
> > +     return SCFG_SPIMSICR_ADDR;
> > +}
> > +
> > +static u32 ls_pcie_get_msi_data(struct pcie_port *pp, int pos)
> > +{
> > +     struct ls_pcie *pcie = to_ls_pcie(pp);
> > +
> > +     if (pcie->id == PCI_DEVICE_ID_LS1021A)
> > +             return MSI_LS1021A_DATA(pcie->index);
> > +
> > +     return pos;
> > +}
> 
> My impression is that you have two distinct MSI controller
> implementations, one for LS1021A and the other one for everything
> else. How about using separate pcie_host_ops for them, possibly
> also moving them into separate files?
> 
> A good way to deal with this is to put the pointers to the two
> pcie_host_ops into the data fields of the ls_pcie_of_match table.
> 
> [Minghuan] LS1021 contains the same two PCI controllers PEX1 and PEX2.
> both PEX1 and PEX use the same MSI address, but different MSI message data.

I mean LS1021 is different from other chips here, since you compare
the pcie->id value.

	Arnd
