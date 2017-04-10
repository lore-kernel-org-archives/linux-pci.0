Return-Path: <SRS0=0Mm1=3S=sigmadesigns.com=Marc_Gonzalez@kernel.org>
Return-Path: <SRS0=0Mm1=3S=sigmadesigns.com=Marc_Gonzalez@kernel.org>
Subject: Re: [TRIVIAL PATCH] PCI: Change pci_host_common_probe visibility
From: Marc Gonzalez <marc_gonzalez@sigmadesigns.com>
To: Bjorn Helgaas <helgaas@kernel.org>
CC: linux-pci <linux-pci@vger.kernel.org>, Lorenzo Pieralisi
	<lorenzo.pieralisi@arm.com>, Jayachandran C <jchandra@broadcom.com>, "Arnd
 Bergmann" <arnd@arndb.de>
References: <11bd9bd5-5d96-bd7c-24c7-5f262a46085c@sigmadesigns.com>
Message-ID: <b79fcb7f-1621-58e4-ef16-1df2911accbe@sigmadesigns.com>
Date: Mon, 10 Apr 2017 14:26:42 +0200
MIME-Version: 1.0
In-Reply-To: <11bd9bd5-5d96-bd7c-24c7-5f262a46085c@sigmadesigns.com>
Content-Type: text/plain; charset="ISO-8859-15"
List-ID: <linux-pci.vger.kernel.org>

On 28/03/2017 17:29, Marc Gonzalez wrote:

> pci_host_common_probe is defined when CONFIG_PCI_HOST_COMMON=y
> therefore the function declaration should match that.
> 
> drivers/pci/host/pcie-tango.c:300:9: error:
> 	implicit declaration of function 'pci_host_common_probe'
> 
> Signed-off-by: Marc Gonzalez <marc_gonzalez@sigmadesigns.com>
> ---
>  include/linux/pci-ecam.h | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/include/linux/pci-ecam.h b/include/linux/pci-ecam.h
> index 33c4750781a0..e746803df566 100644
> --- a/include/linux/pci-ecam.h
> +++ b/include/linux/pci-ecam.h
> @@ -60,7 +60,7 @@ void __iomem *pci_ecam_map_bus(struct pci_bus *bus, unsigned int devfn,
>  /* default ECAM ops */
>  extern struct pci_ecam_ops pci_generic_ecam_ops;
>  
> -#ifdef CONFIG_PCI_HOST_GENERIC
> +#ifdef CONFIG_PCI_HOST_COMMON
>  /* for DT-based PCI controllers that support ECAM */
>  int pci_host_common_probe(struct platform_device *pdev,
>  			  struct pci_ecam_ops *ops);
> 

Hello Bjorn,

What is the status of this patch?

Arnd submitted an alternative patch earlier.

https://patchwork.kernel.org/patch/9637045/
https://patchwork.kernel.org/patch/9649993/

Arnd's solution is to make the declaration always visible.
My solution is to make the declaration visible only when
CONFIG_PCI_HOST_COMMON is defined.

The difference boils down to getting an error
at link-time VS at compile-time.

Regards.
