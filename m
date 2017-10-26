Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from regular1.263xmail.com ([211.150.99.134]:43907 "EHLO
        regular1.263xmail.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932334AbdJZN3J (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 26 Oct 2017 09:29:09 -0400
From: Jeffy Chen <jeffy.chen@rock-chips.com>
To: linux-kernel@vger.kernel.org, bhelgaas@google.com
Cc: linux-pm@vger.kernel.org, tony@atomide.com,
        shawn.lin@rock-chips.com, briannorris@chromium.org,
        rjw@rjwysocki.net, dianders@chromium.org,
        Jeffy Chen <jeffy.chen@rock-chips.com>,
        devicetree@vger.kernel.org, linux-pci@vger.kernel.org,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>
Subject: [RFC PATCH v8 1/7] dt-bindings: PCI: Add definition of PCIe WAKE# irq and PCI irq
Date: Thu, 26 Oct 2017 21:28:34 +0800
Message-Id: <20171026132840.20946-2-jeffy.chen@rock-chips.com>
In-Reply-To: <20171026132840.20946-1-jeffy.chen@rock-chips.com>
References: <20171026132840.20946-1-jeffy.chen@rock-chips.com>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Add optional interrupts for PCIe WAKE# pin and PCI interrupt pin.

Signed-off-by: Jeffy Chen <jeffy.chen@rock-chips.com>
---

Changes in v8:
Add optional "pci", and rewrite commit message.

Changes in v7: None
Changes in v6: None
Changes in v5:
Move to pci.txt

Changes in v3: None
Changes in v2: None

 Documentation/devicetree/bindings/pci/pci.txt | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/Documentation/devicetree/bindings/pci/pci.txt b/Documentation/devicetree/bindings/pci/pci.txt
index c77981c5dd18..faed405811cd 100644
--- a/Documentation/devicetree/bindings/pci/pci.txt
+++ b/Documentation/devicetree/bindings/pci/pci.txt
@@ -24,3 +24,6 @@ driver implementation may support the following properties:
    unsupported link speed, for instance, trying to do training for
    unsupported link speed, etc.  Must be '4' for gen4, '3' for gen3, '2'
    for gen2, and '1' for gen1. Any other values are invalid.
+- interrupts: Interrupt specifier for each name in interrupt-names.
+- interrupt-names: May contains "wakeup" for PCIe WAKE# interrupt and "pci"
+  for PCI interrupt.
-- 
2.11.0
