Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from szxga03-in.huawei.com ([119.145.14.66]:33337 "EHLO
	szxga03-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755543AbaCNJft (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Fri, 14 Mar 2014 05:35:49 -0400
From: Yijing Wang <wangyijing@huawei.com>
To: Bjorn Helgaas <bhelgaas@google.com>
CC: <linux-pci@vger.kernel.org>,
	"Rafael J. Wysocki" <rafael.j.wysocki@intel.com>,
	Yijing Wang <wangyijing@huawei.com>
Subject: [PATCH 1/3] PCI: rename pci_is_bridge() to pci_has_subordinate()
Date: Fri, 14 Mar 2014 17:34:38 +0800
Message-ID: <1394789678-2204-1-git-send-email-wangyijing@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

pci_is_bridge() return true only when the device subordinate
is not equal to NULL. This confuses people. PCI device is a
bridge means header type(bit 0 through 6) is 0x1(PCI bridge) or 
0x2(CardBus bridge).

Signed-off-by: Yijing Wang <wangyijing@huawei.com>
---
 drivers/pci/pci-acpi.c   |    5 -----
 drivers/pci/pci-driver.c |    8 ++++----
 drivers/pci/pci.h        |    2 +-
 3 files changed, 5 insertions(+), 10 deletions(-)

diff --git a/drivers/pci/pci-acpi.c b/drivers/pci/pci-acpi.c
index f49abef..4bc7971 100644
--- a/drivers/pci/pci-acpi.c
+++ b/drivers/pci/pci-acpi.c
@@ -309,11 +309,6 @@ static struct acpi_device *acpi_pci_find_companion(struct device *dev)
 	bool check_children;
 	u64 addr;
 
-	/*
-	 * pci_is_bridge() is not suitable here, because pci_dev->subordinate
-	 * is set only after acpi_pci_find_device() has been called for the
-	 * given device.
-	 */
 	check_children = pci_dev->hdr_type == PCI_HEADER_TYPE_BRIDGE
 			|| pci_dev->hdr_type == PCI_HEADER_TYPE_CARDBUS;
 	/* Please ref to ACPI spec for the syntax of _ADR */
diff --git a/drivers/pci/pci-driver.c b/drivers/pci/pci-driver.c
index 25f0bc6..019dcb2 100644
--- a/drivers/pci/pci-driver.c
+++ b/drivers/pci/pci-driver.c
@@ -580,14 +580,14 @@ static void pci_pm_default_resume(struct pci_dev *pci_dev)
 {
 	pci_fixup_device(pci_fixup_resume, pci_dev);
 
-	if (!pci_is_bridge(pci_dev))
+	if (!pci_has_subordinate(pci_dev))
 		pci_enable_wake(pci_dev, PCI_D0, false);
 }
 
 static void pci_pm_default_suspend(struct pci_dev *pci_dev)
 {
 	/* Disable non-bridge devices without PM support */
-	if (!pci_is_bridge(pci_dev))
+	if (!pci_has_subordinate(pci_dev))
 		pci_disable_enabled_device(pci_dev);
 }
 
@@ -711,7 +711,7 @@ static int pci_pm_suspend_noirq(struct device *dev)
 
 	if (!pci_dev->state_saved) {
 		pci_save_state(pci_dev);
-		if (!pci_is_bridge(pci_dev))
+		if (!pci_has_subordinate(pci_dev))
 			pci_prepare_to_sleep(pci_dev);
 	}
 
@@ -954,7 +954,7 @@ static int pci_pm_poweroff_noirq(struct device *dev)
 			return error;
 	}
 
-	if (!pci_dev->state_saved && !pci_is_bridge(pci_dev))
+	if (!pci_dev->state_saved && !pci_has_subordinate(pci_dev))
 		pci_prepare_to_sleep(pci_dev);
 
 	/*
diff --git a/drivers/pci/pci.h b/drivers/pci/pci.h
index 4df38df..a3b9cc1 100644
--- a/drivers/pci/pci.h
+++ b/drivers/pci/pci.h
@@ -79,7 +79,7 @@ static inline void pci_wakeup_event(struct pci_dev *dev)
 	pm_wakeup_event(&dev->dev, 100);
 }
 
-static inline bool pci_is_bridge(struct pci_dev *pci_dev)
+static inline bool pci_has_subordinate(struct pci_dev *pci_dev)
 {
 	return !!(pci_dev->subordinate);
 }
-- 
1.7.1


