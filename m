Return-Path: <linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-18.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DA6A8C433E6
	for <linux-pci@archiver.kernel.org>; Thu, 11 Feb 2021 09:18:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A513B64E7D
	for <linux-pci@archiver.kernel.org>; Thu, 11 Feb 2021 09:18:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230269AbhBKJSQ (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Thu, 11 Feb 2021 04:18:16 -0500
Received: from smtprelay-out1.synopsys.com ([149.117.87.133]:56822 "EHLO
        smtprelay-out1.synopsys.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S230116AbhBKJOM (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 11 Feb 2021 04:14:12 -0500
Received: from mailhost.synopsys.com (mdc-mailhost2.synopsys.com [10.225.0.210])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
        (No client certificate requested)
        by smtprelay-out1.synopsys.com (Postfix) with ESMTPS id 7039EC00C6;
        Thu, 11 Feb 2021 09:13:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=synopsys.com; s=mail;
        t=1613034785; bh=Q8p1awFRWvZQwAEJydjROiaIceJgT6c3cpPWic23uwQ=;
        h=From:To:Subject:Date:In-Reply-To:References:In-Reply-To:
         References:From;
        b=JMEqSAo9+yi5dBa43QLxPS5+YC6iilA3oR0ulB4co5lCik2v3DXiDvWkIPbwKK9Hl
         RxsrEuxZoasCqKL8Yz4EZuXX8zEN3stioxE5A0TRyGYIjjYfxC2FRZSfWdHgSDgtT7
         kiFTnpY+1olGV6IntnHO9V1MMOwyhuUknpZZoKE950aDaZOxVs+Rvqv7/yMjmEWAF4
         z9AAR+fOd/D67hWgyX51hZqZv2kfW609yUF4rCBY3HaYwWmQ05BjpFpjWUyjwaO0He
         a/qLHb08MxR5vP5lkTlD9Z8+2d7DibYzNdg2yLZAa5Ak17ejGzkYtC5OdfQTaK5c4T
         Yhy4ZHXURH2VA==
Received: from de02dwia024.internal.synopsys.com (de02dwia024.internal.synopsys.com [10.225.19.81])
        by mailhost.synopsys.com (Postfix) with ESMTP id 36FAAA01F1;
        Thu, 11 Feb 2021 09:13:04 +0000 (UTC)
X-SNPS-Relay: synopsys.com
From:   Gustavo Pimentel <Gustavo.Pimentel@synopsys.com>
To:     dmaengine@vger.kernel.org, linux-pci@vger.kernel.org,
        linux-kernel@vger.kernel.org, Vinod Koul <vkoul@kernel.org>,
        Dan Williams <dan.j.williams@intel.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Gustavo Pimentel <Gustavo.Pimentel@synopsys.com>
Subject: [PATCH v5 10/15] dmaengine: dw-edma: Change linked list and data blocks offset and sizes
Date:   Thu, 11 Feb 2021 10:12:43 +0100
Message-Id: <9e60326f906093f1110bcde6286b8f743c8f19f9.1613034728.git.gustavo.pimentel@synopsys.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <cover.1613034728.git.gustavo.pimentel@synopsys.com>
References: <cover.1613034728.git.gustavo.pimentel@synopsys.com>
In-Reply-To: <cover.1613034728.git.gustavo.pimentel@synopsys.com>
References: <cover.1613034728.git.gustavo.pimentel@synopsys.com>
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Changes the linked list and data blocks offset and sizes to follow the
recommendation given by the hardware team for the IPK solution.

Although the previous data blocks offset and sizes are still valid and
functional, using them that might present some issues related to the IPK
solution, since this solution is based on FPGA and might be subjected to
timmings constrains.

Signed-off-by: Gustavo Pimentel <gustavo.pimentel@synopsys.com>
---
 drivers/dma/dw-edma/dw-edma-pcie.c | 32 ++++++++++++++++----------------
 1 file changed, 16 insertions(+), 16 deletions(-)

diff --git a/drivers/dma/dw-edma/dw-edma-pcie.c b/drivers/dma/dw-edma/dw-edma-pcie.c
index a0fa809..686b4ff 100644
--- a/drivers/dma/dw-edma/dw-edma-pcie.c
+++ b/drivers/dma/dw-edma/dw-edma-pcie.c
@@ -59,29 +59,29 @@ static const struct dw_edma_pcie_data snps_edda_data = {
 	.rg.sz				= 0x00002000,	/*  8 Kbytes */
 	/* eDMA memory linked list location */
 	.ll_wr = {
-		/* Channel 0 - BAR 2, offset 0 Mbytes, size 2 Mbytes */
-		DW_BLOCK(BAR_2, 0x00000000, 0x00200000)
-		/* Channel 1 - BAR 2, offset 2 Mbytes, size 2 Mbytes */
-		DW_BLOCK(BAR_2, 0x00200000, 0x00200000)
+		/* Channel 0 - BAR 2, offset 0 Mbytes, size 2 Kbytes */
+		DW_BLOCK(BAR_2, 0x00000000, 0x00000800)
+		/* Channel 1 - BAR 2, offset 2 Mbytes, size 2 Kbytes */
+		DW_BLOCK(BAR_2, 0x00200000, 0x00000800)
 	},
 	.ll_rd = {
-		/* Channel 0 - BAR 2, offset 4 Mbytes, size 2 Mbytes */
-		DW_BLOCK(BAR_2, 0x00400000, 0x00200000)
-		/* Channel 1 - BAR 2, offset 6 Mbytes, size 2 Mbytes */
-		DW_BLOCK(BAR_2, 0x00600000, 0x00200000)
+		/* Channel 0 - BAR 2, offset 4 Mbytes, size 2 Kbytes */
+		DW_BLOCK(BAR_2, 0x00400000, 0x00000800)
+		/* Channel 1 - BAR 2, offset 6 Mbytes, size 2 Kbytes */
+		DW_BLOCK(BAR_2, 0x00600000, 0x00000800)
 	},
 	/* eDMA memory data location */
 	.dt_wr = {
-		/* Channel 0 - BAR 2, offset 8 Mbytes, size 14 Mbytes */
-		DW_BLOCK(BAR_2, 0x00800000, 0x00e00000)
-		/* Channel 1 - BAR 2, offset 22 Mbytes, size 14 Mbytes */
-		DW_BLOCK(BAR_2, 0x01600000, 0x00e00000)
+		/* Channel 0 - BAR 2, offset 8 Mbytes, size 2 Kbytes */
+		DW_BLOCK(BAR_2, 0x00800000, 0x00000800)
+		/* Channel 1 - BAR 2, offset 9 Mbytes, size 2 Kbytes */
+		DW_BLOCK(BAR_2, 0x00900000, 0x00000800)
 	},
 	.dt_rd = {
-		/* Channel 0 - BAR 2, offset 36 Mbytes, size 14 Mbytes */
-		DW_BLOCK(BAR_2, 0x02400000, 0x00e00000)
-		/* Channel 1 - BAR 2, offset 50 Mbytes, size 14 Mbytes */
-		DW_BLOCK(BAR_2, 0x03200000, 0x00e00000)
+		/* Channel 0 - BAR 2, offset 10 Mbytes, size 2 Kbytes */
+		DW_BLOCK(BAR_2, 0x00a00000, 0x00000800)
+		/* Channel 1 - BAR 2, offset 11 Mbytes, size 2 Kbytes */
+		DW_BLOCK(BAR_2, 0x00b00000, 0x00000800)
 	},
 	/* Other */
 	.mf				= EDMA_MF_EDMA_UNROLL,
-- 
2.7.4

