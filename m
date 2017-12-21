Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-qk0-f194.google.com ([209.85.220.194]:33931 "EHLO
        mail-qk0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752447AbdLUQqI (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 21 Dec 2017 11:46:08 -0500
From: "Jingoo Han" <jingoohan1@gmail.com>
To: "'Joao Pinto'" <Joao.Pinto@synopsys.com>,
        "'Niklas Cassel'" <niklas.cassel@axis.com>,
        "'Lorenzo Pieralisi'" <lorenzo.pieralisi@arm.com>,
        "'Bjorn Helgaas'" <bhelgaas@google.com>
Cc: "'Niklas Cassel'" <niklass@axis.com>, <linux-pci@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
References: <20171219232940.659-1-niklas.cassel@axis.com> <20171219232940.659-5-niklas.cassel@axis.com> <690a6c50-f5af-24bb-2f49-ba828022dcee@synopsys.com>
In-Reply-To: <690a6c50-f5af-24bb-2f49-ba828022dcee@synopsys.com>
Subject: Re: [PATCH v6 04/18] PCI: designware-ep: Pre-allocate memory for MSI in dw_pcie_ep_init
Date: Thu, 21 Dec 2017 11:46:06 -0500
Message-ID: <000301d37a7b$32926f60$97b74e20$@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain;
        charset="utf-8"
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Wednesday, December 20, 2017 2:30 PM, Joao Pinto wrote:
>=20
> Hi,
>=20
> =C3=80s 11:29 PM de 12/19/2017, Niklas Cassel escreveu:
> > Certain SoCs need to map the MSI address in raise_irq.
> > To map an address, you first need to call pci_epc_mem_alloc_addr(),
> > however, pci_epc_mem_alloc_addr() calls ioremap() (which can sleep).
> >
> > Since raise_irq is only called from atomic context, we can't call
> > pci_epc_mem_alloc_addr() from raise_irq.
> >
> > Pre-allocate a page in dw_pcie_ep_init(), so that this page can =
later
> > be used to map/unmap the MSI address in raise_irq.
> >
> > Signed-off-by: Niklas Cassel <niklas.cassel@axis.com>
> > ---
> >  drivers/pci/dwc/pcie-designware-ep.c | 10 ++++++++++
> >  drivers/pci/dwc/pcie-designware.h    |  2 ++
> >  2 files changed, 12 insertions(+)
> >
> > diff --git a/drivers/pci/dwc/pcie-designware-ep.c
> b/drivers/pci/dwc/pcie-designware-ep.c
> > index 3fb34be99715..8d8019cdff2a 100644
> > --- a/drivers/pci/dwc/pcie-designware-ep.c
> > +++ b/drivers/pci/dwc/pcie-designware-ep.c
> > @@ -286,6 +286,9 @@ void dw_pcie_ep_exit(struct dw_pcie_ep *ep)
> >  {
> >  	struct pci_epc *epc =3D ep->epc;
> >
> > +	pci_epc_mem_free_addr(epc, ep->msi_mem_phys, ep->msi_mem,
> > +			      epc->mem->page_size);
> > +
> >  	pci_epc_mem_exit(epc);
> >  }
> >
> > @@ -341,6 +344,13 @@ int dw_pcie_ep_init(struct dw_pcie_ep *ep)
> >  		return ret;
> >  	}
> >
> > +	ep->msi_mem =3D pci_epc_mem_alloc_addr(epc, &ep->msi_mem_phys,
> > +					     epc->mem->page_size);
> > +	if (!ep->msi_mem) {
> > +		dev_err(dev, "Failed to reserve memory for MSI\n");
> > +		return -ENOMEM;
> > +	}
> > +
> >  	ep->epc =3D epc;
> >  	epc_set_drvdata(epc, ep);
> >  	dw_pcie_setup(pci);
> > diff --git a/drivers/pci/dwc/pcie-designware.h =
b/drivers/pci/dwc/pcie-
> designware.h
> > index 9aaf0cd04dd6..5a1da459eda5 100644
> > --- a/drivers/pci/dwc/pcie-designware.h
> > +++ b/drivers/pci/dwc/pcie-designware.h
> > @@ -198,6 +198,8 @@ struct dw_pcie_ep {
> >  	unsigned long		ob_window_map;
> >  	u32			num_ib_windows;
> >  	u32			num_ob_windows;
> > +	void __iomem		*msi_mem;
> > +	phys_addr_t		msi_mem_phys;
> >  };
> >
> >  struct dw_pcie_ops {
> >
>=20
> Acked-by: Joao Pinto <jpinto@synopsys.com>

Acked-by: Jingoo Han <jingoohan1@gmail.com>

Best regards,
Jingoo Han
