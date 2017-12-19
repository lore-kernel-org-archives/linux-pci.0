Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from lelnx194.ext.ti.com ([198.47.27.80]:18110 "EHLO
        lelnx194.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1030236AbdLSJp5 (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 19 Dec 2017 04:45:57 -0500
From: Kishon Vijay Abraham I <kishon@ti.com>
To: Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>, <kishon@ti.com>
CC: <devicetree@vger.kernel.org>, <linux-pci@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <nsekhar@ti.com>
Subject: [PATCH 1/2] dt-bindings: phy: ti-pipe3: Add dt binding to use USB3 PHY for PCIe
Date: Tue, 19 Dec 2017 15:15:39 +0530
Message-ID: <20171219094540.18432-2-kishon@ti.com>
In-Reply-To: <20171219094540.18432-1-kishon@ti.com>
References: <20171219094540.18432-1-kishon@ti.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

DRA72 uses USB3 PHY for the 2nd lane of PCIE. Add dt bindings property
to indicate if the USB3 PHY should be used for 2nd lane of PCIe.

Signed-off-by: Kishon Vijay Abraham I <kishon@ti.com>
---
 Documentation/devicetree/bindings/phy/ti-phy.txt | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/Documentation/devicetree/bindings/phy/ti-phy.txt b/Documentation/devicetree/bindings/phy/ti-phy.txt
index cd13e6157088..907a046e794b 100644
--- a/Documentation/devicetree/bindings/phy/ti-phy.txt
+++ b/Documentation/devicetree/bindings/phy/ti-phy.txt
@@ -93,6 +93,8 @@ Optional properties:
    register that contains the SATA_PLL_SOFT_RESET bit. Only valid for sata_phy.
  - syscon-pcs : phandle/offset pair. Phandle to the system control module and the
    register offset to write the PCS delay value.
+ - "ti,configure-as-pcie" : property to indicate if the PHY should be
+   configured as PCIE PHY.
 
 Deprecated properties:
  - ctrl-module : phandle of the control module used by PHY driver to power on
-- 
2.11.0
