Return-Path: <SRS0=EJXn=O3=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3AFD2C43444
	for <linux-pci@archiver.kernel.org>; Tue, 18 Dec 2018 07:57:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1215A20874
	for <linux-pci@archiver.kernel.org>; Tue, 18 Dec 2018 07:57:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726518AbeLRH5C (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Tue, 18 Dec 2018 02:57:02 -0500
Received: from mail-sh2.amlogic.com ([58.32.228.45]:34324 "EHLO
        mail-sh2.amlogic.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726439AbeLRH5A (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 18 Dec 2018 02:57:00 -0500
Received: from droid10.amlogic.com (10.18.11.213) by mail-sh2.amlogic.com
 (10.18.11.6) with Microsoft SMTP Server id 15.0.1320.4; Tue, 18 Dec 2018
 15:57:14 +0800
From:   Hanjie Lin <hanjie.lin@amlogic.com>
To:     Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Bjorn Helgaas <bhelgaas@google.com>
CC:     Yue Wang <yue.wang@amlogic.com>,
        Hanjie Lin <hanjie.lin@amlogic.com>,
        Kevin Hilman <khilman@baylibre.com>,
        Carlo Caione <carlo@caione.org>,
        Jerome Brunet <jbrunet@baylibre.com>,
        Rob Herring <robh@kernel.org>,
        Gustavo Pimentel <gustavo.pimentel@synopsys.com>,
        Shawn Lin <shawn.lin@rock-chips.com>,
        Philippe Ombredanne <pombredanne@nexb.com>,
        Cyrille Pitchen <cyrille.pitchen@free-electrons.com>,
        <linux-kernel@vger.kernel.org>, <linux-pci@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-amlogic@lists.infradead.org>,
        Yixun Lan <yixun.lan@amlogic.com>,
        Liang Yang <liang.yang@amlogic.com>,
        Jianxin Pan <jianxin.pan@amlogic.com>,
        Qiufang Dai <qiufang.dai@amlogic.com>,
        Jian Hu <jian.hu@amlogic.com>, <devicetree@vger.kernel.org>
Subject: [PATCH v8 1/2] dt-bindings: PCI: meson: add DT bindings for Amlogic Meson PCIe controller
Date:   Tue, 18 Dec 2018 15:56:49 +0800
Message-ID: <1545119811-26911-2-git-send-email-hanjie.lin@amlogic.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1545119811-26911-1-git-send-email-hanjie.lin@amlogic.com>
References: <1545119811-26911-1-git-send-email-hanjie.lin@amlogic.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.18.11.213]
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

From: Yue Wang <yue.wang@amlogic.com>

The Amlogic Meson PCIe host controller is based on the Synopsys DesignWare
PCI core. This patch adds documentation for the DT bindings in Meson PCIe
controller.

Signed-off-by: Yue Wang <yue.wang@amlogic.com>
Signed-off-by: Hanjie Lin <hanjie.lin@amlogic.com>
Reviewed-by: Rob Herring <robh@kernel.org>
---
 .../devicetree/bindings/pci/amlogic,meson-pcie.txt | 70 ++++++++++++++++++++++
 1 file changed, 70 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/pci/amlogic,meson-pcie.txt

diff --git a/Documentation/devicetree/bindings/pci/amlogic,meson-pcie.txt b/Documentation/devicetree/bindings/pci/amlogic,meson-pcie.txt
new file mode 100644
index 0000000..12b18f8
--- /dev/null
+++ b/Documentation/devicetree/bindings/pci/amlogic,meson-pcie.txt
@@ -0,0 +1,70 @@
+Amlogic Meson AXG DWC PCIE SoC controller
+
+Amlogic Meson PCIe host controller is based on the Synopsys DesignWare PCI core.
+It shares common functions with the PCIe DesignWare core driver and
+inherits common properties defined in
+Documentation/devicetree/bindings/pci/designware-pci.txt.
+
+Additional properties are described here:
+
+Required properties:
+- compatible:
+	should contain "amlogic,axg-pcie" to identify the core.
+- reg:
+	should contain the configuration address space.
+- reg-names: Must be
+	- "elbi"	External local bus interface registers
+	- "cfg"		Meson specific registers
+	- "phy"		Meson PCIE PHY registers
+	- "config"	PCIe configuration space
+- reset-gpios: The GPIO to generate PCIe PERST# assert and deassert signal.
+- clocks: Must contain an entry for each entry in clock-names.
+- clock-names: Must include the following entries:
+	- "pclk"       PCIe GEN 100M PLL clock
+	- "port"       PCIe_x(A or B) RC clock gate
+	- "general"    PCIe Phy clock
+	- "mipi"       PCIe_x(A or B) 100M ref clock gate
+- resets: phandle to the reset lines.
+- reset-names: must contain "phy" "port" and "apb"
+       - "phy"         Share PHY reset
+       - "port"        Port A or B reset
+       - "apb"         Share APB reset
+- device_type:
+	should be "pci". As specified in designware-pcie.txt
+
+
+Example configuration:
+
+	pcie: pcie@f9800000 {
+			compatible = "amlogic,axg-pcie", "snps,dw-pcie";
+			reg = <0x0 0xf9800000 0x0 0x400000
+					0x0 0xff646000 0x0 0x2000
+					0x0 0xff644000 0x0 0x2000
+					0x0 0xf9f00000 0x0 0x100000>;
+			reg-names = "elbi", "cfg", "phy", "config";
+			reset-gpios = <&gpio GPIOX_19 GPIO_ACTIVE_HIGH>;
+			interrupts = <GIC_SPI 177 IRQ_TYPE_EDGE_RISING>;
+			#interrupt-cells = <1>;
+			interrupt-map-mask = <0 0 0 0>;
+			interrupt-map = <0 0 0 0 &gic GIC_SPI 179 IRQ_TYPE_EDGE_RISING>;
+			bus-range = <0x0 0xff>;
+			#address-cells = <3>;
+			#size-cells = <2>;
+			device_type = "pci";
+			ranges = <0x82000000 0 0 0x0 0xf9c00000 0 0x00300000>;
+
+			clocks = <&clkc CLKID_USB
+					&clkc CLKID_MIPI_ENABLE
+					&clkc CLKID_PCIE_A
+					&clkc CLKID_PCIE_CML_EN0>;
+			clock-names = "general",
+					"mipi",
+					"pclk",
+					"port";
+			resets = <&reset RESET_PCIE_PHY>,
+				<&reset RESET_PCIE_A>,
+				<&reset RESET_PCIE_APB>;
+			reset-names = "phy",
+					"port",
+					"apb";
+	};
-- 
2.7.4

