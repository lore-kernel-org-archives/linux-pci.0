Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-yb0-f194.google.com ([209.85.213.194]:38883 "EHLO
        mail-yb0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S933928AbeEWSwc (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 23 May 2018 14:52:32 -0400
Date: Wed, 23 May 2018 13:52:29 -0500
From: Rob Herring <robh@kernel.org>
To: Alan Douglas <adouglas@cadence.com>
Cc: bhelgaas@google.com, kishon@ti.com, lorenzo.pieralisi@arm.com,
        linux-pci@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.com, cyrille.pitchen@free-electrons.com
Subject: Re: [RESEND PATCH 3/4] dt-bindings: PCI: cadence: Add DT bindings
 for optional PHYs
Message-ID: <20180523185229.GA7457@rob-hp-laptop>
References: <1526995952-22031-1-git-send-email-adouglas@cadence.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1526995952-22031-1-git-send-email-adouglas@cadence.com>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Tue, May 22, 2018 at 02:32:32PM +0100, Alan Douglas wrote:
> Update DT documentation to include optional PHYs for cadence PCIe
> host and endpoint controllers.
> 
> Signed-off-by: Alan Douglas <adouglas@cadence.com>
> ---
>  Documentation/devicetree/bindings/pci/cdns,cdns-pcie-ep.txt   | 4 ++++
>  Documentation/devicetree/bindings/pci/cdns,cdns-pcie-host.txt | 2 ++
>  2 files changed, 6 insertions(+)
> 
> diff --git a/Documentation/devicetree/bindings/pci/cdns,cdns-pcie-ep.txt b/Documentation/devicetree/bindings/pci/cdns,cdns-pcie-ep.txt
> index 9a305237..e40c635 100644
> --- a/Documentation/devicetree/bindings/pci/cdns,cdns-pcie-ep.txt
> +++ b/Documentation/devicetree/bindings/pci/cdns,cdns-pcie-ep.txt
> @@ -9,6 +9,8 @@ Required properties:
>  
>  Optional properties:
>  - max-functions: Maximum number of functions that can be configured (default 1).
> +- phys: From PHY bindings: List of Generic PHY phandles.
> +- phy-names:  List of names to identify the PHY.

You need to define how many. I'd assume one, but I guess your example is 
1 per lane.

>  
>  Example:
>  
> @@ -19,4 +21,6 @@ pcie@fc000000 {
>  	reg-names = "reg", "mem";
>  	cdns,max-outbound-regions = <16>;
>  	max-functions = /bits/ 8 <8>;
> +	phys = <&ep_phy0 &ep_phy1>;
> +	phy-names = "pcie-lane0","pcie-lane1";
>  };
> diff --git a/Documentation/devicetree/bindings/pci/cdns,cdns-pcie-host.txt b/Documentation/devicetree/bindings/pci/cdns,cdns-pcie-host.txt
> index 20a33f3..c0ca4c1 100644
> --- a/Documentation/devicetree/bindings/pci/cdns,cdns-pcie-host.txt
> +++ b/Documentation/devicetree/bindings/pci/cdns,cdns-pcie-host.txt
> @@ -24,6 +24,8 @@ Optional properties:
>    translations (default 32)
>  - vendor-id: The PCI vendor ID (16 bits, default is design dependent)
>  - device-id: The PCI device ID (16 bits, default is design dependent)
> +- phys: From PHY bindings: List of Generic PHY phandles.
> +- phy-names:  List of names to identify the PHY.
>  
>  Example:
>  
> -- 
> 2.2.2
> 
> --
> To unsubscribe from this list: send the line "unsubscribe devicetree" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
