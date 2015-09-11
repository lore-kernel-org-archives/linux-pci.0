Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-lb0-f179.google.com ([209.85.217.179]:34698 "EHLO
	mail-lb0-f179.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932153AbbIKXGR (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Fri, 11 Sep 2015 19:06:17 -0400
Received: by lbbmp1 with SMTP id mp1so46885813lbb.1
        for <linux-pci@vger.kernel.org>; Fri, 11 Sep 2015 16:06:16 -0700 (PDT)
From: Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>
To: robh+dt@kernel.org, pawel.moll@arm.com, mark.rutland@arm.com,
	ijc+devicetree@hellion.org.uk, galak@codeaurora.org,
	horms@verge.net.au, bhelgaas@google.com,
	devicetree@vger.kernel.org, linux-pci@vger.kernel.org,
	linux-sh@vger.kernel.org
Subject: [PATCH] pci-rcar-gen2: add R8A7794 support
Date: Sat, 12 Sep 2015 02:06:09 +0300
Message-ID: <2525770.ZsLzbliFPH@wasted.cogentembedded.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Add Renesas R8A7794 SoC support to the Renesas R-Car gen2 PCI driver.

Signed-off-by: Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>

---
The patch is against the 'next' branch of Bjorn Helgaas' 'pci.git' repo.

 Documentation/devicetree/bindings/pci/pci-rcar-gen2.txt |    3 ++-
 drivers/pci/host/pci-rcar-gen2.c                        |    1 +
 2 files changed, 3 insertions(+), 1 deletion(-)

Index: pci/Documentation/devicetree/bindings/pci/pci-rcar-gen2.txt
===================================================================
--- pci.orig/Documentation/devicetree/bindings/pci/pci-rcar-gen2.txt
+++ pci/Documentation/devicetree/bindings/pci/pci-rcar-gen2.txt
@@ -7,7 +7,8 @@ OHCI and EHCI controllers.
 
 Required properties:
 - compatible: "renesas,pci-r8a7790" for the R8A7790 SoC;
-	      "renesas,pci-r8a7791" for the R8A7791 SoC.
+	      "renesas,pci-r8a7791" for the R8A7791 SoC;
+	      "renesas,pci-r8a7794" for the R8A7794 SoC.
 - reg:	A list of physical regions to access the device: the first is
 	the operational registers for the OHCI/EHCI controllers and the
 	second is for the bridge configuration and control registers.
Index: pci/drivers/pci/host/pci-rcar-gen2.c
===================================================================
--- pci.orig/drivers/pci/host/pci-rcar-gen2.c
+++ pci/drivers/pci/host/pci-rcar-gen2.c
@@ -362,6 +362,7 @@ static int rcar_pci_probe(struct platfor
 static struct of_device_id rcar_pci_of_match[] = {
 	{ .compatible = "renesas,pci-r8a7790", },
 	{ .compatible = "renesas,pci-r8a7791", },
+	{ .compatible = "renesas,pci-r8a7794", },
 	{ },
 };
 

