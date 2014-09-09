Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mout.kundenserver.de ([212.227.126.187]:56575 "EHLO
	mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756034AbaIIJ4U convert rfc822-to-8bit (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Tue, 9 Sep 2014 05:56:20 -0400
From: Arnd Bergmann <arnd@arndb.de>
To: Lian Minghuan-B31939 <B31939@freescale.com>
Cc: "Minghuan.Lian@freescale.com" <Minghuan.Lian@freescale.com>,
	"linux-arm-kernel@lists.infradead.org"
	<linux-arm-kernel@lists.infradead.org>,
	"linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
	"Mingkai.Hu@freescale.com" <Mingkai.Hu@freescale.com>,
	Roy Zang <tie-fei.zang@freescale.com>
Subject: Re: =?UTF-8?B?562U5aSNOg==?= [PATCH 2/2] PCI: Layerscape: Add Layerscape PCIe driver
Date: Tue, 09 Sep 2014 11:56:11 +0200
Message-ID: <6844751.zBSvS2zU47@wuerfel>
In-Reply-To: <540F3825.6080601@freescale.com>
References: <1409856338-1730-1-git-send-email-Minghuan.Lian@freescale.com> <7284910.vZQKmpeMI1@wuerfel> <540F3825.6080601@freescale.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Tuesday 09 September 2014 17:25:57 Lian Minghuan-B31939 wrote:
> On 2014年09月05日 08:44, Arnd Bergmann wrote:
> > On Friday 05 September 2014 07:22:08 Minghuan.Lian@freescale.com wrote:
> >>> +struct ls_pcie {
> >>> +     struct list_head node;
> >>> +     struct device *dev;
> >>> +     struct pci_bus *bus;
> >>> +     void __iomem *dbi;
> >>> +     void __iomem *scfg;
> >>> +     struct pcie_port pp;
> >>> +     int id;
> >>> +     int index;
> >>> +     int irq;
> >>> +     int msi_irq;
> >>> +     int pme_irq;
> >>> +};
> >> irq and pme_irq seem to be completely unused, so better
> >> not add them until they are actually used.
> >> [Minghuan] Ok, I will remove them.
> >>
> >> The scfg registers seem to belong to another device that
> >> is responsible for multiple instances. Unfortunately,
> >> this "fsl,ls1021a-scfg" device is not documented anywhere
> >> that I can see.
> >>
> >> Is this some sort of syscon node, or is it specific to the
> >> pcie controller(s)?
> >>
> >> [Minghaun] SCFG provides SoC specific configuration and status
> >> registers for the device including PCI USB eTSEC SATA ...
> >> The platform patches that contains SCFG code are being upstream.
> > This sounds like it should be a syscon node, and you should use
> > syscon_regmap_lookup_by_phandle() to find the scfg node from each
> > of those drivers, rather than scanning the DT yourself in each
> > of the drivers using it.
> >
> > This can also be a place to put the index, such as
> >
> > 	scfg = <&scfg 0>;
> >
> > for the first PCIe node. The probe function then extracts both
> > the phandle for the syscon and the index from that property.
> [Minghuan] I discussed with my colleague. They worry about performance 
> degradation if using regmap API,
> because there are some fast device use scfg. We tend to use a simple way 
> to map andread/write scfg directly.

I see. In this case, I would probably create a separate msi controller
driver that owns the "fsl,ls1021a-scfg" device, and is referenced
through the "msi-parent" property in the pcie controller.

You can use of_pci_find_msi_chip_by_node() to get the msi_chip
instance and then connect that to your pci host. This will also
take care of the case where you may want to use the main GICv3
on a future SoC.

> >>> +static int ls_pcie_link_up(struct pcie_port *pp)
> >>> +{
> >>> +     u32 rc, tmp;
> >>> +     struct ls_pcie *pcie = to_ls_pcie(pp);
> >>> +
> >>> +     tmp = ioread32(pcie->scfg + SCFG_SCFGREVCR_OFF);
> >>> +     iowrite32(SCFG_NO_BIT_REVERSE, pcie->scfg + SCFG_SCFGREVCR_OFF);
> >>> +
> >>> +     rc = (ioread32(pcie->scfg + PEXMSCPORTSR(pcie->index)) >>
> >>> +          LTSSM_STATE_SHIFT) & LTSSM_STATE_MASK;
> >>> +
> >>> +     iowrite32(tmp, pcie->scfg + SCFG_SCFGREVCR_OFF);
> >>> +
> >>> +     if (rc < LTSSM_PCIE_L0)
> >>> +             return 0;
> >>> +
> >>> +     return 1;
> >>> +}
> >> This looks like it is really a phy driver, although a pretty minimal
> >> one.
> >>
> >> [Minghuan] I read SCFG register. SCFG provides SoC specific configuration
> >> and status registers for the device including PCI USB eTSEC SATA ...
> > I'm guessing that a lot of that is phy related information though.
> > A nicer way to deal with this, compared to using syscon directly is
> > to have a phy driver for your chip, and have that deal with all
> > the phy related setup. In this case you would have a reference in
> > the client driver like
> >
> > 	phys = <&scfgphy LS1021A_PHY_PCIE0>;
> > 	phy-names = "pcie";
> >
> > And in the pcie driver you just call devm_phy_get(dev, "pcie") to get a reference
> > to that phy node, and then you can use the phy API to perform actions on
> > it (init, power_on, power_off, exit).
> >
> > This keeps all knowledge about the phy registers inside of the scfg area
> > in one place, and you only have to add a new phy driver for a future SoC
> > that has the same PCIe core but different scfg.
> [Minghuan] SCFG does not contains power_on power_off or other PCI 
> control registers.
> We only  get link up and MSI related status via SCFG. So I think it is 
> not enough to call scfg PCIe phy.

Ok, then use syscon for this one. Note that we are currently changing
the syscon code to make it easier for the same device to be both syscon
and driven by another device driver such as the msi_chip above.

	Arnd
