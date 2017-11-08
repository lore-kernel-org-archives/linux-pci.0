Return-Path: <linux-kernel-owner@vger.kernel.org>
Date: Tue, 7 Nov 2017 18:30:49 -0600
From: Bjorn Helgaas <helgaas@kernel.org>
To: changbin.du@intel.com
Cc: bhelgaas@google.com, tglx@linutronix.de, mingo@redhat.com,
        x86@kernel.org, linux-pci@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] PCI: Fail pci_map_rom if the PCI ROM is invalid
Message-ID: <20171108003049.GC22847@bhelgaas-glaptop.roam.corp.google.com>
References: <1509594522-6841-1-git-send-email-changbin.du@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1509594522-6841-1-git-send-email-changbin.du@intel.com>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Thu, Nov 02, 2017 at 11:48:42AM +0800, changbin.du@intel.com wrote:
> From: Changbin Du <changbin.du@intel.com>
> 
> If we detected a invalid PCI ROM (e.g. Invalid PCI ROM header signature),
> we should unmap it immediately and fail. It doesn't make any sense that
> return a mapped area with size of 0.
> 
> I have seen this case on Intel GVTg vGPU, which have no vbios. It will
> not cause a real problem, but we should skip it as early as possible.
> 
> Signed-off-by: Changbin Du <changbin.du@intel.com>

Applied to pci/resource for v4.15, thanks!

I split this into two patches: (1) moving the disable to err_ioremap, and
(2) the actual "if (!*size)" change which is the interesting part.

> ---
>  drivers/pci/rom.c | 19 +++++++++++++------
>  1 file changed, 13 insertions(+), 6 deletions(-)
> 
> diff --git a/drivers/pci/rom.c b/drivers/pci/rom.c
> index b6edb18..1f5e6af 100644
> --- a/drivers/pci/rom.c
> +++ b/drivers/pci/rom.c
> @@ -147,12 +147,8 @@ void __iomem *pci_map_rom(struct pci_dev *pdev, size_t *size)
>  		return NULL;
>  
>  	rom = ioremap(start, *size);
> -	if (!rom) {
> -		/* restore enable if ioremap fails */
> -		if (!(res->flags & IORESOURCE_ROM_ENABLE))
> -			pci_disable_rom(pdev);
> -		return NULL;
> -	}
> +	if (!rom)
> +		goto err_ioremap;
>  
>  	/*
>  	 * Try to find the true size of the ROM since sometimes the PCI window
> @@ -160,7 +156,18 @@ void __iomem *pci_map_rom(struct pci_dev *pdev, size_t *size)
>  	 * True size is important if the ROM is going to be copied.
>  	 */
>  	*size = pci_get_rom_size(pdev, rom, *size);
> +	if (!*size)
> +		goto invalid_rom;
> +
>  	return rom;
> +
> +invalid_rom:
> +	iounmap(rom);
> +err_ioremap:
> +	/* restore enable if ioremap fails */
> +	if (!(res->flags & IORESOURCE_ROM_ENABLE))
> +		pci_disable_rom(pdev);
> +	return NULL;
>  }
>  EXPORT_SYMBOL(pci_map_rom);
>  
> -- 
> 2.7.4
> 
