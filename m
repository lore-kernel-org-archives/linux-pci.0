Return-Path: <SRS0=7Kzx=O2=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A1304C43387
	for <linux-pci@archiver.kernel.org>; Mon, 17 Dec 2018 17:19:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7064B21473
	for <linux-pci@archiver.kernel.org>; Mon, 17 Dec 2018 17:19:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=synopsys.com header.i=@synopsys.com header.b="h9rdy2pg"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732312AbeLQRTr (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Mon, 17 Dec 2018 12:19:47 -0500
Received: from smtprelay.synopsys.com ([198.182.47.9]:56462 "EHLO
        smtprelay.synopsys.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726763AbeLQRTr (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 17 Dec 2018 12:19:47 -0500
Received: from mailhost.synopsys.com (mailhost3.synopsys.com [10.12.238.238])
        by smtprelay.synopsys.com (Postfix) with ESMTP id AD26524E27B4;
        Mon, 17 Dec 2018 09:19:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=synopsys.com; s=mail;
        t=1545067186; bh=QV5aupCTNcPLbFBgc6lvYGa0DsqR2VHM/EHqL2GtyQ0=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:In-Reply-To:
         References:From;
        b=h9rdy2pgzvwmJuH2ch9Avwmd0rYUq5gj4qvss1lC3cS3jzfw5udapZHf3bqJaZzxo
         LSUe4p9u44InE3euYNPpxftZMtMbWv/qad8lMYPavrgYcVvTOeW3q1dvFtTFAEiQ//
         uoih4xbOqYUQtvZWTHzW0NJ6DspxEqTG6O/ufcEucxlIX8ydpCtyZrbgAGtLrcpFpT
         PwAadF/CnUW2mlCNHc/PC4h+oxpYRUNcvmdszrqbDpffgwkHn6f6WS5Dcyp07qvdAQ
         wFTqX4PSRzEnMH0t8Eee+kOUYolzsMLd1fLrjy1eABRRNxifNmf8uRZmJCYVxYmEO8
         AgEb+U0ujbjHQ==
Received: from de02.synopsys.com (de02.internal.synopsys.com [10.225.17.21])
        by mailhost.synopsys.com (Postfix) with ESMTP id 480AD30AF;
        Mon, 17 Dec 2018 09:19:46 -0800 (PST)
Received: from de02dwia024.internal.synopsys.com (de02dwia024.internal.synopsys.com [10.225.19.81])
        by de02.synopsys.com (Postfix) with ESMTP id 75F347F30;
        Mon, 17 Dec 2018 18:19:45 +0100 (CET)
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
Subject: [RFC v2 4/6] PCI: Add Synopsys endpoint EDDA Device id
Date:   Mon, 17 Dec 2018 18:19:36 +0100
Message-Id: <d93634dc34964f40f00ce532e5f83e340b8ef902.1545066805.git.gustavo.pimentel@synopsys.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <cover.1545066805.git.gustavo.pimentel@synopsys.com>
References: <cover.1545066805.git.gustavo.pimentel@synopsys.com>
In-Reply-To: <cover.1545066805.git.gustavo.pimentel@synopsys.com>
References: <cover.1545066805.git.gustavo.pimentel@synopsys.com>
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Create and add Synopsys Endpoint EDDA Device id to PCI id list, since
this id is now being use on two different drivers (pci_endpoint_test.ko
and dw-edma-pcie.ko).

Changes:
RFC v1->RFC v2:
 - Reword subject line patch
 - Reorder patch order on the series

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

