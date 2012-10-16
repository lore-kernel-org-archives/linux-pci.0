Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from szxga01-in.huawei.com ([119.145.14.64]:55377 "EHLO
	szxga01-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754290Ab2JPHMN (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Tue, 16 Oct 2012 03:12:13 -0400
From: Yijing Wang <wangyijing@huawei.com>
To: Bjorn Helgaas <bhelgaas@google.com>, Yu Zhao <yu.zhao@intel.com>,
	<kernel.openeuler@huawei.com>
CC: <linux-pci@vger.kernel.org>, Yinghai Lu <yinghai@kernel.org>,
	Hanjun Guo <guohanjun@huawei.com>, <jiang.liu@huawei.com>,
	Yijing Wang <wangyijing@huawei.com>
Subject: [PATCH v2 1/3] PCI: rework pci_enable_ari for support disable ari forwarding
Date: Tue, 16 Oct 2012 15:10:18 +0800
Message-ID: <1350371420-7888-1-git-send-email-wangyijing@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

pci_enable_ari will be called if an ARI pci device found, set its bridge ARI Forwarding Enable
bit in Device Control 2 Register. But the bridge ARI Forwarding Enable bit will never be cleared
when an ARI device hot removed.
1. Hot add an ARI pci device;
2. Hot remove the ARI pci device;
3. Hot add an non ARI pci device;

In this case, we could only find fun 0 of non ARI pci device because of its bridge ARI Forwarding Enable
bit set.

As PCIe Spec 2.0(6.13/441) recommends:
"Following a hot-plug event below a Downstream Port, it is strongly recommended that software
Clear the ARI Forwarding Enable bit in the Downstream Port until software determines that a
newly added component is in fact an ARI Device"

So, this patch rework pci_enable_ari to support enable/disable ARI when a new device hot add.

Signed-off-by: Yijing Wang <wangyijing@huawei.com>
Signed-off-by: Jiang Liu <jiang.liu@huawei.com>
---
 drivers/pci/pci.c   |   21 +++++++++++++--------
 drivers/pci/pci.h   |    2 +-
 drivers/pci/probe.c |    2 +-
 3 files changed, 15 insertions(+), 10 deletions(-)

diff --git a/drivers/pci/pci.c b/drivers/pci/pci.c
index 5485883..38f1ad6 100644
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
+void pci_configure_ari(struct pci_dev *dev)
 {
 	u32 cap;
 	struct pci_dev *bridge;
@@ -2021,9 +2021,6 @@ void pci_enable_ari(struct pci_dev *dev)
 	if (pcie_ari_disabled || !pci_is_pcie(dev) || dev->devfn)
 		return;
 
-	if (!pci_find_ext_capability(dev, PCI_EXT_CAP_ID_ARI))
-		return;
-
 	bridge = dev->bus->self;
 	if (!bridge)
 		return;
@@ -2031,10 +2028,18 @@ void pci_enable_ari(struct pci_dev *dev)
 	pcie_capability_read_dword(bridge, PCI_EXP_DEVCAP2, &cap);
 	if (!(cap & PCI_EXP_DEVCAP2_ARI))
 		return;
-
-	pcie_capability_set_word(bridge, PCI_EXP_DEVCTL2, PCI_EXP_DEVCTL2_ARI);
-	bridge->ari_enabled = 1;
+
+	if (pci_find_ext_capability(dev, PCI_EXT_CAP_ID_ARI)) {
+		pcie_capability_set_word(bridge, PCI_EXP_DEVCTL2,
+				PCI_EXP_DEVCTL2_ARI);
+		bridge->ari_enabled = 1;
+	} else {
+		pcie_capability_clear_word(bridge, PCI_EXP_DEVCTL2,
+				PCI_EXP_DEVCTL2_ARI);
+		bridge->ari_enabled = 0;
+	}
 }
+EXPORT_SYMBOL(pci_configure_ari);
 
 /**
  * pci_enable_ido - enable ID-based Ordering on a device
diff --git a/drivers/pci/pci.h b/drivers/pci/pci.h
index bacbcba..d6eb3d9 100644
--- a/drivers/pci/pci.h
+++ b/drivers/pci/pci.h
@@ -211,7 +211,7 @@ extern int __pci_read_base(struct pci_dev *dev, enum pci_bar_type type,
 extern int pci_resource_bar(struct pci_dev *dev, int resno,
 			    enum pci_bar_type *type);
 extern int pci_bus_add_child(struct pci_bus *bus);
-extern void pci_enable_ari(struct pci_dev *dev);
+extern void pci_configure_ari(struct pci_dev *dev);
 /**
  * pci_ari_enabled - query ARI forwarding status
  * @bus: the PCI bus
diff --git a/drivers/pci/probe.c b/drivers/pci/probe.c
index ec909af..bb7ecf6 100644
--- a/drivers/pci/probe.c
+++ b/drivers/pci/probe.c
@@ -1282,7 +1282,7 @@ static void pci_init_capabilities(struct pci_dev *dev)
 	pci_vpd_pci22_init(dev);
 
 	/* Alternative Routing-ID Forwarding */
-	pci_enable_ari(dev);
+	pci_configure_ari(dev);
 
 	/* Single Root I/O Virtualization */
 	pci_iov_init(dev);
-- 
1.7.1


