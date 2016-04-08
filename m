Return-Path: <linux-acpi-owner@vger.kernel.org>
From: Jon Derrick <jonathan.derrick@intel.com>
To: Rafael Wysocki <rjw@rjwysocki.net>
Cc: Jon Derrick <jonathan.derrick@intel.com>,
	Bjorn Helgaas <helgaas@kernel.org>,
	Keith Busch <keith.busch@intel.com>,
	linux-acpi@vger.kernel.org, linux-pci@vger.kernel.org
Subject: [PATCH 0/2] Fixups for mixed pcie_ports=auto and native
Date: Fri,  8 Apr 2016 10:01:18 -0600
Message-Id: <1460131280-184287-1-git-send-email-jonathan.derrick@intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

This set introduces a fixup that lets non-acpi pcie ports subscribe to
native port services. The theory is that on an acpi system, native
services will require acpi to release control of the port instance.

Rather than failing on non-acpi devices, we should continue as if they
were native to begin with, and try to subscribe to native services just
the same.

Jon Derrick (2):
  PCI/ACPI: Do not fail ports without ACPI entries
  PCI/PCIe: Fixups for acpi port setup not being allowed to fail

 drivers/pci/pcie/portdrv.h      | 11 ++++-------
 drivers/pci/pcie/portdrv_acpi.c | 10 ++++------
 drivers/pci/pcie/portdrv_core.c |  8 ++------
 3 files changed, 10 insertions(+), 19 deletions(-)

-- 
1.8.3.1

