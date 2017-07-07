Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-pf0-f182.google.com ([209.85.192.182]:34865 "EHLO
        mail-pf0-f182.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753105AbdGGAnc (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 6 Jul 2017 20:43:32 -0400
Received: by mail-pf0-f182.google.com with SMTP id c73so8726868pfk.2
        for <linux-pci@vger.kernel.org>; Thu, 06 Jul 2017 17:43:32 -0700 (PDT)
From: Brian Norris <briannorris@chromium.org>
To: Bjorn Helgaas <bhelgaas@google.com>
Cc: <linux-kernel@vger.kernel.org>, linux-pci@vger.kernel.org,
        <devicetree@vger.kernel.org>, Rob Herring <robh+dt@kernel.org>,
        Brian Norris <briannorris@chromium.org>
Subject: [PATCH] Documentation/devicetree: fix dead links to PCI/OF specs
Date: Thu,  6 Jul 2017 17:43:23 -0700
Message-Id: <20170707004323.22550-1-briannorris@chromium.org>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

www.firmware.org doesn't resolve for me. I found these equivalent URLs
by taking the redirects from the previous (openfirmware.org) URLs, as
seen before commit f517256a6867 ("Documentation/devicetree: Update PCI
Device Tree bindings") updated them.

Signed-off-by: Brian Norris <briannorris@chromium.org>
---
This is my best attempt at a resolution. I'm not sure what firmware.org is or
if its owner is even legit. It does seem like openfirmware.info is a proper
successor to openfirmware.org, and it's registered to a coreboot dev.

 Documentation/devicetree/bindings/pci/pci.txt | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/Documentation/devicetree/bindings/pci/pci.txt b/Documentation/devicetree/bindings/pci/pci.txt
index 50f9e2ca5b13..13a73b423233 100644
--- a/Documentation/devicetree/bindings/pci/pci.txt
+++ b/Documentation/devicetree/bindings/pci/pci.txt
@@ -1,12 +1,12 @@
 PCI bus bridges have standardized Device Tree bindings:
 
 PCI Bus Binding to: IEEE Std 1275-1994
-http://www.firmware.org/1275/bindings/pci/pci2_1.pdf
+https://www.openfirmware.info/data/docs/bus.pci.pdf
 
 And for the interrupt mapping part:
 
 Open Firmware Recommended Practice: Interrupt Mapping
-http://www.firmware.org/1275/practice/imap/imap0_9d.pdf
+https://www.openfirmware.info/data/docs/rec.intmap.d09.pdf
 
 Additionally to the properties specified in the above standards a host bridge
 driver implementation may support the following properties:
-- 
2.13.2.725.g09c95d1e9-goog
