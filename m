Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from szxga02-in.huawei.com ([119.145.14.65]:5447 "EHLO
	szxga02-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754869Ab3AODPl (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Mon, 14 Jan 2013 22:15:41 -0500
From: Yijing Wang <wangyijing@huawei.com>
To: Bjorn Helgaas <bhelgaas@google.com>, Yu Zhao <yu.zhao@intel.com>
CC: Kenji Kaneshige <kaneshige.kenji@jp.fujitsu.com>,
	Scott Murray <scott@spiteful.org>,
	Yinghai Lu <yinghai@kernel.org>, <linux-pci@vger.kernel.org>,
	Hanjun Guo <guohanjun@huawei.com>, <jiang.liu@huawei.com>,
	Yijing Wang <wangyijing@huawei.com>
Subject: [PATCH -v3 1/7] PCI: rework pci_enable_ari to support disable ari forwarding
Date: Tue, 15 Jan 2013 11:12:16 +0800
Message-ID: <1358219542-16880-2-git-send-email-wangyijing@huawei.com>
In-Reply-To: <1358219542-16880-1-git-send-email-wangyijing@huawei.com>
References: <1358219542-16880-1-git-send-email-wangyijing@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

pci_enable_ari will set the pci bridge ARI Forwarding Enable bit in Device
Control 2 Register when a ARI pcie device connected found. But the bridge ARI
Forwarding Enable bit will never be cleared when the ARI device hot removed.

As PCIe Spec 2.0(6.13/441) recommends:
"Following a hot-plug event below a Downstream Port, it is strongly recommended
that software Clear the ARI Forwarding Enable bit in the Downstream Port until
software determines that a newly added component is in fact an ARI Device"

This patch rework pci_enable_ari to support disable ARI Forwarding whenever found
the new pci device is a non-ari device.

Signed-off-by: Yijing Wang <wangyijing@huawei.com>
Signed-off-by: Jiang Liu <jiang.liu@huawei.com>
---
 drivers/pci/pci.c |   16 ++++++++++------
 1 files changed, 10 insertions(+), 6 deletions(-)

diff --git a/drivers/pci/pci.c b/drivers/pci/pci.c
index 5cb5820..a17129f 100644
--- a/drivers/pci/pci.c
+++ b/drivers/pci/pci.c
@@ -2078,9 +2078,6 @@ void pci_enable_ari(struct pci_dev *dev)
 	if (pcie_ari_disabled || !pci_is_pcie(dev) || dev->devfn)
 		return;
 
-	if (!pci_find_ext_capability(dev, PCI_EXT_CAP_ID_ARI))
-		return;
-
 	bridge = dev->bus->self;
 	if (!bridge)
 		return;
@@ -2088,9 +2085,16 @@ void pci_enable_ari(struct pci_dev *dev)
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
 
 /**
-- 
1.7.1


