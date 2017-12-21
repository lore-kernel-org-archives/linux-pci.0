Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-qt0-f194.google.com ([209.85.216.194]:33659 "EHLO
        mail-qt0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751655AbdLUQr2 (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 21 Dec 2017 11:47:28 -0500
From: "Jingoo Han" <jingoohan1@gmail.com>
To: "'Joao Pinto'" <Joao.Pinto@synopsys.com>,
        "'Niklas Cassel'" <niklas.cassel@axis.com>,
        "'Lorenzo Pieralisi'" <lorenzo.pieralisi@arm.com>,
        "'Bjorn Helgaas'" <bhelgaas@google.com>
Cc: "'Niklas Cassel'" <niklass@axis.com>, <linux-pci@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
References: <20171219232940.659-1-niklas.cassel@axis.com> <20171219232940.659-7-niklas.cassel@axis.com> <fd89cef7-ffab-7d1b-162f-8a155c4576be@synopsys.com>
In-Reply-To: <fd89cef7-ffab-7d1b-162f-8a155c4576be@synopsys.com>
Subject: Re: [PATCH v6 06/18] PCI: designware-ep: Add generic function for raising MSI irq
Date: Thu, 21 Dec 2017 11:47:25 -0500
Message-ID: <000401d37a7b$61e574b0$25b05e10$@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain;
        charset="utf-8"
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Wednesday, December 20, 2017 2:33 PM, Joao Pinto wrote:
>=20
>=20
> Hi,
>=20
> =C3=80s 11:29 PM de 12/19/2017, Niklas Cassel escreveu:
> > Add a generic function for raising MSI irqs that can be used by all
> > DWC based controllers.
> >
> > Note that certain controllers, like DRA7xx, have a special =
convenience
> > register for raising MSI irqs that doesn't require you to explicitly =
map
> > the MSI address. Therefore, it is likely that certain drivers will
> > not use this generic function, even if they can.
> >
> > Signed-off-by: Niklas Cassel <niklas.cassel@axis.com>
> > ---
> >  drivers/pci/dwc/pcie-designware-ep.c | 35
> +++++++++++++++++++++++++++++++++++
> >  drivers/pci/dwc/pcie-designware.h    |  9 +++++++++
> >  2 files changed, 44 insertions(+)
> >
> > diff --git a/drivers/pci/dwc/pcie-designware-ep.c
> b/drivers/pci/dwc/pcie-designware-ep.c
> > index 700ed2f4becf..c5aa1cac5041 100644
> > --- a/drivers/pci/dwc/pcie-designware-ep.c
> > +++ b/drivers/pci/dwc/pcie-designware-ep.c
> > @@ -282,6 +282,41 @@ static const struct pci_epc_ops epc_ops =3D {
> >  	.stop			=3D dw_pcie_ep_stop,
> >  };
> >
> > +int dw_pcie_ep_raise_msi_irq(struct dw_pcie_ep *ep,
> > +			     u8 interrupt_num)
> > +{
> > +	struct dw_pcie *pci =3D to_dw_pcie_from_ep(ep);
> > +	struct pci_epc *epc =3D ep->epc;
> > +	u16 msg_ctrl, msg_data;
> > +	u32 msg_addr_lower, msg_addr_upper;
> > +	u64 msg_addr;
> > +	bool has_upper;
> > +	int ret;
> > +
> > +	/* Raise MSI per the PCI Local Bus Specification Revision 3.0,
> 6.8.1. */
> > +	msg_ctrl =3D dw_pcie_readw_dbi(pci, MSI_MESSAGE_CONTROL);
> > +	has_upper =3D !!(msg_ctrl & PCI_MSI_FLAGS_64BIT);
> > +	msg_addr_lower =3D dw_pcie_readl_dbi(pci, MSI_MESSAGE_ADDR_L32);
> > +	if (has_upper) {
> > +		msg_addr_upper =3D dw_pcie_readl_dbi(pci,
> MSI_MESSAGE_ADDR_U32);
> > +		msg_data =3D dw_pcie_readw_dbi(pci, MSI_MESSAGE_DATA_64);
> > +	} else {
> > +		msg_addr_upper =3D 0;
> > +		msg_data =3D dw_pcie_readw_dbi(pci, MSI_MESSAGE_DATA_32);
> > +	}
> > +	msg_addr =3D ((u64) msg_addr_upper) << 32 | msg_addr_lower;
> > +	ret =3D dw_pcie_ep_map_addr(epc, ep->msi_mem_phys, msg_addr,
> > +				  epc->mem->page_size);
> > +	if (ret)
> > +		return ret;
> > +
> > +	writel(msg_data | (interrupt_num - 1), ep->msi_mem);
> > +
> > +	dw_pcie_ep_unmap_addr(epc, ep->msi_mem_phys);
> > +
> > +	return 0;
> > +}
> > +
> >  void dw_pcie_ep_exit(struct dw_pcie_ep *ep)
> >  {
> >  	struct pci_epc *epc =3D ep->epc;
> > diff --git a/drivers/pci/dwc/pcie-designware.h =
b/drivers/pci/dwc/pcie-
> designware.h
> > index 37dfad8d003f..24edac035160 100644
> > --- a/drivers/pci/dwc/pcie-designware.h
> > +++ b/drivers/pci/dwc/pcie-designware.h
> > @@ -106,6 +106,8 @@
> >  #define MSI_CAP_MME_MASK		(7 << MSI_CAP_MME_SHIFT)
> >  #define MSI_MESSAGE_ADDR_L32		0x54
> >  #define MSI_MESSAGE_ADDR_U32		0x58
> > +#define MSI_MESSAGE_DATA_32		0x58
> > +#define MSI_MESSAGE_DATA_64		0x5C
> >
> >  /*
> >   * Maximum number of MSI IRQs can be 256 per controller. But keep
> > @@ -338,6 +340,7 @@ static inline int dw_pcie_host_init(struct =
pcie_port
> *pp)
> >  void dw_pcie_ep_linkup(struct dw_pcie_ep *ep);
> >  int dw_pcie_ep_init(struct dw_pcie_ep *ep);
> >  void dw_pcie_ep_exit(struct dw_pcie_ep *ep);
> > +int dw_pcie_ep_raise_msi_irq(struct dw_pcie_ep *ep, u8 =
interrupt_num);
> >  void dw_pcie_ep_reset_bar(struct dw_pcie *pci, enum pci_barno bar);
> >  #else
> >  static inline void dw_pcie_ep_linkup(struct dw_pcie_ep *ep)
> > @@ -353,6 +356,12 @@ static inline void dw_pcie_ep_exit(struct
> dw_pcie_ep *ep)
> >  {
> >  }
> >
> > +static inline int dw_pcie_ep_raise_msi_irq(struct dw_pcie_ep *ep,
> > +					   u8 interrupt_num)
> > +{
> > +	return 0;
> > +}
> > +
> >  static inline void dw_pcie_ep_reset_bar(struct dw_pcie *pci, enum
> pci_barno bar)
> >  {
> >  }
> >
>=20
> Acked-by: Joao Pinto <jpinto@synopsys.com>

Acked-by: Jingoo Han <jingoohan1@gmail.com>

Best regards,
Jingoo Han
