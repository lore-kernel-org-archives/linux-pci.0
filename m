Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from userp1040.oracle.com ([156.151.31.81]:21920 "EHLO
	userp1040.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932583AbbG0XhE (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Mon, 27 Jul 2015 19:37:04 -0400
From: Yinghai Lu <yinghai@kernel.org>
To: Bjorn Helgaas <bhelgaas@google.com>,
	David Miller <davem@davemloft.net>,
	Benjamin Herrenschmidt <benh@kernel.crashing.org>,
	Wei Yang <weiyang@linux.vnet.ibm.com>, TJ <linux@iam.tj>,
	Yijing Wang <wangyijing@huawei.com>
Cc: Andrew Morton <akpm@linux-foundation.org>,
	linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
	Yinghai Lu <yinghai@kernel.org>, stable@vger.kernel.org
Subject: [PATCH v3 48/51] PCI: Set resource to FIXED for lsi devices
Date: Mon, 27 Jul 2015 16:30:06 -0700
Message-Id: <1438039809-24957-49-git-send-email-yinghai@kernel.org>
In-Reply-To: <1438039809-24957-1-git-send-email-yinghai@kernel.org>
References: <1438039809-24957-1-git-send-email-yinghai@kernel.org>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

LSI HBA firmware stop responding pci read from host if pci core ever change
pci device BAR values.

Set their resources to FIXED, so will allow realloc to skip them.

Reported-by: Paul Johnson <pjay@nwtrail.com>
Suggested-by: Bjorn Helgaas <bhelgaas@google.com>
Bugzilla: https://bugzilla.kernel.org/show_bug.cgi?id=92351
Signed-off-by: Yinghai Lu <yinghai@kernel.org>
Cc: stable@vger.kernel.org
---
 drivers/pci/pci.h       |  1 +
 drivers/pci/quirks.c    | 20 ++++++++++++++++++++
 drivers/pci/setup-bus.c |  4 ++++
 3 files changed, 25 insertions(+)

diff --git a/drivers/pci/pci.h b/drivers/pci/pci.h
index 1804d44..dec1c18 100644
--- a/drivers/pci/pci.h
+++ b/drivers/pci/pci.h
@@ -168,6 +168,7 @@ static inline void pci_msix_clear_and_set_ctrl(struct pci_dev *dev, u16 clear, u
 }
 
 void pci_realloc_get_opt(char *);
+bool pci_realloc_user_enabled(void);
 
 static inline int pci_no_d1d2(struct pci_dev *dev)
 {
diff --git a/drivers/pci/quirks.c b/drivers/pci/quirks.c
index 9efa983..a2945a4 100644
--- a/drivers/pci/quirks.c
+++ b/drivers/pci/quirks.c
@@ -324,6 +324,26 @@ static void quirk_s3_64M(struct pci_dev *dev)
 DECLARE_PCI_FIXUP_HEADER(PCI_VENDOR_ID_S3,	PCI_DEVICE_ID_S3_868,		quirk_s3_64M);
 DECLARE_PCI_FIXUP_HEADER(PCI_VENDOR_ID_S3,	PCI_DEVICE_ID_S3_968,		quirk_s3_64M);
 
+/*
+ * LSI devices firmware does not like BAR get changed
+ */
+static void quirk_bar_fixed(struct pci_dev *dev)
+{
+	int i;
+
+	if (pci_realloc_user_enabled())
+		return;
+
+	for (i = 0; i < PCI_STD_RESOURCE_END; i++) {
+		struct resource *r = &dev->resource[i];
+
+		if (!r->start || !r->flags)
+			continue;
+		r->flags |= IORESOURCE_PCI_FIXED;
+	}
+}
+DECLARE_PCI_FIXUP_HEADER(PCI_VENDOR_ID_LSI_LOGIC,	PCI_ANY_ID,	quirk_bar_fixed);
+
 /* for pci remove and rescan */
 static void quirk_allocate_fixed(struct pci_dev *dev)
 {
diff --git a/drivers/pci/setup-bus.c b/drivers/pci/setup-bus.c
index dcbbe04..7b296b0 100644
--- a/drivers/pci/setup-bus.c
+++ b/drivers/pci/setup-bus.c
@@ -2207,6 +2207,10 @@ void __init pci_realloc_get_opt(char *str)
 	else if (!strncmp(str, "on", 2))
 		pci_realloc_enable = user_enabled;
 }
+bool pci_realloc_user_enabled(void)
+{
+	return pci_realloc_enable == user_enabled;
+}
 static bool pci_realloc_enabled(enum enable_type enable)
 {
 	return enable >= user_enabled;
-- 
1.8.4.5

