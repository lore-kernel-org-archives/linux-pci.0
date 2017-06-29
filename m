Return-Path: <SRS0=xPYE=6C=mediatek.com=ryder.lee@kernel.org>
Return-Path: <SRS0=xPYE=6C=mediatek.com=ryder.lee@kernel.org>
Message-ID: <1498701623.32475.9.camel@mtkswgap22>
Subject: Re: [PATCH v5 1/2] PCI: mediatek: Add Mediatek PCIe host controller
 support
From: Ryder Lee <ryder.lee@mediatek.com>
To: Bjorn Helgaas <helgaas@kernel.org>
CC: Bjorn Helgaas <bhelgaas@google.com>, Rob Herring <robh+dt@kernel.org>,
	Arnd Bergmann <arnd@arndb.de>, <devicetree@vger.kernel.org>, Red Hung
	<red.hung@mediatek.com>, <linux-pci@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, <linux-mediatek@lists.infradead.org>,
	<linux-arm-kernel@lists.infradead.org>
Date: Thu, 29 Jun 2017 10:00:23 +0800
In-Reply-To: <20170628195325.GR17844@bhelgaas-glaptop.roam.corp.google.com>
References: <1495338145-9384-1-git-send-email-ryder.lee@mediatek.com>
	 <1495338145-9384-2-git-send-email-ryder.lee@mediatek.com>
	 <20170628195325.GR17844@bhelgaas-glaptop.roam.corp.google.com>
Content-Type: text/plain; charset="UTF-8"
MIME-Version: 1.0
List-ID: <linux-pci.vger.kernel.org>

On Wed, 2017-06-28 at 14:53 -0500, Bjorn Helgaas wrote:
> On Sun, May 21, 2017 at 11:42:24AM +0800, Ryder Lee wrote:
> > Add support for the Mediatek PCIe Gen2 controller which can
> > be found on MT7623 series SoCs.
> > 
> > Signed-off-by: Ryder Lee <ryder.lee@mediatek.com>
> > ---
> >  drivers/pci/host/Kconfig         |  11 +
> >  drivers/pci/host/Makefile        |   1 +
> >  drivers/pci/host/pcie-mediatek.c | 553 +++++++++++++++++++++++++++++++++++++++
> >  3 files changed, 565 insertions(+)
> >  create mode 100644 drivers/pci/host/pcie-mediatek.c
> >...
> 
> > +static int mtk_pcie_register_host(struct pci_host_bridge *host)
> > +{
> > +	struct mtk_pcie *pcie = pci_host_bridge_priv(host);
> > +	struct pci_bus *child;
> > +	int err;
> > +
> > +	pci_add_flags(PCI_REASSIGN_ALL_RSRC | PCI_REASSIGN_ALL_BUS);
> 
> Do you really need the PCI_REASSIGN_ALL_RSRC and PCI_REASSIGN_ALL_BUS
> flags?  I'd like to get rid of them because we should automatically
> assign resources if the firmware hasn't done it.
> 
> Bjorn

You're right! These flags are not needed and should be removed.
Thanks for catching that.

Ryder
