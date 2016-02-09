Return-Path: <linux-acpi-owner@vger.kernel.org>
Date: Tue, 9 Feb 2016 18:24:29 +0000
From: Mark Rutland <mark.rutland@arm.com>
To: Gabriele Paoloni <gabriele.paoloni@huawei.com>
Cc: guohanjun@huawei.com, wangzhou1@hisilicon.com,
	liudongdong3@huawei.com, linuxarm@huawei.com, qiujiang@huawei.com,
	bhelgaas@google.com, arnd@arndb.de, Lorenzo.Pieralisi@arm.com,
	tn@semihalf.com, linux-pci@vger.kernel.org,
	linux-kernel@vger.kernel.org, xuwei5@hisilicon.com,
	linux-acpi@vger.kernel.org, jcm@redhat.com, zhangjukuo@huawei.com,
	liguozhu@hisilicon.com, linux-arm-kernel@lists.infradead.org
Subject: Re: [RFC PATCH v3 3/3] PCI/ACPI: hisi: Add ACPI support for
 HiSilicon SoCs Host Controllers
Message-ID: <20160209182429.GD4348@leverpostej>
References: <1455039260-6040-1-git-send-email-gabriele.paoloni@huawei.com>
 <1455039260-6040-4-git-send-email-gabriele.paoloni@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1455039260-6040-4-git-send-email-gabriele.paoloni@huawei.com>
Sender: linux-acpi-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Tue, Feb 09, 2016 at 05:34:20PM +0000, Gabriele Paoloni wrote:
> From: gabriele paoloni <gabriele.paoloni@huawei.com>
> 
> This patch adds specific quirks for PCI config space accessors,
> it uses _HID to decide whether to hook pci_ops or not.

If I understand correctly, this would mean that it's not actually ECAM
compliant, then?

