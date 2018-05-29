Return-Path: <linux-kernel-owner@vger.kernel.org>
From: Ray Jui <ray.jui@broadcom.com>
To: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>
Cc: linux-kernel@vger.kernel.org,
        bcm-kernel-feedback-list@broadcom.com, linux-pci@vger.kernel.org,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        Ray Jui <ray.jui@broadcom.com>
Subject: [PATCH 4/6] arm: dts: Change PCIe INTx mapping for NSP
Date: Tue, 29 May 2018 14:58:48 -0700
Message-Id: <1527631130-20045-5-git-send-email-ray.jui@broadcom.com>
In-Reply-To: <1527631130-20045-1-git-send-email-ray.jui@broadcom.com>
References: <1527631130-20045-1-git-send-email-ray.jui@broadcom.com>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Change the PCIe INTx mapping to model the 4 INTx interrupts in the
IRQ domain of the iProc PCIe controller itself

Signed-off-by: Ray Jui <ray.jui@broadcom.com>
---
 arch/arm/boot/dts/bcm-nsp.dtsi | 27 +++++++++++++++++++++------
 1 file changed, 21 insertions(+), 6 deletions(-)

diff --git a/arch/arm/boot/dts/bcm-nsp.dtsi b/arch/arm/boot/dts/bcm-nsp.dtsi
index dcc55aa..8c4c8b2 100644
--- a/arch/arm/boot/dts/bcm-nsp.dtsi
+++ b/arch/arm/boot/dts/bcm-nsp.dtsi
@@ -494,9 +494,14 @@
 		compatible = "brcm,iproc-pcie";
 		reg = <0x18012000 0x1000>;
 
+		interrupt-controller;
 		#interrupt-cells = <1>;
-		interrupt-map-mask = <0 0 0 0>;
-		interrupt-map = <0 0 0 0 &gic GIC_SPI 131 IRQ_TYPE_NONE>;
+		interrupt-map-mask = <0 0 0 7>;
+		interrupt-map = <0 0 0 1 &pcie0 1>,
+				<0 0 0 2 &pcie0 2>,
+				<0 0 0 3 &pcie0 3>,
+				<0 0 0 4 &pcie0 4>;
+		interrupts = <GIC_SPI 131 IRQ_TYPE_NONE>;
 
 		linux,pci-domain = <0>;
 
@@ -531,9 +536,14 @@
 		compatible = "brcm,iproc-pcie";
 		reg = <0x18013000 0x1000>;
 
+		interrupt-controller;
 		#interrupt-cells = <1>;
-		interrupt-map-mask = <0 0 0 0>;
-		interrupt-map = <0 0 0 0 &gic GIC_SPI 137 IRQ_TYPE_NONE>;
+		interrupt-map-mask = <0 0 0 7>;
+		interrupt-map = <0 0 0 1 &pcie1 1>,
+				<0 0 0 2 &pcie1 2>,
+				<0 0 0 3 &pcie1 3>,
+				<0 0 0 4 &pcie1 4>;
+		interrupts = <GIC_SPI 137 IRQ_TYPE_NONE>;
 
 		linux,pci-domain = <1>;
 
@@ -568,9 +578,14 @@
 		compatible = "brcm,iproc-pcie";
 		reg = <0x18014000 0x1000>;
 
+		interrupt-controller;
 		#interrupt-cells = <1>;
-		interrupt-map-mask = <0 0 0 0>;
-		interrupt-map = <0 0 0 0 &gic GIC_SPI 143 IRQ_TYPE_NONE>;
+		interrupt-map-mask = <0 0 0 7>;
+		interrupt-map = <0 0 0 1 &pcie2 1>,
+				<0 0 0 2 &pcie2 2>,
+				<0 0 0 3 &pcie2 3>,
+				<0 0 0 4 &pcie2 4>;
+		interrupts = <GIC_SPI 143 IRQ_TYPE_NONE>;
 
 		linux,pci-domain = <2>;
 
-- 
2.1.4
