Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from hqemgate14.nvidia.com ([216.228.121.143]:11667 "EHLO
        hqemgate14.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932387AbdJWOhB (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 23 Oct 2017 10:37:01 -0400
From: Vidya Sagar <vidyas@nvidia.com>
To: <treding@nvidia.com>, <bhelgaas@google.com>
CC: <linux-tegra@vger.kernel.org>, <linux-pci@vger.kernel.org>,
        <kthota@nvidia.com>, <mmaddireddy@nvidia.com>, <vidyas@nvidia.com>,
        <robh+dt@kernel.org>, <devicetree@vger.kernel.org>
Subject: [PATCH V2 2/7] ARM: tegra: limit PCIe config space mapping to 4K for T20
Date: Mon, 23 Oct 2017 20:05:07 +0530
Message-ID: <1508769312-12465-3-git-send-email-vidyas@nvidia.com>
In-Reply-To: <1508769312-12465-1-git-send-email-vidyas@nvidia.com>
References: <1508769312-12465-1-git-send-email-vidyas@nvidia.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

reduces PCIe end point config space mapping size from its
current 256MB to 4K to give more space for BAR mapping

Signed-off-by: Vidya Sagar <vidyas@nvidia.com>
---
V2:
* no changes in this patch

 arch/arm/boot/dts/tegra20.dtsi | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/arch/arm/boot/dts/tegra20.dtsi b/arch/arm/boot/dts/tegra20.dtsi
index 7c85f97f72ea..4c761a60cdf7 100644
--- a/arch/arm/boot/dts/tegra20.dtsi
+++ b/arch/arm/boot/dts/tegra20.dtsi
@@ -591,7 +591,7 @@
 		device_type = "pci";
 		reg = <0x80003000 0x00000800   /* PADS registers */
 		       0x80003800 0x00000200   /* AFI registers */
-		       0x90000000 0x10000000>; /* configuration space */
+		       0x82000000 0x00001000>; /* configuration space */
 		reg-names = "pads", "afi", "cs";
 		interrupts = <GIC_SPI 98 IRQ_TYPE_LEVEL_HIGH   /* controller interrupt */
 			      GIC_SPI 99 IRQ_TYPE_LEVEL_HIGH>; /* MSI interrupt */
@@ -607,9 +607,9 @@
 
 		ranges = <0x82000000 0 0x80000000 0x80000000 0 0x00001000   /* port 0 registers */
 			  0x82000000 0 0x80001000 0x80001000 0 0x00001000   /* port 1 registers */
-			  0x81000000 0 0          0x82000000 0 0x00010000   /* downstream I/O */
-			  0x82000000 0 0xa0000000 0xa0000000 0 0x08000000   /* non-prefetchable memory */
-			  0xc2000000 0 0xa8000000 0xa8000000 0 0x18000000>; /* prefetchable memory */
+			  0x81000000 0 0          0x82001000 0 0x00010000   /* downstream I/O */
+			  0x82000000 0 0x82100000 0x82100000 0 0x05F00000   /* non-prefetchable memory */
+			  0xc2000000 0 0x88000000 0x88000000 0 0x38000000>; /* prefetchable memory */
 
 		clocks = <&tegra_car TEGRA20_CLK_PEX>,
 			 <&tegra_car TEGRA20_CLK_AFI>,
-- 
2.7.4
