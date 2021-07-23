Return-Path: <linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EA5F0C432BE
	for <linux-pci@archiver.kernel.org>; Fri, 23 Jul 2021 21:06:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D559F60F25
	for <linux-pci@archiver.kernel.org>; Fri, 23 Jul 2021 21:06:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231912AbhGWU0W (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Fri, 23 Jul 2021 16:26:22 -0400
Received: from finn.gateworks.com ([108.161.129.64]:57818 "EHLO
        finn.localdomain" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S229461AbhGWU0V (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 23 Jul 2021 16:26:21 -0400
Received: from 068-189-091-139.biz.spectrum.com ([68.189.91.139] helo=tharvey.pdc.gateworks.com)
        by finn.localdomain with esmtp (Exim 4.93)
        (envelope-from <tharvey@gateworks.com>)
        id 1m727O-0057Vc-9G; Fri, 23 Jul 2021 20:50:02 +0000
From:   Tim Harvey <tharvey@gateworks.com>
To:     Richard Zhu <hongxing.zhu@nxp.com>,
        Lucas Stach <l.stach@pengutronix.de>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Rob Herring <robh+dt@kernel.org>,
        Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>,
        NXP Linux Team <linux-imx@nxp.com>,
        linux-pci@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        =?UTF-8?q?Krzysztof=20Wilczy=C5=84ski?= <kw@linux.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
Cc:     Tim Harvey <tharvey@gateworks.com>
Subject: [PATCH 1/6] dt-bindings: imx6q-pcie: add compatible for IMX8MM support
Date:   Fri, 23 Jul 2021 13:49:53 -0700
Message-Id: <20210723204958.7186-2-tharvey@gateworks.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20210723204958.7186-1-tharvey@gateworks.com>
References: <20210723204958.7186-1-tharvey@gateworks.com>
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

This adds the DT binding for IMX8MM support to the existing imx6q-pcie
driver which shares most functionality with the IMX8MM.

Additionally a 'fsl,ext-osc' property is defined to note use of an
external oscillator as ref clock vs the internal PLL.

Signed-off-by: Tim Harvey <tharvey@gateworks.com>
---
 Documentation/devicetree/bindings/pci/fsl,imx6q-pcie.txt | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/Documentation/devicetree/bindings/pci/fsl,imx6q-pcie.txt b/Documentation/devicetree/bindings/pci/fsl,imx6q-pcie.txt
index d8971ab99274..9886e1344fd3 100644
--- a/Documentation/devicetree/bindings/pci/fsl,imx6q-pcie.txt
+++ b/Documentation/devicetree/bindings/pci/fsl,imx6q-pcie.txt
@@ -10,6 +10,7 @@ Required properties:
 	- "fsl,imx6qp-pcie"
 	- "fsl,imx7d-pcie"
 	- "fsl,imx8mq-pcie"
+	- "fsl,imx8mm-pcie"
 - reg: base address and length of the PCIe controller
 - interrupts: A list of interrupt outputs of the controller. Must contain an
   entry for each entry in the interrupt-names property.
@@ -19,6 +20,7 @@ Required properties:
 	- "pcie_phy"
 
 Optional properties:
+- fsl,ext-osc: use the external oscillator as ref clock (vs internal PLL)
 - fsl,tx-deemph-gen1: Gen1 De-emphasis value. Default: 0
 - fsl,tx-deemph-gen2-3p5db: Gen2 (3.5db) De-emphasis value. Default: 0
 - fsl,tx-deemph-gen2-6db: Gen2 (6db) De-emphasis value. Default: 20
@@ -49,7 +51,7 @@ Additional required properties for imx6sx-pcie:
   PCIE_PHY power domains
 - power-domain-names: Must be "pcie", "pcie_phy"
 
-Additional required properties for imx7d-pcie and imx8mq-pcie:
+Additional required properties for imx7d-pcie, imx8mq-pcie, imx8mm-pcie:
 - power-domains: Must be set to a phandle pointing to PCIE_PHY power domain
 - resets: Must contain phandles to PCIe-related reset lines exposed by SRC
   IP block
-- 
2.17.1

