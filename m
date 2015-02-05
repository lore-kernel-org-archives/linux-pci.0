Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from kirsty.vergenet.net ([202.4.237.240]:54812 "EHLO
	kirsty.vergenet.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755922AbbBEAfo (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Wed, 4 Feb 2015 19:35:44 -0500
Date: Thu, 5 Feb 2015 09:35:40 +0900
From: Simon Horman <horms@verge.net.au>
To: Phil Edworthy <phil.edworthy@renesas.com>
Cc: Nobuhiro Iwamatsu <nobuhiro.iwamatsu.yj@renesas.com>,
	"linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
	"bhelgaas@google.com" <bhelgaas@google.com>
Subject: Re: [PATCH] PCI: rcar: Change macro name of PCIEPARL and PCIEPARH
Message-ID: <20150205003540.GB17596@verge.net.au>
References: <1423040575-28080-1-git-send-email-nobuhiro.iwamatsu.yj@renesas.com>
 <SIXPR06MB06397E299C79226C6DD148CDF53A0@SIXPR06MB0639.apcprd06.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <SIXPR06MB06397E299C79226C6DD148CDF53A0@SIXPR06MB0639.apcprd06.prod.outlook.com>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Wed, Feb 04, 2015 at 09:14:40AM +0000, Phil Edworthy wrote:
> Hi Iwamatsu-san,
> 
> On: 04 February 2015 09:03, Nobuhiro Iwamatsu wrote:
> > 
> > PCIEPARL and PCIEPARH are macro that calculates address of the register.
> > However, register name is incorrect, PCIEPALR and PCIEPAUR is correct.
> > This change macro name to PCIEPALR and PCIEPAUR.
> > 
> > Signed-off-by: Nobuhiro Iwamatsu <nobuhiro.iwamatsu.yj@renesas.com>
> Acked-by: Phil Edworthy <phil.edworthy@renesas.com>

Acked-by: Simon Horman <horms+renesas@verge.net.au>

> 
> Thanks
> Phil
> 
> > ---
> >  drivers/pci/host/pcie-rcar.c | 8 ++++----
> >  1 file changed, 4 insertions(+), 4 deletions(-)
> > 
> > diff --git a/drivers/pci/host/pcie-rcar.c b/drivers/pci/host/pcie-rcar.c
> > index eb12659..183c32d 100644
> > --- a/drivers/pci/host/pcie-rcar.c
> > +++ b/drivers/pci/host/pcie-rcar.c
> > @@ -64,8 +64,8 @@
> >  #define  LAR_ENABLE		(1 << 1)
> > 
> >  /* PCIe address reg & mask */
> > -#define PCIEPARL(x)		(0x03400 + ((x) * 0x20))
> > -#define PCIEPARH(x)		(0x03404 + ((x) * 0x20))
> > +#define PCIEPALR(x)		(0x03400 + ((x) * 0x20))
> > +#define PCIEPAUR(x)		(0x03404 + ((x) * 0x20))
> >  #define PCIEPAMR(x)		(0x03408 + ((x) * 0x20))
> >  #define PCIEPTCTLR(x)		(0x0340c + ((x) * 0x20))
> >  #define  PAR_ENABLE		(1 << 31)
> > @@ -341,9 +341,9 @@ static void rcar_pcie_setup_window(int win, struct
> > rcar_pcie *pcie)
> >  	else
> >  		res_start = res->start;
> > 
> > -	rcar_pci_write_reg(pcie, upper_32_bits(res_start), PCIEPARH(win));
> > +	rcar_pci_write_reg(pcie, upper_32_bits(res_start), PCIEPAUR(win));
> >  	rcar_pci_write_reg(pcie, lower_32_bits(res_start) & ~0x7F,
> > -			   PCIEPARL(win));
> > +			   PCIEPALR(win));
> > 
> >  	/* First resource is for IO */
> >  	mask = PAR_ENABLE;
> > --
> > 2.1.3
> 
