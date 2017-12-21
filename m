Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-qk0-f196.google.com ([209.85.220.196]:36149 "EHLO
        mail-qk0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752156AbdLUQog (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 21 Dec 2017 11:44:36 -0500
From: "Jingoo Han" <jingoohan1@gmail.com>
To: "'Joao Pinto'" <Joao.Pinto@synopsys.com>,
        "'Niklas Cassel'" <niklas.cassel@axis.com>,
        "'Lorenzo Pieralisi'" <lorenzo.pieralisi@arm.com>,
        "'Bjorn Helgaas'" <bhelgaas@google.com>
Cc: "'Niklas Cassel'" <niklass@axis.com>, <linux-pci@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
References: <20171219232940.659-1-niklas.cassel@axis.com> <20171219232940.659-3-niklas.cassel@axis.com> <7308951d-5123-2ebf-1d11-27b4467625d9@synopsys.com>
In-Reply-To: <7308951d-5123-2ebf-1d11-27b4467625d9@synopsys.com>
Subject: Re: [PATCH v6 02/18] PCI: designware-ep: dw_pcie_ep_set_msi() should only set MMC bits
Date: Thu, 21 Dec 2017 11:44:33 -0500
Message-ID: <000101d37a7a$fb7209f0$f2561dd0$@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain;
        charset="utf-8"
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Wednesday, December 20, 2017 2:18 PM, Joao Pinto wrote:
>=20
> Hi,
>=20
> =C3=80s 11:29 PM de 12/19/2017, Niklas Cassel escreveu:
> > Previously, dw_pcie_ep_set_msi() wrote all bits in the Message =
Control
> > register, thus overwriting the PCI_MSI_FLAGS_64BIT bit.
> > By clearing the PCI_MSI_FLAGS_64BIT bit, we break MSI
> > on systems where the RC has set a 64 bit MSI address.
> > Fix dw_pcie_ep_set_msi() so that it only sets MMC bits.
> >
> > Signed-off-by: Niklas Cassel <niklas.cassel@axis.com>
> > ---
> >  drivers/pci/dwc/pcie-designware-ep.c | 4 +++-
> >  drivers/pci/dwc/pcie-designware.h    | 1 +
> >  2 files changed, 4 insertions(+), 1 deletion(-)
> >
> > diff --git a/drivers/pci/dwc/pcie-designware-ep.c
> b/drivers/pci/dwc/pcie-designware-ep.c
> > index d53d5f168363..c92ab87fd660 100644
> > --- a/drivers/pci/dwc/pcie-designware-ep.c
> > +++ b/drivers/pci/dwc/pcie-designware-ep.c
> > @@ -220,7 +220,9 @@ static int dw_pcie_ep_set_msi(struct pci_epc =
*epc,
> u8 encode_int)
> >  	struct dw_pcie_ep *ep =3D epc_get_drvdata(epc);
> >  	struct dw_pcie *pci =3D to_dw_pcie_from_ep(ep);
> >
> > -	val =3D (encode_int << MSI_CAP_MMC_SHIFT);
> > +	val =3D dw_pcie_readw_dbi(pci, MSI_MESSAGE_CONTROL);
> > +	val &=3D ~MSI_CAP_MMC_MASK;
> > +	val |=3D (encode_int << MSI_CAP_MMC_SHIFT) & MSI_CAP_MMC_MASK;
> >  	dw_pcie_writew_dbi(pci, MSI_MESSAGE_CONTROL, val);
> >
> >  	return 0;
> > diff --git a/drivers/pci/dwc/pcie-designware.h =
b/drivers/pci/dwc/pcie-
> designware.h
> > index ecdede68522a..9aaf0cd04dd6 100644
> > --- a/drivers/pci/dwc/pcie-designware.h
> > +++ b/drivers/pci/dwc/pcie-designware.h
> > @@ -101,6 +101,7 @@
> >
> >  #define MSI_MESSAGE_CONTROL		0x52
> >  #define MSI_CAP_MMC_SHIFT		1
> > +#define MSI_CAP_MMC_MASK		(7 << MSI_CAP_MMC_SHIFT)
> >  #define MSI_CAP_MME_SHIFT		4
> >  #define MSI_CAP_MME_MASK		(7 << MSI_CAP_MME_SHIFT)
> >  #define MSI_MESSAGE_ADDR_L32		0x54
> >
>=20
> Acked-by: Joao Pinto <jpinto@synopsys.com>

Acked-by: Jingoo Han <jingoohan1@gmail.com>

Best regards,
Jingoo Han
