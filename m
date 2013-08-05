Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from szxga01-in.huawei.com ([119.145.14.64]:19033 "EHLO
	szxga01-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754971Ab3HEI4E (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Mon, 5 Aug 2013 04:56:04 -0400
From: Yijing Wang <wangyijing@huawei.com>
To: Bjorn Helgaas <bhelgaas@google.com>
CC: <linux-pci@vger.kernel.org>, Rafael <rjw@sisk.pl>,
	Oliver Neukum <oneukum@suse.de>,
	Gu Zheng <guz.fnst@cn.fujitsu.com>,
	Paul Bolle <pebolle@tiscali.nl>,
	Hanjun Guo <guohanjun@huawei.com>, <jiang.liu@huawei.com>,
	Yijing Wang <wangyijing@huawei.com>
Subject: [PATCH -v5 3/6] PCI: Introduce Vital Product Data Serial Number capability support
Date: Mon, 5 Aug 2013 16:54:55 +0800
Message-ID: <1375692898-27476-4-git-send-email-wangyijing@huawei.com>
In-Reply-To: <1375692898-27476-1-git-send-email-wangyijing@huawei.com>
References: <1375692898-27476-1-git-send-email-wangyijing@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Vital Product Data Serial Number is another capability to support
device serial number, some devices may implement this cap. So we
introduce VPD SN support here to enhance the device change
identification.

Suggested-by: Bjorn Helgaas <bhelgaas@google.com>
Signed-off-by: Yijing Wang <wangyijing@huawei.com>
Cc: Paul Bolle <pebolle@tiscali.nl>
Cc: "Rafael J. Wysocki" <rjw@sisk.pl>
Cc: Oliver Neukum <oneukum@suse.de>
Cc: Gu Zheng <guz.fnst@cn.fujitsu.com>
Cc: linux-pci@vger.kernel.org
---
 drivers/pci/access.c |    4 ++-
 drivers/pci/pci.h    |    4 +++
 drivers/pci/vpd.c    |   70 ++++++++++++++++++++++++++++++++++++++++++++++++++
 include/linux/pci.h  |    1 +
 4 files changed, 78 insertions(+), 1 deletions(-)

diff --git a/drivers/pci/access.c b/drivers/pci/access.c
index 1cc2366..0069981 100644
--- a/drivers/pci/access.c
+++ b/drivers/pci/access.c
@@ -194,7 +194,6 @@ PCI_USER_WRITE_CONFIG(dword, u32)
 
 /* VPD access through PCI 2.2+ VPD capability */
 
-#define PCI_VPD_PCI22_SIZE (PCI_VPD_ADDR_MASK + 1)
 
 struct pci_vpd_pci22 {
 	struct pci_vpd base;
@@ -350,6 +349,7 @@ out:
 
 static void pci_vpd_pci22_release(struct pci_dev *dev)
 {
+	kfree(dev->vpd->sn);
 	kfree(container_of(dev->vpd, struct pci_vpd_pci22, base));
 }
 
@@ -377,6 +377,8 @@ int pci_vpd_pci22_init(struct pci_dev *dev)
 	vpd->cap = cap;
 	vpd->busy = false;
 	dev->vpd = &vpd->base;
+
+	pci_vpd_serial_number_init(dev, dev->vpd);
 	return 0;
 }
 
diff --git a/drivers/pci/pci.h b/drivers/pci/pci.h
index 2b2a9cc..eb77124 100644
--- a/drivers/pci/pci.h
+++ b/drivers/pci/pci.h
@@ -83,6 +83,8 @@ static inline bool pci_is_bridge(struct pci_dev *pci_dev)
 	return !!(pci_dev->subordinate);
 }
 
+#define PCI_VPD_PCI22_SIZE (PCI_VPD_ADDR_MASK + 1)
+
 struct pci_vpd_ops {
 	ssize_t (*read)(struct pci_dev *dev, loff_t pos, size_t count, void *buf);
 	ssize_t (*write)(struct pci_dev *dev, loff_t pos, size_t count, const void *buf);
@@ -91,6 +93,7 @@ struct pci_vpd_ops {
 
 struct pci_vpd {
 	unsigned int len;
+	char *sn; /* serial number */
 	const struct pci_vpd_ops *ops;
 	struct bin_attribute *attr; /* descriptor for sysfs VPD entry */
 };
@@ -208,6 +211,7 @@ void __ref __pci_bus_assign_resources(const struct pci_bus *bus,
 				      struct list_head *realloc_head,
 				      struct list_head *fail_head);
 void pci_dsn_init(struct pci_dev *dev);
+struct pci_vpd *pci_vpd_serial_number_init(struct pci_dev *dev, struct pci_vpd *vpd);
 /**
  * pci_ari_enabled - query ARI forwarding status
  * @bus: the PCI bus
diff --git a/drivers/pci/vpd.c b/drivers/pci/vpd.c
index 39b7907..e5a4853 100644
--- a/drivers/pci/vpd.c
+++ b/drivers/pci/vpd.c
@@ -7,6 +7,7 @@
 
 #include <linux/pci.h>
 #include <linux/export.h>
+#include "pci.h"
 
 int pci_vpd_find_tag(const u8 *buf, unsigned int off, unsigned int len, u8 rdt)
 {
@@ -60,3 +61,71 @@ int pci_vpd_find_info_keyword(const u8 *buf, unsigned int off,
 	return -ENOENT;
 }
 EXPORT_SYMBOL_GPL(pci_vpd_find_info_keyword);
+
+/**
+ * pci_vpd_serial_number_init - initialize the device VPD SN
+ * @dev: the PCI device
+ * @vpd: the VPD used to initialize SN
+ *
+ * Initialize the device VPD Serial Number, if vpd passed as NULL,
+ * allocate a new VPD and initialize its SN.
+ */
+struct pci_vpd *pci_vpd_serial_number_init(struct pci_dev *dev,
+				struct pci_vpd *vpd)
+{
+	char *buf = NULL;
+	struct pci_vpd *old = dev->vpd;
+	struct pci_vpd *new = NULL;
+	int cnt, i, end, j, len;
+
+	/* To detect whether the device is changed, we should
+	 * allocate a new VPD to initialize serial number,
+	 * because if the device has been changed, the cap
+	 * info is stale.
+	 */
+	if (!vpd) {
+		dev->vpd = NULL;
+		pci_vpd_pci22_init(dev);
+		if (!dev->vpd)
+			goto fail;
+	}
+
+	new = dev->vpd;
+	buf = kzalloc(PCI_VPD_PCI22_SIZE, GFP_KERNEL);
+	if (!buf)
+		goto fail;
+
+	cnt = pci_read_vpd(dev, 0, PCI_VPD_PCI22_SIZE, buf);
+	if (cnt < 0)
+		goto fail;
+
+	i = pci_vpd_find_tag(buf, 0, PCI_VPD_PCI22_SIZE,
+			PCI_VPD_LRDT_RO_DATA);
+	if (i < 0)
+		goto fail;
+
+	end = i + PCI_VPD_LRDT_TAG_SIZE + pci_vpd_lrdt_size(&buf[i]);
+	i += PCI_VPD_LRDT_TAG_SIZE;
+
+	j = pci_vpd_find_info_keyword(buf, i, end,
+			PCI_VPD_RO_KEYWORD_SN);
+	if (j < 0)
+		goto fail;
+
+	len = pci_vpd_info_field_size(&buf[j]);
+	new->sn = kzalloc(len + 1, GFP_KERNEL);
+	if (!new->sn)
+		goto fail;
+
+	j += PCI_VPD_INFO_FLD_HDR_SIZE;
+	memcpy(new->sn, &buf[j], len);
+	kfree(buf);
+	dev->vpd = old;
+	return new;
+fail:
+	kfree(buf);
+	if (new != old)
+		pci_vpd_release(dev);
+	dev->vpd = old;
+	return NULL;
+}
diff --git a/include/linux/pci.h b/include/linux/pci.h
index 4354eaf..5c38b55 100644
--- a/include/linux/pci.h
+++ b/include/linux/pci.h
@@ -1781,6 +1781,7 @@ bool pci_acs_path_enabled(struct pci_dev *start,
 
 #define PCI_VPD_RO_KEYWORD_PARTNO	"PN"
 #define PCI_VPD_RO_KEYWORD_MFR_ID	"MN"
+#define PCI_VPD_RO_KEYWORD_SN		"SN"
 #define PCI_VPD_RO_KEYWORD_VENDOR0	"V0"
 #define PCI_VPD_RO_KEYWORD_CHKSUM	"RV"
 
-- 
1.7.1


