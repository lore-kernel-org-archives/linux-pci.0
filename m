Return-Path: <SRS0=PFnE=OC=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ADF5AC43441
	for <linux-pci@archiver.kernel.org>; Fri, 23 Nov 2018 17:00:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5FA4420863
	for <linux-pci@archiver.kernel.org>; Fri, 23 Nov 2018 17:00:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=synopsys.com header.i=@synopsys.com header.b="gDEzFaaW"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5FA4420863
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=synopsys.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-pci-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2436993AbeKXDpr (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Fri, 23 Nov 2018 22:45:47 -0500
Received: from us01smtprelay-2.synopsys.com ([198.182.60.111]:43068 "EHLO
        smtprelay.synopsys.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2391367AbeKXDpq (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 23 Nov 2018 22:45:46 -0500
Received: from mailhost.synopsys.com (mailhost1.synopsys.com [10.12.238.239])
        by smtprelay.synopsys.com (Postfix) with ESMTP id 0F24810C0909;
        Fri, 23 Nov 2018 09:00:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=synopsys.com; s=mail;
        t=1542992444; bh=Kn/ps6iF2Wz3k8Li+M7/HyvlX3akEHWDXji1nvIS6qg=;
        h=From:To:Cc:Subject:Date:From;
        b=gDEzFaaWIXQpjWYgfjejsLWKajqNNnSOUvr1G5zZvm5Qa1aOT9b4YNDHNXRITWdSO
         6zFZLcBhnsRst7QbpYiuPzNh7ftcqLF+KbPrgPq8iSopXbsVxdjzpbHFc7KY4upDv/
         LIDrK49Ih1S2zC94MzXMMnEK89NMgA5tf3w14ux2cVbm7VXTSdVpBD55tLhf9RwFeX
         NOs4qL6G9F1/UKUlnajRwQSiYZl6syX2LaCwsiXO4QYJ27H0LZ7/ue29EPLfjMvEuV
         Xrw7yUT7toS6CzLpEc09Y5MPmK/4tFsqIZwhvO+uq9HCLZlgAoh9Tqs3Qw9pcDdFZE
         o0TOl1XezD+nQ==
Received: from de02.synopsys.com (de02.internal.synopsys.com [10.225.17.21])
        by mailhost.synopsys.com (Postfix) with ESMTP id BD40F5566;
        Fri, 23 Nov 2018 09:00:43 -0800 (PST)
Received: from de02dwia024.internal.synopsys.com (de02dwia024.internal.synopsys.com [10.225.19.81])
        by de02.synopsys.com (Postfix) with ESMTP id CA6537C7D;
        Fri, 23 Nov 2018 18:00:42 +0100 (CET)
From:   Gustavo Pimentel <gustavo.pimentel@synopsys.com>
To:     jingoohan1@gmail.com, bhelgaas@google.com,
        lorenzo.pieralisi@arm.com
Cc:     joao.pinto@synopsys.com, linux-pci@vger.kernel.org,
        Gustavo Pimentel <gustavo.pimentel@synopsys.com>,
        stable@vger.kernel.org
Subject: [PATCH v2] PCI: dwc: Fix MSI-X EP framework address calculation bug
Date:   Fri, 23 Nov 2018 18:00:21 +0100
Message-Id: <7d7ec9c537b5aa6cac918b0201572efb14dc89c3.1542992421.git.gustavo.pimentel@synopsys.com>
X-Mailer: git-send-email 2.7.4
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Fixes an error caused by 3-bit right rotation on offset address
calculation of MSI-X table in dw_pcie_ep_raise_msix_irq().

During the development time, by default the offset address of MSI-X
table was set to zero, so that even with a 3-bit right rotation the
computed result would still be zero and valid, therefore not being
noticed this bug.

Fixes: beb4641a787d ("PCI: dwc: Add MSI-X callbacks handler")
Signed-off-by: Gustavo Pimentel <gustavo.pimentel@synopsys.com>
Cc: stable@vger.kernel.org
---
 drivers/pci/controller/dwc/pcie-designware-ep.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/pci/controller/dwc/pcie-designware-ep.c b/drivers/pci/controller/dwc/pcie-designware-ep.c
index 1e7b022..de8635a 100644
--- a/drivers/pci/controller/dwc/pcie-designware-ep.c
+++ b/drivers/pci/controller/dwc/pcie-designware-ep.c
@@ -440,7 +440,6 @@ int dw_pcie_ep_raise_msix_irq(struct dw_pcie_ep *ep, u8 func_no,
 	tbl_offset = dw_pcie_readl_dbi(pci, reg);
 	bir = (tbl_offset & PCI_MSIX_TABLE_BIR);
 	tbl_offset &= PCI_MSIX_TABLE_OFFSET;
-	tbl_offset >>= 3;
 
 	reg = PCI_BASE_ADDRESS_0 + (4 * bir);
 	bar_addr_upper = 0;
-- 
2.7.4

