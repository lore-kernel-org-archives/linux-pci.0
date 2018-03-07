Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.99]:42336 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1750951AbeCGGNY (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Wed, 7 Mar 2018 01:13:24 -0500
Subject: [PATCH v1 0/9] PCI: Simplify PCIe port driver
From: Bjorn Helgaas <helgaas@kernel.org>
To: linux-pci@vger.kernel.org
Cc: linux-kernel@vger.kernel.org,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>, linux-pm@vger.kernel.org,
        Keith Busch <keith.busch@intel.com>,
        Sinan Kaya <okaya@codeaurora.org>,
        Lukas Wunner <lukas@wunner.de>
Date: Wed, 07 Mar 2018 00:13:23 -0600
Message-ID: <152040297576.240786.1532465558381209070.stgit@bhelgaas-glaptop.roam.corp.google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

This is an attempt to move a few things out of the port driver.

Patches 1-2 move a workaround for a BIOS PME issue from the port driver to
the PCI core, so it doesn't depend on CONFIG_PCIEPORTBUS.

Patch 3 extends that workaround so it works for Root Complex Event
Collectors.  I haven't seen reports of this being a problem, but I think we
should handle Event Collector PMEs the same as Root Port PMEs.

Patch 4 disables the port driver completely for "pcie_ports=compat".  We
used to register the driver, claim port devices, enable them, etc., as part
of supporting the above BIOS workaround.

Patch 5 removes a port driver link order dependency.

Patch 6 removes the unused VC service.

Patch 7 simplifies the _OSC code path by keeping more of the details in the
ACPI pci_root.c driver.

Patch 8 removes an unnecessary #include.

Patch 9 removes the "pcie_hp=nomsi" parameter.  This was added to work
around an issue when shutting down devices, but a later patch fixed the
root cause, and I don't think we need such a specific parameter any more
(we still have "pci=nomsi").

---

Bjorn Helgaas (9):
      PCI/PM: Move pcie_clear_root_pme_status() to core
      PCI/PM: Clear PCIe PME Status bit in core, not PCIe port driver
      PCI/PM: Clear PCIe PME Status bit for Root Complex Event Collectors
      PCI/portdrv: Disable port driver in compat mode
      PCI/portdrv: Remove pcie_port_bus_type link order dependency
      PCI/portdrv: Remove unused PCIE_PORT_SERVICE_VC
      PCI/portdrv: Simplify PCIe feature permission checking
      PCI/portdrv: Remove unnecessary include of <linux/pci-aspm.h>
      PCI/portdrv: Remove "pcie_hp=nomsi" kernel parameter


 Documentation/admin-guide/kernel-parameters.txt |    4 -
 drivers/acpi/pci_root.c                         |   13 +++-
 drivers/pci/pci-driver.c                        |   60 ++++++++++++++++++
 drivers/pci/pci.c                               |    9 +++
 drivers/pci/pci.h                               |    1 
 drivers/pci/pcie/Makefile                       |    3 -
 drivers/pci/pcie/portdrv.h                      |   27 --------
 drivers/pci/pcie/portdrv_acpi.c                 |    2 -
 drivers/pci/pcie/portdrv_bus.c                  |   56 -----------------
 drivers/pci/pcie/portdrv_core.c                 |   77 ++++++++++-------------
 drivers/pci/pcie/portdrv_pci.c                  |   40 +-----------
 drivers/pci/probe.c                             |   10 +++
 include/linux/pci.h                             |    3 +
 include/linux/pcieport_if.h                     |    4 -
 14 files changed, 131 insertions(+), 178 deletions(-)
 delete mode 100644 drivers/pci/pcie/portdrv_bus.c
