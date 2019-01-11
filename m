Return-Path: <SRS0=/dOL=PT=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 57D7AC43387
	for <linux-pci@archiver.kernel.org>; Fri, 11 Jan 2019 18:33:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 31404218A4
	for <linux-pci@archiver.kernel.org>; Fri, 11 Jan 2019 18:33:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=synopsys.com header.i=@synopsys.com header.b="Jz9Ghn3e"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731763AbfAKSdx (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Fri, 11 Jan 2019 13:33:53 -0500
Received: from smtprelay.synopsys.com ([198.182.47.9]:34012 "EHLO
        smtprelay.synopsys.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729700AbfAKSdw (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 11 Jan 2019 13:33:52 -0500
Received: from mailhost.synopsys.com (mailhost2.synopsys.com [10.13.184.66])
        by smtprelay.synopsys.com (Postfix) with ESMTP id 2CF2324E0D4C;
        Fri, 11 Jan 2019 10:33:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=synopsys.com; s=mail;
        t=1547231632; bh=3wVF2XoinVpS5I/8toDaq4FP+5f7Sx+/znb8WxI6kBc=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:In-Reply-To:
         References:From;
        b=Jz9Ghn3e+KWFtx82CeC9rb9jmNhYu4Upcda1fsNlYOUQ6WD4jaAbbUX8O/D4LLbqt
         b+XaoPk4o+N03n0f02o4hv61HcvpQrvg6NsfJgkTDzOBZSHA2hXGFtIFpAd82v4b6b
         eVDX4HW0K5NcCD49QmIXFb7kxK3Tof1VbnXNYSyVyCjR2JNGNv3W627ugQiJkfkb5D
         8Y5shDAvTp2HdhtB7FoWSLXo3FgnfU3gfI5+tEYqO0qvME96Oq624H6LnS/V/YjJI0
         Gb1zc+fbkju9ArrLQK8+3P9287laDXsvd0WaoeMTAxmoPzwV0bScl3pYHTR2QZ+Uks
         H/igfD5DmghKw==
Received: from de02.synopsys.com (de02.internal.synopsys.com [10.225.17.21])
        by mailhost.synopsys.com (Postfix) with ESMTP id C7ECD2ED9;
        Fri, 11 Jan 2019 10:33:51 -0800 (PST)
Received: from de02dwia024.internal.synopsys.com (de02dwia024.internal.synopsys.com [10.225.19.81])
        by de02.synopsys.com (Postfix) with ESMTP id 028EF3ED9E;
        Fri, 11 Jan 2019 19:33:51 +0100 (CET)
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
Subject: [RFC v3 4/7] PCI: Add Synopsys endpoint EDDA Device id
Date:   Fri, 11 Jan 2019 19:33:40 +0100
Message-Id: <55ddfd8c072f63c84c2ba7dd6f42ef8fa594632c.1547230339.git.gustavo.pimentel@synopsys.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <cover.1547230339.git.gustavo.pimentel@synopsys.com>
References: <cover.1547230339.git.gustavo.pimentel@synopsys.com>
In-Reply-To: <cover.1547230339.git.gustavo.pimentel@synopsys.com>
References: <cover.1547230339.git.gustavo.pimentel@synopsys.com>
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
RFC v2->RFC v3:
 - No changes

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
index 5eaf39d..faf55af 100644
--- a/include/linux/pci_ids.h
+++ b/include/linux/pci_ids.h
@@ -2364,6 +2364,7 @@
 #define PCI_DEVICE_ID_SYNOPSYS_HAPSUSB3		0xabcd
 #define PCI_DEVICE_ID_SYNOPSYS_HAPSUSB3_AXI	0xabce
 #define PCI_DEVICE_ID_SYNOPSYS_HAPSUSB31	0xabcf
+#define PCI_DEVICE_ID_SYNOPSYS_EDDA	0xedda
 
 #define PCI_VENDOR_ID_USR		0x16ec
 
-- 
2.7.4

