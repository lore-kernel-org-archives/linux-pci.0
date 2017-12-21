Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-qk0-f193.google.com ([209.85.220.193]:46840 "EHLO
        mail-qk0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753648AbdLUQpK (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 21 Dec 2017 11:45:10 -0500
From: "Jingoo Han" <jingoohan1@gmail.com>
To: "'Joao Pinto'" <Joao.Pinto@synopsys.com>,
        "'Niklas Cassel'" <niklas.cassel@axis.com>,
        "'Lorenzo Pieralisi'" <lorenzo.pieralisi@arm.com>,
        "'Bjorn Helgaas'" <bhelgaas@google.com>
Cc: "'Niklas Cassel'" <niklass@axis.com>, <linux-pci@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
References: <20171219232940.659-1-niklas.cassel@axis.com> <20171219232940.659-4-niklas.cassel@axis.com> <dd13b24a-fb66-6c76-a61a-cacab6fbbd50@synopsys.com>
In-Reply-To: <dd13b24a-fb66-6c76-a61a-cacab6fbbd50@synopsys.com>
Subject: Re: [PATCH v6 03/18] PCI: designware-ep: Read-only registers need DBI_RO_WR_EN to be writable
Date: Thu, 21 Dec 2017 11:45:07 -0500
Message-ID: <000201d37a7b$0fa31b30$2ee95190$@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain;
        charset="utf-8"
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Wednesday, December 20, 2017 2:19 PM, Joao Pinto wrote:
>=20
>=20
> Hi,
>=20
> =C3=80s 11:29 PM de 12/19/2017, Niklas Cassel escreveu:
> > Certain registers that pcie-designware-ep tries to write to are =
read-
> only
> > registers. However, these registers can become read/write if we =
first
> > enable the DBI_RO_WR_EN bit. Set/unset the DBI_RO_WR_EN bit =
before/after
> > writing these registers.
> >
> > Signed-off-by: Niklas Cassel <niklas.cassel@axis.com>
> > ---
> >  drivers/pci/dwc/pcie-designware-ep.c | 8 ++++++++
> >  1 file changed, 8 insertions(+)
> >
> > diff --git a/drivers/pci/dwc/pcie-designware-ep.c
> b/drivers/pci/dwc/pcie-designware-ep.c
> > index c92ab87fd660..3fb34be99715 100644
> > --- a/drivers/pci/dwc/pcie-designware-ep.c
> > +++ b/drivers/pci/dwc/pcie-designware-ep.c
> > @@ -35,8 +35,10 @@ static void dw_pcie_ep_reset_bar(struct dw_pcie =
*pci,
> enum pci_barno bar)
> >  	u32 reg;
> >
> >  	reg =3D PCI_BASE_ADDRESS_0 + (4 * bar);
> > +	dw_pcie_dbi_ro_wr_en(pci);
> >  	dw_pcie_writel_dbi2(pci, reg, 0x0);
> >  	dw_pcie_writel_dbi(pci, reg, 0x0);
> > +	dw_pcie_dbi_ro_wr_dis(pci);
> >  }
> >
> >  static int dw_pcie_ep_write_header(struct pci_epc *epc,
> > @@ -45,6 +47,7 @@ static int dw_pcie_ep_write_header(struct pci_epc =
*epc,
> >  	struct dw_pcie_ep *ep =3D epc_get_drvdata(epc);
> >  	struct dw_pcie *pci =3D to_dw_pcie_from_ep(ep);
> >
> > +	dw_pcie_dbi_ro_wr_en(pci);
> >  	dw_pcie_writew_dbi(pci, PCI_VENDOR_ID, hdr->vendorid);
> >  	dw_pcie_writew_dbi(pci, PCI_DEVICE_ID, hdr->deviceid);
> >  	dw_pcie_writeb_dbi(pci, PCI_REVISION_ID, hdr->revid);
> > @@ -58,6 +61,7 @@ static int dw_pcie_ep_write_header(struct pci_epc =
*epc,
> >  	dw_pcie_writew_dbi(pci, PCI_SUBSYSTEM_ID, hdr->subsys_id);
> >  	dw_pcie_writeb_dbi(pci, PCI_INTERRUPT_PIN,
> >  			   hdr->interrupt_pin);
> > +	dw_pcie_dbi_ro_wr_dis(pci);
> >
> >  	return 0;
> >  }
> > @@ -142,8 +146,10 @@ static int dw_pcie_ep_set_bar(struct pci_epc =
*epc,
> enum pci_barno bar,
> >  	if (ret)
> >  		return ret;
> >
> > +	dw_pcie_dbi_ro_wr_en(pci);
> >  	dw_pcie_writel_dbi2(pci, reg, size - 1);
> >  	dw_pcie_writel_dbi(pci, reg, flags);
> > +	dw_pcie_dbi_ro_wr_dis(pci);
> >
> >  	return 0;
> >  }
> > @@ -223,7 +229,9 @@ static int dw_pcie_ep_set_msi(struct pci_epc =
*epc,
> u8 encode_int)
> >  	val =3D dw_pcie_readw_dbi(pci, MSI_MESSAGE_CONTROL);
> >  	val &=3D ~MSI_CAP_MMC_MASK;
> >  	val |=3D (encode_int << MSI_CAP_MMC_SHIFT) & MSI_CAP_MMC_MASK;
> > +	dw_pcie_dbi_ro_wr_en(pci);
> >  	dw_pcie_writew_dbi(pci, MSI_MESSAGE_CONTROL, val);
> > +	dw_pcie_dbi_ro_wr_dis(pci);
> >
> >  	return 0;
> >  }
> >
>=20
> Acked-by: Joao Pinto <jpinto@synopsys.com>

Acked-by: Jingoo Han <jingoohan1@gmail.com>

Best regards,
Jingoo Han
