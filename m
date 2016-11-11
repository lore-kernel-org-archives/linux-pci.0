Return-Path: <keith.busch@intel.com>
Return-Path: <keith.busch@intel.com>
Date: Fri, 11 Nov 2016 18:10:00 -0500
From: Keith Busch <keith.busch@intel.com>
To: Jon Derrick <jonathan.derrick@intel.com>
Cc: helgaas@kernel.org, linux-pci@vger.kernel.org
Subject: Re: [PATCH 2/2] PCI/VMD: Select SRCU
Message-ID: <20161111230959.GC10660@localhost.localdomain>
References: <1478904657-11342-1-git-send-email-jonathan.derrick@intel.com>
 <1478904657-11342-2-git-send-email-jonathan.derrick@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1478904657-11342-2-git-send-email-jonathan.derrick@intel.com>
List-ID: <linux-pci.vger.kernel.org>

On Fri, Nov 11, 2016 at 03:50:57PM -0700, Jon Derrick wrote:
> VMD now uses SRCU, so we must qualify that it is part of the kernel.
> 
> Signed-off-by: Jon Derrick <jonathan.derrick@intel.com>
> ---
>  drivers/pci/host/Kconfig | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/drivers/pci/host/Kconfig b/drivers/pci/host/Kconfig
> index d7e7c0a..80ffa66 100644
> --- a/drivers/pci/host/Kconfig
> +++ b/drivers/pci/host/Kconfig
> @@ -287,6 +287,7 @@ config PCIE_ROCKCHIP
>  
>  config VMD
>  	depends on PCI_MSI && X86_64
> +	select SRCU
>  	tristate "Intel Volume Management Device Driver"
>  	default N
>  	---help---

I think it'd be better to squash this patch with the first in this series,
and append SRCU to the 'depends on' section rather than select it.

I get the feeling that having both 'select' and 'depends on' in the
Kconfig syntax is not a well loved feature:
 https://www.linuxplumbersconf.org/2016/ocw/proposals/4605
