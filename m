Return-Path: <SRS0=Tpvo=MC=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2F5A3C433F4
	for <linux-pci@archiver.kernel.org>; Thu, 20 Sep 2018 16:26:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E5B282147D
	for <linux-pci@archiver.kernel.org>; Thu, 20 Sep 2018 16:26:35 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E5B282147D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-pci-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731832AbeITWKv (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Thu, 20 Sep 2018 18:10:51 -0400
Received: from mga07.intel.com ([134.134.136.100]:21062 "EHLO mga07.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730915AbeITWKu (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Thu, 20 Sep 2018 18:10:50 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by orsmga105.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 20 Sep 2018 09:26:34 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.54,281,1534834800"; 
   d="scan'208";a="258918210"
Received: from unknown (HELO localhost.lm.intel.com) ([10.232.112.44])
  by orsmga005.jf.intel.com with ESMTP; 20 Sep 2018 09:26:33 -0700
From:   Keith Busch <keith.busch@intel.com>
To:     Linux PCI <linux-pci@vger.kernel.org>,
        Bjorn Helgaas <bhelgaas@google.com>
Cc:     Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Sinan Kaya <okaya@kernel.org>,
        Thomas Tai <thomas.tai@oracle.com>, poza@codeaurora.org,
        Lukas Wunner <lukas@wunner.de>, Christoph Hellwig <hch@lst.de>,
        Mika Westerberg <mika.westerberg@linux.intel.com>,
        Keith Busch <keith.busch@intel.com>
Subject: [PATCHv4 11/12] PCI: Unify device inaccessible
Date:   Thu, 20 Sep 2018 10:27:16 -0600
Message-Id: <20180920162717.31066-12-keith.busch@intel.com>
X-Mailer: git-send-email 2.13.6
In-Reply-To: <20180920162717.31066-1-keith.busch@intel.com>
References: <20180920162717.31066-1-keith.busch@intel.com>
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

This patch brings surprise removals and permanent failures together so
we no longer need separate flags. The implementation enforces the error
handling will not be able to override a surprise removal's permanent
channel failure.

Signed-off-by: Keith Busch <keith.busch@intel.com>
---
 drivers/pci/pci.h      | 60 +++++++++++++++++++++++++++++++++++++++++++++-----
 drivers/pci/pcie/err.c | 10 ++++-----
 2 files changed, 59 insertions(+), 11 deletions(-)

diff --git a/drivers/pci/pci.h b/drivers/pci/pci.h
index 028abe34a15b..a244bd0c5ca7 100644
--- a/drivers/pci/pci.h
+++ b/drivers/pci/pci.h
@@ -295,21 +295,71 @@ struct pci_sriov {
 	bool		drivers_autoprobe; /* Auto probing of VFs by driver */
 };
 
-/* pci_dev priv_flags */
-#define PCI_DEV_DISCONNECTED 0
-#define PCI_DEV_ADDED 1
+/**
+ * pci_dev_set_io_state - Set the new error state if possible.
+ *
+ * @dev - pci device to set new error_state
+ * @new - the state we want dev to be in
+ *
+ * Must be called with device_lock held.
+ *
+ * Returns true if state has been changed to the requested state.
+ */
+static inline bool pci_dev_set_io_state(struct pci_dev *dev,
+					pci_channel_state_t new)
+{
+	bool changed = false;
+
+	device_lock_assert(&dev->dev);
+	switch (new) {
+	case pci_channel_io_perm_failure:
+		switch (dev->error_state) {
+		case pci_channel_io_frozen:
+		case pci_channel_io_normal:
+		case pci_channel_io_perm_failure:
+			changed = true;
+			break;
+		}
+		break;
+	case pci_channel_io_frozen:
+		switch (dev->error_state) {
+		case pci_channel_io_frozen:
+		case pci_channel_io_normal:
+			changed = true;
+			break;
+		}
+		break;
+	case pci_channel_io_normal:
+		switch (dev->error_state) {
+		case pci_channel_io_frozen:
+		case pci_channel_io_normal:
+			changed = true;
+			break;
+		}
+		break;
+	}
+	if (changed)
+		dev->error_state = new;
+	return changed;
+}
 
 static inline int pci_dev_set_disconnected(struct pci_dev *dev, void *unused)
 {
-	set_bit(PCI_DEV_DISCONNECTED, &dev->priv_flags);
+	device_lock(&dev->dev);
+	pci_dev_set_io_state(dev, pci_channel_io_perm_failure);
+	device_unlock(&dev->dev);
+
 	return 0;
 }
 
 static inline bool pci_dev_is_disconnected(const struct pci_dev *dev)
 {
-	return test_bit(PCI_DEV_DISCONNECTED, &dev->priv_flags);
+	return dev->error_state == pci_channel_io_perm_failure;
 }
 
+/* pci_dev priv_flags */
+#define PCI_DEV_ADDED 0
+
 static inline void pci_dev_assign_added(struct pci_dev *dev, bool added)
 {
 	assign_bit(PCI_DEV_ADDED, &dev->priv_flags, added);
diff --git a/drivers/pci/pcie/err.c b/drivers/pci/pcie/err.c
index 31e8a4314384..4da2a62b4f77 100644
--- a/drivers/pci/pcie/err.c
+++ b/drivers/pci/pcie/err.c
@@ -52,9 +52,8 @@ static int report_error_detected(struct pci_dev *dev,
 	const struct pci_error_handlers *err_handler;
 
 	device_lock(&dev->dev);
-	dev->error_state = state;
-
-	if (!dev->driver ||
+	if (!pci_dev_set_io_state(dev, state) ||
+		!dev->driver ||
 		!dev->driver->err_handler ||
 		!dev->driver->err_handler->error_detected) {
 		/*
@@ -130,9 +129,8 @@ static int report_resume(struct pci_dev *dev, void *data)
 	const struct pci_error_handlers *err_handler;
 
 	device_lock(&dev->dev);
-	dev->error_state = pci_channel_io_normal;
-
-	if (!dev->driver ||
+	if (!pci_dev_set_io_state(dev, pci_channel_io_normal) ||
+		!dev->driver ||
 		!dev->driver->err_handler ||
 		!dev->driver->err_handler->resume)
 		goto out;
-- 
2.14.4

