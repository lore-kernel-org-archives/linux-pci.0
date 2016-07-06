Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail.windriver.com ([147.11.1.11]:44226 "EHLO
	mail.windriver.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752059AbcGFRkF (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Wed, 6 Jul 2016 13:40:05 -0400
Date: Wed, 6 Jul 2016 13:39:10 -0400
From: Paul Gortmaker <paul.gortmaker@windriver.com>
To: Will Deacon <will.deacon@arm.com>
CC: <linux-kernel@vger.kernel.org>,
	Bjorn Helgaas <bhelgaas@google.com>,
	<linux-pci@vger.kernel.org>
Subject: Re: [PATCH 04/14] PCI: generic: make it explicitly non-modular
Message-ID: <20160706173910.GJ26134@windriver.com>
References: <20160702231334.26684-1-paul.gortmaker@windriver.com>
 <20160702231334.26684-5-paul.gortmaker@windriver.com>
 <20160706170201.GE31910@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
In-Reply-To: <20160706170201.GE31910@arm.com>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

[Re: [PATCH 04/14] PCI: generic: make it explicitly non-modular] On 06/07/2016 (Wed 18:02) Will Deacon wrote:

> On Sat, Jul 02, 2016 at 07:13:24PM -0400, Paul Gortmaker wrote:
> > The Kconfig currently controlling compilation of this code is:
> > 
> > drivers/pci/host/Kconfig:config PCI_HOST_GENERIC
> > drivers/pci/host/Kconfig:       bool "Generic PCI host controller"
> > 
> > ...meaning that it currently is not being built as a module by anyone.
> > 
> > Lets remove the few trace uses of modular code and macros, so that
> > when reading the driver there is no doubt it is builtin-only.
> > 
> > Since module_platform_driver() uses the same init level priority as
> > builtin_platform_driver() the init ordering remains unchanged with
> > this commit.
> > 
> > Also note that MODULE_DEVICE_TABLE is a no-op for non-modular code.
> > 
> > We also delete the MODULE_LICENSE tag etc. since all that information
> > is already contained at the top of the file in the comments.
> > 
> > Cc: Will Deacon <will.deacon@arm.com>
> > Cc: Bjorn Helgaas <bhelgaas@google.com>
> > Cc: linux-pci@vger.kernel.org
> > Signed-off-by: Paul Gortmaker <paul.gortmaker@windriver.com>
> > ---
> >  drivers/pci/host/pci-host-generic.c | 10 ++--------
> >  1 file changed, 2 insertions(+), 8 deletions(-)
> 
> Given that nobody seems to need this as a module and it's not
> straightforward to enable that:
> 
> Acked-by: Will Deacon <will.deacon@arm.com>
> 
> I assume you've done something similar for
> drivers/pci/host/pci-host-common.c?

Not yet -- that one escaped my radar because it didn't have module_init
or MODULE_DEVICE_TABLE in it; it just has MODULE_AUTHOR etc.  I'll add
that fix to my queue and update my audit to hide the MODULE_AUTHOR tags
when compiling for !MODULE.

Thanks,
Paul.
--

> 
> Will
