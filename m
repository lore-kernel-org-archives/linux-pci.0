Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from [119.145.14.66] ([119.145.14.66]:28380 "EHLO
	szxga03-in.huawei.com" rhost-flags-FAIL-FAIL-OK-OK) by vger.kernel.org
	with ESMTP id S932189AbbDWHqC (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Thu, 23 Apr 2015 03:46:02 -0400
From: Yijing Wang <wangyijing@huawei.com>
To: <bhelgaas@google.com>
CC: <linux-pci@vger.kernel.org>, <mjg59@coreos.com>,
	<rwhite@pobox.com>, Yijing Wang <wangyijing@huawei.com>
Subject: [PATCH] PCI: Fix NULL pointer when find parent pcie_link_state
Date: Thu, 23 Apr 2015 15:41:56 +0800
Message-ID: <1429774916-24920-1-git-send-email-wangyijing@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

https://bugzilla.kernel.org/show_bug.cgi?id=94361 reported
NULL Pointer in pcie_aspm_init_link_state(), Some platform
like ATCA may has strange PCIe topology:
E.g.
---root port---downstream port---upstream port
                              |--downstream port
                              |--downstream port

When we try to alloc pcie_link_state, we assumed downstream port
always has a upstream port, in this case, NULL pointer would
be triggered when try to find the parent pci_link_state,
because downstream port connects to root port directly.

Signed-off-by: Yijing Wang <wangyijing@huawei.com>
---
 drivers/pci/pcie/aspm.c |   13 +++++++++++--
 1 files changed, 11 insertions(+), 2 deletions(-)

diff --git a/drivers/pci/pcie/aspm.c b/drivers/pci/pcie/aspm.c
index 7d4fcdc..f295824 100644
--- a/drivers/pci/pcie/aspm.c
+++ b/drivers/pci/pcie/aspm.c
@@ -526,8 +526,17 @@ static struct pcie_link_state *alloc_pcie_link_state(struct pci_dev *pdev)
 	INIT_LIST_HEAD(&link->link);
 	link->pdev = pdev;
 	if (pci_pcie_type(pdev) == PCI_EXP_TYPE_DOWNSTREAM) {
-		struct pcie_link_state *parent;
-		parent = pdev->bus->parent->self->link_state;
+		struct pci_bus *pbus = pdev->bus;
+		struct pcie_link_state *parent = NULL;
+
+		while (pbus) {
+			if (pbus->self) {
+				parent = pbus->self->link_state;
+				if (parent)
+					break;
+			}
+			pbus = pbus->parent;
+		}
 		if (!parent) {
 			kfree(link);
 			return NULL;
-- 
1.7.1

