Return-Path: <linux-kernel-owner@vger.kernel.org>
Date: Mon, 22 May 2017 16:26:40 -0500
From: Bjorn Helgaas <helgaas@kernel.org>
To: Geert Uytterhoeven <geert@linux-m68k.org>
Cc: Kishon Vijay Abraham I <kishon@ti.com>,
        Bjorn Helgaas <bhelgaas@google.com>, linux-pci@vger.kernel.org,
        Arnd Bergmann <arnd@arndb.de>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] PCI: endpoint: PCI_ENDPOINT should depend on HAS_DMA
Message-ID: <20170522212640.GD19733@bhelgaas-glaptop.roam.corp.google.com>
References: <1494955268-1262-1-git-send-email-geert@linux-m68k.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1494955268-1262-1-git-send-email-geert@linux-m68k.org>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Tue, May 16, 2017 at 07:21:08PM +0200, Geert Uytterhoeven wrote:
> If NO_DMA=y:
> 
>     drivers/built-in.o: In function `__pci_epc_create':
>     (.text+0xef4e): undefined reference to `bad_dma_ops'
>     drivers/built-in.o: In function `pci_epc_add_epf':
>     (.text+0xf676): undefined reference to `bad_dma_ops'
>     drivers/built-in.o: In function `pci_epf_alloc_space':
>     (.text+0xfa32): undefined reference to `bad_dma_ops'
>     drivers/built-in.o: In function `pci_epf_free_space':
>     (.text+0xfac4): undefined reference to `bad_dma_ops'
> 
> Add a dependency on HAS_DMA to fix this.
> 
> Signed-off-by: Geert Uytterhoeven <geert@linux-m68k.org>

Applied to for-linus for v4.12, thanks!

> ---
> Should PCI_ENDPOINT depend on CONFIG_PCI instead?

I *think* we want HAS_DMA, not CONFIG_PCI, because CONFIG_PCI means we
want the infrastructure for PCI host bridges, enumerating children of
the bridges, etc.  I think we want to allow PCI_ENDPOINT without all
that.

Kishon?

> ---
>  drivers/pci/endpoint/Kconfig | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/drivers/pci/endpoint/Kconfig b/drivers/pci/endpoint/Kconfig
> index c23f146fb5a668b3..c09623ca8c3b14b9 100644
> --- a/drivers/pci/endpoint/Kconfig
> +++ b/drivers/pci/endpoint/Kconfig
> @@ -6,6 +6,7 @@ menu "PCI Endpoint"
>  
>  config PCI_ENDPOINT
>  	bool "PCI Endpoint Support"
> +	depends on HAS_DMA
>  	help
>  	   Enable this configuration option to support configurable PCI
>  	   endpoint. This should be enabled if the platform has a PCI
> -- 
> 2.7.4
> 
