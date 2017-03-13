Return-Path: <linux-kernel-owner@vger.kernel.org>
From: Kishon Vijay Abraham I <kishon@ti.com>
To: Bjorn Helgaas <bhelgaas@google.com>,
        Joao Pinto <Joao.Pinto@synopsys.com>,
        <linux-pci@vger.kernel.org>, <linux-doc@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-omap@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>
CC: <hch@infradead.org>, <nsekhar@ti.com>, <kishon@ti.com>
Subject: [PATCH v4 15/23] dt-bindings: PCI: dra7xx: Add dt bindings to enable unaligned access
Date: Mon, 13 Mar 2017 19:52:51 +0530
Message-ID: <20170313142259.25397-16-kishon@ti.com>
In-Reply-To: <20170313142259.25397-1-kishon@ti.com>
References: <20170313142259.25397-1-kishon@ti.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Update device tree binding documentation of TI's dra7xx PCI
controller to include property for enabling unaligned mem access.

Signed-off-by: Kishon Vijay Abraham I <kishon@ti.com>
---
 Documentation/devicetree/bindings/pci/ti-pci.txt | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/Documentation/devicetree/bindings/pci/ti-pci.txt b/Documentation/devicetree/bindings/pci/ti-pci.txt
index 190828a5f32a..b69dd7dbd29e 100644
--- a/Documentation/devicetree/bindings/pci/ti-pci.txt
+++ b/Documentation/devicetree/bindings/pci/ti-pci.txt
@@ -39,6 +39,11 @@ DEVICE MODE
  - interrupts : one interrupt entries must be specified for main interrupt.
  - num-ib-windows : number of inbound address translation windows
  - num-ob-windows : number of outbound address translation windows
+ - ti,syscon-unaligned-access: phandle to the syscon dt node. The 1st argument
+			       should contain the register offset within syscon
+			       and the 2nd argument should contain the bit field
+			       for setting the bit to enable unaligned
+			       access.
 
 Optional Property:
  - gpios : Should be added if a gpio line is required to drive PERST# line
-- 
2.11.0
