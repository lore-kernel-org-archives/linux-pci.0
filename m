Return-Path: <SRS0=3eBm=LU=xilinx.com=bharatku@kernel.org>
Return-Path: <SRS0=3eBm=LU=xilinx.com=bharatku@kernel.org>
From: Bharat Kumar Gogada <bharatku@xilinx.com>
To: Bjorn Helgaas <helgaas@kernel.org>
CC: "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"bhelgaas@google.com" <bhelgaas@google.com>, Ravikiran Gummaluri
	<rgummal@xilinx.com>
Subject: RE: [PATCH 3/4] PCI/portdrv: Check platform supported service IRQ's
Date: Thu, 6 Sep 2018 15:34:44 +0000
Message-ID: 
 <BN6PR02MB27724845B839B1DC26B5530BA5010@BN6PR02MB2772.namprd02.prod.outlook.com>
References: <1533915580-31805-1-git-send-email-bharat.kumar.gogada@xilinx.com>
 <1533915580-31805-4-git-send-email-bharat.kumar.gogada@xilinx.com>
 <20180904141227.GD107892@bhelgaas-glaptop.roam.corp.google.com>
In-Reply-To: <20180904141227.GD107892@bhelgaas-glaptop.roam.corp.google.com>
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
List-ID: <linux-pci.vger.kernel.org>

> Subject: Re: [PATCH 3/4] PCI/portdrv: Check platform supported service IR=
Q's
>=20
> On Fri, Aug 10, 2018 at 09:09:39PM +0530, Bharat Kumar Gogada wrote:
> > Platforms may have dedicated IRQ lines for PCIe services like AER/PME
> > etc., check for such IRQ lines.
> > Check mask and fill legacy irq line for services other than
>=20
> Capitalize "IRQ" consistently in English text like this.
>=20
> Insert blank lines between paragraphs.
>=20
> Add a reference to the relevant spec sections.  PCIe r4.0, sec 6.2.4.1.2,=
 6.2.6,
> 7.5.3.12 seem pertinent.
>=20
Agreed, will do in next patch.
> > platform supported service IRQ number.
> >
> > Signed-off-by: Bharat Kumar Gogada <bharat.kumar.gogada@xilinx.com>
> > ---
> >  drivers/pci/pcie/portdrv_core.c |   19 +++++++++++++++++--
> >  1 files changed, 17 insertions(+), 2 deletions(-)
> >
> > diff --git a/drivers/pci/pcie/portdrv_core.c
> > b/drivers/pci/pcie/portdrv_core.c index e0261ad..a7d024c 100644
> > --- a/drivers/pci/pcie/portdrv_core.c
> > +++ b/drivers/pci/pcie/portdrv_core.c
> > @@ -166,6 +166,19 @@ static int pcie_init_service_irqs(struct pci_dev
> *dev, int *irqs, int mask)
> >  		irqs[i] =3D -1;
> >
> >  	/*
> > +	 * Some platforms have dedicated interrupt line from root complex
> to
> > +	 * interrupt controller for PCIe services like AER/PME etc., check
> > +	 * if platform registered with any such IRQ.
> > +	 */
> > +	if (pci_pcie_type(dev) =3D=3D PCI_EXP_TYPE_ROOT_PORT) {
> > +		int plat_mask;
> > +
> > +		plat_mask =3D pci_check_platform_service_irqs(dev, irqs,
> mask);
> > +		if (plat_mask > 0)
>=20
> Masks should be unsigned and tested for zero or "mask & bit".  The rest o=
f
> this file uses "int", which is sloppy because it does the wrong thing if =
we
> happen to use the high-order bit in the mask.
>=20
> > +			mask =3D mask & plat_mask;
> > +	}
>=20
> I think these platform IRQs are neither MSI-X/MSI nor PCI INTx wires.
> But as written, I think this patch executes pcie_port_enable_irq_vec(), w=
hich
> only does MSI-X/MSI stuff.  So this must rely on that failing?
>=20
> And then we fall through to run pci_alloc_irq_vectors(), which is for PCI=
 INTx
> interrupts, which doesn't seem appropriate either.
>=20
> It seems like this platform IRQ case should be completely separated from =
the
> other MSI/INTx cases, i.e., set irqs[PCIE_PORT_SERVICE_AER_SHIFT] directl=
y
> (I think you already do this inside pci_check_platform_service_irqs()) an=
d
> immediately return.
> Then I think you wouldn't need the other hunk below.
Agreed if we check platform service irqs here we need to deal with differen=
t combination
of service IRQ's like AER MSI, pme platform .. and change code accordingly =
to fill irqs[i].
yes it is better to call platform IRQ separately to avoid code changes in d=
ifferent scenarios and=20
chunk below.

Can we do the following code flow:=20
int pcie_port_device_register(struct pci_dev *dev)
{
 ...=20
status =3D pcie_init_service_irqs(dev, irqs, capabilities);
        if (status) {
...
}
pci_check_platform_service_irqs(dev, irqs, capabilities);

Thanks,
Bharat
