Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from hqemgate16.nvidia.com ([216.228.121.65]:7129 "EHLO
        hqemgate16.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751341AbdITGqR (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 20 Sep 2017 02:46:17 -0400
From: Manikanta Maddireddy <mmaddireddy@nvidia.com>
To: <bhelgaas@google.com>, <thierry.reding@gmail.com>,
        <jonathanh@nvidia.com>
CC: <linux-tegra@vger.kernel.org>, <linux-pci@vger.kernel.org>,
        Manikanta Maddireddy <mmaddireddy@nvidia.com>
Subject: [PATCH 4/4] arm64: tegra: Enable PCIe on Jetson TX2
Date: Wed, 20 Sep 2017 12:12:44 +0530
Message-ID: <1505889764-19397-5-git-send-email-mmaddireddy@nvidia.com>
In-Reply-To: <1505889764-19397-1-git-send-email-mmaddireddy@nvidia.com>
References: <1505889764-19397-1-git-send-email-mmaddireddy@nvidia.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Enable x4 PCIe slot on Jetson TX2.

Signed-off-by: Manikanta Maddireddy <mmaddireddy@nvidia.com>
---
 arch/arm64/boot/dts/nvidia/tegra186-p3310.dtsi | 24 ++++++++++++++++++++++++
 1 file changed, 24 insertions(+)

diff --git a/arch/arm64/boot/dts/nvidia/tegra186-p3310.dtsi b/arch/arm64/boot/dts/nvidia/tegra186-p3310.dtsi
index cf84d7046ad5..a4d96b2a23b4 100644
--- a/arch/arm64/boot/dts/nvidia/tegra186-p3310.dtsi
+++ b/arch/arm64/boot/dts/nvidia/tegra186-p3310.dtsi
@@ -378,4 +378,28 @@
 			vin-supply = <&vdd_1v8>;
 		};
 	};
+
+	pcie@10003000 {
+		status = "okay";
+
+		dvdd-pex-supply = <&vdd_pex>;
+		hvdd-pex-pll-supply = <&vdd_1v8>;
+		hvdd-pex-supply = <&vdd_1v8>;
+		vddio-pexctl-aud-supply = <&vdd_1v8>;
+
+		pci@1,0 {
+			nvidia,num-lanes = <4>;
+			status = "okay";
+		};
+
+		pci@2,0 {
+			nvidia,num-lanes = <0>;
+			status = "disabled";
+		};
+
+		pci@3,0 {
+			nvidia,num-lanes = <1>;
+			status = "disabled";
+		};
+	};
 };
-- 
2.1.4
