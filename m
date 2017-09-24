Return-Path: <linux-kernel-owner@vger.kernel.org>
From: Sinan Kaya <okaya@codeaurora.org>
To: linux-pci@vger.kernel.org, timur@codeaurora.org,
        alex.williamson@redhat.com
Cc: linux-arm-msm@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        Sinan Kaya <okaya@codeaurora.org>,
        Bjorn Helgaas <bhelgaas@google.com>,
        linux-kernel@vger.kernel.org
Subject: [PATCH 5/5] PCI: add device wait after slot and bus reset
Date: Sat, 23 Sep 2017 20:16:58 -0400
Message-Id: <1506212218-29103-5-git-send-email-okaya@codeaurora.org>
In-Reply-To: <1506212218-29103-1-git-send-email-okaya@codeaurora.org>
References: <1506212218-29103-1-git-send-email-okaya@codeaurora.org>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Rev 3.1 Sec 2.3.1 Request Handling Rules indicates that a device can issue
CRS following secondary bus reset. Handle device presence gracefully.

Signed-off-by: Sinan Kaya <okaya@codeaurora.org>
---
 drivers/pci/pci.c | 9 +++++++--
 1 file changed, 7 insertions(+), 2 deletions(-)

diff --git a/drivers/pci/pci.c b/drivers/pci/pci.c
index 074adf9..7131aab 100644
--- a/drivers/pci/pci.c
+++ b/drivers/pci/pci.c
@@ -4056,7 +4056,7 @@ static int pci_parent_bus_reset(struct pci_dev *dev, int probe)
 
 	pci_reset_bridge_secondary_bus(dev->bus->self);
 
-	return 0;
+	return pci_dev_wait(dev, "bus reset", 1000, 60000);
 }
 
 static int pci_reset_hotplug_slot(struct hotplug_slot *hotplug, int probe)
@@ -4077,6 +4077,7 @@ static int pci_reset_hotplug_slot(struct hotplug_slot *hotplug, int probe)
 static int pci_dev_reset_slot_function(struct pci_dev *dev, int probe)
 {
 	struct pci_dev *pdev;
+	int rc;
 
 	if (dev->subordinate || !dev->slot ||
 	    dev->dev_flags & PCI_DEV_FLAGS_NO_BUS_RESET)
@@ -4086,7 +4087,11 @@ static int pci_dev_reset_slot_function(struct pci_dev *dev, int probe)
 		if (pdev != dev && pdev->slot == dev->slot)
 			return -ENOTTY;
 
-	return pci_reset_hotplug_slot(dev->slot->hotplug, probe);
+	rc = pci_reset_hotplug_slot(dev->slot->hotplug, probe);
+	if (!rc && !probe)
+		rc = pci_dev_wait(dev, "slot reset", 1000, 60000);
+
+	return rc;
 }
 
 static void pci_dev_lock(struct pci_dev *dev)
-- 
1.9.1
