Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from smtp.codeaurora.org ([198.145.29.96]:38086 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S933924AbdGTFfC (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 20 Jul 2017 01:35:02 -0400
From: Varadarajan Narayanan <varada@codeaurora.org>
To: bhelgaas@google.com, robh+dt@kernel.org, mark.rutland@arm.com,
        svarbanov@mm-sol.com, kishon@ti.com, sboyd@codeaurora.org,
        vivek.gautam@codeaurora.org, fengguang.wu@intel.com,
        weiyongjun1@huawei.com, linux-pci@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-msm@vger.kernel.org
Cc: Varadarajan Narayanan <varada@codeaurora.org>
Subject: [PATCH v3 1/8] dt-bindings: phy: qmp: Add output-clock-names
Date: Thu, 20 Jul 2017 11:04:33 +0530
Message-Id: <1500528880-25804-2-git-send-email-varada@codeaurora.org>
In-Reply-To: <1500528880-25804-1-git-send-email-varada@codeaurora.org>
References: <1500528880-25804-1-git-send-email-varada@codeaurora.org>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

The phy outputs a clock that will act as the parent for
the phy's pipe clock. Add the name of this clock to the
lane's DT node.

Acked-by: Rob Herring <robh@kernel.org>
Signed-off-by: Varadarajan Narayanan <varada@codeaurora.org>
---
 Documentation/devicetree/bindings/phy/qcom-qmp-phy.txt | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/Documentation/devicetree/bindings/phy/qcom-qmp-phy.txt b/Documentation/devicetree/bindings/phy/qcom-qmp-phy.txt
index e11c563..5d7a51f 100644
--- a/Documentation/devicetree/bindings/phy/qcom-qmp-phy.txt
+++ b/Documentation/devicetree/bindings/phy/qcom-qmp-phy.txt
@@ -60,6 +60,8 @@ Required properties for child node:
 	   one for each entry in clock-names.
  - clock-names: Must contain following for pcie and usb qmp phys:
 		 "pipe<lane-number>" for pipe clock specific to each lane.
+ - clock-output-names: Name of the phy clock that will be the parent for
+		       the above pipe clock.
 
  - resets: a list of phandles and reset controller specifier pairs,
 	   one for each entry in reset-names.
@@ -96,6 +98,7 @@ Example:
 
 			clocks = <&gcc GCC_PCIE_0_PIPE_CLK>;
 			clock-names = "pipe0";
+			clock-output-names = "pcie_0_pipe_clk_src";
 			resets = <&gcc GCC_PCIE_0_PHY_BCR>;
 			reset-names = "lane0";
 		};
-- 
QUALCOMM INDIA, on behalf of Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum, hosted by The Linux Foundation
