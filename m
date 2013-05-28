Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from szxga01-in.huawei.com ([119.145.14.64]:4403 "EHLO
	szxga01-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S933282Ab3E1IEW (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Tue, 28 May 2013 04:04:22 -0400
From: Yijing Wang <wangyijing@huawei.com>
To: Bjorn Helgaas <bhelgaas@google.com>
CC: <linux-pci@vger.kernel.org>, Hanjun Guo <guohanjun@huawei.com>,
	Jiang Liu <liuj97@gmail.com>,
	Yijing Wang <wangyijing@huawei.com>
Subject: [PATCH] PCI: fix trivial comment for __pci_disable_link_state
Date: Tue, 28 May 2013 16:03:22 +0800
Message-ID: <1369728202-31188-1-git-send-email-wangyijing@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Fix trivial comments for __pci_disble_link_state

Signed-off-by: Yijing Wang <wangyijing@huawei.com>
---
 drivers/pci/pcie/aspm.c |   10 ++++++----
 1 files changed, 6 insertions(+), 4 deletions(-)

diff --git a/drivers/pci/pcie/aspm.c b/drivers/pci/pcie/aspm.c
index faa83b6..c7fd56b 100644
--- a/drivers/pci/pcie/aspm.c
+++ b/drivers/pci/pcie/aspm.c
@@ -714,10 +714,6 @@ void pcie_aspm_powersave_config_link(struct pci_dev *pdev)
 	up_read(&pci_bus_sem);
 }
 
-/*
- * pci_disable_link_state - disable pci device's link state, so the link will
- * never enter specific states
- */
 static void __pci_disable_link_state(struct pci_dev *pdev, int state, bool sem,
 				     bool force)
 {
@@ -771,6 +767,12 @@ void pci_disable_link_state_locked(struct pci_dev *pdev, int state)
 }
 EXPORT_SYMBOL(pci_disable_link_state_locked);
 
+/**
+ * pci_disable_link_state - disable pci device's link state, so the link will
+ * never enter specific states
+ * @pdev: PCI device on the link.
+ * @state: ASPM link state to disable
+ */
 void pci_disable_link_state(struct pci_dev *pdev, int state)
 {
 	__pci_disable_link_state(pdev, state, true, false);
-- 
1.7.1


