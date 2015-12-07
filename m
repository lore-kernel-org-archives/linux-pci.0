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
Subject: [PATCHv6 0/7] Driver for new "VMD" device
Date: Mon,  7 Dec 2015 14:32:22 -0700
Message-Id: <1449523949-21898-1-git-send-email-keith.busch@intel.com>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

v5 -> v6:

  Fixed kernel doc.

  Fixed S-o-B on PATCH 1/7.

  Added driver power management to save and restoring VMD pci state.

  Allow VMD domains to be accisble to aer_inject, which requires a minor
  change to use 32-bit pci domains.

  Changed child bus resource conflict detection on walking the pci
  domain. If the bus resource aperture is not large enough, we can
  enumerate only a sub-tree of the topology. A bridge device with
  subordinate outside the range should not be allocated. Checking for the
  conflict after the child is allocated retains pointer to the removed
  subordinate bus. The way to fix that is to call "pci_remove_bus_device"
  instead, but I don't think we want to remove the bridge dev since it
  is accessible, albeit not very useful as a bridge device.

Keith Busch (6):
  pci: child bus alloc fix on constrained resource
  Export msi and irq functions for module use
  x86-pci: allow pci domain specific dma ops
  x86/pci: Initial commit for new VMD device driver
  aer_inject: Use 32 bit int type domains
  pciutils: Allow 32-bit domains

Liu Jiang (1):
  msi: Relax msi_domain_alloc() to support parentless MSI irqdomains

 arch/x86/Kconfig                  |  13 +
 arch/x86/include/asm/device.h     |  10 +
 arch/x86/include/asm/hw_irq.h     |   5 +
 arch/x86/pci/Makefile             |   2 +
 arch/x86/pci/common.c             |  38 +++
 arch/x86/pci/vmd.c                | 695 ++++++++++++++++++++++++++++++++++++++
 drivers/pci/msi.c                 |   2 +
 drivers/pci/pcie/aer/aer_inject.c |  16 +-
 drivers/pci/probe.c               |   6 +
 kernel/irq/irqdomain.c            |   1 +
 kernel/irq/msi.c                  |   8 +-
 11 files changed, 785 insertions(+), 11 deletions(-)
 create mode 100644 arch/x86/pci/vmd.c

-- 
2.6.2.307.g37023ba

