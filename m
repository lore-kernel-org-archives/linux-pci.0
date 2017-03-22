Return-Path: <SRS0=Wdc/=27=sigmadesigns.com=Marc_Gonzalez@kernel.org>
Return-Path: <SRS0=Wdc/=27=sigmadesigns.com=Marc_Gonzalez@kernel.org>
Subject: Re: [PATCH] PCI: Pull struct pci_ops definition
From: Marc Gonzalez <marc_gonzalez@sigmadesigns.com>
To: Bjorn Helgaas <helgaas@kernel.org>
CC: linux-pci <linux-pci@vger.kernel.org>, Lorenzo Pieralisi
	<lorenzo.pieralisi@arm.com>, Jayachandran C <jchandra@broadcom.com>, Arnd
 Bergmann <arnd@arndb.de>
References: <13b87220-8aab-3a80-1d74-8e31d2d59e20@sigmadesigns.com>
Message-ID: <8c99b974-14f2-37cc-2753-0879348ba027@sigmadesigns.com>
Date: Wed, 22 Mar 2017 11:18:11 +0100
MIME-Version: 1.0
In-Reply-To: <13b87220-8aab-3a80-1d74-8e31d2d59e20@sigmadesigns.com>
Content-Type: text/plain; charset="ISO-8859-15"
List-ID: <linux-pci.vger.kernel.org>

On 17/03/2017 15:53, Marc Gonzalez wrote:

> struct pci_ecam_ops embeds a struct pci_ops. Explicitly request the
> definition for struct pci_ops, otherwise gcc might complain:
> 
> include/linux/pci-ecam.h:29:19: error: field 'pci_ops' has incomplete type
> 
> Signed-off-by: Marc Gonzalez <marc_gonzalez@sigmadesigns.com>
> ---
>  include/linux/pci-ecam.h | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/include/linux/pci-ecam.h b/include/linux/pci-ecam.h
> index 7adad206b1f4..33c4750781a0 100644
> --- a/include/linux/pci-ecam.h
> +++ b/include/linux/pci-ecam.h
> @@ -16,6 +16,7 @@
>  #ifndef DRIVERS_PCI_ECAM_H
>  #define DRIVERS_PCI_ECAM_H
>  
> +#include <linux/pci.h>
>  #include <linux/kernel.h>
>  #include <linux/platform_device.h>
>  

Hello Bjorn,

Can you take this trivial patch?

Regards.
