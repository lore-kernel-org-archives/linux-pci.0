Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AB9DF511194;
	Wed, 14 Oct 2026 13:19:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791983997; cv=none; b=o5Yv8sSjAu/bVfAaSuNG9T88pLwMjI4jtQ7uXcyNDMkN3RphY+A7z2feWUNgfFvzQgHP/5K56aVJh6ghVZRUfYdg4SSmwDWtgrbhfqosQD+H+H0e828HZDQJf5mIBYz4RrvIxfjMX3/LNiHT+1draxe9ZOGReAeM9MQHO2F5Q0c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791983997; c=relaxed/simple;
	bh=pytAkIVsLbHxQ7gQzGdJRcS6lpyfY0e0Nkh3L09jJeQ=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=PntGyjUeQlmOBUu+UvCFOJuReOLbJxaeXKVT2W/OfU3ybMy4BA7130iwlvQ9lpS9KxNkI9kvXVu+/Vi7IVW6SXed1ecbwMX+n6dXAyTAfKiUECY79bLhwaKa2888gVl1DHjEkEpoTFUxndLV1jR3H5zcdwntP1bqmzvluu1FWSo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Dq2DkGy2; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Dq2DkGy2"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 076EE1F000FF;
	Wed, 14 Oct 2026 13:19:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791983996;
	bh=FEN0Cztw+BYN7XA5fORyPpV9q6g1u7RdRnzRwOfUVTM=;
	h=Date:From:To:Cc:Subject:In-Reply-To;
	b=Dq2DkGy2908a1ZLNzPOanS6vCdxfdErYhJ56neCG59Qo7E/IEvAvIURBVoYE3o4FB
	 LNic9MkoP6sv4UDKei69KFUglNeUN2kOaUC/OtyiEj5nuIeS2n/O1FyJCGDpXvkssd
	 0Xr1+/oWlXOkKbloJJu7gks239NwXpaxsR2DjlZniWextIxlNdbMypZqQEQIrJcQQz
	 AZMbPBM65ctwOgqz0GFB6HLmGk81hgBiXADnKDsoN2Q4A2y41/hOYaEnlx5JeoWYXj
	 VrkGOhW8cy0VYBFXBxcy3jZlX2hgjeEgW0I3ePuDdt18mxFB6BQ7MpdadcdykyobL3
	 1r7qKab3rBw9g==
Date: Wed, 14 Oct 2026 08:19:54 -0500
From: Bjorn Helgaas <helgaas@kernel.org>
To: Navid Ghahremani <ghahramani.navid@gmail.com>
Cc: linux-arm-kernel@lists.infradead.org, arnd@arndb.de,
	stefandoesinger@gmail.com, krzk@kernel.org,
	Lorenzo Pieralisi <lpieralisi@kernel.org>,
	Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kwilczynski@kernel.org>,
	Manivannan Sadhasivam <mani@kernel.org>,
	Rob Herring <robh@kernel.org>, Bjorn Helgaas <bhelgaas@google.com>,
	Philipp Zabel <p.zabel@pengutronix.de>,
	linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org
Subject: Re: [PATCH v2 13/24] PCI: dwc: Add ZTE ZX279128S host controller
 driver
Message-ID: <20261014131954.GA1623979@bhelgaas>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20261014072109.1759502-14-ghahramani.navid@gmail.com>

On Wed, Oct 14, 2026 at 08:20:53AM +0100, Navid Ghahremani wrote:
> Support the two Synopsys DesignWare PCIe host controllers of the
> ZTE ZX279128S SoC. The driver manages the controller clocks via CCF,
> asserts/deasserts resets via the Reset framework, and manages the
> analog SerDes and PLL via the Generic PHY framework.

Thanks for making the commit log complete.

Suggest making the subject line:

  PCI: zx: Add ...

or whatever tag you plan to use for the family of hardware this driver
will support over time.  Future changes to a driver typically don't
include "dwc" because the name of the driver itself is more useful.

