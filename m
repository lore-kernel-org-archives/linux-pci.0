Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from avon.wwwdotorg.org ([70.85.31.133]:36040 "EHLO
	avon.wwwdotorg.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755185AbcCPQwA (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Wed, 16 Mar 2016 12:52:00 -0400
Subject: Re: [PATCH 1/2] dt-bindings: pci: tegra: Update for per-lane PHYs
To: Thierry Reding <thierry.reding@gmail.com>,
	Bjorn Helgaas <bhelgaas@google.com>
References: <1457452094-5409-1-git-send-email-thierry.reding@gmail.com>
Cc: Rob Herring <robh+dt@kernel.org>, Pawel Moll <pawel.moll@arm.com>,
	Mark Rutland <mark.rutland@arm.com>,
	Ian Campbell <ijc+devicetree@hellion.org.uk>,
	Kumar Gala <galak@codeaurora.org>,
	Alexandre Courbot <gnurou@gmail.com>,
	linux-pci@vger.kernel.org, devicetree@vger.kernel.org,
	linux-tegra@vger.kernel.org
From: Stephen Warren <swarren@wwwdotorg.org>
Message-ID: <56E98F2E.5010307@wwwdotorg.org>
Date: Wed, 16 Mar 2016 10:51:58 -0600
MIME-Version: 1.0
In-Reply-To: <1457452094-5409-1-git-send-email-thierry.reding@gmail.com>
Content-Type: text/plain; charset=windows-1252; format=flowed
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On 03/08/2016 08:48 AM, Thierry Reding wrote:
> From: Thierry Reding <treding@nvidia.com>
>
> Changes to the pad controller device tree binding have required that
> each lane be associated with a separate PHY.

I still don't think this has anything to do with DT bindings. Rather, 
the definition of a PHY (in HW and the Linux PHY subsystem) is a single 
lane. That fact then requires drivers to support a PHY per lane rather 
than a single multi-lane PHY, and equally means the DT bindings must be 
written according to the correct definition of a PHY.

Still, I suppose the commit description is fine as is.

> Update the PCI host bridge
> device tree binding to allow each root port to define the list of PHYs
> required to drive the lanes associated with it.

> diff --git a/Documentation/devicetree/bindings/pci/nvidia,tegra20-pcie.txt b/Documentation/devicetree/bindings/pci/nvidia,tegra20-pcie.txt

> +Required properties for Tegra124 and later:
> +- phys: Must contain an phandle to a PHY for each entry in phy-names.
> +- phy-names: Must include an entry for each active lane. Note that the number
> +  of entries does not have to (though usually will) be equal to the specified
> +  number of lanes in the nvidia,num-lanes property. Entries are of the form
> +  "pcie-N": where N ranges from 0 to the value specified in nvidia,num-lanes.

When would the number of PHYs not equal the number of lanes? I thought 
the whole point of this patch was to switch to per-lane PHYs? Perhaps 
I'm just misremembering some exception, so there may be no need to 
change this.

>   Example:
>
>   SoC DTSI:
> @@ -169,6 +179,9 @@ SoC DTSI:
>   			ranges;
>
>   			nvidia,num-lanes = <2>;
> +
> +			phys = <&{/padctl@0,7009f000/pads/pcie/pcie-4}>;
> +			phy-names = "pcie-0";
>   		};

The example shows a Tegra20 PCIe controller, yet includes 
Tegra124-or-greater properties. That seems a bit odd. Should the changes 
to the example be dropped, or does "Required properties for Tegra124 and 
later" mean "Required for T124+, optional for earlier chips"?

Conceptually this change is fine by me though.
