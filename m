Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from kirsty.vergenet.net ([202.4.237.240]:42978 "EHLO
	kirsty.vergenet.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755339AbbLAHZG (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Tue, 1 Dec 2015 02:25:06 -0500
From: Simon Horman <horms+renesas@verge.net.au>
To: Bjorn Helgaas <bhelgaas@google.com>
Cc: Magnus Damm <magnus.damm@gmail.com>, linux-pci@vger.kernel.org,
	linux-sh@vger.kernel.org, devicetree@vger.kernel.org,
	Simon Horman <horms+renesas@verge.net.au>
Subject: [PATCH 2/4] PCI: rcar-gen2: Add device tree support for r8a7793
Date: Tue,  1 Dec 2015 16:24:30 +0900
Message-Id: <1448954672-27236-3-git-send-email-horms+renesas@verge.net.au>
In-Reply-To: <1448954672-27236-1-git-send-email-horms+renesas@verge.net.au>
References: <1448954672-27236-1-git-send-email-horms+renesas@verge.net.au>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Simply document new compat strings.
There appears to be no need for a driver updates.

Signed-off-by: Simon Horman <horms+renesas@verge.net.au>
---
 Documentation/devicetree/bindings/pci/pci-rcar-gen2.txt | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/pci/pci-rcar-gen2.txt b/Documentation/devicetree/bindings/pci/pci-rcar-gen2.txt
index b19be08a8113..7c231b3e5872 100644
--- a/Documentation/devicetree/bindings/pci/pci-rcar-gen2.txt
+++ b/Documentation/devicetree/bindings/pci/pci-rcar-gen2.txt
@@ -8,6 +8,7 @@ OHCI and EHCI controllers.
 Required properties:
 - compatible: "renesas,pci-r8a7790" for the R8A7790 SoC;
 	      "renesas,pci-r8a7791" for the R8A7791 SoC;
+	      "renesas,pci-r8a7793" for the R8A7793 SoC;
 	      "renesas,pci-r8a7794" for the R8A7794 SoC;
 	      "renesas,pci-gen2" for a generic R-Car Gen2 compatible device.
 
-- 
2.1.4

