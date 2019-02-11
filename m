Return-Path: <SRS0=XN0A=QS=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8A5EDC169C4
	for <linux-pci@archiver.kernel.org>; Mon, 11 Feb 2019 17:34:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5D2A821B18
	for <linux-pci@archiver.kernel.org>; Mon, 11 Feb 2019 17:34:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=synopsys.com header.i=@synopsys.com header.b="AfiGAvvK"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731746AbfBKRek (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Mon, 11 Feb 2019 12:34:40 -0500
Received: from us01smtprelay-2.synopsys.com ([198.182.47.9]:36476 "EHLO
        smtprelay.synopsys.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731027AbfBKRek (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 11 Feb 2019 12:34:40 -0500
Received: from mailhost.synopsys.com (dc2-mailhost2.synopsys.com [10.12.135.162])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by smtprelay.synopsys.com (Postfix) with ESMTPS id E673A24E0DA5;
        Mon, 11 Feb 2019 09:34:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=synopsys.com; s=mail;
        t=1549906479; bh=d+i2MiBWKahRqTWzsq/4GZZQ1nAeJJDEJQuQ+qtE3+A=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:In-Reply-To:
         References:From;
        b=AfiGAvvK922t64Ladr0sSn9ipVMjzLbDfOUZD2KAXYHdbudJl0T5q48vHah5+8+Hv
         Xd+SE+ks/ixfMKgpdYqwp3XKqiWX8uSf7ccuW6MPFDgcIqoXeO6ZRzpkI7sSmnNyBx
         cIUykPI2jL7kp6a4k1sSGPtsmD8Q/Y5DChmJhJS6Z4pZGTiOcsIIZHj0aP6QrGS3BZ
         o7UAIhWB5zyw/xJ9/XkON3EGWsCFTVQ6RZPNWOwN1TqQsUjPIYXDZPDeY2bVR2Asca
         i+SDGip3VWuQjQSDqs2tmz6l98zSstTgHFLxsmloootgZcMdTHkzV0ZAwK4EGEHtKI
         YZ6WVJpLxp3Pg==
Received: from de02.synopsys.com (de02.internal.synopsys.com [10.225.17.21])
        by mailhost.synopsys.com (Postfix) with ESMTP id 8BCF9A00A6;
        Mon, 11 Feb 2019 17:34:39 +0000 (UTC)
Received: from de02dwia024.internal.synopsys.com (de02dwia024.internal.synopsys.com [10.225.19.81])
        by de02.synopsys.com (Postfix) with ESMTP id C18F93C235;
        Mon, 11 Feb 2019 18:34:38 +0100 (CET)
From:   Gustavo Pimentel <gustavo.pimentel@synopsys.com>
To:     linux-pci@vger.kernel.org, dmaengine@vger.kernel.org
Cc:     Gustavo Pimentel <gustavo.pimentel@synopsys.com>,
        Kishon Vijay Abraham I <kishon@ti.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Niklas Cassel <niklas.cassel@linaro.org>,
        Joao Pinto <joao.pinto@synopsys.com>,
        Jose Abreu <jose.abreu@synopsys.com>,
        Luis Oliveira <luis.oliveira@synopsys.com>,
        Vitor Soares <vitor.soares@synopsys.com>,
        Nelson Costa <nelson.costa@synopsys.com>,
        Pedro Sousa <pedrom.sousa@synopsys.com>
Subject: [RFC v5 4/6] PCI: Add Synopsys endpoint EDDA Device ID
Date:   Mon, 11 Feb 2019 18:34:33 +0100
Message-Id: <65b86e1a5d4ae82a3e9baa97974446f60b789123.1549905325.git.gustavo.pimentel@synopsys.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <cover.1549905325.git.gustavo.pimentel@synopsys.com>
References: <cover.1549905325.git.gustavo.pimentel@synopsys.com>
In-Reply-To: <cover.1549905325.git.gustavo.pimentel@synopsys.com>
References: <cover.1549905325.git.gustavo.pimentel@synopsys.com>
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
Cc: Niklas Cassel <niklas.cassel@linaro.org>
Cc: Joao Pinto <jpinto@synopsys.com>
Cc: Jose Abreu <jose.abreu@synopsys.com>
Cc: Luis Oliveira <lolivei@synopsys.com>
Cc: Vitor Soares <vitor.soares@synopsys.com>
Cc: Nelson Costa <nelson.costa@synopsys.com>
Cc: Pedro Sousa <pedrom.sousa@synopsys.com>
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

drivers/misc/pci_endpoint_test.c | 2 +-
 include/linux/pci_ids.h          | 1 +
 2 files changed, 2 insertions(+), 1 deletion(-)

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

