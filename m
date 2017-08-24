Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-wm0-f50.google.com ([74.125.82.50]:35721 "EHLO
        mail-wm0-f50.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753021AbdHXSnv (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 24 Aug 2017 14:43:51 -0400
Received: by mail-wm0-f50.google.com with SMTP id b189so2146954wmd.0
        for <linux-pci@vger.kernel.org>; Thu, 24 Aug 2017 11:43:51 -0700 (PDT)
From: Ard Biesheuvel <ard.biesheuvel@linaro.org>
To: linux-pci@vger.kernel.org
Cc: mw@semihalf.com, Ard Biesheuvel <ard.biesheuvel@linaro.org>,
        Leif Lindholm <leif.lindholm@linaro.org>,
        Graeme Gregory <graeme.gregory@linaro.org>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Jingoo Han <jingoohan1@gmail.com>,
        Joao Pinto <Joao.Pinto@synopsys.com>,
        Marc Zyngier <marc.zyngier@arm.com>,
        Rob Herring <robh@kernel.org>
Subject: [PATCH v2 3/3] dt-bindings: designware: add binding for Designware PCIe in ECAM mode
Date: Thu, 24 Aug 2017 19:43:21 +0100
Message-Id: <20170824184321.19432-4-ard.biesheuvel@linaro.org>
In-Reply-To: <20170824184321.19432-1-ard.biesheuvel@linaro.org>
References: <20170824184321.19432-1-ard.biesheuvel@linaro.org>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Describe the binding for firmware-configured instances of the Synopsys
Designware PCIe controller in RC mode.

Cc: Rob Herring <robh@kernel.org>
Signed-off-by: Ard Biesheuvel <ard.biesheuvel@linaro.org>
---
 Documentation/devicetree/bindings/pci/designware-pcie-ecam.txt | 56 ++++++++++++++++++++
 1 file changed, 56 insertions(+)

diff --git a/Documentation/devicetree/bindings/pci/designware-pcie-ecam.txt b/Documentation/devicetree/bindings/pci/designware-pcie-ecam.txt
new file mode 100644
index 000000000000..b8127b19c220
--- /dev/null
+++ b/Documentation/devicetree/bindings/pci/designware-pcie-ecam.txt
@@ -0,0 +1,56 @@
+* Synopsys Designware PCIe root complex in ECAM mode
+
+In some cases, firmware may already have configured the Synopsys Designware
+PCIe controller in RC mode with static ATU window mappings that cover all
+config, MMIO and I/O spaces in a [mostly] ECAM compatible fashion.
+In this case, there is no need for the OS to perform any low level setup
+of clocks or device registers, nor is there any reason for the driver to
+reconfigure ATU windows for config and/or IO space accesses at runtime.
+
+Such hardware configurations should be described as "pci-host-ecam-generic"
+if they are truly ECAM compatible. Configurations that require no low-level
+setup by the OS nor any ATU window reconfiguration at runtime, but do
+require special handling for type 0 config TLPs may instead be described as
+"snps,dw-pcie-ecam".
+
+Required properties:
+- compatible: should contain "snps,dw-pcie-ecam".
+
+Please refer to the binding document of "pci-host-ecam-generic" in the
+file host-generic-pci.txt for a description of the remaining required
+and optional properties.
+
+
+* MSI support for Synopsys Designware PCIe root complex in ECAM mode
+
+Platforms that elect to perform all configuration of the RC in firmware
+and use the "pci-host-ecam-generic" or "snps,dw-pcie-ecam" binding to
+describe it to the OS may include a separate description of the embedded
+MSI controller in case no MSI support is available in the core interrupt
+controller.
+
+Required properties:
+- compatible:      should contain "snps,dw-pcie-msi".
+- reg:             a single region describing the device registers.
+- interrupts:      interrupt specifier for the interrupt that is asserted when
+                   an MSI is received by the RC.
+- msi-controller:  empty property identifying this device as an MSI controller.
+
+Example for an implementation that routes all legacy INTx interrupts via SPI
+#188 and all MSI interrupts via SPI #190:
+
+  pcie@20000000 {
+    compatible = "snps,dw-pcie-ecam";
+    device_type = "pci";
+    msi-parent = <&msi0>;
+    interrupt-map-mask = <0x0 0x0 0x0 0x0>;
+    interrupt-map = <0x0 0x0 0x0 0x0 &gic GIC_SPI 188 IRQ_TYPE_LEVEL_HIGH>;
+    ...
+  };
+
+  msi0: msi@10000000 {
+    compatible = "snps,dw-pcie-msi";
+    reg = <0x0 0x10000000 0x0 0x10000>;
+    interrupts = <GIC_SPI 190 IRQ_TYPE_LEVEL_HIGH>;
+    msi-controller;
+  };
-- 
2.11.0
