Return-Path: <SRS0=ZPBx=RJ=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7848AC10F00
	for <linux-pci@archiver.kernel.org>; Wed,  6 Mar 2019 22:13:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4E3B020854
	for <linux-pci@archiver.kernel.org>; Wed,  6 Mar 2019 22:13:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726768AbfCFWNi (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Wed, 6 Mar 2019 17:13:38 -0500
Received: from mga07.intel.com ([134.134.136.100]:13420 "EHLO mga07.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726388AbfCFWNh (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Wed, 6 Mar 2019 17:13:37 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by orsmga105.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 06 Mar 2019 14:13:35 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.58,449,1544515200"; 
   d="scan'208";a="149937654"
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
Subject: [PATCH v1 3/5] PCI/ATS: Fix PASID PF/VF dependency issues
Date:   Wed,  6 Mar 2019 14:11:16 -0800
Message-Id: <ef7d85dcf69255c1cfee8082e986409a46ed8f49.1551909341.git.sathyanarayanan.kuppuswamy@linux.intel.com>
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

As per PCIe spec r4.0, sec 9.3.7.14 ("PASID"), all VFs associated
with PF can only use the PASID of the PF and not implement it.
So for any PASID capability related queries on a VF device use
associated PF device capabilities. Also disable PASID support on
a PF device only when all related VFs disable PASID.

Cc: Ashok Raj <ashok.raj@intel.com>
Cc: Keith Busch <keith.busch@intel.com>
Suggested-by: Ashok Raj <ashok.raj@intel.com>
Signed-off-by: Kuppuswamy Sathyanarayanan <sathyanarayanan.kuppuswamy@linux.intel.com>
---
 drivers/pci/ats.c   | 62 +++++++++++++++++++++++++++++++++++++++++++++
 include/linux/pci.h |  1 +
 2 files changed, 63 insertions(+)

diff --git a/drivers/pci/ats.c b/drivers/pci/ats.c
index 3fcef4544c4c..28bbf7dad425 100644
--- a/drivers/pci/ats.c
+++ b/drivers/pci/ats.c
@@ -314,6 +314,7 @@ int pci_enable_pasid(struct pci_dev *pdev, int features)
 {
 	u16 control, supported;
 	int pos;
+	struct pci_dev *pf;
 
 	if (WARN_ON(pdev->pasid_enabled))
 		return -EBUSY;
@@ -321,6 +322,29 @@ int pci_enable_pasid(struct pci_dev *pdev, int features)
 	if (!pdev->eetlp_prefix_path)
 		return -EINVAL;
 
+	/* If PASID capability is invalid, return error */
+	if (pdev->is_virtfn || pdev->is_physfn) {
+		if (pdev->invalid_cap & PCI_IOV_INVALID_PASID)
+			return -EINVAL;
+	}
+
+	if (pdev->is_virtfn) {
+		/* Since VF shares PASID with PF, use PF config */
+		pf = pci_physfn(pdev);
+
+		/* If VF config does not match with PF, return error */
+		if (!pf->pasid_enabled || pf->pasid_features != features)
+			return -EINVAL;
+
+		pdev->pasid_features = features;
+		pdev->pasid_enabled = 1;
+
+		/* Increment PF PASID refcount */
+		atomic_inc(&pf->pasid_ref_cnt);
+
+		return 0;
+	}
+
 	pos = pci_find_ext_capability(pdev, PCI_EXT_CAP_ID_PASID);
 	if (!pos)
 		return -EINVAL;
@@ -351,10 +375,27 @@ void pci_disable_pasid(struct pci_dev *pdev)
 {
 	u16 control = 0;
 	int pos;
+	struct pci_dev *pf;
 
 	if (WARN_ON(!pdev->pasid_enabled))
 		return;
 
+	/* All VFs PASID should be disabled before disabling PF PASID*/
+	if (atomic_read(&pdev->pasid_ref_cnt))
+		return;
+
+	if (pdev->is_virtfn) {
+		/* Since VF shares PASID with PF, use PF config. */
+		pf = pci_physfn(pdev);
+
+		/* Decrement PF PASID refcount */
+		atomic_dec(&pf->pasid_ref_cnt);
+
+		pdev->pasid_enabled = 0;
+
+		return;
+	}
+
 	pos = pci_find_ext_capability(pdev, PCI_EXT_CAP_ID_PASID);
 	if (!pos)
 		return;
@@ -377,6 +418,9 @@ void pci_restore_pasid_state(struct pci_dev *pdev)
 	if (!pdev->pasid_enabled)
 		return;
 
+	if (pdev->is_virtfn)
+		return;
+
 	pos = pci_find_ext_capability(pdev, PCI_EXT_CAP_ID_PASID);
 	if (!pos)
 		return;
@@ -401,6 +445,15 @@ int pci_pasid_features(struct pci_dev *pdev)
 	u16 supported;
 	int pos;
 
+	/* If PASID Cap is invalid then return error */
+	if (pdev->is_virtfn || pdev->is_physfn) {
+		if (pdev->invalid_cap & PCI_IOV_INVALID_PASID)
+			return -EINVAL;
+	}
+
+	if (pdev->is_virtfn)
+		pdev = pci_physfn(pdev);
+
 	pos = pci_find_ext_capability(pdev, PCI_EXT_CAP_ID_PASID);
 	if (!pos)
 		return -EINVAL;
@@ -427,6 +480,15 @@ int pci_max_pasids(struct pci_dev *pdev)
 	u16 supported;
 	int pos;
 
+	/* If PASID Cap is invalid then return error */
+	if (pdev->is_virtfn || pdev->is_physfn) {
+		if (pdev->invalid_cap & PCI_IOV_INVALID_PASID)
+			return -EINVAL;
+	}
+
+	if (pdev->is_virtfn)
+		pdev = pci_physfn(pdev);
+
 	pos = pci_find_ext_capability(pdev, PCI_EXT_CAP_ID_PASID);
 	if (!pos)
 		return -EINVAL;
diff --git a/include/linux/pci.h b/include/linux/pci.h
index d5df80ab2645..c6c413c52403 100644
--- a/include/linux/pci.h
+++ b/include/linux/pci.h
@@ -452,6 +452,7 @@ struct pci_dev {
 #endif
 #ifdef CONFIG_PCI_PASID
 	u16		pasid_features;
+	atomic_t	pasid_ref_cnt;	/* Number of VFs with PASID enabled */
 #endif
 #ifdef CONFIG_PCI_P2PDMA
 	struct pci_p2pdma *p2pdma;
-- 
2.20.1

