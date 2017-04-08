Return-Path: <linux-arm-kernel-bounces+bjorn=helgaas.com@lists.infradead.org>
Return-Path: <linux-arm-kernel-bounces+bjorn=helgaas.com@lists.infradead.org>
From: Sinan Kaya <okaya@codeaurora.org>
To: linux-pci@vger.kernel.org,
	timur@codeaurora.org
Subject: [PATCH V8 5/5] PCI/ASPM: move link_state cleanup to bridge remove
Date: Sat,  8 Apr 2017 00:55:51 -0400
Message-Id: <1491627351-1111-6-git-send-email-okaya@codeaurora.org>
In-Reply-To: <1491627351-1111-1-git-send-email-okaya@codeaurora.org>
References: <1491627351-1111-1-git-send-email-okaya@codeaurora.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Cc: mayurkumar.patel@intel.com, David Daney <david.daney@cavium.com>,
 linux-arm-msm@vger.kernel.org, Shawn Lin <shawn.lin@rock-chips.com>,
 linux-kernel@vger.kernel.org, Sinan Kaya <okaya@codeaurora.org>,
 Julia Lawall <Julia.Lawall@lip6.fr>, Bjorn Helgaas <bhelgaas@google.com>,
 Rajat Jain <rajatja@google.com>, Yinghai Lu <yinghai@kernel.org>,
 linux-arm-kernel@lists.infradead.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+bjorn=helgaas.com@lists.infradead.org
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
index c7da087..d99fa3f 100644
--- a/drivers/pci/pcie/aspm.c
+++ b/drivers/pci/pcie/aspm.c
@@ -972,6 +972,21 @@ void pcie_aspm_exit_link_state(struct pci_dev *pdev)
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
 
@@ -990,11 +1005,6 @@ void pcie_aspm_exit_link_state(struct pci_dev *pdev)
 
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


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
