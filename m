Return-Path: <linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CE7F5C4320E
	for <linux-pci@archiver.kernel.org>; Tue, 17 Aug 2021 22:42:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id AD9FF60FE6
	for <linux-pci@archiver.kernel.org>; Tue, 17 Aug 2021 22:42:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236079AbhHQWnV (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Tue, 17 Aug 2021 18:43:21 -0400
Received: from mga04.intel.com ([192.55.52.120]:23830 "EHLO mga04.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S234889AbhHQWnV (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Tue, 17 Aug 2021 18:43:21 -0400
X-IronPort-AV: E=McAfee;i="6200,9189,10079"; a="214366097"
X-IronPort-AV: E=Sophos;i="5.84,330,1620716400"; 
   d="scan'208";a="214366097"
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Aug 2021 15:42:47 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.84,330,1620716400"; 
   d="scan'208";a="449448157"
Received: from linux.intel.com ([10.54.29.200])
  by fmsmga007.fm.intel.com with ESMTP; 17 Aug 2021 15:42:46 -0700
Received: from debox1-desk2.jf.intel.com (debox1-desk2.jf.intel.com [10.54.75.16])
        by linux.intel.com (Postfix) with ESMTP id C32825808DB;
        Tue, 17 Aug 2021 15:42:46 -0700 (PDT)
From:   "David E. Box" <david.e.box@linux.intel.com>
To:     lee.jones@linaro.org, hdegoede@redhat.com, mgross@linux.intel.com,
        bhelgaas@google.com, srinivas.pandruvada@intel.com,
        andy.shevchenko@gmail.com
Cc:     "David E. Box" <david.e.box@linux.intel.com>,
        linux-kernel@vger.kernel.org, platform-driver-x86@vger.kernel.org,
        linux-pci@vger.kernel.org
Subject: [PATCH v2 5/5] MFD: intel_pmt: Add DG2 support
Date:   Tue, 17 Aug 2021 15:40:18 -0700
Message-Id: <20210817224018.1013192-6-david.e.box@linux.intel.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210817224018.1013192-1-david.e.box@linux.intel.com>
References: <20210817224018.1013192-1-david.e.box@linux.intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Add Platform Monitoring Technology support for DG2 platforms.

Signed-off-by: David E. Box <david.e.box@linux.intel.com>
---

V2:	New patch

 drivers/mfd/intel_pmt.c                | 9 +++++++++
 drivers/platform/x86/intel/pmt/class.c | 2 ++
 2 files changed, 11 insertions(+)

diff --git a/drivers/mfd/intel_pmt.c b/drivers/mfd/intel_pmt.c
index 08e07b31aeec..a6fe50f65479 100644
--- a/drivers/mfd/intel_pmt.c
+++ b/drivers/mfd/intel_pmt.c
@@ -94,6 +94,11 @@ static const struct pmt_platform_info dg1_info = {
 	.capabilities = dg1_capabilities,
 };
 
+/* DG2 Platform */
+static const struct pmt_platform_info dg2_info = {
+	.quirks = PMT_QUIRK_TABLE_SHIFT
+};
+
 static bool intel_ext_cap_allowed(u16 id)
 {
 	int i;
@@ -334,11 +339,15 @@ static void pmt_pci_remove(struct pci_dev *pdev)
 
 #define PCI_DEVICE_ID_INTEL_PMT_ADL	0x467d
 #define PCI_DEVICE_ID_INTEL_PMT_DG1	0x490e
+#define PCI_DEVICE_ID_INTEL_PMT_DG2_G10	0x4f93
+#define PCI_DEVICE_ID_INTEL_PMT_DG2_G11	0x4f95
 #define PCI_DEVICE_ID_INTEL_PMT_OOBMSM	0x09a7
 #define PCI_DEVICE_ID_INTEL_PMT_TGL	0x9a0d
 static const struct pci_device_id pmt_pci_ids[] = {
 	{ PCI_DEVICE_DATA(INTEL, PMT_ADL, &tgl_info) },
 	{ PCI_DEVICE_DATA(INTEL, PMT_DG1, &dg1_info) },
+	{ PCI_DEVICE_DATA(INTEL, PMT_DG2_G10, &dg2_info) },
+	{ PCI_DEVICE_DATA(INTEL, PMT_DG2_G11, &dg2_info) },
 	{ PCI_DEVICE_DATA(INTEL, PMT_OOBMSM, NULL) },
 	{ PCI_DEVICE_DATA(INTEL, PMT_TGL, &tgl_info) },
 	{ }
diff --git a/drivers/platform/x86/intel/pmt/class.c b/drivers/platform/x86/intel/pmt/class.c
index 659b1073033c..f2a8e19a02e7 100644
--- a/drivers/platform/x86/intel/pmt/class.c
+++ b/drivers/platform/x86/intel/pmt/class.c
@@ -29,6 +29,8 @@
 static const struct pci_device_id pmt_telem_early_client_pci_ids[] = {
 	{ PCI_VDEVICE(INTEL, 0x467d) }, /* ADL */
 	{ PCI_VDEVICE(INTEL, 0x490e) }, /* DG1 */
+	{ PCI_VDEVICE(INTEL, 0x4f93) }, /* DG2_G10 */
+	{ PCI_VDEVICE(INTEL, 0x4f95) }, /* DG2_G11 */
 	{ PCI_VDEVICE(INTEL, 0x9a0d) }, /* TGL */
 	{ }
 };
-- 
2.25.1

