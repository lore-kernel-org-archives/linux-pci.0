Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from szxga01-in.huawei.com ([119.145.14.64]:19029 "EHLO
	szxga01-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754938Ab3HEI4E (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Mon, 5 Aug 2013 04:56:04 -0400
From: Yijing Wang <wangyijing@huawei.com>
To: Bjorn Helgaas <bhelgaas@google.com>
CC: <linux-pci@vger.kernel.org>, Rafael <rjw@sisk.pl>,
	Oliver Neukum <oneukum@suse.de>,
	Gu Zheng <guz.fnst@cn.fujitsu.com>,
	Paul Bolle <pebolle@tiscali.nl>,
	Hanjun Guo <guohanjun@huawei.com>, <jiang.liu@huawei.com>,
	Yijing Wang <wangyijing@huawei.com>
Subject: [PATCH -v5 2/6] PCI: introduce PCIe Device Serial Number Capability support
Date: Mon, 5 Aug 2013 16:54:54 +0800
Message-ID: <1375692898-27476-3-git-send-email-wangyijing@huawei.com>
In-Reply-To: <1375692898-27476-1-git-send-email-wangyijing@huawei.com>
References: <1375692898-27476-1-git-send-email-wangyijing@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Introduce PCIe Ext Capability Device Serial Number support,
so we can use the unique device serial number to identify
the physical device. During system suspend, if the PCIe
device was removed and reinserted a new same device, during
system resume there is no good way to identify it, maybe
Device Serial Number is a good choice if device support.

Reviewed-by: Gu Zheng <guz.fnst@cn.fujitsu.com>
Signed-off-by: Yijing Wang <wangyijing@huawei.com>
Cc: Paul Bolle <pebolle@tiscali.nl>
Cc: "Rafael J. Wysocki" <rjw@sisk.pl>
Cc: Oliver Neukum <oneukum@suse.de>
Cc: Gu Zheng <guz.fnst@cn.fujitsu.com>
Cc: linux-pci@vger.kernel.org
---
 drivers/pci/pci.c   |   29 +++++++++++++++++++++++++++++
 drivers/pci/pci.h   |    2 +-
 drivers/pci/probe.c |    2 ++
 include/linux/pci.h |    1 +
 4 files changed, 33 insertions(+), 1 deletions(-)

diff --git a/drivers/pci/pci.c b/drivers/pci/pci.c
index 84a3c09..cfc0f7f 100644
--- a/drivers/pci/pci.c
+++ b/drivers/pci/pci.c
@@ -2048,6 +2048,35 @@ void pci_free_cap_save_buffers(struct pci_dev *dev)
 }
 
 /**
+ * pci_device_serial_number - get device serial number
+ * @dev: the PCI device
+ *
+ * return the device serial number if device support,
+ * otherwise return 0.
+ */
+static u64 pci_device_serial_number(struct pci_dev *dev)
+{
+	int pos;
+	u32 lo, hi;
+
+	if (!pci_is_pcie(dev))
+		return 0;
+
+	pos = pci_find_ext_capability(dev, PCI_EXT_CAP_ID_DSN);
+	if (!pos)
+		return 0;
+
+	pci_read_config_dword(dev, pos + 4, &lo);
+	pci_read_config_dword(dev, pos + 8, &hi);
+	return ((u64)hi << 32) | lo;
+}
+
+void pci_dsn_init(struct pci_dev *dev)
+{
+	dev->sn = pci_device_serial_number(dev);
+}
+
+/**
  * pci_configure_ari - enable or disable ARI forwarding
  * @dev: the PCI device
  *
diff --git a/drivers/pci/pci.h b/drivers/pci/pci.h
index 816c297..2b2a9cc 100644
--- a/drivers/pci/pci.h
+++ b/drivers/pci/pci.h
@@ -207,7 +207,7 @@ void __ref __pci_bus_size_bridges(struct pci_bus *bus,
 void __ref __pci_bus_assign_resources(const struct pci_bus *bus,
 				      struct list_head *realloc_head,
 				      struct list_head *fail_head);
-
+void pci_dsn_init(struct pci_dev *dev);
 /**
  * pci_ari_enabled - query ARI forwarding status
  * @bus: the PCI bus
diff --git a/drivers/pci/probe.c b/drivers/pci/probe.c
index 83172bc..0c5da76 100644
--- a/drivers/pci/probe.c
+++ b/drivers/pci/probe.c
@@ -1325,6 +1325,8 @@ static void pci_init_capabilities(struct pci_dev *dev)
 	/* Vital Product Data */
 	pci_vpd_pci22_init(dev);
 
+	pci_dsn_init(dev);
+
 	/* Alternative Routing-ID Forwarding */
 	pci_configure_ari(dev);
 
diff --git a/include/linux/pci.h b/include/linux/pci.h
index 0fd1f15..4354eaf 100644
--- a/include/linux/pci.h
+++ b/include/linux/pci.h
@@ -342,6 +342,7 @@ struct pci_dev {
 	struct list_head msi_list;
 	struct kset *msi_kset;
 #endif
+	u64 sn;		/* device serial number, 0 if not support */
 	struct pci_vpd *vpd;
 #ifdef CONFIG_PCI_ATS
 	union {
-- 
1.7.1


