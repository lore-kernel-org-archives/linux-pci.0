Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from smtp.codeaurora.org ([198.145.29.96]:50408 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S933062AbdC3NbD (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 30 Mar 2017 09:31:03 -0400
From: Sinan Kaya <okaya@codeaurora.org>
To: linux-pci@vger.kernel.org, timur@codeaurora.org
Cc: mayurkumar.patel@intel.com, linux-arm-msm@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        Sinan Kaya <okaya@codeaurora.org>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Rajat Jain <rajatja@google.com>,
        Yinghai Lu <yinghai@kernel.org>,
        Julia Lawall <Julia.Lawall@lip6.fr>,
        David Daney <david.daney@cavium.com>,
        linux-kernel@vger.kernel.org
Subject: [PATCH V7 5/5] PCI/ASPM: move link_state cleanup to bridge remove
Date: Thu, 30 Mar 2017 09:30:36 -0400
Message-Id: <1490880636-30542-6-git-send-email-okaya@codeaurora.org>
In-Reply-To: <1490880636-30542-1-git-send-email-okaya@codeaurora.org>
References: <1490880636-30542-1-git-send-email-okaya@codeaurora.org>
Sender: linux-pci-owner@vger.kernel.org
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
index a38602a..e6fd297 100644
--- a/drivers/pci/pcie/aspm.c
+++ b/drivers/pci/pcie/aspm.c
@@ -960,6 +960,21 @@ void pcie_aspm_exit_link_state(struct pci_dev *pdev)
 	struct pci_dev *parent = pdev->bus->self;
 	struct pcie_link_state *link, *root, *parent_link;
 
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
 	if (!parent || !parent->link_state)
 		return;
 
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
