Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from lucky1.263xmail.com ([211.157.147.133]:46889 "EHLO
        lucky1.263xmail.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751336AbdGRH7p (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 18 Jul 2017 03:59:45 -0400
From: Shawn Lin <shawn.lin@rock-chips.com>
To: Bjorn Helgaas <bhelgaas@google.com>,
        Kishon Vijay Abraham I <kishon@ti.com>
Cc: Rob Herring <robh@kernel.org>, Heiko Stuebner <heiko@sntech.de>,
        linux-pci@vger.kernel.org, linux-rockchip@lists.infradead.org,
        Brian Norris <briannorris@chromium.org>,
        Jeffy Chen <jeffy.chen@rock-chips.com>,
        devicetree@vger.kernel.org, Shawn Lin <shawn.lin@rock-chips.com>
Subject: [RFC PATCH v3 5/7] arm64: dts: rockchip: convert PCIe to use per-lane PHYs for rk3339
Date: Tue, 18 Jul 2017 15:59:20 +0800
Message-Id: <1500364762-98146-1-git-send-email-shawn.lin@rock-chips.com>
In-Reply-To: <1500364623-97041-1-git-send-email-shawn.lin@rock-chips.com>
References: <1500364623-97041-1-git-send-email-shawn.lin@rock-chips.com>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Convert all RK3399 platforms to use per-lane PHY model in
order to save more power by idling the unused lane(s).

Signed-off-by: Shawn Lin <shawn.lin@rock-chips.com>
Tested-by: Jeffy Chen <jeffy.chen@rock-chips.com>
---

Changes in v3: None
Changes in v2: None

 arch/arm64/boot/dts/rockchip/rk3399.dtsi | 8 +++++---
 1 file changed, 5 insertions(+), 3 deletions(-)

diff --git a/arch/arm64/boot/dts/rockchip/rk3399.dtsi b/arch/arm64/boot/dts/rockchip/rk3399.dtsi
index 69c56f7..5b78ce1 100644
--- a/arch/arm64/boot/dts/rockchip/rk3399.dtsi
+++ b/arch/arm64/boot/dts/rockchip/rk3399.dtsi
@@ -238,8 +238,10 @@
 		linux,pci-domain = <0>;
 		max-link-speed = <1>;
 		msi-map = <0x0 &its 0x0 0x1000>;
-		phys = <&pcie_phy>;
-		phy-names = "pcie-phy";
+		phys = <&pcie_phy 0>, <&pcie_phy 1>,
+		       <&pcie_phy 2>, <&pcie_phy 3>;
+		phy-names = "pcie-phy-0", "pcie-phy-1",
+			    "pcie-phy-2", "pcie-phy-3";
 		ranges = <0x83000000 0x0 0xfa000000 0x0 0xfa000000 0x0 0x1e00000
 			  0x81000000 0x0 0xfbe00000 0x0 0xfbe00000 0x0 0x100000>;
 		resets = <&cru SRST_PCIE_CORE>, <&cru SRST_PCIE_MGMT>,
@@ -1295,7 +1297,7 @@
 			compatible = "rockchip,rk3399-pcie-phy";
 			clocks = <&cru SCLK_PCIEPHY_REF>;
 			clock-names = "refclk";
-			#phy-cells = <0>;
+			#phy-cells = <1>;
 			resets = <&cru SRST_PCIEPHY>;
 			reset-names = "phy";
 			status = "disabled";
-- 
1.9.1
