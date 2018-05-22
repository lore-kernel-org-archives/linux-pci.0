Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from foss.arm.com ([217.140.101.70]:34962 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1750733AbeEVLCo (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Tue, 22 May 2018 07:02:44 -0400
Date: Tue, 22 May 2018 12:02:36 +0100
From: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
To: Alan Douglas <adouglas@cadence.com>
Cc: "bhelgaas@google.com" <bhelgaas@google.com>,
        "kishon@ti.com" <kishon@ti.com>,
        "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
        "cyrille.pitchen@free-electrons.com"
        <cyrille.pitchen@free-electrons.com>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "nsekhar@ti.com" <nsekhar@ti.com>
Subject: Re: [PATCH 3/4] dt-bindings: PCI: cadence: Add DT bindings for
 optional PHYs
Message-ID: <20180522110236.GA17739@e107981-ln.cambridge.arm.com>
References: <SN6PR07MB451213F202165D9733877828D8940@SN6PR07MB4512.namprd07.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <SN6PR07MB451213F202165D9733877828D8940@SN6PR07MB4512.namprd07.prod.outlook.com>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Tue, May 22, 2018 at 09:08:01AM +0000, Alan Douglas wrote:
> From: Alan Douglas <adouglas@cadence.com>
> 
> Update DT documentation to include optional PHYs for cadence PCIe
> host and endpoint controllers.
> 
> Signed-off-by: Alan Douglas <adouglas@cadence.com>
> ---
>  Documentation/devicetree/bindings/pci/cdns,cdns-pcie-ep.txt   | 4 ++++
>  Documentation/devicetree/bindings/pci/cdns,cdns-pcie-host.txt | 2 ++
>  2 files changed, 6 insertions(+)

It looks like v2 of patches [3-4] did not make it to the linux-pci list.
I do not know why you sent two versions and what happened, I suggest you
avoid adding linux-pci@vger.kernel.org in both to: and cc: for no reason
to start with.

Anyway, I can't apply patches that aren't on the PCI mailing list.

Can you please generate the series with:

git format-patch

and send it with

git send-email

to make sure headers, etc. are in order ? You can resend a v2 by
sticking a "RESEND" at the beginning of (every) patch subject:

[RESEND PATCH v2...]

Please send patches to yourself first to make sure everything is OK,
email threading inclusive.

Thanks,
Lorenzo

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
