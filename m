Return-Path: <linux-kernel-owner@vger.kernel.org>
Date: Sat, 19 Dec 2015 21:39:01 -0600
From: Rob Herring <robh@kernel.org>
To: Kishon Vijay Abraham I <kishon@ti.com>
Cc: devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-omap@vger.kernel.org, pawel.moll@arm.com,
	mark.rutland@arm.com, ijc+devicetree@hellion.org.uk,
	galak@codeaurora.org, rogerq@ti.com, nsekhar@ti.com,
	linux-pci@vger.kernel.org, linux-usb@vger.kernel.org,
	tony@atomide.com, t-kristo@ti.com
Subject: Re: [PATCH v3 9/9] phy: omap-usb2: use *syscon* framework API to
 power on/off the PHY
Message-ID: <20151220033901.GI9883@rob-hp-laptop>
References: <1450170968-11282-1-git-send-email-kishon@ti.com>
 <1450170968-11282-10-git-send-email-kishon@ti.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1450170968-11282-10-git-send-email-kishon@ti.com>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Tue, Dec 15, 2015 at 02:46:08PM +0530, Kishon Vijay Abraham I wrote:
> Deprecate using phy-omap-control driver to power on/off the PHY,
> and use *syscon* framework to do the same. This handles
> powering on/off the PHY for the USB2 PHYs used in various TI SoCs.
> 
> Signed-off-by: Kishon Vijay Abraham I <kishon@ti.com>
> ---
>  Documentation/devicetree/bindings/phy/ti-phy.txt |    8 +-
>  drivers/phy/phy-omap-usb2.c                      |   94 ++++++++++++++++++----
>  include/linux/phy/omap_usb.h                     |   23 ++++++
>  3 files changed, 107 insertions(+), 18 deletions(-)
> 
> diff --git a/Documentation/devicetree/bindings/phy/ti-phy.txt b/Documentation/devicetree/bindings/phy/ti-phy.txt
> index 49e5b0c..a3b3945 100644
> --- a/Documentation/devicetree/bindings/phy/ti-phy.txt
> +++ b/Documentation/devicetree/bindings/phy/ti-phy.txt
> @@ -31,6 +31,8 @@ OMAP USB2 PHY
>  
>  Required properties:
>   - compatible: Should be "ti,omap-usb2"
> +	       Should be "ti,dra7x-usb2-phy2" for the 2nd instance of USB2 PHY
> +	       in DRA7x

The 2nd instance is different somehow?

Rob
