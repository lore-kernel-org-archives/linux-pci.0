Return-Path: <SRS0=Sdll=QA=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.0 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 58E1DC282C3
	for <linux-pci@archiver.kernel.org>; Thu, 24 Jan 2019 13:15:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 31AA921855
	for <linux-pci@archiver.kernel.org>; Thu, 24 Jan 2019 13:15:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727725AbfAXNP3 (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Thu, 24 Jan 2019 08:15:29 -0500
Received: from szxga06-in.huawei.com ([45.249.212.32]:60880 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727799AbfAXNP3 (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Thu, 24 Jan 2019 08:15:29 -0500
Received: from DGGEMS405-HUB.china.huawei.com (unknown [172.30.72.59])
        by Forcepoint Email with ESMTP id 53FE13E5C68F3DA888F5;
        Thu, 24 Jan 2019 21:15:27 +0800 (CST)
Received: from linux-ioko.site (10.71.200.31) by
 DGGEMS405-HUB.china.huawei.com (10.3.19.205) with Microsoft SMTP Server id
 14.3.408.0; Thu, 24 Jan 2019 21:15:17 +0800
From:   Dongdong Liu <liudongdong3@huawei.com>
To:     <helgaas@kernel.org>, <keith.busch@intel.com>
CC:     <linux-pci@vger.kernel.org>, <linuxarm@huawei.com>,
        Dongdong Liu <liudongdong3@huawei.com>,
        Bjorn Helgaas <bhelgaas@google.com>
Subject: [PATCH] PCI/ERR: Fix run error recovery callbacks for all affected devices
Date:   Thu, 24 Jan 2019 21:50:10 +0800
Message-ID: <1548337810-69892-1-git-send-email-liudongdong3@huawei.com>
X-Mailer: git-send-email 1.9.1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.71.200.31]
X-CFilter-Loop: Reflected
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

The patch [1] PCI/ERR: Run error recovery callbacks for all affected
devices have broken the non-fatal error handling logic in patch [2].
For non-fatal error, link is reliable, so no need to reset link,
handle non-fatal error for all subordinates seems incorrect.
Restore the non-fatal errors process logic.

[1] PCI/ERR: Run error recovery callbacks for all affected devices   #4.20
https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=bfcb79fca19d267712e425af1dd48812c40dec0c

[2] PCI/AER: Report non-fatal errors only to the affected endpoint  #4.15
https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?h=v5.0-rc2&id=86acc790717fb60fb51ea3095084e331d8711c74

Fixes: bfcb79fca19d ("PCI/ERR: Run error recovery callbacks for all affected devices")
Reported-by: Xiaofei Tan <tanxiaofei@huawei.com>
Signed-off-by: Dongdong Liu <liudongdong3@huawei.com>
Cc: Keith Busch <keith.busch@intel.com>
Cc: Bjorn Helgaas <bhelgaas@google.com>
---
 drivers/pci/pcie/err.c | 37 ++++++++++++++++++++++++++++---------
 1 file changed, 28 insertions(+), 9 deletions(-)

diff --git a/drivers/pci/pcie/err.c b/drivers/pci/pcie/err.c
index 773197a..9de3880 100644
--- a/drivers/pci/pcie/err.c
+++ b/drivers/pci/pcie/err.c
@@ -187,7 +187,8 @@ void pcie_do_recovery(struct pci_dev *dev, enum pci_channel_state state,
 		      u32 service)
 {
 	pci_ers_result_t status = PCI_ERS_RESULT_CAN_RECOVER;
-	struct pci_bus *bus;
+	struct pci_bus *bus = dev->bus;
+	struct pci_dev *bridge = dev;
 
 	/*
 	 * Error recovery runs on all subordinates of the first downstream port.
@@ -195,23 +196,33 @@ void pcie_do_recovery(struct pci_dev *dev, enum pci_channel_state state,
 	 */
 	if (!(pci_pcie_type(dev) == PCI_EXP_TYPE_ROOT_PORT ||
 	      pci_pcie_type(dev) == PCI_EXP_TYPE_DOWNSTREAM))
-		dev = dev->bus->self;
-	bus = dev->subordinate;
+		bridge = bus->self;
+
+	if (bridge)
+		bus = bridge->subordinate;
 
 	pci_dbg(dev, "broadcast error_detected message\n");
 	if (state == pci_channel_io_frozen)
 		pci_walk_bus(bus, report_frozen_detected, &status);
-	else
-		pci_walk_bus(bus, report_normal_detected, &status);
+	else {
+		if (dev->hdr_type != PCI_HEADER_TYPE_BRIDGE)
+			report_normal_detected(dev, &status);
+		else
+			pci_walk_bus(bus, report_normal_detected, &status);
+	}
 
 	if (state == pci_channel_io_frozen &&
-	    reset_link(dev, service) != PCI_ERS_RESULT_RECOVERED)
+	    reset_link(bridge, service) != PCI_ERS_RESULT_RECOVERED)
 		goto failed;
 
 	if (status == PCI_ERS_RESULT_CAN_RECOVER) {
 		status = PCI_ERS_RESULT_RECOVERED;
 		pci_dbg(dev, "broadcast mmio_enabled message\n");
-		pci_walk_bus(bus, report_mmio_enabled, &status);
+		if (state == pci_channel_io_normal &&
+		    dev->hdr_type != PCI_HEADER_TYPE_BRIDGE)
+			report_mmio_enabled(dev, &status);
+		else
+			pci_walk_bus(bus, report_mmio_enabled, &status);
 	}
 
 	if (status == PCI_ERS_RESULT_NEED_RESET) {
@@ -222,14 +233,22 @@ void pcie_do_recovery(struct pci_dev *dev, enum pci_channel_state state,
 		 */
 		status = PCI_ERS_RESULT_RECOVERED;
 		pci_dbg(dev, "broadcast slot_reset message\n");
-		pci_walk_bus(bus, report_slot_reset, &status);
+		if (state == pci_channel_io_normal &&
+		    dev->hdr_type != PCI_HEADER_TYPE_BRIDGE)
+			report_slot_reset(dev, &status);
+		else
+			pci_walk_bus(bus, report_slot_reset, &status);
 	}
 
 	if (status != PCI_ERS_RESULT_RECOVERED)
 		goto failed;
 
 	pci_dbg(dev, "broadcast resume message\n");
-	pci_walk_bus(bus, report_resume, &status);
+	if (state == pci_channel_io_normal &&
+	    dev->hdr_type != PCI_HEADER_TYPE_BRIDGE)
+		report_resume(dev, &status);
+	else
+		pci_walk_bus(bus, report_resume, &status);
 
 	pci_aer_clear_device_status(dev);
 	pci_cleanup_aer_uncorrect_error_status(dev);
-- 
1.9.1

