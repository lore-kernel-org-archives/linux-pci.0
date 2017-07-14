Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-pg0-f46.google.com ([74.125.83.46]:34954 "EHLO
        mail-pg0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751066AbdGNUrQ (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 14 Jul 2017 16:47:16 -0400
Received: by mail-pg0-f46.google.com with SMTP id j186so50638287pge.2
        for <linux-pci@vger.kernel.org>; Fri, 14 Jul 2017 13:47:16 -0700 (PDT)
Date: Fri, 14 Jul 2017 13:47:13 -0700
From: Brian Norris <briannorris@chromium.org>
To: Shawn Lin <shawn.lin@rock-chips.com>
Cc: Bjorn Helgaas <bhelgaas@google.com>, Rob Herring <robh@kernel.org>,
        Kishon Vijay Abraham I <kishon@ti.com>,
        Heiko Stuebner <heiko@sntech.de>, linux-pci@vger.kernel.org,
        linux-rockchip@lists.infradead.org,
        Jeffy Chen <jeffy.chen@rock-chips.com>,
        devicetree@vger.kernel.org
Subject: Re: [RFC PATCH 6/6] dt-bindings: PCI: rockchip: convert to use
 per-lane PHY model
Message-ID: <20170714204711.GA13174@google.com>
References: <1500004101-240296-1-git-send-email-shawn.lin@rock-chips.com>
 <1500004366-241633-1-git-send-email-shawn.lin@rock-chips.com>
 <1500004366-241633-5-git-send-email-shawn.lin@rock-chips.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1500004366-241633-5-git-send-email-shawn.lin@rock-chips.com>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Hi Shawn,

On Fri, Jul 14, 2017 at 11:52:46AM +0800, Shawn Lin wrote:
> Deprecate legacy PHY model and encourage to use per-lane PHY
> model.
> 
> Signed-off-by: Shawn Lin <shawn.lin@rock-chips.com>
> 
> ---
> 
>  .../devicetree/bindings/pci/rockchip-pcie.txt      | 25 ++++++++++++++++++++--
>  1 file changed, 23 insertions(+), 2 deletions(-)
> 
> diff --git a/Documentation/devicetree/bindings/pci/rockchip-pcie.txt b/Documentation/devicetree/bindings/pci/rockchip-pcie.txt
> index 1453a73..78d4469 100644
> --- a/Documentation/devicetree/bindings/pci/rockchip-pcie.txt
> +++ b/Documentation/devicetree/bindings/pci/rockchip-pcie.txt
> @@ -19,8 +19,6 @@ Required properties:
>  	- "pm"
>  - msi-map: Maps a Requester ID to an MSI controller and associated
>  	msi-specifier data. See ./pci-msi.txt
> -- phys: From PHY bindings: Phandle for the Generic PHY for PCIe.
> -- phy-names:  MUST be "pcie-phy".
>  - interrupts: Three interrupt entries must be specified.
>  - interrupt-names: Must include the following names
>  	- "sys"
> @@ -42,6 +40,18 @@ Required properties:
>  	interrupt source. The value must be 1.
>  - interrupt-map-mask and interrupt-map: standard PCI properties
>  
> +Required properties for legacy PHY model (deprecated):
> +- phys: From PHY bindings: Phandle for the Generic PHY for PCIe.
> +- phy-names:  MUST be "pcie-phy".
> +
> +Required properties for per-lane PHY model:
> +- phys: Must contain an phandle to a PHY for each entry in phy-names.
> +- phy-names: Must include an entry for each active lane. Note that the number
> +  of entries does not have to (though usually will) be equal to the specified
> +  number of lanes in the num-lanes property. Entries are of the form
> +  "pcie-phy-N": where N ranges from 0 to the value specified of (num-lanes - 1).
> +  (see example below)

So (for the non-legacy case) are you requiring listing all 4 PHY lanes,
or not? If you aren't, then you need to make the PHY driver handle the
case were lanes {X..3} were never "powered on", but we want them idled.
IIUC, your current (broken) implementation is trying (incorrectly) to
only idle a lane once it has been powered on and then back off. But that
won't ever happen if we only request (for example) PHY lane 0.

It's also misleading that it's possible to specify only some subset of
the PHY lanes, but the driver might still try to use them all.

Brian

> +
>  Optional Property:
>  - aspm-no-l0s: RC won't support ASPM L0s. This property is needed if
>  	using 24MHz OSC for RC's PHY.
> @@ -95,6 +105,7 @@ pcie0: pcie@f8000000 {
>  		 <&cru SRST_PCIE_PM>, <&cru SRST_P_PCIE>, <&cru SRST_A_PCIE>;
>  	reset-names = "core", "mgmt", "mgmt-sticky", "pipe",
>  		      "pm", "pclk", "aclk";
> +	/* deprecated legacy PHY model */
>  	phys = <&pcie_phy>;
>  	phy-names = "pcie-phy";
>  	pinctrl-names = "default";
> @@ -111,3 +122,13 @@ pcie0: pcie@f8000000 {
>  		#interrupt-cells = <1>;
>  	};
>  };
> +
> +pcie0: pcie@f8000000 {
> +	...
> +
> +	/* preferred per-lane PHY model */
> +	phys = <&pcie_phy 0>, <&pcie_phy 1>, <&pcie_phy 2>, <&pcie_phy 3>;
> +	phy-names = "pcie-phy-0", "pcie-phy-1", "pcie-phy-2", "pcie-phy-3";
> +
> +	...
> +};
> -- 
> 1.9.1
> 
> 
