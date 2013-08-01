Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from szxga03-in.huawei.com ([119.145.14.66]:27364 "EHLO
	szxga03-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751066Ab3HANHQ (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Thu, 1 Aug 2013 09:07:16 -0400
From: Yijing Wang <wangyijing@huawei.com>
To: Bjorn Helgaas <bhelgaas@google.com>
CC: <linux-pci@vger.kernel.org>, Hanjun Guo <guohanjun@huawei.com>,
	<jiang.liu@huawei.com>, Yijing Wang <wangyijing@huawei.com>,
	Paul Bolle <pebolle@tiscali.nl>,
	"Rafael J. Wysocki" <rjw@sisk.pl>, Oliver Neukum <oneukum@suse.de>,
	Gu Zheng <guz.fnst@cn.fujitsu.com>
Subject: [PATCH -v4 2/6] PCI: introduce PCIe Device Serial Number Capability support
Date: Thu, 1 Aug 2013 21:06:25 +0800
Message-ID: <1375362389-26096-3-git-send-email-wangyijing@huawei.com>
In-Reply-To: <1375362389-26096-1-git-send-email-wangyijing@huawei.com>
References: <1375362389-26096-1-git-send-email-wangyijing@huawei.com>
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
index a8d5fd0..4de8468 100644
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
index d1182c4..5f398a5 100644
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
index 46ada5c..edb138c 100644
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


