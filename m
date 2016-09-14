Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from smtp.codeaurora.org ([198.145.29.96]:42847 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1765721AbcINVO5 (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 14 Sep 2016 17:14:57 -0400
From: Tyler Baicar <tbaicar@codeaurora.org>
To: rjw@rjwysocki.net, lenb@kernel.org, bhelgaas@google.com,
        paul.gortmaker@windriver.com, sudipm.mukherjee@gmail.com,
        axboe@fb.com, izumi.taku@jp.fujitsu.com,
        linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-pci@vger.kernel.org
Cc: bp@suse.de, Tyler Baicar <tbaicar@codeaurora.org>
Subject: [PATCH V2 1/2] PCI/AER: Remove duplicate AER severity translation
Date: Wed, 14 Sep 2016 15:14:45 -0600
Message-Id: <1473887686-24420-2-git-send-email-tbaicar@codeaurora.org>
In-Reply-To: <1473887686-24420-1-git-send-email-tbaicar@codeaurora.org>
References: <1473887686-24420-1-git-send-email-tbaicar@codeaurora.org>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Currently the AER severity is being translated twice in
the code flow for PCIe errors. It is first translated in
ghes_do_proc() before calling into the AER driver. Then it
is translated again when the AER driver calls cper_print_aer().
This causes the severity that is used in cper_print_aer() to
be incorrect. Remove the second translation that is in
cper_print_aer() since this function is already receiving the
correct AER severity.

Signed-off-by: Tyler Baicar <tbaicar@codeaurora.org>
Reviewed-by: Borislav Petkov <bp@suse.de>
---
 drivers/pci/pcie/aer/aerdrv_errprint.c | 6 ++----
 include/linux/aer.h                    | 2 +-
 2 files changed, 3 insertions(+), 5 deletions(-)

diff --git a/drivers/pci/pcie/aer/aerdrv_errprint.c b/drivers/pci/pcie/aer/aerdrv_errprint.c
index 167fe41..54c4b69 100644
--- a/drivers/pci/pcie/aer/aerdrv_errprint.c
+++ b/drivers/pci/pcie/aer/aerdrv_errprint.c
@@ -219,15 +219,13 @@ int cper_severity_to_aer(int cper_severity)
 }
 EXPORT_SYMBOL_GPL(cper_severity_to_aer);
 
-void cper_print_aer(struct pci_dev *dev, int cper_severity,
+void cper_print_aer(struct pci_dev *dev, int aer_severity,
 		    struct aer_capability_regs *aer)
 {
-	int aer_severity, layer, agent, status_strs_size, tlp_header_valid = 0;
+	int layer, agent, status_strs_size, tlp_header_valid = 0;
 	u32 status, mask;
 	const char **status_strs;
 
-	aer_severity = cper_severity_to_aer(cper_severity);
-
 	if (aer_severity == AER_CORRECTABLE) {
 		status = aer->cor_status;
 		mask = aer->cor_mask;
diff --git a/include/linux/aer.h b/include/linux/aer.h
index 1640493..04602cb 100644
--- a/include/linux/aer.h
+++ b/include/linux/aer.h
@@ -63,7 +63,7 @@ static inline int pci_cleanup_aer_error_status_regs(struct pci_dev *dev)
 }
 #endif
 
-void cper_print_aer(struct pci_dev *dev, int cper_severity,
+void cper_print_aer(struct pci_dev *dev, int aer_severity,
 		    struct aer_capability_regs *aer);
 int cper_severity_to_aer(int cper_severity);
 void aer_recover_queue(int domain, unsigned int bus, unsigned int devfn,
-- 
Qualcomm Datacenter Technologies, Inc. as an affiliate of Qualcomm Technologies, Inc.
Qualcomm Technologies, Inc. is a member of the Code Aurora Forum,
a Linux Foundation Collaborative Project.

