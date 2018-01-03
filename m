Return-Path: <SRS0=wIFD=D6=mediatek.com=honghui.zhang@kernel.org>
Return-Path: <SRS0=wIFD=D6=mediatek.com=honghui.zhang@kernel.org>
Message-ID: <1514961544.25872.49.camel@mhfsdcap03>
Subject: Re: [PATCH v5 2/2] PCI: mediatek: Set up class type and vendor ID
 for MT7622
From: Honghui Zhang <honghui.zhang@mediatek.com>
To: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
CC: Bjorn Helgaas <helgaas@kernel.org>, <bhelgaas@google.com>,
	<matthias.bgg@gmail.com>, <linux-arm-kernel@lists.infradead.org>,
	<linux-mediatek@lists.infradead.org>, <linux-pci@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, <devicetree@vger.kernel.org>,
	<yingjoe.chen@mediatek.com>, <eddie.huang@mediatek.com>,
	<ryder.lee@mediatek.com>, <hongkun.cao@mediatek.com>,
	<youlin.pei@mediatek.com>, <yong.wu@mediatek.com>, <yt.shen@mediatek.com>,
	<sean.wang@mediatek.com>, <xinping.qian@mediatek.com>
Date: Wed, 3 Jan 2018 14:39:04 +0800
In-Reply-To: <20180102105659.GB10536@red-moon>
References: <1514336394-17747-1-git-send-email-honghui.zhang@mediatek.com>
	 <1514336394-17747-3-git-send-email-honghui.zhang@mediatek.com>
	 <20171227184542.GA79892@bhelgaas-glaptop.roam.corp.google.com>
	 <1514425152.25872.39.camel@mhfsdcap03> <20180102105659.GB10536@red-moon>
Content-Type: text/plain; charset="UTF-8"
MIME-Version: 1.0
List-ID: <linux-pci.vger.kernel.org>

On Tue, 2018-01-02 at 10:56 +0000, Lorenzo Pieralisi wrote:
> On Thu, Dec 28, 2017 at 09:39:12AM +0800, Honghui Zhang wrote:
> > On Wed, 2017-12-27 at 12:45 -0600, Bjorn Helgaas wrote:
> > > On Wed, Dec 27, 2017 at 08:59:54AM +0800, honghui.zhang@mediatek.com wrote:
> > > > From: Honghui Zhang <honghui.zhang@mediatek.com>
> > > > 

> > > > +		/* Set up class code for MT7622 */
> > > > +		val = PCI_CLASS_BRIDGE_PCI << 16;
> > > > +		writel(val, port->base + PCIE_CONF_CLASS);
> > > 
> > > 1) Your comments mention MT7622 specifically, but this code is run for
> > > both mt2712-pcie and mt7622-pcie.  If this code is safe and necessary
> > > for both mt2712-pcie and mt7622-pcie, please remove the mention of
> > > MT7622.
> > 
> > Hmm, the code snippet added here will only be executed by MT7622, since
> > MT2712 will not enter this  "if (pcie->base) {"  condition.
> > Should the mention of MT7622 must be removed in this case?
> 
> You should add an explicit way (eg of_device_is_compatible() match for
> instance) to apply the quirk just on the platform that requires it.
> 
> Checking for "if (pcie->base)" is really not the way to do it.
> 

hi, Lorenzo,
Thanks very much for your advise.
Passing the compatible string or platform data into this function needed
to add some new field in the struct mtk_pcie_port, then I guess both set
it for MT2712 and MT7622 is an easy way, since re-setting those values
for MT2712 is safe.

> > > 2) The first comment mentions both "vendor ID and device ID" but you
> > > don't write the device ID.  Since this code applies to both
> > > mt2712-pcie and mt7622-pcie, my guess is that you don't *want* to
> > > write the device ID.  If that's the case, please fix the comment.
> > > 
> > 
> > My bad, I did not check the comments carefully.
> > Thanks.
> > 
> > > 3) If you only need to set the vendor ID, you're performing a 32-bit
> > > write (writel()) to update a 16-bit value.  Please use writew()
> > > instead.
> > > 
> > 
> > Ok, thanks, I guess I could use the following code snippet in the next
> > version:
> > val = readl(port->base + PCIE_CONF_VENDOR_ID)
> > val &= ~GENMASK(15, 0);
> > val |= PCI_VENDOR_ID_MEDIATEK;
> > writel(val, port->base + PCIE_CONF_VENDOR_ID);
> 
> Have you read Bjorn's comment ? Or there is a problem with using
> a writew() ?
> 

This control register is a 32bit register, I'm not sure whether the apb
bus support write an 16bit value with 16bit but not 32bit address
alignment. I prefer the more safety old way of writel.

I need to do more test about the writew if the code elegant is more
important.

thanks.

> Lorenzo
> 
> > > 4) If you only need to set the vendor ID, please use a definition like
> > > "PCIE_CONF_VENDOR_ID" instead of the ambiguous "PCIE_CONF_ID".
> > > 
> > > 5) If you only need to set the vendor ID, please update the changelog
> > > to mention "vendor ID" specifically instead of the ambiguous "IDs".
> > 
> > > 6) Please add a space before the closing "*/" of the first comment.
> > > 
> > > 7) PCI_CLASS_BRIDGE_PCI is for a PCI-to-PCI bridge, i.e., one that has
> > > PCI on both the primary (upstream) side and the secondary (downstream)
> > > side.  That kind of bridge has a type 1 config header (see
> > > PCI_HEADER_TYPE) and the PCI_PRIMARY_BUS and PCI_SECONDARY_BUS
> > > registers tell us the bus number of the primary and secondary sides.
> > > 
> > > I don't believe this device is a PCI-to-PCI bridge.  I think it's a
> > > *host* bridge that has some non-PCI interface on the upstream side and
> > > should have a type 0 config header.  If that's the case you should use
> > > PCI_CLASS_BRIDGE_HOST instead.
> > > 
> > 
> > Thanks very much for your help with the review, I will fix the other
> > issue in the next version.
> > 
> > > >  	}
> > > >  
> > > >  	/* Assert all reset signals */
> > > > diff --git a/include/linux/pci_ids.h b/include/linux/pci_ids.h
> > > > index ab20dc5..2480b0e 100644
> > > > --- a/include/linux/pci_ids.h
> > > > +++ b/include/linux/pci_ids.h
> > > > @@ -2113,6 +2113,8 @@
> > > >  
> > > >  #define PCI_VENDOR_ID_MYRICOM		0x14c1
> > > >  
> > > > +#define PCI_VENDOR_ID_MEDIATEK		0x14c3
> > > > +
> > > >  #define PCI_VENDOR_ID_TITAN		0x14D2
> > > >  #define PCI_DEVICE_ID_TITAN_010L	0x8001
> > > >  #define PCI_DEVICE_ID_TITAN_100L	0x8010
> > > > -- 
> > > > 2.6.4
> > > > 
> > 
> > 
