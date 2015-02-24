Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from kirsty.vergenet.net ([202.4.237.240]:43475 "EHLO
	kirsty.vergenet.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751312AbbBXCC5 (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Mon, 23 Feb 2015 21:02:57 -0500
Date: Tue, 24 Feb 2015 11:02:46 +0900
From: Simon Horman <horms@verge.net.au>
To: Phil Edworthy <phil.edworthy@renesas.com>
Cc: Nobuhiro Iwamatsu <nobuhiro.iwamatsu.yj@renesas.com>,
	"linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
	"bhelgaas@google.com" <bhelgaas@google.com>
Subject: Re: [PATCH] PCI: rcar: Add mask of data to be written to PCIEPARL
Message-ID: <20150224020246.GB10297@verge.net.au>
References: <1422853798-14467-1-git-send-email-nobuhiro.iwamatsu.yj@renesas.com>
 <SIXPR06MB0639AA0109B0332E757B7BF6F53D0@SIXPR06MB0639.apcprd06.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <SIXPR06MB0639AA0109B0332E757B7BF6F53D0@SIXPR06MB0639.apcprd06.prod.outlook.com>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Tue, Feb 03, 2015 at 06:53:51PM +0000, Phil Edworthy wrote:
> Hi Iwamatsu-san,
> 
> On: 02 February 2015 05:10, Nobuhiro Iwamatsu wrote:
> > 
> > Lower 7bit of PCIEPARL is reserved bit. When we write to this register,
> > these bits must be 0.
> > 
> > Signed-off-by: Nobuhiro Iwamatsu <nobuhiro.iwamatsu.yj@renesas.com>
> Acked-by: Phil Edworthy <phil.edworthy@renesas.com>

Acked-by: Simon Horman <horms+renesas@verge.net.au>

> 
> Thanks
> Phil
> 
> > ---
> >  drivers/pci/host/pcie-rcar.c | 3 ++-
> >  1 file changed, 2 insertions(+), 1 deletion(-)
> > 
> > diff --git a/drivers/pci/host/pcie-rcar.c b/drivers/pci/host/pcie-rcar.c
> > index 748786c..bb36e27 100644
> > --- a/drivers/pci/host/pcie-rcar.c
> > +++ b/drivers/pci/host/pcie-rcar.c
> > @@ -342,7 +342,8 @@ static void rcar_pcie_setup_window(int win, struct
> > rcar_pcie *pcie)
> >  		res_start = res->start;
> > 
> >  	rcar_pci_write_reg(pcie, upper_32_bits(res_start), PCIEPARH(win));
> > -	rcar_pci_write_reg(pcie, lower_32_bits(res_start), PCIEPARL(win));
> > +	rcar_pci_write_reg(pcie, lower_32_bits(res_start) & ~0x7F,
> > +			   PCIEPARL(win));
> > 
> >  	/* First resource is for IO */
> >  	mask = PAR_ENABLE;
> > --
> > 2.1.3
> 
