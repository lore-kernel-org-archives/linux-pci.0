Return-Path: <SRS0=ZQO4=QM=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 95BD8C282CB
	for <linux-pci@archiver.kernel.org>; Tue,  5 Feb 2019 04:57:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 661CB2081B
	for <linux-pci@archiver.kernel.org>; Tue,  5 Feb 2019 04:57:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="CR0ODXMl"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727630AbfBEE5y (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Mon, 4 Feb 2019 23:57:54 -0500
Received: from mail-pg1-f195.google.com ([209.85.215.195]:40413 "EHLO
        mail-pg1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725947AbfBEE5y (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 4 Feb 2019 23:57:54 -0500
Received: by mail-pg1-f195.google.com with SMTP id z10so904583pgp.7
        for <linux-pci@vger.kernel.org>; Mon, 04 Feb 2019 20:57:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=Zru6go97O+voj3WvByWsomLzeqljS4c2Zg0aKG5L14k=;
        b=CR0ODXMlxHlxnhb4EKVfWfp0RxhXihztgOwDvU1TYPUDtJEtroTLkpD4P0H48y9Z/D
         bchw8yMzyGGzU7uA1xwyrz2jqemhak8/zB2pAvJvM7tHGv/KLMen882kiWcsHJeKelkW
         1gZIbe1AtJcc5FK2bU+oD5vYs9G8WZ6R7M2nY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=Zru6go97O+voj3WvByWsomLzeqljS4c2Zg0aKG5L14k=;
        b=CFGeCJ3qzI8WRZ6uiuU/rxM8KBITpjKPEUXpnPR3/1Hw2+4QpZduWqFBnYgXNtFadx
         jv5/M+kZtmP8FXqz3Z/PHEB91qyreVnOZL+nVB5oweBjGNPpSsuOnwjpiYHsswOXJOrY
         3K+hXc1fznZwqLvfXtq8pxzYM8CInaFXqd2ZhEnTVIxoMBHNRs1qTUV+vwarcBG2OU3u
         oPvdrOvPuwUXQ7SgZW75wjK1jKsPK9iMmNtcX99EepC438qL0y6vuOnd1uwTWh5i5UF0
         +SQidIVaPqb/A7H8+vBitcvtKBk/sJ5ZnEoVKBPXxZWR+7DEEsBPl2hPPUkwHuyKj5NT
         RPzQ==
X-Gm-Message-State: AHQUAuYqEXpq2DpixGWSg3ZGLdLO3zSMLc/+2/TpgeA6n6r1aDJK9KmJ
        oJPG0sp2bTUwMP1sla4HRFuKxw==
X-Google-Smtp-Source: AHgI3IY8aAGDLiSP7PmZDPwlz4UYyrWxTBiQL5a6sO6hsS+zFjAYrC6s8ztOUTeVUmMFpfTw6T+NIw==
X-Received: by 2002:a63:be4d:: with SMTP id g13mr2873694pgo.378.1549342673003;
        Mon, 04 Feb 2019 20:57:53 -0800 (PST)
Received: from mannams-OptiPlex-7010.dhcp.broadcom.net ([192.19.234.250])
        by smtp.gmail.com with ESMTPSA id r76sm2895164pfb.69.2019.02.04.20.57.49
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Mon, 04 Feb 2019 20:57:52 -0800 (PST)
From:   Srinath Mannam <srinath.mannam@broadcom.com>
To:     Bjorn Helgaas <bhelgaas@google.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Ray Jui <rjui@broadcom.com>,
        Scott Branden <sbranden@broadcom.com>
Cc:     bcm-kernel-feedback-list@broadcom.com, linux-pci@vger.kernel.org,
        iommu@lists.linux-foundation.org, linux-kernel@vger.kernel.org,
        Srinath Mannam <srinath.mannam@broadcom.com>,
        Abhishek Shah <abhishek.shah@broadcom.com>,
        Ray Jui <ray.jui@broadcom.com>
Subject: [PATCH v2 2/2] PCI: iproc: Add PCIe 32bit outbound memory configuration
Date:   Tue,  5 Feb 2019 10:27:01 +0530
Message-Id: <1549342622-9929-3-git-send-email-srinath.mannam@broadcom.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1549342622-9929-1-git-send-email-srinath.mannam@broadcom.com>
References: <1549342622-9929-1-git-send-email-srinath.mannam@broadcom.com>
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Add configuration to support IPROC PCIe host controller outbound memory
window mapping with SOC address range inside 4GB boundary, which is 32 bit
AXI address.

Signed-off-by: Srinath Mannam <srinath.mannam@broadcom.com>
Signed-off-by: Abhishek Shah <abhishek.shah@broadcom.com>
Signed-off-by: Ray Jui <ray.jui@broadcom.com>
Reviewed-by: Scott Branden <scott.branden@broadcom.com>
Reviewed-by: Vikram Prakash <vikram.prakash@broadcom.com>
---
 drivers/pci/controller/pcie-iproc.c | 21 +++++++++++++++++++--
 1 file changed, 19 insertions(+), 2 deletions(-)

diff --git a/drivers/pci/controller/pcie-iproc.c b/drivers/pci/controller/pcie-iproc.c
index b882255..080f142 100644
--- a/drivers/pci/controller/pcie-iproc.c
+++ b/drivers/pci/controller/pcie-iproc.c
@@ -955,8 +955,25 @@ static int iproc_pcie_setup_ob(struct iproc_pcie *pcie, u64 axi_addr,
 			resource_size_t window_size =
 				ob_map->window_sizes[size_idx] * SZ_1M;
 
-			if (size < window_size)
-				continue;
+			/*
+			 * Keep iterating until we reach the last window and
+			 * with the minimal window size at index zero. In this
+			 * case, we take a compromise by mapping it using the
+			 * minimum window size that can be supported
+			 */
+			if (size < window_size) {
+				if (size_idx > 0 || window_idx > 0)
+					continue;
+
+				/*
+				 * For the corner case of reaching the minimal
+				 * window size that can be supported on the
+				 * last window
+				 */
+				axi_addr = ALIGN_DOWN(axi_addr, window_size);
+				pci_addr = ALIGN_DOWN(pci_addr, window_size);
+				size = window_size;
+			}
 
 			if (!IS_ALIGNED(axi_addr, window_size) ||
 			    !IS_ALIGNED(pci_addr, window_size)) {
-- 
2.7.4

