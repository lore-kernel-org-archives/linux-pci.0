Return-Path: <linux-kernel-owner@vger.kernel.org>
From: Jeffy Chen <jeffy.chen@rock-chips.com>
To: linux-kernel@vger.kernel.org, bhelgaas@google.com
Cc: shawn.lin@rock-chips.com, briannorris@chromium.org,
        dianders@chromium.org, Jeffy Chen <jeffy.chen@rock-chips.com>,
        devicetree@vger.kernel.org, linux-pci@vger.kernel.org,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>
Subject: [PATCH v6 2/3] dt-bindings: PCI: Add definition of pcie wake irq
Date: Sat, 14 Oct 2017 03:50:57 +0800
Message-Id: <20171013195059.23865-3-jeffy.chen@rock-chips.com>
In-Reply-To: <20171013195059.23865-1-jeffy.chen@rock-chips.com>
References: <20171013195059.23865-1-jeffy.chen@rock-chips.com>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Add an optional interrupt for PCIE_WAKE pin.

Signed-off-by: Jeffy Chen <jeffy.chen@rock-chips.com>
---

Changes in v6: None
Changes in v5:
Move to pci.txt

Changes in v3: None
Changes in v2: None

 Documentation/devicetree/bindings/pci/pci.txt | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/Documentation/devicetree/bindings/pci/pci.txt b/Documentation/devicetree/bindings/pci/pci.txt
index c77981c5dd18..5ae3a9e0134d 100644
--- a/Documentation/devicetree/bindings/pci/pci.txt
+++ b/Documentation/devicetree/bindings/pci/pci.txt
@@ -24,3 +24,5 @@ driver implementation may support the following properties:
    unsupported link speed, for instance, trying to do training for
    unsupported link speed, etc.  Must be '4' for gen4, '3' for gen3, '2'
    for gen2, and '1' for gen1. Any other values are invalid.
+- interrupts: Interrupt specifier for each name in interrupt-names.
+- interrupt-names: May contains "wakeup" for PCI WAKE# interrupt.
-- 
2.11.0