> Signed-off-by: Dongdong Liu <liudongdong3@huawei.com>
> Signed-off-by: Gabriele Paoloni <gabriele.paoloni@huawei.com>
> ---
>  MAINTAINERS                       |   1 +
>  drivers/pci/host/Kconfig          |   8 ++
>  drivers/pci/host/Makefile         |   1 +
>  drivers/pci/host/pcie-hisi-acpi.c | 188 ++++++++++++++++++++++++++++++++++++++
>  drivers/pci/host/pcie-hisi.c      |   2 -
>  drivers/pci/host/pcie-hisi.h      |   2 +
>  6 files changed, 200 insertions(+), 2 deletions(-)
>  create mode 100644 drivers/pci/host/pcie-hisi-acpi.c
> 
> diff --git a/MAINTAINERS b/MAINTAINERS
> index d69f436..f184c3e 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -8412,6 +8412,7 @@ F:	Documentation/devicetree/bindings/pci/hisilicon-pcie.txt
>  F:	drivers/pci/host/pcie-hisi.h
>  F:	drivers/pci/host/pcie-hisi.c
>  F:	drivers/pci/host/pcie-hisi-common.c
> +F:	drivers/pci/host/pcie-hisi-acpi.c
>  
>  PCIE DRIVER FOR QUALCOMM MSM
>  M:     Stanimir Varbanov <svarbanov@mm-sol.com>
> diff --git a/drivers/pci/host/Kconfig b/drivers/pci/host/Kconfig
> index 75a6054..65b1add 100644
> --- a/drivers/pci/host/Kconfig
> +++ b/drivers/pci/host/Kconfig
> @@ -181,6 +181,14 @@ config PCI_HISI
>  	  Say Y here if you want PCIe controller support on HiSilicon
>  	  Hip05 and Hip06 SoCs
>  
> +config PCI_HISI_ACPI
> +	depends on ACPI
> +	bool "HiSilicon Hip05 and Hip06 SoCs ACPI PCIe controllers"
> +	select ACPI_PCI_HOST_GENERIC
> +	help
> +	  Say Y here if you want ACPI PCIe controller support on HiSilicon
> +	  Hip05 and Hip06 SoCs
> +
>  config PCIE_QCOM
>  	bool "Qualcomm PCIe controller"
>  	depends on ARCH_QCOM && OF
> diff --git a/drivers/pci/host/Makefile b/drivers/pci/host/Makefile
> index 8c93c0f..57e4379 100644
> --- a/drivers/pci/host/Makefile
> +++ b/drivers/pci/host/Makefile
> @@ -21,4 +21,5 @@ obj-$(CONFIG_PCIE_IPROC_BCMA) += pcie-iproc-bcma.o
>  obj-$(CONFIG_PCIE_ALTERA) += pcie-altera.o
>  obj-$(CONFIG_PCIE_ALTERA_MSI) += pcie-altera-msi.o
>  obj-$(CONFIG_PCI_HISI) += pcie-hisi.o pcie-hisi-common.o
> +obj-$(CONFIG_PCI_HISI_ACPI) += pcie-hisi-acpi.o pcie-hisi-common.o
>  obj-$(CONFIG_PCIE_QCOM) += pcie-qcom.o
> diff --git a/drivers/pci/host/pcie-hisi-acpi.c b/drivers/pci/host/pcie-hisi-acpi.c
> new file mode 100644
> index 0000000..3605260
> --- /dev/null
> +++ b/drivers/pci/host/pcie-hisi-acpi.c
> @@ -0,0 +1,188 @@
> +/*
> + * PCIe host controller driver for HiSilicon HipXX SoCs
> + *
> + * Copyright (C) 2016 HiSilicon Co., Ltd. http://www.hisilicon.com
> + *
> + * Author: Dongdong Liu <liudongdong3@huawei.com>
> + *         Gabriele Paoloni <gabriele.paoloni@huawei.com>
> + *
> + * This program is free software; you can redistribute it and/or modify
> + * it under the terms of the GNU General Public License version 2 as
> + * published by the Free Software Foundation.
> + */
> +#include <linux/interrupt.h>
> +#include <linux/acpi.h>
> +#include <linux/ecam.h>
> +#include <linux/pci.h>
> +#include <linux/pci-acpi.h>
> +#include "pcie-hisi.h"
> +
> +#define GET_PCIE_LINK_STATUS  0x0
> +
> +/* uuid 6d30f553-836c-408e-b6ad-45bccc957949 */
> +const u8 hisi_pcie_acpi_dsm_uuid[] = {
> +	0x53, 0xf5, 0x30, 0x6d, 0x6c, 0x83, 0x8e, 0x40,
> +	0xb6, 0xad, 0x45, 0xbc, 0xcc, 0x95, 0x79, 0x49
> +};
> +
> +static const struct acpi_device_id hisi_pcie_ids[] = {
> +	{"HISI0080", 0},
> +	{"", 0},
> +};
> +
> +static int hisi_pcie_get_addr(struct acpi_pci_root *root, const char *name,
> +				void __iomem **addr)
> +{
> +	struct acpi_device *device;
> +	u64 base;
> +	u64 size;
> +	u32 buf[4];
> +	int ret;
> +
> +	device =  root->device;
> +	ret = fwnode_property_read_u32_array(&device->fwnode, name,
> +					buf, ARRAY_SIZE(buf));
> +	if (ret) {
> +		dev_err(&device->dev, "can't get %s\n", name);
> +		return ret;
> +	}
> +
> +	base = ((u64)buf[0] << 32) | buf[1];
> +	size =  ((u64)buf[2] << 32) | buf[3];
> +	*addr = devm_ioremap(&device->dev, base, size);
> +	if (!(*addr)) {
> +		dev_err(&device->dev, "error with ioremap\n");
> +		return -ENOMEM;
> +	}

This does not seem like the correct way of describing an addres in ACPI.

> +
> +	return 0;
> +}
> +
> +
> +static int hisi_pcie_link_up_acpi(struct acpi_pci_root *root)
> +{
> +	u32 val;
> +	struct acpi_device *device;
> +	union acpi_object *obj;
> +
> +	device = root->device;
> +	obj = acpi_evaluate_dsm(device->handle,
> +		hisi_pcie_acpi_dsm_uuid, 0,
> +		GET_PCIE_LINK_STATUS, NULL);
> +
> +	if (!obj  ||  obj->type != ACPI_TYPE_INTEGER)  {
> +		dev_err(&device->dev, "can't get link status from _DSM\n");
> +		return 0;
> +	}
> +	val = obj->integer.value;
> +
> +	return ((val & PCIE_LTSSM_STATE_MASK) == PCIE_LTSSM_LINKUP_STATE);
> +
> +}
> +
> +/*
> + * Retrieve rc_dbi base and size from _DSD
> + * Name (_DSD, Package () {
> + *	ToUUID("daffd814-6eba-4d8c-8a91-bc9bbf4aa301"),
> + *	Package () {
> + *	Package () {"rc-dbi", Package () { 0x0, 0xb0080000, 0x0, 0x10000 }},
> + *	}
> + *	})
> + */

As above, this does not look right. ACPI has standard mechanisms for
describing addresses. Making something up like this is not a good idea.

Mark.

