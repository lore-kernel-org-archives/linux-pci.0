Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-oi0-f65.google.com ([209.85.218.65]:44398 "EHLO
        mail-oi0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751906AbeC2VYp (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 29 Mar 2018 17:24:45 -0400
Received: by mail-oi0-f65.google.com with SMTP id j143-v6so6350525oih.11
        for <linux-pci@vger.kernel.org>; Thu, 29 Mar 2018 14:24:45 -0700 (PDT)
From: Alexandru Gagniuc <mr.nuke.me@gmail.com>
To: linux-pci@vger.kernel.org
Cc: alex_gagniuc@dellteam.com, austin_bolen@dellteam.com,
        bhelgaas@google.com, fred@fredlawl.com, gregkh@linuxfoundation.org,
        Alexandru Gagniuc <mr.nuke.me@gmail.com>
Subject: [PATCH] PCI/AER: Use a common function to print AER error bits
Date: Thu, 29 Mar 2018 16:24:35 -0500
Message-Id: <20180329212435.13277-1-mr.nuke.me@gmail.com>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On errors reported from CPER, cper_print_bits() was used to log the
AER bits. This resulted in hard-to-understand messages, without a
prefix. Instead use __aer_print_error() for both native AER and CPER
to provide a more consistent log format.

Signed-off-by: Alexandru Gagniuc <mr.nuke.me@gmail.com>
---
 drivers/pci/pcie/aer/aerdrv_errprint.c | 16 +++++++++-------
 1 file changed, 9 insertions(+), 7 deletions(-)

diff --git a/drivers/pci/pcie/aer/aerdrv_errprint.c b/drivers/pci/pcie/aer/aerdrv_errprint.c
index 6a352e638699..7cef8492c6d8 100644
--- a/drivers/pci/pcie/aer/aerdrv_errprint.c
+++ b/drivers/pci/pcie/aer/aerdrv_errprint.c
@@ -219,28 +219,30 @@ EXPORT_SYMBOL_GPL(cper_severity_to_aer);
 void cper_print_aer(struct pci_dev *dev, int aer_severity,
 		    struct aer_capability_regs *aer)
 {
-	int layer, agent, status_strs_size, tlp_header_valid = 0;
+	int layer, agent, tlp_header_valid = 0;
 	u32 status, mask;
-	const char **status_strs;
+	struct aer_err_info info;
 
 	if (aer_severity == AER_CORRECTABLE) {
 		status = aer->cor_status;
 		mask = aer->cor_mask;
-		status_strs = aer_correctable_error_string;
-		status_strs_size = ARRAY_SIZE(aer_correctable_error_string);
 	} else {
 		status = aer->uncor_status;
 		mask = aer->uncor_mask;
-		status_strs = aer_uncorrectable_error_string;
-		status_strs_size = ARRAY_SIZE(aer_uncorrectable_error_string);
 		tlp_header_valid = status & AER_LOG_TLP_MASKS;
 	}
 
 	layer = AER_GET_LAYER_ERROR(aer_severity, status);
 	agent = AER_GET_AGENT(aer_severity, status);
 
+	memset(&info, 0, sizeof(info));
+	info.severity = aer_severity;
+	info.status = status;
+	info.mask = mask;
+	info.first_error = 0x1f;
+
 	pci_err(dev, "aer_status: 0x%08x, aer_mask: 0x%08x\n", status, mask);
-	cper_print_bits("", status, status_strs, status_strs_size);
+	__aer_print_error(dev, &info);
 	pci_err(dev, "aer_layer=%s, aer_agent=%s\n",
 		aer_error_layer[layer], aer_agent_string[agent]);
 
-- 
2.14.3
