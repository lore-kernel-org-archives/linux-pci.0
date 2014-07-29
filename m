Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from szxga02-in.huawei.com ([119.145.14.65]:10225 "EHLO
	szxga02-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750708AbaG2Hwg (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Tue, 29 Jul 2014 03:52:36 -0400
From: Yijing Wang <wangyijing@huawei.com>
To: Bjorn Helgaas <bhelgaas@google.com>
CC: <linux-pci@vger.kernel.org>, <Jordan_Hargrave@Dell.com>,
	<keith.busch@intel.com>, <jon.mason@intel.com>,
	Yijing Wang <wangyijing@huawei.com>,
	Jon Mason <jdmason@kudzu.us>
Subject: [PATCH] PCI: update device mps when doing pci hotplug
Date: Tue, 29 Jul 2014 16:17:57 +0800
Message-ID: <1406621877-12022-1-git-send-email-wangyijing@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Currently we don't update device's mps value when doing
pci device hot-add. The hot-added device's mps will be set
to default value (128B). But the upstream port device's mps
may be larger than 128B which was set by firmware during
system bootup. In this case the new added device may not
work normally. This issue was found in huawei 5885 server
and Dell R620 server. And if we run the platform with windows,
this problem is gone. This patch try to update the hot added
device mps equal to its parent mps, if device mpss < parent mps,
print warning.

References: https://bugzilla.kernel.org/show_bug.cgi?id=60671
Reported-by: Keith Busch <keith.busch@intel.com>
Reported-by: Jordan_Hargrave@Dell.com
Reported-by: Yijing Wang <wangyijing@huawei.com>
Signed-off-by: Yijing Wang <wangyijing@huawei.com>
Cc: Jon Mason <jdmason@kudzu.us>
---
 drivers/pci/probe.c |   39 +++++++++++++++++++++++++++++++++++++++
 1 files changed, 39 insertions(+), 0 deletions(-)

diff --git a/drivers/pci/probe.c b/drivers/pci/probe.c
index e3cf8a2..583ca52 100644
--- a/drivers/pci/probe.c
+++ b/drivers/pci/probe.c
@@ -1613,6 +1613,44 @@ static void pcie_write_mrrs(struct pci_dev *dev)
 		dev_err(&dev->dev, "MRRS was unable to be configured with a safe value.  If problems are experienced, try running with pci=pcie_bus_safe\n");
 }
 
+/**
+ * pcie_bus_update_set - update device mps when device doing hot-add
+ * @dev: PCI device to set
+ * 
+ * After device hot add, mps will be set to default(128B), But the 
+ * upstream port device's mps may be larger than 128B which was set 
+ * by firmware during system bootup. Then we should update the device
+ * mps to equal to its parent mps, Or the device can not work normally.
+ */
+static void pcie_bus_update_set(struct pci_dev *dev)
+{
+	int mps, p_mps, mpss;
+	struct pci_dev *parent;
+
+	if (!pci_is_pcie(dev) || !dev->bus->self 
+			|| !dev->bus->self->is_hotplug_bridge)
+		return;
+	
+	parent = dev->bus->self;
+	mps = pcie_get_mps(dev);
+	p_mps = pcie_get_mps(parent);
+
+	if (mps >= p_mps)
+		return;
+
+	mpss = 128 << dev->pcie_mpss;
+	if (mpss < p_mps) {
+		dev_warn(&dev->dev, "MPSS %d smaller than upstream MPS %d\n"
+				"If necessary, use \"pci=pcie_bus_safe\" boot parameter to avoid this problem\n",
+				mpss, p_mps);
+		return;
+	}
+
+	pcie_write_mps(dev, p_mps);
+	dev_info(&dev->dev, "Max Payload Size set to %4d/%4d (was %4d)\n", 
+			pcie_get_mps(dev), 128 << dev->pcie_mpss, mps);
+}
+
 static void pcie_bus_detect_mps(struct pci_dev *dev)
 {
 	struct pci_dev *bridge = dev->bus->self;
@@ -1637,6 +1675,7 @@ static int pcie_bus_configure_set(struct pci_dev *dev, void *data)
 		return 0;
 
 	if (pcie_bus_config == PCIE_BUS_TUNE_OFF) {
+		pcie_bus_update_set(dev);
 		pcie_bus_detect_mps(dev);
 		return 0;
 	}
-- 
1.7.1

