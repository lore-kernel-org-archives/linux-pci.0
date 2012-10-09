Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from szxga01-in.huawei.com ([119.145.14.64]:65438 "EHLO
	szxga01-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754517Ab2JIDEI (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Mon, 8 Oct 2012 23:04:08 -0400
From: Yijing Wang <wangyijing@huawei.com>
To: Bjorn Helgaas <bhelgaas@google.com>
CC: <jiang.liu@huawei.com>, Hanjun Guo <guohanjun@huawei.com>,
	<linux-pci@vger.kernel.org>, Yinghai Lu <yinghai@kernel.org>,
	Yijing Wang <wangyijing@huawei.com>
Subject: [PATCH 1/7] PCI: rework pci_enable_ari for support disable ari forwarding
Date: Tue, 9 Oct 2012 11:03:18 +0800
Message-ID: <1349751804-7476-2-git-send-email-wangyijing@huawei.com>
In-Reply-To: <1349751804-7476-1-git-send-email-wangyijing@huawei.com>
References: <1349751804-7476-1-git-send-email-wangyijing@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

pci_enable_ari will be called if an ARI pci device found, set its bridge ARI Forwarding Enable
bit in Device Control 2 Register. But the bridge ARI Forwarding Enable bit will never be cleared
when an ARI device hot removed.

As PCIe Spec 2.0(6.13/441) recommends:
"Following a hot-plug event below a Downstream Port, it is strongly recommended that software
Clear the ARI Forwarding Enable bit in the Downstream Port until software determines that a
newly added component is in fact an ARI Device"

So, this patch rework pci_enable_ari for support disable ari forwarding when a pci device
was hot removed.

Signed-off-by: Yijing Wang <wangyijing@huawei.com>
---
 drivers/pci/pci.c   |   16 +++++++++++-----
 drivers/pci/pci.h   |    2 +-
 drivers/pci/probe.c |    2 +-
 3 files changed, 13 insertions(+), 7 deletions(-)

diff --git a/drivers/pci/pci.c b/drivers/pci/pci.c
index 5485883..27f57d7 100644
--- a/drivers/pci/pci.c
+++ b/drivers/pci/pci.c
@@ -2010,10 +2010,10 @@ void pci_free_cap_save_buffers(struct pci_dev *dev)
 }
 
 /**
- * pci_enable_ari - enable ARI forwarding if hardware support it
+ * pci_configure_ari - enable or disable ARI forwarding if hardware support it
  * @dev: the PCI device
  */
-void pci_enable_ari(struct pci_dev *dev)
+void pci_configure_ari(struct pci_dev *dev, bool enable)
 {
 	u32 cap;
 	struct pci_dev *bridge;
@@ -2031,10 +2031,16 @@ void pci_enable_ari(struct pci_dev *dev)
 	pcie_capability_read_dword(bridge, PCI_EXP_DEVCAP2, &cap);
 	if (!(cap & PCI_EXP_DEVCAP2_ARI))
 		return;
-
-	pcie_capability_set_word(bridge, PCI_EXP_DEVCTL2, PCI_EXP_DEVCTL2_ARI);
-	bridge->ari_enabled = 1;
+	
+	if (enable) {
+		pcie_capability_set_word(bridge, PCI_EXP_DEVCTL2, PCI_EXP_DEVCTL2_ARI);
+		bridge->ari_enabled = 1;
+	} else {
+		pcie_capability_clear_word(bridge, PCI_EXP_DEVCTL2, PCI_EXP_DEVCTL2_ARI);
+		bridge->ari_enabled = 0;
+	}
 }
+EXPORT_SYMBOL(pci_configure_ari);
 
 /**
  * pci_enable_ido - enable ID-based Ordering on a device
diff --git a/drivers/pci/pci.h b/drivers/pci/pci.h
index bacbcba..3eb05d4 100644
--- a/drivers/pci/pci.h
+++ b/drivers/pci/pci.h
@@ -211,7 +211,7 @@ extern int __pci_read_base(struct pci_dev *dev, enum pci_bar_type type,
 extern int pci_resource_bar(struct pci_dev *dev, int resno,
 			    enum pci_bar_type *type);
 extern int pci_bus_add_child(struct pci_bus *bus);
-extern void pci_enable_ari(struct pci_dev *dev);
+extern void pci_configure_ari(struct pci_dev *dev, bool enable);
 /**
  * pci_ari_enabled - query ARI forwarding status
  * @bus: the PCI bus
diff --git a/drivers/pci/probe.c b/drivers/pci/probe.c
index ec909af..9d6deb6 100644
--- a/drivers/pci/probe.c
+++ b/drivers/pci/probe.c
@@ -1282,7 +1282,7 @@ static void pci_init_capabilities(struct pci_dev *dev)
 	pci_vpd_pci22_init(dev);
 
 	/* Alternative Routing-ID Forwarding */
-	pci_enable_ari(dev);
+	pci_configure_ari(dev, true);
 
 	/* Single Root I/O Virtualization */
 	pci_iov_init(dev);
-- 
1.7.1


