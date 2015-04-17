Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from exprod5og122.obsmtp.com ([64.18.0.192]:56632 "EHLO
	mail-pd0-f175.google.com" rhost-flags-OK-OK-OK-FAIL)
	by vger.kernel.org with ESMTP id S932274AbbDQJv0 (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Fri, 17 Apr 2015 05:51:26 -0400
Received: by pdbqd1 with SMTP id qd1so123241659pdb.2
        for <linux-pci@vger.kernel.org>; Fri, 17 Apr 2015 02:51:25 -0700 (PDT)
From: Duc Dang <dhdang@apm.com>
To: Bjorn Helgaas <bhelgaas@google.com>, Arnd Bergmann <arnd@arndb.de>,
	Grant Likely <grant.likely@linaro.org>,
	Liviu Dudau <Liviu.Dudau@arm.com>,
	Marc Zyngier <marc.zyngier@arm.com>
Cc: linux-pci@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org, Tanmay Inamdar <tinamdar@apm.com>,
	Loc Ho <lho@apm.com>, Feng Kan <fkan@apm.com>,
	Duc Dang <dhdang@apm.com>
Subject: [PATCH v4 3/4] documentation: dts: Add the device tree binding for APM X-Gene v1 PCIe MSI device tree node
Date: Fri, 17 Apr 2015 02:50:09 -0700
Message-Id: <5022d14af2964be107c174180238b8661bc25b46.1429263201.git.dhdang@apm.com>
In-Reply-To: <cover.1429263201.git.dhdang@apm.com>
References: <cover.1429263201.git.dhdang@apm.com>
In-Reply-To: <cover.1429263201.git.dhdang@apm.com>
References: <20150415091655.02361cdc@arm.com> <cover.1429263201.git.dhdang@apm.com>
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

