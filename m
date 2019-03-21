Return-Path: <SRS0=33lb=RY=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F22FAC43381
	for <linux-pci@archiver.kernel.org>; Thu, 21 Mar 2019 10:01:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C3277218B0
	for <linux-pci@archiver.kernel.org>; Thu, 21 Mar 2019 10:01:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="a5EjvoLN"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728390AbfCUKBE (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Thu, 21 Mar 2019 06:01:04 -0400
Received: from fllv0016.ext.ti.com ([198.47.19.142]:51224 "EHLO
        fllv0016.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728351AbfCUKBE (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 21 Mar 2019 06:01:04 -0400
Received: from lelv0265.itg.ti.com ([10.180.67.224])
        by fllv0016.ext.ti.com (8.15.2/8.15.2) with ESMTP id x2LA0ndl075287;
        Thu, 21 Mar 2019 05:00:49 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1553162449;
        bh=oV+nN/6TmtTzto6Wl4xvl2fcL77K2u3d1Dnvjj6uakE=;
        h=From:To:CC:Subject:Date:In-Reply-To:References;
        b=a5EjvoLNQvI4XKlK+BO4qn5HkZ2wGlwUDnSN1kPj9IwONinMDaKUeattthenUb5zI
         1L+lNxrK1lhiYgBlHMEYFyxmNhStz/6B+Bu5U9Hzo/2U6mOM+etfs4IPohLSbvfMHQ
         /Dc+42oHgqQaGASLj7VgD/Pg+woPZfRidySJTm2M=
Received: from DLEE103.ent.ti.com (dlee103.ent.ti.com [157.170.170.33])
        by lelv0265.itg.ti.com (8.15.2/8.15.2) with ESMTPS id x2LA0ngj094055
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Thu, 21 Mar 2019 05:00:49 -0500
Received: from DLEE104.ent.ti.com (157.170.170.34) by DLEE103.ent.ti.com
 (157.170.170.33) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1713.5; Thu, 21
 Mar 2019 05:00:48 -0500
Received: from dflp33.itg.ti.com (10.64.6.16) by DLEE104.ent.ti.com
 (157.170.170.34) with Microsoft SMTP Server (version=TLS1_0,
 cipher=TLS_RSA_WITH_AES_256_CBC_SHA) id 15.1.1713.5 via Frontend Transport;
 Thu, 21 Mar 2019 05:00:48 -0500
Received: from a0393678ub.india.ti.com (ileax41-snat.itg.ti.com [10.172.224.153])
        by dflp33.itg.ti.com (8.14.3/8.13.8) with ESMTP id x2LA0KOE014903;
        Thu, 21 Mar 2019 05:00:46 -0500
From:   Kishon Vijay Abraham I <kishon@ti.com>
To:     Murali Karicheri <m-karicheri2@ti.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Gustavo Pimentel <gustavo.pimentel@synopsys.com>,
        Marc Zyngier <marc.zyngier@arm.com>
CC:     Kishon Vijay Abraham I <kishon@ti.com>,
        Jingoo Han <jingoohan1@gmail.com>, <linux-pci@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>
Subject: [PATCH v5 8/8] PCI: dwc: Do not write to MSI control registers if the platform doesn't use it
Date:   Thu, 21 Mar 2019 15:29:27 +0530
Message-ID: <20190321095927.7058-9-kishon@ti.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190321095927.7058-1-kishon@ti.com>
References: <20190321095927.7058-1-kishon@ti.com>
MIME-Version: 1.0
Content-Type: text/plain
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Platforms which populate msi_host_init, has it's own MSI controller
logic. Writing to MSI control registers on platforms which doesn't use
Designware's MSI controller logic might have side effects. To
be safe, do not write to MSI control registers if the platform uses
it's own MSI controller logic instead of Designware's MSI controller
logic.

Signed-off-by: Kishon Vijay Abraham I <kishon@ti.com>
---
 .../pci/controller/dwc/pcie-designware-host.c | 24 ++++++++++---------
 1 file changed, 13 insertions(+), 11 deletions(-)

diff --git a/drivers/pci/controller/dwc/pcie-designware-host.c b/drivers/pci/controller/dwc/pcie-designware-host.c
index 498422397609..7e0ff7d428a9 100644
--- a/drivers/pci/controller/dwc/pcie-designware-host.c
+++ b/drivers/pci/controller/dwc/pcie-designware-host.c
@@ -626,17 +626,19 @@ void dw_pcie_setup_rc(struct pcie_port *pp)
 
 	dw_pcie_setup(pci);
 
-	num_ctrls = pp->num_vectors / MAX_MSI_IRQS_PER_CTRL;
-
-	/* Initialize IRQ Status array */
-	for (ctrl = 0; ctrl < num_ctrls; ctrl++) {
-		pp->irq_mask[ctrl] = ~0;
-		dw_pcie_wr_own_conf(pp, PCIE_MSI_INTR0_MASK +
-					(ctrl * MSI_REG_CTRL_BLOCK_SIZE),
-				    4, pp->irq_mask[ctrl]);
-		dw_pcie_wr_own_conf(pp, PCIE_MSI_INTR0_ENABLE +
-					(ctrl * MSI_REG_CTRL_BLOCK_SIZE),
-				    4, ~0);
+	if (!pp->ops->msi_host_init) {
+		num_ctrls = pp->num_vectors / MAX_MSI_IRQS_PER_CTRL;
+
+		/* Initialize IRQ Status array */
+		for (ctrl = 0; ctrl < num_ctrls; ctrl++) {
+			pp->irq_mask[ctrl] = ~0;
+			dw_pcie_wr_own_conf(pp, PCIE_MSI_INTR0_MASK +
+					    (ctrl * MSI_REG_CTRL_BLOCK_SIZE),
+					    4, pp->irq_mask[ctrl]);
+			dw_pcie_wr_own_conf(pp, PCIE_MSI_INTR0_ENABLE +
+					    (ctrl * MSI_REG_CTRL_BLOCK_SIZE),
+					    4, ~0);
+		}
 	}
 
 	/* Setup RC BARs */
-- 
2.17.1

