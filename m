Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.136]:33278 "EHLO mail.kernel.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S933658AbcAKRGU (ORCPT <rfc822;linux-pci@vger.kernel.org>);
	Mon, 11 Jan 2016 12:06:20 -0500
Date: Mon, 11 Jan 2016 11:06:17 -0600
From: Bjorn Helgaas <helgaas@kernel.org>
To: Keith Busch <keith.busch@intel.com>
Cc: LKML <linux-kernel@vger.kernel.org>, x86@kernel.org,
	linux-pci@vger.kernel.org, Jiang Liu <jiang.liu@linux.intel.com>,
	Thomas Gleixner <tglx@linutronix.de>,
	Dan Williams <dan.j.williams@intel.com>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Bryan Veal <bryan.e.veal@intel.com>,
	Ingo Molnar <mingo@redhat.com>,
	"H. Peter Anvin" <hpa@zytor.com>, Martin Mares <mj@ucw.cz>,
	Jon Derrick <jonathan.derrick@intel.com>
Subject: Re: [PATCHv7 0/6] Driver for new "VMD" device
Message-ID: <20160111170617.GA30780@localhost>
References: <1450719900-2824-1-git-send-email-keith.busch@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1450719900-2824-1-git-send-email-keith.busch@intel.com>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Hi Keith,

On Mon, Dec 21, 2015 at 10:44:54AM -0700, Keith Busch wrote:
> Now on version 7, mostly cosmetic.
> 
> v6->v7:
> 
>  Removed PCI resource window patch rejecting child bus that doesn't fit in
>  parent's window. There are additional caveats the maintainer brought up
>  that need more consideration. Since we are not dependent on that patch,
>  it is removed from the series.
> 
>  Dropped the pciutils patch since it is an external projet not part
>  of this series anyway. Will send tooling updates to the appropriate
>  mailing list once this settles.
> 
>  Modified commit log messages to align with maintainer's requested format.
> 
>  Using u32's for domains instead of ints.
> 
>  Fixed code comment on posted/non-posted clarification. 
> 
>  Added a dmesg info message to show which domain a VMD end point bound to.
> 
>  Fixed the vmd domain's root bus parent device so power management has
>  the correct dependency tree.
> 
> Keith Busch (5):
>   PCI/MSI: Export msi functions for module use
>   x86/IRQ: Export IRQ domain function for module use
>   x86/PCI: Allow PCI domain specific dma ops
>   x86/PCI: Initial commit for new VMD device driver
>   PCI/AER: Use 32 bit int type domains
> 
> Liu Jiang (1):
>   msi: Relax msi_domain_alloc() to support parentless MSI irqdomains
> 
>  arch/x86/Kconfig                  |  13 +
>  arch/x86/include/asm/device.h     |  10 +
>  arch/x86/include/asm/hw_irq.h     |   5 +
>  arch/x86/pci/Makefile             |   2 +
>  arch/x86/pci/common.c             |  38 +++
>  arch/x86/pci/vmd.c                | 698 ++++++++++++++++++++++++++++++++++++++
>  drivers/pci/msi.c                 |   2 +
>  drivers/pci/pcie/aer/aer_inject.c |  16 +-
>  kernel/irq/irqdomain.c            |   1 +
>  kernel/irq/msi.c                  |   8 +-
>  10 files changed, 782 insertions(+), 11 deletions(-)
>  create mode 100644 arch/x86/pci/vmd.c

Checkpatch complained about a few things that should be easy to fix up:

  x86-pci-allow-pci-domain
  -:26: WARNING: struct dma_map_ops should normally be const
  x86-pci-initial-commit-for-new
  -:125: WARNING: added, moved or deleted file(s), does MAINTAINERS need updating?
  -:168: WARNING: please, no space before tabs
  -:187: WARNING: please, no space before tabs
  -:212: WARNING: struct dma_map_ops should normally be const
  -:269: WARNING: line over 80 characters
  -:384: WARNING: Missing a blank line after declarations
  -:391: WARNING: Missing a blank line after declarations

This is from:

+       struct device *vdev = dev_to_vmd_dev(dev);
+       return vdev->archdata.dma_ops->alloc(vdev, size, addr, flag, attrs);

There are a lot of these, and I'm not going to be obsessive about all
these two-line functions.  But maybe a macro or helper function could
turn them all into one-line functions and side-step it, e.g.,:

  static struct dma_ops *vmd_dma_ops(struct device *dev)
  {
    return &dev_to_vmd_dev(dev)->archdata.dma_ops;
  }

  static void *vmd_alloc(...)
  {
    return vmd_dma_ops(dev)->alloc(...);
  }

  -:398: WARNING: Missing a blank line after declarations
  -:406: WARNING: Missing a blank line after declarations
  -:415: WARNING: Missing a blank line after declarations
  -:425: WARNING: Missing a blank line after declarations
  -:434: WARNING: Missing a blank line after declarations
  -:442: WARNING: Missing a blank line after declarations
  -:450: WARNING: Missing a blank line after declarations
  -:457: WARNING: Missing a blank line after declarations
  -:464: WARNING: Missing a blank line after declarations
  -:471: WARNING: Missing a blank line after declarations
  -:478: WARNING: Missing a blank line after declarations
  -:484: WARNING: Missing a blank line after declarations
  -:490: WARNING: Missing a blank line after declarations
  -:497: WARNING: Missing a blank line after declarations
  -:509: ERROR: Macros with multiple statements should be enclosed in a do - while loop
  -:509: WARNING: macros should not use a trailing semicolon
  -:510: ERROR: trailing statements should be on next line

We should definitely fix this one.

  -:514: WARNING: struct dma_map_ops should normally be const
  -:515: WARNING: struct dma_map_ops should normally be const
  -:654: WARNING: line over 80 characters
  -:656: WARNING: line over 80 characters
  -:662: WARNING: line over 80 characters
  -:664: WARNING: line over 80 characters
  -:692: WARNING: line over 80 characters

These could be easily fixed with a "struct resource *res", which would
make the code more readable as well.

  -:747: ERROR: space required before the open parenthesis '('

