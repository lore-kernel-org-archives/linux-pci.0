Return-Path: <lorenzo.pieralisi@arm.com>
Return-Path: <lorenzo.pieralisi@arm.com>
Date: Thu, 2 Jun 2016 10:48:20 +0100
From: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
To: Tomasz Nowicki <tn@semihalf.com>
Cc: helgaas@kernel.org, arnd@arndb.de, will.deacon@arm.com,
	catalin.marinas@arm.com, rafael@kernel.org, hanjun.guo@linaro.org,
	okaya@codeaurora.org, jchandra@broadcom.com,
	robert.richter@caviumnetworks.com, mw@semihalf.com,
	Liviu.Dudau@arm.com, ddaney@caviumnetworks.com,
	wangyijing@huawei.com, Suravee.Suthikulpanit@amd.com,
	msalter@redhat.com, linux-pci@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org, linux-acpi@vger.kernel.org,
	linux-kernel@vger.kernel.org, linaro-acpi@lists.linaro.org,
	jcm@redhat.com, andrea.gallo@linaro.org, dhdang@apm.com,
	jeremy.linton@arm.com, liudongdong3@huawei.com, cov@codeaurora.org
Subject: Re: [PATCH V8 1/9] PCI: ecam: move ecam.h to linux/include/pci-ecam.h
Message-ID: <20160602094820.GC13962@red-moon>
References: <1464621262-26770-1-git-send-email-tn@semihalf.com>
 <1464621262-26770-2-git-send-email-tn@semihalf.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1464621262-26770-2-git-send-email-tn@semihalf.com>
List-ID: <linux-pci.vger.kernel.org>

On Mon, May 30, 2016 at 05:14:14PM +0200, Tomasz Nowicki wrote:
> From: Jayachandran C <jchandra@broadcom.com>
> 
> This header will be used from arch/arm64 for ACPI PCI implementation
> so it needs to be moved out of drivers/pci.
> 
> Update users of the header file to use the new name. No functional
> changes.
> 
> Signed-off-by: Jayachandran C <jchandra@broadcom.com>
> ---
>  drivers/pci/ecam.c                  |  3 +-
>  drivers/pci/ecam.h                  | 67 -------------------------------------
>  drivers/pci/host/pci-host-common.c  |  3 +-
>  drivers/pci/host/pci-host-generic.c |  3 +-
>  drivers/pci/host/pci-thunder-ecam.c |  3 +-
>  drivers/pci/host/pci-thunder-pem.c  |  3 +-
>  include/linux/pci-ecam.h            | 67 +++++++++++++++++++++++++++++++++++++
>  7 files changed, 72 insertions(+), 77 deletions(-)
>  delete mode 100644 drivers/pci/ecam.h
>  create mode 100644 include/linux/pci-ecam.h

Acked-by: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>

