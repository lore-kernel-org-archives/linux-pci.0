Return-Path: <SRS0=Zwnb=M5=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5194FECDE30
	for <linux-pci@archiver.kernel.org>; Wed, 17 Oct 2018 07:43:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 173C321526
	for <linux-pci@archiver.kernel.org>; Wed, 17 Oct 2018 07:43:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="TNMCxrnN"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 173C321526
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=ti.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-pci-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727714AbeJQPha (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Wed, 17 Oct 2018 11:37:30 -0400
Received: from lelv0142.ext.ti.com ([198.47.23.249]:52786 "EHLO
        lelv0142.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727655AbeJQPh3 (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 17 Oct 2018 11:37:29 -0400
Received: from dlelxv90.itg.ti.com ([172.17.2.17])
        by lelv0142.ext.ti.com (8.15.2/8.15.2) with ESMTP id w9H7gkEX052664;
        Wed, 17 Oct 2018 02:42:46 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1539762166;
        bh=QC6R01oOfBedPs18DXWbzKSKHpZhAnqAxHPEUw6bcpc=;
        h=From:To:CC:Subject:Date:In-Reply-To:References;
        b=TNMCxrnNQvyYj06S6QSbdfkJdF4V/bTABXr6XHPJRC4fgso6FgVKdxT/JqApxPYYk
         k23Rm9T1zMFQFR0+YwhVb8oE/2YaTxhuf9UqHE7ston1AXyyNaYx7OZMSEHS9J4339
         y64MDDbiACLy1tx6FNTdO0cuWN8dSYnjyIhT4EAI=
Received: from DFLE114.ent.ti.com (dfle114.ent.ti.com [10.64.6.35])
        by dlelxv90.itg.ti.com (8.14.3/8.13.8) with ESMTP id w9H7gkuD025580;
        Wed, 17 Oct 2018 02:42:46 -0500
Received: from DFLE103.ent.ti.com (10.64.6.24) by DFLE114.ent.ti.com
 (10.64.6.35) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1466.3; Wed, 17
 Oct 2018 02:42:46 -0500
Received: from dflp32.itg.ti.com (10.64.6.15) by DFLE103.ent.ti.com
 (10.64.6.24) with Microsoft SMTP Server (version=TLS1_0,
 cipher=TLS_RSA_WITH_AES_256_CBC_SHA) id 15.1.1466.3 via Frontend Transport;
 Wed, 17 Oct 2018 02:42:46 -0500
Received: from a0393678ub.dal.design.ti.com (ileax41-snat.itg.ti.com [10.172.224.153])
        by dflp32.itg.ti.com (8.14.3/8.13.8) with ESMTP id w9H7fgSd009413;
        Wed, 17 Oct 2018 02:42:43 -0500
From:   Kishon Vijay Abraham I <kishon@ti.com>
To:     Bjorn Helgaas <bhelgaas@google.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Murali Karicheri <m-karicheri2@ti.com>,
        Jingoo Han <jingoohan1@gmail.com>,
        Gustavo Pimentel <gustavo.pimentel@synopsys.com>
CC:     Rob Herring <robh+dt@kernel.org>, <linux-pci@vger.kernel.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        Kishon Vijay Abraham I <kishon@ti.com>
Subject: [PATCH v2 18/21] PCI: keystone: Use ERR_IRQ_STATUS instead of ERR_IRQ_STATUS_RAW to get interrupt status
Date:   Wed, 17 Oct 2018 13:11:11 +0530
Message-ID: <20181017074114.28239-19-kishon@ti.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20181017074114.28239-1-kishon@ti.com>
References: <20181017074114.28239-1-kishon@ti.com>
MIME-Version: 1.0
Content-Type: text/plain
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Use ERR_IRQ_STATUS instead of ERR_IRQ_STATUS_RAW to get interrupt
status. ERR_IRQ_STATUS_RAW has the status of the interrupts
before masking whereas ERR_IRQ_STATUS has the status of the interrupts
after masking. Since all the interrupts are unmasked here, use
ERR_IRQ_STATUS.

Signed-off-by: Kishon Vijay Abraham I <kishon@ti.com>
---
 drivers/pci/controller/dwc/pci-keystone.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/pci/controller/dwc/pci-keystone.c b/drivers/pci/controller/dwc/pci-keystone.c
index e181e6277323..c0bba7b604fa 100644
--- a/drivers/pci/controller/dwc/pci-keystone.c
+++ b/drivers/pci/controller/dwc/pci-keystone.c
@@ -80,7 +80,6 @@
 #define ERR_IRQ_ALL	(ERR_AER | ERR_AXI | ERR_CORR | \
 			 ERR_NONFATAL | ERR_FATAL | ERR_SYS)
 #define ERR_FATAL_IRQ	(ERR_FATAL | ERR_AXI)
-#define ERR_IRQ_STATUS_RAW		0x1c0
 #define ERR_IRQ_STATUS			0x1c4
 #define ERR_IRQ_ENABLE_SET		0x1c8
 #define ERR_IRQ_ENABLE_CLR		0x1cc
@@ -249,7 +248,7 @@ static irqreturn_t ks_pcie_handle_error_irq(struct keystone_pcie *ks_pcie)
 {
 	u32 status;
 
-	status = ks_pcie_app_readl(ks_pcie, ERR_IRQ_STATUS_RAW) & ERR_IRQ_ALL;
+	status = ks_pcie_app_readl(ks_pcie, ERR_IRQ_STATUS);
 	if (!status)
 		return IRQ_NONE;
 
-- 
2.17.1

