Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from regular1.263xmail.com ([211.150.99.140]:44045 "EHLO
        regular1.263xmail.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751708AbdLZChn (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 25 Dec 2017 21:37:43 -0500
From: Jeffy Chen <jeffy.chen@rock-chips.com>
To: linux-kernel@vger.kernel.org, bhelgaas@google.com
Cc: linux-pm@vger.kernel.org, tony@atomide.com,
        shawn.lin@rock-chips.com, briannorris@chromium.org,
        rjw@rjwysocki.net, dianders@chromium.org,
        Jeffy Chen <jeffy.chen@rock-chips.com>,
        devicetree@vger.kernel.org, linux-pci@vger.kernel.org,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>
Subject: [RFC PATCH v12 1/5] dt-bindings: PCI: Add definition of PCIe WAKE# irq and PCI irq
Date: Tue, 26 Dec 2017 10:36:42 +0800
Message-Id: <20171226023646.17722-2-jeffy.chen@rock-chips.com>
In-Reply-To: <20171226023646.17722-1-jeffy.chen@rock-chips.com>
References: <20171226023646.17722-1-jeffy.chen@rock-chips.com>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

We are going to handle PCIe WAKE# pin for PCI devices in the pci core,
so add definitions of the optional PCIe WAKE# pin for PCI devices.

Also add an definition of the optional PCI interrupt pin for PCI
devices to distinguish it from the PCIe WAKE# pin.

Signed-off-by: Jeffy Chen <jeffy.chen@rock-chips.com>
---

Changes in v13: None
Changes in v12:
Only add irq definitions for PCI devices and rewrite the commit message.

Changes in v11: None
Changes in v10: None
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

 Documentation/devicetree/bindings/pci/pci.txt | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/Documentation/devicetree/bindings/pci/pci.txt b/Documentation/devicetree/bindings/pci/pci.txt
index c77981c5dd18..3045ac452f27 100644
--- a/Documentation/devicetree/bindings/pci/pci.txt
+++ b/Documentation/devicetree/bindings/pci/pci.txt
@@ -24,3 +24,13 @@ driver implementation may support the following properties:
    unsupported link speed, for instance, trying to do training for
    unsupported link speed, etc.  Must be '4' for gen4, '3' for gen3, '2'
    for gen2, and '1' for gen1. Any other values are invalid.
+
+PCI devices may support the following properties:
+
+- interrupts: Interrupt specifier for each name in interrupt-names.
+- interrupt-names:
+    May contain "wakeup" for PCIe WAKE# interrupt and "pci" for PCI interrupt.
+    The PCI devices may optionally include an 'interrupts' property that
+    represents the legacy PCI interrupt. And when we try to specify the PCIe
+    WAKE# pin, a corresponding 'interrupt-names' property is required to
+    distinguish them.
-- 
2.11.0
