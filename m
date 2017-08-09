Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-lf0-f43.google.com ([209.85.215.43]:33405 "EHLO
        mail-lf0-f43.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751704AbdHIOPA (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 9 Aug 2017 10:15:00 -0400
Received: by mail-lf0-f43.google.com with SMTP id d17so28685279lfe.0
        for <linux-pci@vger.kernel.org>; Wed, 09 Aug 2017 07:15:00 -0700 (PDT)
From: Linus Walleij <linus.walleij@linaro.org>
To: Bjorn Helgaas <bhelgaas@google.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Arnd Bergmann <arnd@arndb.de>
Cc: linux-pci@vger.kernel.org, Linus Walleij <linus.walleij@linaro.org>
Subject: [PATCH 1/2 v2] PCI: v3: Update the device tree bindings
Date: Wed,  9 Aug 2017 16:14:54 +0200
Message-Id: <20170809141455.22220-1-linus.walleij@linaro.org>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

The bindings for the V3 Semiconductor PCI bridge are a tad bit outdated
and predates the more formal format we have adopted for the bindings.
Update them a bit so it is easier to read, and add the Integrator AP-
specific compatible so we can detect that we are running on that specific
platform.

Acked-by: Rob Herring <robh@kernel.org>
Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
---
ChangeLog v1->v2:
- Added Rob's ACK.

Bjorn: please merge this when you feel confident with it.
---
 .../devicetree/bindings/pci/v3-v360epc-pci.txt        | 19 ++++++++++---------
 1 file changed, 10 insertions(+), 9 deletions(-)

diff --git a/Documentation/devicetree/bindings/pci/v3-v360epc-pci.txt b/Documentation/devicetree/bindings/pci/v3-v360epc-pci.txt
index 30b364e504ba..bcc5fe2a74cb 100644
--- a/Documentation/devicetree/bindings/pci/v3-v360epc-pci.txt
+++ b/Documentation/devicetree/bindings/pci/v3-v360epc-pci.txt
@@ -2,14 +2,15 @@ V3 Semiconductor V360 EPC PCI bridge
 
 This bridge is found in the ARM Integrator/AP (Application Platform)
 
-Integrator-specific notes:
-
-- syscon: should contain a link to the syscon device node (since
-  on the Integrator, some registers in the syscon are required to
-  operate the V3).
-
-V360 EPC specific notes:
-
-- reg: should contain the base address of the V3 adapter.
+Required properties:
+- compatible: should be one of:
+  "v3,v360epc-pci"
+  "arm,integrator-ap-pci", "v3,v360epc-pci"
+- reg: should contain the base address of the V3 host bridge.
 - interrupts: should contain a reference to the V3 error interrupt
   as routed on the system.
+
+Integrator-specific required properties:
+- syscon: should contain a link to the syscon device node, since
+  on the Integrator, some registers in the syscon are required to
+  operate the V3 host bridge.
-- 
2.9.4
