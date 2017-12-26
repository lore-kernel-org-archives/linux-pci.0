Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-qk0-f195.google.com ([209.85.220.195]:40497 "EHLO
        mail-qk0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750890AbdLZUuM (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 26 Dec 2017 15:50:12 -0500
Received: by mail-qk0-f195.google.com with SMTP id q14so31805151qke.7
        for <linux-pci@vger.kernel.org>; Tue, 26 Dec 2017 12:50:12 -0800 (PST)
From: Fabio Estevam <festevam@gmail.com>
To: bhelgaas@google.com
Cc: l.stach@pengutronix.de, linux-pci@vger.kernel.org,
        lorenzo.pieralisi@arm.com, robh+dt@kernel.org,
        Fabio Estevam <fabio.estevam@nxp.com>
Subject: [PATCH] dt-bindings: imx6q-pcie: Add required property for i.MX6SX
Date: Tue, 26 Dec 2017 18:49:55 -0200
Message-Id: <1514321395-13025-1-git-send-email-festevam@gmail.com>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

From: Fabio Estevam <fabio.estevam@nxp.com>

i.MX6SX needs a PCI 'power-domains' entry, so add it to its required
properties section.

Signed-off-by: Fabio Estevam <fabio.estevam@nxp.com>
---
The i.MX6SX PCI power domain patches have been accepted by the ARM
maintainer:

https://git.kernel.org/pub/scm/linux/kernel/git/shawnguo/linux.git/commit/?h=imx/dt&id=1f1b7ec6714e08c9ab4243146ff8b572a25d1837

https://git.kernel.org/pub/scm/linux/kernel/git/shawnguo/linux.git/commit/?h=imx/drivers&id=cfabb7921ccbede2968e5049d433ba3d0e0950af

and they will land into 4.16.

It would be nice if this dt-bindings update could also reach 4.16.

 Documentation/devicetree/bindings/pci/fsl,imx6q-pcie.txt | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/pci/fsl,imx6q-pcie.txt b/Documentation/devicetree/bindings/pci/fsl,imx6q-pcie.txt
index 149d8f7..cb33421 100644
--- a/Documentation/devicetree/bindings/pci/fsl,imx6q-pcie.txt
+++ b/Documentation/devicetree/bindings/pci/fsl,imx6q-pcie.txt
@@ -41,6 +41,7 @@ Optional properties:
 Additional required properties for imx6sx-pcie:
 - clock names: Must include the following additional entries:
 	- "pcie_inbound_axi"
+- power-domains: Must be set to a phandle pointing to the PCIE_PHY power domain
 
 Additional required properties for imx7d-pcie:
 - power-domains: Must be set to a phandle pointing to PCIE_PHY power domain
-- 
2.7.4
