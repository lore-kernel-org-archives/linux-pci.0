Return-Path: <linux-kernel-owner@vger.kernel.org>
Date: Tue, 27 May 2014 16:54:22 -0600
From: Bjorn Helgaas <bhelgaas@google.com>
To: Arnd Bergmann <arnd@arndb.de>
Cc: linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
	Magnus Damm <damm@opensource.se>, linux-pci@vger.kernel.org,
	linux-sh@vger.kernel.org
Subject: Re: [PATCH] pci: rcar host needs OF
Message-ID: <20140527225422.GE11907@google.com>
References: <1399560433-1402630-1-git-send-email-arnd@arndb.de>
 <1399560990-1402858-1-git-send-email-arnd@arndb.de>
 <1399560990-1402858-14-git-send-email-arnd@arndb.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1399560990-1402858-14-git-send-email-arnd@arndb.de>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Thu, May 08, 2014 at 04:56:25PM +0200, Arnd Bergmann wrote:
> The pci-rcar driver is enabled for compile tests, and this has
> now shown that the driver cannot build without CONFIG_OF,
> following the inclusion of f8f2fe7355fb "PCI: rcar: Use new OF
> interrupt mapping when possible":
> 
> drivers/built-in.o: In function `rcar_pci_map_irq':
> :(.text+0x1cc7c): undefined reference to `of_irq_parse_and_map_pci'
> 
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>
> Cc: Bjorn Helgaas <bhelgaas@google.com>
> Cc: Magnus Damm <damm@opensource.se>
> Cc: linux-pci@vger.kernel.org
> Cc: linux-sh@vger.kernel.org

If I understand correctly, this patch was superceded by this one:

    "[PATCH] of/irq: provide int of_irq_parse_and_map_pci wrapper"

and you aren't expecting me to do anything.  Let me know if otherwise.

> ---
>  drivers/pci/host/Kconfig | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/pci/host/Kconfig b/drivers/pci/host/Kconfig
> index fbbef0b..4675f47 100644
> --- a/drivers/pci/host/Kconfig
> +++ b/drivers/pci/host/Kconfig
> @@ -27,7 +27,7 @@ config PCI_TEGRA
>  
>  config PCI_RCAR_GEN2
>  	bool "Renesas R-Car Gen2 Internal PCI controller"
> -	depends on ARCH_SHMOBILE || (ARM && COMPILE_TEST)
> +	depends on ARCH_SHMOBILE || (ARM && OF && COMPILE_TEST)
>  	help
>  	  Say Y here if you want internal PCI support on R-Car Gen2 SoC.
>  	  There are 3 internal PCI controllers available with a single
> -- 
> 1.8.3.2
> 
