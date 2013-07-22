Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from aserp1040.oracle.com ([141.146.126.69]:21057 "EHLO
	aserp1040.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S933154Ab3GVVi0 (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Mon, 22 Jul 2013 17:38:26 -0400
From: Yinghai Lu <yinghai@kernel.org>
To: Bjorn Helgaas <bhelgaas@google.com>
Cc: linux-pci@vger.kernel.org, Yinghai Lu <yinghai@kernel.org>
Subject: [PATCH v6 7/7] PCI: Retry assign unassigned resources for hotadd root bus
Date: Mon, 22 Jul 2013 14:37:18 -0700
Message-Id: <1374529038-14311-8-git-send-email-yinghai@kernel.org>
In-Reply-To: <1374529038-14311-1-git-send-email-yinghai@kernel.org>
References: <1374529038-14311-1-git-send-email-yinghai@kernel.org>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Let root bus hotadd path use same code for booting path.
As driver is not loaded yet, we could retry to make sure
all pci devices get resources allocated.
We need this as during hotadd, firmware could assign some bars before
handle over.

Signed-off-by: Yinghai Lu <yinghai@kernel.org>
---
 drivers/acpi/pci_root.c |  2 +-
 drivers/pci/setup-bus.c | 15 +++++++--------
 include/linux/pci.h     |  1 +
 3 files changed, 9 insertions(+), 9 deletions(-)

diff --git a/drivers/acpi/pci_root.c b/drivers/acpi/pci_root.c
index faa1d29..ce04eb2 100644
--- a/drivers/acpi/pci_root.c
+++ b/drivers/acpi/pci_root.c
@@ -526,7 +526,7 @@ static int acpi_pci_root_add(struct acpi_device *device,
 
 	if (system_state != SYSTEM_BOOTING) {
 		pcibios_resource_survey_bus(root->bus);
-		pci_assign_unassigned_bus_resources(root->bus);
+		pci_assign_unassigned_root_bus_resources(root->bus);
 	}
 
 	pci_bus_add_devices(root->bus);
diff --git a/drivers/pci/setup-bus.c b/drivers/pci/setup-bus.c
index bd90cc1..4e60c44 100644
--- a/drivers/pci/setup-bus.c
+++ b/drivers/pci/setup-bus.c
@@ -1297,7 +1297,7 @@ static void pci_bus_dump_resources(struct pci_bus *bus)
 	}
 }
 
-static int __init pci_bus_get_depth(struct pci_bus *bus)
+static int pci_bus_get_depth(struct pci_bus *bus)
 {
 	int depth = 0;
 	struct pci_dev *dev;
@@ -1331,7 +1331,7 @@ enum enable_type {
 	auto_enabled,
 };
 
-static enum enable_type pci_realloc_enable __initdata = undefined;
+static enum enable_type pci_realloc_enable = undefined;
 void __init pci_realloc_get_opt(char *str)
 {
 	if (!strncmp(str, "off", 3))
@@ -1339,13 +1339,13 @@ void __init pci_realloc_get_opt(char *str)
 	else if (!strncmp(str, "on", 2))
 		pci_realloc_enable = user_enabled;
 }
-static bool __init pci_realloc_enabled(enum enable_type enable)
+static bool pci_realloc_enabled(enum enable_type enable)
 {
 	return enable >= user_enabled;
 }
 
 #if defined(CONFIG_PCI_IOV) && defined(CONFIG_PCI_REALLOC_ENABLE_AUTO)
-static int __init check_unassigned_resources(struct pci_dev *dev, void *data)
+static int check_unassigned_resources(struct pci_dev *dev, void *data)
 {
 	int i;
 	int *unassigned = data;
@@ -1368,7 +1368,7 @@ static int __init check_unassigned_resources(struct pci_dev *dev, void *data)
 	return 0;
 }
 
-static enum enable_type __init pci_realloc_detect(struct pci_bus *bus,
+static enum enable_type pci_realloc_detect(struct pci_bus *bus,
 			 enum enable_type enable_local)
 {
 	int unassigned = 0;
@@ -1383,7 +1383,7 @@ static enum enable_type __init pci_realloc_detect(struct pci_bus *bus,
 	return enable_local;
 }
 #else
-static enum enable_type __init pci_realloc_detect(struct pci_bus *bus,
+static enum enable_type pci_realloc_detect(struct pci_bus *bus,
 			 enum enable_type enable_local)
 {
 	return enable_local;
@@ -1395,8 +1395,7 @@ static enum enable_type __init pci_realloc_detect(struct pci_bus *bus,
  * second  and later try will clear small leaf bridge res
  * will stop till to the max  deepth if can not find good one
  */
-static void __init
-pci_assign_unassigned_root_bus_resources(struct pci_bus *bus)
+void pci_assign_unassigned_root_bus_resources(struct pci_bus *bus)
 {
 	LIST_HEAD(realloc_head); /* list of resources that
 					want additional resources */
diff --git a/include/linux/pci.h b/include/linux/pci.h
index 8cd1e6f..e494c90 100644
--- a/include/linux/pci.h
+++ b/include/linux/pci.h
@@ -1003,6 +1003,7 @@ int pci_claim_resource(struct pci_dev *, int);
 void pci_assign_unassigned_resources(void);
 void pci_assign_unassigned_bridge_resources(struct pci_dev *bridge);
 void pci_assign_unassigned_bus_resources(struct pci_bus *bus);
+void pci_assign_unassigned_root_bus_resources(struct pci_bus *bus);
 void pdev_enable_device(struct pci_dev *);
 int pci_enable_resources(struct pci_dev *, int mask);
 void pci_fixup_irqs(u8 (*)(struct pci_dev *, u8 *),
-- 
1.8.1.4

