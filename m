Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mx08-00178001.pphosted.com ([91.207.212.93]:54516 "EHLO
	mx08-00178001.pphosted.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1750710AbaIXEOp convert rfc822-to-8bit
	(ORCPT <rfc822;linux-pci@vger.kernel.org>);
	Wed, 24 Sep 2014 00:14:45 -0400
From: Mohit KUMAR DCG <Mohit.KUMAR@st.com>
To: Bjorn Helgaas <bhelgaas@google.com>,
	Minghuan Lian <Minghuan.Lian@freescale.com>
Cc: "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
	"linux-arm-kernel@lists.infradead.org"
	<linux-arm-kernel@lists.infradead.org>,
	Zang Roy-R61911 <r61911@freescale.com>,
	Hu Mingkai-B21284 <B21284@freescale.com>,
	Scott Wood <scottwood@freescale.com>,
	Yoder Stuart-B08248 <stuart.yoder@freescale.com>,
	Arnd Bergmann <arnd@arndb.de>, Jingoo Han <jg1.han@samsung.com>
Date: Wed, 24 Sep 2014 12:14:02 +0800
Subject: RE: [PATCH] PCI: designware: Fix configuration base address
Message-ID: <2CC2A0A4A178534D93D5159BF3BCB661ABCDBA8EEB@EAPEX1MAIL1.st.com>
References: <1411482540-31297-1-git-send-email-Minghuan.Lian@freescale.com>
 <20140923225306.GF27117@google.com>
In-Reply-To: <20140923225306.GF27117@google.com>
Content-Type: text/plain; charset="Windows-1252"
MIME-Version: 1.0
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Hello Minghuan,

> -----Original Message-----
> From: Bjorn Helgaas [mailto:bhelgaas@google.com]
> Sent: Wednesday, September 24, 2014 4:23 AM
> To: Minghuan Lian
> Cc: linux-pci@vger.kernel.org; linux-arm-kernel@lists.infradead.org; Zang
> Roy-R61911; Hu Mingkai-B21284; Scott Wood; Yoder Stuart-B08248; Arnd
> Bergmann; Mohit KUMAR DCG; Jingoo Han
> Subject: Re: [PATCH] PCI: designware: Fix configuration base address
> 
> [+cc Mohit, Jingoo]
> 
> On Tue, Sep 23, 2014 at 10:28:56PM +0800, Minghuan Lian wrote:
> > The code has calculated cfg0_base and cfg1_base when parsing 'reg'
> > or 'ranges' property of PCI DTS node. so remove duplicate calculation.
> > And when using 'reg', resource cfg is not used, the removed code will
> > get incorrect configuration base.
> >
> > Signed-off-by: Minghuan Lian <Minghuan.Lian@freescale.com>
> > ---
> >  drivers/pci/host/pcie-designware.c | 2 --
> >  1 file changed, 2 deletions(-)
> >
> > diff --git a/drivers/pci/host/pcie-designware.c
> > b/drivers/pci/host/pcie-designware.c
> > index c28ca05..0f3cb2a 100644
> > --- a/drivers/pci/host/pcie-designware.c
> > +++ b/drivers/pci/host/pcie-designware.c
> > @@ -515,7 +515,6 @@ int __init dw_pcie_host_init(struct pcie_port *pp)
> >  	pp->mem_base = pp->mem.start;
> >
> >  	if (!pp->va_cfg0_base) {
> > -		pp->cfg0_base = pp->cfg.start;
> >  		pp->va_cfg0_base = devm_ioremap(pp->dev, pp-
> >cfg0_base,
> >  						pp->cfg0_size);
> >  		if (!pp->va_cfg0_base) {
> > @@ -525,7 +524,6 @@ int __init dw_pcie_host_init(struct pcie_port *pp)
> >  	}
> >
> >  	if (!pp->va_cfg1_base) {
> > -		pp->cfg1_base = pp->cfg.start + pp->cfg0_size;
> >  		pp->va_cfg1_base = devm_ioremap(pp->dev, pp-
> >cfg1_base,
> >  						pp->cfg1_size);
> >  		if (!pp->va_cfg1_base) {
> > --
> > 1.9.1
> >

- Acked-by: Mohit KUMAR <mohit.kumar@st.com>

Thanks
Mohit
