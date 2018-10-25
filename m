Return-Path: <SRS0=18Ni=NF=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EA111C46475
	for <linux-pci@archiver.kernel.org>; Thu, 25 Oct 2018 17:52:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9FD0A20854
	for <linux-pci@archiver.kernel.org>; Thu, 25 Oct 2018 17:52:25 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9FD0A20854
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-pci-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727615AbeJZC0L (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Thu, 25 Oct 2018 22:26:11 -0400
Received: from mga05.intel.com ([192.55.52.43]:1799 "EHLO mga05.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727439AbeJZC0L (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Thu, 25 Oct 2018 22:26:11 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by fmsmga105.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 25 Oct 2018 10:52:24 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.54,425,1534834800"; 
   d="scan'208";a="84468283"
Received: from unknown (HELO localhost.localdomain.localdomain) ([10.232.117.194])
  by orsmga008.jf.intel.com with ESMTP; 25 Oct 2018 10:52:24 -0700
From:   Jon Derrick <jonathan.derrick@intel.com>
To:     <linux-pci@vger.kernel.org>
Cc:     Bjorn Helgaas <helgaas@kernel.org>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Jon Derrick <jonathan.derrick@intel.com>
Subject: [PATCH] PCI/MSI: Prevent MSI/X masking IO to a removed device
Date:   Thu, 25 Oct 2018 11:44:49 -0600
Message-Id: <1540489489-2622-1-git-send-email-jonathan.derrick@intel.com>
X-Mailer: git-send-email 1.8.3.1
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

A removed device won't be able to accept mmio or config cycles setting
or clearing MSI/X mask bits. Shortcut this path by preventing the writes
and subsequent reads which may result in unsupported requests or
completer abort.

Signed-off-by: Jon Derrick <jonathan.derrick@intel.com>
---
 drivers/pci/msi.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/drivers/pci/msi.c b/drivers/pci/msi.c
index af24ed5..3a41024 100644
--- a/drivers/pci/msi.c
+++ b/drivers/pci/msi.c
@@ -227,6 +227,14 @@ static void msi_set_mask_bit(struct irq_data *data, u32 flag)
 {
 	struct msi_desc *desc = irq_data_get_msi_desc(data);
 
+	/*
+	 * Prevent non-posted IO to the device if it has been removed and is in
+	 * the process of removal cleanup, in order to prevent unsupported
+	 * requests or completer aborts or other issues.
+	 */
+	if (pci_dev_is_disconnected(msi_desc_to_pci_dev(desc)))
+		return;
+
 	if (desc->msi_attrib.is_msix) {
 		msix_mask_irq(desc, flag);
 		readl(desc->mask_base);		/* Flush write to device */
-- 
1.8.3.1

