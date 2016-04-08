Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.136]:55016 "EHLO mail.kernel.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753260AbcDHTLq (ORCPT <rfc822;linux-pci@vger.kernel.org>);
	Fri, 8 Apr 2016 15:11:46 -0400
Date: Fri, 8 Apr 2016 14:11:42 -0500
From: Bjorn Helgaas <helgaas@kernel.org>
To: Thierry Reding <thierry.reding@gmail.com>
Cc: Bjorn Helgaas <bhelgaas@google.com>,
	Stephen Warren <swarren@wwwdotorg.org>,
	Alexandre Courbot <gnurou@gmail.com>,
	linux-tegra@vger.kernel.org, linux-pci@vger.kernel.org,
	devicetree@vger.kernel.org
Subject: Re: [PATCH v4 1/2] dt-bindings: pci: tegra: Update for per-lane PHYs
Message-ID: <20160408191142.GD15034@localhost>
References: <1460131994-24493-1-git-send-email-thierry.reding@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1460131994-24493-1-git-send-email-thierry.reding@gmail.com>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Hi Thierry,

I have a couple more questions, probably just because I'm
DT-illiterate.

On Fri, Apr 08, 2016 at 06:13:13PM +0200, Thierry Reding wrote:
> From: Thierry Reding <treding@nvidia.com>
> 
> Changes to the pad controller device tree binding have required that
> each lane be associated with a separate PHY. Update the PCI host bridge
> device tree binding to allow each root port to define the list of PHYs
> required to drive the lanes associated with it.
> 
> Acked-by: Rob Herring <robh@kernel.org>
> Signed-off-by: Thierry Reding <treding@nvidia.com>
> ---
> Changes in v4:
> - add additional lanes subnode when dereferencing PHYs from the XUSB pad
>   controller to reflect changes in its binding
> 
>  .../devicetree/bindings/pci/nvidia,tegra20-pcie.txt    | 18 +++++++++++++++++-
>  1 file changed, 17 insertions(+), 1 deletion(-)
> 
> diff --git a/Documentation/devicetree/bindings/pci/nvidia,tegra20-pcie.txt b/Documentation/devicetree/bindings/pci/nvidia,tegra20-pcie.txt
> index 75321ae23c08..f5364084b494 100644
> --- a/Documentation/devicetree/bindings/pci/nvidia,tegra20-pcie.txt
> +++ b/Documentation/devicetree/bindings/pci/nvidia,tegra20-pcie.txt
> @@ -60,11 +60,14 @@ Required properties:
>    - afi
>    - pcie_x
>  
> -Required properties on Tegra124 and later:
> +Required properties on Tegra124 and later (deprecated):
>  - phys: Must contain an entry for each entry in phy-names.
>  - phy-names: Must include the following entries:
>    - pcie
>  
> +These properties are deprecated in favour of per-lane PHYs define in each of
> +the root ports (see below).
> +
>  Power supplies for Tegra20:
>  - avdd-pex-supply: Power supply for analog PCIe logic. Must supply 1.05 V.
>  - vdd-pex-supply: Power supply for digital PCIe I/O. Must supply 1.05 V.
> @@ -122,6 +125,13 @@ Required properties:
>    - Root port 0 uses 4 lanes, root port 1 is unused.
>    - Both root ports use 2 lanes.
>  
> +Required properties for Tegra124 and later:

I had a little trouble disambiguating this from the "Required
properties on Tegra124 and later (deprecated)" line above.  It might
help if they said:

  Required PCIe controller properties on Tegra124 and later (deprecated):
  Required PCIe Root Port properties for Tegra124 and later:

I'm not sure how to interpret the "deprecated" part.  Assume I'm
writing a DTS.  What am I supposed to include?

  - "phys" and "phy-names" under the PCIe controller *and*
    "phys" and "phy-names" under the Root Port?

  - "phys" and "phy-names" under the PCIe controller only if I don't
    supply "phys" and "phy-names" under the Root Port?

My guess is that a board with more than one PHY for PCIe should omit
"phys" and "phy-names" under the PCIe controller and include them
under each Root Port.  And a board with only one PHY could conceivably
supply these properties either under the controller or the Root Port
or both.

> +- phys: Must contain an phandle to a PHY for each entry in phy-names.
> +- phy-names: Must include an entry for each active lane. Note that the number
> +  of entries does not have to (though usually will) be equal to the specified
> +  number of lanes in the nvidia,num-lanes property. Entries are of the form
> +  "pcie-N": where N ranges from 0 to the value specified in nvidia,num-lanes.
> +
>  Example:
>  
>  SoC DTSI:
> @@ -169,6 +179,9 @@ SoC DTSI:
>  			ranges;
>  
>  			nvidia,num-lanes = <2>;
> +
> +			phys = <&{/padctl@0,7009f000/pads/pcie/lanes/pcie-4}>;
> +			phy-names = "pcie-0";

I'm also a little confused here because it looks like this root port
supports two lanes, but there's only one entry in phy-names.  I
thought you needed one entry for each lane.

>  		};
>  
>  		pci@2,0 {
> @@ -183,6 +196,9 @@ SoC DTSI:
>  			ranges;
>  
>  			nvidia,num-lanes = <2>;
> +
> +			phys = <&{/padctl@0,7009f000/pads/pcie/lanes/pcie-2}>;
> +			phy-names = "pcie-0";
>  		};
>  	};
>  
> -- 
> 2.8.0
> 
> --
> To unsubscribe from this list: send the line "unsubscribe linux-pci" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
