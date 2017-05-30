Return-Path: <linux-arm-kernel-bounces+bjorn=helgaas.com@lists.infradead.org>
Return-Path: <linux-arm-kernel-bounces+bjorn=helgaas.com@lists.infradead.org>
Date: Tue, 30 May 2017 14:24:08 +0100
From: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
To: Gabriele Paoloni <gabriele.paoloni@huawei.com>
Subject: Re: [PATCH v9 5/7] ACPI: Translate the I/O range of non-MMIO devices
 before scanning
Message-ID: <20170530132408.GA2556@red-moon>
References: <1495712248-5232-1-git-send-email-gabriele.paoloni@huawei.com>
 <1495712248-5232-6-git-send-email-gabriele.paoloni@huawei.com>
MIME-Version: 1.0
In-Reply-To: <1495712248-5232-6-git-send-email-gabriele.paoloni@huawei.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Cc: mark.rutland@arm.com, minyard@acm.org, linux-acpi@vger.kernel.org,
 arnd@arndb.de, rafael@kernel.org, linux-pci@vger.kernel.org,
 catalin.marinas@arm.com, john.garry@huawei.com, will.deacon@arm.com,
 linux-kernel@vger.kernel.org, xuwei5@hisilicon.com, linuxarm@huawei.com,
 olof@lixom.net, robh+dt@kernel.org, benh@kernel.crashing.org,
 bhelgaas@google.com, frowand.list@gmail.com, brian.starkey@arm.com,
 linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="us-ascii"
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+bjorn=helgaas.com@lists.infradead.org
List-ID: <linux-pci.vger.kernel.org>

Hi Gab,

On Thu, May 25, 2017 at 12:37:26PM +0100, Gabriele Paoloni wrote:
> From: Gabriele <gabriele.paoloni@huawei.com>
> 
> On some platforms(such as Hip06/Hip07), the legacy ISA/LPC devices access
> I/O with some special host-local I/O ports known on x86. As their I/O
> space are not memory mapped like PCI/PCIE MMIO host bridges, this patch is
> meant to support a new class of I/O host controllers where the local IO
> ports of the children devices are translated into the Indirect I/O address
> space.
> Through the handler attach callback, all the I/O translations are done
> before starting the enumeration on children devices and the translated
> addresses are replaced in the children resources.

I do not understand why this is done through a scan handler and to
be frank I do not see how this mechanism is supposed to be a generic
kernel layer, possibly used by other platforms, when there is no notion
in ACPI to cater for that.

As far as I am concerned this patch code should live in the Hisilicon
LPC driver - as things stand it is neither ACPI generic code nor ARM64
specific, it is code to make ACPI work like DT bindings without any ACPI
binding at all; I still have some concerns from an ACPI standpoint
below.

