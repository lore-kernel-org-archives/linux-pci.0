Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from kirsty.vergenet.net ([202.4.237.240]:60446 "EHLO
	kirsty.vergenet.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S933153AbcCKBtU (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Thu, 10 Mar 2016 20:49:20 -0500
Date: Fri, 11 Mar 2016 10:49:11 +0900
From: Simon Horman <horms@verge.net.au>
To: Bjorn Helgaas <helgaas@kernel.org>
Cc: Bjorn Helgaas <bhelgaas@google.com>,
	Magnus Damm <magnus.damm@gmail.com>, linux-pci@vger.kernel.org,
	linux-renesas-soc@vger.kernel.org
Subject: Re: [PATCH] PCI: rcar, rcar-gen2: Use ARCH_RENESAS
Message-ID: <20160311014911.GA26819@verge.net.au>
References: <1456361156-16798-1-git-send-email-horms+renesas@verge.net.au>
 <20160308183650.GB23484@localhost>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20160308183650.GB23484@localhost>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Tue, Mar 08, 2016 at 12:36:50PM -0600, Bjorn Helgaas wrote:
> On Thu, Feb 25, 2016 at 09:45:56AM +0900, Simon Horman wrote:
> > Make use of ARCH_RENESAS in place of ARCH_SHMOBILE.
> > 
> > This is part of an ongoing process to migrate from ARCH_SHMOBILE to
> > ARCH_RENESAS the motivation for which being that RENESAS seems to be a more
> > appropriate name than SHMOBILE for the majority of Renesas ARM based SoCs.
> > 
> > Signed-off-by: Simon Horman <horms+renesas@verge.net.au>
> > ---
> >  drivers/pci/host/Kconfig | 4 ++--
> >  1 file changed, 2 insertions(+), 2 deletions(-)
> > 
> >  Based on the next branch of the pci tree
> > 
> > diff --git a/drivers/pci/host/Kconfig b/drivers/pci/host/Kconfig
> > index 75a605426538..dcf4d5a349ca 100644
> > --- a/drivers/pci/host/Kconfig
> > +++ b/drivers/pci/host/Kconfig
> > @@ -41,7 +41,7 @@ config PCI_TEGRA
> >  config PCI_RCAR_GEN2
> >  	bool "Renesas R-Car Gen2 Internal PCI controller"
> >  	depends on ARM
> > -	depends on ARCH_SHMOBILE || COMPILE_TEST
> > +	depends on ARCH_RENESAS || COMPILE_TEST
> >  	help
> >  	  Say Y here if you want internal PCI support on R-Car Gen2 SoC.
> >  	  There are 3 internal PCI controllers available with a single
> > @@ -49,7 +49,7 @@ config PCI_RCAR_GEN2
> >  
> >  config PCI_RCAR_GEN2_PCIE
> >  	bool "Renesas R-Car PCIe controller"
> > -	depends on ARCH_SHMOBILE || (ARM && COMPILE_TEST)
> > +	depends on ARCH_RENESAS || (ARM && COMPILE_TEST)
> 
> I don't object to this, but I don't know what's happening with Phil's
> question.  Is there another revision coming with a doc change and/or the
> "s/Gen2//" change?

Sorry for not following up earlier. I have a slight preference to handle
the Gen2 issue as a separate change. Could you consider picking up this
patch as is?

With regards to the Gen2 change:

* I think its entirely reasonable to s/Gen2// in the help text but;
* I think it would also be worth considering, as a follow-up change,
  s/PCI_RCAR_GEN2/PCI_RCAR/ though I'm wary of breaking existing configs.

  So I don't have a clear view of how to move forwards at this time.
