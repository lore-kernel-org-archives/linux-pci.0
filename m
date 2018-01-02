Return-Path: <SRS0=9jKw=D5=arm.com=lorenzo.pieralisi@kernel.org>
Return-Path: <SRS0=9jKw=D5=arm.com=lorenzo.pieralisi@kernel.org>
Date: Tue, 2 Jan 2018 10:56:59 +0000
From: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
To: Honghui Zhang <honghui.zhang@mediatek.com>
Cc: Bjorn Helgaas <helgaas@kernel.org>, bhelgaas@google.com,
	matthias.bgg@gmail.com, linux-arm-kernel@lists.infradead.org,
	linux-mediatek@lists.infradead.org, linux-pci@vger.kernel.org,
	linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
	yingjoe.chen@mediatek.com, eddie.huang@mediatek.com,
	ryder.lee@mediatek.com, hongkun.cao@mediatek.com,
	youlin.pei@mediatek.com, yong.wu@mediatek.com, yt.shen@mediatek.com,
	sean.wang@mediatek.com, xinping.qian@mediatek.com
Subject: Re: [PATCH v5 2/2] PCI: mediatek: Set up class type and vendor ID
 for MT7622
Message-ID: <20180102105659.GB10536@red-moon>
References: <1514336394-17747-1-git-send-email-honghui.zhang@mediatek.com>
 <1514336394-17747-3-git-send-email-honghui.zhang@mediatek.com>
 <20171227184542.GA79892@bhelgaas-glaptop.roam.corp.google.com>
 <1514425152.25872.39.camel@mhfsdcap03>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1514425152.25872.39.camel@mhfsdcap03>
List-ID: <linux-pci.vger.kernel.org>

On Thu, Dec 28, 2017 at 09:39:12AM +0800, Honghui Zhang wrote:
> On Wed, 2017-12-27 at 12:45 -0600, Bjorn Helgaas wrote:
> > On Wed, Dec 27, 2017 at 08:59:54AM +0800, honghui.zhang@mediatek.com wrote:
> > > From: Honghui Zhang <honghui.zhang@mediatek.com>
> > > 
> > > The hardware default value of IDs and class type is not correct,
> > > fix that by setup the correct values before start up.
> > > 
> > > Signed-off-by: Honghui Zhang <honghui.zhang@mediatek.com>
> > > ---
> > >  drivers/pci/host/pcie-mediatek.c | 12 ++++++++++++
> > >  include/linux/pci_ids.h          |  2 ++
> > >  2 files changed, 14 insertions(+)
> > > 
> > > diff --git a/drivers/pci/host/pcie-mediatek.c b/drivers/pci/host/pcie-mediatek.c
> > > index fc29a9a..62aac0ea 100644
> > > --- a/drivers/pci/host/pcie-mediatek.c
> > > +++ b/drivers/pci/host/pcie-mediatek.c
> > > @@ -74,6 +74,10 @@
> > >  
> > >  /* PCIe V2 per-port registers */
> > >  #define PCIE_MSI_VECTOR		0x0c0
> > > +
> > > +#define PCIE_CONF_ID		0x100
> > > +#define PCIE_CONF_CLASS		0x104
> > > +
> > >  #define PCIE_INT_MASK		0x420
> > >  #define INTX_MASK		GENMASK(19, 16)
> > >  #define INTX_SHIFT		16
> > > @@ -393,6 +397,14 @@ static int mtk_pcie_startup_port_v2(struct mtk_pcie_port *port)
> > >  		val |= PCIE_CSR_LTSSM_EN(port->slot) |
> > >  		       PCIE_CSR_ASPM_L1_EN(port->slot);
> > >  		writel(val, pcie->base + PCIE_SYS_CFG_V2);
> > > +
> > > +		/* Set up vendor ID and device ID for MT7622*/
> > > +		val = PCI_VENDOR_ID_MEDIATEK;
> > > +		writel(val, port->base + PCIE_CONF_ID);
> > > +
> > > +		/* Set up class code for MT7622 */
> > > +		val = PCI_CLASS_BRIDGE_PCI << 16;
> > > +		writel(val, port->base + PCIE_CONF_CLASS);
> > 
> > 1) Your comments mention MT7622 specifically, but this code is run for
> > both mt2712-pcie and mt7622-pcie.  If this code is safe and necessary
> > for both mt2712-pcie and mt7622-pcie, please remove the mention of
> > MT7622.
> 
> Hmm, the code snippet added here will only be executed by MT7622, since
> MT2712 will not enter this  "if (pcie->base) {"  condition.
> Should the mention of MT7622 must be removed in this case?

