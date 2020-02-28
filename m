Return-Path: <SRS0=niy7=4Q=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8D2D1C3F2CE
	for <linux-pci@archiver.kernel.org>; Fri, 28 Feb 2020 01:03:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6D9AE246A5
	for <linux-pci@archiver.kernel.org>; Fri, 28 Feb 2020 01:03:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730534AbgB1BCp (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Thu, 27 Feb 2020 20:02:45 -0500
Received: from mga14.intel.com ([192.55.52.115]:40114 "EHLO mga14.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730577AbgB1BCp (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Thu, 27 Feb 2020 20:02:45 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by fmsmga103.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 27 Feb 2020 17:02:43 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.70,493,1574150400"; 
   d="scan'208";a="317977010"
Received: from skuppusw-desk.jf.intel.com ([10.7.201.16])
  by orsmga001.jf.intel.com with ESMTP; 27 Feb 2020 17:02:42 -0800
From:   sathyanarayanan.kuppuswamy@linux.intel.com
To:     bhelgaas@google.com
Cc:     linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
        ashok.raj@intel.com,
        Kuppuswamy Sathyanarayanan 
        <sathyanarayanan.kuppuswamy@linux.intel.com>
Subject: [PATCH v16 6/9] PCI/AER: Allow clearing Error Status Register in FF mode
Date:   Thu, 27 Feb 2020 16:59:48 -0800
Message-Id: <9e71cba3596213b40d7c280bf57d8938189c2866.1582850766.git.sathyanarayanan.kuppuswamy@linux.intel.com>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <cover.1582850766.git.sathyanarayanan.kuppuswamy@linux.intel.com>
References: <cover.1582850766.git.sathyanarayanan.kuppuswamy@linux.intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

From: Kuppuswamy Sathyanarayanan <sathyanarayanan.kuppuswamy@linux.intel.com>

As per PCI firmware specification r3.2 System Firmware Intermediary
(SFI) _OSC and DPC Updates ECR
(https://members.pcisig.com/wg/PCI-SIG/document/13563), sec titled "DPC
Event Handling Implementation Note", page 10, Error Disconnect Recover
(EDR) support allows OS to handle error recovery and clearing Error
Registers even in FF mode. So create new API pci_aer_raw_clear_status()
which allows clearing AER registers without FF mode checks.

Signed-off-by: Kuppuswamy Sathyanarayanan <sathyanarayanan.kuppuswamy@linux.intel.com>
---
 drivers/pci/pci.h      |  2 ++
 drivers/pci/pcie/aer.c | 22 ++++++++++++++++++----
 2 files changed, 20 insertions(+), 4 deletions(-)

diff --git a/drivers/pci/pci.h b/drivers/pci/pci.h
index e57e78b619f8..c239e6dd2542 100644
--- a/drivers/pci/pci.h
+++ b/drivers/pci/pci.h
@@ -655,6 +655,7 @@ extern const struct attribute_group aer_stats_attr_group;
 void pci_aer_clear_fatal_status(struct pci_dev *dev);
 void pci_aer_clear_device_status(struct pci_dev *dev);
 int pci_cleanup_aer_error_status_regs(struct pci_dev *dev);
+int pci_aer_raw_clear_status(struct pci_dev *dev);
 #else
 static inline void pci_no_aer(void) { }
 static inline void pci_aer_init(struct pci_dev *d) { }
@@ -665,6 +666,7 @@ static inline int pci_cleanup_aer_error_status_regs(struct pci_dev *dev)
 {
 	return -EINVAL;
 }
+int pci_aer_raw_clear_status(struct pci_dev *dev) { return -EINVAL; }
 #endif
 
 #ifdef CONFIG_ACPI
diff --git a/drivers/pci/pcie/aer.c b/drivers/pci/pcie/aer.c
index 1235eca0a2e6..70a1493d8aa6 100644
--- a/drivers/pci/pcie/aer.c
+++ b/drivers/pci/pcie/aer.c
@@ -420,7 +420,16 @@ void pci_aer_clear_fatal_status(struct pci_dev *dev)
 		pci_write_config_dword(dev, pos + PCI_ERR_UNCOR_STATUS, status);
 }
 
-int pci_cleanup_aer_error_status_regs(struct pci_dev *dev)
+/**
+ * pci_aer_raw_clear_status - Clear AER error registers.
+ * @dev: the PCI device
+ *
+ * NOTE: Allows clearing error registers in both FF and
+ * non FF modes.
+ *
+ * Returns 0 on success, or negative on failure.
+ */
+int pci_aer_raw_clear_status(struct pci_dev *dev)
 {
 	int pos;
 	u32 status;
@@ -433,9 +442,6 @@ int pci_cleanup_aer_error_status_regs(struct pci_dev *dev)
 	if (!pos)
 		return -EIO;
 
-	if (pcie_aer_get_firmware_first(dev))
-		return -EIO;
-
 	port_type = pci_pcie_type(dev);
 	if (port_type == PCI_EXP_TYPE_ROOT_PORT) {
 		pci_read_config_dword(dev, pos + PCI_ERR_ROOT_STATUS, &status);
@@ -451,6 +457,14 @@ int pci_cleanup_aer_error_status_regs(struct pci_dev *dev)
 	return 0;
 }
 
+int pci_cleanup_aer_error_status_regs(struct pci_dev *dev)
+{
+	if (pcie_aer_get_firmware_first(dev))
+		return -EIO;
+
+	return pci_aer_raw_clear_status(dev);
+}
+
 void pci_save_aer_state(struct pci_dev *dev)
 {
 	struct pci_cap_saved_state *save_state;
-- 
2.21.0

