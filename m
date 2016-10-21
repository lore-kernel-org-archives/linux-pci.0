Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from lucky1.263xmail.com ([211.157.147.132]:58950 "EHLO
        lucky1.263xmail.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753367AbcJUCi7 (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 20 Oct 2016 22:38:59 -0400
From: Shawn Lin <shawn.lin@rock-chips.com>
To: Heiko Stuebner <heiko@sntech.de>,
        Bjorn Helgaas <bhelgaas@google.com>
Cc: Rob Herring <robh+dt@kernel.org>, devicetree@vger.kernel.org,
        linux-rockchip@lists.infradead.org,
        Brian Norris <briannorris@chromium.org>,
        linux-pci@vger.kernel.org, Shawn Lin <shawn.lin@rock-chips.com>
Subject: [PATCH 2/2] arm64: dts: rockchip: add three new resets for rk3399 PCIe controller
Date: Fri, 21 Oct 2016 10:43:56 +0800
Message-Id: <1477017836-19317-3-git-send-email-shawn.lin@rock-chips.com>
In-Reply-To: <1477017836-19317-1-git-send-email-shawn.lin@rock-chips.com>
References: <1477017836-19317-1-git-send-email-shawn.lin@rock-chips.com>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

pm_rst, aclk_rst and pclk_rst should be controlled by driver, so we
need to add these three resets for PCIe controller.

Signed-off-by: Shawn Lin <shawn.lin@rock-chips.com>
---

 arch/arm64/boot/dts/rockchip/rk3399.dtsi | 7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)

diff --git a/arch/arm64/boot/dts/rockchip/rk3399.dtsi b/arch/arm64/boot/dts/rockchip/rk3399.dtsi
index 76b2864..5191cfd 100644
--- a/arch/arm64/boot/dts/rockchip/rk3399.dtsi
+++ b/arch/arm64/boot/dts/rockchip/rk3399.dtsi
@@ -300,8 +300,11 @@
 		ranges = <0x83000000 0x0 0xfa000000 0x0 0xfa000000 0x0 0x600000
 			  0x81000000 0x0 0xfa600000 0x0 0xfa600000 0x0 0x100000>;
 		resets = <&cru SRST_PCIE_CORE>, <&cru SRST_PCIE_MGMT>,
-			 <&cru SRST_PCIE_MGMT_STICKY>, <&cru SRST_PCIE_PIPE>;
-		reset-names = "core", "mgmt", "mgmt-sticky", "pipe";
+			 <&cru SRST_PCIE_MGMT_STICKY>, <&cru SRST_PCIE_PIPE>,
+			 <&cru SRST_PCIE_PM>, <&cru SRST_P_PCIE>,
+			 <&cru SRST_A_PCIE>;
+		reset-names = "core", "mgmt", "mgmt-sticky", "pipe",
+			      "pm", "pclk", "aclk";
 		status = "disabled";
 
 		pcie0_intc: interrupt-controller {
-- 
2.3.7


