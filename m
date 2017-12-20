Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-pl0-f68.google.com ([209.85.160.68]:37295 "EHLO
        mail-pl0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1756116AbdLTUzO (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 20 Dec 2017 15:55:14 -0500
Date: Wed, 20 Dec 2017 14:55:11 -0600
From: Rob Herring <robh@kernel.org>
To: Kishon Vijay Abraham I <kishon@ti.com>
Cc: Mark Rutland <mark.rutland@arm.com>, devicetree@vger.kernel.org,
        linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
        nsekhar@ti.com
Subject: Re: [PATCH 1/2] dt-bindings: phy: ti-pipe3: Add dt binding to use
 USB3 PHY for PCIe
Message-ID: <20171220205511.lqi2ijggfqeel6tu@rob-hp-laptop>
References: <20171219094540.18432-1-kishon@ti.com>
 <20171219094540.18432-2-kishon@ti.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20171219094540.18432-2-kishon@ti.com>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Tue, Dec 19, 2017 at 03:15:39PM +0530, Kishon Vijay Abraham I wrote:
> DRA72 uses USB3 PHY for the 2nd lane of PCIE. Add dt bindings property
> to indicate if the USB3 PHY should be used for 2nd lane of PCIe.
> 
> Signed-off-by: Kishon Vijay Abraham I <kishon@ti.com>
> ---
>  Documentation/devicetree/bindings/phy/ti-phy.txt | 2 ++
>  1 file changed, 2 insertions(+)
> 
> diff --git a/Documentation/devicetree/bindings/phy/ti-phy.txt b/Documentation/devicetree/bindings/phy/ti-phy.txt
> index cd13e6157088..907a046e794b 100644
> --- a/Documentation/devicetree/bindings/phy/ti-phy.txt
> +++ b/Documentation/devicetree/bindings/phy/ti-phy.txt
> @@ -93,6 +93,8 @@ Optional properties:
>     register that contains the SATA_PLL_SOFT_RESET bit. Only valid for sata_phy.
>   - syscon-pcs : phandle/offset pair. Phandle to the system control module and the
>     register offset to write the PCS delay value.
> + - "ti,configure-as-pcie" : property to indicate if the PHY should be
> +   configured as PCIE PHY.

This is not that uncommon as PCIe, 10Gb eth, USB3, SATA are all very 
electrically similar and the same phy can drive all of them AIUI. The DT 
already contains the necessary information too because you have a phys 
property creating a link to PCI host. The problem is either the client 
side would need to set the mode or you'd have to search all "phys" 
properties to find the link. There's already a DT function to iterate 
thru all named properties.

Rob
