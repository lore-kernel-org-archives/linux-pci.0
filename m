Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.136]:40329 "EHLO mail.kernel.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753196AbcBEUVk (ORCPT <rfc822;linux-pci@vger.kernel.org>);
	Fri, 5 Feb 2016 15:21:40 -0500
Date: Fri, 5 Feb 2016 14:21:35 -0600
From: Bjorn Helgaas <helgaas@kernel.org>
To: Simon Horman <horms+renesas@verge.net.au>
Cc: Bjorn Helgaas <bhelgaas@google.com>,
	Magnus Damm <magnus.damm@gmail.com>, linux-pci@vger.kernel.org,
	linux-renesas-soc@vger.kernel.org, devicetree@vger.kernel.org
Subject: Re: [PATCH v3 0/4] PCI: rcar, rcar-gen2: More Gen2 compatibility
 strings
Message-ID: <20160205202135.GA9594@localhost>
References: <1453093785-21067-1-git-send-email-horms+renesas@verge.net.au>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1453093785-21067-1-git-send-email-horms+renesas@verge.net.au>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Hi Simon,

On Mon, Jan 18, 2016 at 02:09:41PM +0900, Simon Horman wrote:
> this short series adds fallback gen2 and SoC-specific r8a7793 compatibility
> strings to the rcar PCI and rcar-gen2 PCIE drivers. The intention is to
> provide a complete set of compatibility strings for known Gen2 SoCs.
> 
> Bjorn, the intention of the revised changelogs for the r8a7793 is to
> address your concerns regarding providing an explanation of why there are
> no driver changes. Please consider taking this series through your tree.
> 
> Key Changes between v2 and v3:
> * Enhance changelog to describe why documenting the r8a7793 is necessary
>   and sufficient
> * Added acks.
> 
> Key Changes between v1 and v2:
> * Include "rcar-" in generic bindings
> 
> Simon Horman (4):
>   PCI: rcar-gen2: add gen2 fallback compatibility string
>   PCI: rcar-gen2: add device tree support for r8a7793
>   PCI: rcar: add gen2 fallback compatibility string
>   PCI: rcar: add device tree support for r8a7793
> 
>  Documentation/devicetree/bindings/pci/pci-rcar-gen2.txt | 12 ++++++++++--
>  Documentation/devicetree/bindings/pci/rcar-pci.txt      | 14 +++++++++++---
>  drivers/pci/host/pci-rcar-gen2.c                        |  1 +
>  drivers/pci/host/pcie-rcar.c                            |  1 +
>  4 files changed, 23 insertions(+), 5 deletions(-)

Whew, it took a long time to pound that through my thick skull :)

I think patches 1 and 3 are already in v4.5-rc1, and I applied patches 2
and 4 to my for-linus branch as below.  Please double-check and make sure
for-linus has everything you want.  I'll ask Linus to pull that before
v4.5.

Bjorn


commit a176cd304a8a07d6d9191126fd9bece4f67358c3
Author: Simon Horman <horms+renesas@verge.net.au>
Date:   Fri Feb 5 14:10:04 2016 -0600

    PCI: rcar: Add gen2 device tree support for r8a7793
    
    Add "renesas,pci-r8a7793" as a compatibility string for
    "renesas,pci-rcar-gen2".
    
    This doesn't change the driver, so it does nothing by itself.  But it
    does mean that checkpatch won't complain about a future patch that adds
    "renesas,pci-r8a7793" to a DT, which helps ensure that shipped DTs use
    documented compatibility strings.
    
    [bhelgaas: changelog]
    Signed-off-by: Simon Horman <horms+renesas@verge.net.au>
    Signed-off-by: Bjorn Helgaas <bhelgaas@google.com>
    Acked-by: Rob Herring <robh@kernel.org>

diff --git a/Documentation/devicetree/bindings/pci/pci-rcar-gen2.txt b/Documentation/devicetree/bindings/pci/pci-rcar-gen2.txt
index 4e8b90e..07a7509 100644
--- a/Documentation/devicetree/bindings/pci/pci-rcar-gen2.txt
+++ b/Documentation/devicetree/bindings/pci/pci-rcar-gen2.txt
@@ -8,6 +8,7 @@ OHCI and EHCI controllers.
 Required properties:
 - compatible: "renesas,pci-r8a7790" for the R8A7790 SoC;
 	      "renesas,pci-r8a7791" for the R8A7791 SoC;
+	      "renesas,pci-r8a7793" for the R8A7793 SoC;
 	      "renesas,pci-r8a7794" for the R8A7794 SoC;
 	      "renesas,pci-rcar-gen2" for a generic R-Car Gen2 compatible device
 

commit 0cf1337e0b83c16de4e7e98dad3a6afce6043fea
Author: Simon Horman <horms+renesas@verge.net.au>
Date:   Fri Feb 5 14:10:13 2016 -0600

    PCI: rcar: Add device tree support for r8a7793
    
    Add "renesas,pcie-r8a7793" as a compatibility string for
    "renesas,pcie-rcar-gen2".
    
    This doesn't change the driver, so it does nothing by itself.  But it
    does mean that checkpatch won't complain about a future patch that adds
    "renesas,pci-r8a7793" to a DT, which helps ensure that shipped DTs use
    documented compatibility strings.
    
    [bhelgaas: changelog]
    Signed-off-by: Simon Horman <horms+renesas@verge.net.au>
    Signed-off-by: Bjorn Helgaas <bhelgaas@google.com>
    Acked-by: Rob Herring <robh@kernel.org>

diff --git a/Documentation/devicetree/bindings/pci/rcar-pci.txt b/Documentation/devicetree/bindings/pci/rcar-pci.txt
index 558fe52..6cf9969 100644
--- a/Documentation/devicetree/bindings/pci/rcar-pci.txt
+++ b/Documentation/devicetree/bindings/pci/rcar-pci.txt
@@ -4,6 +4,7 @@ Required properties:
 compatible: "renesas,pcie-r8a7779" for the R8A7779 SoC;
 	    "renesas,pcie-r8a7790" for the R8A7790 SoC;
 	    "renesas,pcie-r8a7791" for the R8A7791 SoC;
+	    "renesas,pcie-r8a7793" for the R8A7793 SoC;
 	    "renesas,pcie-r8a7795" for the R8A7795 SoC;
 	    "renesas,pcie-rcar-gen2" for a generic R-Car Gen2 compatible device.
 
