Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail1.windriver.com ([147.11.146.13]:56276 "EHLO
	mail1.windriver.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751375AbcG1V2I (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Thu, 28 Jul 2016 17:28:08 -0400
Date: Thu, 28 Jul 2016 17:28:02 -0400
From: Paul Gortmaker <paul.gortmaker@windriver.com>
To: Keith Busch <keith.busch@intel.com>
CC: <linux-kernel@vger.kernel.org>,
	Bjorn Helgaas <bhelgaas@google.com>,
	"Mika Westerberg" <mika.westerberg@linux.intel.com>,
	<linux-pci@vger.kernel.org>
Subject: Re: [PATCH -next] PCI/PCIe: make DPC explicitly non-modular
Message-ID: <20160728212801.GY11410@windriver.com>
References: <20160728193303.12945-1-paul.gortmaker@windriver.com>
 <20160728202859.GA2420@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
In-Reply-To: <20160728202859.GA2420@localhost.localdomain>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

[Re: [PATCH -next] PCI/PCIe: make DPC explicitly non-modular] On 28/07/2016 (Thu 16:29) Keith Busch wrote:

> On Thu, Jul 28, 2016 at 03:33:03PM -0400, Paul Gortmaker wrote:
> > The Kconfig currently controlling compilation of this code is:
> > 
> > drivers/pci/pcie/Kconfig:config PCIE_DPC
> > drivers/pci/pcie/Kconfig:       bool "PCIe Downstream Port Containment support"
> > 
> > ...meaning that it currently is not being built as a module by anyone.
> > 
> > Lets remove the modular code that is essentially orphaned, so that
> > when reading the driver there is no doubt it is builtin-only.
> > 
> > Since module_init translates to device_initcall in the non-modular
> > case, the init ordering remains unchanged with this commit.
> > 
> > We also delete the MODULE_LICENSE tag etc. since all that information
> > was (or is now) contained at the top of the file in the comments.
> 
> Thanks for cleaning this up.
> 
> FWIW, all of the other pcie service drivers look like they could use
> the same cleanup.

Yep, not to worry, I've still got the following patches pending for-4.9:

$ grep PCI series 
# PCI
PCI-aerdrv-make-it-explicitly-non-modular.patch
PCI-altera-make-it-explicitly-non-modular.patch
PCI-dra7xx-make-it-explicitly-non-modular.patch
PCI-imx6-make-it-explicitly-non-modular.patch
PCI-pme-make-it-explicitly-non-modular.patch
PCI-qcom-make-it-explicitly-non-modular.patch
PCI-spear13xx-make-it-explicitly-non-modular.patch
PCI-xilinx-make-it-explicitly-non-modular.patch
PCI-xilinx-nwl-make-it-eplicitly-non-modular.patch
PCI-portdrv-make-it-explicitly-non-modular.patch
PCI-PCIe-make-dpc-explicitly-non-modular.patch
PCI-generic-make-host-common-explicitly-non-modular.patch
PCI-hotplug_core-make-it-explicitly-non-modular.patch
PCI-hotplug-make-core-code-explicitly-non-modular.patch

Thanks,
Paul.
--

> 
> Reviewed-by: Keith Busch <keith.busch@intel.com>
