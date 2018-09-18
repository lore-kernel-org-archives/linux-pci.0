Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mga14.intel.com ([192.55.52.115]:7927 "EHLO mga14.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726960AbeISFd7 (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Wed, 19 Sep 2018 01:33:59 -0400
From: Keith Busch <keith.busch@intel.com>
To: Linux PCI <linux-pci@vger.kernel.org>,
        Bjorn Helgaas <bhelgaas@google.com>
Cc: Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Sinan Kaya <okaya@kernel.org>,
        Thomas Tai <thomas.tai@oracle.com>, poza@codeaurora.org,
        Lukas Wunner <lukas@wunner.de>, Christoph Hellwig <hch@lst.de>,
        Mika Westerberg <mika.westerberg@linux.intel.com>,
        Keith Busch <keith.busch@intel.com>
Subject: [PATCH 06/12] PCI/AER: Remove error source from aer struct
Date: Tue, 18 Sep 2018 17:58:42 -0600
Message-Id: <20180918235848.26694-7-keith.busch@intel.com>
In-Reply-To: <20180918235848.26694-1-keith.busch@intel.com>
References: <20180918235848.26694-1-keith.busch@intel.com>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

The aer struct was carrying a copy of the error source simply as a
temperary variable. This patch removes that from the structure and uses
a stack variable for the purpose.

Signed-off-by: Keith Busch <keith.busch@intel.com>
---
 drivers/pci/pcie/aer.c | 33 ++++++++++++++++-----------------
 1 file changed, 16 insertions(+), 17 deletions(-)

diff --git a/drivers/pci/pcie/aer.c b/drivers/pci/pcie/aer.c
index a66e33868303..72f8b4d6be32 100644
--- a/drivers/pci/pcie/aer.c
+++ b/drivers/pci/pcie/aer.c
@@ -44,7 +44,6 @@ struct aer_rpc {
 	struct pci_dev *rpd;		/* Root Port device */
 	struct work_struct dpc_handler;
 	struct aer_err_source e_sources[AER_ERROR_SOURCES_MAX];
-	struct aer_err_info e_info;
 	unsigned short prod_idx;	/* Error Producer Index */
 	unsigned short cons_idx;	/* Error Consumer Index */
 	int isr;
@@ -1175,7 +1174,7 @@ static void aer_isr_one_error(struct aer_rpc *rpc,
 		struct aer_err_source *e_src)
 {
 	struct pci_dev *pdev = rpc->rpd;
-	struct aer_err_info *e_info = &rpc->e_info;
+	struct aer_err_info e_info;
 
 	pci_rootport_aer_stats_incr(pdev, e_src);
 
@@ -1184,36 +1183,36 @@ static void aer_isr_one_error(struct aer_rpc *rpc,
 	 * uncorrectable error being logged. Report correctable error first.
 	 */
 	if (e_src->status & PCI_ERR_ROOT_COR_RCV) {
-		e_info->id = ERR_COR_ID(e_src->id);
-		e_info->severity = AER_CORRECTABLE;
+		e_info.id = ERR_COR_ID(e_src->id);
+		e_info.severity = AER_CORRECTABLE;
 
 		if (e_src->status & PCI_ERR_ROOT_MULTI_COR_RCV)
-			e_info->multi_error_valid = 1;
+			e_info.multi_error_valid = 1;
 		else
-			e_info->multi_error_valid = 0;
-		aer_print_port_info(pdev, e_info);
+			e_info.multi_error_valid = 0;
+		aer_print_port_info(pdev, &e_info);
 
-		if (find_source_device(pdev, e_info))
-			aer_process_err_devices(e_info);
+		if (find_source_device(pdev, &e_info))
+			aer_process_err_devices(&e_info);
 	}
 
 	if (e_src->status & PCI_ERR_ROOT_UNCOR_RCV) {
-		e_info->id = ERR_UNCOR_ID(e_src->id);
+		e_info.id = ERR_UNCOR_ID(e_src->id);
 
 		if (e_src->status & PCI_ERR_ROOT_FATAL_RCV)
-			e_info->severity = AER_FATAL;
+			e_info.severity = AER_FATAL;
 		else
-			e_info->severity = AER_NONFATAL;
+			e_info.severity = AER_NONFATAL;
 
 		if (e_src->status & PCI_ERR_ROOT_MULTI_UNCOR_RCV)
-			e_info->multi_error_valid = 1;
+			e_info.multi_error_valid = 1;
 		else
-			e_info->multi_error_valid = 0;
+			e_info.multi_error_valid = 0;
 
-		aer_print_port_info(pdev, e_info);
+		aer_print_port_info(pdev, &e_info);
 
-		if (find_source_device(pdev, e_info))
-			aer_process_err_devices(e_info);
+		if (find_source_device(pdev, &e_info))
+			aer_process_err_devices(&e_info);
 	}
 }
 
-- 
2.14.4
