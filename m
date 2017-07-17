Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from smtp.codeaurora.org ([198.145.29.96]:48996 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751280AbdGQMFP (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 17 Jul 2017 08:05:15 -0400
From: Varadarajan Narayanan <varada@codeaurora.org>
To: bhelgaas@google.com, robh+dt@kernel.org, mark.rutland@arm.com,
        svarbanov@mm-sol.com, kishon@ti.com, sboyd@codeaurora.org,
        vivek.gautam@codeaurora.org, fengguang.wu@intel.com,
        weiyongjun1@huawei.com, linux-pci@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-msm@vger.kernel.org
Cc: Varadarajan Narayanan <varada@codeaurora.org>
Subject: [PATCH 6/7] dt-bindings: pci: qcom: Add support for IPQ8074
Date: Mon, 17 Jul 2017 17:34:02 +0530
Message-Id: <1500293043-1887-7-git-send-email-varada@codeaurora.org>
In-Reply-To: <1500293043-1887-1-git-send-email-varada@codeaurora.org>
References: <1500293043-1887-1-git-send-email-varada@codeaurora.org>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Add support for the IPQ8074 PCIe controller.  IPQ8074 supports Gen 1/2, one
lane, two PCIe root complex with support for MSI and legacy interrupts, and
it conforms to PCI Express Base 2.1 specification.

Signed-off-by: Varadarajan Narayanan <varada@codeaurora.org>
---
 .../devicetree/bindings/pci/qcom,pcie.txt          | 67 ++++++++++++++++++++++
 1 file changed, 67 insertions(+)

diff --git a/Documentation/devicetree/bindings/pci/qcom,pcie.txt b/Documentation/devicetree/bindings/pci/qcom,pcie.txt
index 9d418b7..643bcc2 100644
--- a/Documentation/devicetree/bindings/pci/qcom,pcie.txt
+++ b/Documentation/devicetree/bindings/pci/qcom,pcie.txt
@@ -9,6 +9,7 @@
 			- "qcom,pcie-apq8084" for apq8084
 			- "qcom,pcie-msm8996" for msm8996 or apq8096
 			- "qcom,pcie-ipq4019" for ipq4019
+			- "qcom,pcie-ipq8074" for ipq8074
 
 - reg:
 	Usage: required
@@ -261,3 +262,69 @@
 		pinctrl-0 = <&pcie0_pins_default>;
 		pinctrl-names = "default";
 	};
+
+* Example for ipq8074
+	pcie0: pci@20000000 {
+		compatible = "qcom,pcie-ipq8074";
+		reg =  <0x20000000 0xf1d
+			0x20000F20 0xa8
+			0x80000 0x2000
+			0x20100000 0x1000>;
+		reg-names = "dbi", "elbi", "parf", "config";
+		device_type = "pci";
+		linux,pci-domain = <0>;
+		bus-range = <0x00 0xff>;
+		num-lanes = <1>;
+		#address-cells = <3>;
+		#size-cells = <2>;
+
+		phys = <&pciephy_0>;
+		phy-names = "pciephy";
+
+		ranges = <0x81000000 0 0x20200000 0x20200000
+			  0 0x00100000   /* downstream I/O */
+			  0x82000000 0 0x20300000 0x20300000
+			  0 0x00d00000>; /* non-prefetchable memory */
+
+		interrupts = <0 52 0>;
+		interrupt-names = "msi";
+		#interrupt-cells = <1>;
+		interrupt-map-mask = <0 0 0 0x7>;
+		interrupt-map = <0 0 0 1 &intc 0 75
+				 IRQ_TYPE_LEVEL_HIGH>, /* int_a */
+				<0 0 0 2 &intc 0 78
+				 IRQ_TYPE_LEVEL_HIGH>, /* int_b */
+				<0 0 0 3 &intc 0 79
+				 IRQ_TYPE_LEVEL_HIGH>, /* int_c */
+				<0 0 0 4 &intc 0 83
+				 IRQ_TYPE_LEVEL_HIGH>; /* int_d */
+
+		clocks =	<&gcc GCC_SYS_NOC_PCIE0_AXI_CLK>,
+				<&gcc GCC_PCIE0_AXI_M_CLK>,
+				<&gcc GCC_PCIE0_AXI_S_CLK>,
+				<&gcc GCC_PCIE0_AHB_CLK>,
+				<&gcc GCC_PCIE0_AUX_CLK>;
+		clock-names =	"sys_noc",
+				"axi_m",
+				"axi_s",
+				"ahb",
+				"aux";
+
+		resets = <&gcc GCC_PCIE0_PIPE_ARES>,
+			 <&gcc GCC_PCIE0_SLEEP_ARES>,
+			 <&gcc GCC_PCIE0_CORE_STICKY_ARES>,
+			 <&gcc GCC_PCIE0_AXI_MASTER_ARES>,
+			 <&gcc GCC_PCIE0_AXI_SLAVE_ARES>,
+			 <&gcc GCC_PCIE0_AHB_ARES>,
+			 <&gcc GCC_PCIE0_AXI_MASTER_STICKY_ARES>;
+		reset-names = "pipe",
+			      "sleep",
+			      "sticky",
+			      "axi_m",
+			      "axi_s",
+			      "ahb",
+			      "axi_m_sticky";
+
+		perst-gpio = <&tlmm 58 1>;
+		status = "disabled";
+	};
-- 
QUALCOMM INDIA, on behalf of Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum, hosted by The Linux Foundation
