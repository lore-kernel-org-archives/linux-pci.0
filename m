Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-oi0-f68.google.com ([209.85.218.68]:34852 "EHLO
        mail-oi0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753329AbdACSFJ (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 3 Jan 2017 13:05:09 -0500
Date: Tue, 3 Jan 2017 12:05:07 -0600
From: Rob Herring <robh@kernel.org>
To: Jaehoon Chung <jh80.chung@samsung.com>
Cc: linux-pci@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-samsung-soc@vger.kernel.org,
        bhelgaas@google.com, mark.rutland@arm.com, kgene@kernel.org,
        krzk@kernel.org, kishon@ti.com, jingoohan1@gmail.com,
        vivek.gautam@codeaurora.org, pankaj.dubey@samsung.com,
        alim.akhtar@samsung.com, cpgs@samsung.com
Subject: Re: [PATCH 2/4] Documetation: samsung-phy: add the exynos-pcie-phy
 binding
Message-ID: <20170103180507.b7otjrfo4ye3yx42@rob-hp-laptop>
References: <20161228103454.26467-1-jh80.chung@samsung.com>
 <CGME20161228103455epcas5p2acc54945d70ac45b2ce2cd4f6ad4b875@epcas5p2.samsung.com>
 <20161228103454.26467-3-jh80.chung@samsung.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20161228103454.26467-3-jh80.chung@samsung.com>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Wed, Dec 28, 2016 at 07:34:52PM +0900, Jaehoon Chung wrote:
> Adds the exynos-pcie-phy binding for Exynos PCIe PHY.
> This is for using generic PHY framework.
> 
> Signed-off-by: Jaehoon Chung <jh80.chung@samsung.com>
> ---
>  .../devicetree/bindings/phy/samsung-phy.txt        | 23 ++++++++++++++++++++++
>  1 file changed, 23 insertions(+)
> 
> diff --git a/Documentation/devicetree/bindings/phy/samsung-phy.txt b/Documentation/devicetree/bindings/phy/samsung-phy.txt
> index 9872ba8..1cbc15f 100644
> --- a/Documentation/devicetree/bindings/phy/samsung-phy.txt
> +++ b/Documentation/devicetree/bindings/phy/samsung-phy.txt
> @@ -191,3 +191,26 @@ Example:
>  		usbdrdphy0 = &usb3_phy0;
>  		usbdrdphy1 = &usb3_phy1;
>  	};
> +
> +Samsung Exynos SoC series PCIe PHY controller
> +--------------------------------------------------
> +Required properties:
> +- compatible : Should be set to "samsung,exynos5440-pcie-phy"
> +- #phy-cells : Must be zero
> +- reg : a register used by phy driver.
> +
> +Required properies for child node:
> +- reg : a block register used by phy driver.

There's no need for this. Either just make the length 0x1040 or add a 
2nd address to the parent reg prop.

> +
> +Example:
> +	pcie_phy0: pcie-phy@270000 {
> +		#phy-cells = <0>;
> +		compatible = "samsung,exynos5440-pcie-phy";
> +		reg = <0x270000 0x1000>;
> +		#address-cells = <1>;
> +		#size-cells = <1>;
> +		ranges;
> +		block@271000 {
> +			reg = <0x271000 0x40>;
> +		};
> +	};
> -- 
> 2.10.2
> 
