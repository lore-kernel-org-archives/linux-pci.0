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
Subject: [PATCHv5 0/6] Driver for new VMD device
Date: Fri, 13 Nov 2015 10:17:31 -0700
Message-Id: <1447435057-5212-1-git-send-email-keith.busch@intel.com>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Latest revision after incorporating maintainer comments, mostly code
style and comments.

Is it too late to hope for a 4.4 inclusion? :)

v4 -> v5:

  Updated struct comments to kernel-doc style.

  Added comments to call out future work for enhanced irq sharing and
  affinity mask settings.

  Commended the potential list corruption if NMI, interrupt, and irq
  teardown occur concurrently.

  Using raw spinlock for irq list manipulation.

  Fix IRQ flags: removed IRQF_SHARED.

  Fixed the SoB in patch 1, added my Tested-by.

Keith Busch (5):
  pci: skip child bus with conflicting resources
  Export msi and irq functions for module use
  x86-pci: allow pci domain specific dma ops
  x86/pci: Initial commit for new VMD device driver
  pciutils: Allow 32-bit domains

Jiang Liu (1):
  msi: Relax msi_domain_alloc() to support parentless MSI irqdomains

 arch/x86/Kconfig              |  13 +
 arch/x86/include/asm/device.h |  10 +
 arch/x86/include/asm/hw_irq.h |   5 +
 arch/x86/pci/Makefile         |   2 +
 arch/x86/pci/common.c         |  38 +++
 arch/x86/pci/vmd.c            | 677 ++++++++++++++++++++++++++++++++++++++++++
 drivers/pci/msi.c             |   2 +
 drivers/pci/probe.c           |  10 +-
 kernel/irq/irqdomain.c        |   1 +
 kernel/irq/msi.c              |   8 +-
 10 files changed, 761 insertions(+), 5 deletions(-)
 create mode 100644 arch/x86/pci/vmd.c

-- 
2.6.2.307.g37023ba

