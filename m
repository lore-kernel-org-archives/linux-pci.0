Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-lf0-f66.google.com ([209.85.215.66]:39938 "EHLO
        mail-lf0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751178AbeECTpB (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 3 May 2018 15:45:01 -0400
Received: by mail-lf0-f66.google.com with SMTP id j16-v6so27697963lfb.7
        for <linux-pci@vger.kernel.org>; Thu, 03 May 2018 12:45:00 -0700 (PDT)
Subject: [PATCH v3 5/5] DT: pci: rcar-pci: document R8A77980 bindings
From: Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>
To: horms@verge.net.au, bhelgaas@google.com, linux-pci@vger.kernel.org,
        linux-renesas-soc@vger.kernel.org,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Rob Herring <robh+dt@kernel.org>, devicetree@vger.kernel.org
References: <b98130a7-b128-9fc3-aee1-1a5a2590b320@cogentembedded.com>
Cc: Mark Rutland <mark.rutland@arm.com>
Message-ID: <eb928983-475a-c238-5a44-505c07472b93@cogentembedded.com>
Date: Thu, 3 May 2018 22:44:58 +0300
MIME-Version: 1.0
In-Reply-To: <b98130a7-b128-9fc3-aee1-1a5a2590b320@cogentembedded.com>
Content-Type: text/plain; charset=utf-8
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Document the R-Car V3H (R8A77980) SoC in the R-Car PCIe bindings.

Signed-off-by: Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>

---
Changes in version 2:
- new patch.

 Documentation/devicetree/bindings/pci/rcar-pci.txt |    1 +
 1 file changed, 1 insertion(+)

Index: pci/Documentation/devicetree/bindings/pci/rcar-pci.txt
===================================================================
--- pci.orig/Documentation/devicetree/bindings/pci/rcar-pci.txt
+++ pci/Documentation/devicetree/bindings/pci/rcar-pci.txt
@@ -8,6 +8,7 @@ compatible: "renesas,pcie-r8a7743" for t
 	    "renesas,pcie-r8a7793" for the R8A7793 SoC;
 	    "renesas,pcie-r8a7795" for the R8A7795 SoC;
 	    "renesas,pcie-r8a7796" for the R8A7796 SoC;
+	    "renesas,pcie-r8a77980" for the R8A77980 SoC;
 	    "renesas,pcie-rcar-gen2" for a generic R-Car Gen2 or
 				     RZ/G1 compatible device.
 	    "renesas,pcie-rcar-gen3" for a generic R-Car Gen3 compatible device.
