Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from szxga01-in.huawei.com ([119.145.14.64]:45343 "EHLO
	szxga01-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752324Ab3HVD3T (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Wed, 21 Aug 2013 23:29:19 -0400
From: Yijing Wang <wangyijing@huawei.com>
To: Bjorn Helgaas <bhelgaas@google.com>
CC: Jon Mason <jdmason@kudzu.us>, <linux-pci@vger.kernel.org>,
	Hanjun Guo <guohanjun@huawei.com>, <jiang.liu@huawei.com>
Subject: [PATCH v8 4/6] PCI: Simplify MPS test for Downstream Port
Date: Thu, 22 Aug 2013 11:24:46 +0800
Message-ID: <1377141888-7000-5-git-send-email-wangyijing@huawei.com>
In-Reply-To: <1377141888-7000-1-git-send-email-wangyijing@huawei.com>
References: <1377141888-7000-1-git-send-email-wangyijing@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

From: Bjorn Helgaas <bhelgaas@google.com>

PCIe hotplug bridges are always either Root Ports or Downstream Ports.  No
other device type can have a PCIe link leading downstream to a slot.

Root Ports don't have an upstream bridge, so "dev->is_hotplug_bridge &&
dev->bus->self" is true if and only if "dev" is a Downstream Port.  That
means we can simplify this by looking at the type of "dev" itself, without
looking upstream at all.

No functional change.

Signed-off-by: Bjorn Helgaas <bhelgaas@google.com>
---
 drivers/pci/probe.c |    3 +--
 1 files changed, 1 insertions(+), 2 deletions(-)

diff --git a/drivers/pci/probe.c b/drivers/pci/probe.c
index 627cc88..87be31b 100644
--- a/drivers/pci/probe.c
+++ b/drivers/pci/probe.c
@@ -1507,8 +1507,7 @@ static int pcie_find_smpss(struct pci_dev *dev, void *data)
 	 * will occur as normal.
 	 */
 	if (dev->is_hotplug_bridge && (!list_is_singular(&dev->bus->devices) ||
-	     (dev->bus->self &&
-	      pci_pcie_type(dev->bus->self) != PCI_EXP_TYPE_ROOT_PORT)))
+	    pci_pcie_type(dev) != PCI_EXP_TYPE_ROOT_PORT))
 		*smpss = 0;
 
 	if (*smpss > dev->pcie_mpss)
-- 
1.7.1