> Signed-off-by: zhichang.yuan <yuanzhichang@hisilicon.com>
> Signed-off-by: Gabriele Paoloni <gabriele.paoloni@huawei.com>
> ---
>  drivers/acpi/arm64/Makefile            |   1 +
>  drivers/acpi/arm64/acpi_indirect_pio.c | 301 +++++++++++++++++++++++++++++++++
>  drivers/acpi/internal.h                |   5 +
>  drivers/acpi/scan.c                    |   1 +
>  include/acpi/acpi_indirect_pio.h       |  24 +++
>  5 files changed, 332 insertions(+)
>  create mode 100644 drivers/acpi/arm64/acpi_indirect_pio.c
>  create mode 100644 include/acpi/acpi_indirect_pio.h
> 
> diff --git a/drivers/acpi/arm64/Makefile b/drivers/acpi/arm64/Makefile
> index 1017def..3944775 100644
> --- a/drivers/acpi/arm64/Makefile
> +++ b/drivers/acpi/arm64/Makefile
> @@ -1,2 +1,3 @@
>  obj-$(CONFIG_ACPI_IORT) 	+= iort.o
>  obj-$(CONFIG_ACPI_GTDT) 	+= gtdt.o
> +obj-$(CONFIG_INDIRECT_PIO) += acpi_indirect_pio.o
> diff --git a/drivers/acpi/arm64/acpi_indirect_pio.c b/drivers/acpi/arm64/acpi_indirect_pio.c
> new file mode 100644
> index 0000000..7813f73
> --- /dev/null
> +++ b/drivers/acpi/arm64/acpi_indirect_pio.c
> @@ -0,0 +1,301 @@
> +/*
> + * ACPI support for indirect-PIO bus.
> + *
> + * Copyright (C) 2017 Hisilicon Limited, All Rights Reserved.
> + * Author: Gabriele Paoloni <gabriele.paoloni@huawei.com>
> + * Author: Zhichang Yuan <yuanzhichang@hisilicon.com>
> + *
> + * This program is free software; you can redistribute it and/or modify
> + * it under the terms of the GNU General Public License version 2 as
> + * published by the Free Software Foundation.
> + */
> +
> +#include <linux/acpi.h>
> +#include <linux/platform_device.h>
> +#include <linux/logic_pio.h>
> +
> +#include <acpi/acpi_indirect_pio.h>
> +
> +ACPI_MODULE_NAME("indirect PIO");
> +
> +#define INDIRECT_PIO_INFO(desc) ((unsigned long)&desc)
> +
> +static acpi_status acpi_count_logic_iores(struct acpi_resource *res,
> +					   void *data)
> +{
> +	int *res_cnt = data;
> +
> +	if (!acpi_dev_filter_resource_type(res, IORESOURCE_IO))
> +		(*res_cnt)++;
> +
> +	return AE_OK;
> +}
> +
> +static acpi_status acpi_read_one_logicpiores(struct acpi_resource *res,
> +		void *data)
> +{
> +	struct acpi_resource **resource = data;
> +
> +	if (!acpi_dev_filter_resource_type(res, IORESOURCE_IO)) {
> +		memcpy((*resource), res, sizeof(struct acpi_resource));
> +		(*resource)->length = sizeof(struct acpi_resource);
> +		(*resource)->type = res->type;
> +		(*resource)++;
> +	}
> +
> +	return AE_OK;
> +}
> +
> +static acpi_status
> +acpi_build_logicpiores_template(struct acpi_device *adev,
> +			struct acpi_buffer *buffer)
> +{
> +	acpi_handle handle = adev->handle;
> +	struct acpi_resource *resource;
> +	acpi_status status;
> +	int res_cnt = 0;
> +
> +	status = acpi_walk_resources(handle, METHOD_NAME__CRS,
> +				     acpi_count_logic_iores, &res_cnt);
> +	if (ACPI_FAILURE(status)) {
> +		dev_err(&adev->dev, "can't evaluate _CRS: %d\n", status);
> +		return -EINVAL;
> +	}
> +
> +	if (!res_cnt) {
> +		dev_err(&adev->dev, "no logic IO resources\n");
> +		return -ENODEV;
> +	}
> +
> +	buffer->length = sizeof(struct acpi_resource) * (res_cnt + 1);
> +	buffer->pointer = kzalloc(buffer->length, GFP_KERNEL);
> +	if (!buffer->pointer)
> +		return -ENOMEM;
> +
> +	resource = (struct acpi_resource *)buffer->pointer;
> +	status = acpi_walk_resources(handle, METHOD_NAME__CRS,
> +				     acpi_read_one_logicpiores, &resource);
> +	if (ACPI_FAILURE(status)) {
> +		kfree(buffer->pointer);
> +		dev_err(&adev->dev, "can't evaluate _CRS: %d\n", status);
> +		return -EINVAL;
> +	}
> +
> +	resource->type = ACPI_RESOURCE_TYPE_END_TAG;
> +	resource->length = sizeof(struct acpi_resource);
> +
> +	return 0;
> +}

IIUC correctly this code is here to count resources and replace them
with kernel specific IO offsets and I think that's wrong. ACPI devices
_CRS,_PRS,_SRS are set-up by firmware and by no means should be updated
with resources that are basically Linux kernel internals specific.

The problem you are facing is there because there is no way in ACPI
to specify in FW what you want to describe but that's not a reason
to make it work by other means.

[...]

