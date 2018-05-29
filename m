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
Subject: [PATCH 6/6] arm64: dts: Change PCIe INTx mapping for NS2
Date: Tue, 29 May 2018 14:58:50 -0700
Message-Id: <1527631130-20045-7-git-send-email-ray.jui@broadcom.com>
In-Reply-To: <1527631130-20045-1-git-send-email-ray.jui@broadcom.com>
References: <1527631130-20045-1-git-send-email-ray.jui@broadcom.com>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Change the PCIe INTx mapping to model the 4 INTx interrupts in the
IRQ domain of the iProc PCIe controller itself

Signed-off-by: Ray Jui <ray.jui@broadcom.com>
---
 arch/arm64/boot/dts/broadcom/northstar2/ns2.dtsi | 19 ++++++++++++++-----
 1 file changed, 14 insertions(+), 5 deletions(-)

diff --git a/arch/arm64/boot/dts/broadcom/northstar2/ns2.dtsi b/arch/arm64/boot/dts/broadcom/northstar2/ns2.dtsi
index 4a2a6af..0373ebe 100644
--- a/arch/arm64/boot/dts/broadcom/northstar2/ns2.dtsi
+++ b/arch/arm64/boot/dts/broadcom/northstar2/ns2.dtsi
@@ -116,9 +116,14 @@
 		reg = <0 0x20020000 0 0x1000>;
 		dma-coherent;
 
+		interrupt-controller;
 		#interrupt-cells = <1>;
-		interrupt-map-mask = <0 0 0 0>;
-		interrupt-map = <0 0 0 0 &gic 0 GIC_SPI 281 IRQ_TYPE_NONE>;
+		interrupt-map-mask = <0 0 0 7>;
+		interrupt-map = <0 0 0 1 &pcie0 1>,
+				<0 0 0 2 &pcie0 2>,
+				<0 0 0 3 &pcie0 3>,
+				<0 0 0 4 &pcie0 4>;
+		interrupts = <GIC_SPI 281 IRQ_TYPE_NONE>;
 
 		linux,pci-domain = <0>;
 
@@ -147,9 +152,14 @@
 		reg = <0 0x50020000 0 0x1000>;
 		dma-coherent;
 
+		interrupt-controller;
 		#interrupt-cells = <1>;
-		interrupt-map-mask = <0 0 0 0>;
-		interrupt-map = <0 0 0 0 &gic 0 GIC_SPI 305 IRQ_TYPE_NONE>;
+		interrupt-map-mask = <0 0 0 7>;
+		interrupt-map = <0 0 0 1 &pcie4 1>,
+				<0 0 0 2 &pcie4 2>,
+				<0 0 0 3 &pcie4 3>,
+				<0 0 0 4 &pcie4 4>;
+		interrupts = <GIC_SPI 305 IRQ_TYPE_NONE>;
 
 		linux,pci-domain = <4>;
 
@@ -169,7 +179,6 @@
 
 		phys = <&pci_phy1>;
 		phy-names = "pcie-phy";
-
 		msi-parent = <&v2m0>;
 	};
 
-- 
2.1.4
