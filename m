Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from top.free-electrons.com ([176.31.233.9]:42623 "EHLO
	mail.free-electrons.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1030292Ab3HIGpN (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Fri, 9 Aug 2013 02:45:13 -0400
Message-ID: <52048FF6.6030904@free-electrons.com>
Date: Fri, 09 Aug 2013 08:45:10 +0200
From: Gregory CLEMENT <gregory.clement@free-electrons.com>
MIME-Version: 1.0
To: Thomas Petazzoni <thomas.petazzoni@free-electrons.com>
CC: Bjorn Helgaas <bhelgaas@google.com>, linux-pci@vger.kernel.org,
	Russell King <linux@arm.linux.org.uk>,
	Benjamin Herrenschmidt <benh@kernel.crashing.org>,
	Rob Herring <rob.herring@calxeda.com>,
	Thomas Gleixner <tglx@linutronix.de>,
	Jason Cooper <jason@lakedaemon.net>,
	Andrew Lunn <andrew@lunn.ch>,
	Ezequiel Garcia <ezequiel.garcia@free-electrons.com>,
	linux-arm-kernel@lists.infradead.org,
	Maen Suleiman <maen@marvell.com>,
	Lior Amsalem <alior@marvell.com>,
	Thierry Reding <thierry.reding@gmail.com>
Subject: Re: [PATCHv8 08/10] ARM: mvebu: the MPIC now provides MSI controller
 features
References: <1376000268-18397-1-git-send-email-thomas.petazzoni@free-electrons.com> <1376000268-18397-9-git-send-email-thomas.petazzoni@free-electrons.com>
In-Reply-To: <1376000268-18397-9-git-send-email-thomas.petazzoni@free-electrons.com>
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On 09/08/2013 00:17, Thomas Petazzoni wrote:
> Adds the 'msi-controller' property to the main interrupt controller
> Device Tree node, to indicate that it can now behave as a MSI
> controller.
> 
> Signed-off-by: Thomas Petazzoni <thomas.petazzoni@free-electrons.com>
> Reviewed-by: Thierry Reding <thierry.reding@gmail.com>
> Tested-by: Daniel Price <daniel.price@gmail.com>

Acked-by: Gregory CLEMENT <gregory.clement@free-electrons.com>

> ---
>  arch/arm/boot/dts/armada-370-xp.dtsi | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/arch/arm/boot/dts/armada-370-xp.dtsi b/arch/arm/boot/dts/armada-370-xp.dtsi
> index 90b1176..ac0bbc0 100644
> --- a/arch/arm/boot/dts/armada-370-xp.dtsi
> +++ b/arch/arm/boot/dts/armada-370-xp.dtsi
> @@ -56,6 +56,7 @@
>  				#interrupt-cells = <1>;
>  				#size-cells = <1>;
>  				interrupt-controller;
> +				msi-controller;
>  			};
>  
>  			coherency-fabric@20200 {
> 


-- 
Gregory Clement, Free Electrons
Kernel, drivers, real-time and embedded Linux
development, consulting, training and support.
http://free-electrons.com
