Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from szxga01-in.huawei.com ([119.145.14.64]:65272 "EHLO
	szxga01-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750924Ab2JKMIt (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Thu, 11 Oct 2012 08:08:49 -0400
From: Yijing Wang <wangyijing@huawei.com>
To: Bjorn Helgaas <bhelgaas@google.com>,
	Jon Mason <jon.mason@intel.com>, Jon Mason <jdmason@kudzu.us>
CC: <linux-pci@vger.kernel.org>, Hanjun Guo <guohanjun@huawei.com>,
	<jiang.liu@huawei.com>, Yijing Wang <wangyijing@huawei.com>
Subject: [PATCH V2] PCI: print pcie max_payload_size default setting info to help diagnosis
Date: Thu, 11 Oct 2012 20:03:27 +0800
Message-ID: <1349957007-9920-1-git-send-email-wangyijing@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

PCIe device mps maybe not equal to its bridge mps after doing hotplug.
This may result unexpected problem like
http://marc.info/?l=linux-scsi&m=134788365823217&w=2. So add mps log for current
mps setting to help diagnosis an issue like this.

Signed-off-by: Yijing Wang <wangyijing@huawei.com>
---
 drivers/pci/probe.c |   29 +++++++++++++++++++++++++++++
 1 files changed, 29 insertions(+), 0 deletions(-)

diff --git a/drivers/pci/probe.c b/drivers/pci/probe.c
index ec909af..a31e615 100644
--- a/drivers/pci/probe.c
+++ b/drivers/pci/probe.c
@@ -1533,6 +1533,33 @@ static void pcie_write_mrrs(struct pci_dev *dev)
 			"with pci=pcie_bus_safe.\n");
 }
 
+static int pcie_mps_info(struct pci_dev *dev, void *data)
+{
+	int mps, mpss;
+
+	if (!pci_is_pcie(dev))
+		return -EINVAL;
+
+	mps = pcie_get_mps(dev);
+	mpss = 128 << dev->pcie_mpss;
+	dev_printk(KERN_DEBUG, &dev->dev, "PCI-E Max_Payload_Size Supported %d, "
+			"Max_Payload_Size %d\n", mpss, mps);
+
+	return 0;
+}
+
+static void pcie_dump_mps_info(struct pci_bus *bus)
+{
+	int mps, mpss;
+
+	mps = pcie_get_mps(bus->self);
+	mpss = 128 << bus->self->pcie_mpss;
+	dev_printk(KERN_DEBUG, &bus->self->dev, "PCI-E Max_Payload_Size Supported %d, "
+		"Max_Payload_Size %d\n", mpss, mps);
+
+	pci_walk_bus(bus, pcie_mps_info, NULL);
+}
+
 static int pcie_bus_configure_set(struct pci_dev *dev, void *data)
 {
 	int mps, orig_mps;
@@ -1564,6 +1591,8 @@ void pcie_bus_configure_settings(struct pci_bus *bus, u8 mpss)
 	if (!pci_is_pcie(bus->self))
 		return;
 
+	pcie_dump_mps_info(bus);
+
 	if (pcie_bus_config == PCIE_BUS_TUNE_OFF)
 		return;
 
-- 
1.7.1