> + * update/set the current I/O resource of the designated device node.
> + * after this calling, the enumeration can be started as the I/O resource
> + * had been translated to logicial I/O from bus-local I/O.
> + *
> + * @adev: the device node to be updated the I/O resource;
> + * @host: the device node where 'adev' is attached, which can be not
> + *	the parent of 'adev';
> + *
> + * return 0 when successful, negative is for failure.
> + */
> +int acpi_set_logic_pio_resource(struct device *child,
> +		struct device *hostdev)
> +{
> +	struct acpi_device *adev;
> +	struct acpi_device *host;
> +	struct acpi_buffer buffer;
> +	acpi_status status;
> +	int ret;
> +
> +	if (!child || !hostdev)
> +		return -EINVAL;
> +
> +	host = to_acpi_device(hostdev);
> +	adev = to_acpi_device(child);
> +
> +	/* check the device state */
> +	if (!adev->status.present) {
> +		dev_info(child, "ACPI: device is not present!\n");
> +		return 0;
> +	}
> +	/* whether the child had been enumerated? */
> +	if (acpi_device_enumerated(adev)) {
> +		dev_info(child, "ACPI: had been enumerated!\n");
> +		return 0;
> +	}
> +
> +	/* read the _CRS and convert as acpi_buffer */
> +	status = acpi_build_logicpiores_template(adev, &buffer);
> +	if (ACPI_FAILURE(status)) {
> +		dev_warn(child, "Failure evaluating %s\n", METHOD_NAME__CRS);
> +		return -ENODEV;
> +	}
> +
> +	/* translate the I/O resources */
> +	ret = acpi_translate_logicpiores(adev, host, &buffer);
> +	if (ret) {
> +		kfree(buffer.pointer);
> +		dev_err(child, "Translate I/O range FAIL!\n");
> +		return ret;
> +	}
> +
> +	/* set current resource... */
> +	status = acpi_set_current_resources(adev->handle, &buffer);

I reckon that this is wrong. You are updating ACPI device resources with
kernel specific built resources (ie IO space offsets) made by slicing up
IO space into the kernel available virtual address space offset
allocated to it.

IIUC this is done to make sure platform devices contains the
"translated" resources by the time they are probed, it is hard
to follow and again, not correct from an ACPI standpoint.

Furthermore I have no idea how this code is supposed to be used by
_any_ other platform, ACPI just has no notion of the translation you
are carrying out here (which mirrors what's done in DT without any
firmware binding to support it) so even if any other platform has
the same requirements I have no idea how people developing FW may
write their bindings to match these given that they just don't exist.

> +	kfree(buffer.pointer);
> +	if (ACPI_FAILURE(status)) {
> +		dev_err(child, "Error evaluating _SRS (0x%x)\n", status);
> +		ret = -EIO;
> +	}
> +
> +	return ret;
> +}
> +
> +/* All the host devices which apply indirect-PIO can be listed here. */
> +static const struct acpi_device_id acpi_indirect_host_id[] = {
> +	{""},

How can this be used by any other platform other than Hisilicon LPC ?

Imagine for a minute you have an ARM64 platform with an LPC bus in it
and you have to write ACPI tables to describe it, you may not want
to start by reading Linux kernel code to understand how to do it.

This code is Hisilicon specific code (ie there is no ACPI binding to
the best of my knowledge describing to FW developers an LPC binding)
and on the ACPI side it makes assumptions that I am not sure are
correct at all, see above.

> +};
> +
> +static int acpi_indirectpio_attach(struct acpi_device *adev,
> +				const struct acpi_device_id *id)
> +{
> +	struct indirect_pio_device_desc *hostdata;
> +	struct platform_device *pdev;
> +	int ret;
> +
> +	hostdata = (struct indirect_pio_device_desc *)id->driver_data;
> +	if (!hostdata || !hostdata->pre_setup)
> +		return -EINVAL;
> +
> +	ret = hostdata->pre_setup(adev, hostdata->pdata);
> +	if (!ret) {
> +		pdev = acpi_create_platform_device(adev, NULL);

So, this is done through a scan handler for what reason ? Is this
because you want this code to run before platform devices are created
by ACPI core - so that you can update their resources in the

struct indirect_pio_device_desc.pre_setup() method ?

I suspect this is yet another probing order issue to solve but that's
orthogonal to the comments I made above.

To sum it up:

(1) Creating an ARM64 ACPI standard kernel layer to parse something that is
    not an ACPI (let alone ARM64) standard does not make much sense to me,
    so either standard bindings are published for other partners to use
    them or this code belongs to Hisilicon specific LPC bus management
(2) Even with (1), I have concerns about this patch ACPI resources
    handling, I really think it is wrong to update ACPI devices
    resources with something that is Linux kernel specific. I may
    understand building platform devices resources according to your
    LPC bus requirements but not updating ACPI device FW bindings with
    resources that are basically kernel internals.

Thanks,
Lorenzo

> +		if (IS_ERR_OR_NULL(pdev)) {
> +			dev_err(&adev->dev, "Create platform device for host FAIL!\n");
> +			return -EFAULT;
> +		}
> +		acpi_device_set_enumerated(adev);
> +		ret = 1;
> +	}
> +
> +	return ret;
> +}
> +
> +
> +static struct acpi_scan_handler acpi_indirect_handler = {
> +	.ids = acpi_indirect_host_id,
> +	.attach = acpi_indirectpio_attach,
> +};
> +
> +void __init acpi_indirectio_scan_init(void)
> +{
> +	acpi_scan_add_handler(&acpi_indirect_handler);
> +}
> diff --git a/drivers/acpi/internal.h b/drivers/acpi/internal.h
> index 66229ff..bf8aaf8 100644
> --- a/drivers/acpi/internal.h
> +++ b/drivers/acpi/internal.h
> @@ -31,6 +31,11 @@ void acpi_processor_init(void);
>  void acpi_platform_init(void);
>  void acpi_pnp_init(void);
>  void acpi_int340x_thermal_init(void);
> +#ifdef CONFIG_INDIRECT_PIO
> +void acpi_indirectio_scan_init(void);
> +#else
> +static inline void acpi_indirectio_scan_init(void) {}
> +#endif
>  #ifdef CONFIG_ARM_AMBA
>  void acpi_amba_init(void);
>  #else
> diff --git a/drivers/acpi/scan.c b/drivers/acpi/scan.c
> index e39ec7b..37dd23c 100644
> --- a/drivers/acpi/scan.c
> +++ b/drivers/acpi/scan.c
> @@ -2035,6 +2035,7 @@ int __init acpi_scan_init(void)
>  	acpi_int340x_thermal_init();
>  	acpi_amba_init();
>  	acpi_watchdog_init();
> +	acpi_indirectio_scan_init();
>  
>  	acpi_scan_add_handler(&generic_device_handler);
>  
> diff --git a/include/acpi/acpi_indirect_pio.h b/include/acpi/acpi_indirect_pio.h
> new file mode 100644
> index 0000000..efc5c43
> --- /dev/null
> +++ b/include/acpi/acpi_indirect_pio.h
> @@ -0,0 +1,24 @@
> +/*
> + * ACPI support for indirect-PIO bus.
> + *
> + * Copyright (C) 2017 Hisilicon Limited, All Rights Reserved.
> + * Author: Gabriele Paoloni <gabriele.paoloni@huawei.com>
> + * Author: Zhichang Yuan <yuanzhichang@hisilicon.com>
> + *
> + * This program is free software; you can redistribute it and/or modify
> + * it under the terms of the GNU General Public License version 2 as
> + * published by the Free Software Foundation.
> + */
> +
> +#ifndef _ACPI_INDIRECT_PIO_H
> +#define _ACPI_INDIRECT_PIO_H
> +
> +struct indirect_pio_device_desc {
> +	void *pdata; /* device relevant info data */
> +	int (*pre_setup)(struct acpi_device *adev, void *pdata);
> +};
> +
> +int acpi_set_logic_pio_resource(struct device *child,
> +		struct device *hostdev);
> +
> +#endif
> -- 
> 2.7.4
> 
> 

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
