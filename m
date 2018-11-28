Return-Path: <SRS0=2mbU=OH=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3ECFAC43441
	for <linux-pci@archiver.kernel.org>; Wed, 28 Nov 2018 04:04:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0F800205C9
	for <linux-pci@archiver.kernel.org>; Wed, 28 Nov 2018 04:04:45 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0F800205C9
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=socionext.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-pci-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727322AbeK1PEl (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Wed, 28 Nov 2018 10:04:41 -0500
Received: from mx.socionext.com ([202.248.49.38]:37684 "EHLO mx.socionext.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727238AbeK1PEk (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Wed, 28 Nov 2018 10:04:40 -0500
Received: from unknown (HELO kinkan-ex.css.socionext.com) ([172.31.9.52])
  by mx.socionext.com with ESMTP; 28 Nov 2018 13:04:29 +0900
Received: from mail.mfilter.local (m-filter-2 [10.213.24.62])
        by kinkan-ex.css.socionext.com (Postfix) with ESMTP id AE5D41800A0;
        Wed, 28 Nov 2018 13:04:29 +0900 (JST)
Received: from 172.31.9.51 (172.31.9.51) by m-FILTER with ESMTP; Wed, 28 Nov 2018 13:04:29 +0900
Received: from plum.e01.socionext.com (unknown [10.213.132.32])
        by kinkan.css.socionext.com (Postfix) with ESMTP id 22C5E1A1235;
        Wed, 28 Nov 2018 13:04:29 +0900 (JST)
From:   Kunihiko Hayashi <hayashi.kunihiko@socionext.com>
To:     Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Masahiro Yamada <yamada.masahiro@socionext.com>
Cc:     linux-pci@vger.kernel.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Masami Hiramatsu <masami.hiramatsu@linaro.org>,
        Jassi Brar <jaswinder.singh@linaro.org>,
        Gustavo Pimentel <gustavo.pimentel@synopsys.com>,
        Kunihiko Hayashi <hayashi.kunihiko@socionext.com>
Subject: [PATCH v4 1/2] dt-bindings: PCI: Add UniPhier PCIe host controller description
Date:   Wed, 28 Nov 2018 13:04:25 +0900
Message-Id: <1543377866-16634-2-git-send-email-hayashi.kunihiko@socionext.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1543377866-16634-1-git-send-email-hayashi.kunihiko@socionext.com>
References: <1543377866-16634-1-git-send-email-hayashi.kunihiko@socionext.com>
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Add DT bindings for PCIe controller implemented in UniPhier SoCs when
configured in Root Complex (host) mode. This controller is based on
the DesignWare PCIe core.

Signed-off-by: Kunihiko Hayashi <hayashi.kunihiko@socionext.com>
Reviewed-by: Rob Herring <robh@kernel.org>
---
 .../devicetree/bindings/pci/uniphier-pcie.txt      | 81 ++++++++++++++++++++++
 1 file changed, 81 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/pci/uniphier-pcie.txt

diff --git a/Documentation/devicetree/bindings/pci/uniphier-pcie.txt b/Documentation/devicetree/bindings/pci/uniphier-pcie.txt
new file mode 100644
index 0000000..1fa2c59
--- /dev/null
+++ b/Documentation/devicetree/bindings/pci/uniphier-pcie.txt
@@ -0,0 +1,81 @@
+Socionext UniPhier PCIe host controller bindings
+
+This describes the devicetree bindings for PCIe host controller implemented
+on Socionext UniPhier SoCs.
+
+UniPhier PCIe host controller is based on the Synopsys DesignWare PCI core.
+It shares common functions with the PCIe DesignWare core driver and inherits
+common properties defined in
+Documentation/devicetree/bindings/pci/designware-pcie.txt.
+
+Required properties:
+- compatible: Should be "socionext,uniphier-pcie".
+- reg: Specifies offset and length of the register set for the device.
+	According to the reg-names, appropriate register sets are required.
+- reg-names: Must include the following entries:
+    "dbi"    - controller configuration registers
+    "link"   - SoC-specific glue layer registers
+    "config" - PCIe configuration space
+- clocks: A phandle to the clock gate for PCIe glue layer including
+	the host controller.
+- resets: A phandle to the reset line for PCIe glue layer including
+	the host controller.
+- interrupts: A list of interrupt specifiers. According to the
+	interrupt-names, appropriate interrupts are required.
+- interrupt-names: Must include the following entries:
+    "dma" - DMA interrupt
+    "msi" - MSI interrupt
+
+Optional properties:
+- phys: A phandle to generic PCIe PHY. According to the phy-names, appropriate
+	phys are required.
+- phy-names: Must be "pcie-phy".
+
+Required sub-node:
+- legacy-interrupt-controller: Specifies interrupt controller for legacy PCI
+	interrupts.
+
+Required properties for legacy-interrupt-controller:
+- interrupt-controller: identifies the node as an interrupt controller.
+- #interrupt-cells: specifies the number of cells needed to encode an
+	interrupt source. The value must be 1.
+- interrupt-parent: Phandle to the parent interrupt controller.
+- interrupts: An interrupt specifier for legacy interrupt.
+
+Example:
+
+	pcie: pcie@66000000 {
+		compatible = "socionext,uniphier-pcie", "snps,dw-pcie";
+		status = "disabled";
+		reg-names = "dbi", "link", "config";
+		reg = <0x66000000 0x1000>, <0x66010000 0x10000>,
+		      <0x2fff0000 0x10000>;
+		#address-cells = <3>;
+		#size-cells = <2>;
+		clocks = <&sys_clk 24>;
+		resets = <&sys_rst 24>;
+		num-lanes = <1>;
+		num-viewport = <1>;
+		bus-range = <0x0 0xff>;
+		device_type = "pci";
+		ranges =
+		/* downstream I/O */
+			<0x81000000 0 0x00000000  0x2ffe0000  0 0x00010000
+		/* non-prefetchable memory */
+			 0x82000000 0 0x00000000  0x20000000  0 0x0ffe0000>;
+		#interrupt-cells = <1>;
+		interrupt-names = "dma", "msi";
+		interrupts = <0 224 4>, <0 225 4>;
+		interrupt-map-mask = <0 0 0  7>;
+		interrupt-map = <0 0 0  1  &pcie_intc 0>,	/* INTA */
+				<0 0 0  2  &pcie_intc 1>,	/* INTB */
+				<0 0 0  3  &pcie_intc 2>,	/* INTC */
+				<0 0 0  4  &pcie_intc 3>;	/* INTD */
+
+		pcie_intc: legacy-interrupt-controller {
+			interrupt-controller;
+			#interrupt-cells = <1>;
+			interrupt-parent = <&gic>;
+			interrupts = <0 226 4>;
+		};
+	};
-- 
2.7.4

