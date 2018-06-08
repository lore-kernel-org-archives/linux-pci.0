Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.99]:48644 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752478AbeFHUEr (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Fri, 8 Jun 2018 16:04:47 -0400
Subject: [RFC PATCH v1 00/13] PCI/AER: Squash into one file
From: Bjorn Helgaas <helgaas@kernel.org>
To: linux-pci@vger.kernel.org
Cc: Keith Busch <keith.busch@intel.com>,
        Borislav Petkov <bp@alien8.de>,
        Oza Pawandeep <poza@codeaurora.org>,
        linux-kernel@vger.kernel.org
Date: Fri, 08 Jun 2018 15:04:45 -0500
Message-ID: <152848785553.11888.12243539903985770441.stgit@bhelgaas-glaptop.roam.corp.google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

The AER code is scattered across several files and buried a little too deep
in the hierarchy, which makes it a bit of a hassle to browse.  Consolidate
it all in a single file (plus the optional aer_inject module) and move it
up one level to drivers/pci/pcie/aer.c.

This is all pure code moves; no functional changes intended.

---

Bjorn Helgaas (13):
      PCI/AER: Remove forward declarations
      PCI/AER: Reorder code to group probe/remove stuff together
      PCI/AER: Squash aerdrv_core.c into aerdrv.c
      PCI/AER: Squash aerdrv_errprint.c into aerdrv.c
      PCI/AER: Squash aerdrv_acpi.c into aerdrv.c
      PCI/AER: Squash ecrc.c into aerdrv.c
      PCI/AER: Remove duplicate pcie_port_bus_type declaration
      PCI/AER: Move pcie_aer_get_firmware_first() to portdrv.h
      PCI/AER: Move aer_irq() declaration to portdrv.h
      PCI/AER: Move private AER things to aerdrv.c
      PCI/AER: Squash Kconfig.debug into Kconfig
      PCI/AER: Hoist aerdrv.c, aer_inject.c up to drivers/pci/pcie/
      PCI/AER: Use "PCI Express" consistently in Kconfig text


 drivers/pci/pcie/Kconfig               |   41 +
 drivers/pci/pcie/Makefile              |    3 
 drivers/pci/pcie/aer.c                 | 1377 ++++++++++++++++++++++++++++++++
 drivers/pci/pcie/aer/Kconfig           |   29 -
 drivers/pci/pcie/aer/Kconfig.debug     |   19 
 drivers/pci/pcie/aer/Makefile          |   13 
 drivers/pci/pcie/aer/aer_inject.c      |  550 -------------
 drivers/pci/pcie/aer/aerdrv.c          |  371 ---------
 drivers/pci/pcie/aer/aerdrv.h          |   95 --
 drivers/pci/pcie/aer/aerdrv_acpi.c     |  141 ---
 drivers/pci/pcie/aer/aerdrv_core.c     |  496 ------------
 drivers/pci/pcie/aer/aerdrv_errprint.c |  260 ------
 drivers/pci/pcie/aer/ecrc.c            |  117 ---
 drivers/pci/pcie/aer_inject.c          |  551 +++++++++++++
 drivers/pci/pcie/dpc.c                 |    1 
 drivers/pci/pcie/portdrv.h             |   15 
 16 files changed, 1983 insertions(+), 2096 deletions(-)
 create mode 100644 drivers/pci/pcie/aer.c
 delete mode 100644 drivers/pci/pcie/aer/Kconfig
 delete mode 100644 drivers/pci/pcie/aer/Kconfig.debug
 delete mode 100644 drivers/pci/pcie/aer/Makefile
 delete mode 100644 drivers/pci/pcie/aer/aer_inject.c
 delete mode 100644 drivers/pci/pcie/aer/aerdrv.c
 delete mode 100644 drivers/pci/pcie/aer/aerdrv.h
 delete mode 100644 drivers/pci/pcie/aer/aerdrv_acpi.c
 delete mode 100644 drivers/pci/pcie/aer/aerdrv_core.c
 delete mode 100644 drivers/pci/pcie/aer/aerdrv_errprint.c
 delete mode 100644 drivers/pci/pcie/aer/ecrc.c
 create mode 100644 drivers/pci/pcie/aer_inject.c
