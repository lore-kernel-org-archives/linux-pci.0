Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from smtp.codeaurora.org ([198.145.29.96]:48406 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751280AbdGQMEq (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 17 Jul 2017 08:04:46 -0400
From: Varadarajan Narayanan <varada@codeaurora.org>
To: bhelgaas@google.com, robh+dt@kernel.org, mark.rutland@arm.com,
        svarbanov@mm-sol.com, kishon@ti.com, sboyd@codeaurora.org,
        vivek.gautam@codeaurora.org, fengguang.wu@intel.com,
        weiyongjun1@huawei.com, linux-pci@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-msm@vger.kernel.org
Cc: Varadarajan Narayanan <varada@codeaurora.org>
Subject: [PATCH 2/7] dt-bindings: phy: qmp: Add support for QMP phy in IPQ8074
Date: Mon, 17 Jul 2017 17:33:58 +0530
Message-Id: <1500293043-1887-3-git-send-email-varada@codeaurora.org>
In-Reply-To: <1500293043-1887-1-git-send-email-varada@codeaurora.org>
References: <1500293043-1887-1-git-send-email-varada@codeaurora.org>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

IPQ8074 uses QMP phy controller that provides support to PCIe and
USB. Adding dt binding information for the same.

Signed-off-by: Varadarajan Narayanan <varada@codeaurora.org>
---
 .../devicetree/bindings/phy/qcom-qmp-phy.txt       | 28 ++++++++++++++++++++++
 1 file changed, 28 insertions(+)

diff --git a/Documentation/devicetree/bindings/phy/qcom-qmp-phy.txt b/Documentation/devicetree/bindings/phy/qcom-qmp-phy.txt
index 5d7a51f..80d766b 100644
--- a/Documentation/devicetree/bindings/phy/qcom-qmp-phy.txt
+++ b/Documentation/devicetree/bindings/phy/qcom-qmp-phy.txt
@@ -6,6 +6,7 @@ controllers on Qualcomm chipsets, such as, PCIe, UFS, and USB.
 
 Required properties:
  - compatible: compatible list, contains:
+	       "qcom,ipq8074-qmp-pcie-phy" for PCIe phy on IPQ8074
 	       "qcom,msm8996-qmp-pcie-phy" for 14nm PCIe phy on msm8996,
 	       "qcom,msm8996-qmp-usb3-phy" for 14nm USB3 phy on msm8996.
 
@@ -107,3 +108,30 @@ Example:
 		...
 		...
 	};
+
+	phy@86000 {
+		compatible = "qcom,ipq8074-qmp-pcie-phy";
+		reg = <0x86000 0x1000>;
+
+		#clock-cells = <1>;
+		#address-cells = <1>;
+		#size-cells = <1>;
+		ranges;
+
+		resets = <&gcc GCC_PCIE0_PHY_BCR>,
+			 <&gcc GCC_PCIE0PHY_PHY_BCR>;
+		reset-names = "phy",
+			      "phy_phy";
+
+		status = "ok";
+
+		pciephy_0: lane@86000 {
+			reg = <0x86200 0x130>,
+				<0x86400 0x200>,
+				<0x86800 0x1f8>;
+			#phy-cells = <0>;
+			clocks = <&gcc GCC_PCIE0_PIPE_CLK>;
+			clock-names = "pipe0";
+			clock-output-names = "pcie20_phy0_pipe_clk";
+		};
+	};
-- 
QUALCOMM INDIA, on behalf of Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum, hosted by The Linux Foundation
