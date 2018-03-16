Return-Path: <SRS0=kfwO=GG=arm.com=lorenzo.pieralisi@kernel.org>
Return-Path: <SRS0=kfwO=GG=arm.com=lorenzo.pieralisi@kernel.org>
Date: Fri, 16 Mar 2018 12:13:50 +0000
From: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
To: Bjorn Helgaas <helgaas@kernel.org>
Cc: honghui.zhang@mediatek.com, bhelgaas@google.com, matthias.bgg@gmail.com,
	linux-arm-kernel@lists.infradead.org,
	linux-mediatek@lists.infradead.org, linux-pci@vger.kernel.org,
	linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
	yingjoe.chen@mediatek.com, eddie.huang@mediatek.com,
	ryder.lee@mediatek.com, hongkun.cao@mediatek.com,
	youlin.pei@mediatek.com, yong.wu@mediatek.com, yt.shen@mediatek.com,
	sean.wang@mediatek.com, xinping.qian@mediatek.com
Subject: Re: [PATCH v5 2/2] PCI: mediatek: Set up class type and vendor ID
 for MT7622
Message-ID: <20180316121350.GB24325@e107981-ln.cambridge.arm.com>
References: <1514336394-17747-1-git-send-email-honghui.zhang@mediatek.com>
 <1514336394-17747-3-git-send-email-honghui.zhang@mediatek.com>
 <20171227184542.GA79892@bhelgaas-glaptop.roam.corp.google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20171227184542.GA79892@bhelgaas-glaptop.roam.corp.google.com>
List-ID: <linux-pci.vger.kernel.org>

On Wed, Dec 27, 2017 at 12:45:42PM -0600, Bjorn Helgaas wrote:

[...]

> > +		/* Set up class code for MT7622 */
> > +		val = PCI_CLASS_BRIDGE_PCI << 16;
> > +		writel(val, port->base + PCIE_CONF_CLASS);
> 
> 1) Your comments mention MT7622 specifically, but this code is run for
> both mt2712-pcie and mt7622-pcie.  If this code is safe and necessary
> for both mt2712-pcie and mt7622-pcie, please remove the mention of
> MT7622.
> 
> 2) The first comment mentions both "vendor ID and device ID" but you
> don't write the device ID.  Since this code applies to both
> mt2712-pcie and mt7622-pcie, my guess is that you don't *want* to
> write the device ID.  If that's the case, please fix the comment.
> 
> 3) If you only need to set the vendor ID, you're performing a 32-bit
> write (writel()) to update a 16-bit value.  Please use writew()
> instead.
> 
> 4) If you only need to set the vendor ID, please use a definition like
> "PCIE_CONF_VENDOR_ID" instead of the ambiguous "PCIE_CONF_ID".
> 
> 5) If you only need to set the vendor ID, please update the changelog
> to mention "vendor ID" specifically instead of the ambiguous "IDs".
> 
> 6) Please add a space before the closing "*/" of the first comment.
> 
> 7) PCI_CLASS_BRIDGE_PCI is for a PCI-to-PCI bridge, i.e., one that has
> PCI on both the primary (upstream) side and the secondary (downstream)
> side.  That kind of bridge has a type 1 config header (see
> PCI_HEADER_TYPE) and the PCI_PRIMARY_BUS and PCI_SECONDARY_BUS
> registers tell us the bus number of the primary and secondary sides.
> 
> I don't believe this device is a PCI-to-PCI bridge.  I think it's a
> *host* bridge that has some non-PCI interface on the upstream side and
> should have a type 0 config header.  If that's the case you should use
> PCI_CLASS_BRIDGE_HOST instead.

I think these registers actually programme the root port register space
in the RC (whether real or fake - that depends on the RC design) so
the class is PCI_CLASS_BRIDGE_PCI, that's what most of host bridge
drivers in drivers/pci/host do.

I would like to get to the bottom of this since it is indeed misleading
(and I do not have HW to test it myself to check my understanding).

Thanks,
Lorenzo
