Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-wm0-f43.google.com ([74.125.82.43]:44191 "EHLO
        mail-wm0-f43.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751528AbdJFQjv (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 6 Oct 2017 12:39:51 -0400
Received: by mail-wm0-f43.google.com with SMTP id 196so3292065wma.1
        for <linux-pci@vger.kernel.org>; Fri, 06 Oct 2017 09:39:51 -0700 (PDT)
From: Ard Biesheuvel <ard.biesheuvel@linaro.org>
To: linux-pci@vger.kernel.org
Cc: linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        Ard Biesheuvel <ard.biesheuvel@linaro.org>,
        Leif Lindholm <leif.lindholm@linaro.org>,
        Graeme Gregory <graeme.gregory@linaro.org>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Rob Herring <robh@kernel.org>,
        Will Deacon <will.deacon@arm.com>
Subject: [PATCH v4 2/2] dt-bindings: designware: add binding for Designware PCIe in ECAM mode
Date: Fri,  6 Oct 2017 17:39:19 +0100
Message-Id: <20171006163919.14898-3-ard.biesheuvel@linaro.org>
In-Reply-To: <20171006163919.14898-1-ard.biesheuvel@linaro.org>
References: <20171006163919.14898-1-ard.biesheuvel@linaro.org>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Describe the binding for firmware-configured instances of the Synopsys
DesignWare PCIe controller in RC mode, that are almost but not quite
ECAM compliant.

Acked-by: Rob Herring <robh@kernel.org>
Signed-off-by: Ard Biesheuvel <ard.biesheuvel@linaro.org>
---
 Documentation/devicetree/bindings/pci/designware-pcie-ecam.txt | 42 ++++++++++++++++++++
 1 file changed, 42 insertions(+)

diff --git a/Documentation/devicetree/bindings/pci/designware-pcie-ecam.txt b/Documentation/devicetree/bindings/pci/designware-pcie-ecam.txt
new file mode 100644
index 000000000000..515b2f9542e5
--- /dev/null
+++ b/Documentation/devicetree/bindings/pci/designware-pcie-ecam.txt
@@ -0,0 +1,42 @@
+* Synopsys DesignWare PCIe root complex in ECAM shift mode
+
+In some cases, firmware may already have configured the Synopsys DesignWare
+PCIe controller in RC mode with static ATU window mappings that cover all
+config, MMIO and I/O spaces in a [mostly] ECAM compatible fashion.
+In this case, there is no need for the OS to perform any low level setup
+of clocks, PHYs or device registers, nor is there any reason for the driver
+to reconfigure ATU windows for config and/or IO space accesses at runtime.
+
+In cases where the IP was synthesized with a minimum ATU window size of
+64 KB, it cannot be supported by the generic ECAM driver, because it
+requires special config space accessors that filter accesses to device #1
+and beyond on the first bus.
+
+Required properties:
+- compatible: "marvell,armada8k-pcie-ecam" or
+              "socionext,synquacer-pcie-ecam" or
+              "snps,dw-pcie-ecam" (must be preceded by a more specific match)
+
+Please refer to the binding document of "pci-host-ecam-generic" in the
+file host-generic-pci.txt for a description of the remaining required
+and optional properties.
+
+Example:
+
+    pcie1: pcie@7f000000 {
+        compatible = "socionext,synquacer-pcie-ecam", "snps,dw-pcie-ecam";
+        device_type = "pci";
+        reg = <0x0 0x7f000000 0x0 0xf00000>;
+        bus-range = <0x0 0xe>;
+        #address-cells = <3>;
+        #size-cells = <2>;
+        ranges = <0x1000000 0x00 0x00010000 0x00 0x7ff00000 0x0 0x00010000>,
+                 <0x2000000 0x00 0x70000000 0x00 0x70000000 0x0 0x0f000000>,
+                 <0x3000000 0x3f 0x00000000 0x3f 0x00000000 0x1 0x00000000>;
+
+        #interrupt-cells = <0x1>;
+        interrupt-map-mask = <0x0 0x0 0x0 0x0>;
+        interrupt-map = <0x0 0x0 0x0 0x0 &gic 0x0 0x0 0x0 182 0x4>;
+        msi-map = <0x0 &its 0x0 0x10000>;
+        dma-coherent;
+    };
-- 
2.11.0
