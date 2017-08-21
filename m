Return-Path: <linux-arm-kernel-bounces+bjorn=helgaas.com@lists.infradead.org>
Return-Path: <linux-arm-kernel-bounces+bjorn=helgaas.com@lists.infradead.org>
From: Ard Biesheuvel <ard.biesheuvel@linaro.org>
To: linux-pci@vger.kernel.org
Subject: [PATCH 3/3] dt-bindings: designware: add binding for Designware PCIe
 in ECAM mode
Date: Mon, 21 Aug 2017 20:29:07 +0100
Message-Id: <20170821192907.8695-4-ard.biesheuvel@linaro.org>
In-Reply-To: <20170821192907.8695-1-ard.biesheuvel@linaro.org>
References: <20170821192907.8695-1-ard.biesheuvel@linaro.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Cc: Rob Herring <robh@kernel.org>, Joao Pinto <Joao.Pinto@synopsys.com>,
 Graeme Gregory <graeme.gregory@linaro.org>,
 Ard Biesheuvel <ard.biesheuvel@linaro.org>,
 Marc Zyngier <marc.zyngier@arm.com>, Jingoo Han <jingoohan1@gmail.com>,
 Leif Lindholm <leif.lindholm@linaro.org>, Bjorn Helgaas <bhelgaas@google.com>,
 linux-arm-kernel@lists.infradead.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+bjorn=helgaas.com@lists.infradead.org
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


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
