Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.99]:52328 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751978AbdGaW6Y (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Mon, 31 Jul 2017 18:58:24 -0400
Date: Mon, 31 Jul 2017 17:58:22 -0500
From: Bjorn Helgaas <helgaas@kernel.org>
To: Paul Burton <paul.burton@imgtec.com>
Cc: Guenter Roeck <linux@roeck-us.net>,
        Bjorn Helgaas <bhelgaas@google.com>, linux-pci@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Michal Simek <michal.simek@xilinx.com>,
        =?iso-8859-1?Q?S=F6ren?= Brinkmann <soren.brinkmann@xilinx.com>,
        James Hogan <james.hogan@imgtec.com>
Subject: Re: [PATCH] PCI: xilinx: Remove platform/architecture restrictions
Message-ID: <20170731225822.GB19800@bhelgaas-glaptop.roam.corp.google.com>
References: <1500856777-23383-1-git-send-email-linux@roeck-us.net>
 <3882569.bb2rKKAOIY@np-p-burton>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <3882569.bb2rKKAOIY@np-p-burton>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Mon, Jul 24, 2017 at 11:49:22AM +0100, Paul Burton wrote:
> Hi Guenter & all,
> 
> On Monday, 24 July 2017 01:39:37 BST Guenter Roeck wrote:
> > The MIPS Boston board configuration tries to enable CONFIG_PCIE_XILINX.
> > That doesn't work since PCIE_XILINX depends on ARCH_ZYNQ || MICROBLAZE.
> > Remove that restriction.
> 
> I'd prefer that this patch does not go in standalone. The intent for the MIPS 
> Boston board is that this driver is enabled for MIPS by this patch:
> 
> https://patchwork.kernel.org/patch/9794361/
> 
> But not until after earlier patches in that series fix issues with the driver:
> 
> https://patchwork.kernel.org/patch/9794355/
> https://patchwork.kernel.org/patch/9794357/
> https://patchwork.kernel.org/patch/9794359/
> 
> That has been held up by disagreement about whether the driver should be using 
> 0-3 or 1-4 for hardware IRQ numbers, sadly, despite the driver already being 
> in tree & clearly broken, and my series not changing which the driver uses...

It's true that your v5 series only changes xilinx from using hwirq 0-3
to 0-4 (with 0 being unused in both cases, and the addition of 4
fixing the "INTD doesn't work" bug).

However, I *would* like to see this issue cleaned up consistently
across all our drivers.  I mooted a couple ideas in [1], but nobody
seemed interested.  If I merged your series as-is, there would be even
less interest.

[1] http://lkml.kernel.org/r/20170712221455.GJ14614@bhelgaas-glaptop.roam.corp.google.com

> In any case, I don't really mind if people would rather remove the 
> architecture restrictions than just add MIPS, but I'd prefer this doesn't go 
> in until the rest of my series since without at least patch 1 of my seres this 
> will lead to various WARN()s on Boston boards.
> 
> Thanks,
>     Paul
> 
> > 
> > Cc: Paul Burton <paul.burton@imgtec.com>
> > Cc: James Hogan <james.hogan@imgtec.com>
> > Signed-off-by: Guenter Roeck <linux@roeck-us.net>
> > ---
> >  drivers/pci/host/Kconfig | 1 -
> >  1 file changed, 1 deletion(-)
> > 
> > diff --git a/drivers/pci/host/Kconfig b/drivers/pci/host/Kconfig
> > index 89d61c2cbfaa..ed905a5401c3 100644
> > --- a/drivers/pci/host/Kconfig
> > +++ b/drivers/pci/host/Kconfig
> > @@ -71,7 +71,6 @@ config PCI_HOST_GENERIC
> > 
> >  config PCIE_XILINX
> >  	bool "Xilinx AXI PCIe host bridge support"
> > -	depends on ARCH_ZYNQ || MICROBLAZE
> >  	help
> >  	  Say 'Y' here if you want kernel to support the Xilinx AXI PCIe
> >  	  Host Bridge driver.
> 
