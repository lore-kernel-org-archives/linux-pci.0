Return-Path: <linux-arm-kernel-bounces+bjorn=helgaas.com@lists.infradead.org>
Return-Path: <linux-arm-kernel-bounces+bjorn=helgaas.com@lists.infradead.org>
MIME-Version: 1.0
In-Reply-To: <1490887619-61732-6-git-send-email-yuanzhichang@hisilicon.com>
References: <1490887619-61732-1-git-send-email-yuanzhichang@hisilicon.com>
 <1490887619-61732-6-git-send-email-yuanzhichang@hisilicon.com>
From: dann frazier <dann.frazier@canonical.com>
Date: Thu, 20 Apr 2017 14:57:52 -0600
Message-ID: <CALdTtnuO=592n+PoR_kkdTyeFYRd90VyPf0JLwnEo7DtXwzoPA@mail.gmail.com>
Subject: Re: [PATCH V8 5/6] ACPI: Support the probing on the devices which
 apply indirect-IO
To: "zhichang.yuan" <yuanzhichang@hisilicon.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Cc: Mark Rutland <mark.rutland@arm.com>, benh@kernel.crashing.org,
 Gabriele Paoloni <gabriele.paoloni@huawei.com>, rafael@kernel.org,
 linux-pci@vger.kernel.org, Will Deacon <will.deacon@arm.com>,
 linuxarm@huawei.com, Frank Rowand <frowand.list@gmail.com>,
 lorenzo.pieralisi@arm.com, Arnd Bergmann <arnd@arndb.de>, xuwei5@hisilicon.com,
 linux-acpi@vger.kernel.org, Catalin Marinas <catalin.marinas@arm.com>,
 "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
 Corey Minyard <minyard@acm.org>, John Garry <john.garry@huawei.com>,
 Zou Rongrong <zourongrong@gmail.com>, Rob Herring <robh+dt@kernel.org>,
 Bjorn Helgaas <bhelgaas@google.com>, kantyzc@163.com,
 "zhichang.yuan" <zhichang.yuan02@gmail.com>,
 linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
 Seth Forshee <seth.forshee@canonical.com>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, olof@lixom.net,
 Brian Starkey <brian.starkey@arm.com>
Content-Type: text/plain; charset="us-ascii"
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+bjorn=helgaas.com@lists.infradead.org
List-ID: <linux-pci.vger.kernel.org>

