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
Subject: [PATCHv4 0/6] Driver for new VMD device
Date: Fri,  6 Nov 2015 15:35:40 -0700
Message-Id: <1446849346-8242-1-git-send-email-keith.busch@intel.com>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Version 4 after re-working the irq domain hierarchies.

v3 -> v4:

  Patch from Jiang to allow parent-less msi irq domain.

  Separated kernel API dependency exports into their own patch.

  Removed the vmd irq domain hierarchy, and instead use a msi irq
  domain. This pushed all the irq initialization and teardown handling
  into the irq_chip implementation and reduced kernel dependencies.

  Using devm_request_irq instead of an irq flow handler. This moves the
  irq life management to the devres API which simplifies teardown.

  Implemented a smarter method of selecting the VMD vector to share.

  Lots style fixes/updates and additional code comments.

The one review comment I have not fixed is the affinity hint. We are
still developing a way to better handle this, so have left it as a error
returning stub. It's less than optimal, but isn't more harmful than that.

Keith Busch (5):
  pci: skip child bus with conflicting resources
  Export msi and irq functions for module use
  x86-pci: allow pci domain specific dma ops
  x86/pci: Initial commit for new VMD device driver
  pciutils: Allow 32-bit domains

Liu Jiang (1):
  msi: Relax msi_domain_alloc() to support parentless MSI irqdomains

 arch/x86/Kconfig              |  13 +
 arch/x86/include/asm/device.h |  10 +
 arch/x86/include/asm/hw_irq.h |   5 +
 arch/x86/pci/Makefile         |   2 +
 arch/x86/pci/common.c         |  38 +++
 arch/x86/pci/vmd.c            | 646 ++++++++++++++++++++++++++++++++++++++++++
 drivers/pci/msi.c             |   2 +
 drivers/pci/probe.c           |  10 +-
 kernel/irq/irqdomain.c        |   1 +
 kernel/irq/msi.c              |   8 +-
 10 files changed, 730 insertions(+), 5 deletions(-)
 create mode 100644 arch/x86/pci/vmd.c

-- 
2.6.2.307.g37023ba

