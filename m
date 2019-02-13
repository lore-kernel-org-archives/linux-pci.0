Return-Path: <SRS0=kgfr=QU=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 88419C282CA
	for <linux-pci@archiver.kernel.org>; Wed, 13 Feb 2019 13:28:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 57A72222B5
	for <linux-pci@archiver.kernel.org>; Wed, 13 Feb 2019 13:28:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="rZdhw+Eh"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388310AbfBMN2Q (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Wed, 13 Feb 2019 08:28:16 -0500
Received: from fllv0016.ext.ti.com ([198.47.19.142]:38098 "EHLO
        fllv0016.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2403799AbfBMN2N (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 13 Feb 2019 08:28:13 -0500
Received: from fllv0034.itg.ti.com ([10.64.40.246])
        by fllv0016.ext.ti.com (8.15.2/8.15.2) with ESMTP id x1DDRkXX061180;
        Wed, 13 Feb 2019 07:27:46 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1550064466;
        bh=fAqNlTR7cMaMsca9ZKERwJ2A9RfxaY/X8QU7ZLjB4i0=;
        h=From:To:CC:Subject:Date:In-Reply-To:References;
        b=rZdhw+EhPKyWX24qFCHvmoYFj/8rTffUYzZZZ8RVfWPdiq7Z3H9tTEvhUz+ujTkq9
         fnXjggg0x9AQwsWJvhuYrCcdIAjh13bq2SrYEpmxnO6z8bgo2ZhgogTiRsHe0YBE6+
         1BZ2Fa8LQX5EEHEArar78OuqyC6o97ngv9NVtgKo=
Received: from DLEE105.ent.ti.com (dlee105.ent.ti.com [157.170.170.35])
        by fllv0034.itg.ti.com (8.15.2/8.15.2) with ESMTPS id x1DDRkCf025618
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Wed, 13 Feb 2019 07:27:46 -0600
Received: from DLEE100.ent.ti.com (157.170.170.30) by DLEE105.ent.ti.com
 (157.170.170.35) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1591.10; Wed, 13
 Feb 2019 07:27:46 -0600
Received: from dlep32.itg.ti.com (157.170.170.100) by DLEE100.ent.ti.com
 (157.170.170.30) with Microsoft SMTP Server (version=TLS1_0,
 cipher=TLS_RSA_WITH_AES_256_CBC_SHA) id 15.1.1591.10 via Frontend Transport;
 Wed, 13 Feb 2019 07:27:45 -0600
Received: from a0393678ub.india.ti.com (ileax41-snat.itg.ti.com [10.172.224.153])
        by dlep32.itg.ti.com (8.14.3/8.13.8) with ESMTP id x1DDRGZj016688;
        Wed, 13 Feb 2019 07:27:43 -0600
From:   Kishon Vijay Abraham I <kishon@ti.com>
To:     Murali Karicheri <m-karicheri2@ti.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
CC:     Kishon Vijay Abraham I <kishon@ti.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Jingoo Han <jingoohan1@gmail.com>,
        Gustavo Pimentel <gustavo.pimentel@synopsys.com>,
        <linux-pci@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>
Subject: [PATCH v3 9/9] PCI: dwc: Do not write to MSI control registers if the platform doesn't use it
Date:   Wed, 13 Feb 2019 18:56:29 +0530
Message-ID: <20190213132629.24790-10-kishon@ti.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190213132629.24790-1-kishon@ti.com>
References: <20190213132629.24790-1-kishon@ti.com>
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
index 781735f06dea..2bc2fd582124 100644
--- a/drivers/pci/controller/dwc/pcie-designware-host.c
+++ b/drivers/pci/controller/dwc/pcie-designware-host.c
@@ -641,17 +641,19 @@ void dw_pcie_setup_rc(struct pcie_port *pp)
 
 	dw_pcie_setup(pci);
 
-	num_ctrls = pp->num_vectors / MAX_MSI_IRQS_PER_CTRL;
-
-	/* Initialize IRQ Status array */
-	for (ctrl = 0; ctrl < num_ctrls; ctrl++) {
-		dw_pcie_wr_own_conf(pp, PCIE_MSI_INTR0_MASK +
-					(ctrl * MSI_REG_CTRL_BLOCK_SIZE),
-				    4, ~0);
-		dw_pcie_wr_own_conf(pp, PCIE_MSI_INTR0_ENABLE +
-					(ctrl * MSI_REG_CTRL_BLOCK_SIZE),
-				    4, ~0);
-		pp->irq_status[ctrl] = 0;
+	if (!pp->ops->msi_host_init) {
+		num_ctrls = pp->num_vectors / MAX_MSI_IRQS_PER_CTRL;
+
+		/* Initialize IRQ Status array */
+		for (ctrl = 0; ctrl < num_ctrls; ctrl++) {
+			dw_pcie_wr_own_conf(pp, PCIE_MSI_INTR0_MASK +
+					    (ctrl * MSI_REG_CTRL_BLOCK_SIZE),
+					    4, ~0);
+			dw_pcie_wr_own_conf(pp, PCIE_MSI_INTR0_ENABLE +
+					    (ctrl * MSI_REG_CTRL_BLOCK_SIZE),
+					    4, ~0);
+			pp->irq_status[ctrl] = 0;
+		}
 	}
 
 	/* Setup RC BARs */
-- 
2.17.1

