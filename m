Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.99]:47876 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S932253AbeFYW7m (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Mon, 25 Jun 2018 18:59:42 -0400
Subject: [PATCH v1 1/4] PCI: shpchp: Manage SHPC unconditionally on non-ACPI
 systems
From: Bjorn Helgaas <helgaas@kernel.org>
To: linux-pci@vger.kernel.org
Cc: Marc Zyngier <marc.zyngier@arm.com>,
        Mika Westerberg <mika.westerberg@linux.intel.com>,
        linux-kernel@vger.kernel.org
Date: Mon, 25 Jun 2018 17:59:40 -0500
Message-ID: <152996758037.260522.6880919949506497973.stgit@bhelgaas-glaptop.roam.corp.google.com>
In-Reply-To: <152996746234.260522.11381067633352986554.stgit@bhelgaas-glaptop.roam.corp.google.com>
References: <152996746234.260522.11381067633352986554.stgit@bhelgaas-glaptop.roam.corp.google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

From: Bjorn Helgaas <bhelgaas@google.com>

If acpi_pci_find_root() returns NULL, it means there's no ACPI host bridge
device (PNP0A03 or PNP0A08), and the OS is always allowed to manage the
SHPC, so return success in that case.

This fixes a NULL pointer dereference when CONFIG_ACPI=y but the current
hardware/firmware platform doesn't support ACPI.  In that case,
acpi_get_hp_hw_control_from_firmware() is implemented but
acpi_pci_find_root() returns NULL.

Fixes: 90cc0c3cc709 ("PCI: shpchp: Add shpchp_is_native()")
Link: https://lkml.kernel.org/r/20180621164715.28160-1-marc.zyngier@arm.com
Reported-by: Marc Zyngier <marc.zyngier@arm.com>
Signed-off-by: Bjorn Helgaas <bhelgaas@google.com>
---
 drivers/pci/hotplug/acpi_pcihp.c |   10 +++++++++-
 1 file changed, 9 insertions(+), 1 deletion(-)

diff --git a/drivers/pci/hotplug/acpi_pcihp.c b/drivers/pci/hotplug/acpi_pcihp.c
index 3979f89b250a..5bd6c1573295 100644
--- a/drivers/pci/hotplug/acpi_pcihp.c
+++ b/drivers/pci/hotplug/acpi_pcihp.c
@@ -7,7 +7,6 @@
  * All rights reserved.
  *
  * Send feedback to <kristen.c.accardi@intel.com>
- *
  */
 
 #include <linux/module.h>
@@ -87,8 +86,17 @@ int acpi_get_hp_hw_control_from_firmware(struct pci_dev *pdev)
 		return 0;
 
 	/* If _OSC exists, we should not evaluate OSHP */
+
+	/*
+	 * If there's no ACPI host bridge (i.e., ACPI support is compiled
+	 * into the kernel but the hardware platform doesn't support ACPI),
+	 * there's nothing to do here.
+	 */
 	host = pci_find_host_bridge(pdev->bus);
 	root = acpi_pci_find_root(ACPI_HANDLE(&host->dev));
+	if (!root)
+		return 0;
+
 	if (root->osc_support_set)
 		goto no_control;
 
