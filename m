Return-Path: <SRS0=XN0A=QS=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DCC8DC282CE
	for <linux-pci@archiver.kernel.org>; Mon, 11 Feb 2019 21:52:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B5DEE2054F
	for <linux-pci@archiver.kernel.org>; Mon, 11 Feb 2019 21:52:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727168AbfBKVw2 (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Mon, 11 Feb 2019 16:52:28 -0500
Received: from mga11.intel.com ([192.55.52.93]:21453 "EHLO mga11.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726074AbfBKVw1 (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Mon, 11 Feb 2019 16:52:27 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by fmsmga102.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 11 Feb 2019 13:52:27 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.58,360,1544515200"; 
   d="scan'208";a="319517986"
Received: from skuppusw-desk.jf.intel.com ([10.54.74.33])
  by fmsmga005.fm.intel.com with ESMTP; 11 Feb 2019 13:52:27 -0800
From:   sathyanarayanan.kuppuswamy@linux.intel.com
To:     bhelgaas@google.com, joro@8bytes.org, dwmw2@infradead.org
Cc:     linux-pci@vger.kernel.org, iommu@lists.linux-foundation.org,
        linux-kernel@vger.kernel.org, ashok.raj@intel.com,
        jacob.jun.pan@intel.com, keith.busch@intel.com,
        Jacob Pan <jacob.jun.pan@linux.intel.com>,
        Kuppuswamy Sathyanarayanan 
        <sathyanarayanan.kuppuswamy@linux.intel.com>
Subject: [PATCH v2 1/2] PCI/ATS: Add pci_prg_resp_pasid_required() interface.
Date:   Mon, 11 Feb 2019 13:50:31 -0800
Message-Id: <e7dddc4f4092764bb5762e8b46c847278a8923ac.1549915780.git.sathyanarayanan.kuppuswamy@linux.intel.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <cover.1549915780.git.sathyanarayanan.kuppuswamy@linux.intel.com>
References: <cover.1549915780.git.sathyanarayanan.kuppuswamy@linux.intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

From: Kuppuswamy Sathyanarayanan <sathyanarayanan.kuppuswamy@linux.intel.com>

Return the PRG Response PASID Required bit in the Page Request
Status Register.

As per PCIe spec r4.0, sec 10.5.2.3, if this bit is Set then the device
expects a PASID TLP Prefix on PRG Response Messages when the
corresponding Page Requests had a PASID TLP Prefix. If Clear, the device
does not expect PASID TLP Prefixes on any PRG Response Message, and the
device behavior is undefined if this bit is Clear and the device
receives a PRG Response Message with a PASID TLP Prefix. Also the device
behavior is undefined in the this bit is Set and the device receives a
PRG Response Message with no PASID TLP Prefix when the corresponding
Page Requests had a PASID TLP Prefix.

This function will be used by drivers like IOMMU, if it is required to
check the status of the PRG Response PASID Required bit before enabling
the PASID support of the device.

Cc: Ashok Raj <ashok.raj@intel.com>
Cc: Jacob Pan <jacob.jun.pan@linux.intel.com>
Cc: Keith Busch <keith.busch@intel.com>
Suggested-by: Ashok Raj <ashok.raj@intel.com>
Signed-off-by: Kuppuswamy Sathyanarayanan <sathyanarayanan.kuppuswamy@linux.intel.com>
---
 drivers/pci/ats.c             | 31 +++++++++++++++++++++++++++++++
 include/linux/pci-ats.h       |  5 +++++
 include/uapi/linux/pci_regs.h |  1 +
 3 files changed, 37 insertions(+)

diff --git a/drivers/pci/ats.c b/drivers/pci/ats.c
index 5b78f3b1b918..f843cd846dff 100644
--- a/drivers/pci/ats.c
+++ b/drivers/pci/ats.c
@@ -368,6 +368,37 @@ int pci_pasid_features(struct pci_dev *pdev)
 }
 EXPORT_SYMBOL_GPL(pci_pasid_features);
 
+/**
+ * pci_prg_resp_pasid_required - Return PRG Response PASID Required bit
+ *				 status.
+ * @pdev: PCI device structure
+ *
+ * Returns 1 if PASID is required in PRG Response message, 0 otherwise.
+ *
+ * Even though the PRG response PASID status is read from PRI status
+ * register, since this API will mainly be used by PASID users, this
+ * function is defined within #ifdef CONFIG_PCI_PASID instead of
+ * CONFIG_PCI_PRI.
+ *
+ */
+int pci_prg_resp_pasid_required(struct pci_dev *pdev)
+{
+	u16 status;
+	int pos;
+
+	pos = pci_find_ext_capability(pdev, PCI_EXT_CAP_ID_PRI);
+	if (!pos)
+		return 0;
+
+	pci_read_config_word(pdev, pos + PCI_PRI_STATUS, &status);
+
+	if (status & PCI_PRI_STATUS_PASID)
+		return 1;
+
+	return 0;
+}
+EXPORT_SYMBOL_GPL(pci_prg_resp_pasid_required);
+
 #define PASID_NUMBER_SHIFT	8
 #define PASID_NUMBER_MASK	(0x1f << PASID_NUMBER_SHIFT)
 /**
diff --git a/include/linux/pci-ats.h b/include/linux/pci-ats.h
index 7c4b8e27268c..facfd6a18fe1 100644
--- a/include/linux/pci-ats.h
+++ b/include/linux/pci-ats.h
@@ -40,6 +40,7 @@ void pci_disable_pasid(struct pci_dev *pdev);
 void pci_restore_pasid_state(struct pci_dev *pdev);
 int pci_pasid_features(struct pci_dev *pdev);
 int pci_max_pasids(struct pci_dev *pdev);
+int pci_prg_resp_pasid_required(struct pci_dev *pdev);
 
 #else  /* CONFIG_PCI_PASID */
 
@@ -66,6 +67,10 @@ static inline int pci_max_pasids(struct pci_dev *pdev)
 	return -EINVAL;
 }
 
+static int pci_prg_resp_pasid_required(struct pci_dev *pdev)
+{
+	return 0;
+}
 #endif /* CONFIG_PCI_PASID */
 
 
diff --git a/include/uapi/linux/pci_regs.h b/include/uapi/linux/pci_regs.h
index e1e9888c85e6..898be572b010 100644
--- a/include/uapi/linux/pci_regs.h
+++ b/include/uapi/linux/pci_regs.h
@@ -880,6 +880,7 @@
 #define  PCI_PRI_STATUS_RF	0x001	/* Response Failure */
 #define  PCI_PRI_STATUS_UPRGI	0x002	/* Unexpected PRG index */
 #define  PCI_PRI_STATUS_STOPPED	0x100	/* PRI Stopped */
+#define  PCI_PRI_STATUS_PASID	0x8000	/* PRG Response PASID Required */
 #define PCI_PRI_MAX_REQ		0x08	/* PRI max reqs supported */
 #define PCI_PRI_ALLOC_REQ	0x0c	/* PRI max reqs allowed */
 #define PCI_EXT_CAP_PRI_SIZEOF	16
-- 
2.20.1

