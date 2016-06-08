Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-by2on0099.outbound.protection.outlook.com ([207.46.100.99]:48652
	"EHLO na01-by2-obe.outbound.protection.outlook.com"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S932967AbcFHNmL (ORCPT <rfc822;linux-pci@vger.kernel.org>);
	Wed, 8 Jun 2016 09:42:11 -0400
From: Fabio Estevam <fabio.estevam@nxp.com>
To: <bhelgaas@google.com>
CC: <l.stach@pengutronix.de>, <hongxing.zhu@nxp.com>,
	<linux-pci@vger.kernel.org>, Fabio Estevam <fabio.estevam@nxp.com>
Subject: [PATCH] PCI: imx6: Add missing required clocks
Date: Wed, 8 Jun 2016 10:27:41 -0300
Message-ID: <1465392461-3469-1-git-send-email-fabio.estevam@nxp.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

The PCI hardware on imx6 requires the following clocks:
"pcie", "pcie_bus" and "pcie_phy", so add the missing clocks
in the clock-names property.

Signed-off-by: Fabio Estevam <fabio.estevam@nxp.com>
---
 Documentation/devicetree/bindings/pci/fsl,imx6q-pcie.txt | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/Documentation/devicetree/bindings/pci/fsl,imx6q-pcie.txt b/Documentation/devicetree/bindings/pci/fsl,imx6q-pcie.txt
index 83aeb1f..94ab92c 100644
--- a/Documentation/devicetree/bindings/pci/fsl,imx6q-pcie.txt
+++ b/Documentation/devicetree/bindings/pci/fsl,imx6q-pcie.txt
@@ -10,8 +10,8 @@ Required properties:
   entry for each entry in the interrupt-names property.
 - interrupt-names: Must include the following entries:
 	- "msi": The interrupt that is asserted when an MSI is received
-- clock-names: Must include the following additional entries:
-	- "pcie_phy"
+- clock-names: Must include the following entries:
+	- "pcie", "pcie_bus" and "pcie_phy".
 
 Optional properties:
 - fsl,tx-deemph-gen1: Gen1 De-emphasis value. Default: 0
-- 
1.9.1

