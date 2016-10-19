Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mailout1.hostsharing.net ([83.223.95.204]:43761 "EHLO
        mailout1.hostsharing.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751352AbcJSOJ6 (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 19 Oct 2016 10:09:58 -0400
Message-Id: <dbe9c6490001a351fb63bca74e27a454ac13a300.1476875113.git.lukas@wunner.de>
In-Reply-To: <cover.1476875113.git.lukas@wunner.de>
References: <cover.1476875113.git.lukas@wunner.de>
From: Lukas Wunner <lukas@wunner.de>
Date: Wed, 19 Oct 2016 16:07:13 +0200
Subject: [PATCH 7/9] ACPI / hotplug / PCI: Use cached copy of
 PCI_EXP_SLTCAP_HPC bit
To: linux-pci@vger.kernel.org, linux-pm@vger.kernel.org,
        Bjorn Helgaas <bhelgaas@google.com>
Cc: Mika Westerberg <mika.westerberg@linux.intel.com>,
        "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>,
        Andreas Noever <andreas.noever@gmail.com>,
        Keith Busch <keith.busch@intel.com>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

We cache the PCI_EXP_SLTCAP_HPC bit in pci_dev->is_hotplug_bridge on
device probe, so there's no need to read it again when adding the ACPI
hotplug context.

Here's the call chain to prove that no ordering issue is introduced:

pci_scan_child_bus [drivers/pci/probe.c]
  pci_scan_slot
    pci_scan_single_device
      pci_scan_device
        pci_setup_device
          set_pcie_hotplug_bridge
            [is_hotplug_bridge bit is set here]
  pci_scan_bridge
    pci_add_new_bus
      pci_alloc_child_bus
        pcibios_add_bus  [arch/(x86|arm64|ia64)/...]
          acpi_pci_add_bus [drivers/pci/pci-acpi.c]
            acpiphp_enumerate_slots [drivers/pci/hotplug/acpiphp_glue.c]
              acpiphp_add_context
                device_is_managed_by_native_pciehp
                  [is_hotplug_bridge bit is queried here]

No functional change intended.

Cc: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
Signed-off-by: Lukas Wunner <lukas@wunner.de>
---
 drivers/pci/hotplug/acpiphp_glue.c | 5 +----
 1 file changed, 1 insertion(+), 4 deletions(-)

diff --git a/drivers/pci/hotplug/acpiphp_glue.c b/drivers/pci/hotplug/acpiphp_glue.c
index a46b585..b286a56 100644
--- a/drivers/pci/hotplug/acpiphp_glue.c
+++ b/drivers/pci/hotplug/acpiphp_glue.c
@@ -225,14 +225,11 @@ static void acpiphp_post_dock_fixup(struct acpi_device *adev)
 /* Check whether the PCI device is managed by native PCIe hotplug driver */
 static bool device_is_managed_by_native_pciehp(struct pci_dev *pdev)
 {
-	u32 reg32;
 	acpi_handle tmp;
 	struct acpi_pci_root *root;
 
 	/* Check whether the PCIe port supports native PCIe hotplug */
-	if (pcie_capability_read_dword(pdev, PCI_EXP_SLTCAP, &reg32))
-		return false;
-	if (!(reg32 & PCI_EXP_SLTCAP_HPC))
+	if (!pdev->is_hotplug_bridge)
 		return false;
 
 	/*
-- 
2.9.3

