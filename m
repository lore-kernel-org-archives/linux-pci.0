Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from relmlor4.renesas.com ([210.160.252.174]:14924 "EHLO
	relmlie3.idc.renesas.com" rhost-flags-OK-OK-OK-FAIL)
	by vger.kernel.org with ESMTP id S1756092AbbBCSqo convert rfc822-to-8bit
	(ORCPT <rfc822;linux-pci@vger.kernel.org>);
	Tue, 3 Feb 2015 13:46:44 -0500
From: Phil Edworthy <phil.edworthy@renesas.com>
To: Nobuhiro Iwamatsu <nobuhiro.iwamatsu.yj@renesas.com>
CC: "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
	"horms+renesas@verge.net.au" <horms+renesas@verge.net.au>,
	Nobuhiro Iwamatsu <nobuhiro.iwamatsu.yj@renesas.com>,
	"bhelgaas@google.com" <bhelgaas@google.com>
Subject: RE: [PATCH] PCI: rcar: Fix postion of MSI enable bit
Date: Tue, 3 Feb 2015 18:46:35 +0000
Message-ID: <SIXPR06MB0639D02BAB35FE7BD328BD24F53D0@SIXPR06MB0639.apcprd06.prod.outlook.com>
References: <1422853483-14334-1-git-send-email-nobuhiro.iwamatsu.yj@renesas.com> 
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Resend with correct ml address

On: 03 February 2015 18:44, Phil Edworthy wrote:
> Hi Iwamatsu-san,
> 
> Hmm, this is odd as MSI works before and after your patch. Since bit 31 just
> represents the value of MSICAP0[16].MSIE, I think this may just be used for
> endpoints.
> 
> However, you are correct that the bit used was wrong and so:
> Acked-by: Phil Edworthy <phil.edworthy@renesas.com>
> 
> Thanks
> Phil
> 
> On: 02 February 2015 05:05, Nobuhiro Iwamatsu wrote:
> >
> > Position of MSI enable bit is 31bit, not 28bit.
> > This fixes position of MSI bit necessary to initialize MSI.
> >
> > Signed-off-by: Nobuhiro Iwamatsu <nobuhiro.iwamatsu.yj@renesas.com>
> > ---
> >  drivers/pci/host/pcie-rcar.c | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> >
> > diff --git a/drivers/pci/host/pcie-rcar.c b/drivers/pci/host/pcie-rcar.c
> > index bb36e27..eb12659 100644
> > --- a/drivers/pci/host/pcie-rcar.c
> > +++ b/drivers/pci/host/pcie-rcar.c
> > @@ -505,7 +505,7 @@ static int rcar_pcie_hw_init(struct rcar_pcie *pcie)
> >
> >  	/* Enable MSI */
> >  	if (IS_ENABLED(CONFIG_PCI_MSI))
> > -		rcar_pci_write_reg(pcie, 0x101f0000, PCIEMSITXR);
> > +		rcar_pci_write_reg(pcie, 0x801f0000, PCIEMSITXR);
> >
> >  	/* Finish initialization - establish a PCI Express link */
> >  	rcar_pci_write_reg(pcie, CFINIT, PCIETCTLR);
> > --
> > 2.1.3

