Return-Path: <SRS0=Emu/=SZ=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F0243C10F03
	for <linux-pci@archiver.kernel.org>; Tue, 23 Apr 2019 18:30:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BE3E7218FD
	for <linux-pci@archiver.kernel.org>; Tue, 23 Apr 2019 18:30:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=synopsys.com header.i=@synopsys.com header.b="Eb9p287W"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726075AbfDWSaZ (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Tue, 23 Apr 2019 14:30:25 -0400
Received: from smtprelay-out1.synopsys.com ([198.182.61.142]:60364 "EHLO
        smtprelay-out1.synopsys.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725945AbfDWSaZ (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 23 Apr 2019 14:30:25 -0400
Received: from mailhost.synopsys.com (dc2-mailhost2.synopsys.com [10.12.135.162])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
        (No client certificate requested)
        by smtprelay-out1.synopsys.com (Postfix) with ESMTPS id 2A17EC0B0D;
        Tue, 23 Apr 2019 18:30:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=synopsys.com; s=mail;
        t=1556044224; bh=50CWiIlnfqP3gzk/lakYJkAsP60XpEenB/h1ngbItYI=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:In-Reply-To:
         References:From;
        b=Eb9p287WgE1aV15Nk+VSB8QmaetmkIXcxVqkx5O/rdzTb0NEG981TKC6To7k7rctK
         wtTXtnNmuXxtpqECGWFImISOJVNV88JGrPmqU8DAGuzMH53fDao4+9jDXFebaFgZ9d
         enVnxGEQZsN4vVeQwwAHQGLWlJQ4hE4Pp4Or10tcmtZuo+UP32bKMPxOF2cso0vjHi
         zGU/3XxZVf6lqTqdbyhrIGyLnzXF/31gMIexH7qn/+N5yts9TdAp5/LVHV15edawpC
         s3jIBaiD+1fPY2+ddWzd/46SBwWo4hsakXVfSfc/dc8OeiP0IP8K+4EziThb2Gy8EJ
         SJESk11AiK7zA==
Received: from de02.synopsys.com (de02.internal.synopsys.com [10.225.17.21])
        by mailhost.synopsys.com (Postfix) with ESMTP id AE0ABA00A0;
        Tue, 23 Apr 2019 18:30:24 +0000 (UTC)
Received: from de02dwia024.internal.synopsys.com (de02dwia024.internal.synopsys.com [10.225.19.81])
        by de02.synopsys.com (Postfix) with ESMTP id E48C73F82E;
        Tue, 23 Apr 2019 20:30:23 +0200 (CEST)
From:   Gustavo Pimentel <Gustavo.Pimentel@synopsys.com>
To:     linux-pci@vger.kernel.org, dmaengine@vger.kernel.org
Cc:     Gustavo Pimentel <Gustavo.Pimentel@synopsys.com>,
        Kishon Vijay Abraham I <kishon@ti.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Joao Pinto <Joao.Pinto@synopsys.com>
Subject: [RFC v6 4/6] PCI: Add Synopsys endpoint EDDA Device ID
Date:   Tue, 23 Apr 2019 20:30:11 +0200
Message-Id: <687ccde83fd386f9f8af074c666f5a3c96485826.1556043127.git.gustavo.pimentel@synopsys.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <cover.1556043127.git.gustavo.pimentel@synopsys.com>
References: <cover.1556043127.git.gustavo.pimentel@synopsys.com>
In-Reply-To: <cover.1556043127.git.gustavo.pimentel@synopsys.com>
References: <cover.1556043127.git.gustavo.pimentel@synopsys.com>
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Create and add Synopsys Endpoint EDDA Device ID to PCI ID list, since
this ID is now being use on two different drivers (pci_endpoint_test.ko
and dw-edma-pcie.ko).

Signed-off-by: Gustavo Pimentel <gustavo.pimentel@synopsys.com>
Acked-by: Bjorn Helgaas <bhelgaas@google.com>
Cc: Kishon Vijay Abraham I <kishon@ti.com>
Cc: Bjorn Helgaas <bhelgaas@google.com>
Cc: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
Cc: Joao Pinto <jpinto@synopsys.com>
---
Changes:
RFC v1->RFC v2:
 - Reword subject line patch
 - Reorder patch order on the series
RFC v2->RFC v3:
 - Rebase to v5.0-rc1
RFC v3->RFC v4:
 - Replace id by ID on title and description
RFC v4->RFC v5:
 - Patch resended, forgot to replace of '___' by '---' and to remove
 duplicate signed-off
RFC v5->RFC v6:
 - Following patch version

 drivers/misc/pci_endpoint_test.c | 2 +-
 include/linux/pci_ids.h          | 1 +
 2 files changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/misc/pci_endpoint_test.c b/drivers/misc/pci_endpoint_test.c
index 29582fe..f65a882 100644
--- a/drivers/misc/pci_endpoint_test.c
+++ b/drivers/misc/pci_endpoint_test.c
@@ -789,7 +789,7 @@ static const struct pci_device_id pci_endpoint_test_tbl[] = {
 	{ PCI_DEVICE(PCI_VENDOR_ID_TI, PCI_DEVICE_ID_TI_DRA74x) },
 	{ PCI_DEVICE(PCI_VENDOR_ID_TI, PCI_DEVICE_ID_TI_DRA72x) },
 	{ PCI_DEVICE(PCI_VENDOR_ID_FREESCALE, 0x81c0) },
-	{ PCI_DEVICE(PCI_VENDOR_ID_SYNOPSYS, 0xedda) },
+	{ PCI_DEVICE_DATA(SYNOPSYS, EDDA, NULL) },
 	{ }
 };
 MODULE_DEVICE_TABLE(pci, pci_endpoint_test_tbl);
diff --git a/include/linux/pci_ids.h b/include/linux/pci_ids.h
index 70e8614..4aad69f 100644
--- a/include/linux/pci_ids.h
+++ b/include/linux/pci_ids.h
@@ -2366,6 +2366,7 @@
 #define PCI_DEVICE_ID_SYNOPSYS_HAPSUSB3		0xabcd
 #define PCI_DEVICE_ID_SYNOPSYS_HAPSUSB3_AXI	0xabce
 #define PCI_DEVICE_ID_SYNOPSYS_HAPSUSB31	0xabcf
+#define PCI_DEVICE_ID_SYNOPSYS_EDDA	0xedda
 
 #define PCI_VENDOR_ID_USR		0x16ec
 
-- 
2.7.4

