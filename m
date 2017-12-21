Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-qk0-f193.google.com ([209.85.220.193]:42843 "EHLO
        mail-qk0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751655AbdLUQnq (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 21 Dec 2017 11:43:46 -0500
From: "Jingoo Han" <jingoohan1@gmail.com>
To: "'Joao Pinto'" <Joao.Pinto@synopsys.com>,
        "'Niklas Cassel'" <niklas.cassel@axis.com>,
        "'Lorenzo Pieralisi'" <lorenzo.pieralisi@arm.com>,
        "'Bjorn Helgaas'" <bhelgaas@google.com>
Cc: "'Niklas Cassel'" <niklass@axis.com>, <linux-pci@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
References: <20171219232940.659-1-niklas.cassel@axis.com> <20171219232940.659-2-niklas.cassel@axis.com> <b7f66e90-1fc2-a957-831d-32881df98ba9@synopsys.com>
In-Reply-To: <b7f66e90-1fc2-a957-831d-32881df98ba9@synopsys.com>
Subject: Re: [PATCH v6 01/18] PCI: dwc: Use the DMA-API to get the MSI address
Date: Thu, 21 Dec 2017 11:43:44 -0500
Message-ID: <000001d37a7a$ddc3c5b0$994b5110$@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain;
        charset="utf-8"
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Wednesday, December 20, 2017 2:10 PM, Joao Pinto wrote:
>=20
> Hi Niklas,
>=20
> =C3=80s 11:29 PM de 12/19/2017, Niklas Cassel escreveu:
> > Use the DMA-API to get the MSI address. This address will be written =
to
> > our PCI config space and to the register which determines which AXI
> > address the DWC IP will spoof for incoming MSI irqs.
> >
> > Since it is a PCIe endpoint device, rather than the CPU, that is
> supposed
> > to write to the MSI address, the proper way to get the MSI address =
is by
> > using the DMA API, not by using virt_to_phys().
> >
> > Using virt_to_phys() might work on some systems, but using the DMA =
API
> > should work on all systems.
> >
> > This is essentially the same thing as allocating a buffer in a =
driver
> > to which the endpoint will write to. To do this, we use the DMA API.
> >
> > Signed-off-by: Niklas Cassel <niklas.cassel@axis.com>
> > ---
> >  drivers/pci/dwc/pcie-designware-host.c | 15 ++++++++++++---
> >  drivers/pci/dwc/pcie-designware.h      |  3 ++-
> >  2 files changed, 14 insertions(+), 4 deletions(-)
> >
> > diff --git a/drivers/pci/dwc/pcie-designware-host.c
> b/drivers/pci/dwc/pcie-designware-host.c
> > index 81e2157a7cfb..bf558df5b7b3 100644
> > --- a/drivers/pci/dwc/pcie-designware-host.c
> > +++ b/drivers/pci/dwc/pcie-designware-host.c
> > @@ -83,10 +83,19 @@ irqreturn_t dw_handle_msi_irq(struct pcie_port =
*pp)
> >
> >  void dw_pcie_msi_init(struct pcie_port *pp)
> >  {
> > +	struct dw_pcie *pci =3D to_dw_pcie_from_pp(pp);
> > +	struct device *dev =3D pci->dev;
> > +	struct page *page;
> >  	u64 msi_target;
> >
> > -	pp->msi_data =3D __get_free_pages(GFP_KERNEL, 0);
> > -	msi_target =3D virt_to_phys((void *)pp->msi_data);
> > +	page =3D alloc_page(GFP_KERNEL);
> > +	pp->msi_data =3D dma_map_page(dev, page, 0, PAGE_SIZE,
> DMA_FROM_DEVICE);
> > +	if (dma_mapping_error(dev, pp->msi_data)) {
> > +		dev_err(dev, "failed to map MSI data\n");
> > +		__free_page(page);
> > +		return;
> > +	}
> > +	msi_target =3D (u64)pp->msi_data;
> >
> >  	/* program the msi_data */
> >  	dw_pcie_wr_own_conf(pp, PCIE_MSI_ADDR_LO, 4,
> > @@ -187,7 +196,7 @@ static void dw_msi_setup_msg(struct pcie_port =
*pp,
> unsigned int irq, u32 pos)
> >  	if (pp->ops->get_msi_addr)
> >  		msi_target =3D pp->ops->get_msi_addr(pp);
> >  	else
> > -		msi_target =3D virt_to_phys((void *)pp->msi_data);
> > +		msi_target =3D (u64)pp->msi_data;
> >
> >  	msg.address_lo =3D (u32)(msi_target & 0xffffffff);
> >  	msg.address_hi =3D (u32)(msi_target >> 32 & 0xffffffff);
> > diff --git a/drivers/pci/dwc/pcie-designware.h =
b/drivers/pci/dwc/pcie-
> designware.h
> > index e5d9d77b778e..ecdede68522a 100644
> > --- a/drivers/pci/dwc/pcie-designware.h
> > +++ b/drivers/pci/dwc/pcie-designware.h
> > @@ -14,6 +14,7 @@
> >  #ifndef _PCIE_DESIGNWARE_H
> >  #define _PCIE_DESIGNWARE_H
> >
> > +#include <linux/dma-mapping.h>
> >  #include <linux/irq.h>
> >  #include <linux/msi.h>
> >  #include <linux/pci.h>
> > @@ -168,7 +169,7 @@ struct pcie_port {
> >  	const struct dw_pcie_host_ops *ops;
> >  	int			msi_irq;
> >  	struct irq_domain	*irq_domain;
> > -	unsigned long		msi_data;
> > +	dma_addr_t		msi_data;
> >  	DECLARE_BITMAP(msi_irq_in_use, MAX_MSI_IRQS);
> >  };
> >
> >
>=20
> Makes total sense! Thanks.
>=20
> Acked-by: Joao Pinto <jpinto@synopsys.com>

Acked-by: Jingoo Han <jingoohan1@gmail.com>

Best regards,
Jingoo Han
