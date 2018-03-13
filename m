Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from usa-sjc-mx-foss1.foss.arm.com ([217.140.101.70]:35784 "EHLO
        foss.arm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752411AbeCMLMU (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Tue, 13 Mar 2018 07:12:20 -0400
Date: Tue, 13 Mar 2018 11:12:11 +0000
From: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
To: Jaehoon Chung <jh80.chung@samsung.com>
Cc: linux-pci@vger.kernel.org, linux-samsung-soc@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        robh+dt@kernel.org, krzk@kernel.org, jingoohan1@gmail.com,
        kgene@kernel.org
Subject: Re: [RFC 1/2] pci: dwc: pci-exynos: modify the Kconfig dependency
Message-ID: <20180313111211.GA15480@e107981-ln.cambridge.arm.com>
References: <CGME20171221121409epcas1p2af291857b9df115d2dec9a3d3300e0aa@epcas1p2.samsung.com>
 <20171221121408.22636-1-jh80.chung@samsung.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20171221121408.22636-1-jh80.chung@samsung.com>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Hi Jaehoon,

On Thu, Dec 21, 2017 at 09:14:06PM +0900, Jaehoon Chung wrote:
> PCI_EXYNOS has the dependency with SOC_EXYNOS5440.
> It's modified to ARCH_EXYNOS from SOC_EXYNOS5440, because other
> SoCs needs to use this driver.
> 
> Signed-off-by: Jaehoon Chung <jh80.chung@samsung.com>
> ---
>  drivers/pci/dwc/Kconfig | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/pci/dwc/Kconfig b/drivers/pci/dwc/Kconfig
> index 113e09440f85..0ff9795df8e8 100644
> --- a/drivers/pci/dwc/Kconfig
> +++ b/drivers/pci/dwc/Kconfig
> @@ -65,7 +65,7 @@ config PCIE_DW_PLAT
>  config PCI_EXYNOS
>  	bool "Samsung Exynos PCIe controller"
>  	depends on PCI
> -	depends on SOC_EXYNOS5440
> +	depends on ARCH_EXYNOS
>  	depends on PCI_MSI_IRQ_DOMAIN
>  	select PCIEPORTBUS
>  	select PCIE_DW_HOST

This patch fell through the cracks, is it still needed ? Please let
me know and I will apply it if it is, thank you very much.

Lorenzo
