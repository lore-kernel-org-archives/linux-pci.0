Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from szxga02-in.huawei.com ([119.145.14.65]:21818 "EHLO
	szxga02-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755617AbaCNJjV (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Fri, 14 Mar 2014 05:39:21 -0400
From: Yijing Wang <wangyijing@huawei.com>
To: Bjorn Helgaas <bhelgaas@google.com>
CC: <linux-pci@vger.kernel.org>,
	"Rafael J. Wysocki" <rafael.j.wysocki@intel.com>,
	Yijing Wang <wangyijing@huawei.com>
Subject: [PATCH 2/2] PCI: Refactor pci_is_bridge()
Date: Fri, 14 Mar 2014 17:38:46 +0800
Message-ID: <1394789926-11912-1-git-send-email-wangyijing@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Refactor pci_is_bridge(), check pci device
hdr_type instead, and move it in include/linux/pci.h

Signed-off-by: Yijing Wang <wangyijing@huawei.com>
---
 include/linux/pci.h |    6 ++++++
 1 files changed, 6 insertions(+), 0 deletions(-)

diff --git a/include/linux/pci.h b/include/linux/pci.h
index 33aa2ca..22370c4 100644
--- a/include/linux/pci.h
+++ b/include/linux/pci.h
@@ -1649,6 +1649,12 @@ static inline bool pci_is_pcie(struct pci_dev *dev)
 	return pci_pcie_cap(dev);
 }
 
+static inline bool pci_is_bridge(struct pci_dev *dev)
+{
+	return dev->hdr_type == PCI_HEADER_TYPE_BRIDGE ||
+		dev->hdr_type == PCI_HEADER_TYPE_CARDBUS;
+}
+
 /**
  * pcie_caps_reg - get the PCIe Capabilities Register
  * @dev: PCI device
-- 
1.7.1


