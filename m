Return-Path: <SRS0=ZPBx=RJ=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 49701C43381
	for <linux-pci@archiver.kernel.org>; Wed,  6 Mar 2019 22:13:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 16FA120684
	for <linux-pci@archiver.kernel.org>; Wed,  6 Mar 2019 22:13:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726806AbfCFWNs (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Wed, 6 Mar 2019 17:13:48 -0500
Received: from mga07.intel.com ([134.134.136.100]:13421 "EHLO mga07.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726763AbfCFWNh (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Wed, 6 Mar 2019 17:13:37 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by orsmga105.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 06 Mar 2019 14:13:35 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.58,449,1544515200"; 
   d="scan'208";a="149937662"
Received: from skuppusw-desk.jf.intel.com ([10.54.74.33])
  by fmsmga004.fm.intel.com with ESMTP; 06 Mar 2019 14:13:35 -0800
From:   sathyanarayanan.kuppuswamy@linux.intel.com
To:     bhelgaas@google.com, corbet@lwn.net
Cc:     linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-pci@vger.kernel.org,
        Kuppuswamy Sathyanarayanan 
        <sathyanarayanan.kuppuswamy@linux.intel.com>,
        Ashok Raj <ashok.raj@intel.com>,
        Keith Busch <keith.busch@intel.com>
Subject: [PATCH v1 5/5] PCI/ATS: Fix ATS PF/VF dependency issues
Date:   Wed,  6 Mar 2019 14:11:18 -0800
Message-Id: <770df406d036606f1f157a7df0d462d11ee5fae0.1551909341.git.sathyanarayanan.kuppuswamy@linux.intel.com>
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

As per PCIe spec r4.0, sec 9.3.7.8, ATS Capabilities in VFs and their
associated PFs may be enabled independently. But currently all VFs needs
to disable ATS service before disabling the ATS service in PF. So remove
this dependency logic in enable/disable code.

Cc: Ashok Raj <ashok.raj@intel.com>
Cc: Keith Busch <keith.busch@intel.com>
Suggested-by: Ashok Raj <ashok.raj@intel.com>
Signed-off-by: Kuppuswamy Sathyanarayanan <sathyanarayanan.kuppuswamy@linux.intel.com>
---
 drivers/pci/ats.c   | 11 -----------
 include/linux/pci.h |  1 -
 2 files changed, 12 deletions(-)

diff --git a/drivers/pci/ats.c b/drivers/pci/ats.c
index 11299d93a59a..062471abfeca 100644
--- a/drivers/pci/ats.c
+++ b/drivers/pci/ats.c
@@ -66,8 +66,6 @@ int pci_enable_ats(struct pci_dev *dev, int ps)
 		pdev = pci_physfn(dev);
 		if (pdev->ats_stu != ps)
 			return -EINVAL;
-
-		atomic_inc(&pdev->ats_ref_cnt);  /* count enabled VFs */
 	} else {
 		dev->ats_stu = ps;
 		ctrl |= PCI_ATS_CTRL_STU(dev->ats_stu - PCI_ATS_MIN_STU);
@@ -85,20 +83,11 @@ EXPORT_SYMBOL_GPL(pci_enable_ats);
  */
 void pci_disable_ats(struct pci_dev *dev)
 {
-	struct pci_dev *pdev;
 	u16 ctrl;
 
 	if (WARN_ON(!dev->ats_enabled))
 		return;
 
-	if (atomic_read(&dev->ats_ref_cnt))
-		return;		/* VFs still enabled */
-
-	if (dev->is_virtfn) {
-		pdev = pci_physfn(dev);
-		atomic_dec(&pdev->ats_ref_cnt);
-	}
-
 	pci_read_config_word(dev, dev->ats_cap + PCI_ATS_CTRL, &ctrl);
 	ctrl &= ~PCI_ATS_CTRL_ENABLE;
 	pci_write_config_word(dev, dev->ats_cap + PCI_ATS_CTRL, ctrl);
diff --git a/include/linux/pci.h b/include/linux/pci.h
index c6c413c52403..07e796e7f2bf 100644
--- a/include/linux/pci.h
+++ b/include/linux/pci.h
@@ -444,7 +444,6 @@ struct pci_dev {
 	};
 	u16		ats_cap;	/* ATS Capability offset */
 	u8		ats_stu;	/* ATS Smallest Translation Unit */
-	atomic_t	ats_ref_cnt;	/* Number of VFs with ATS enabled */
 #endif
 #ifdef CONFIG_PCI_PRI
 	u32		pri_reqs_alloc;	/* Number of PRI requests allocated */
-- 
2.20.1

