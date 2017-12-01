Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from lelnx194.ext.ti.com ([198.47.27.80]:48441 "EHLO
        lelnx194.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752658AbdLAGN2 (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 1 Dec 2017 01:13:28 -0500
From: Vignesh R <vigneshr@ti.com>
To: Bjorn Helgaas <bhelgaas@google.com>,
        Rob Herring <robh+dt@kernel.org>,
        Tony Lindgren <tony@atomide.com>,
        Chris Welch <Chris.Welch@viavisolutions.com>
CC: Kishon Vijay Abraham I <kishon@ti.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        <linux-omap@vger.kernel.org>, <linux-pci@vger.kernel.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>, Vignesh R <vigneshr@ti.com>
Subject: [PATCH 2/4] dt-bindings: PCI: dra7xx: Add bindings for unaligned access in host mode
Date: Fri, 1 Dec 2017 11:43:09 +0530
Message-ID: <20171201061311.16691-3-vigneshr@ti.com>
In-Reply-To: <20171201061311.16691-1-vigneshr@ti.com>
References: <20171201061311.16691-1-vigneshr@ti.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Update device tree binding documentation of TI's dra7xx PCI controller
for enabling unaligned mem access as applicable not just in EP mode but
in host mode as well.

Signed-off-by: Vignesh R <vigneshr@ti.com>
---
 Documentation/devicetree/bindings/pci/ti-pci.txt | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/Documentation/devicetree/bindings/pci/ti-pci.txt b/Documentation/devicetree/bindings/pci/ti-pci.txt
index 7f7af3044016..452fe48c4fdd 100644
--- a/Documentation/devicetree/bindings/pci/ti-pci.txt
+++ b/Documentation/devicetree/bindings/pci/ti-pci.txt
@@ -26,6 +26,11 @@ HOST MODE
    ranges,
    interrupt-map-mask,
    interrupt-map : as specified in ../designware-pcie.txt
+ - ti,syscon-unaligned-access: phandle to the syscon DT node. The 1st argument
+			       should contain the register offset within syscon
+			       and the 2nd argument should contain the bit field
+			       for setting the bit to enable unaligned
+			       access.
 
 DEVICE MODE
 ===========
-- 
2.15.0
