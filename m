Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.136]:56213 "EHLO mail.kernel.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751160AbcCKSNu (ORCPT <rfc822;linux-pci@vger.kernel.org>);
	Fri, 11 Mar 2016 13:13:50 -0500
Date: Fri, 11 Mar 2016 12:13:46 -0600
From: Bjorn Helgaas <helgaas@kernel.org>
To: Simon Horman <horms@verge.net.au>
Cc: Bjorn Helgaas <bhelgaas@google.com>,
	Magnus Damm <magnus.damm@gmail.com>, linux-pci@vger.kernel.org,
	linux-renesas-soc@vger.kernel.org
Subject: Re: [PATCH] PCI: rcar, rcar-gen2: Use ARCH_RENESAS
Message-ID: <20160311181346.GC4725@localhost>
References: <1456361156-16798-1-git-send-email-horms+renesas@verge.net.au>
 <20160308183650.GB23484@localhost>
 <20160311014911.GA26819@verge.net.au>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20160311014911.GA26819@verge.net.au>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Fri, Mar 11, 2016 at 10:49:11AM +0900, Simon Horman wrote:
> On Tue, Mar 08, 2016 at 12:36:50PM -0600, Bjorn Helgaas wrote:
> > On Thu, Feb 25, 2016 at 09:45:56AM +0900, Simon Horman wrote:
> > > Make use of ARCH_RENESAS in place of ARCH_SHMOBILE.
> > > 
> > > This is part of an ongoing process to migrate from ARCH_SHMOBILE to
> > > ARCH_RENESAS the motivation for which being that RENESAS seems to be a more
> > > appropriate name than SHMOBILE for the majority of Renesas ARM based SoCs.
> > > 
> > > Signed-off-by: Simon Horman <horms+renesas@verge.net.au>
> > > ---
> > >  drivers/pci/host/Kconfig | 4 ++--
> > >  1 file changed, 2 insertions(+), 2 deletions(-)
> > > 
> > >  Based on the next branch of the pci tree
> > > 
> > > diff --git a/drivers/pci/host/Kconfig b/drivers/pci/host/Kconfig
> > > index 75a605426538..dcf4d5a349ca 100644
> > > --- a/drivers/pci/host/Kconfig
> > > +++ b/drivers/pci/host/Kconfig
> > > @@ -41,7 +41,7 @@ config PCI_TEGRA
> > >  config PCI_RCAR_GEN2
> > >  	bool "Renesas R-Car Gen2 Internal PCI controller"
> > >  	depends on ARM
> > > -	depends on ARCH_SHMOBILE || COMPILE_TEST
> > > +	depends on ARCH_RENESAS || COMPILE_TEST
> > >  	help
> > >  	  Say Y here if you want internal PCI support on R-Car Gen2 SoC.
> > >  	  There are 3 internal PCI controllers available with a single
> > > @@ -49,7 +49,7 @@ config PCI_RCAR_GEN2
> > >  
> > >  config PCI_RCAR_GEN2_PCIE
> > >  	bool "Renesas R-Car PCIe controller"
> > > -	depends on ARCH_SHMOBILE || (ARM && COMPILE_TEST)
> > > +	depends on ARCH_RENESAS || (ARM && COMPILE_TEST)
> > 
> > I don't object to this, but I don't know what's happening with Phil's
> > question.  Is there another revision coming with a doc change and/or the
> > "s/Gen2//" change?
> 
> Sorry for not following up earlier. I have a slight preference to handle
> the Gen2 issue as a separate change. Could you consider picking up this
> patch as is?
> 
> With regards to the Gen2 change:
> 
> * I think its entirely reasonable to s/Gen2// in the help text but;
> * I think it would also be worth considering, as a follow-up change,
>   s/PCI_RCAR_GEN2/PCI_RCAR/ though I'm wary of breaking existing configs.

The Gen2 and PCI/PCIe text is definitely confusing.  It'd be nice to
clean it up somehow.

Bjorn