On Thu, Mar 30, 2017 at 9:26 AM, zhichang.yuan
<yuanzhichang@hisilicon.com> wrote:
> On some platforms(such as Hip06/Hip07), the legacy ISA/LPC devices access I/O
> with some special host-local I/O ports known on x86. To access the I/O
> peripherals, an indirect-IO mechanism is introduced to mapped the host-local
> I/O to system logical/fake PIO similar the PCI MMIO on architectures where no
> separate I/O space exists. Just as PCI MMIO, the host I/O range should be
> registered before probing the downstream devices and set up the I/O mapping.
> But current ACPI bus probing doesn't support these indirect-IO hosts/devices.
>
> This patch introdueces a new ACPI handler for this device category. Through the
> handler attach callback, the indirect-IO hosts I/O registration is done and
> all peripherals' I/O resources are translated into logic/fake PIO before
> starting the enumeration.
>
> Signed-off-by: zhichang.yuan <yuanzhichang@hisilicon.com>
> Signed-off-by: Gabriele Paoloni <gabriele.paoloni@huawei.com>
> ---
>  drivers/acpi/Makefile          |   1 +
>  drivers/acpi/acpi_indirectio.c | 344 +++++++++++++++++++++++++++++++++++++++++
>  drivers/acpi/internal.h        |   5 +
>  drivers/acpi/scan.c            |   1 +
>  4 files changed, 351 insertions(+)
>  create mode 100644 drivers/acpi/acpi_indirectio.c
>
> diff --git a/drivers/acpi/Makefile b/drivers/acpi/Makefile
> index a391bbc..10e5f2b 100644
> --- a/drivers/acpi/Makefile
> +++ b/drivers/acpi/Makefile
> @@ -57,6 +57,7 @@ acpi-$(CONFIG_ACPI_PROCFS_POWER) += cm_sbs.o
>  acpi-y                         += acpi_lpat.o
>  acpi-$(CONFIG_ACPI_GENERIC_GSI) += irq.o
>  acpi-$(CONFIG_ACPI_WATCHDOG)   += acpi_watchdog.o
> +acpi-$(CONFIG_INDIRECT_PIO)    += acpi_indirectio.o
>
>  # These are (potentially) separate modules
>
> diff --git a/drivers/acpi/acpi_indirectio.c b/drivers/acpi/acpi_indirectio.c
> new file mode 100644
> index 0000000..c8c80b5
> --- /dev/null
> +++ b/drivers/acpi/acpi_indirectio.c
> @@ -0,0 +1,344 @@
> +/*
> + * ACPI support for indirect-IO bus.
> + *
> + * Copyright (C) 2017 Hisilicon Limited, All Rights Reserved.
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
> +#include "internal.h"
> +
> +ACPI_MODULE_NAME("indirect IO");
> +
> +#define INDIRECT_IO_INFO(desc) ((unsigned long)&desc)
> +
> +struct lpc_private_data {
> +       resource_size_t io_size;
> +       resource_size_t io_start;
> +};
> +
> +struct indirectio_device_desc {
> +       void *pdata; /* device relevant info data */
> +       int (*pre_setup)(struct acpi_device *adev, void *pdata);
> +};
> +
> +static struct lpc_private_data lpc_data = {
> +       .io_size = LPC_BUS_IO_SIZE,
> +       .io_start = LPC_MIN_BUS_RANGE,
> +};
> +
> +static inline bool acpi_logicio_supported_resource(struct acpi_resource *res)
> +{
> +       switch (res->type) {
> +       case ACPI_RESOURCE_TYPE_ADDRESS32:
> +       case ACPI_RESOURCE_TYPE_ADDRESS64:
> +               return true;
> +       }
> +       return false;
> +}
> +
> +static acpi_status acpi_count_logiciores(struct acpi_resource *res,
> +                                          void *data)
> +{
> +       int *res_cnt = data;
> +
> +       if (acpi_logicio_supported_resource(res) &&
> +               !acpi_dev_filter_resource_type(res, IORESOURCE_IO))
> +               (*res_cnt)++;
> +
> +       return AE_OK;
> +}
> +
> +static acpi_status acpi_read_one_logiciores(struct acpi_resource *res,
> +               void *data)
> +{
> +       struct acpi_resource **resource = data;
> +
> +       if (acpi_logicio_supported_resource(res) &&
> +               !acpi_dev_filter_resource_type(res, IORESOURCE_IO)) {
> +               memcpy((*resource), res, sizeof(struct acpi_resource));
> +               (*resource)->length = sizeof(struct acpi_resource);
> +               (*resource)->type = res->type;
> +               (*resource)++;
> +       }
> +
> +       return AE_OK;
> +}
> +
> +static acpi_status
> +acpi_build_logiciores_template(struct acpi_device *adev,
> +                       struct acpi_buffer *buffer)
> +{
> +       acpi_handle handle = adev->handle;
> +       struct acpi_resource *resource;
> +       acpi_status status;
> +       int res_cnt = 0;
> +
> +       status = acpi_walk_resources(handle, METHOD_NAME__CRS,
> +                                    acpi_count_logiciores, &res_cnt);
> +       if (ACPI_FAILURE(status) || !res_cnt) {
> +               dev_err(&adev->dev, "can't evaluate _CRS: %d\n", status);
> +               return -EINVAL;
> +       }
> +
> +       buffer->length = sizeof(struct acpi_resource) * (res_cnt + 1) + 1;
> +       buffer->pointer = kzalloc(buffer->length - 1, GFP_KERNEL);

(Seth Forshee noticed this issue, just passing it on)

Should this just allocate the full buffer->length? That would keep the
length attribute accurate (possibly avoiding an off-by-1 error later).
It's not clear what the trailing byte is needed for, but other drivers
allocate it as well (drivers/acpi/pci_link.c and
drivers/platform/x86/sony-laptop.c).

 -dann

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
