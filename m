Return-Path: <linux-arch-owner@vger.kernel.org>
Date: Tue, 8 Mar 2016 15:22:57 -0600
From: Bjorn Helgaas <helgaas@kernel.org>
To: Bogicevic Sasa <brutallesale@gmail.com>
Cc: bhelgaas@google.com, linux-kernel@vger.kernel.org,
	linux-pci@vger.kernel.org, "David S. Miller" <davem@davemloft.net>,
	linux-arch@vger.kernel.org
Subject: Re: [PATCH] drivers:pci Remove pcie folder from Kconfig
Message-ID: <20160308212257.GB27132@localhost>
References: <1454534662-33889-1-git-send-email-brutallesale@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1454534662-33889-1-git-send-email-brutallesale@gmail.com>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

[+cc linux-arch, davem]

On Wed, Feb 03, 2016 at 01:24:22PM -0800, Bogicevic Sasa wrote:
> This removes drivers/pci/pcie folder from Kconfig
> files in arch/ and sources pcie in pci Kconfig directly
> 
> Signed-off-by: Sasa Bogicevic <brutallesale@gmail.com>

I applied this to pci/kconfig with the changelog below.  I intend this
for v4.6, subject to any comments or issues we trip over.

The interesting thing here is that it adds PCIe support to several
arches that didn't have it before.  It surprises me a bit that some of
these (in particular, sparc) didn't have it before.

I do like the idea of an arch not having to specify *both* PCI and
PCIe support, because in principle a PCI hierarchy can include PCIe
devices, but maybe there's a reason we don't want this.


    PCI: Include pci/pcie/Kconfig directly from pci/Kconfig
    
    Include pci/pcie/Kconfig directly from pci/Kconfig, so arches don't
    have to source both pci/Kconfig and pci/pcie/Kconfig.
    
    Note that this effectively adds pci/pcie/Kconfig to the following
    arches, because they already sourced drivers/pci/Kconfig but they
    previously did not source drivers/pci/pcie/Kconfig:
    
      alpha
      avr32
      blackfin
      frv
      m32r
      m68k
      microblaze
      mn10300
      parisc
      sparc
      unicore32
      xtensa
    
    [bhelgaas: changelog, source pci/pcie/Kconfig at top of pci/Kconfig, whitespace]
    Signed-off-by: Sasa Bogicevic <brutallesale@gmail.com>
    Signed-off-by: Bjorn Helgaas <bhelgaas@google.com>

