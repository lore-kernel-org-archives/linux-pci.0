Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-wm0-f53.google.com ([74.125.82.53]:33429 "EHLO
        mail-wm0-f53.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1757046AbdEORXU (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 15 May 2017 13:23:20 -0400
Received: by mail-wm0-f53.google.com with SMTP id f135so27790342wmd.0
        for <linux-pci@vger.kernel.org>; Mon, 15 May 2017 10:23:20 -0700 (PDT)
From: Linus Walleij <linus.walleij@linaro.org>
To: Kishon Vijay Abraham I <kishon@ti.com>,
        Bjorn Helgaas <bhelgaas@google.com>
Cc: linux-pci@vger.kernel.org,
        Linus Walleij <linus.walleij@linaro.org>,
        devicetree@vger.kernel.org
Subject: [PATCH 1/2] pci: ftpci100: add clock bindings
Date: Mon, 15 May 2017 19:23:12 +0200
Message-Id: <20170515172312.1722-1-linus.walleij@linaro.org>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

The Faraday FTPCI100 controller has two clock ports, PCLK and PCICLK.
We add bindings for these two clocks so we can assign them in the device
tree.

Cc: devicetree@vger.kernel.org
Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
---
 Documentation/devicetree/bindings/pci/faraday,ftpci100.txt | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/Documentation/devicetree/bindings/pci/faraday,ftpci100.txt b/Documentation/devicetree/bindings/pci/faraday,ftpci100.txt
index 35d4a979bb7b..89a84f8aa621 100644
--- a/Documentation/devicetree/bindings/pci/faraday,ftpci100.txt
+++ b/Documentation/devicetree/bindings/pci/faraday,ftpci100.txt
@@ -30,6 +30,13 @@ Mandatory properties:
   128MB, 256MB, 512MB, 1GB or 2GB in size. The memory should be marked as
   pre-fetchable.
 
+Optional properties:
+- clocks: when present, this should contain the peripheral clock (PCLK) and the
+  PCI clock (PCICLK). If these are not present, they are assumed to be
+  hard-wired enabled and always on. The PCI clock will be 33 or 66 MHz.
+- clock-names: when present, this should contain "PCLK" for the peripheral
+  clock and "PCICLK" for the PCI-side clock.
+
 Mandatory subnodes:
 - For "faraday,ftpci100" a node representing the interrupt-controller inside the
   host bridge is mandatory. It has the following mandatory properties:
-- 
2.9.3
