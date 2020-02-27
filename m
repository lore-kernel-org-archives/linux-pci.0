Return-Path: <SRS0=fw3j=4P=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BADE5C3F2CD
	for <linux-pci@archiver.kernel.org>; Thu, 27 Feb 2020 22:36:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8F551246A6
	for <linux-pci@archiver.kernel.org>; Thu, 27 Feb 2020 22:36:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730345AbgB0Wgn (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Thu, 27 Feb 2020 17:36:43 -0500
Received: from mga18.intel.com ([134.134.136.126]:49955 "EHLO mga18.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730310AbgB0Wgn (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Thu, 27 Feb 2020 17:36:43 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by orsmga106.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 27 Feb 2020 14:36:43 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.70,493,1574150400"; 
   d="scan'208";a="238568413"
Received: from jekeller-desk.amr.corp.intel.com (HELO jekeller-desk.jekeller.internal) ([10.166.244.172])
  by orsmga003.jf.intel.com with ESMTP; 27 Feb 2020 14:36:43 -0800
From:   Jacob Keller <jacob.e.keller@intel.com>
To:     linux-pci@vger.kernel.org, netdev@vger.kernel.org
Cc:     Jacob Keller <jacob.e.keller@intel.com>,
        Michael Chan <michael.chan@broadcom.com>
Subject: [PATCH 2/5] bnxt_en: use pci_get_dsn
Date:   Thu, 27 Feb 2020 14:36:32 -0800
Message-Id: <20200227223635.1021197-4-jacob.e.keller@intel.com>
X-Mailer: git-send-email 2.25.0.368.g28a2d05eebfb
In-Reply-To: <20200227223635.1021197-1-jacob.e.keller@intel.com>
References: <20200227223635.1021197-1-jacob.e.keller@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Replace the open-coded implementation for reading the PCIe DSN with
pci_get_dsn.

Signed-off-by: Jacob Keller <jacob.e.keller@intel.com>
Cc: Michael Chan <michael.chan@broadcom.com>
---
 drivers/net/ethernet/broadcom/bnxt/bnxt.c | 14 ++++----------
 1 file changed, 4 insertions(+), 10 deletions(-)

diff --git a/drivers/net/ethernet/broadcom/bnxt/bnxt.c b/drivers/net/ethernet/broadcom/bnxt/bnxt.c
index 597e6fd5bfea..55f078fc067e 100644
--- a/drivers/net/ethernet/broadcom/bnxt/bnxt.c
+++ b/drivers/net/ethernet/broadcom/bnxt/bnxt.c
@@ -11755,20 +11755,14 @@ static int bnxt_init_mac_addr(struct bnxt *bp)
 static int bnxt_pcie_dsn_get(struct bnxt *bp, u8 dsn[])
 {
 	struct pci_dev *pdev = bp->pdev;
-	int pos = pci_find_ext_capability(pdev, PCI_EXT_CAP_ID_DSN);
-	u32 dw;
+	int err;
 
-	if (!pos) {
+	err = pci_get_dsn(pdev, dsn);
+	if (err) {
 		netdev_info(bp->dev, "Unable do read adapter's DSN");
-		return -EOPNOTSUPP;
+		return err;
 	}
 
-	/* DSN (two dw) is at an offset of 4 from the cap pos */
-	pos += 4;
-	pci_read_config_dword(pdev, pos, &dw);
-	put_unaligned_le32(dw, &dsn[0]);
-	pci_read_config_dword(pdev, pos + 4, &dw);
-	put_unaligned_le32(dw, &dsn[4]);
 	bp->flags |= BNXT_FLAG_DSN_VALID;
 	return 0;
 }
-- 
2.25.0.368.g28a2d05eebfb

