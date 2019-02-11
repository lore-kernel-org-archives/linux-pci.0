Return-Path: <SRS0=XN0A=QS=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B7E24C282D7
	for <linux-pci@archiver.kernel.org>; Mon, 11 Feb 2019 06:20:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 864C42176F
	for <linux-pci@archiver.kernel.org>; Mon, 11 Feb 2019 06:20:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725986AbfBKGUj (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Mon, 11 Feb 2019 01:20:39 -0500
Received: from szxga06-in.huawei.com ([45.249.212.32]:55598 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725931AbfBKGUj (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Mon, 11 Feb 2019 01:20:39 -0500
Received: from DGGEMS414-HUB.china.huawei.com (unknown [172.30.72.60])
        by Forcepoint Email with ESMTP id 49574476F5D903C95020;
        Mon, 11 Feb 2019 14:20:34 +0800 (CST)
Received: from linux-ioko.site (10.71.200.31) by
 DGGEMS414-HUB.china.huawei.com (10.3.19.214) with Microsoft SMTP Server id
 14.3.408.0; Mon, 11 Feb 2019 14:20:23 +0800
From:   Dongdong Liu <liudongdong3@huawei.com>
To:     <helgaas@kernel.org>, <keith.busch@intel.com>, <okaya@kernel.org>
CC:     <linux-pci@vger.kernel.org>, <linuxarm@huawei.com>,
        Dongdong Liu <liudongdong3@huawei.com>,
        <stable@vger.kernel.org>, Bjorn Helgaas <bhelgaas@google.com>
Subject: [PATCH RESEND] PCI/DPC: Fix print AER status in DPC event handling
Date:   Mon, 11 Feb 2019 15:02:59 +0800
Message-ID: <1549868579-125090-1-git-send-email-liudongdong3@huawei.com>
X-Mailer: git-send-email 1.9.1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.71.200.31]
X-CFilter-Loop: Reflected
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Current info->severity have not assigned a value before calling
aer_get_device_error_info() and aer_get_device_error_info(),
Fix the bug to get the severity by reading the port's AER status, mask
and severity registers. At the same time, add code to clear the port's
fatal errors.

Fixes: 8aefa9b0d910 ("PCI/DPC: Print AER status in DPC event handling")
Signed-off-by: Dongdong Liu <liudongdong3@huawei.com>
Cc: stable@vger.kernel.org
Cc: Keith Busch <keith.busch@intel.com>
Cc: Bjorn Helgaas <bhelgaas@google.com>
---
 drivers/pci/pcie/dpc.c | 27 ++++++++++++++++++++++++++-
 1 file changed, 26 insertions(+), 1 deletion(-)

diff --git a/drivers/pci/pcie/dpc.c b/drivers/pci/pcie/dpc.c
index e435d12..7b77754 100644
--- a/drivers/pci/pcie/dpc.c
+++ b/drivers/pci/pcie/dpc.c
@@ -202,6 +202,28 @@ static void dpc_process_rp_pio_error(struct dpc_dev *dpc)
 	pci_write_config_dword(pdev, cap + PCI_EXP_DPC_RP_PIO_STATUS, status);
 }
 
+static int dpc_get_aer_uncorrect_severity(struct pci_dev *dev,
+					  struct aer_err_info *info)
+{
+	int pos = dev->aer_cap;
+	u32 status, mask, sev;
+
+	pci_read_config_dword(dev, pos + PCI_ERR_UNCOR_STATUS, &status);
+	pci_read_config_dword(dev, pos + PCI_ERR_UNCOR_MASK, &mask);
+	status &= ~mask;
+	if (!status)
+		return 0;
+
+	pci_read_config_dword(dev, pos + PCI_ERR_UNCOR_SEVER, &sev);
+	status &= sev;
+	if (status)
+		info->severity = AER_FATAL;
+	else
+		info->severity = AER_NONFATAL;
+
+	return 1;
+}
+
 static irqreturn_t dpc_handler(int irq, void *context)
 {
 	struct aer_err_info info;
@@ -229,9 +251,12 @@ static irqreturn_t dpc_handler(int irq, void *context)
 	/* show RP PIO error detail information */
 	if (dpc->rp_extensions && reason == 3 && ext_reason == 0)
 		dpc_process_rp_pio_error(dpc);
-	else if (reason == 0 && aer_get_device_error_info(pdev, &info)) {
+	else if (reason == 0 &&
+		 dpc_get_aer_uncorrect_severity(pdev, &info) &&
+		 aer_get_device_error_info(pdev, &info)) {
 		aer_print_error(pdev, &info);
 		pci_cleanup_aer_uncorrect_error_status(pdev);
+		pci_aer_clear_fatal_status(pdev);
 	}
 
 	/* We configure DPC so it only triggers on ERR_FATAL */
-- 
1.9.1

