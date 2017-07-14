Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from lucky1.263xmail.com ([211.157.147.130]:51362 "EHLO
        lucky1.263xmail.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753059AbdGNDxf (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 13 Jul 2017 23:53:35 -0400
From: Shawn Lin <shawn.lin@rock-chips.com>
To: Bjorn Helgaas <bhelgaas@google.com>, Rob Herring <robh@kernel.org>,
        Kishon Vijay Abraham I <kishon@ti.com>
Cc: Heiko Stuebner <heiko@sntech.de>, linux-pci@vger.kernel.org,
        linux-rockchip@lists.infradead.org,
        Brian Norris <briannorris@chromium.org>,
        Jeffy Chen <jeffy.chen@rock-chips.com>,
        devicetree@vger.kernel.org, Shawn Lin <shawn.lin@rock-chips.com>
Subject: [RFC PATCH 5/6] arm64: dts: rockchip: convert PCIe to use per-lane PHYs for rk3339-evb
Date: Fri, 14 Jul 2017 11:52:45 +0800
Message-Id: <1500004366-241633-4-git-send-email-shawn.lin@rock-chips.com>
In-Reply-To: <1500004366-241633-1-git-send-email-shawn.lin@rock-chips.com>
References: <1500004101-240296-1-git-send-email-shawn.lin@rock-chips.com>
 <1500004366-241633-1-git-send-email-shawn.lin@rock-chips.com>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

DON'T MERGE currently as it's just for test and we could
introduce it for rk3399.dtsi when the PHY & PCIe drivers
finally got merged.

Signed-off-by: Shawn Lin <shawn.lin@rock-chips.com>
---

 arch/arm64/boot/dts/rockchip/rk3399-evb.dts | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/arch/arm64/boot/dts/rockchip/rk3399-evb.dts b/arch/arm64/boot/dts/rockchip/rk3399-evb.dts
index 42033bc..6398ca6 100644
--- a/arch/arm64/boot/dts/rockchip/rk3399-evb.dts
+++ b/arch/arm64/boot/dts/rockchip/rk3399-evb.dts
@@ -198,6 +198,8 @@
 &pcie0 {
 	ep-gpios = <&gpio3 RK_PB5 GPIO_ACTIVE_HIGH>;
 	num-lanes = <4>;
+	phys = <&pcie_phy 0>, <&pcie_phy 1>, <&pcie_phy 2>, <&pcie_phy 3>;
+	phy-names = "pcie-phy-0", "pcie-phy-1", "pcie-phy-2", "pcie-phy-3";
 	pinctrl-names = "default";
 	pinctrl-0 = <&pcie_clkreqn>;
 	status = "disabled";
-- 
1.9.1
