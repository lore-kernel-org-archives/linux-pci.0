Return-Path: <SRS0=lMXa=OB=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3A21FC43441
	for <linux-pci@archiver.kernel.org>; Thu, 22 Nov 2018 16:24:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EECED206B2
	for <linux-pci@archiver.kernel.org>; Thu, 22 Nov 2018 16:24:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=synopsys.com header.i=@synopsys.com header.b="WeFzhiuA"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EECED206B2
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=synopsys.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-pci-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2395383AbeKWDEq (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Thu, 22 Nov 2018 22:04:46 -0500
Received: from us01smtprelay-2.synopsys.com ([198.182.60.111]:41836 "EHLO
        smtprelay.synopsys.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2395258AbeKWDEq (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 22 Nov 2018 22:04:46 -0500
Received: from mailhost.synopsys.com (mailhost1.synopsys.com [10.12.238.239])
        by smtprelay.synopsys.com (Postfix) with ESMTP id BDC2010C13DB;
        Thu, 22 Nov 2018 08:24:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=synopsys.com; s=mail;
        t=1542903882; bh=GdJJ8Msy/9aSgdBYlMbr2GiFqyMyNIZ4EObwk0SjbNc=;
        h=From:To:Cc:Subject:Date:From;
        b=WeFzhiuAnmD9eu8wP6d2dA8/cRoV1QLkmGPfIAEx5QUMau/lp1QENxBHSWphbtyoH
         x64qlc41jQB+nbCX8RUuMZRa0CcFcW2OI/iT0DtTs7LBKHsynZWMMYrjM2NVq3O7gQ
         BU4nXrpCVxAtRWPCukKfzoJZ+CHYfqifrWaB1uY1k6bimCq/qOZfmUr0esl0I1likc
         YeyS2lxxq0CKpgQyDC30kZdEtyDa/dXC9PBsfOwJjJWHp7C3nC9+GP5y63OEGOO1Yo
         qBn4dZ668P/BTOi8lzlIQ05MpC/YSePIsmy118K7TL3+s6r0tchR0jA1PmqbcN7fWP
         7rJvJ8l28wEkw==
Received: from de02.synopsys.com (germany.internal.synopsys.com [10.225.17.21])
        by mailhost.synopsys.com (Postfix) with ESMTP id 7E54B5614;
        Thu, 22 Nov 2018 08:24:42 -0800 (PST)
Received: from de02dwia024.internal.synopsys.com (de02dwia024.internal.synopsys.com [10.225.19.81])
        by de02.synopsys.com (Postfix) with ESMTP id AF14E3F776;
        Thu, 22 Nov 2018 17:24:41 +0100 (CET)
From:   Gustavo Pimentel <gustavo.pimentel@synopsys.com>
To:     lorenzo.pieralisi@arm.com, jingoohan1@gmail.com,
        bhelgaas@google.com
Cc:     joao.pinto@synopsys.com, linux-pci@vger.kernel.org,
        Gustavo Pimentel <gustavo.pimentel@synopsys.com>
Subject: [PATCH] PCI: dwc: Remove 3-bit right rotation on MSI-X table offset address calculation
Date:   Thu, 22 Nov 2018 17:24:28 +0100
Message-Id: <a9c24a70e23dbc5a2d0300452588dc6a0b5e218a.1542903868.git.gustavo.pimentel@synopsys.com>
X-Mailer: git-send-email 2.7.4
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Remove 3-bit right rotation on MSI-X table offset address calculation on
dw_pcie_ep_raise_msix_irq().

By default, the offset address of the MSI-X table is zero, so that even with a
3-bit right rotation, the computed result would still be zero, so still valid.

Fixes: beb4641a787d ("PCI: dwc: Add MSI-X callbacks handler")

Signed-off-by: Gustavo Pimentel <gustavo.pimentel@synopsys.com>
---
 drivers/pci/controller/dwc/pcie-designware-ep.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/drivers/pci/controller/dwc/pcie-designware-ep.c b/drivers/pci/controller/dwc/pcie-designware-ep.c
index 1e7b022..cdb2005 100644
--- a/drivers/pci/controller/dwc/pcie-designware-ep.c
+++ b/drivers/pci/controller/dwc/pcie-designware-ep.c
@@ -440,7 +440,6 @@ int dw_pcie_ep_raise_msix_irq(struct dw_pcie_ep *ep, u8 func_no,
 	tbl_offset = dw_pcie_readl_dbi(pci, reg);
 	bir = (tbl_offset & PCI_MSIX_TABLE_BIR);
 	tbl_offset &= PCI_MSIX_TABLE_OFFSET;
-	tbl_offset >>= 3;
 
 	reg = PCI_BASE_ADDRESS_0 + (4 * bir);
 	bar_addr_upper = 0;
@@ -466,8 +465,10 @@ int dw_pcie_ep_raise_msix_irq(struct dw_pcie_ep *ep, u8 func_no,
 
 	iounmap(msix_tbl);
 
-	if (vec_ctrl & PCI_MSIX_ENTRY_CTRL_MASKBIT)
+	if (vec_ctrl & PCI_MSIX_ENTRY_CTRL_MASKBIT) {
+		dev_err(pci->dev, "MSI-X entry ctrl set\n");
 		return -EPERM;
+	}
 
 	ret = dw_pcie_ep_map_addr(epc, func_no, ep->msi_mem_phys, msg_addr,
 				  epc->mem->page_size);
-- 
2.7.4

