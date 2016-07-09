Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail.windriver.com ([147.11.1.11]:38982 "EHLO
	mail.windriver.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756658AbcGIXPV (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Sat, 9 Jul 2016 19:15:21 -0400
Date: Sat, 9 Jul 2016 19:15:17 -0400
From: Paul Gortmaker <paul.gortmaker@windriver.com>
To: Duc Dang <dhdang@apm.com>
CC: Tanmay Inamdar <tinamdar@apm.com>,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
	Bjorn Helgaas <bhelgaas@google.com>,
	"linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>
Subject: Re: [PATCH 14/14] PCI: xgene: make it explicitly non-modular
Message-ID: <20160709231516.GE30853@windriver.com>
References: <20160702231334.26684-1-paul.gortmaker@windriver.com>
 <20160702231334.26684-15-paul.gortmaker@windriver.com>
 <CACoXjc=Tw2a_oCvxTmZY+7jeyyb9XvLF1yWx9FEPWekPBaAw1g@mail.gmail.com>
 <CADaLNDm4L=Zvd6izcMbCZ1jnFO2ix3Oxybp2A4oi+LdxaY1jzA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
In-Reply-To: <CADaLNDm4L=Zvd6izcMbCZ1jnFO2ix3Oxybp2A4oi+LdxaY1jzA@mail.gmail.com>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

[Re: [PATCH 14/14] PCI: xgene: make it explicitly non-modular] On 07/07/2016 (Thu 15:42) Duc Dang wrote:

> On Thu, Jul 7, 2016 at 3:35 PM, Tanmay Inamdar <tinamdar@apm.com> wrote:
> >
> >
> > On Sat, Jul 2, 2016 at 4:13 PM, Paul Gortmaker
> > <paul.gortmaker@windriver.com> wrote:
> >>
> >> The Kconfig currently controlling compilation of this code is:
> >>
> >> drivers/pci/host/Kconfig:config PCI_XGENE
> >> drivers/pci/host/Kconfig:       bool "X-Gene PCIe controller"
> >>
> >> ...meaning that it currently is not being built as a module by anyone.
> >>
> >> Lets remove the few trace uses of modular code and macros, so that
> >> when reading the driver there is no doubt it is builtin-only.
> >>
> >> Since module_platform_driver() uses the same init level priority as
> >> builtin_platform_driver() the init ordering remains unchanged with
> >> this commit.
> >>
> >> We also delete the MODULE_LICENSE tag etc. since all that information
> >> is already contained at the top of the file in the comments.
> >>
> >> Cc: Tanmay Inamdar <tinamdar@apm.com>
> >> Cc: Bjorn Helgaas <bhelgaas@google.com>
> >> Cc: linux-pci@vger.kernel.org
> >> Signed-off-by: Paul Gortmaker <paul.gortmaker@windriver.com>
> 
> Thanks for taking care of this, Paul.
> 
> I tested your patch and it worked fine on my X-Gene Mustang board.
> 
> One minor comment below.
> 
> >> ---
> >>  drivers/pci/host/pci-xgene.c | 8 ++------
> >>  1 file changed, 2 insertions(+), 6 deletions(-)
> >>
> >> diff --git a/drivers/pci/host/pci-xgene.c b/drivers/pci/host/pci-xgene.c
> >> index 7eb20cc76dd3..a81273c23341 100644
> >> --- a/drivers/pci/host/pci-xgene.c
> >> +++ b/drivers/pci/host/pci-xgene.c
> >> @@ -21,7 +21,7 @@
> >>  #include <linux/io.h>
> >>  #include <linux/jiffies.h>
> >>  #include <linux/memblock.h>
> >> -#include <linux/module.h>
> >> +#include <linux/init.h>
> 
> The platform_device.h already has builtin_platform_driver macro
> defined. So this init.h is not need?

If you look, you will find that platform_device.h does not include the
init.h even though it references __init; it can do this w/o error since
all the references themselves are in a macro.  However once code wants
to be a consumer of those macros, they will need init.h present.  Often
you can overlook directly calling it out for inclusion since it gets
sourced by another header, but it is best policy to list what gets used.

Thanks for testing!

Paul.
--

> 
> >>  #include <linux/of.h>
> >>  #include <linux/of_address.h>
> >>  #include <linux/of_irq.h>
> >> @@ -579,8 +579,4 @@ static struct platform_driver xgene_pcie_driver = {
> >>         },
> >>         .probe = xgene_pcie_probe_bridge,
> >>  };
> >> -module_platform_driver(xgene_pcie_driver);
> >> -
> >> -MODULE_AUTHOR("Tanmay Inamdar <tinamdar@apm.com>");
> >> -MODULE_DESCRIPTION("APM X-Gene PCIe driver");
> >> -MODULE_LICENSE("GPL v2");
> >> +builtin_platform_driver(xgene_pcie_driver);
> >
> >
> > Copying Duc.
> >>
> >> --
> >> 2.8.4
> >>
> >
> Regards,
> Duc Dang.
