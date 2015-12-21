Return-Path: <linux-kernel-owner@vger.kernel.org>
From: Keith Busch <keith.busch@intel.com>
To: LKML <linux-kernel@vger.kernel.org>, x86@kernel.org,
	linux-pci@vger.kernel.org
Cc: Jiang Liu <jiang.liu@linux.intel.com>,
	Thomas Gleixner <tglx@linutronix.de>,
	Dan Williams <dan.j.williams@intel.com>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Bryan Veal <bryan.e.veal@intel.com>,
	Ingo Molnar <mingo@redhat.com>,
	"H. Peter Anvin" <hpa@zytor.com>, Martin Mares <mj@ucw.cz>,
	Jon Derrick <jonathan.derrick@intel.com>,
	Keith Busch <keith.busch@intel.com>
Subject: [PATCHv7 0/6] Driver for new "VMD" device
Date: Mon, 21 Dec 2015 10:44:54 -0700
Message-Id: <1450719900-2824-1-git-send-email-keith.busch@intel.com>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Now on version 7, mostly cosmetic.

v6->v7:

 Removed PCI resource window patch rejecting child bus that doesn't fit in
 parent's window. There are additional caveats the maintainer brought up
 that need more consideration. Since we are not dependent on that patch,
 it is removed from the series.

 Dropped the pciutils patch since it is an external projet not part
 of this series anyway. Will send tooling updates to the appropriate
 mailing list once this settles.

 Modified commit log messages to align with maintainer's requested format.

 Using u32's for domains instead of ints.

 Fixed code comment on posted/non-posted clarification. 

 Added a dmesg info message to show which domain a VMD end point bound to.

 Fixed the vmd domain's root bus parent device so power management has
 the correct dependency tree.

Keith Busch (5):
  PCI/MSI: Export msi functions for module use
  x86/IRQ: Export IRQ domain function for module use
  x86/PCI: Allow PCI domain specific dma ops
  x86/PCI: Initial commit for new VMD device driver
  PCI/AER: Use 32 bit int type domains

Liu Jiang (1):
  msi: Relax msi_domain_alloc() to support parentless MSI irqdomains

 arch/x86/Kconfig                  |  13 +
 arch/x86/include/asm/device.h     |  10 +
 arch/x86/include/asm/hw_irq.h     |   5 +
 arch/x86/pci/Makefile             |   2 +
 arch/x86/pci/common.c             |  38 +++
 arch/x86/pci/vmd.c                | 698 ++++++++++++++++++++++++++++++++++++++
 drivers/pci/msi.c                 |   2 +
 drivers/pci/pcie/aer/aer_inject.c |  16 +-
 kernel/irq/irqdomain.c            |   1 +
 kernel/irq/msi.c                  |   8 +-
 10 files changed, 782 insertions(+), 11 deletions(-)
 create mode 100644 arch/x86/pci/vmd.c

-- 
2.6.2.307.g37023ba

