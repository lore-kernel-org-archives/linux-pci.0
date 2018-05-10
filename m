Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.99]:46110 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752608AbeEJVqS (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Thu, 10 May 2018 17:46:18 -0400
Subject: [PATCH] PCI/portdrv: Remove unused pcie_port_acpi_setup()
From: Bjorn Helgaas <helgaas@kernel.org>
To: linux-pci@vger.kernel.org
Cc: linux-kernel@vger.kernel.org
Date: Thu, 10 May 2018 16:46:15 -0500
Message-ID: <152598877588.228994.16423836714969302381.stgit@bhelgaas-glaptop.roam.corp.google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

From: Bjorn Helgaas <bhelgaas@google.com>

02bfeb484230 ("PCI/portdrv: Simplify PCIe feature permission checking")
removed the only call of pcie_port_acpi_setup() and removed portdrv_acpi.o
from the Makefile, but I forgot to remove pcie_port_acpi_setup() itself.

Remove pcie_port_acpi_setup() and the drivers/pci/pcie/portdrv_acpi.c file.

Signed-off-by: Bjorn Helgaas <bhelgaas@google.com>
---
 drivers/pci/pcie/portdrv_acpi.c |   57 ---------------------------------------
 1 file changed, 57 deletions(-)
 delete mode 100644 drivers/pci/pcie/portdrv_acpi.c

diff --git a/drivers/pci/pcie/portdrv_acpi.c b/drivers/pci/pcie/portdrv_acpi.c
deleted file mode 100644
index 8ab5d434b9c6..000000000000
--- a/drivers/pci/pcie/portdrv_acpi.c
+++ /dev/null
@@ -1,57 +0,0 @@
-// SPDX-License-Identifier: GPL-2.0
-/*
- * PCIe Port Native Services Support, ACPI-Related Part
- *
- * Copyright (C) 2010 Rafael J. Wysocki <rjw@sisk.pl>, Novell Inc.
- */
-
-#include <linux/pci.h>
-#include <linux/kernel.h>
-#include <linux/errno.h>
-#include <linux/acpi.h>
-#include <linux/pci-acpi.h>
-
-#include "aer/aerdrv.h"
-#include "../pci.h"
-#include "portdrv.h"
-
-/**
- * pcie_port_acpi_setup - Request the BIOS to release control of PCIe services.
- * @port: PCIe Port service for a root port or event collector.
- * @srv_mask: Bit mask of services that can be enabled for @port.
- *
- * Invoked when @port is identified as a PCIe port device.  To avoid conflicts
- * with the BIOS PCIe port native services support requires the BIOS to yield
- * control of these services to the kernel.  The mask of services that the BIOS
- * allows to be enabled for @port is written to @srv_mask.
- *
- * NOTE: It turns out that we cannot do that for individual port services
- * separately, because that would make some systems work incorrectly.
- */
-void pcie_port_acpi_setup(struct pci_dev *port, int *srv_mask)
-{
-	struct acpi_pci_root *root;
-	acpi_handle handle;
-	u32 flags;
-
-	if (acpi_pci_disabled)
-		return;
-
-	handle = acpi_find_root_bridge_handle(port);
-	if (!handle)
-		return;
-
-	root = acpi_pci_find_root(handle);
-	if (!root)
-		return;
-
-	flags = root->osc_control_set;
-
-	*srv_mask = 0;
-	if (flags & OSC_PCI_EXPRESS_NATIVE_HP_CONTROL)
-		*srv_mask |= PCIE_PORT_SERVICE_HP;
-	if (flags & OSC_PCI_EXPRESS_PME_CONTROL)
-		*srv_mask |= PCIE_PORT_SERVICE_PME;
-	if (flags & OSC_PCI_EXPRESS_AER_CONTROL)
-		*srv_mask |= PCIE_PORT_SERVICE_AER | PCIE_PORT_SERVICE_DPC;
-}
