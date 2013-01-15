Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from szxga02-in.huawei.com ([119.145.14.65]:4731 "EHLO
	szxga02-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750912Ab3AODOz (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Mon, 14 Jan 2013 22:14:55 -0500
From: Yijing Wang <wangyijing@huawei.com>
To: Bjorn Helgaas <bhelgaas@google.com>, Yu Zhao <yu.zhao@intel.com>
CC: Kenji Kaneshige <kaneshige.kenji@jp.fujitsu.com>,
	Scott Murray <scott@spiteful.org>,
	Yinghai Lu <yinghai@kernel.org>, <linux-pci@vger.kernel.org>,
	Hanjun Guo <guohanjun@huawei.com>, <jiang.liu@huawei.com>,
	Yijing Wang <wangyijing@huawei.com>
Subject: [PATCH -v3 2/7] PCI: Rename pci_enable_ari to pci_configure_ari
Date: Tue, 15 Jan 2013 11:12:17 +0800
Message-ID: <1358219542-16880-3-git-send-email-wangyijing@huawei.com>
In-Reply-To: <1358219542-16880-1-git-send-email-wangyijing@huawei.com>
References: <1358219542-16880-1-git-send-email-wangyijing@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

pci_enable_ari now support enable or disable ARI forwarding.
So rename pci_enable_ari() to pci_configure_ari for easy
understanding.

No functional change.

Signed-off-by: Yijing Wang <wangyijing@huawei.com>
---
 drivers/pci/pci.c   |    4 ++--
 drivers/pci/pci.h   |    2 +-
 drivers/pci/probe.c |    2 +-
 3 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/pci/pci.c b/drivers/pci/pci.c
index a17129f..d921900 100644
--- a/drivers/pci/pci.c
+++ b/drivers/pci/pci.c
@@ -2067,10 +2067,10 @@ void pci_free_cap_save_buffers(struct pci_dev *dev)
 }
 
 /**
- * pci_enable_ari - enable ARI forwarding if hardware support it
+ * pci_configure_ari - enable or disable ARI forwarding
  * @dev: the PCI device
  */
-void pci_enable_ari(struct pci_dev *dev)
+void pci_configure_ari(struct pci_dev *dev)
 {
 	u32 cap;
 	struct pci_dev *bridge;
diff --git a/drivers/pci/pci.h b/drivers/pci/pci.h
index e851829..19043cb 100644
--- a/drivers/pci/pci.h
+++ b/drivers/pci/pci.h
@@ -209,7 +209,7 @@ extern int __pci_read_base(struct pci_dev *dev, enum pci_bar_type type,
 extern int pci_resource_bar(struct pci_dev *dev, int resno,
 			    enum pci_bar_type *type);
 extern int pci_bus_add_child(struct pci_bus *bus);
-extern void pci_enable_ari(struct pci_dev *dev);
+extern void pci_configure_ari(struct pci_dev *dev);
 /**
  * pci_ari_enabled - query ARI forwarding status
  * @bus: the PCI bus
diff --git a/drivers/pci/probe.c b/drivers/pci/probe.c
index 6186f03..7b9e691 100644
--- a/drivers/pci/probe.c
+++ b/drivers/pci/probe.c
@@ -1286,7 +1286,7 @@ static void pci_init_capabilities(struct pci_dev *dev)
 	pci_vpd_pci22_init(dev);
 
 	/* Alternative Routing-ID Forwarding */
-	pci_enable_ari(dev);
+	pci_configure_ari(dev);
 
 	/* Single Root I/O Virtualization */
 	pci_iov_init(dev);
-- 
1.7.1


