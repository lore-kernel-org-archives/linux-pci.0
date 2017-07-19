Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from smtp.codeaurora.org ([198.145.29.96]:51156 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753379AbdGSIos (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 19 Jul 2017 04:44:48 -0400
From: Varadarajan Narayanan <varada@codeaurora.org>
To: bhelgaas@google.com, robh+dt@kernel.org, mark.rutland@arm.com,
        svarbanov@mm-sol.com, kishon@ti.com, sboyd@codeaurora.org,
        vivek.gautam@codeaurora.org, fengguang.wu@intel.com,
        weiyongjun1@huawei.com, linux-pci@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-msm@vger.kernel.org
Cc: Varadarajan Narayanan <varada@codeaurora.org>
Subject: [PATCH v2 7/8] dt-bindings: pci: qcom: Add support for IPQ8074
Date: Wed, 19 Jul 2017 14:13:38 +0530
Message-Id: <1500453819-5223-8-git-send-email-varada@codeaurora.org>
In-Reply-To: <1500453819-5223-1-git-send-email-varada@codeaurora.org>
References: <1500453819-5223-1-git-send-email-varada@codeaurora.org>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Add support for the IPQ8074 PCIe controller.  IPQ8074 supports Gen 1/2, one
lane, two PCIe root complex with support for MSI and legacy interrupts, and
it conforms to PCI Express Base 2.1 specification.

Signed-off-by: Varadarajan Narayanan <varada@codeaurora.org>
---
 .../devicetree/bindings/pci/qcom,pcie.txt          | 23 ++++++++++++++++++++++
 1 file changed, 23 insertions(+)

diff --git a/Documentation/devicetree/bindings/pci/qcom,pcie.txt b/Documentation/devicetree/bindings/pci/qcom,pcie.txt
index 9d418b7..b3e36ef 100644
--- a/Documentation/devicetree/bindings/pci/qcom,pcie.txt
+++ b/Documentation/devicetree/bindings/pci/qcom,pcie.txt
@@ -9,6 +9,7 @@
 			- "qcom,pcie-apq8084" for apq8084
 			- "qcom,pcie-msm8996" for msm8996 or apq8096
 			- "qcom,pcie-ipq4019" for ipq4019
+			- "qcom,pcie-ipq8074" for ipq8074
 
 - reg:
 	Usage: required
@@ -105,6 +106,16 @@
 			- "bus_master"	Master AXI clock
 			- "bus_slave"	Slave AXI clock
 
+- clock-names:
+	Usage: required for ipq8074
+	Value type: <stringlist>
+	Definition: Should contain the following entries
+			- "iface"	PCIe to SysNOC BIU clock
+			- "axi_m"	AXI Master clock
+			- "axi_s"	AXI Slave clock
+			- "ahb"		AHB clock
+			- "aux"		Auxiliary clock
+
 - resets:
 	Usage: required
 	Value type: <prop-encoded-array>
@@ -144,6 +155,18 @@
 			- "ahb"			AHB reset
 			- "phy_ahb"		PHY AHB reset
 
+- reset-names:
+	Usage: required for ipq8074
+	Value type: <stringlist>
+	Definition: Should contain the following entries
+			- "pipe"		PIPE reset
+			- "sleep"		Sleep reset
+			- "sticky"		Core Sticky reset
+			- "axi_m"		AXI Master reset
+			- "axi_s"		AXI Slave reset
+			- "ahb"			AHB Reset
+			- "axi_m_sticky"	AXI Master Sticky reset
+
 - power-domains:
 	Usage: required for apq8084 and msm8996/apq8096
 	Value type: <prop-encoded-array>
-- 
QUALCOMM INDIA, on behalf of Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum, hosted by The Linux Foundation
