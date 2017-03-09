Return-Path: <linux-arm-kernel-bounces+bjorn=helgaas.com@lists.infradead.org>
Return-Path: <linux-arm-kernel-bounces+bjorn=helgaas.com@lists.infradead.org>
From: Kishon Vijay Abraham I <kishon@ti.com>
To: Bjorn Helgaas <bhelgaas@google.com>, Joao Pinto <Joao.Pinto@synopsys.com>,
 <linux-doc@vger.kernel.org>, <devicetree@vger.kernel.org>,
 <linux-pci@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
 <linux-omap@vger.kernel.org>, <linux-arm-kernel@lists.infradead.org>
Subject: [PATCH v3 10/23] dt-bindings: PCI: Add dt bindings for pci designware
 EP mode
Date: Thu, 9 Mar 2017 13:27:21 +0530
Message-ID: <1489046254-19919-11-git-send-email-kishon@ti.com>
In-Reply-To: <1489046254-19919-1-git-send-email-kishon@ti.com>
References: <1489046254-19919-1-git-send-email-kishon@ti.com>
MIME-Version: 1.0
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Cc: hch@infradead.org, nsekhar@ti.com, kishon@ti.com
Content-Type: text/plain; charset="us-ascii"
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+bjorn=helgaas.com@lists.infradead.org
List-ID: <linux-pci.vger.kernel.org>

Add device tree binding documentation for pci designware EP mode.

Acked-by: Rob Herring <robh@kernel.org>
Signed-off-by: Kishon Vijay Abraham I <kishon@ti.com>
---
 .../devicetree/bindings/pci/designware-pcie.txt    |   26 ++++++++++++++------
 1 file changed, 18 insertions(+), 8 deletions(-)

diff --git a/Documentation/devicetree/bindings/pci/designware-pcie.txt b/Documentation/devicetree/bindings/pci/designware-pcie.txt
index 1392c70..b2480dd 100644
--- a/Documentation/devicetree/bindings/pci/designware-pcie.txt
+++ b/Documentation/devicetree/bindings/pci/designware-pcie.txt
@@ -6,30 +6,40 @@ Required properties:
 - reg-names: Must be "config" for the PCIe configuration space.
     (The old way of getting the configuration address space from "ranges"
     is deprecated and should be avoided.)
+- num-lanes: number of lanes to use
+RC mode:
 - #address-cells: set to <3>
 - #size-cells: set to <2>
 - device_type: set to "pci"
 - ranges: ranges for the PCI memory and I/O regions
 - #interrupt-cells: set to <1>
-- interrupt-map-mask and interrupt-map: standard PCI properties
-	to define the mapping of the PCIe interface to interrupt
+- interrupt-map-mask and interrupt-map: standard PCI
+	properties to define the mapping of the PCIe interface to interrupt
 	numbers.
-- num-lanes: number of lanes to use
+EP mode:
+- num-ib-windows: number of inbound address translation
+        windows
+- num-ob-windows: number of outbound address translation
+        windows
 
 Optional properties:
-- num-viewport: number of view ports configured in hardware.  If a platform
-  does not specify it, the driver assumes 2.
 - num-lanes: number of lanes to use (this property should be specified unless
   the link is brought already up in BIOS)
 - reset-gpio: gpio pin number of power good signal
-- bus-range: PCI bus numbers covered (it is recommended for new devicetrees to
-  specify this property, to keep backwards compatibility a range of 0x00-0xff
-  is assumed if not present)
 - clocks: Must contain an entry for each entry in clock-names.
 	See ../clocks/clock-bindings.txt for details.
 - clock-names: Must include the following entries:
 	- "pcie"
 	- "pcie_bus"
+RC mode:
+- num-viewport: number of view ports configured in
+  hardware. If a platform does not specify it, the driver assumes 2.
+- bus-range: PCI bus numbers covered (it is recommended
+  for new devicetrees to specify this property, to keep backwards
+  compatibility a range of 0x00-0xff is assumed if not present)
+EP mode:
+- max-functions: maximum number of functions that can be
+  configured
 
 Example configuration:
 
-- 
1.7.9.5


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
