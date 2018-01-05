Return-Path: <SRS0=UQ06=EA=amd.com=Felix.Kuehling@kernel.org>
Return-Path: <SRS0=UQ06=EA=amd.com=Felix.Kuehling@kernel.org>
From: Felix Kuehling <Felix.Kuehling@amd.com>
To: linux-pci@vger.kernel.org,
	helgaas@kernel.org
Cc: oded.gabbay@gmail.com,
	Jay.Cornwall@amd.com,
	Felix Kuehling <Felix.Kuehling@amd.com>,
	Ram Amrani <Ram.Amrani@cavium.com>,
	Doug Ledford <dledford@redhat.com>
Subject: [PATCH 2/2] RDMA/qedr: Use pci_enable_atomic_ops_to_root
Date: Thu,  4 Jan 2018 19:45:00 -0500
Message-Id: <1515113100-4718-2-git-send-email-Felix.Kuehling@amd.com>
In-Reply-To: <1515113100-4718-1-git-send-email-Felix.Kuehling@amd.com>
References: <1515113100-4718-1-git-send-email-Felix.Kuehling@amd.com>
MIME-Version: 1.0
Content-Type: text/plain
List-ID: <linux-pci.vger.kernel.org>

Use common helper function pci_enable_atomic_ops_to_root to enable
atomic capability.

CC: Bjorn Helgaas <helgaas@kernel.org>
CC: Ram Amrani <Ram.Amrani@cavium.com>
CC: Doug Ledford <dledford@redhat.com>
Signed-off-by: Felix Kuehling <Felix.Kuehling@amd.com>
---
 drivers/infiniband/hw/qedr/main.c | 59 ++++++---------------------------------
 1 file changed, 8 insertions(+), 51 deletions(-)

diff --git a/drivers/infiniband/hw/qedr/main.c b/drivers/infiniband/hw/qedr/main.c
index 50812b3..b378647 100644
--- a/drivers/infiniband/hw/qedr/main.c
+++ b/drivers/infiniband/hw/qedr/main.c
@@ -430,59 +430,16 @@ static void qedr_remove_sysfiles(struct qedr_dev *dev)
 
 static void qedr_pci_set_atomic(struct qedr_dev *dev, struct pci_dev *pdev)
 {
-	struct pci_dev *bridge;
-	u32 ctl2, cap2;
-	u16 flags;
-	int rc;
-
-	bridge = pdev->bus->self;
-	if (!bridge)
-		goto disable;
-
-	/* Check atomic routing support all the way to root complex */
-	while (bridge->bus->parent) {
-		rc = pcie_capability_read_word(bridge, PCI_EXP_FLAGS, &flags);
-		if (rc || ((flags & PCI_EXP_FLAGS_VERS) < 2))
-			goto disable;
-
-		rc = pcie_capability_read_dword(bridge, PCI_EXP_DEVCAP2, &cap2);
-		if (rc)
-			goto disable;
+	int rc = pci_enable_atomic_ops_to_root(pdev,
+					       PCI_EXP_DEVCAP2_ATOMIC_COMP64);
 
-		rc = pcie_capability_read_dword(bridge, PCI_EXP_DEVCTL2, &ctl2);
-		if (rc)
-			goto disable;
-
-		if (!(cap2 & PCI_EXP_DEVCAP2_ATOMIC_ROUTE) ||
-		    (ctl2 & PCI_EXP_DEVCTL2_ATOMIC_EGRESS_BLOCK))
-			goto disable;
-		bridge = bridge->bus->parent->self;
+	if (rc) {
+		dev->atomic_cap = IB_ATOMIC_NONE;
+		DP_DEBUG(dev, QEDR_MSG_INIT, "Atomic capability disabled\n");
+	} else {
+		dev->atomic_cap = IB_ATOMIC_GLOB;
+		DP_DEBUG(dev, QEDR_MSG_INIT, "Atomic capability enabled\n");
 	}
-
-	rc = pcie_capability_read_word(bridge, PCI_EXP_FLAGS, &flags);
-	if (rc || ((flags & PCI_EXP_FLAGS_VERS) < 2))
-		goto disable;
-
-	rc = pcie_capability_read_dword(bridge, PCI_EXP_DEVCAP2, &cap2);
-	if (rc || !(cap2 & PCI_EXP_DEVCAP2_ATOMIC_COMP64))
-		goto disable;
-
-	/* Set atomic operations */
-	pcie_capability_set_word(pdev, PCI_EXP_DEVCTL2,
-				 PCI_EXP_DEVCTL2_ATOMIC_REQ);
-	dev->atomic_cap = IB_ATOMIC_GLOB;
-
-	DP_DEBUG(dev, QEDR_MSG_INIT, "Atomic capability enabled\n");
-
-	return;
-
-disable:
-	pcie_capability_clear_word(pdev, PCI_EXP_DEVCTL2,
-				   PCI_EXP_DEVCTL2_ATOMIC_REQ);
-	dev->atomic_cap = IB_ATOMIC_NONE;
-
-	DP_DEBUG(dev, QEDR_MSG_INIT, "Atomic capability disabled\n");
-
 }
 
 static const struct qed_rdma_ops *qed_ops;
-- 
2.7.4
