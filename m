Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from szxga01-in.huawei.com ([119.145.14.64]:55851 "EHLO
	szxga01-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750987Ab3HFHYS (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Tue, 6 Aug 2013 03:24:18 -0400
From: Yijing Wang <wangyijing@huawei.com>
To: Bjorn Helgaas <bhelgaas@google.com>
CC: <linux-pci@vger.kernel.org>, Hanjun Guo <guohanjun@huawei.com>,
	<jiang.liu@huawei.com>, Yijing Wang <wangyijing@huawei.com>,
	Jon Mason <jdmason@kudzu.us>, <stable@vger.kernel.org>
Subject: [PATCH -v2] PCI: update device mps when doing pci hotplug
Date: Tue, 6 Aug 2013 15:23:58 +0800
Message-ID: <1375773838-33572-1-git-send-email-wangyijing@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

v1->v2: Update patch log, remove Joe's reported-by, because his problem
        was mainly caused by BIOS incorrect setting. But this patch mainly
		to fix the bug caused by device hot add. Conservatively, this 
		version only update the mps problem when hot add. When the device
		mps < parent mps found, this patch try to update device mps.
		It seems unlikely device mps > parent mps after hot add device.
		So we don't care that situation.

This patch need to be applied to stable 3.4+

Currently we don't update device's mps vaule when doing
pci device hot-add. The hot-added device's mps will be set
to default value (128B). But the upstream port device's mps
may be larger than 128B which was set by firmware during
system bootup. In this case the new added device may not
work normally. This patch try to update the hot added device
mps euqal to its parent mps, if device mpss < parent mps,
print warning.

References: https://bugzilla.kernel.org/show_bug.cgi?id=60671
Reported-by: Yijing Wang <wangyijing@huawei.com>
Signed-off-by: Yijing Wang <wangyijing@huawei.com>
Cc: Jon Mason <jdmason@kudzu.us>
Cc: stable@vger.kernel.org
---
 drivers/pci/probe.c |   43 +++++++++++++++++++++++++++++++++++++++++++
 1 files changed, 43 insertions(+), 0 deletions(-)

diff --git a/drivers/pci/probe.c b/drivers/pci/probe.c
index cf57fe7..9b0e634 100644
--- a/drivers/pci/probe.c
+++ b/drivers/pci/probe.c
@@ -1603,6 +1603,40 @@ static int pcie_bus_configure_set(struct pci_dev *dev, void *data)
 	return 0;
 }
 
+static int pcie_bus_update_set(struct pci_dev *dev, void *data)
+{
+	int mps, p_mps;
+
+	if (!pci_is_pcie(dev) || !dev->bus->self)
+		return 0;
+
+	mps = pcie_get_mps(dev);
+	p_mps = pcie_get_mps(dev->bus->self);
+
+	if (mps < p_mps)
+		goto update;
+
+	return 0;
+
+update:
+	/* If current mpss is lager than upstream, use upstream mps to update
+	 * current mps, otherwise print warning info.
+	 */
+	if ((128 << dev->pcie_mpss) >= p_mps)
+		pcie_write_mps(dev, p_mps);
+	else
+		dev_warn(&dev->dev, "MPS %d MPSS %d both smaller than upstream MPS %d\n"
+				"If necessary, use \"pci=pcie_bus_peer2peer\" boot parameter to avoid this problem\n",
+				mps, 128 << dev->pcie_mpss, p_mps);
+	return 0;
+}
+
+static void pcie_bus_update_setting(struct pci_bus *bus)
+{
+	if (bus->self->is_hotplug_bridge)
+		pci_walk_bus(bus, pcie_bus_update_set, NULL);
+}
+
 /* pcie_bus_configure_settings requires that pci_walk_bus work in a top-down,
  * parents then children fashion.  If this changes, then this code will not
  * work as designed.
@@ -1614,6 +1648,15 @@ void pcie_bus_configure_settings(struct pci_bus *bus, u8 mpss)
 	if (!pci_is_pcie(bus->self))
 		return;
 
+	/* Sometimes we should update device mps here,
+	 * eg. after hot add, device mps value will be
+	 * set to default(128B), but the upstream port
+	 * mps value may be larger than 128B, if we do
+	 * not update the device mps, it maybe can not
+	 * work normally.
+	 */
+	pcie_bus_update_setting(bus);
+
 	if (pcie_bus_config == PCIE_BUS_TUNE_OFF)
 		return;
 
-- 
1.7.1


