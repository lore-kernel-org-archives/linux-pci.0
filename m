Return-Path: <SRS0=ZPBx=RJ=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 03D40C43381
	for <linux-pci@archiver.kernel.org>; Wed,  6 Mar 2019 22:13:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CDD2F20684
	for <linux-pci@archiver.kernel.org>; Wed,  6 Mar 2019 22:13:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726774AbfCFWNi (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Wed, 6 Mar 2019 17:13:38 -0500
Received: from mga07.intel.com ([134.134.136.100]:13420 "EHLO mga07.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726364AbfCFWNh (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Wed, 6 Mar 2019 17:13:37 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by orsmga105.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 06 Mar 2019 14:13:35 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.58,449,1544515200"; 
   d="scan'208";a="149937658"
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
Subject: [PATCH v1 4/5] PCI/ATS: For PF/VF skip ATS initalization if spec check failed
Date:   Wed,  6 Mar 2019 14:11:17 -0800
Message-Id: <0898a9bd92cfcf2ab07e5dd5ba59dc181b88edec.1551909341.git.sathyanarayanan.kuppuswamy@linux.intel.com>
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

Don't initialize ATS for VF/PF devices if the ATS Capability
implementaion is not aligned with PCIe spec r4.0 sec 9.3.7.8.

Cc: Ashok Raj <ashok.raj@intel.com>
Cc: Keith Busch <keith.busch@intel.com>
Suggested-by: Ashok Raj <ashok.raj@intel.com>
Reviewed-by: Keith Busch <keith.busch@intel.com>
Signed-off-by: Kuppuswamy Sathyanarayanan <sathyanarayanan.kuppuswamy@linux.intel.com>
---
 drivers/pci/ats.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/drivers/pci/ats.c b/drivers/pci/ats.c
index 28bbf7dad425..11299d93a59a 100644
--- a/drivers/pci/ats.c
+++ b/drivers/pci/ats.c
@@ -23,6 +23,12 @@ void pci_ats_init(struct pci_dev *dev)
 	if (pci_ats_disabled())
 		return;
 
+	/* If ATS Cap is invalid then return */
+	if (dev->is_virtfn || dev->is_physfn) {
+		if (dev->invalid_cap & PCI_IOV_INVALID_ATS)
+			return;
+	}
+
 	pos = pci_find_ext_capability(dev, PCI_EXT_CAP_ID_ATS);
 	if (!pos)
 		return;
-- 
2.20.1

