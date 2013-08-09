Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from top.free-electrons.com ([176.31.233.9]:42639 "EHLO
	mail.free-electrons.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1030434Ab3HIGpw (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Fri, 9 Aug 2013 02:45:52 -0400
Message-ID: <5204901C.5000708@free-electrons.com>
Date: Fri, 09 Aug 2013 08:45:48 +0200
From: Gregory CLEMENT <gregory.clement@free-electrons.com>
MIME-Version: 1.0
To: Thomas Petazzoni <thomas.petazzoni@free-electrons.com>
CC: Bjorn Helgaas <bhelgaas@google.com>, linux-pci@vger.kernel.org,
	Russell King <linux@arm.linux.org.uk>,
	Benjamin Herrenschmidt <benh@kernel.crashing.org>,
	Rob Herring <rob.herring@calxeda.com>,
	Thomas Gleixner <tglx@linutronix.de>,
	Jason Cooper <jason@lakedaemon.net>,
	Andrew Lunn <andrew@lunn.ch>, Lior Amsalem <alior@marvell.com>,
	Maen Suleiman <maen@marvell.com>,
	Thierry Reding <thierry.reding@gmail.com>,
	linux-arm-kernel@lists.infradead.org,
	Ezequiel Garcia <ezequiel.garcia@free-electrons.com>
Subject: Re: [PATCHv8 10/10] ARM: mvebu: link PCIe controllers to the MSI
 controller
References: <1376000268-18397-1-git-send-email-thomas.petazzoni@free-electrons.com> <1376000268-18397-11-git-send-email-thomas.petazzoni@free-electrons.com>
In-Reply-To: <1376000268-18397-11-git-send-email-thomas.petazzoni@free-electrons.com>
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On 09/08/2013 00:17, Thomas Petazzoni wrote:
> This commit adjusts the Armada 370 and Armada XP PCIe controllers
> Device Tree informations to reference their MSI controller. In the
> case of this platform, the MSI controller is implemented by the MPIC.
> 
> Signed-off-by: Thomas Petazzoni <thomas.petazzoni@free-electrons.com>
> Tested-by: Daniel Price <daniel.price@gmail.com>
Acked-by: Gregory CLEMENT <gregory.clement@free-electrons.com>

> ---
>  arch/arm/boot/dts/armada-370.dtsi        | 1 +
>  arch/arm/boot/dts/armada-xp-mv78230.dtsi | 1 +
>  arch/arm/boot/dts/armada-xp-mv78260.dtsi | 1 +
>  arch/arm/boot/dts/armada-xp-mv78460.dtsi | 1 +
>  4 files changed, 4 insertions(+)
> 
> diff --git a/arch/arm/boot/dts/armada-370.dtsi b/arch/arm/boot/dts/armada-370.dtsi
> index fa3dfc6..a60018d 100644
> --- a/arch/arm/boot/dts/armada-370.dtsi
> +++ b/arch/arm/boot/dts/armada-370.dtsi
> @@ -178,6 +178,7 @@
>  				#address-cells = <3>;
>  				#size-cells = <2>;
>  
> +				msi-parent = <&mpic>;
>  				bus-range = <0x00 0xff>;
>  
>  				ranges = <0x82000000 0 0x40000 0x40000 0 0x00002000   /* Port 0.0 registers */
> diff --git a/arch/arm/boot/dts/armada-xp-mv78230.dtsi b/arch/arm/boot/dts/armada-xp-mv78230.dtsi
> index f8eaa38..4a9a305 100644
> --- a/arch/arm/boot/dts/armada-xp-mv78230.dtsi
> +++ b/arch/arm/boot/dts/armada-xp-mv78230.dtsi
> @@ -91,6 +91,7 @@
>  #address-cells = <3>;
>  #size-cells = <2>;
>  
> +				msi-parent = <&mpic>;
>  				bus-range = <0x00 0xff>;
>  
>  				ranges = <0x82000000 0 0x40000 0x40000 0 0x00002000   /* Port 0.0 registers */
> diff --git a/arch/arm/boot/dts/armada-xp-mv78260.dtsi b/arch/arm/boot/dts/armada-xp-mv78260.dtsi
> index 2d9335d..dd23e96 100644
> --- a/arch/arm/boot/dts/armada-xp-mv78260.dtsi
> +++ b/arch/arm/boot/dts/armada-xp-mv78260.dtsi
> @@ -111,6 +111,7 @@
>  				#address-cells = <3>;
>  				#size-cells = <2>;
>  
> +				msi-parent = <&mpic>;
>  				bus-range = <0x00 0xff>;
>  
>  				ranges = <0x82000000 0 0x40000 0x40000 0 0x00002000   /* Port 0.0 registers */
> diff --git a/arch/arm/boot/dts/armada-xp-mv78460.dtsi b/arch/arm/boot/dts/armada-xp-mv78460.dtsi
> index c7b1f4d..77db2bc 100644
> --- a/arch/arm/boot/dts/armada-xp-mv78460.dtsi
> +++ b/arch/arm/boot/dts/armada-xp-mv78460.dtsi
> @@ -127,6 +127,7 @@
>  				#address-cells = <3>;
>  				#size-cells = <2>;
>  
> +				msi-parent = <&mpic>;
>  				bus-range = <0x00 0xff>;
>  
>  				ranges = <0x82000000 0 0x40000 0x40000 0 0x00002000   /* Port 0.0 registers */
> 


-- 
Gregory Clement, Free Electrons
Kernel, drivers, real-time and embedded Linux
development, consulting, training and support.
http://free-electrons.com
