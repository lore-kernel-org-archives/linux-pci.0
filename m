Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from szxga01-in.huawei.com ([119.145.14.64]:58600 "EHLO
	szxga01-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754561Ab3HANHI (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Thu, 1 Aug 2013 09:07:08 -0400
From: Yijing Wang <wangyijing@huawei.com>
To: Bjorn Helgaas <bhelgaas@google.com>
CC: <linux-pci@vger.kernel.org>, Hanjun Guo <guohanjun@huawei.com>,
	<jiang.liu@huawei.com>, Yijing Wang <wangyijing@huawei.com>,
	Paul Bolle <pebolle@tiscali.nl>,
	"Rafael J. Wysocki" <rjw@sisk.pl>, Oliver Neukum <oneukum@suse.de>,
	Gu Zheng <guz.fnst@cn.fujitsu.com>
Subject: [PATCH -v4 4/6] PCI: add pci_serial_number_changed() for device change identification
Date: Thu, 1 Aug 2013 21:06:27 +0800
Message-ID: <1375362389-26096-5-git-send-email-wangyijing@huawei.com>
In-Reply-To: <1375362389-26096-1-git-send-email-wangyijing@huawei.com>
References: <1375362389-26096-1-git-send-email-wangyijing@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Sometimes OS do not know the physical device swap,
for instance, some device hotplug during system suspend.
Interrupt can not deliver to OS in some platform.
So we can use pci serial number capability to detect this
issue if device supports serial number.

Signed-off-by: Yijing Wang <wangyijing@huawei.com>
Cc: Paul Bolle <pebolle@tiscali.nl>
Cc: "Rafael J. Wysocki" <rjw@sisk.pl>
Cc: Oliver Neukum <oneukum@suse.de>
Cc: Gu Zheng <guz.fnst@cn.fujitsu.com>
Cc: linux-pci@vger.kernel.org
---
 drivers/pci/access.c |    9 ---------
 drivers/pci/pci.c    |   48 ++++++++++++++++++++++++++++++++++++++++++++++++
 drivers/pci/pci.h    |    8 ++++++++
 include/linux/pci.h  |    2 ++
 4 files changed, 58 insertions(+), 9 deletions(-)

diff --git a/drivers/pci/access.c b/drivers/pci/access.c
index 0069981..7f8df11 100644
--- a/drivers/pci/access.c
+++ b/drivers/pci/access.c
@@ -194,15 +194,6 @@ PCI_USER_WRITE_CONFIG(dword, u32)
 
 /* VPD access through PCI 2.2+ VPD capability */
 
-
-struct pci_vpd_pci22 {
-	struct pci_vpd base;
-	struct mutex lock;
-	u16	flag;
-	bool	busy;
-	u8	cap;
-};
-
 /*
  * Wait for last operation to complete.
  * This code has to spin since there is no other notification from the PCI
diff --git a/drivers/pci/pci.c b/drivers/pci/pci.c
index 4de8468..55b1069 100644
--- a/drivers/pci/pci.c
+++ b/drivers/pci/pci.c
@@ -2077,6 +2077,54 @@ void pci_dsn_init(struct pci_dev *dev)
 }
 
 /**
+ * pci_serial_number_changed - check the device SN is changed
+ * @pdev: the PCI device
+ *
+ * check the device serial number is changed.
+ * if device does not support device serial number,
+ * return false.
+ */
+bool pci_serial_number_changed(struct pci_dev *pdev)
+{
+	struct pci_vpd *vpd;
+	u64 old_dsn, new_dsn;
+	int ret;
+
+	/* first check PCIe DSN */
+	old_dsn = pdev->sn;
+	new_dsn = pci_device_serial_number(pdev);
+
+	if (old_dsn != new_dsn)
+		return true;
+	else if (old_dsn)
+		return false;
+
+	/* PCIe DSN does not support, check VPD SN */
+	vpd = pci_vpd_serial_number_init(pdev, NULL);
+	if (!pdev->vpd && !vpd) {
+		/* VPD SN does not support */
+		return false;
+	} else if (pdev->vpd && pdev->vpd->sn && vpd) {
+		ret = strcmp(pdev->vpd->sn, vpd->sn);
+		kfree(vpd->sn);
+		kfree(container_of(vpd, struct pci_vpd_pci22, base));
+		if (!ret)
+			return false;
+		else
+			return true;
+	} else if ((pdev->vpd && pdev->vpd->sn) || (vpd && vpd->sn)) {
+		if (vpd) {
+			kfree(vpd->sn);
+			kfree(container_of(vpd, struct pci_vpd_pci22, base));
+		}
+		return true;
+	}
+
+	return false;
+}
+EXPORT_SYMBOL(pci_serial_number_changed);
+
+/**
  * pci_configure_ari - enable or disable ARI forwarding
  * @dev: the PCI device
  *
diff --git a/drivers/pci/pci.h b/drivers/pci/pci.h
index aed8751..eb86cf8 100644
--- a/drivers/pci/pci.h
+++ b/drivers/pci/pci.h
@@ -98,6 +98,14 @@ struct pci_vpd {
 	struct bin_attribute *attr; /* descriptor for sysfs VPD entry */
 };
 
+struct pci_vpd_pci22 {
+	struct pci_vpd base;
+	struct mutex lock;
+	u16	flag;
+	bool	busy;
+	u8	cap;
+};
+
 int pci_vpd_pci22_init(struct pci_dev *dev);
 static inline void pci_vpd_release(struct pci_dev *dev)
 {
diff --git a/include/linux/pci.h b/include/linux/pci.h
index 5c38b55..9580fa5 100644
--- a/include/linux/pci.h
+++ b/include/linux/pci.h
@@ -996,6 +996,8 @@ ssize_t pci_read_vpd(struct pci_dev *dev, loff_t pos, size_t count, void *buf);
 ssize_t pci_write_vpd(struct pci_dev *dev, loff_t pos, size_t count, const void *buf);
 int pci_vpd_truncate(struct pci_dev *dev, size_t size);
 
+bool pci_serial_number_changed(struct pci_dev *pdev);
+
 /* Helper functions for low-level code (drivers/pci/setup-[bus,res].c) */
 resource_size_t pcibios_retrieve_fw_addr(struct pci_dev *dev, int idx);
 void pci_bus_assign_resources(const struct pci_bus *bus);
-- 
1.7.1


