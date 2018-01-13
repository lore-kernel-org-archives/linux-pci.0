Return-Path: <SRS0=A+B5=EI=fredlawl.com=fred@kernel.org>
Return-Path: <SRS0=A+B5=EI=fredlawl.com=fred@kernel.org>
From: Frederick Lawler <fred@fredlawl.com>
To: linux-pci@vger.kernel.org
Cc: helgaas@kernel.org,
	Frederick Lawler <fred@fredlawl.com>
Subject: [PATCH v3 0/3] PCI: Add and use pci_<level>: dev_<level> equivalents
Date: Fri, 12 Jan 2018 22:58:35 -0600
Message-Id: <1515819518-6501-1-git-send-email-fred@fredlawl.com>
List-ID: <linux-pci.vger.kernel.org>

Replace current uses of dev_<level> with pci_<level> by adding and using
PCI specific fuctions. 

V2:
* Replace static inline varadic functions with macros instead
* Convert hotplug, AER, ASPM, PME, PTM
V3:
* Split updates for hotplug, AER, ASPM, PME, PTM into new patch

Frederick Lawler (3):
  PCI: Create  minor pci_dev log wrapper functions
  PCI: Replace calls from dev_<level> to pci_<level>
  PCI: Replace calls from dev_<level> to pci_<level> in pcie and hotplug

 drivers/pci/access.c                   |   8 +-
 drivers/pci/bus.c                      |   4 +-
 drivers/pci/hotplug/cpqphp_core.c      |   2 +-
 drivers/pci/hotplug/pnv_php.c          |  40 +++----
 drivers/pci/hotplug/sgi_hotplug.c      |  36 +++---
 drivers/pci/hotplug/shpchp.h           |   8 +-
 drivers/pci/hotplug/shpchp_core.c      |   2 +-
 drivers/pci/iov.c                      |  10 +-
 drivers/pci/irq.c                      |   7 +-
 drivers/pci/msi.c                      |   7 +-
 drivers/pci/pci-acpi.c                 |   2 +-
 drivers/pci/pci-stub.c                 |   2 +-
 drivers/pci/pci-sysfs.c                |  10 +-
 drivers/pci/pci.c                      |  82 +++++++-------
 drivers/pci/pcie/aer/aer_inject.c      |  15 +--
 drivers/pci/pcie/aer/aerdrv.c          |   2 +-
 drivers/pci/pcie/aer/aerdrv_core.c     |  21 ++--
 drivers/pci/pcie/aer/aerdrv_errprint.c |  22 ++--
 drivers/pci/pcie/aspm.c                |   9 +-
 drivers/pci/pcie/pme.c                 |   6 +-
 drivers/pci/pcie/ptm.c                 |   2 +-
 drivers/pci/probe.c                    |  75 ++++++-------
 drivers/pci/quirks.c                   | 200 ++++++++++++++++-----------------
 drivers/pci/rom.c                      |   4 +-
 drivers/pci/setup-bus.c                |  44 ++++----
 drivers/pci/setup-irq.c                |   4 +-
 drivers/pci/setup-res.c                |  40 ++++---
 drivers/pci/vc.c                       |  18 ++-
 drivers/pci/xen-pcifront.c             |  19 ++--
 include/linux/pci.h                    |  27 +++++
 30 files changed, 363 insertions(+), 365 deletions(-)

-- 
2.7.4
