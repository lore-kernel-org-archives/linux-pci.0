Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.99]:47982 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S933509AbeFYW7z (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Mon, 25 Jun 2018 18:59:55 -0400
Subject: [PATCH v1 3/4] PCI: shpchp: Inline shpchp_is_native()
From: Bjorn Helgaas <helgaas@kernel.org>
To: linux-pci@vger.kernel.org
Cc: Marc Zyngier <marc.zyngier@arm.com>,
        Mika Westerberg <mika.westerberg@linux.intel.com>,
        linux-kernel@vger.kernel.org
Date: Mon, 25 Jun 2018 17:59:53 -0500
Message-ID: <152996759356.260522.17897676139260762555.stgit@bhelgaas-glaptop.roam.corp.google.com>
In-Reply-To: <152996746234.260522.11381067633352986554.stgit@bhelgaas-glaptop.roam.corp.google.com>
References: <152996746234.260522.11381067633352986554.stgit@bhelgaas-glaptop.roam.corp.google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

From: Bjorn Helgaas <bhelgaas@google.com>

shpchp_is_native() is trivial and has nothing to do with ACPI, so make it
an inline in pci_hotplug.h.

Signed-off-by: Bjorn Helgaas <bhelgaas@google.com>
---
 drivers/pci/pci-acpi.c      |   12 ------------
 include/linux/pci_hotplug.h |    8 ++++++--
 2 files changed, 6 insertions(+), 14 deletions(-)

diff --git a/drivers/pci/pci-acpi.c b/drivers/pci/pci-acpi.c
index 5100fd2d5a75..52b8434d4d6e 100644
--- a/drivers/pci/pci-acpi.c
+++ b/drivers/pci/pci-acpi.c
@@ -394,18 +394,6 @@ bool pciehp_is_native(struct pci_dev *bridge)
 	return host->native_pcie_hotplug;
 }
 
-/**
- * shpchp_is_native - Check whether a hotplug port is handled by the OS
- * @bridge: Hotplug port to check
- *
- * Returns true if the given @bridge is handled by the native SHPC hotplug
- * driver.
- */
-bool shpchp_is_native(struct pci_dev *bridge)
-{
-	return bridge->shpc_managed;
-}
-
 /**
  * pci_acpi_wake_bus - Root bus wakeup notification fork function.
  * @context: Device wakeup context.
diff --git a/include/linux/pci_hotplug.h b/include/linux/pci_hotplug.h
index cf5e22103f68..f08a44e1606f 100644
--- a/include/linux/pci_hotplug.h
+++ b/include/linux/pci_hotplug.h
@@ -162,11 +162,15 @@ struct hotplug_params {
 #ifdef CONFIG_ACPI
 #include <linux/acpi.h>
 int pci_get_hp_params(struct pci_dev *dev, struct hotplug_params *hpp);
-bool pciehp_is_native(struct pci_dev *bridge);
 int acpi_get_hp_hw_control_from_firmware(struct pci_dev *bridge);
-bool shpchp_is_native(struct pci_dev *bridge);
 int acpi_pci_check_ejectable(struct pci_bus *pbus, acpi_handle handle);
 int acpi_pci_detect_ejectable(acpi_handle handle);
+
+bool pciehp_is_native(struct pci_dev *bridge);
+static inline bool shpchp_is_native(struct pci_dev *bridge)
+{
+	return bridge->shpc_managed;
+}
 #else
 static inline int pci_get_hp_params(struct pci_dev *dev,
 				    struct hotplug_params *hpp)
