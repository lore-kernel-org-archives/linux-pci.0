Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from foss.arm.com ([217.140.101.70]:52430 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S933391AbeFUQrl (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Thu, 21 Jun 2018 12:47:41 -0400
From: Marc Zyngier <marc.zyngier@arm.com>
To: Bjorn Helgaas <bhelgaas@google.com>,
        Mika Westerberg <mika.westerberg@linux.intel.com>
Cc: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] PCI: shpchp: Fix probing logic inversion
Date: Thu, 21 Jun 2018 17:47:15 +0100
Message-Id: <20180621164715.28160-1-marc.zyngier@arm.com>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Until recently, shpc_probe() would bail out pretty early in the
absence of the SHPC capability. A logic change in the way the
driver now checks that capability makes it go and probe the
firmware anyway, with ugly consequences if the system is not
ACPI based (my arm64 ThunderX is DT driven, and explodes in
a spectacular way after getting a NULL root bridge from the
non-existent ACPI tables...).

Take this opportunity to move the call to shpchp_is_native()
back into shpc_probe(), making it clear that a non-ACPI system
is not expected to use this driver.

Fixes: 90cc0c3cc709 ("PCI: shpchp: Add shpchp_is_native()")
Signed-off-by: Marc Zyngier <marc.zyngier@arm.com>
---
 drivers/pci/hotplug/acpi_pcihp.c  | 3 ---
 drivers/pci/hotplug/shpchp_core.c | 3 ++-
 2 files changed, 2 insertions(+), 4 deletions(-)

diff --git a/drivers/pci/hotplug/acpi_pcihp.c b/drivers/pci/hotplug/acpi_pcihp.c
index 3979f89b250a..b57f29753a08 100644
--- a/drivers/pci/hotplug/acpi_pcihp.c
+++ b/drivers/pci/hotplug/acpi_pcihp.c
@@ -83,9 +83,6 @@ int acpi_get_hp_hw_control_from_firmware(struct pci_dev *pdev)
 	 * OSHP within the scope of the hotplug controller and its parents,
 	 * up to the host bridge under which this controller exists.
 	 */
-	if (shpchp_is_native(pdev))
-		return 0;
-
 	/* If _OSC exists, we should not evaluate OSHP */
 	host = pci_find_host_bridge(pdev->bus);
 	root = acpi_pci_find_root(ACPI_HANDLE(&host->dev));
diff --git a/drivers/pci/hotplug/shpchp_core.c b/drivers/pci/hotplug/shpchp_core.c
index e91be287f292..8902fe18a636 100644
--- a/drivers/pci/hotplug/shpchp_core.c
+++ b/drivers/pci/hotplug/shpchp_core.c
@@ -275,7 +275,8 @@ static int shpc_probe(struct pci_dev *pdev, const struct pci_device_id *ent)
 	int rc;
 	struct controller *ctrl;
 
-	if (acpi_get_hp_hw_control_from_firmware(pdev))
+	if (!shpchp_is_native(pdev) ||
+	    acpi_get_hp_hw_control_from_firmware(pdev))
 		return -ENODEV;
 
 	ctrl = kzalloc(sizeof(*ctrl), GFP_KERNEL);
-- 
2.17.1
