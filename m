Return-Path: <linux-kernel-owner@vger.kernel.org>
From: Gustavo Pimentel <gustavo.pimentel@synopsys.com>
To: bhelgaas@google.com, lorenzo.pieralisi@arm.com,
        Joao.Pinto@synopsys.com, jingoohan1@gmail.com, kishon@ti.com,
        robh+dt@kernel.org, mark.rutland@arm.com
Cc: linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org,
        Gustavo Pimentel <gustavo.pimentel@synopsys.com>
Subject: [PATCH 1/4] bindings: PCI: designware: Example update
Date: Tue, 15 May 2018 08:13:26 +0100
Message-Id: <daccd2d9da8f4467680649b4226be7be711f32e8.1526368369.git.gustavo.pimentel@synopsys.com>
In-Reply-To: <cover.1526368368.git.gustavo.pimentel@synopsys.com>
References: <cover.1526368368.git.gustavo.pimentel@synopsys.com>
In-Reply-To: <cover.1526368368.git.gustavo.pimentel@synopsys.com>
References: <cover.1526368368.git.gustavo.pimentel@synopsys.com>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Replace "ctrlreg" reg-name by "dbi" to be coherent with similar drivers,
however it still be compatible with any previous DT that uses the old
reg-name.

Replace the PCIe base address example by a real PCIe base address in use.

Signed-off-by: Gustavo Pimentel <gustavo.pimentel@synopsys.com>
Reviewed-by: Rob Herring <robh@kernel.org>
---
 Documentation/devicetree/bindings/pci/designware-pcie.txt | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/Documentation/devicetree/bindings/pci/designware-pcie.txt b/Documentation/devicetree/bindings/pci/designware-pcie.txt
index 1da7ade..7f9804d 100644
--- a/Documentation/devicetree/bindings/pci/designware-pcie.txt
+++ b/Documentation/devicetree/bindings/pci/designware-pcie.txt
@@ -1,7 +1,8 @@
 * Synopsys DesignWare PCIe interface
 
 Required properties:
-- compatible: should contain "snps,dw-pcie" to identify the core.
+- compatible:
+	"snps,dw-pcie" for RC mode;
 - reg: Should contain the configuration address space.
 - reg-names: Must be "config" for the PCIe configuration space.
     (The old way of getting the configuration address space from "ranges"
@@ -41,11 +42,11 @@ EP mode:
 
 Example configuration:
 
-	pcie: pcie@dffff000 {
+	pcie: pcie@dfc00000 {
 		compatible = "snps,dw-pcie";
-		reg = <0xdffff000 0x1000>, /* Controller registers */
-		      <0xd0000000 0x2000>; /* PCI config space */
-		reg-names = "ctrlreg", "config";
+		reg = <0xdfc00000 0x0001000>, /* IP registers */
+		      <0xd0000000 0x0002000>; /* Configuration space */
+		reg-names = "dbi", "config";
 		#address-cells = <3>;
 		#size-cells = <2>;
 		device_type = "pci";
@@ -54,5 +55,4 @@ Example configuration:
 		interrupts = <25>, <24>;
 		#interrupt-cells = <1>;
 		num-lanes = <1>;
-		num-viewport = <3>;
 	};
-- 
2.7.4
