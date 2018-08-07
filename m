Return-Path: <SRS0=/HcQ=KW=xilinx.com=bharatku@kernel.org>
Return-Path: <SRS0=/HcQ=KW=xilinx.com=bharatku@kernel.org>
From: Bharat Kumar Gogada <bharatku@xilinx.com>
To: Bjorn Helgaas <helgaas@kernel.org>, Sinan Kaya <okaya@kernel.org>
CC: "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"bhelgaas@google.com" <bhelgaas@google.com>, Ravikiran Gummaluri
	<rgummal@xilinx.com>
Subject: RE: [PATCH 3/3] PCI/portdrv: Add support for sharing xilinx
 controller irq with AER
Date: Tue, 7 Aug 2018 13:19:44 +0000
Message-ID: 
 <SN6PR02MB4862625E305AE74F3E4F11F3A5270@SN6PR02MB4862.namprd02.prod.outlook.com>
References: <1533141889-19962-1-git-send-email-bharat.kumar.gogada@xilinx.com>
 <1533141889-19962-4-git-send-email-bharat.kumar.gogada@xilinx.com>
 <7d5ae8ed-5623-3cd2-7769-77702448b2d6@kernel.org>
 <20180806205614.GC30691@bhelgaas-glaptop.roam.corp.google.com>
In-Reply-To: <20180806205614.GC30691@bhelgaas-glaptop.roam.corp.google.com>
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
List-ID: <linux-pci.vger.kernel.org>

> Subject: Re: [PATCH 3/3] PCI/portdrv: Add support for sharing xilinx
> controller irq with AER
>=20
> On Wed, Aug 01, 2018 at 11:05:09AM -0700, Sinan Kaya wrote:
> > On 8/1/2018 9:44 AM, Bharat Kumar Gogada wrote:
> > > Xilinx ZynqMP PS PCIe does not report AER interrupts using Advanced
> > > Error Interrupt Message Number. The controller has dedicated
> > > interrupt line for reporting PCIe errors along with AER.
> > >
> > > Using dedicated controller irq number for AER which is shared with
> > > misc interrupt handler in pcie-xilinx-nwl. This irq number is set
> > > using PCI quirk.
> > >
> > > Signed-off-by: Bharat Kumar Gogada<bharat.kumar.gogada@xilinx.com>
> > > ---
> > >   drivers/pci/pcie/portdrv_core.c |    4 ++++
> > >   1 files changed, 4 insertions(+), 0 deletions(-)
> > >
> > > diff --git a/drivers/pci/pcie/portdrv_core.c
> > > b/drivers/pci/pcie/portdrv_core.c index e0261ad..fa9150e 100644
> > > --- a/drivers/pci/pcie/portdrv_core.c
> > > +++ b/drivers/pci/pcie/portdrv_core.c
> > > @@ -264,6 +264,10 @@ static int pcie_device_init(struct pci_dev *pdev=
,
> int service, int irq)
> > >   	int retval;
> > >   	struct pcie_device *pcie;
> > >   	struct device *device;
> > > +#if defined(CONFIG_ARCH_ZYNQMP) &&
> defined(CONFIG_PCIE_XILINX_NWL)
> > > +	if (service =3D=3D PCIE_PORT_SERVICE_AER && pdev->sysdata)
> > > +		irq =3D *(int *)pdev->sysdata;
> > > +#endif
> >
> > I remember seeing a similar patch before.
>=20
> Are you thinking of [1]?
Thanks for reviewing. Yes this case is also similar to [1].=20
I'm not aware of this [1]. I will withdraw this current patches.
Will work on a different model based on your suggestions.

Regards,
Bharat=20
