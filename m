Return-Path: <SRS0=bs7s=7Z=mediatek.com=ryder.lee@kernel.org>
Return-Path: <SRS0=bs7s=7Z=mediatek.com=ryder.lee@kernel.org>
Message-ID: <1503450266.11985.3.camel@mtkswgap22>
Subject: Re: [PATCH v2 0/3] PCI: mediatek: Add MSI support for MT2712 and
 MT7622
From: Ryder Lee <ryder.lee@mediatek.com>
To: Bjorn Helgaas <helgaas@kernel.org>
CC: <honghui.zhang@mediatek.com>, <bhelgaas@google.com>,
	<matthias.bgg@gmail.com>, <linux-arm-kernel@lists.infradead.org>,
	<linux-mediatek@lists.infradead.org>, <linux-pci@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, <devicetree@vger.kernel.org>,
	<yingjoe.chen@mediatek.com>, <eddie.huang@mediatek.com>,
	<hongkun.cao@mediatek.com>, <youlin.pei@mediatek.com>,
	<yong.wu@mediatek.com>, <yt.shen@mediatek.com>, <sean.wang@mediatek.com>,
	<xinping.qian@mediatek.com>
Date: Wed, 23 Aug 2017 09:04:26 +0800
In-Reply-To: <20170822213602.GK6948@bhelgaas-glaptop.roam.corp.google.com>
References: <1502715868-17651-1-git-send-email-honghui.zhang@mediatek.com>
	 <20170822213602.GK6948@bhelgaas-glaptop.roam.corp.google.com>
Content-Type: text/plain; charset="UTF-8"
MIME-Version: 1.0
List-ID: <linux-pci.vger.kernel.org>

On Tue, 2017-08-22 at 16:36 -0500, Bjorn Helgaas wrote:
> On Mon, Aug 14, 2017 at 09:04:25PM +0800, honghui.zhang@mediatek.com wrote:
> > From: Honghui Zhang <honghui.zhang@mediatek.com>
> > 
> > MT2712 and MT7622's PCIe host controller support MSI, but only 32bit MSI
> > address are supportted. It connect to GIC with the same IRQ number of INTx
> > IRQ, so it shares the same IRQ with INTx IRQ.
> > 
> > This patchset add MSI support for MT2712 and MT7622.
> > Also do some code fixup and cleanups.
> > 
> > Change Since V1:
> >  - Add the first two patches into this patchset.
> >  - Using -ENODEV instead of PTR_ERR if msi_domain == NULL
> >  - Change the error logs with consistency of lower-case
> >  - Using has_msi instead of support_msi to make the parameter name a bit shorter
> > 
> > Honghui Zhang (3):
> >   PCI: mediatek: Fix return value in case of error
> >   PCI: mediatek: take use of bus->sysdata to get host private data
> >   PCI: mediatek: add msi support for MT2712 and MT7622
> > 
> >  drivers/pci/host/pcie-mediatek.c | 157 +++++++++++++++++++++++++++++++++++++--
> >  1 file changed, 151 insertions(+), 6 deletions(-)
> 
> Just waiting for an ack from Ryder...

For whole series:

Acked-by: Ryder Lee <ryder.lee@mediatek.com>
