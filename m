Return-Path: <linux-kernel-owner@vger.kernel.org>
From: Gustavo Pimentel <gustavo.pimentel@synopsys.com>
To: bhelgaas@google.com, lorenzo.pieralisi@arm.com,
        Joao.Pinto@synopsys.com, jingoohan1@gmail.com, kishon@ti.com,
        robh+dt@kernel.org, mark.rutland@arm.com
Cc: linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org,
        Gustavo Pimentel <gustavo.pimentel@synopsys.com>
Subject: [PATCH v2 3/4] bindings: PCI: designware: Add support for EP in DesignWare driver
Date: Tue, 15 May 2018 15:41:43 +0100
Message-Id: <46ba656013d1493e87b32a2e1dca125cb63dcc2a.1526395185.git.gustavo.pimentel@synopsys.com>
In-Reply-To: <cover.1526395185.git.gustavo.pimentel@synopsys.com>
References: <cover.1526395185.git.gustavo.pimentel@synopsys.com>
In-Reply-To: <cover.1526395185.git.gustavo.pimentel@synopsys.com>
References: <cover.1526395185.git.gustavo.pimentel@synopsys.com>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Add device tree binding documentation for the EP in PCIe DesignWare driver.

Signed-off-by: Gustavo Pimentel <gustavo.pimentel@synopsys.com>
Reviewed-by: Rob Herring <robh@kernel.org>
---
 Documentation/devicetree/bindings/pci/designware-pcie.txt | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/Documentation/devicetree/bindings/pci/designware-pcie.txt b/Documentation/devicetree/bindings/pci/designware-pcie.txt
index 7f9804d..c124f9b 100644
--- a/Documentation/devicetree/bindings/pci/designware-pcie.txt
+++ b/Documentation/devicetree/bindings/pci/designware-pcie.txt
@@ -3,6 +3,7 @@
 Required properties:
 - compatible:
 	"snps,dw-pcie" for RC mode;
+	"snps,dw-pcie-ep" for EP mode;
 - reg: Should contain the configuration address space.
 - reg-names: Must be "config" for the PCIe configuration space.
     (The old way of getting the configuration address space from "ranges"
@@ -56,3 +57,14 @@ Example configuration:
 		#interrupt-cells = <1>;
 		num-lanes = <1>;
 	};
+or
+	pcie: pcie@dfc00000 {
+		compatible = "snps,dw-pcie-ep";
+		reg = <0xdfc00000 0x0001000>, /* IP registers 1 */
+		      <0xdfc01000 0x0001000>, /* IP registers 2 */
+		      <0xd0000000 0x2000000>; /* Configuration space */
+		reg-names = "dbi", "dbi2", "addr_space";
+		num-ib-windows = <6>;
+		num-ob-windows = <2>;
+		num-lanes = <1>;
+	};
-- 
2.7.4
