Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from fllnx210.ext.ti.com ([198.47.19.17]:50073 "EHLO
        fllnx210.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754528AbdDEIy2 (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 5 Apr 2017 04:54:28 -0400
From: Kishon Vijay Abraham I <kishon@ti.com>
To: Bjorn Helgaas <bhelgaas@google.com>,
        Joao Pinto <Joao.Pinto@synopsys.com>,
        <linux-pci@vger.kernel.org>, <linux-doc@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-omap@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>
CC: <hch@infradead.org>, <nsekhar@ti.com>, <kishon@ti.com>
Subject: [PATCH v6 15/23] dt-bindings: PCI: dra7xx: Add DT bindings to enable unaligned access
Date: Wed, 5 Apr 2017 14:22:35 +0530
Message-ID: <20170405085243.18123-16-kishon@ti.com>
In-Reply-To: <20170405085243.18123-1-kishon@ti.com>
References: <20170405085243.18123-1-kishon@ti.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Update device tree binding documentation of TI's dra7xx PCI controller to
include property for enabling unaligned mem access.

Signed-off-by: Kishon Vijay Abraham I <kishon@ti.com>
Acked-by: Rob Herring <robh@kernel.org>
Signed-off-by: Bjorn Helgaas <bhelgaas@google.com>
---
 Documentation/devicetree/bindings/pci/ti-pci.txt | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/Documentation/devicetree/bindings/pci/ti-pci.txt b/Documentation/devicetree/bindings/pci/ti-pci.txt
index 60c3cccefabc..6a07c96227e0 100644
--- a/Documentation/devicetree/bindings/pci/ti-pci.txt
+++ b/Documentation/devicetree/bindings/pci/ti-pci.txt
@@ -39,6 +39,11 @@ DEVICE MODE
  - interrupts : one interrupt entries must be specified for main interrupt.
  - num-ib-windows : number of inbound address translation windows
  - num-ob-windows : number of outbound address translation windows
+ - ti,syscon-unaligned-access: phandle to the syscon DT node. The 1st argument
+			       should contain the register offset within syscon
+			       and the 2nd argument should contain the bit field
+			       for setting the bit to enable unaligned
+			       access.
 
 Optional Property:
  - gpios : Should be added if a gpio line is required to drive PERST# line
-- 
2.11.0
