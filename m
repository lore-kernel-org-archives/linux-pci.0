Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.99]:48024 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1753199AbeFYXAC (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Mon, 25 Jun 2018 19:00:02 -0400
Subject: [PATCH v1 4/4] PCI: hotplug: Implement hotplug_is_native() only
 when CONFIG_ACPI=y
From: Bjorn Helgaas <helgaas@kernel.org>
To: linux-pci@vger.kernel.org
Cc: Marc Zyngier <marc.zyngier@arm.com>,
        Mika Westerberg <mika.westerberg@linux.intel.com>,
        linux-kernel@vger.kernel.org
Date: Mon, 25 Jun 2018 18:00:00 -0500
Message-ID: <152996760010.260522.16627091342000868828.stgit@bhelgaas-glaptop.roam.corp.google.com>
In-Reply-To: <152996746234.260522.11381067633352986554.stgit@bhelgaas-glaptop.roam.corp.google.com>
References: <152996746234.260522.11381067633352986554.stgit@bhelgaas-glaptop.roam.corp.google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

From: Bjorn Helgaas <bhelgaas@google.com>

hotplug_is_native() is used only by the acpiphp driver, so we only need to
implement the interface when CONFIG_ACPI=y.

Move the implementation under #ifdef CONFIG_ACPI and drop the unnecessary
stubs for the non-ACPI case.

Signed-off-by: Bjorn Helgaas <bhelgaas@google.com>
---
 include/linux/pci_hotplug.h |   12 +++++-------
 1 file changed, 5 insertions(+), 7 deletions(-)

diff --git a/include/linux/pci_hotplug.h b/include/linux/pci_hotplug.h
index f08a44e1606f..09eb40299c37 100644
--- a/include/linux/pci_hotplug.h
+++ b/include/linux/pci_hotplug.h
@@ -9,7 +9,6 @@
  * All rights reserved.
  *
  * Send feedback to <kristen.c.accardi@intel.com>
- *
  */
 #ifndef _PCI_HOTPLUG_H
 #define _PCI_HOTPLUG_H
@@ -171,6 +170,11 @@ static inline bool shpchp_is_native(struct pci_dev *bridge)
 {
 	return bridge->shpc_managed;
 }
+
+static inline bool hotplug_is_native(struct pci_dev *bridge)
+{
+	return pciehp_is_native(bridge) || shpchp_is_native(bridge);
+}
 #else
 static inline int pci_get_hp_params(struct pci_dev *dev,
 				    struct hotplug_params *hpp)
@@ -182,12 +186,6 @@ static inline int acpi_get_hp_hw_control_from_firmware(struct pci_dev *bridge)
 {
 	return 0;
 }
-static inline bool pciehp_is_native(struct pci_dev *bridge) { return true; }
-static inline bool shpchp_is_native(struct pci_dev *bridge) { return true; }
 #endif
 
-static inline bool hotplug_is_native(struct pci_dev *bridge)
-{
-	return pciehp_is_native(bridge) || shpchp_is_native(bridge);
-}
 #endif
