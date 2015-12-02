Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from kirsty.vergenet.net ([202.4.237.240]:41748 "EHLO
	kirsty.vergenet.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757069AbbLBWwD (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Wed, 2 Dec 2015 17:52:03 -0500
From: Simon Horman <horms+renesas@verge.net.au>
To: Bjorn Helgaas <bhelgaas@google.com>
Cc: Magnus Damm <magnus.damm@gmail.com>, linux-pci@vger.kernel.org,
	linux-sh@vger.kernel.org, devicetree@vger.kernel.org,
	Simon Horman <horms+renesas@verge.net.au>
Subject: [PATCH v2 2/4] PCI: rcar-gen2: add device tree support for r8a7793
Date: Thu,  3 Dec 2015 07:51:38 +0900
Message-Id: <1449096700-23304-3-git-send-email-horms+renesas@verge.net.au>
In-Reply-To: <1449096700-23304-1-git-send-email-horms+renesas@verge.net.au>
References: <1449096700-23304-1-git-send-email-horms+renesas@verge.net.au>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Simply document new compatibility string.
As a previous patch adds a generic R-Car Gen2 compatibility string
there appears to be no need for a driver updates.

Signed-off-by: Simon Horman <horms+renesas@verge.net.au>

---
* The r8a7792 is omitted from this change as the hardware in question
  does not appear to be present on that SoC.

v2
* No change
---
 Documentation/devicetree/bindings/pci/pci-rcar-gen2.txt | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/pci/pci-rcar-gen2.txt b/Documentation/devicetree/bindings/pci/pci-rcar-gen2.txt
index 089a99dcdf10..9c50e0c9d6da 100644
--- a/Documentation/devicetree/bindings/pci/pci-rcar-gen2.txt
+++ b/Documentation/devicetree/bindings/pci/pci-rcar-gen2.txt
@@ -8,6 +8,7 @@ OHCI and EHCI controllers.
 Required properties:
 - compatible: "renesas,pci-r8a7790" for the R8A7790 SoC;
 	      "renesas,pci-r8a7791" for the R8A7791 SoC;
+	      "renesas,pci-r8a7793" for the R8A7793 SoC;
 	      "renesas,pci-r8a7794" for the R8A7794 SoC;
 	      "renesas,pci-rcar-gen2" for a generic R-Car Gen2 compatible device.
 
-- 
2.1.4

