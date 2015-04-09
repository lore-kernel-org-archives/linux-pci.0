Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from exprod5og121.obsmtp.com ([64.18.0.139]:48985 "EHLO
	mail-pd0-f178.google.com" rhost-flags-OK-OK-OK-FAIL)
	by vger.kernel.org with ESMTP id S1755723AbbDIRFr (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Thu, 9 Apr 2015 13:05:47 -0400
Received: by pddn5 with SMTP id n5so159150746pdd.2
        for <linux-pci@vger.kernel.org>; Thu, 09 Apr 2015 10:05:46 -0700 (PDT)
From: Duc Dang <dhdang@apm.com>
To: Bjorn Helgaas <bhelgaas@google.com>, Arnd Bergmann <arnd@arndb.de>,
	Grant Likely <grant.likely@linaro.org>,
	Liviu Dudau <Liviu.Dudau@arm.com>,
	Marc Zyngier <marc.zyngier@arm.com>
Cc: linux-pci@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org, Tanmay Inamdar <tinamdar@apm.com>,
	Loc Ho <lho@apm.com>, Feng Kan <fkan@apm.com>,
	Duc Dang <dhdang@apm.com>
Subject: [PATCH v3 3/4] documentation: dts: Add the device tree binding for APM X-Gene v1 PCIe MSI device tree node
Date: Thu,  9 Apr 2015 10:05:05 -0700
Message-Id: <a2f637a7bf23b6a4cbd0e8cad19a9cf16eb52071.1428564115.git.dhdang@apm.com>
In-Reply-To: <cover.1428564115.git.dhdang@apm.com>
References: <cover.1428564115.git.dhdang@apm.com>
In-Reply-To: <cover.1428564115.git.dhdang@apm.com>
References: <20150408084448.5f0793b7@why.wild-wind.fr.eu.org> <cover.1428564115.git.dhdang@apm.com>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

The driver for this binding is under 'drivers/pci/host/pci-xgene-msi.c'

Signed-off-by: Duc Dang <dhdang@apm.com>
Signed-off-by: Tanmay Inamdar <tinamdar@apm.com>
---
 .../devicetree/bindings/pci/xgene-pci-msi.txt      | 63 ++++++++++++++++++++++
 1 file changed, 63 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/pci/xgene-pci-msi.txt

diff --git a/Documentation/devicetree/bindings/pci/xgene-pci-msi.txt b/Documentation/devicetree/bindings/pci/xgene-pci-msi.txt
new file mode 100644
index 0000000..0ffdcb3
--- /dev/null
+++ b/Documentation/devicetree/bindings/pci/xgene-pci-msi.txt
@@ -0,0 +1,63 @@
+* AppliedMicro X-Gene PCIe MSI interface
+
+Required properties:
+
+- compatible: should contain "apm,xgene1-msi" to identify the core.
+- msi-controller: indicates that this is X-Gene1 PCIe MSI controller node
+- reg: A list of physical base address and length for each set of controller
+       registers.
+- interrupts: A list of interrupt outputs of the controller.
+
+Each PCIe node needs to have property msi-parent that points to msi controller node
+
+Examples:
+
+SoC DTSI:
+
+	+ MSI node:
+	msi@79000000 {
+		compatible = "apm,xgene1-msi";
+		msi-controller;
+		reg = <0x00 0x79000000 0x0 0x900000>;
+		interrupts = <  0x0 0x10 0x4
+				0x0 0x11 0x4
+				0x0 0x12 0x4
+				0x0 0x13 0x4
+				0x0 0x14 0x4
+				0x0 0x15 0x4
+				0x0 0x16 0x4
+				0x0 0x17 0x4
+				0x0 0x18 0x4
+				0x0 0x19 0x4
+				0x0 0x1a 0x4
+				0x0 0x1b 0x4
+				0x0 0x1c 0x4
+				0x0 0x1d 0x4
+				0x0 0x1e 0x4
+				0x0 0x1f 0x4>;
+	};
+
+	+ PCIe controller node with msi-parent property pointing to MSI node:
+	pcie0: pcie@1f2b0000 {
+		status = "disabled";
+		device_type = "pci";
+		compatible = "apm,xgene-storm-pcie", "apm,xgene-pcie";
+		#interrupt-cells = <1>;
+		#size-cells = <2>;
+		#address-cells = <3>;
+		reg = < 0x00 0x1f2b0000 0x0 0x00010000   /* Controller registers */
+			0xe0 0xd0000000 0x0 0x00040000>; /* PCI config space */
+		reg-names = "csr", "cfg";
+		ranges = <0x01000000 0x00 0x00000000 0xe0 0x10000000 0x00 0x00010000   /* io */
+			  0x02000000 0x00 0x80000000 0xe1 0x80000000 0x00 0x80000000>; /* mem */
+		dma-ranges = <0x42000000 0x80 0x00000000 0x80 0x00000000 0x00 0x80000000
+			      0x42000000 0x00 0x00000000 0x00 0x00000000 0x80 0x00000000>;
+		interrupt-map-mask = <0x0 0x0 0x0 0x7>;
+		interrupt-map = <0x0 0x0 0x0 0x1 &gic 0x0 0xc2 0x1
+				 0x0 0x0 0x0 0x2 &gic 0x0 0xc3 0x1
+				 0x0 0x0 0x0 0x3 &gic 0x0 0xc4 0x1
+				 0x0 0x0 0x0 0x4 &gic 0x0 0xc5 0x1>;
+		dma-coherent;
+		clocks = <&pcie0clk 0>;
+		msi-parent= <&msi>;
+	};
-- 
1.9.1

