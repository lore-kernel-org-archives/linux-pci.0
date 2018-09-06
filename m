Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-bn3nam01on0086.outbound.protection.outlook.com ([104.47.33.86]:23670
        "EHLO NAM01-BN3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1729991AbeIFUDr (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Thu, 6 Sep 2018 16:03:47 -0400
From: Bharat Kumar Gogada <bharatku@xilinx.com>
To: Bjorn Helgaas <helgaas@kernel.org>
CC: "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "bhelgaas@google.com" <bhelgaas@google.com>,
        Ravikiran Gummaluri <rgummal@xilinx.com>
Subject: RE: [PATCH 4/4] PCI: xilinx-nwl: Add method to
 setup_platform_service_irq hook
Date: Thu, 6 Sep 2018 15:27:40 +0000
Message-ID: <BN6PR02MB2772814D31D45FB093183458A5010@BN6PR02MB2772.namprd02.prod.outlook.com>
References: <1533915580-31805-1-git-send-email-bharat.kumar.gogada@xilinx.com>
 <1533915580-31805-5-git-send-email-bharat.kumar.gogada@xilinx.com>
 <20180904134859.GC107892@bhelgaas-glaptop.roam.corp.google.com>
In-Reply-To: <20180904134859.GC107892@bhelgaas-glaptop.roam.corp.google.com>
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

> Subject: Re: [PATCH 4/4] PCI: xilinx-nwl: Add method to
> setup_platform_service_irq hook
>=20
> On Fri, Aug 10, 2018 at 09:09:40PM +0530, Bharat Kumar Gogada wrote:
> > Add nwl_setup_service_irqs hook to setup_platform_service_irq IRQs to
> > register platform provided IRQ number to kernel AER service.
> >
> > Signed-off-by: Bharat Kumar Gogada <bharat.kumar.gogada@xilinx.com>
> > ---
> >  drivers/pci/controller/pcie-xilinx-nwl.c |   16 ++++++++++++++++
> >  1 files changed, 16 insertions(+), 0 deletions(-)
> >
> > diff --git a/drivers/pci/controller/pcie-xilinx-nwl.c
> > b/drivers/pci/controller/pcie-xilinx-nwl.c
> > index fb32840..285647b 100644
> > --- a/drivers/pci/controller/pcie-xilinx-nwl.c
> > +++ b/drivers/pci/controller/pcie-xilinx-nwl.c
> > @@ -22,6 +22,7 @@
> >  #include <linux/irqchip/chained_irq.h>
> >
> >  #include "../pci.h"
> > +#include "../pcie/portdrv.h"
> >
> >  /* Bridge core config registers */
> >  #define BRCFG_PCIE_RX0			0x00000000
> > @@ -819,6 +820,20 @@ static int nwl_pcie_parse_dt(struct nwl_pcie *pcie=
,
> >  	return 0;
> >  }
> >
> > +int nwl_setup_service_irqs(struct pci_host_bridge *bridge, int *irqs,
> > +			   int plat_mask)
> > +{
> > +	struct nwl_pcie *pcie;
> > +
> > +	pcie =3D pci_host_bridge_priv(bridge);
> > +	if (plat_mask & PCIE_PORT_SERVICE_AER) {
> > +		irqs[PCIE_PORT_SERVICE_AER_SHIFT] =3D pcie->irq_misc;
> > +		plat_mask &=3D ~(1 << PCIE_PORT_SERVICE_AER_SHIFT);
> > +	}
>=20
> If I understand correctly, this ultimately results in pcie->irq_misc bein=
g
> hooked up to aer_irq() via the aer_probe() path.  We already have pcie-
> >irq_misc being hooked up to nwl_pcie_misc_handler() via
> nwl_pcie_bridge_init().
>=20
> We can't rely on the ordering of the two handlers.  Is it safe if
> nwl_pcie_misc_handler() runs first, followed by aer_irq()?  It looks like
> nwl_pcie_misc_handler() might log messages and clear AER-related errors. =
 If
> that's the case aer_irq() might not find anything to do.
>=20
Hi Bjorn, the nwl_pcie_misc_handler() prints all pcie errors along with AER=
 and then clears=20
controller register (MSGF_MISC_STATUS) in which these status bits are set.=
=20
But clearing this controller register will not effect any bits in AER capab=
ilities.
So in our case we need  to clear controller register and also handle AER as=
 per spec.
This will not cause any ordering issue as both paths are accessing differen=
t set of registers.

Thanks,
Bharat
