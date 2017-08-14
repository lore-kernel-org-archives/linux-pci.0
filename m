Return-Path: <linux-arm-kernel-bounces+bjorn=helgaas.com@lists.infradead.org>
Return-Path: <linux-arm-kernel-bounces+bjorn=helgaas.com@lists.infradead.org>
Date: Mon, 14 Aug 2017 19:15:03 +0100
From: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
To: Khuong Dinh <kdinh@apm.com>
Subject: Re: [PATCH v3 pci] PCI/MSI: pci-xgene-msi: Enable MSI support in
 ACPI boot for X-Gene v1
Message-ID: <20170814181503.GA3093@red-moon>
References: <1502496173-6017-1-git-send-email-kdinh@apm.com>
MIME-Version: 1.0
In-Reply-To: <1502496173-6017-1-git-send-email-kdinh@apm.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Cc: marc.zyngier@arm.com, linux-pci@vger.kernel.org, msalter@redhat.com,
 rjw@rjwysocki.net, linux-kernel@vger.kernel.org, patches@apm.com,
 jcm@redhat.com, bhelgaas@google.com, linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="us-ascii"
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+bjorn=helgaas.com@lists.infradead.org
List-ID: <linux-pci.vger.kernel.org>

On Fri, Aug 11, 2017 at 06:02:53PM -0600, Khuong Dinh wrote:
> This patch makes pci-xgene-msi driver ACPI-aware and provides
> MSI capability for X-Gene v1 PCIe controllers in ACPI boot mode.
> 
> Signed-off-by: Khuong Dinh <kdinh@apm.com>
>         [Take over from Duc Dang]
> Acked-by: Marc Zyngier <marc.zyngier@arm.com>
> ---
> v3:
>  - Input X-Gene MSI base address for irq_domain_alloc_fwnode
>  - Add a hook to enforce X-Gene MSI be probed prior acpi_bus_scan happens
> v2:
>  - Verify with BIOS version 3.06.25 and 3.07.09
> v1:
>  - Initial version
> ---
>  drivers/acpi/Makefile            |    2 +-
>  drivers/acpi/acpi_msi.c          |   74 ++++++++++++++++++++++++++++++++++++++
>  drivers/acpi/internal.h          |    1 +
>  drivers/acpi/scan.c              |    1 +
>  drivers/pci/host/pci-xgene-msi.c |   36 +++++++++++++++++--
>  5 files changed, 110 insertions(+), 4 deletions(-)
>  create mode 100644 drivers/acpi/acpi_msi.c
> 
> diff --git a/drivers/acpi/Makefile b/drivers/acpi/Makefile
> index b1aacfc..c15f5cd 100644
> --- a/drivers/acpi/Makefile
> +++ b/drivers/acpi/Makefile
> @@ -40,7 +40,7 @@ acpi-y				+= ec.o
>  acpi-$(CONFIG_ACPI_DOCK)	+= dock.o
>  acpi-y				+= pci_root.o pci_link.o pci_irq.o
>  obj-$(CONFIG_ACPI_MCFG)		+= pci_mcfg.o
> -acpi-y				+= acpi_lpss.o acpi_apd.o
> +acpi-y				+= acpi_lpss.o acpi_apd.o acpi_msi.o
>  acpi-y				+= acpi_platform.o
>  acpi-y				+= acpi_pnp.o
>  acpi-$(CONFIG_ARM_AMBA)	+= acpi_amba.o
> diff --git a/drivers/acpi/acpi_msi.c b/drivers/acpi/acpi_msi.c
> new file mode 100644
> index 0000000..c2f8d26
> --- /dev/null
> +++ b/drivers/acpi/acpi_msi.c
> @@ -0,0 +1,74 @@
> +/*
> + * Enforce MSI driver loaded by PCIe controller driver
> + *
> + * Copyright (c) 2017, MACOM Technology Solutions Corporation
> + * Author: Khuong Dinh <kdinh@apm.com>
> + *
> + * This program is free software; you can redistribute  it and/or modify it
> + * under  the terms of  the GNU General  Public License as published by the
> + * Free Software Foundation;  either version 2 of the  License, or (at your
> + * option) any later version.
> + *
> + * This program is distributed in the hope that it will be useful,
> + * but WITHOUT ANY WARRANTY; without even the implied warranty of
> + * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
> + * GNU General Public License for more details.
> + */
> +
> +#include <linux/acpi.h>
> +#include "internal.h"
> +
> +static acpi_status acpi_create_msi_device(acpi_handle handle, u32 Level,
> +					void *context, void **retval)
> +{
> +	struct acpi_device *device = NULL;
> +	int type = ACPI_BUS_TYPE_DEVICE;
> +	unsigned long long sta;
> +	acpi_status status;
> +	int ret = 0;
> +
> +	acpi_bus_get_device(handle, &device);
> +	status = acpi_bus_get_status_handle(handle, &sta);
> +	if (ACPI_FAILURE(status))
> +		sta = 0;
> +
> +	device = kzalloc(sizeof(struct acpi_device), GFP_KERNEL);
> +	if (!device)
> +		return -ENOMEM;
> +
> +	acpi_init_device_object(device, handle, type, sta);
> +	ret = acpi_device_add(device, NULL);
> +	if (ret)
> +		return ret;
> +	device->parent = kzalloc(sizeof(struct acpi_device), GFP_KERNEL);
> +	INIT_LIST_HEAD(&device->parent->physical_node_list);
> +
> +	acpi_device_add_finalize(device);
> +
> +	ret = device_attach(&device->dev);
> +	if (ret < 0)
> +		return ret;
> +
> +	acpi_create_platform_device(device, NULL);
> +	acpi_device_set_enumerated(device);
> +
> +	return ret;
> +}

Can't this be implemented through acpi_bus_scan(handle) ?

(where handle is your MSI controller acpi_handle ?)

[...]

>  static int xgene_msi_probe(struct platform_device *pdev)
>  {
>  	struct resource *res;
> @@ -469,7 +487,18 @@ static int xgene_msi_probe(struct platform_device *pdev)
>  		goto error;
>  	}
>  	xgene_msi->msi_addr = res->start;
> -	xgene_msi->node = pdev->dev.of_node;
> +
> +	xgene_msi->fwnode = of_node_to_fwnode(pdev->dev.of_node);
> +	if (!xgene_msi->fwnode) {
> +		xgene_msi->fwnode =
> +			irq_domain_alloc_fwnode((void *)xgene_msi->msi_addr);
> +		if (!xgene_msi->fwnode) {
> +			dev_err(&pdev->dev, "Failed to create fwnode\n");
> +			rc = ENOMEM;
> +			goto error;
> +		}
> +	}
> +
>  	xgene_msi->num_cpus = num_possible_cpus();
>  
>  	rc = xgene_msi_init_allocator(xgene_msi);
> @@ -540,6 +569,7 @@ static int xgene_msi_probe(struct platform_device *pdev)
>  	.driver = {
>  		.name = "xgene-msi",
>  		.of_match_table = xgene_msi_match_table,
> +		.acpi_match_table = ACPI_PTR(xgene_msi_acpi_ids),
>  	},
>  	.probe = xgene_msi_probe,
>  	.remove = xgene_msi_remove,

AFAIK you still have not solved the link ordering problem, creating
the platform device before scanning the PCI root bridge is not enough,
because you are not guaranteed to probe the MSI driver first, there
has to be way for registering your driver from the ACPI scan hook.

Thanks,
Lorenzo

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