I see "zx" used in the spi patch and "zte" used in the clk patch.
"zte" might be too generic; there may be future hardware that requires
a different driver.  "zx279128s" might be too specific; there will
likely be more SoCs that share this driver.  Same consideration
applies to filename, config symbol, struct and function names, etc.

> Signed-off-by: Navid Ghahremani <ghahramani.navid@gmail.com>
> ---
>  drivers/pci/controller/dwc/Kconfig          |  13 +
>  drivers/pci/controller/dwc/Makefile         |   1 +
>  drivers/pci/controller/dwc/pcie-zx279128s.c | 273 ++++++++++++++++++++
>  3 files changed, 287 insertions(+)
>  create mode 100644 drivers/pci/controller/dwc/pcie-zx279128s.c
> 
> diff --git a/drivers/pci/controller/dwc/Kconfig b/drivers/pci/controller/dwc/Kconfig
> index dcfbe7e229..3a4008be84 100644
> --- a/drivers/pci/controller/dwc/Kconfig
> +++ b/drivers/pci/controller/dwc/Kconfig
> @@ -577,4 +577,17 @@ config PCIE_ULTRARISC
>  	  By default, this symbol is enabled when ARCH_ULTRARISC is active,
>  	  requiring no further configuration on that platform.
>  
> +config PCIE_ZX279128S
> +	bool "ZTE zx279128s PCIe controller"
> +	depends on ARCH_ZTE || COMPILE_TEST
> +	depends on PCI_MSI
> +	select GENERIC_PHY
> +	select PCIE_DW_HOST
> +	select RESET_CONTROLLER
> +	help
> +	  Say Y here to enable support for the two PCIe host controllers of
> +	  the ZTE zx279128s SoC. They are based on the Synopsys DesignWare
> +	  PCIe IP. On the ZTE ZXHN H3600 they connect the MT7915 Wi-Fi chip.
> +	  The driver only supports legacy INTx interrupts.

Capitalization of "zx279128s" here (menu item, help text, comment
below) should probably match the commit log and marketing materials
for this SoC.

The config symbol should use the same tag as the subject line.
PCIE_ZX279128S might be too specific if more SoCs might share this
driver.

>  endmenu
> diff --git a/drivers/pci/controller/dwc/Makefile b/drivers/pci/controller/dwc/Makefile
> index d4f88cfc62..379198ebd6 100644
> --- a/drivers/pci/controller/dwc/Makefile
> +++ b/drivers/pci/controller/dwc/Makefile
> @@ -35,6 +35,7 @@ obj-$(CONFIG_PCIE_TEGRA194) += pcie-tegra194.o
>  obj-$(CONFIG_PCIE_UNIPHIER) += pcie-uniphier.o
>  obj-$(CONFIG_PCIE_UNIPHIER_EP) += pcie-uniphier-ep.o
>  obj-$(CONFIG_PCIE_VISCONTI_HOST) += pcie-visconti.o
> +obj-$(CONFIG_PCIE_ZX279128S) += pcie-zx279128s.o
>  obj-$(CONFIG_PCIE_RCAR_GEN4) += pcie-rcar-gen4.o
>  obj-$(CONFIG_PCIE_SPACEMIT_K1) += pcie-spacemit-k1.o
>  obj-$(CONFIG_PCIE_STM32_HOST) += pcie-stm32.o
> diff --git a/drivers/pci/controller/dwc/pcie-zx279128s.c b/drivers/pci/controller/dwc/pcie-zx279128s.c
> new file mode 100644
> index 0000000000..592a7f7c4e
> --- /dev/null
> +++ b/drivers/pci/controller/dwc/pcie-zx279128s.c
> @@ -0,0 +1,273 @@
> +// SPDX-License-Identifier: GPL-2.0-only
> +/*
> + * ZTE zx279128s PCIe host controller