> ---
>  arch/arm/Kconfig     | 1 -
>  arch/arm64/Kconfig   | 1 -
>  arch/ia64/Kconfig    | 1 -
>  arch/mips/Kconfig    | 2 --
>  arch/powerpc/Kconfig | 1 -
>  arch/s390/Kconfig    | 1 -
>  arch/sh/Kconfig      | 1 -
>  arch/tile/Kconfig    | 1 -
>  arch/x86/Kconfig     | 1 -
>  drivers/pci/Kconfig  | 1 +
>  10 files changed, 1 insertion(+), 10 deletions(-)
> 
> diff --git a/arch/arm/Kconfig b/arch/arm/Kconfig
> index 4f799e5..1d00da1 100644
> --- a/arch/arm/Kconfig
> +++ b/arch/arm/Kconfig
> @@ -1212,7 +1212,6 @@ config PCI_HOST_ITE8152
>  	select DMABOUNCE
>  
>  source "drivers/pci/Kconfig"
> -source "drivers/pci/pcie/Kconfig"
>  
>  source "drivers/pcmcia/Kconfig"
>  
> diff --git a/arch/arm64/Kconfig b/arch/arm64/Kconfig
> index 8cc6228..128ec3c 100644
> --- a/arch/arm64/Kconfig
> +++ b/arch/arm64/Kconfig
> @@ -235,7 +235,6 @@ config PCI_SYSCALL
>  	def_bool PCI
>  
>  source "drivers/pci/Kconfig"
> -source "drivers/pci/pcie/Kconfig"
>  source "drivers/pci/hotplug/Kconfig"
>  
>  endmenu
> diff --git a/arch/ia64/Kconfig b/arch/ia64/Kconfig
> index fb0515e..6245501 100644
> --- a/arch/ia64/Kconfig
> +++ b/arch/ia64/Kconfig
> @@ -574,7 +574,6 @@ config PCI_DOMAINS
>  config PCI_SYSCALL
>  	def_bool PCI
>  
> -source "drivers/pci/pcie/Kconfig"
>  
>  source "drivers/pci/Kconfig"
>  
> diff --git a/arch/mips/Kconfig b/arch/mips/Kconfig
> index 57a945e..d21eec7 100644
> --- a/arch/mips/Kconfig
> +++ b/arch/mips/Kconfig
> @@ -2876,8 +2876,6 @@ config PCI_DOMAINS
>  
>  source "drivers/pci/Kconfig"
>  
> -source "drivers/pci/pcie/Kconfig"
> -
>  #
>  # ISA support is now enabled via select.  Too many systems still have the one
>  # or other ISA chip on the board that users don't know about so don't expect
> diff --git a/arch/powerpc/Kconfig b/arch/powerpc/Kconfig
> index e4824fd..d4ec17c 100644
> --- a/arch/powerpc/Kconfig
> +++ b/arch/powerpc/Kconfig
> @@ -828,7 +828,6 @@ config PCI_8260
>  	select PPC_INDIRECT_PCI
>  	default y
>  
> -source "drivers/pci/pcie/Kconfig"
>  
>  source "drivers/pci/Kconfig"
>  
> diff --git a/arch/s390/Kconfig b/arch/s390/Kconfig
> index 3be9c83..9918433 100644
> --- a/arch/s390/Kconfig
> +++ b/arch/s390/Kconfig
> @@ -605,7 +605,6 @@ config PCI_NR_MSI
>  	  PCI devices.
>  
>  source "drivers/pci/Kconfig"
> -source "drivers/pci/pcie/Kconfig"
>  source "drivers/pci/hotplug/Kconfig"
>  
>  endif	# PCI
> diff --git a/arch/sh/Kconfig b/arch/sh/Kconfig
> index e13da05..88a334c 100644
> --- a/arch/sh/Kconfig
> +++ b/arch/sh/Kconfig
> @@ -847,7 +847,6 @@ config PCI
>  config PCI_DOMAINS
>  	bool
>  
> -source "drivers/pci/pcie/Kconfig"
>  
>  source "drivers/pci/Kconfig"
>  
> diff --git a/arch/tile/Kconfig b/arch/tile/Kconfig
> index de4a4ff..0c95266 100644
> --- a/arch/tile/Kconfig
> +++ b/arch/tile/Kconfig
> @@ -455,7 +455,6 @@ config TILE_PCI_IO
>  
>  source "drivers/pci/Kconfig"
>  
> -source "drivers/pci/pcie/Kconfig"
>  
>  config TILE_USB
>  	tristate "Tilera USB host adapter support"
> diff --git a/arch/x86/Kconfig b/arch/x86/Kconfig
> index 9af2e63..688b222 100644
> --- a/arch/x86/Kconfig
> +++ b/arch/x86/Kconfig
> @@ -2430,7 +2430,6 @@ config PCI_CNB20LE_QUIRK
>  
>  	  You should say N unless you know you need this.
>  
> -source "drivers/pci/pcie/Kconfig"
>  
>  source "drivers/pci/Kconfig"
>  
> diff --git a/drivers/pci/Kconfig b/drivers/pci/Kconfig
> index 73de4ef..aae605a 100644
> --- a/drivers/pci/Kconfig
> +++ b/drivers/pci/Kconfig
> @@ -119,3 +119,4 @@ config PCI_LABEL
>  	select NLS
>  
>  source "drivers/pci/host/Kconfig"
> +source "drivers/pci/pcie/Kconfig"
> -- 
> 2.5.0
> 
> --
> To unsubscribe from this list: send the line "unsubscribe linux-pci" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
