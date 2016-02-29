Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from kirsty.vergenet.net ([202.4.237.240]:38711 "EHLO
	kirsty.vergenet.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752227AbcB2Ag0 (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Sun, 28 Feb 2016 19:36:26 -0500
Date: Mon, 29 Feb 2016 09:36:18 +0900
From: Simon Horman <horms@verge.net.au>
To: Phil Edworthy <phil.edworthy@renesas.com>
Cc: Geert Uytterhoeven <geert@linux-m68k.org>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Magnus Damm <magnus.damm@gmail.com>,
	linux-pci <linux-pci@vger.kernel.org>,
	"linux-renesas-soc@vger.kernel.org"
	<linux-renesas-soc@vger.kernel.org>
Subject: Re: [PATCH] PCI: rcar, rcar-gen2: Use ARCH_RENESAS
Message-ID: <20160229003618.GA25079@verge.net.au>
References: <1456361156-16798-1-git-send-email-horms+renesas@verge.net.au>
 <CAMuHMdUW=3Vx7M2tTHguF2Gs8BAWWcPOVNDPizdPTWyawy8vHg@mail.gmail.com>
 <HK2PR0601MB1393372115B466FBB5F2D4EEF5A70@HK2PR0601MB1393.apcprd06.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <HK2PR0601MB1393372115B466FBB5F2D4EEF5A70@HK2PR0601MB1393.apcprd06.prod.outlook.com>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Fri, Feb 26, 2016 at 09:22:04AM +0000, Phil Edworthy wrote:
> Hi Geert,
> 
> On 25 February 2016 08:05, Geert Uytterhoeven wrote:
> > On Thu, Feb 25, 2016 at 1:45 AM, Simon Horman
> > <horms+renesas@verge.net.au> wrote:
> > > Make use of ARCH_RENESAS in place of ARCH_SHMOBILE.
> > >
> > > This is part of an ongoing process to migrate from ARCH_SHMOBILE to
> > > ARCH_RENESAS the motivation for which being that RENESAS seems to be a
> > more
> > > appropriate name than SHMOBILE for the majority of Renesas ARM based
> > SoCs.
> > >
> > > Signed-off-by: Simon Horman <horms+renesas@verge.net.au>
> > 
> > Acked-by: Geert Uytterhoeven <geert+renesas@glider.be>
> > 
> > > --- a/drivers/pci/host/Kconfig
> > > +++ b/drivers/pci/host/Kconfig
> > 
> > > @@ -49,7 +49,7 @@ config PCI_RCAR_GEN2
> > >
> > >  config PCI_RCAR_GEN2_PCIE
> > >         bool "Renesas R-Car PCIe controller"
> > > -       depends on ARCH_SHMOBILE || (ARM && COMPILE_TEST)
> > > +       depends on ARCH_RENESAS || (ARM && COMPILE_TEST)
> > >         help
> > >           Say Y here if you want PCIe controller support on R-Car Gen2 SoCs.
> > 
> > BTW, this looks like a misnomer: the driver supports a compatible value for
> > R-Car H1, too ("renesas,pcie-r8a7779"), but it's not used in r8a7779.dtsi.
> IIRC, H1 PCIe support was nobbled in some way that meant you could not
> use it with any normal PCIe card. You could connect to another R-Car that
> was acting as an endpoint though.

It sounds like that might be worth documenting somewhere.

In any case, I think we could s/Gen2 // in the text above.
