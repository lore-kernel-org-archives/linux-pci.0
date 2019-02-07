Return-Path: <SRS0=HpDZ=QO=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C9822C282C2
	for <linux-pci@archiver.kernel.org>; Thu,  7 Feb 2019 18:42:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9CEA32175B
	for <linux-pci@archiver.kernel.org>; Thu,  7 Feb 2019 18:42:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726905AbfBGSmu (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Thu, 7 Feb 2019 13:42:50 -0500
Received: from mga03.intel.com ([134.134.136.65]:38605 "EHLO mga03.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726675AbfBGSmu (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Thu, 7 Feb 2019 13:42:50 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by orsmga103.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 07 Feb 2019 10:42:49 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.58,345,1544515200"; 
   d="scan'208";a="318494907"
Received: from skuppusw-desk.jf.intel.com ([10.54.74.33])
  by fmsmga005.fm.intel.com with ESMTP; 07 Feb 2019 10:42:48 -0800
From:   sathyanarayanan.kuppuswamy@linux.intel.com
To:     bhelgaas@google.com, joro@8bytes.org, dwmw2@infradead.org
Cc:     linux-pci@vger.kernel.org, iommu@lists.linux-foundation.org,
        linux-kernel@vger.kernel.org, Ashok Raj <ashok.raj@intel.com>,
        Jacob Pan <jacob.jun.pan@linux.intel.com>,
        Keith Busch <keith.busch@intel.com>,
        Kuppuswamy Sathyanarayanan 
        <sathyanarayanan.kuppuswamy@linux.intel.com>
Subject: [PATCH v1 1/2] PCI: ATS: Add function to check ATS page aligned request status.
Date:   Thu,  7 Feb 2019 10:41:13 -0800
Message-Id: <91bfae8b1d4b424219e3ce3c1fc03559c73f1ae7.1549478584.git.sathyanarayanan.kuppuswamy@linux.intel.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <cover.1549478584.git.sathyanarayanan.kuppuswamy@linux.intel.com>
References: <cover.1549478584.git.sathyanarayanan.kuppuswamy@linux.intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

From: Kuppuswamy Sathyanarayanan <sathyanarayanan.kuppuswamy@linux.intel.com>

Add a new function to return the status of ATS page aligned request
bit in ATS capability register. This function will be used by
drivers like IOMMU, if it is required to enforce page-aligned
requests in ATS.

Cc: Ashok Raj <ashok.raj@intel.com>
Cc: Jacob Pan <jacob.jun.pan@linux.intel.com>
Cc: Keith Busch <keith.busch@intel.com>
Suggested-by: Ashok Raj <ashok.raj@intel.com>
Signed-off-by: Kuppuswamy Sathyanarayanan <sathyanarayanan.kuppuswamy@linux.intel.com>
---
 drivers/pci/ats.c             | 22 ++++++++++++++++++++++
 include/linux/pci.h           |  2 ++
 include/uapi/linux/pci_regs.h |  1 +
 3 files changed, 25 insertions(+)

diff --git a/drivers/pci/ats.c b/drivers/pci/ats.c
index 5b78f3b1b918..7d14b9a1981e 100644
--- a/drivers/pci/ats.c
+++ b/drivers/pci/ats.c
@@ -142,6 +142,28 @@ int pci_ats_queue_depth(struct pci_dev *dev)
 }
 EXPORT_SYMBOL_GPL(pci_ats_queue_depth);
 
+/**
+ * pci_ats_page_aligned - Return ATS page aligned request bit status.
+ * @pdev: the PCI device
+ *
+ * Returns  value > 0 if address is aligned or 0 otherwise.
+ *
+ * As per PCI spec, If page aligned request bit is set, it indicates
+ * the untranslated address is always aligned to a 4096 byte boundary.
+ */
+int pci_ats_page_aligned(struct pci_dev *pdev)
+{
+	u16 cap;
+
+	if (!pdev->ats_cap)
+		return 0;
+
+	pci_read_config_word(pdev, pdev->ats_cap + PCI_ATS_CAP, &cap);
+
+	return PCI_ATS_CAP_PAGE_ALIGNED(cap);
+}
+EXPORT_SYMBOL_GPL(pci_ats_page_aligned);
+
 #ifdef CONFIG_PCI_PRI
 /**
  * pci_enable_pri - Enable PRI capability
diff --git a/include/linux/pci.h b/include/linux/pci.h
index 65f1d8c2f082..9724a8c0496b 100644
--- a/include/linux/pci.h
+++ b/include/linux/pci.h
@@ -1524,11 +1524,13 @@ void pci_ats_init(struct pci_dev *dev);
 int pci_enable_ats(struct pci_dev *dev, int ps);
 void pci_disable_ats(struct pci_dev *dev);
 int pci_ats_queue_depth(struct pci_dev *dev);
+int pci_ats_page_aligned(struct pci_dev *dev);
 #else
 static inline void pci_ats_init(struct pci_dev *d) { }
 static inline int pci_enable_ats(struct pci_dev *d, int ps) { return -ENODEV; }
 static inline void pci_disable_ats(struct pci_dev *d) { }
 static inline int pci_ats_queue_depth(struct pci_dev *d) { return -ENODEV; }
+static inline int pci_ats_page_aligned(struct pci_dev *dev) { return 0; }
 #endif
 
 #ifdef CONFIG_PCIE_PTM
diff --git a/include/uapi/linux/pci_regs.h b/include/uapi/linux/pci_regs.h
index e1e9888c85e6..d42a759867b8 100644
--- a/include/uapi/linux/pci_regs.h
+++ b/include/uapi/linux/pci_regs.h
@@ -866,6 +866,7 @@
 #define PCI_ATS_CAP		0x04	/* ATS Capability Register */
 #define  PCI_ATS_CAP_QDEP(x)	((x) & 0x1f)	/* Invalidate Queue Depth */
 #define  PCI_ATS_MAX_QDEP	32	/* Max Invalidate Queue Depth */
+#define  PCI_ATS_CAP_PAGE_ALIGNED(x)	0x0020 /* Page Aligned Request */
 #define PCI_ATS_CTRL		0x06	/* ATS Control Register */
 #define  PCI_ATS_CTRL_ENABLE	0x8000	/* ATS Enable */
 #define  PCI_ATS_CTRL_STU(x)	((x) & 0x1f)	/* Smallest Translation Unit */
-- 
2.20.1

