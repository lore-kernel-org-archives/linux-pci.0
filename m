Return-Path: <SRS0=ZQeV=OV=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CDAB5C6783B
	for <linux-pci@archiver.kernel.org>; Wed, 12 Dec 2018 11:13:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 902302084E
	for <linux-pci@archiver.kernel.org>; Wed, 12 Dec 2018 11:13:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=synopsys.com header.i=@synopsys.com header.b="URSML/eb"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 902302084E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=synopsys.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-pci-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727188AbeLLLN6 (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Wed, 12 Dec 2018 06:13:58 -0500
Received: from smtprelay.synopsys.com ([198.182.60.111]:35104 "EHLO
        smtprelay.synopsys.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727159AbeLLLN6 (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 12 Dec 2018 06:13:58 -0500
Received: from mailhost.synopsys.com (mailhost2.synopsys.com [10.13.184.66])
        by smtprelay.synopsys.com (Postfix) with ESMTP id 1F2A110C0461;
        Wed, 12 Dec 2018 03:13:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=synopsys.com; s=mail;
        t=1544613238; bh=bQxyfyjhbeTLF292y1bLb172w8Quqj/1rP22rG8cDyM=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:In-Reply-To:
         References:From;
        b=URSML/ebVHSIquut8oyhUbU3fQ/jwnry3RTsAcD8ctjkNb10jDYG1EZhJr4iwDt+W
         qjBnl/pVxtKiRl+fQZ7QhcM+3y4QKYbFhUpI5Gqb8KykdBg8rwx/xRr8UACPxhlYJZ
         fLUOADD39YHdogVcOrgpLhxP25fIFiLT2LTjP4oGZyXN7kCPd6+fOlM2qhnQMIvte/
         BZpOGpq5XWU3yL2GQL9If28d52q+814aQNYyyHE8nyZUzi32kcMufaLEl5IW1T03xB
         RWdstKJLDRWrrgnobF4niZLcFq5nxbyjm4FqNIY/HgG3h1/2ZbDyvXuSF3OHCW0knH
         SkKC/95R5J7Jw==
Received: from de02.synopsys.com (de02.internal.synopsys.com [10.225.17.21])
        by mailhost.synopsys.com (Postfix) with ESMTP id DB8703E25;
        Wed, 12 Dec 2018 03:13:57 -0800 (PST)
Received: from de02dwia024.internal.synopsys.com (de02dwia024.internal.synopsys.com [10.225.19.81])
        by de02.synopsys.com (Postfix) with ESMTP id 8A6B33BDE6;
        Wed, 12 Dec 2018 12:13:57 +0100 (CET)
From:   Gustavo Pimentel <gustavo.pimentel@synopsys.com>
To:     linux-pci@vger.kernel.org, dmaengine@vger.kernel.org
Cc:     Gustavo Pimentel <gustavo.pimentel@synopsys.com>,
        Kishon Vijay Abraham I <kishon@ti.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Joao Pinto <joao.pinto@synopsys.com>
Subject: [RFC 6/6] pci: pci_ids: Add Synopsys device id 0xedda
Date:   Wed, 12 Dec 2018 12:13:26 +0100
Message-Id: <df5417ded1e55e5f994ab0ec7f696ddba83eaa35.1544610287.git.gustavo.pimentel@synopsys.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <cover.1544610287.git.gustavo.pimentel@synopsys.com>
References: <cover.1544610287.git.gustavo.pimentel@synopsys.com>
In-Reply-To: <cover.1544610287.git.gustavo.pimentel@synopsys.com>
References: <cover.1544610287.git.gustavo.pimentel@synopsys.com>
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Create and add Synopsys device id (0xedda) to pci id list, since this id
is now being use on two different drivers (pci_endpoint_test.ko and
dw-edma-pcie.ko).

Signed-off-by: Gustavo Pimentel <gustavo.pimentel@synopsys.com>
Cc: Kishon Vijay Abraham I <kishon@ti.com>
Cc: Bjorn Helgaas <bhelgaas@google.com>
Cc: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
Cc: Joao Pinto <jpinto@synopsys.com>
---
 drivers/dma/dw-edma/dw-edma-pcie.c | 2 +-
 drivers/misc/pci_endpoint_test.c   | 2 +-
 include/linux/pci_ids.h            | 1 +
 3 files changed, 3 insertions(+), 2 deletions(-)

diff --git a/drivers/dma/dw-edma/dw-edma-pcie.c b/drivers/dma/dw-edma/dw-edma-pcie.c
index f29a861..50e0db4 100644
--- a/drivers/dma/dw-edma/dw-edma-pcie.c
+++ b/drivers/dma/dw-edma/dw-edma-pcie.c
@@ -280,7 +280,7 @@ static const struct dev_pm_ops dw_edma_pcie_dev_pm_ops = {
 };
 
 static const struct pci_device_id dw_edma_pcie_id_table[] = {
-	{ PCI_DEVICE_DATA(SYNOPSYS, 0xedda, &snps_edda_data) },
+	{ PCI_DEVICE_DATA(SYNOPSYS, EDDA, &snps_edda_data) },
 	{ }
 };
 MODULE_DEVICE_TABLE(pci, dw_edma_pcie_id_table);
diff --git a/drivers/misc/pci_endpoint_test.c b/drivers/misc/pci_endpoint_test.c
index 896e2df..d27efe838 100644
--- a/drivers/misc/pci_endpoint_test.c
+++ b/drivers/misc/pci_endpoint_test.c
@@ -788,7 +788,7 @@ static void pci_endpoint_test_remove(struct pci_dev *pdev)
 static const struct pci_device_id pci_endpoint_test_tbl[] = {
 	{ PCI_DEVICE(PCI_VENDOR_ID_TI, PCI_DEVICE_ID_TI_DRA74x) },
 	{ PCI_DEVICE(PCI_VENDOR_ID_TI, PCI_DEVICE_ID_TI_DRA72x) },
-	{ PCI_DEVICE(PCI_VENDOR_ID_SYNOPSYS, 0xedda) },
+	{ PCI_DEVICE_DATA(SYNOPSYS, EDDA, NULL) },
 	{ }
 };
 MODULE_DEVICE_TABLE(pci, pci_endpoint_test_tbl);
diff --git a/include/linux/pci_ids.h b/include/linux/pci_ids.h
index 69f0abe..57f17dd 100644
--- a/include/linux/pci_ids.h
+++ b/include/linux/pci_ids.h
@@ -2358,6 +2358,7 @@
 #define PCI_DEVICE_ID_CENATEK_IDE	0x0001
 
 #define PCI_VENDOR_ID_SYNOPSYS		0x16c3
+#define PCI_DEVICE_ID_SYNOPSYS_EDDA	0xedda
 
 #define PCI_VENDOR_ID_VITESSE		0x1725
 #define PCI_DEVICE_ID_VITESSE_VSC7174	0x7174
-- 
2.7.4

