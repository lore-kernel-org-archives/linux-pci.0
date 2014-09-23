Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-bn1bon0110.outbound.protection.outlook.com ([157.56.111.110]:14752
	"EHLO na01-bn1-obe.outbound.protection.outlook.com"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S932123AbaIWVZU (ORCPT <rfc822;linux-pci@vger.kernel.org>);
	Tue, 23 Sep 2014 17:25:20 -0400
Message-ID: <1411507511.13320.155.camel@snotra.buserror.net>
Subject: Re: [PATCH v3 3/3] PCI: Layerscape: Add Layerscape PCIe driver
From: Scott Wood <scottwood@freescale.com>
To: Minghuan Lian <Minghuan.Lian@freescale.com>
CC: <linux-pci@vger.kernel.org>,
	<linux-arm-kernel@lists.infradead.org>,
	"Zang Roy-R61911" <r61911@freescale.com>,
	Hu Mingkai-B21284 <B21284@freescale.com>,
	Yoder Stuart-B08248 <stuart.yoder@freescale.com>,
	Arnd Bergmann <arnd@arndb.de>,
	Bjorn Helgaas <bhelgaas@google.com>
Date: Tue, 23 Sep 2014 16:25:11 -0500
In-Reply-To: <1411482540-31297-5-git-send-email-Minghuan.Lian@freescale.com>
References: <1411482540-31297-1-git-send-email-Minghuan.Lian@freescale.com>
	 <1411482540-31297-5-git-send-email-Minghuan.Lian@freescale.com>
Content-Type: text/plain; charset="UTF-8"
MIME-Version: 1.0
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Tue, 2014-09-23 at 22:29 +0800, Minghuan Lian wrote:
> diff --git a/drivers/pci/host/Kconfig b/drivers/pci/host/Kconfig
> index 34134d6..7c49456 100644
> --- a/drivers/pci/host/Kconfig
> +++ b/drivers/pci/host/Kconfig
> @@ -82,4 +82,11 @@ config PCIE_XILINX
>  	  Say 'Y' here if you want kernel to support the Xilinx AXI PCIe
>  	  Host Bridge driver.
>  
> +config PCI_LAYERSCAPE
> +	bool "Freescale Layerscape PCIe controller"
> +	select PCIE_DW
> +	select MFD_SYSCON
> +	help
> +	  Say Y here if you want PCIe controller support on Layerscape SoCs.
> +
>  endmenu

Are you sure there are no dependencies for this to build?  At the least
you need OF.

I think you should also be selecting REGMAP.

-Scott


