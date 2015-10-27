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
Subject: [RFC PATCHv3 0/4] Driver for new VMD device
Date: Tue, 27 Oct 2015 11:34:03 -0600
Message-Id: <1445967247-24310-1-git-send-email-keith.busch@intel.com>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Here's version 3 for the VMD device driver, and overview of what changed
from v2:

>From review discussions, we discovered potential clashes in domain
numbering (thanks, Bjorn). This new version avoids that clash by using
domain numbers outside the ACPI defined _SEG range. Domains are purely
a software concept, so there is no need to constrain domains to the
possible segment range.

Since this lets domain numbers exceed 16 bit domains, PATCH 4/4 updates
pciutils to understand this so 'lspci' and 'setpci' will work as
expected with these types of domains. This is not a kernel patch, but
wasn't sure if it needs to be sent separately or to a different list,
so it's included here.

After testing configurations with constrained resources, we discovered
pci probe made the previously and perfectly reasonable assumption that
a pci domain provides 256 buses, but that's not always the case with
these domains. PATCH 1/4 addresses the reduced resource conflicts that
may occur during the initial scan.

PATCH 2/4 provides a generic interface to allow pci domains to define
DMA operations specific to their domain. This seemed better than tying
the feature to this new VMD device. An alternative suggestion for future
consideration was to use host_bridge specific operations when those are
provided when that option is implemented.

The main VMD patch in 3/4 is updated to address reviewer comments and
a bug fixes discovered during testing. Specific fixes and updates include:

  Lockdep inversion detection with irq flow handler and msi activation;
  replaced irq flow handler's locking with rcu list.

  Out of range configuration access from constrained CFGBAR.

  Improved description in changelog and Kconfig describing the additional
  bus resource benefit this device provides.

  Proper use of 'pci_add_resource()'.

  Removed unnecessary NULL checking.

  Simplified domain enumeration and removal by calling pci-core API's
  for scan and root bus removal.

  Use "module_pci_driver()" rather than "module_init()"

  Subscribe to the "new" domain specific operations rather than defining
  this as a PCI FIXUP.

  Fixed memory leak if irq_domain creation failed.

Keith Busch (4):
  pci: skip child bus with conflicting resources
  x86/pci: allow pci domain specific dma ops
  x86/pci: Initial commit for new VMD device driver
  pciutils: Allow 32-bit domains

 arch/x86/Kconfig              |   17 ++
 arch/x86/include/asm/device.h |   10 +
 arch/x86/include/asm/vmd.h    |   10 +
 arch/x86/kernel/apic/msi.c    |   38 +++
 arch/x86/pci/Makefile         |    2 +
 arch/x86/pci/common.c         |   38 +++
 arch/x86/pci/vmd.c            |  619 +++++++++++++++++++++++++++++++++++++++++
 drivers/pci/probe.c           |   10 +-
 kernel/irq/chip.c             |    1 +
 kernel/irq/irqdomain.c        |    3 +
 10 files changed, 746 insertions(+), 2 deletions(-)
 create mode 100644 arch/x86/include/asm/vmd.h
 create mode 100644 arch/x86/pci/vmd.c

-- 
1.7.10.4

