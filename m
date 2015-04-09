Return-Path: <linux-kernel-owner@vger.kernel.org>
Date: Thu, 9 Apr 2015 08:26:00 -0500
From: Bjorn Helgaas <bhelgaas@google.com>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
	Michael D Labriola <mlabriol@gdeb.com>,
	Dan Carpenter <dan.carpenter@oracle.com>,
	Rasmus Villemoes <linux@rasmusvillemoes.dk>,
	"Matwey V. Kornilov" <matwey@sai.msu.ru>,
	Yinghai Lu <yinghai@kernel.org>,
	"David S. Miller" <davem@davemloft.net>
Subject: [GIT PULL] PCI fixes for v4.0
Message-ID: <20150409132600.GH30967@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Hi Linus,

Here are some fixes for v4.0.  I apologize for how late they are.  We were
hoping for some better fixes, but couldn't get them polished in time.
These fix:

  - a Xen domU oops with PCI passthrough devices
  - a sparc T5 boot failure
  - a STM SPEAr13xx crash (use after initdata freed)
  - a cpcihp hotplug driver thinko
  - an AER thinko that printed stack junk

Bjorn


The following changes since commit 085a68d0010ffa57603b93c2b09fdf98bf74218c:

  PCI: xgene: Add register offset to config space base address (2015-03-05 22:14:21 -0600)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/helgaas/pci.git tags/pci-v4.0-fixes-3

for you to fetch changes up to d10b730f97a7f1fa58c9ec300828f87157cd6b95:

  Revert "sparc/PCI: Clip bridge windows to fit in upstream windows" (2015-04-08 10:04:55 -0500)

----------------------------------------------------------------
PCI updates for v4.0:

  Enumeration
    - Don't look for ACPI hotplug parameters if ACPI is disabled (Bjorn Helgaas)

  Resource management
    - Revert "sparc/PCI: Clip bridge windows to fit in upstream windows" (Bjorn Helgaas)

  AER
    - Avoid info leak in __print_tlp_header() (Rasmus Villemoes)

  PCI device hotplug
    - Add missing curly braces in cpci_configure_slot() (Dan Carpenter)

  ST Microelectronics SPEAr13xx host bridge driver
    - Drop __initdata from spear13xx_pcie_driver (Matwey V. Kornilov)

----------------------------------------------------------------
Bjorn Helgaas (2):
      PCI: Don't look for ACPI hotplug parameters if ACPI is disabled
      Revert "sparc/PCI: Clip bridge windows to fit in upstream windows"

Dan Carpenter (1):
      PCI: cpcihp: Add missing curly braces in cpci_configure_slot()

Matwey V. Kornilov (1):
      PCI: spear: Drop __initdata from spear13xx_pcie_driver

Rasmus Villemoes (1):
      PCI/AER: Avoid info leak in __print_tlp_header()

 arch/sparc/kernel/pci.c                |  5 +----
 drivers/pci/host/pcie-designware.c     |  2 +-
 drivers/pci/host/pcie-spear13xx.c      |  6 +++---
 drivers/pci/hotplug/cpci_hotplug_pci.c |  3 ++-
 drivers/pci/pci-acpi.c                 |  3 +++
 drivers/pci/pcie/aer/aerdrv_errprint.c | 12 ++----------
 6 files changed, 12 insertions(+), 19 deletions(-)
