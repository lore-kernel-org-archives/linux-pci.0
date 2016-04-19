Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mout.kundenserver.de ([217.72.192.75]:58412 "EHLO
	mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750812AbcDSVl7 (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Tue, 19 Apr 2016 17:41:59 -0400
From: Arnd Bergmann <arnd@arndb.de>
To: linux-arm-kernel@lists.infradead.org
Cc: Tomasz Nowicki <tn@semihalf.com>, helgaas@kernel.org,
	will.deacon@arm.com, catalin.marinas@arm.com, rafael@kernel.org,
	hanjun.guo@linaro.org, Lorenzo.Pieralisi@arm.com,
	okaya@codeaurora.org, jiang.liu@linux.intel.com,
	jchandra@broadcom.com, jcm@redhat.com,
	linaro-acpi@lists.linaro.org, linux-pci@vger.kernel.org,
	Liviu.Dudau@arm.com, ddaney@caviumnetworks.com,
	linux-kernel@vger.kernel.org, linux-acpi@vger.kernel.org,
	robert.richter@caviumnetworks.com, Suravee.Suthikulpanit@amd.com,
	msalter@redhat.com, wangyijing@huawei.com, mw@semihalf.com
Subject: Re: [PATCH V6 08/13] PCI: generic, thunder: update to use generic ECAM API
Date: Tue, 19 Apr 2016 23:40:38 +0200
Message-ID: <124097091.1DmSn50Vlh@wuerfel>
In-Reply-To: <1460740008-19489-9-git-send-email-tn@semihalf.com>
References: <1460740008-19489-1-git-send-email-tn@semihalf.com> <1460740008-19489-9-git-send-email-tn@semihalf.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Friday 15 April 2016 19:06:43 Tomasz Nowicki wrote:
> From: Jayachandran C <jchandra@broadcom.com>
>
> Add config option PCI_GENERIC_ECAM and file drivers/pci/ecam.c to
> provide generic functions for accessing memory mapped PCI config space.
>
> The API is defined in drivers/pci/ecam.h and is written to replace the
> API in drivers/pci/host/pci-host-common.h. The file defines a new
> 'struct pci_config_window' to hold the information related to a PCI
> config area and its mapping. This structure is expected to be used as
> sysdata for controllers that have ECAM based mapping.
>
> Helper functions are provided to setup the mapping, free the mapping
> and to implement the map_bus method in 'struct pci_ops'
>
> Signed-off-by: Jayachandran C <jchandra@broadcom.com>

I've taken a fresh look now at what is going on here.

> @@ -58,4 +58,9 @@ void __iomem *pci_generic_ecam_map_bus(struct pci_bus *bus, unsigned int devfn,
>  /* default ECAM ops, bus shift 20, generic read and write */
>  extern struct pci_generic_ecam_ops pci_generic_ecam_default_ops;
>  
> +#ifdef CONFIG_PCI_HOST_GENERIC
> +/* for DT based pci controllers that support ECAM */
> +int pci_host_common_probe(struct platform_device *pdev,
> +			  struct pci_generic_ecam_ops *ops);
> +#endif
>  #endif

This doesn't seem to belong here: just leave the declaration
in the existing file. 

> diff --git a/drivers/pci/host/Kconfig b/drivers/pci/host/Kconfig
> index 7a0780d..31d6eb5 100644
> --- a/drivers/pci/host/Kconfig
> +++ b/drivers/pci/host/Kconfig
> @@ -82,6 +82,7 @@ config PCI_HOST_GENERIC
>  	bool "Generic PCI host controller"
>  	depends on (ARM || ARM64) && OF
>  	select PCI_HOST_COMMON
> +	select PCI_GENERIC_ECAM
>  	help
>  	  Say Y here if you want to support a simple generic PCI host
>  	  controller, such as the one emulated by kvmtool.
> diff --git a/drivers/pci/host/pci-host-common.c b/drivers/pci/host/pci-host-common.c
> index e9f850f..99d99b3 100644
> --- a/drivers/pci/host/pci-host-common.c
> +++ b/drivers/pci/host/pci-host-common.c
> @@ -22,27 +22,21 @@
>  #include <linux/of_pci.h>
>  #include <linux/platform_device.h>
>  
> -#include "pci-host-common.h"
> +#include "../ecam.h"

As mentioned, don't use headers from parent directories, anything
that needs to be shared must go into include/linux, while the parts
that are only needed in one directory should be declared there.

> -static int gen_pci_parse_map_cfg_windows(struct gen_pci *pci)
> +static void gen_pci_generic_unmap_cfg(void *ptr)
> +{
> +	pci_generic_ecam_free((struct pci_config_window *)ptr);
> +}

Why the void pointer?

> +static struct pci_generic_ecam_ops pci_thunder_pem_ops = {
> +	.bus_shift	= 24,
> +	.init		= thunder_pem_init,
> +	.pci_ops	= {
> +		.map_bus	= pci_generic_ecam_map_bus,
> +		.read		= thunder_pem_config_read,
> +		.write		= thunder_pem_config_write,
> +	}
> +};

Adding the callback pointer for init here and yet another structure
pci_config_window really seems to go too far with the number of
abstraction levels.

I think here it makes much more sense to just implement ECAM pci_ops
in ACPI separately, as the implementation really trivial to start with,
and all the complexity comes just from trying to share it with other
stuff. Doesn't ACPI already have an ECAM implementation for x86
that you could simply use?

	Arnd
