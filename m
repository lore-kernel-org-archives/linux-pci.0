Return-Path: <SRS0=OOKX=Z7=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B6872C2D0C3
	for <linux-pci@archiver.kernel.org>; Mon,  9 Dec 2019 03:20:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8C52F206E0
	for <linux-pci@archiver.kernel.org>; Mon,  9 Dec 2019 03:20:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727089AbfLIDU1 (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Sun, 8 Dec 2019 22:20:27 -0500
Received: from mga14.intel.com ([192.55.52.115]:37235 "EHLO mga14.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727084AbfLIDU1 (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Sun, 8 Dec 2019 22:20:27 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by fmsmga103.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 08 Dec 2019 19:20:27 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.69,294,1571727600"; 
   d="scan'208";a="387102974"
Received: from sgsxdev004.isng.intel.com (HELO localhost) ([10.226.88.13])
  by orsmga005.jf.intel.com with ESMTP; 08 Dec 2019 19:20:23 -0800
From:   Dilip Kota <eswara.kota@linux.intel.com>
To:     lorenzo.pieralisi@arm.com, linux-pci@vger.kernel.org,
        devicetree@vger.kernel.org
Cc:     jingoohan1@gmail.com, gustavo.pimentel@synopsys.com,
        andrew.murray@arm.com, robh@kernel.org,
        linux-kernel@vger.kernel.org, andriy.shevchenko@intel.com,
        cheol.yong.kim@intel.com, chuanhua.lei@linux.intel.com,
        qi-ming.wu@intel.com, Dilip Kota <eswara.kota@linux.intel.com>
Subject: [PATCH v11 3/3] PCI: artpec6: Configure FTS with dwc helper function
Date:   Mon,  9 Dec 2019 11:20:06 +0800
Message-Id: <d862101a58286c30636a5f4671861ac4f076bfb8.1575860791.git.eswara.kota@linux.intel.com>
X-Mailer: git-send-email 2.11.0
In-Reply-To: <cover.1575860791.git.eswara.kota@linux.intel.com>
References: <cover.1575860791.git.eswara.kota@linux.intel.com>
In-Reply-To: <cover.1575860791.git.eswara.kota@linux.intel.com>
References: <cover.1575860791.git.eswara.kota@linux.intel.com>
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Use DesignWare helper functions to configure Fast Training
Sequence. Drop the respective code in the driver.

Signed-off-by: Dilip Kota <eswara.kota@linux.intel.com>
Signed-off-by: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
Reviewed-by: Andrew Murray <andrew.murray@arm.com>
---
 drivers/pci/controller/dwc/pcie-artpec6.c | 8 +-------
 1 file changed, 1 insertion(+), 7 deletions(-)

diff --git a/drivers/pci/controller/dwc/pcie-artpec6.c b/drivers/pci/controller/dwc/pcie-artpec6.c
index 9e2482bd7b6d..28d5a1095200 100644
--- a/drivers/pci/controller/dwc/pcie-artpec6.c
+++ b/drivers/pci/controller/dwc/pcie-artpec6.c
@@ -51,9 +51,6 @@ static const struct of_device_id artpec6_pcie_of_match[];
 #define ACK_N_FTS_MASK			GENMASK(15, 8)
 #define ACK_N_FTS(x)			(((x) << 8) & ACK_N_FTS_MASK)
 
-#define FAST_TRAINING_SEQ_MASK		GENMASK(7, 0)
-#define FAST_TRAINING_SEQ(x)		(((x) << 0) & FAST_TRAINING_SEQ_MASK)
-
 /* ARTPEC-6 specific registers */
 #define PCIECFG				0x18
 #define  PCIECFG_DBG_OEN		BIT(24)
@@ -313,10 +310,7 @@ static void artpec6_pcie_set_nfts(struct artpec6_pcie *artpec6_pcie)
 	 * Set the Number of Fast Training Sequences that the core
 	 * advertises as its N_FTS during Gen2 or Gen3 link training.
 	 */
-	val = dw_pcie_readl_dbi(pci, PCIE_LINK_WIDTH_SPEED_CONTROL);
-	val &= ~FAST_TRAINING_SEQ_MASK;
-	val |= FAST_TRAINING_SEQ(180);
-	dw_pcie_writel_dbi(pci, PCIE_LINK_WIDTH_SPEED_CONTROL, val);
+	dw_pcie_link_set_n_fts(pci, 180);
 }
 
 static void artpec6_pcie_assert_core_reset(struct artpec6_pcie *artpec6_pcie)
-- 
2.11.0

