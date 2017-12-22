Return-Path: <linux-arm-kernel-bounces+bjorn=helgaas.com@lists.infradead.org>
Return-Path: <linux-arm-kernel-bounces+bjorn=helgaas.com@lists.infradead.org>
Date: Thu, 21 Dec 2017 18:27:12 -0600
From: Bjorn Helgaas <helgaas@kernel.org>
To: Honghui Zhang <honghui.zhang@mediatek.com>
Subject: Re: [PATCH v2 2/2] PCI: mediatek: Fixup class type for MT7622
Message-ID: <20171222002712.GE30595@bhelgaas-glaptop.roam.corp.google.com>
References: <1513822277-18329-1-git-send-email-honghui.zhang@mediatek.com>
 <1513822277-18329-3-git-send-email-honghui.zhang@mediatek.com>
 <1513838476.23174.3.camel@mhfsdcap03>
 <1513839672.25872.13.camel@mhfsdcap03>
MIME-Version: 1.0
In-Reply-To: <1513839672.25872.13.camel@mhfsdcap03>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Cc: youlin.pei@mediatek.com, devicetree@vger.kernel.org,
 hongkun.cao@mediatek.com, ryder.lee@mediatek.com, yu.yu@mediatek.com,
 linux-pci@vger.kernel.org, sean.wang@mediatek.com,
 linux-kernel@vger.kernel.org, matthias.bgg@gmail.com,
 lorenzo.pieralisi@arm.com, linux-mediatek@lists.infradead.org,
 xinping.qian@mediatek.com, yt.shen@mediatek.com, yingjoe.chen@mediatek.com,
 eddie.huang@mediatek.com, bhelgaas@google.com, Yong Wu <yong.wu@mediatek.com>,
 linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="us-ascii"
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+bjorn=helgaas.com@lists.infradead.org
List-ID: <linux-pci.vger.kernel.org>

On Thu, Dec 21, 2017 at 03:01:12PM +0800, Honghui Zhang wrote:
> On Thu, 2017-12-21 at 14:41 +0800, Yong Wu wrote:
> > On Thu, 2017-12-21 at 10:11 +0800, honghui.zhang@mediatek.com wrote:
> > > From: Honghui Zhang <honghui.zhang@mediatek.com>
> > > 
> > > The host bridge of MT7622 has hardware code the class code to an
> > > arbitrary, meaningless value, fix that.
> > > 
> > > Signed-off-by: Honghui Zhang <honghui.zhang@mediatek.com>
> > > ---
> > >  drivers/pci/host/pcie-mediatek.c | 12 ++++++++++++
> > >  1 file changed, 12 insertions(+)
> > > 
> > > diff --git a/drivers/pci/host/pcie-mediatek.c b/drivers/pci/host/pcie-mediatek.c
> > > index 3248771..ae8d367 100644
> > > --- a/drivers/pci/host/pcie-mediatek.c
> > > +++ b/drivers/pci/host/pcie-mediatek.c
> > > @@ -1174,3 +1174,15 @@ static struct platform_driver mtk_pcie_driver = {
> > >  	},
> > >  };
> > >  builtin_platform_driver(mtk_pcie_driver);
> > > +
> > > +/* The host bridge of MT7622 advertises the wrong device class. */
> > > +static void mtk_fixup_class(struct pci_dev *dev)
> > > +{
> > > +	dev->class = PCI_CLASS_BRIDGE_PCI << 8;
> > > +}
> > > +
> > > +/*
> > > + * The HW default value of vendor id and device id for mt7622 are 0x0e8d,
> > > + * 0x3258, which are arbitrary, meaningless values.

They may be arbitrary but they are certainly not meaningless.

> > What's the right vendor id and device id? is it possible to fix them
> > too?
> 
> Vendor ID is managed by PCI-SIG, you may get the assigned vendor ID
> from:
> https://pci-ids.ucw.cz/read/PC?restrict=

It's true that Vendor IDs are managed by the PCI-SIG.  The link above
is not managed by the PCI-SIG and is not the official list of assigned
Vendor IDs.

> The vendor ID for Mediatek Corp. should be 14c3.
> Device ID is something like vendor-defined.
> Those values are in the configuration space and are read-only defined by
> spec, it's been stored at the pci_dev, we may change the vendor and
> device values in pci_dev, but I don't think it's necessary to change
> that.
> BTW, Does anyone really cares about the vendor ID and device ID except
> the device's driver?

Yes.  This is a fundamental misunderstanding of how Vendor and Device
IDs work.  The *driver* really doesn't care about the IDs.  The PCI
*core* cares about them because it uses the IDs to select the
appropriate driver to bind to the device.

> > > +DECLARE_PCI_FIXUP_EARLY(0x0e8d, 0x3258, mtk_fixup_class);

This is absolutely not OK.  You cannot take over Vendor ID 0x0e8d
unless it has been assigned to you by the PCI-SIG.

To my knowledge, 0x0e8d has not been assigned to any company yet, but
the PCI-SIG could assign it to some new company X tomorrow.  Company X
may then build a device with Device ID 0x3258.  Now we cannot tell the
difference between the Company X device that is correctly designed and
this Mediatek device that is broken.

This quirk would improperly overwrite dev->class for the Company X
device, and we would not be able to bind the correct driver to either
device.

I am amazed that somebody could build a device that claims to be a PCI
device and get the Vendor ID wrong.  That should be literally the
first thing the hardware designer does.  If you have hardware in the
field that uses the wrong Vendor ID, it is definitely not
PCI-compliant.

Bjorn

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
