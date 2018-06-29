Return-Path: <linux-kernel-owner@vger.kernel.org>
Date: Fri, 29 Jun 2018 14:40:41 +0100
From: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
To: Geert Uytterhoeven <geert+renesas@glider.be>
Cc: Gustavo Pimentel <gustavo.pimentel@synopsys.com>,
        Bjorn Helgaas <bhelgaas@google.com>, linux-pci@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] PCI: controller: dwc: Do not let PCIE_DW_PLAT_HOST
 default to yes
Message-ID: <20180629134041.GC9643@red-moon>
References: <20180619171917.19932-1-geert+renesas@glider.be>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20180619171917.19932-1-geert+renesas@glider.be>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Tue, Jun 19, 2018 at 07:19:17PM +0200, Geert Uytterhoeven wrote:
> PCIE_DW_PLAT_HOST does not have any platform dependency, so it should
> not default to yes.
> 
> Fixes: 1d906b22076e12cf ("PCI: dwc: Add support for EP mode")
> Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
> ---
> v2:
>   - Rebased on top of the big PCI controller move.
> ---
>  drivers/pci/controller/dwc/Kconfig | 1 -
>  1 file changed, 1 deletion(-)

Applied to pci/controller-fixes to be tentatively merged for
-rc4, thanks.

Lorenzo

> diff --git a/drivers/pci/controller/dwc/Kconfig b/drivers/pci/controller/dwc/Kconfig
> index 16f52c626b4bd510..91b0194240a57e8f 100644
> --- a/drivers/pci/controller/dwc/Kconfig
> +++ b/drivers/pci/controller/dwc/Kconfig
> @@ -58,7 +58,6 @@ config PCIE_DW_PLAT_HOST
>  	depends on PCI && PCI_MSI_IRQ_DOMAIN
>  	select PCIE_DW_HOST
>  	select PCIE_DW_PLAT
> -	default y
>  	help
>  	  Enables support for the PCIe controller in the Designware IP to
>  	  work in host mode. There are two instances of PCIe controller in
> -- 
> 2.17.1
> 
