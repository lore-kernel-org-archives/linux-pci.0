Return-Path: <SRS0=ZPBx=RJ=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 85E44C43381
	for <linux-pci@archiver.kernel.org>; Wed,  6 Mar 2019 22:13:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5C5D620684
	for <linux-pci@archiver.kernel.org>; Wed,  6 Mar 2019 22:13:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726738AbfCFWNg (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Wed, 6 Mar 2019 17:13:36 -0500
Received: from mga07.intel.com ([134.134.136.100]:13420 "EHLO mga07.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726364AbfCFWNg (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Wed, 6 Mar 2019 17:13:36 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by orsmga105.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 06 Mar 2019 14:13:34 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.58,449,1544515200"; 
   d="scan'208";a="149937650"
Received: from skuppusw-desk.jf.intel.com ([10.54.74.33])
  by fmsmga004.fm.intel.com with ESMTP; 06 Mar 2019 14:13:34 -0800
From:   sathyanarayanan.kuppuswamy@linux.intel.com
To:     bhelgaas@google.com, corbet@lwn.net
Cc:     linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-pci@vger.kernel.org,
        Kuppuswamy Sathyanarayanan 
        <sathyanarayanan.kuppuswamy@linux.intel.com>,
        Ashok Raj <ashok.raj@intel.com>,
        Keith Busch <keith.busch@intel.com>
Subject: [PATCH v1 2/5] PCI/ATS: Fix PRI PF/VF dependency issues
Date:   Wed,  6 Mar 2019 14:11:15 -0800
Message-Id: <cc4123764e3f6b02259d3806419553c01b59edcf.1551909341.git.sathyanarayanan.kuppuswamy@linux.intel.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <cover.1551909341.git.sathyanarayanan.kuppuswamy@linux.intel.com>
References: <cover.1551909341.git.sathyanarayanan.kuppuswamy@linux.intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

From: Kuppuswamy Sathyanarayanan <sathyanarayanan.kuppuswamy@linux.intel.com>

As per PCIe spec r4.0, sec 9.3.7.11 ("Page Request Interface (PRI)"),
all VFs associated with PF can only use the Page Request Interface
of the PF and not implement it. So for any PRI capability related
queries on a VF device use associated PF device capabilities. Also
disable PRI on PF only when all related VFs disable PRI.

Cc: Ashok Raj <ashok.raj@intel.com>
Cc: Keith Busch <keith.busch@intel.com>
Suggested-by: Ashok Raj <ashok.raj@intel.com>
Signed-off-by: Kuppuswamy Sathyanarayanan <sathyanarayanan.kuppuswamy@linux.intel.com>
---
 drivers/pci/ats.c   | 47 ++++++++++++++++++++++++++++++++++++++++++++-
 include/linux/pci.h |  1 +
 2 files changed, 47 insertions(+), 1 deletion(-)

diff --git a/drivers/pci/ats.c b/drivers/pci/ats.c
index 5b78f3b1b918..3fcef4544c4c 100644
--- a/drivers/pci/ats.c
+++ b/drivers/pci/ats.c
@@ -154,10 +154,33 @@ int pci_enable_pri(struct pci_dev *pdev, u32 reqs)
 	u16 control, status;
 	u32 max_requests;
 	int pos;
+	struct pci_dev *pf;
 
 	if (WARN_ON(pdev->pri_enabled))
 		return -EBUSY;
 
+	/* If PRI Capability is invalid, return error */
+	if (pdev->is_virtfn || pdev->is_physfn) {
+		if (pdev->invalid_cap & PCI_IOV_INVALID_PRI)
+			return -EINVAL;
+	}
+
+	if (pdev->is_virtfn) {
+		pf = pci_physfn(pdev);
+
+		/* If VF config does not match with PF, return error */
+		if (!pf->pri_enabled)
+			return -EINVAL;
+
+		pdev->pri_reqs_alloc = pf->pri_reqs_alloc;
+		pdev->pri_enabled = 1;
+
+		/* Increment PF PRI refcount */
+		atomic_inc(&pf->pri_ref_cnt);
+
+		return 0;
+	}
+
 	pos = pci_find_ext_capability(pdev, PCI_EXT_CAP_ID_PRI);
 	if (!pos)
 		return -EINVAL;
@@ -175,7 +198,6 @@ int pci_enable_pri(struct pci_dev *pdev, u32 reqs)
 	pci_write_config_word(pdev, pos + PCI_PRI_CTRL, control);
 
 	pdev->pri_enabled = 1;
-
 	return 0;
 }
 EXPORT_SYMBOL_GPL(pci_enable_pri);
@@ -190,10 +212,27 @@ void pci_disable_pri(struct pci_dev *pdev)
 {
 	u16 control;
 	int pos;
+	struct pci_dev *pf;
 
 	if (WARN_ON(!pdev->pri_enabled))
 		return;
 
+	/* All VFs should be disabled before disabling PF */
+	if (atomic_read(&pdev->pri_ref_cnt))
+		return;
+
+	if (pdev->is_virtfn) {
+		/* Since VF shares PRI with PF, use PF config. */
+		pf = pci_physfn(pdev);
+
+		/* Decrement PF PRI refcount */
+		atomic_dec(&pf->pri_ref_cnt);
+
+		pdev->pri_enabled = 0;
+
+		return;
+	}
+
 	pos = pci_find_ext_capability(pdev, PCI_EXT_CAP_ID_PRI);
 	if (!pos)
 		return;
@@ -219,6 +258,9 @@ void pci_restore_pri_state(struct pci_dev *pdev)
 	if (!pdev->pri_enabled)
 		return;
 
+	if (pdev->is_virtfn)
+		return;
+
 	pos = pci_find_ext_capability(pdev, PCI_EXT_CAP_ID_PRI);
 	if (!pos)
 		return;
@@ -243,6 +285,9 @@ int pci_reset_pri(struct pci_dev *pdev)
 	if (WARN_ON(pdev->pri_enabled))
 		return -EBUSY;
 
+	if (pdev->is_virtfn)
+		return 0;
+
 	pos = pci_find_ext_capability(pdev, PCI_EXT_CAP_ID_PRI);
 	if (!pos)
 		return -EINVAL;
diff --git a/include/linux/pci.h b/include/linux/pci.h
index 489fc0f68bb1..d5df80ab2645 100644
--- a/include/linux/pci.h
+++ b/include/linux/pci.h
@@ -448,6 +448,7 @@ struct pci_dev {
 #endif
 #ifdef CONFIG_PCI_PRI
 	u32		pri_reqs_alloc;	/* Number of PRI requests allocated */
+	atomic_t	pri_ref_cnt;	/* Number of VFs with PRI enabled */
 #endif
 #ifdef CONFIG_PCI_PASID
 	u16		pasid_features;
-- 
2.20.1

