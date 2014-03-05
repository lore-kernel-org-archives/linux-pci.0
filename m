Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from metis.ext.pengutronix.de ([92.198.50.35]:33536 "EHLO
	metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754569AbaCEN0f (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Wed, 5 Mar 2014 08:26:35 -0500
From: Lucas Stach <l.stach@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
Cc: linux-sh@vger.kernel.org, linux-samsung-soc@vger.kernel.org,
	linux-tegra@vger.kernel.org, linux-pci@vger.kernel.org,
	devicetree@vger.kernel.org, Jingoo Han <jg1.han@samsung.com>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Simon Horman <horms@verge.net.au>,
	Shawn Guo <shawn.guo@linaro.org>,
	Stephen Warren <swarren@wwwdotorg.org>,
	Ben Dooks <ben-linux@fluff.org>,
	Kukjin Kim <kgene.kim@samsung.com>,
	Thierry Reding <thierry.reding@gmail.com>,
	Arnd Bergmann <arnd@arndb.de>, kernel@pengutronix.de
Subject: [PATCH v2 1/6] ARM: dts: tegra: add PCIe interrupt mapping properties
Date: Wed,  5 Mar 2014 14:25:46 +0100
Message-Id: <1394025951-32438-2-git-send-email-l.stach@pengutronix.de>
In-Reply-To: <1394025951-32438-1-git-send-email-l.stach@pengutronix.de>
References: <1394025951-32438-1-git-send-email-l.stach@pengutronix.de>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Those are defined by the common PCI binding.

Signed-off-by: Lucas Stach <l.stach@pengutronix.de>
Acked-by: Arnd Bergmann <arnd@arndb.de>
---
 Documentation/devicetree/bindings/pci/nvidia,tegra20-pcie.txt | 8 ++++++++
 arch/arm/boot/dts/tegra20.dtsi                                | 4 ++++
 arch/arm/boot/dts/tegra30.dtsi                                | 4 ++++
 3 files changed, 16 insertions(+)

diff --git a/Documentation/devicetree/bindings/pci/nvidia,tegra20-pcie.txt b/Documentation/devicetree/bindings/pci/nvidia,tegra20-pcie.txt
index 24cee06915c9..c300391e8d3e 100644
--- a/Documentation/devicetree/bindings/pci/nvidia,tegra20-pcie.txt
+++ b/Documentation/devicetree/bindings/pci/nvidia,tegra20-pcie.txt
@@ -42,6 +42,10 @@ Required properties:
     - 0xc2000000: prefetchable memory region
   Please refer to the standard PCI bus binding document for a more detailed
   explanation.
+- #interrupt-cells: Size representation for interrupts (must be 1)
+- interrupt-map-mask and interrupt-map: Standard PCI IRQ mapping properties
+  Please refer to the standard PCI bus binding document for a more detailed
+  explanation.
 - clocks: Must contain an entry for each entry in clock-names.
   See ../clocks/clock-bindings.txt for details.
 - clock-names: Must include the following entries:
@@ -86,6 +90,10 @@ SoC DTSI:
 		              0 99 0x04>; /* MSI interrupt */
 		interrupt-names = "intr", "msi";
 
+		#interrupt-cells = <1>;
+		interrupt-map-mask = <0 0 0 0>;
+		interrupt-map = <0 0 0 0 &intc GIC_SPI 98 IRQ_TYPE_LEVEL_HIGH>;
+
 		bus-range = <0x00 0xff>;
 		#address-cells = <3>;
 		#size-cells = <2>;
diff --git a/arch/arm/boot/dts/tegra20.dtsi b/arch/arm/boot/dts/tegra20.dtsi
index 480ecda3416b..52ef2cf0b142 100644
--- a/arch/arm/boot/dts/tegra20.dtsi
+++ b/arch/arm/boot/dts/tegra20.dtsi
@@ -552,6 +552,10 @@
 			      GIC_SPI 99 IRQ_TYPE_LEVEL_HIGH>; /* MSI interrupt */
 		interrupt-names = "intr", "msi";
 
+		#interrupt-cells = <1>;
+		interrupt-map-mask = <0 0 0 0>;
+		interrupt-map = <0 0 0 0 &intc GIC_SPI 98 IRQ_TYPE_LEVEL_HIGH>;
+
 		bus-range = <0x00 0xff>;
 		#address-cells = <3>;
 		#size-cells = <2>;
diff --git a/arch/arm/boot/dts/tegra30.dtsi b/arch/arm/boot/dts/tegra30.dtsi
index ed8e7700b46d..e5ab7adbc28a 100644
--- a/arch/arm/boot/dts/tegra30.dtsi
+++ b/arch/arm/boot/dts/tegra30.dtsi
@@ -28,6 +28,10 @@
 			      GIC_SPI 99 IRQ_TYPE_LEVEL_HIGH>; /* MSI interrupt */
 		interrupt-names = "intr", "msi";
 
+		#interrupt-cells = <1>;
+		interrupt-map-mask = <0 0 0 0>;
+		interrupt-map = <0 0 0 0 &intc GIC_SPI 98 IRQ_TYPE_LEVEL_HIGH>;
+
 		bus-range = <0x00 0xff>;
 		#address-cells = <3>;
 		#size-cells = <2>;
-- 
1.9.0

