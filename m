Return-Path: <linux-kernel-owner@vger.kernel.org>
From: Kishon Vijay Abraham I <kishon@ti.com>
To: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Rob Herring <robh+dt@kernel.org>
CC: Mark Rutland <mark.rutland@arm.com>, <linux-omap@vger.kernel.org>,
        <devicetree@vger.kernel.org>, <linux-pci@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <nsekhar@ti.com>, <kishon@ti.com>
Subject: [PATCH v2 2/3] dt-bindings: PCI: dra7xx: Add properties to enable x2 lane in dra7
Date: Tue, 19 Dec 2017 14:28:22 +0530
Message-ID: <20171219085823.8695-3-kishon@ti.com>
In-Reply-To: <20171219085823.8695-1-kishon@ti.com>
References: <20171219085823.8695-1-kishon@ti.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Add syscon properties required for configuring PCIe in x2 lane mode.

Signed-off-by: Kishon Vijay Abraham I <kishon@ti.com>
Signed-off-by: Sekhar Nori <nsekhar@ti.com>
---
 Documentation/devicetree/bindings/pci/ti-pci.txt | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/Documentation/devicetree/bindings/pci/ti-pci.txt b/Documentation/devicetree/bindings/pci/ti-pci.txt
index 82cb875e4cec..bfbc77ac7355 100644
--- a/Documentation/devicetree/bindings/pci/ti-pci.txt
+++ b/Documentation/devicetree/bindings/pci/ti-pci.txt
@@ -13,6 +13,12 @@ PCIe DesignWare Controller
  - ti,hwmods : Name of the hwmod associated to the pcie, "pcie<X>",
 	       where <X> is the instance number of the pcie from the HW spec.
  - num-lanes as specified in ../designware-pcie.txt
+ - ti,syscon-lane-conf : phandle/offset pair. Phandle to the system control
+			 module and the register offset to specify 1 lane or
+			 2 lane.
+ - ti,syscon-lane-sel : phandle/offset pair. Phandle to the system control
+			module and the register offset to specify lane
+			selection.
 
 HOST MODE
 =========
-- 
2.11.0
