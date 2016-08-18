Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.136]:40832 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1754454AbcHSBBO (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Thu, 18 Aug 2016 21:01:14 -0400
Date: Thu, 18 Aug 2016 16:24:44 -0500
From: Bjorn Helgaas <helgaas@kernel.org>
To: Shawn Lin <shawn.lin@rock-chips.com>
Cc: Bjorn Helgaas <bhelgaas@google.com>,
        Marc Zyngier <marc.zyngier@arm.com>, linux-pci@vger.kernel.org,
        Arnd Bergmann <arnd@arndb.de>, linux-kernel@vger.kernel.org,
        linux-rockchip@lists.infradead.org,
        Heiko Stuebner <heiko@sntech.de>,
        Doug Anderson <dianders@chromium.org>,
        Wenrui Li <wenrui.li@rock-chips.com>,
        Rob Herring <robh+dt@kernel.org>, devicetree@vger.kernel.org,
        Brian Norris <briannorris@chromium.org>
Subject: Re: [PATCH v9 2/2] PCI: Rockchip: Add Rockchip PCIe controller
 support
Message-ID: <20160818212444.GQ27353@localhost>
References: <1470297128-6213-1-git-send-email-shawn.lin@rock-chips.com>
 <1470297128-6213-2-git-send-email-shawn.lin@rock-chips.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1470297128-6213-2-git-send-email-shawn.lin@rock-chips.com>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Hi Shawn,

On Thu, Aug 04, 2016 at 03:52:08PM +0800, Shawn Lin wrote:
> This patch adds Rockchip PCIe controller support found
> on RK3399 Soc platform.

> --- a/drivers/pci/host/Kconfig
> +++ b/drivers/pci/host/Kconfig
> @@ -264,4 +264,15 @@ config PCIE_ARTPEC6
>  	  Say Y here to enable PCIe controller support on Axis ARTPEC-6
>  	  SoCs.  This PCIe controller uses the DesignWare core.
>  
> +config PCIE_ROCKCHIP
> +	bool "Rockchip PCIe controller"
> +	depends on ARM64 && ARCH_ROCKCHIP

I don't see any actual ARM64 dependencies in the code (which is a very
good thing!).  Can we remove the "depends on ARM64" part?

> +	depends on OF
> +	depends on PCI_MSI_IRQ_DOMAIN
> +	select MFD_SYSCON
> +	help
> +	  Say Y here if you want internal PCI support on Rockchip SoC.
> +	  There is 1 internal PCIe port available to support GEN2 with
> +	  4 slots.
