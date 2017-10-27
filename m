Return-Path: <linux-kernel-owner@vger.kernel.org>
From: Jeffy Chen <jeffy.chen@rock-chips.com>
To: linux-kernel@vger.kernel.org, bhelgaas@google.com
Cc: linux-pm@vger.kernel.org, tony@atomide.com,
        shawn.lin@rock-chips.com, briannorris@chromium.org,
        rjw@rjwysocki.net, dianders@chromium.org,
        Jeffy Chen <jeffy.chen@rock-chips.com>,
        devicetree@vger.kernel.org, linux-pci@vger.kernel.org,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>
Subject: [RFC PATCH v9 1/7] dt-bindings: PCI: Add definition of PCIe WAKE# irq and PCI irq
Date: Fri, 27 Oct 2017 15:17:33 +0800
Message-Id: <20171027071739.21927-2-jeffy.chen@rock-chips.com>
In-Reply-To: <20171027071739.21927-1-jeffy.chen@rock-chips.com>
References: <20171027071739.21927-1-jeffy.chen@rock-chips.com>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

We are going to handle PCIe WAKE# pin for PCI bus bridges and PCI
devices in the pci core, so add definitions of the optional PCIe
WAKE# pin for PCI bus bridges and PCI devices.

Also add an definition of the optional PCI interrupt pin for PCI
devices to distinguish it from the PCIe WAKE# pin.

Signed-off-by: Jeffy Chen <jeffy.chen@rock-chips.com>
---

Changes in v9:
Add section for PCI devices and rewrite the commit message.

Changes in v8:
Add optional "pci", and rewrite commit message.

Changes in v7: None
Changes in v6: None
Changes in v5:
Move to pci.txt

Changes in v3: None
Changes in v2: None

 Documentation/devicetree/bindings/pci/pci.txt | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/Documentation/devicetree/bindings/pci/pci.txt b/Documentation/devicetree/bindings/pci/pci.txt
index c77981c5dd18..d4406d4e15ad 100644
--- a/Documentation/devicetree/bindings/pci/pci.txt
+++ b/Documentation/devicetree/bindings/pci/pci.txt
@@ -24,3 +24,11 @@ driver implementation may support the following properties:
    unsupported link speed, for instance, trying to do training for
    unsupported link speed, etc.  Must be '4' for gen4, '3' for gen3, '2'
    for gen2, and '1' for gen1. Any other values are invalid.
+- interrupts: Interrupt specifier for each name in interrupt-names.
+- interrupt-names: May contains "wakeup" for PCIe WAKE# interrupt.
+
+PCI devices have standardized Device Tree bindings:
+
+- interrupts: Interrupt specifier for each name in interrupt-names.
+- interrupt-names: May contains "wakeup" for PCIe WAKE# interrupt and "pci" for
+  PCI interrupt.
-- 
2.11.0
