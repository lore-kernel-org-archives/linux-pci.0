Return-Path: <SRS0=JnZd=SL=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.7 required=3.0 tests=FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5AFDCC10F0E
	for <linux-pci@archiver.kernel.org>; Tue,  9 Apr 2019 12:11:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 357D620880
	for <linux-pci@archiver.kernel.org>; Tue,  9 Apr 2019 12:11:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726908AbfDIMLt (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Tue, 9 Apr 2019 08:11:49 -0400
Received: from ns.iliad.fr ([212.27.33.1]:38798 "EHLO ns.iliad.fr"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726948AbfDIMLt (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Tue, 9 Apr 2019 08:11:49 -0400
Received: from ns.iliad.fr (localhost [127.0.0.1])
        by ns.iliad.fr (Postfix) with ESMTP id 868F12020C;
        Tue,  9 Apr 2019 14:11:46 +0200 (CEST)
Received: from [192.168.108.8] (freebox.vlq16.iliad.fr [213.36.7.13])
        by ns.iliad.fr (Postfix) with ESMTP id 6E6F41FF7C;
        Tue,  9 Apr 2019 14:11:46 +0200 (CEST)
To:     Bjorn Andersson <bjorn.andersson@linaro.org>
Cc:     Jeffrey Hugo <jhugo@codeaurora.org>,
        Vivek Gautam <vivek.gautam@codeaurora.org>,
        Stanimir Varbanov <svarbanov@mm-sol.com>,
        MSM <linux-arm-msm@vger.kernel.org>,
        PCI <linux-pci@vger.kernel.org>
From:   Marc Gonzalez <marc.w.gonzalez@free.fr>
Subject: [PATCH v2] arm64: dts: qcom: msm8998: Add PCIe PHY and RC nodes
Message-ID: <f9d9afc3-06cb-a0bf-e420-8188f8255a88@free.fr>
Date:   Tue, 9 Apr 2019 14:11:46 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Virus-Scanned: ClamAV using ClamSMTP ; ns.iliad.fr ; Tue Apr  9 14:11:46 2019 +0200 (CEST)
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Add MSM8998 PCIe QMP PHY and PCIe root complex DT nodes.

Based on the following DTS downstream:
https://source.codeaurora.org/quic/la/kernel/msm-4.4/tree/arch/arm/boot/dts/qcom/msm8998.dtsi?h=LE.UM.1.3.r3.25#n2537

Signed-off-by: Marc Gonzalez <marc.w.gonzalez@free.fr>
---
Changes from v1:
	Drop SMMU patch from series (spun off, required)
	Drop PCIE20_PARF_BDF_TRANSLATE_N patch (AR8151 now works without it)
	Provide link to the original DTS in commit log
---
 arch/arm64/boot/dts/qcom/msm8998.dtsi | 78 +++++++++++++++++++++++++++
 1 file changed, 78 insertions(+)

diff --git a/arch/arm64/boot/dts/qcom/msm8998.dtsi b/arch/arm64/boot/dts/qcom/msm8998.dtsi
index f807ea3e2c6e..f848d9f2df2d 100644
--- a/arch/arm64/boot/dts/qcom/msm8998.dtsi
+++ b/arch/arm64/boot/dts/qcom/msm8998.dtsi
@@ -621,6 +621,84 @@
 				<GIC_SPI 369 IRQ_TYPE_EDGE_RISING>;
 		};
 
+		pcie0: pci@1c00000 {
+			compatible = "qcom,pcie-msm8996";
+			reg-names = "parf", "dbi", "elbi", "config";
+			reg =	<0x01c00000 0x2000>,
+				<0x1b000000 0xf1d>,
+				<0x1b000f20 0xa8>,
+				<0x1b100000 0x100000>;
+			device_type = "pci";
+			linux,pci-domain = <0>;
+			bus-range = <0x00 0xff>;
+			#address-cells = <3>;
+			#size-cells = <2>;
+			power-domains = <&gcc PCIE_0_GDSC>;
+
+			num-lanes = <1>;
+			phy-names = "pciephy";
+			phys = <&pciephy>;
+
+			ranges =
+			/*** downstream I/O ***/
+			<0x01000000 0x0 0x1b200000 0x1b200000 0x0 0x100000>,
+			/*** non-prefetchable memory ***/
+			<0x02000000 0x0 0x1b300000 0x1b300000 0x0 0xd00000>;
+
+			#interrupt-cells = <1>;
+			interrupt-names = "msi";
+			interrupts = <GIC_SPI 405 IRQ_TYPE_LEVEL_HIGH>;
+			interrupt-map-mask = <0 0 0 0x7>;
+			interrupt-map =
+				<0 0 0 1 &intc 0 135 IRQ_TYPE_LEVEL_HIGH>, /* #INTA */
+				<0 0 0 2 &intc 0 136 IRQ_TYPE_LEVEL_HIGH>, /* #INTB */
+				<0 0 0 3 &intc 0 138 IRQ_TYPE_LEVEL_HIGH>, /* #INTC */
+				<0 0 0 4 &intc 0 139 IRQ_TYPE_LEVEL_HIGH>; /* #INTD */
+
+			clock-names = "pipe", "bus_master", "bus_slave", "cfg", "aux";
+			clocks =
+				<&gcc GCC_PCIE_0_PIPE_CLK>,
+				<&gcc GCC_PCIE_0_MSTR_AXI_CLK>,
+				<&gcc GCC_PCIE_0_SLV_AXI_CLK>,
+				<&gcc GCC_PCIE_0_CFG_AHB_CLK>,
+				<&gcc GCC_PCIE_0_AUX_CLK>;
+
+			iommu-map = <0x100 &anoc1_smmu 0x1480 1>;
+
+			/* PCIe Fundamental Reset */
+			perst-gpios = <&tlmm 35 GPIO_ACTIVE_LOW>;
+		};
+
+		phy@1c06000 {
+			compatible = "qcom,msm8998-qmp-pcie-phy";
+			reg = <0x01c06000 0x18c>;
+			#address-cells = <1>;
+			#size-cells = <1>;
+			ranges;
+
+			clock-names = "aux", "cfg_ahb", "ref";
+			clocks =
+				<&gcc GCC_PCIE_PHY_AUX_CLK>,
+				<&gcc GCC_PCIE_0_CFG_AHB_CLK>,
+				<&gcc GCC_PCIE_CLKREF_CLK>;
+
+			reset-names = "phy", "common";
+			resets = <&gcc GCC_PCIE_0_PHY_BCR>, <&gcc GCC_PCIE_PHY_BCR>;
+
+			vdda-phy-supply = <&vreg_l1a_0p875>;
+			vdda-pll-supply = <&vreg_l2a_1p2>;
+
+			pciephy: lane@1c06800 {
+				reg = <0x01c06200 0x128>, <0x01c06400 0x1fc>, <0x01c06800 0x20c>;
+				#phy-cells = <0>;
+
+				clock-names = "pipe0";
+				clocks = <&gcc GCC_PCIE_0_PIPE_CLK>;
+				clock-output-names = "pcie_0_pipe_clk_src";
+				#clock-cells = <0>;
+			};
+		};
+
 		tcsr_mutex_regs: syscon@1f40000 {
 			compatible = "syscon";
 			reg = <0x1f40000 0x20000>;
-- 
2.17.1
