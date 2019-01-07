Return-Path: <SRS0=70A0=PP=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D7E01C43387
	for <linux-pci@archiver.kernel.org>; Mon,  7 Jan 2019 21:31:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AC47D2087F
	for <linux-pci@archiver.kernel.org>; Mon,  7 Jan 2019 21:31:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726721AbfAGVbV (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Mon, 7 Jan 2019 16:31:21 -0500
Received: from mga12.intel.com ([192.55.52.136]:11834 "EHLO mga12.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726535AbfAGVbU (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Mon, 7 Jan 2019 16:31:20 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by fmsmga106.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 07 Jan 2019 13:31:20 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.56,451,1539673200"; 
   d="scan'208";a="124044990"
Received: from jprestwo-test.jf.intel.com ([10.54.74.26])
  by FMSMGA003.fm.intel.com with ESMTP; 07 Jan 2019 13:31:19 -0800
From:   James Prestwood <james.prestwood@linux.intel.com>
To:     linux-pci@vger.kernel.org
Cc:     James Prestwood <james.prestwood@linux.intel.com>
Subject: [PATCH] PCI: quirks: add vendor ID for AR9462 card
Date:   Mon,  7 Jan 2019 13:32:48 -0800
Message-Id: <20190107213248.3034-1-james.prestwood@linux.intel.com>
X-Mailer: git-send-email 2.17.1
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

This card has similar issues with bus reset as the others present in
this list.

Signed-off-by: James Prestwood <james.prestwood@linux.intel.com>
---
 drivers/pci/quirks.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/pci/quirks.c b/drivers/pci/quirks.c
index ef7143a274e0..d9d4a95b0309 100644
--- a/drivers/pci/quirks.c
+++ b/drivers/pci/quirks.c
@@ -3379,6 +3379,7 @@ DECLARE_PCI_FIXUP_HEADER(PCI_VENDOR_ID_ATHEROS, 0x0030, quirk_no_bus_reset);
 DECLARE_PCI_FIXUP_HEADER(PCI_VENDOR_ID_ATHEROS, 0x0032, quirk_no_bus_reset);
 DECLARE_PCI_FIXUP_HEADER(PCI_VENDOR_ID_ATHEROS, 0x003c, quirk_no_bus_reset);
 DECLARE_PCI_FIXUP_HEADER(PCI_VENDOR_ID_ATHEROS, 0x0033, quirk_no_bus_reset);
+DECLARE_PCI_FIXUP_HEADER(PCI_VENDOR_ID_ATHEROS, 0x0034, quirk_no_bus_reset);
 
 /*
  * Root port on some Cavium CN8xxx chips do not successfully complete a bus
-- 
2.17.1

