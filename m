Return-Path: <linux-arm-kernel-bounces+bjorn=helgaas.com@lists.infradead.org>
Return-Path: <linux-arm-kernel-bounces+bjorn=helgaas.com@lists.infradead.org>
From: Kishon Vijay Abraham I <kishon@ti.com>
To: Bjorn Helgaas <bhelgaas@google.com>, Jingoo Han <jingoohan1@gmail.com>,
 Joao Pinto <Joao.Pinto@synopsys.com>
Subject: [PATCH v2 12/22] dt-bindings: PCI: dra7xx: Add dt bindings for pci
 dra7xx EP mode
Date: Fri, 17 Feb 2017 15:20:32 +0530
Message-ID: <1487325042-28227-13-git-send-email-kishon@ti.com>
In-Reply-To: <1487325042-28227-1-git-send-email-kishon@ti.com>
References: <1487325042-28227-1-git-send-email-kishon@ti.com>
MIME-Version: 1.0
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Cc: devicetree@vger.kernel.org, linux-doc@vger.kernel.org,
 linux-pci@vger.kernel.org, nsekhar@ti.com, linux-kernel@vger.kernel.org,
 Kishon Vijay Abraham I <kishon@ti.com>, linux-omap@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="us-ascii"
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+bjorn=helgaas.com@lists.infradead.org
List-ID: <linux-pci.vger.kernel.org>

Add device tree binding documentation for pci dra7xx EP mode.

Acked-by: Rob Herring <robh@kernel.org>
Signed-off-by: Kishon Vijay Abraham I <kishon@ti.com>
---
 Documentation/devicetree/bindings/pci/ti-pci.txt |   37 ++++++++++++++++++----
 1 file changed, 30 insertions(+), 7 deletions(-)

diff --git a/Documentation/devicetree/bindings/pci/ti-pci.txt b/Documentation/devicetree/bindings/pci/ti-pci.txt
index 60e2516..190828a 100644
--- a/Documentation/devicetree/bindings/pci/ti-pci.txt
+++ b/Documentation/devicetree/bindings/pci/ti-pci.txt
@@ -1,17 +1,22 @@
 TI PCI Controllers
 
 PCIe Designware Controller
- - compatible: Should be "ti,dra7-pcie""
- - reg : Two register ranges as listed in the reg-names property
- - reg-names : The first entry must be "ti-conf" for the TI specific registers
-	       The second entry must be "rc-dbics" for the designware pcie
-	       registers
-	       The third entry must be "config" for the PCIe configuration space
+ - compatible: Should be "ti,dra7-pcie" for RC
+	       Should be "ti,dra7-pcie-ep" for EP
  - phys : list of PHY specifiers (used by generic PHY framework)
  - phy-names : must be "pcie-phy0", "pcie-phy1", "pcie-phyN".. based on the
 	       number of PHYs as specified in *phys* property.
  - ti,hwmods : Name of the hwmod associated to the pcie, "pcie<X>",
 	       where <X> is the instance number of the pcie from the HW spec.
+ - num-lanes as specified in ../designware-pcie.txt
+
+HOST MODE
+=========
+ - reg : Two register ranges as listed in the reg-names property
+ - reg-names : The first entry must be "ti-conf" for the TI specific registers
+	       The second entry must be "rc-dbics" for the designware pcie
+	       registers
+	       The third entry must be "config" for the PCIe configuration space
  - interrupts : Two interrupt entries must be specified. The first one is for
 		main interrupt line and the second for MSI interrupt line.
  - #address-cells,
@@ -19,13 +24,31 @@ PCIe Designware Controller
    #interrupt-cells,
    device_type,
    ranges,
-   num-lanes,
    interrupt-map-mask,
    interrupt-map : as specified in ../designware-pcie.txt
 
+DEVICE MODE
+===========
+ - reg : Four register ranges as listed in the reg-names property
+ - reg-names : "ti-conf" for the TI specific registers
+	       "ep_dbics" for the standard configuration registers as
+		they are locally accessed within the DIF CS space
+	       "ep_dbics2" for the standard configuration registers as
+		they are locally accessed within the DIF CS2 space
+	       "addr_space" used to map remote RC address space
+ - interrupts : one interrupt entries must be specified for main interrupt.
+ - num-ib-windows : number of inbound address translation windows
+ - num-ob-windows : number of outbound address translation windows
+
 Optional Property:
  - gpios : Should be added if a gpio line is required to drive PERST# line
 
+NOTE: Two dt nodes may be added for each PCI controller; one for host
+mode and another for device mode. So in order for PCI to
+work in host mode, EP mode dt node should be disabled and in order to PCI to
+work in EP mode, host mode dt node should be disabled. And host mode and EP
+mode are mutually exclusive.
+
 Example:
 axi {
 	compatible = "simple-bus";
-- 
1.7.9.5


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