You should add an explicit way (eg of_device_is_compatible() match for
instance) to apply the quirk just on the platform that requires it.

Checking for "if (pcie->base)" is really not the way to do it.

> > 2) The first comment mentions both "vendor ID and device ID" but you
> > don't write the device ID.  Since this code applies to both
> > mt2712-pcie and mt7622-pcie, my guess is that you don't *want* to
> > write the device ID.  If that's the case, please fix the comment.
> > 
> 
> My bad, I did not check the comments carefully.
> Thanks.
> 
> > 3) If you only need to set the vendor ID, you're performing a 32-bit
> > write (writel()) to update a 16-bit value.  Please use writew()
> > instead.
> > 
> 
> Ok, thanks, I guess I could use the following code snippet in the next
> version:
> val = readl(port->base + PCIE_CONF_VENDOR_ID)
> val &= ~GENMASK(15, 0);
> val |= PCI_VENDOR_ID_MEDIATEK;
> writel(val, port->base + PCIE_CONF_VENDOR_ID);

Have you read Bjorn's comment ? Or there is a problem with using
a writew() ?

Lorenzo

> > 4) If you only need to set the vendor ID, please use a definition like
> > "PCIE_CONF_VENDOR_ID" instead of the ambiguous "PCIE_CONF_ID".
> > 
> > 5) If you only need to set the vendor ID, please update the changelog
> > to mention "vendor ID" specifically instead of the ambiguous "IDs".
> 
> > 6) Please add a space before the closing "*/" of the first comment.
> > 
> > 7) PCI_CLASS_BRIDGE_PCI is for a PCI-to-PCI bridge, i.e., one that has
> > PCI on both the primary (upstream) side and the secondary (downstream)
> > side.  That kind of bridge has a type 1 config header (see
> > PCI_HEADER_TYPE) and the PCI_PRIMARY_BUS and PCI_SECONDARY_BUS
> > registers tell us the bus number of the primary and secondary sides.
> > 
> > I don't believe this device is a PCI-to-PCI bridge.  I think it's a
> > *host* bridge that has some non-PCI interface on the upstream side and
> > should have a type 0 config header.  If that's the case you should use
> > PCI_CLASS_BRIDGE_HOST instead.
> > 
> 
> Thanks very much for your help with the review, I will fix the other
> issue in the next version.
> 
> > >  	}
> > >  
> > >  	/* Assert all reset signals */
> > > diff --git a/include/linux/pci_ids.h b/include/linux/pci_ids.h
> > > index ab20dc5..2480b0e 100644
> > > --- a/include/linux/pci_ids.h
> > > +++ b/include/linux/pci_ids.h
> > > @@ -2113,6 +2113,8 @@
> > >  
> > >  #define PCI_VENDOR_ID_MYRICOM		0x14c1
> > >  
> > > +#define PCI_VENDOR_ID_MEDIATEK		0x14c3
> > > +
> > >  #define PCI_VENDOR_ID_TITAN		0x14D2
> > >  #define PCI_DEVICE_ID_TITAN_010L	0x8001
> > >  #define PCI_DEVICE_ID_TITAN_100L	0x8010
> > > -- 
> > > 2.6.4
> > > 
> 
> 
