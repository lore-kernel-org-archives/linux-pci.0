Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from exprod5og108.obsmtp.com ([64.18.0.186]:37281 "HELO
	exprod5og108.obsmtp.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with SMTP id S1751076AbbAFQYz (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Tue, 6 Jan 2015 11:24:55 -0500
Received: by mail-pa0-f52.google.com with SMTP id eu11so31361537pac.39
        for <linux-pci@vger.kernel.org>; Tue, 06 Jan 2015 08:24:55 -0800 (PST)
From: Duc Dang <dhdang@apm.com>
To: Bjorn Helgaas <bhelgaas@google.com>,
	Grant Likely <grant.likely@linaro.org>,
	Liviu Dudau <Liviu.Dudau@arm.com>
Cc: linux-pci@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	Tanmay Inamdar <tinamdar@apm.com>, Loc Ho <lho@apm.com>,
	Feng Kan <fkan@apm.com>, Duc Dang <dhdang@apm.com>
Subject: [PATCH 3/4] documentation: dts: Add the device tree binding for APM X-Gene v1 PCIe MSI device tree node.
Date: Tue,  6 Jan 2015 08:15:43 -0800
Message-Id: <33cd03155176a77c673eee4a4598e677a3a9b8b4.1420499393.git.dhdang@apm.com>
In-Reply-To: <cover.1420499393.git.dhdang@apm.com>
References: <cover.1420499393.git.dhdang@apm.com>
In-Reply-To: <cover.1420499393.git.dhdang@apm.com>
References: <cover.1420499393.git.dhdang@apm.com>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

The driver for this binding is under 'drivers/pci/host/pci-xgene-msi.c'

Signed-off-by: Tanmay Inamdar <tinamdar@apm.com>
Signed-off-by: Duc Dang <dhdang@apm.com>
---
 .../devicetree/bindings/pci/xgene-pci-msi.txt      | 34 ++++++++++++++++++++++
 1 file changed, 34 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/pci/xgene-pci-msi.txt

diff --git a/Documentation/devicetree/bindings/pci/xgene-pci-msi.txt b/Documentation/devicetree/bindings/pci/xgene-pci-msi.txt
new file mode 100644
index 0000000..386782c
--- /dev/null
+++ b/Documentation/devicetree/bindings/pci/xgene-pci-msi.txt
@@ -0,0 +1,34 @@
+* AppliedMicro X-Gene PCIe MSI interface
+
+Required properties:
+
+- compatible: should contain "apm,xgene-pcie-msi" or "apm,xgene-storm-pcie-msi"
+	to identify the core.
+- reg: A list of physical base address and length for each set of controller
+       registers.
+- interrupts: A list of interrupt outputs of the controller.
+
+Examples:
+
+SoC DTSI:
+
+	msi@79000000 {
+	     compatible = "apm,xgene-storm-pcie-msi", "apm,xgene-pcie-msi";
+	     reg = <0x00 0x79000000 0x0 0x900000>;
+	     interrupts = <  0x0 0x10 0x4
+		     0x0 0x11 0x4
+		     0x0 0x12 0x4
+		     0x0 0x13 0x4
+		     0x0 0x14 0x4
+		     0x0 0x15 0x4
+		     0x0 0x16 0x4
+		     0x0 0x17 0x4
+		     0x0 0x18 0x4
+		     0x0 0x19 0x4
+		     0x0 0x1a 0x4
+		     0x0 0x1b 0x4
+		     0x0 0x1c 0x4
+		     0x0 0x1d 0x4
+		     0x0 0x1e 0x4
+		     0x0 0x1f 0x4>;
+	};
-- 
1.9.1

