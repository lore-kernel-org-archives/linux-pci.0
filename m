Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-ob0-f173.google.com ([209.85.214.173]:45073 "EHLO
	mail-ob0-f173.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752011AbbCJWqt (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Tue, 10 Mar 2015 18:46:49 -0400
Received: by obbnt9 with SMTP id nt9so5102262obb.12
        for <linux-pci@vger.kernel.org>; Tue, 10 Mar 2015 15:46:49 -0700 (PDT)
Date: Tue, 10 Mar 2015 17:46:46 -0500
From: Bjorn Helgaas <bhelgaas@google.com>
To: Ray Jui <rjui@broadcom.com>
Cc: Arnd Bergmann <arnd@arndb.de>, Hauke Mehrtens <hauke@hauke-m.de>,
	Paul Bolle <pebolle@tiscali.nl>,
	Florian Fainelli <f.fainelli@gmail.com>,
	Dmitry Torokhov <dtor@google.com>,
	Anatol Pomazau <anatol@google.com>,
	Scott Branden <sbranden@broadcom.com>,
	linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	bcm-kernel-feedback-list@broadcom.com, devicetree@vger.kernel.org,
	Rob Herring <robh@kernel.org>,
	Yijing Wang <wangyijing@huawei.com>
Subject: Re: [PATCH v5 3/4] pci: iproc: Add Broadcom iProc PCIe support
Message-ID: <20150310224646.GC32204@google.com>
References: <1425947886-23705-1-git-send-email-rjui@broadcom.com>
 <1425947886-23705-4-git-send-email-rjui@broadcom.com>
 <20150310214010.GB32204@google.com>
 <54FF6EAC.90603@broadcom.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <54FF6EAC.90603@broadcom.com>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Tue, Mar 10, 2015 at 03:22:36PM -0700, Ray Jui wrote:
> Hi Bjorn,
> 
> On 3/10/2015 2:40 PM, Bjorn Helgaas wrote:
> > [+cc Rob, Yijing]
> > 
> > On Mon, Mar 09, 2015 at 05:38:05PM -0700, Ray Jui wrote:
> >> This adds the support for Broadcom iProc PCIe controller
> >>
> >> pcie-iproc.c servers as the common core driver, and front-end bus
> >> interface needs to be added to support different bus interfaces
> >>
> >> pcie-iproc-pltfm.c contains the support for the platform bus interface
> >>
> >> Signed-off-by: Ray Jui <rjui@broadcom.com>
> >> Reviewed-by: Scott Branden <sbraden@broadcom.com>
> >> ---
> >>  drivers/pci/host/Kconfig            |   17 ++
> >>  drivers/pci/host/Makefile           |    2 +
> >>  drivers/pci/host/pcie-iproc-pltfm.c |  108 +++++++++++
> >>  drivers/pci/host/pcie-iproc.c       |  351 +++++++++++++++++++++++++++++++++++
> >>  drivers/pci/host/pcie-iproc.h       |   42 +++++
> >>  5 files changed, 520 insertions(+)
> >>  create mode 100644 drivers/pci/host/pcie-iproc-pltfm.c
> >>  create mode 100644 drivers/pci/host/pcie-iproc.c
> >>  create mode 100644 drivers/pci/host/pcie-iproc.h
> >>
> >> diff --git a/drivers/pci/host/Kconfig b/drivers/pci/host/Kconfig
> >> index 7b892a9..f4d9c90 100644
> >> --- a/drivers/pci/host/Kconfig
> >> +++ b/drivers/pci/host/Kconfig
> >> @@ -106,4 +106,21 @@ config PCI_VERSATILE
> >>  	bool "ARM Versatile PB PCI controller"
> >>  	depends on ARCH_VERSATILE
> >>  
> >> +config PCIE_IPROC
> >> +	tristate "Broadcom iProc PCIe controller"
> >> +	help
> >> +	  This enables the iProc PCIe core controller support for Broadcom's
> >> +	  iProc family of SoCs. An appropriate bus interface driver also needs
> >> +	  to be enabled
> >> +
> >> +config PCIE_IPROC_PLTFM
> >> +	tristate "Broadcom iProc PCIe platform bus driver"
> >> +	depends on ARCH_BCM_IPROC || COMPILE_TEST
> >> +	depends on OF
> >> +	select PCIE_IPROC
> >> +	default ARCH_BCM_IPROC
> >> +	help
> >> +	  Say Y here if you want to use the Broadcom iProc PCIe controller
> >> +	  through the generic platform bus interface
> > 
> > Do you anticipate additional front-end bus interfaces?  If not, and maybe
> > even if you do, you might squash everything into pcie-iproc.c.  Then you
> > only need one file (no .h file needed) and the package is a little
> > simpler.  I think it's pretty common to have multiple driver registration
> > methods in the same file (OF, PCI, ACPI, etc.)  And I think it's common to
> > have those methods guarded by the generic config symbol (CONFIG_PCI,
> > CONFIG_OF, etc.) rather than defining new ones specific to the driver.
> 
> Yes I do expect Hauke (CCed) to add BCMA bus front end support later.
> 
> I still think having the front end bus driver separated is cleaner and
> may be less troublesome for Hauke to add BCMA support in the future. But
> if you strongly favor having everything stuffed in one single file, I
> can make that change. Please let me know.

OK, just leave it as-is.

> >> +#define INVALID_ACCESS_OFFSET 0xffffffff
> >> +static u32 iproc_pcie_cfg_base(struct iproc_pcie *pcie, int busno,
> >> +			       unsigned int devfn, int where)
> >> +{
> >> +	int slot = PCI_SLOT(devfn);
> >> +	int fn = PCI_FUNC(devfn);
> >> +	u32 val;
> >> +
> > 
> > Would you mind adding a comment to the effect that
> > CFG_IND_ADDR_OFFSET/CFG_IND_DATA_OFFSET and
> > CFG_ADDR_OFFSET/CFG_DATA_OFFSET are protected by pci_lock?
> > 
> > They obviously need a mutex, and while I don't have any plans to
> > change it, I'm not completely 100% sure that pci_lock is the best
> > place for it.
> 
> Sorry I don't get what you want me to do here. Do you want me to add
> some comment to explain that the struct pci_ops read/write callbacks are
> already protected at the upper layer by the pci_lock spinlock and
> therefore no lock is required in this driver?

Nothing fancy; something like this that "git grep pci_lock" will find:

  /* addr/data must used atomically and are protected by pci_lock */

Bjorn
