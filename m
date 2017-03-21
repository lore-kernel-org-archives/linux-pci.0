Return-Path: <linux-kernel-owner@vger.kernel.org>
From: "Jingoo Han" <jingoohan1@gmail.com>
To: "'Arnd Bergmann'" <arnd@arndb.de>,
        "'Bjorn Helgaas'" <bhelgaas@google.com>,
        "'Kishon Vijay Abraham I'" <kishon@ti.com>
Cc: <linux-pci@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        "'Joao Pinto'" <Joao.Pinto@synopsys.com>,
        "'Zhou Wang'" <wangzhou1@hisilicon.com>,
        "'Gabriele Paoloni'" <gabriele.paoloni@huawei.com>
References: <20170321143229.3372903-1-arnd@arndb.de>
In-Reply-To: <20170321143229.3372903-1-arnd@arndb.de>
Subject: Re: [PATCH] pci: dwc: hisi needs PCI_HOST_COMMON
Date: Tue, 21 Mar 2017 11:48:37 -0400
Message-ID: <001801d2a25a$9c742760$d55c7620$@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain;
        charset="us-ascii"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

(+cc: Joao Pinto, Zhou Wang, Gabriele Paoloni)

On Tuesday, March 21, 2017 10:32 AM, Arnd Bergmann wrote:
> 
> Without PCI_HOST_COMMON support enabled, we get a link error:
> 
> drivers/pci/dwc/built-in.o: In function `hisi_pcie_map_bus':
> pcie-hisi.c:(.text+0x8860): undefined reference to `pci_ecam_map_bus'
> drivers/pci/dwc/built-in.o: In function `hisi_pcie_almost_ecam_probe':
> pcie-hisi.c:(.text+0x88b4): undefined reference to `pci_host_common_probe'
> 
> This adds an explicit 'select', as the other users have.
> 
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>

Acked-by: Jingoo Han <jingoohan1@gmail.com>

Best regards,
Jingoo Han

> ---
>  drivers/pci/dwc/Kconfig | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/drivers/pci/dwc/Kconfig b/drivers/pci/dwc/Kconfig
> index dfb8a69afc28..d2d2ba5b8a68 100644
> --- a/drivers/pci/dwc/Kconfig
> +++ b/drivers/pci/dwc/Kconfig
> @@ -89,6 +89,7 @@ config PCI_HISI
>  	depends on PCI_MSI_IRQ_DOMAIN
>  	select PCIEPORTBUS
>  	select PCIE_DW_HOST
> +	select PCI_HOST_COMMON
>  	help
>  	  Say Y here if you want PCIe controller support on HiSilicon
>  	  Hip05 and Hip06 SoCs
> --
> 2.9.0
