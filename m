Return-Path: <SRS0=Zo3Z=LW=wunner.de=lukas@kernel.org>
Return-Path: <SRS0=Zo3Z=LW=wunner.de=lukas@kernel.org>
Message-Id: <cover.1536341821.git.lukas@wunner.de>
From: Lukas Wunner <lukas@wunner.de>
Date: Sat, 8 Sep 2018 09:59:01 +0200
Subject: [PATCH v2 0/8] PCI hotplug diet
To: Bjorn Helgaas <helgaas@kernel.org>, linux-pci@vger.kernel.org
Cc: Sinan Kaya <okaya@kernel.org>, Mika Westerberg <mika.westerberg@linux.intel.com>, Keith Busch <keith.busch@intel.com>, David Yang <mmyangfl@gmail.com>
List-ID: <linux-pci.vger.kernel.org>

Rebase of my PCI hotplug material for the next merge window on current
pci/hotplug branch:

* Patch [1/8] makes pciehp work with broken hardware which hardwires
  Presence Detect to zero.  Originally submitted August 24 in response
  to a user report:
  https://patchwork.ozlabs.org/patch/961860/

* Patches [2/8] to [8/8] contain cleanups and code reduction.
  Originally submitted August 19:
  https://patchwork.ozlabs.org/project/linux-pci/list/?series=61434&state=*


Changes since v1:

* Separate struct unification from renaming of struct members in
  patches [2/8] and [3/8]. (Sinan Kaya)

* Do not change unsigned int to bool in patch [4/8] per commit
  d729593e492e ("checkpatch: add a --strict test for structs with
  bool member definitions").  For the same reason use unsigned int
  instead of bool in patch [6/8] for newly added latch_status and
  adapter_status members in cpci_hotplug.h.

* Add all collected Acked-by and Reviewed-by tags.


Lukas Wunner (8):
  PCI: pciehp: Tolerate Presence Detect hardwired to zero
  PCI: pciehp: Unify controller and slot structs
  PCI: pciehp: Rename controller struct members for clarity
  PCI: pciehp: Reshuffle controller struct for clarity
  PCI: hotplug: Constify hotplug_slot_ops
  PCI: hotplug: Drop hotplug_slot_info
  PCI: hotplug: Embed hotplug_slot
  PCI: hotplug: Document TODOs

 arch/powerpc/include/asm/pnv-pci.h      |   2 +-
 drivers/pci/hotplug/TODO                |  74 +++++++
 drivers/pci/hotplug/acpiphp.h           |  10 +-
 drivers/pci/hotplug/acpiphp_core.c      |  36 +---
 drivers/pci/hotplug/acpiphp_ibm.c       |   2 +-
 drivers/pci/hotplug/cpci_hotplug.h      |  11 +-
 drivers/pci/hotplug/cpci_hotplug_core.c | 105 +++-------
 drivers/pci/hotplug/cpci_hotplug_pci.c  |   6 +-
 drivers/pci/hotplug/cpqphp.h            |   9 +-
 drivers/pci/hotplug/cpqphp_core.c       |  59 ++----
 drivers/pci/hotplug/cpqphp_ctrl.c       |  31 +--
 drivers/pci/hotplug/ibmphp.h            |   9 +-
 drivers/pci/hotplug/ibmphp_core.c       | 121 ++++-------
 drivers/pci/hotplug/ibmphp_ebda.c       |  70 +------
 drivers/pci/hotplug/pci_hotplug_core.c  |  53 ++---
 drivers/pci/hotplug/pciehp.h            | 128 ++++++------
 drivers/pci/hotplug/pciehp_core.c       |  84 +++-----
 drivers/pci/hotplug/pciehp_ctrl.c       | 254 +++++++++++-------------
 drivers/pci/hotplug/pciehp_hpc.c        | 139 +++++--------
 drivers/pci/hotplug/pciehp_pci.c        |  14 +-
 drivers/pci/hotplug/pnv_php.c           |  35 ++--
 drivers/pci/hotplug/rpaphp.h            |  10 +-
 drivers/pci/hotplug/rpaphp_core.c       |  20 +-
 drivers/pci/hotplug/rpaphp_pci.c        |  11 +-
 drivers/pci/hotplug/rpaphp_slot.c       |  22 +-
 drivers/pci/hotplug/s390_pci_hpc.c      |  44 ++--
 drivers/pci/hotplug/sgi_hotplug.c       |  63 +++---
 drivers/pci/hotplug/shpchp.h            |   8 +-
 drivers/pci/hotplug/shpchp_core.c       |  48 ++---
 drivers/pci/hotplug/shpchp_ctrl.c       |  21 +-
 drivers/pci/pci.c                       |   4 +-
 drivers/pci/slot.c                      |   2 +-
 drivers/platform/x86/asus-wmi.c         |  39 +---
 drivers/platform/x86/eeepc-laptop.c     |  43 ++--
 include/linux/pci_hotplug.h             |  43 +---
 35 files changed, 635 insertions(+), 995 deletions(-)
 create mode 100644 drivers/pci/hotplug/TODO

-- 
2.18.0
