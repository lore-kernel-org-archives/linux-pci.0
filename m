Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from fllv0016.ext.ti.com ([198.47.19.142]:52908 "EHLO
        fllv0016.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727052AbeIQXea (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 17 Sep 2018 19:34:30 -0400
From: Vignesh R <vigneshr@ti.com>
To: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
CC: Kishon Vijay Abraham I <kishon@ti.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Rob Herring <robh+dt@kernel.org>, <linux-omap@vger.kernel.org>,
        <linux-pci@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, Vignesh R <vigneshr@ti.com>
Subject: [PATCH v4 1/2] dt-bindings: PCI: dra7xx: Add bindings for unaligned access in host mode
Date: Mon, 17 Sep 2018 23:36:34 +0530
Message-ID: <20180917180635.26996-2-vigneshr@ti.com>
In-Reply-To: <20180917180635.26996-1-vigneshr@ti.com>
References: <20180917180635.26996-1-vigneshr@ti.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Update device tree binding documentation of TI's dra7xx PCI controller
for enabling unaligned mem access as applicable not just in EP mode but
in host mode as well.

Signed-off-by: Vignesh R <vigneshr@ti.com>
Reviewed-by: Rob Herring <robh@kernel.org>
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
2.19.0
