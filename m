Return-Path: <linux-kernel-owner@vger.kernel.org>
From: Sinan Kaya <okaya@codeaurora.org>
To: linux-pci@vger.kernel.org, timur@codeaurora.org
Cc: mayurkumar.patel@intel.com, linux-arm-msm@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        Sinan Kaya <okaya@codeaurora.org>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Rajat Jain <rajatja@google.com>,
        David Daney <david.daney@cavium.com>,
        Yinghai Lu <yinghai@kernel.org>, linux-kernel@vger.kernel.org
Subject: [PATCH V6 5/5] PCI/ASPM: move link_state cleanup to bridge remove
Date: Wed, 29 Mar 2017 19:04:27 -0400
Message-Id: <1490828667-30973-6-git-send-email-okaya@codeaurora.org>
In-Reply-To: <1490828667-30973-1-git-send-email-okaya@codeaurora.org>
References: <1490828667-30973-1-git-send-email-okaya@codeaurora.org>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

For endpoints, change pcie_aspm_exit_link_state() so it cleans up
the device's own state and disables ASPM if necessary, but doesn't
remove the parent's link_state.

For bridges, change pcie_aspm_exit_link_state() so it frees the
bridge's own link_state.

Fixes: https://bugzilla.kernel.org/show_bug.cgi?id=194895
Signed-off-by: Sinan Kaya <okaya@codeaurora.org>
---
 drivers/pci/pcie/aspm.c | 20 +++++++++++++++-----
 drivers/pci/remove.c    |  3 +--
 2 files changed, 16 insertions(+), 7 deletions(-)

diff --git a/drivers/pci/pcie/aspm.c b/drivers/pci/pcie/aspm.c
index a38602a..37ca9b3 100644
--- a/drivers/pci/pcie/aspm.c
+++ b/drivers/pci/pcie/aspm.c
@@ -963,6 +963,21 @@ void pcie_aspm_exit_link_state(struct pci_dev *pdev)
 	if (!parent || !parent->link_state)
 		return;
 
+	if (pdev->has_secondary_link) {
+		link = pdev->link_state;
+		down_read(&pci_bus_sem);
+		mutex_lock(&aspm_lock);
+
+		list_del(&link->sibling);
+		list_del(&link->link);
+
+		/* Clock PM is for endpoint device */
+		free_link_state(link);
+		mutex_unlock(&aspm_lock);
+		up_read(&pci_bus_sem);
+		return;
+	}
+
 	down_read(&pci_bus_sem);
 	mutex_lock(&aspm_lock);
 	/*
@@ -978,11 +993,6 @@ void pcie_aspm_exit_link_state(struct pci_dev *pdev)
 
 	/* All functions are removed, so just disable ASPM for the link */
 	pcie_config_aspm_link(link, 0);
-	list_del(&link->sibling);
-	list_del(&link->link);
-	/* Clock PM is for endpoint device */
-	free_link_state(link);
-
 	/* Recheck latencies and configure upstream links */
 	if (parent_link) {
 		pcie_update_aspm_capable(root);
diff --git a/drivers/pci/remove.c b/drivers/pci/remove.c
index 73a03d3..7e14ebd 100644
--- a/drivers/pci/remove.c
+++ b/drivers/pci/remove.c
@@ -25,8 +25,7 @@ static void pci_stop_dev(struct pci_dev *dev)
 		dev->is_added = 0;
 	}
 
-	if (dev->bus->self)
-		pcie_aspm_exit_link_state(dev);
+	pcie_aspm_exit_link_state(dev);
 }
 
 static void pci_destroy_dev(struct pci_dev *dev)
-- 
1.9.1
