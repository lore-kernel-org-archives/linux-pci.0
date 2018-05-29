Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-qk0-f194.google.com ([209.85.220.194]:33374 "EHLO
        mail-qk0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S967539AbeE2V7S (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 29 May 2018 17:59:18 -0400
Received: by mail-qk0-f194.google.com with SMTP id h7-v6so5659788qkm.0
        for <linux-pci@vger.kernel.org>; Tue, 29 May 2018 14:59:18 -0700 (PDT)
From: Ray Jui <ray.jui@broadcom.com>
To: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>
Cc: linux-kernel@vger.kernel.org,
        bcm-kernel-feedback-list@broadcom.com, linux-pci@vger.kernel.org,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        Ray Jui <ray.jui@broadcom.com>
Subject: [PATCH 5/6] arm: dts: Change PCIe INTx mapping for HR2
Date: Tue, 29 May 2018 14:58:49 -0700
Message-Id: <1527631130-20045-6-git-send-email-ray.jui@broadcom.com>
In-Reply-To: <1527631130-20045-1-git-send-email-ray.jui@broadcom.com>
References: <1527631130-20045-1-git-send-email-ray.jui@broadcom.com>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Change the PCIe INTx mapping to model the 4 INTx interrupts in the
IRQ domain of the iProc PCIe controller itself

Signed-off-by: Ray Jui <ray.jui@broadcom.com>
---
 arch/arm/boot/dts/bcm-hr2.dtsi | 18 ++++++++++++++----
 1 file changed, 14 insertions(+), 4 deletions(-)

diff --git a/arch/arm/boot/dts/bcm-hr2.dtsi b/arch/arm/boot/dts/bcm-hr2.dtsi
index 3f9cedd..20e3161 100644
--- a/arch/arm/boot/dts/bcm-hr2.dtsi
+++ b/arch/arm/boot/dts/bcm-hr2.dtsi
@@ -298,9 +298,14 @@
 		compatible = "brcm,iproc-pcie";
 		reg = <0x18012000 0x1000>;
 
+		interrupt-controller;
 		#interrupt-cells = <1>;
-		interrupt-map-mask = <0 0 0 0>;
-		interrupt-map = <0 0 0 0 &gic GIC_SPI 186 IRQ_TYPE_NONE>;
+		interrupt-map-mask = <0 0 0 7>;
+		interrupt-map = <0 0 0 1 &pcie0 1>,
+				<0 0 0 2 &pcie0 2>,
+				<0 0 0 3 &pcie0 3>,
+				<0 0 0 4 &pcie0 4>;
+		interrupts = <GIC_SPI 186 IRQ_TYPE_NONE>;
 
 		linux,pci-domain = <0>;
 
@@ -334,9 +339,14 @@
 		compatible = "brcm,iproc-pcie";
 		reg = <0x18013000 0x1000>;
 
+		interrupt-controller;
 		#interrupt-cells = <1>;
-		interrupt-map-mask = <0 0 0 0>;
-		interrupt-map = <0 0 0 0 &gic GIC_SPI 192 IRQ_TYPE_NONE>;
+		interrupt-map-mask = <0 0 0 7>;
+		interrupt-map = <0 0 0 1 &pcie1 1>,
+				<0 0 0 2 &pcie1 2>,
+				<0 0 0 3 &pcie1 3>,
+				<0 0 0 4 &pcie1 4>;
+		interrupts = <GIC_SPI 192 IRQ_TYPE_NONE>;
 
 		linux,pci-domain = <1>;
 
-- 
2.1.4