> 
> diff --git a/drivers/pci/ecam.c b/drivers/pci/ecam.c
> index f9832ad..820e26b 100644
> --- a/drivers/pci/ecam.c
> +++ b/drivers/pci/ecam.c
> @@ -19,10 +19,9 @@
>  #include <linux/kernel.h>
>  #include <linux/module.h>
>  #include <linux/pci.h>
> +#include <linux/pci-ecam.h>
>  #include <linux/slab.h>
>  
> -#include "ecam.h"
> -
>  /*
>   * On 64-bit systems, we do a single ioremap for the whole config space
>   * since we have enough virtual address range available.  On 32-bit, we
> diff --git a/drivers/pci/ecam.h b/drivers/pci/ecam.h
> deleted file mode 100644
> index 9878beb..0000000
> --- a/drivers/pci/ecam.h
> +++ /dev/null
> @@ -1,67 +0,0 @@
> -/*
> - * Copyright 2016 Broadcom
> - *
> - * This program is free software; you can redistribute it and/or modify
> - * it under the terms of the GNU General Public License, version 2, as
> - * published by the Free Software Foundation (the "GPL").
> - *
> - * This program is distributed in the hope that it will be useful, but
> - * WITHOUT ANY WARRANTY; without even the implied warranty of
> - * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
> - * General Public License version 2 (GPLv2) for more details.
> - *
> - * You should have received a copy of the GNU General Public License
> - * version 2 (GPLv2) along with this source code.
> - */
> -#ifndef DRIVERS_PCI_ECAM_H
> -#define DRIVERS_PCI_ECAM_H
> -
> -#include <linux/kernel.h>
> -#include <linux/platform_device.h>
> -
> -/*
> - * struct to hold pci ops and bus shift of the config window
> - * for a PCI controller.
> - */
> -struct pci_config_window;
> -struct pci_ecam_ops {
> -	unsigned int			bus_shift;
> -	struct pci_ops			pci_ops;
> -	int				(*init)(struct device *,
> -						struct pci_config_window *);
> -};
> -
> -/*
> - * struct to hold the mappings of a config space window. This
> - * is expected to be used as sysdata for PCI controllers that
> - * use ECAM.
> - */
> -struct pci_config_window {
> -	struct resource			res;
> -	struct resource			busr;
> -	void				*priv;
> -	struct pci_ecam_ops		*ops;
> -	union {
> -		void __iomem		*win;	/* 64-bit single mapping */
> -		void __iomem		**winp; /* 32-bit per-bus mapping */
> -	};
> -};
> -
> -/* create and free pci_config_window */
> -struct pci_config_window *pci_ecam_create(struct device *dev,
> -		struct resource *cfgres, struct resource *busr,
> -		struct pci_ecam_ops *ops);
> -void pci_ecam_free(struct pci_config_window *cfg);
> -
> -/* map_bus when ->sysdata is an instance of pci_config_window */
> -void __iomem *pci_ecam_map_bus(struct pci_bus *bus, unsigned int devfn,
> -			       int where);
> -/* default ECAM ops */
> -extern struct pci_ecam_ops pci_generic_ecam_ops;
> -
> -#ifdef CONFIG_PCI_HOST_GENERIC
> -/* for DT-based PCI controllers that support ECAM */
> -int pci_host_common_probe(struct platform_device *pdev,
> -			  struct pci_ecam_ops *ops);
> -#endif
> -#endif
> diff --git a/drivers/pci/host/pci-host-common.c b/drivers/pci/host/pci-host-common.c
> index 8cba7ab..c18b9e3 100644
> --- a/drivers/pci/host/pci-host-common.c
> +++ b/drivers/pci/host/pci-host-common.c
> @@ -20,10 +20,9 @@
>  #include <linux/module.h>
>  #include <linux/of_address.h>
>  #include <linux/of_pci.h>
> +#include <linux/pci-ecam.h>
>  #include <linux/platform_device.h>
>  
> -#include "../ecam.h"
> -
>  static int gen_pci_parse_request_of_pci_ranges(struct device *dev,
>  		       struct list_head *resources, struct resource **bus_range)
>  {
> diff --git a/drivers/pci/host/pci-host-generic.c b/drivers/pci/host/pci-host-generic.c
> index 6eaceab..f0ca6de 100644
> --- a/drivers/pci/host/pci-host-generic.c
> +++ b/drivers/pci/host/pci-host-generic.c
> @@ -23,10 +23,9 @@
>  #include <linux/module.h>
>  #include <linux/of_address.h>
>  #include <linux/of_pci.h>
> +#include <linux/pci-ecam.h>
>  #include <linux/platform_device.h>
>  
> -#include "../ecam.h"
> -
>  static struct pci_ecam_ops gen_pci_cfg_cam_bus_ops = {
>  	.bus_shift	= 16,
>  	.pci_ops	= {
> diff --git a/drivers/pci/host/pci-thunder-ecam.c b/drivers/pci/host/pci-thunder-ecam.c
> index 540d030..a9fc1c9 100644
> --- a/drivers/pci/host/pci-thunder-ecam.c
> +++ b/drivers/pci/host/pci-thunder-ecam.c
> @@ -11,10 +11,9 @@
>  #include <linux/ioport.h>
>  #include <linux/of_pci.h>
>  #include <linux/of.h>
> +#include <linux/pci-ecam.h>
>  #include <linux/platform_device.h>
>  
> -#include "../ecam.h"
> -
>  static void set_val(u32 v, int where, int size, u32 *val)
>  {
>  	int shift = (where & 3) * 8;
> diff --git a/drivers/pci/host/pci-thunder-pem.c b/drivers/pci/host/pci-thunder-pem.c
> index 9b8ab94..5020d3d 100644
> --- a/drivers/pci/host/pci-thunder-pem.c
> +++ b/drivers/pci/host/pci-thunder-pem.c
> @@ -18,10 +18,9 @@
>  #include <linux/module.h>
>  #include <linux/of_address.h>
>  #include <linux/of_pci.h>
> +#include <linux/pci-ecam.h>
>  #include <linux/platform_device.h>
>  
> -#include "../ecam.h"
> -
>  #define PEM_CFG_WR 0x28
>  #define PEM_CFG_RD 0x30
>  
> diff --git a/include/linux/pci-ecam.h b/include/linux/pci-ecam.h
> new file mode 100644
> index 0000000..9878beb
> --- /dev/null
> +++ b/include/linux/pci-ecam.h
> @@ -0,0 +1,67 @@
> +/*
> + * Copyright 2016 Broadcom
> + *
> + * This program is free software; you can redistribute it and/or modify
> + * it under the terms of the GNU General Public License, version 2, as
> + * published by the Free Software Foundation (the "GPL").
> + *
> + * This program is distributed in the hope that it will be useful, but
> + * WITHOUT ANY WARRANTY; without even the implied warranty of
> + * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
> + * General Public License version 2 (GPLv2) for more details.
> + *
> + * You should have received a copy of the GNU General Public License
> + * version 2 (GPLv2) along with this source code.
> + */
> +#ifndef DRIVERS_PCI_ECAM_H
> +#define DRIVERS_PCI_ECAM_H
> +
> +#include <linux/kernel.h>
> +#include <linux/platform_device.h>
> +
> +/*
> + * struct to hold pci ops and bus shift of the config window
> + * for a PCI controller.
> + */
> +struct pci_config_window;
> +struct pci_ecam_ops {
> +	unsigned int			bus_shift;
> +	struct pci_ops			pci_ops;
> +	int				(*init)(struct device *,
> +						struct pci_config_window *);
> +};
> +
> +/*
> + * struct to hold the mappings of a config space window. This
> + * is expected to be used as sysdata for PCI controllers that
> + * use ECAM.
> + */
> +struct pci_config_window {
> +	struct resource			res;
> +	struct resource			busr;
> +	void				*priv;
> +	struct pci_ecam_ops		*ops;
> +	union {
> +		void __iomem		*win;	/* 64-bit single mapping */
> +		void __iomem		**winp; /* 32-bit per-bus mapping */
> +	};
> +};
> +
> +/* create and free pci_config_window */
> +struct pci_config_window *pci_ecam_create(struct device *dev,
> +		struct resource *cfgres, struct resource *busr,
> +		struct pci_ecam_ops *ops);
> +void pci_ecam_free(struct pci_config_window *cfg);
> +
> +/* map_bus when ->sysdata is an instance of pci_config_window */
> +void __iomem *pci_ecam_map_bus(struct pci_bus *bus, unsigned int devfn,
> +			       int where);
> +/* default ECAM ops */
> +extern struct pci_ecam_ops pci_generic_ecam_ops;
> +
> +#ifdef CONFIG_PCI_HOST_GENERIC
> +/* for DT-based PCI controllers that support ECAM */
> +int pci_host_common_probe(struct platform_device *pdev,
> +			  struct pci_ecam_ops *ops);
> +#endif
> +#endif
> -- 
> 1.9.1
> 
