Return-Path: <linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D03A6C43217
	for <linux-pci@archiver.kernel.org>; Tue, 15 Nov 2022 15:09:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230096AbiKOPJS (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Tue, 15 Nov 2022 10:09:18 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48142 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230460AbiKOPJN (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 15 Nov 2022 10:09:13 -0500
Received: from fllv0015.ext.ti.com (fllv0015.ext.ti.com [198.47.19.141])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5ABED1834A
        for <linux-pci@vger.kernel.org>; Tue, 15 Nov 2022 07:09:10 -0800 (PST)
Received: from fllv0034.itg.ti.com ([10.64.40.246])
        by fllv0015.ext.ti.com (8.15.2/8.15.2) with ESMTP id 2AFF94Ps077742;
        Tue, 15 Nov 2022 09:09:04 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1668524944;
        bh=pQRNSGirOQXjd3vm3b5fncqcHi4AeVKpPaZV1zeypiI=;
        h=From:To:CC:Subject:Date:In-Reply-To:References;
        b=SQLbjqCq8vmcldQ9GQyzMXtxyCYC/5Dl/neVGMdLduNYSJ1+FlO2yCeNu0CJ49sWP
         xpY1UPc1/6w2M7QbaTWRsnt0NgjhwmwCIsRRVsl3BXNiN1/qLM+UHeupHOrmURP7hR
         QwVESRvLghWdY5/IJ88eA0fIYlOicpi+0OiAeauY=
Received: from DFLE115.ent.ti.com (dfle115.ent.ti.com [10.64.6.36])
        by fllv0034.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 2AFF44oN004438
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Tue, 15 Nov 2022 09:04:04 -0600
Received: from DFLE108.ent.ti.com (10.64.6.29) by DFLE115.ent.ti.com
 (10.64.6.36) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.6; Tue, 15
 Nov 2022 09:04:04 -0600
Received: from lelv0327.itg.ti.com (10.180.67.183) by DFLE108.ent.ti.com
 (10.64.6.29) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.6 via
 Frontend Transport; Tue, 15 Nov 2022 09:04:04 -0600
Received: from localhost (ileaxei01-snat2.itg.ti.com [10.180.69.6])
        by lelv0327.itg.ti.com (8.15.2/8.15.2) with ESMTP id 2AFF41Bk014947;
        Tue, 15 Nov 2022 09:04:02 -0600
From:   Matt Ranostay <mranostay@ti.com>
To:     <vigneshr@ti.com>, <lpieralisi@kernel.org>, <robh@kernel.org>,
        <kw@linux.com>, <bhelgaas@google.com>
CC:     <linux-pci@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        Matt Ranostay <mranostay@ti.com>, Achal Verma <a-verma1@ti.com>
Subject: [PATCH v6 5/5] PCI: j721e: add j784s4 PCIe configuration
Date:   Tue, 15 Nov 2022 07:03:35 -0800
Message-ID: <20221115150335.501502-6-mranostay@ti.com>
X-Mailer: git-send-email 2.38.GIT
In-Reply-To: <20221115150335.501502-1-mranostay@ti.com>
References: <20221115150335.501502-1-mranostay@ti.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Add PCIe configuration for j784s4 platform which has 4x lane support.

Tested-by: Achal Verma <a-verma1@ti.com>
Signed-off-by: Matt Ranostay <mranostay@ti.com>
---
 drivers/pci/controller/cadence/pci-j721e.c | 23 ++++++++++++++++++++++
 1 file changed, 23 insertions(+)

diff --git a/drivers/pci/controller/cadence/pci-j721e.c b/drivers/pci/controller/cadence/pci-j721e.c
index dab3db9be6d8..c484d658c18a 100644
--- a/drivers/pci/controller/cadence/pci-j721e.c
+++ b/drivers/pci/controller/cadence/pci-j721e.c
@@ -330,6 +330,21 @@ static const struct j721e_pcie_data am64_pcie_ep_data = {
 	.max_lanes = 1,
 };
 
+static const struct j721e_pcie_data j784s4_pcie_rc_data = {
+	.mode = PCI_MODE_RC,
+	.quirk_retrain_flag = true,
+	.is_intc_v1 = true,
+	.byte_access_allowed = false,
+	.linkdown_irq_regfield = LINK_DOWN,
+	.max_lanes = 4,
+};
+
+static const struct j721e_pcie_data j784s4_pcie_ep_data = {
+	.mode = PCI_MODE_EP,
+	.linkdown_irq_regfield = LINK_DOWN,
+	.max_lanes = 4,
+};
+
 static const struct of_device_id of_j721e_pcie_match[] = {
 	{
 		.compatible = "ti,j721e-pcie-host",
@@ -355,6 +370,14 @@ static const struct of_device_id of_j721e_pcie_match[] = {
 		.compatible = "ti,am64-pcie-ep",
 		.data = &am64_pcie_ep_data,
 	},
+	{
+		.compatible = "ti,j784s4-pcie-host",
+		.data = &j784s4_pcie_rc_data,
+	},
+	{
+		.compatible = "ti,j784s4-pcie-ep",
+		.data = &j784s4_pcie_ep_data,
+	},
 	{},
 };
 
-- 
2.38.GIT

