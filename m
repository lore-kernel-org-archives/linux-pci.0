Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-ia0-f179.google.com ([209.85.210.179]:50995 "EHLO
	mail-ia0-f179.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752993Ab3DVXKV (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Mon, 22 Apr 2013 19:10:21 -0400
Received: by mail-ia0-f179.google.com with SMTP id p22so10546iad.10
        for <linux-pci@vger.kernel.org>; Mon, 22 Apr 2013 16:10:21 -0700 (PDT)
Subject: [PATCH v4 01/22] [SCSI] megaraid_sas: Use correct #define for MSI-X
 capability
To: linux-pci@vger.kernel.org
From: Bjorn Helgaas <bhelgaas@google.com>
Cc: Neela Syam Kolli <megaraidlinux@lsi.com>,
	Gavin Shan <shangw@linux.vnet.ibm.com>,
	"James E.J. Bottomley" <JBottomley@parallels.com>
Date: Mon, 22 Apr 2013 17:10:19 -0600
Message-ID: <20130422231019.32621.25028.stgit@bhelgaas-glaptop>
In-Reply-To: <20130422230012.32621.15224.stgit@bhelgaas-glaptop>
References: <20130422230012.32621.15224.stgit@bhelgaas-glaptop>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Previously we used PCI_MSI_FLAGS to locate a register in the MSI-X
capability.  This did work because the MSI and MSI-X flags happen
to be at the same offsets, but was confusing.

PCI_MSIX_FLAGS_ENABLE is already defined in include/uapi/linux/pci_regs.h,
so no need to define it again.

Signed-off-by: Bjorn Helgaas <bhelgaas@google.com>
CC: Neela Syam Kolli <megaraidlinux@lsi.com>
CC: "James E.J. Bottomley" <JBottomley@parallels.com>
---
 drivers/scsi/megaraid/megaraid_sas.h      |    3 ---
 drivers/scsi/megaraid/megaraid_sas_base.c |    4 ++--
 2 files changed, 2 insertions(+), 5 deletions(-)

diff --git a/drivers/scsi/megaraid/megaraid_sas.h b/drivers/scsi/megaraid/megaraid_sas.h
index 408d254..684cc34 100644
--- a/drivers/scsi/megaraid/megaraid_sas.h
+++ b/drivers/scsi/megaraid/megaraid_sas.h
@@ -1488,7 +1488,4 @@ struct megasas_mgmt_info {
 	int max_index;
 };
 
-#define msi_control_reg(base) (base + PCI_MSI_FLAGS)
-#define PCI_MSIX_FLAGS_ENABLE (1 << 15)
-
 #endif				/*LSI_MEGARAID_SAS_H */
diff --git a/drivers/scsi/megaraid/megaraid_sas_base.c b/drivers/scsi/megaraid/megaraid_sas_base.c
index 9d53540..7c90d57 100644
--- a/drivers/scsi/megaraid/megaraid_sas_base.c
+++ b/drivers/scsi/megaraid/megaraid_sas_base.c
@@ -3984,12 +3984,12 @@ static int megasas_probe_one(struct pci_dev *pdev,
 	if (reset_devices) {
 		pos = pci_find_capability(pdev, PCI_CAP_ID_MSIX);
 		if (pos) {
-			pci_read_config_word(pdev, msi_control_reg(pos),
+			pci_read_config_word(pdev, pos + PCI_MSIX_FLAGS,
 					     &control);
 			if (control & PCI_MSIX_FLAGS_ENABLE) {
 				dev_info(&pdev->dev, "resetting MSI-X\n");
 				pci_write_config_word(pdev,
-						      msi_control_reg(pos),
+						      pos + PCI_MSIX_FLAGS,
 						      control &
 						      ~PCI_MSIX_FLAGS_ENABLE);
 			}

