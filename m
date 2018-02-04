Return-Path: <linux-acpi-owner@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <1516725385-24535-8-git-send-email-john.garry@huawei.com>
References: <1516725385-24535-1-git-send-email-john.garry@huawei.com> <1516725385-24535-8-git-send-email-john.garry@huawei.com>
From: "Rafael J. Wysocki" <rafael@kernel.org>
Date: Sun, 4 Feb 2018 08:45:37 +0100
Message-ID: <CAJZ5v0ghc1sthrMBobSXfNrxoKrjbie9qnKYnLdxnpLfZPzs8w@mail.gmail.com>
Subject: Re: [PATCH v12 7/9] ACPI: Translate the I/O range of non-MMIO devices
 before scanning
To: John Garry <john.garry@huawei.com>
Cc: Mika Westerberg <mika.westerberg@linux.intel.com>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Rob Herring <robh+dt@kernel.org>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Mark Rutland <mark.rutland@arm.com>,
        Olof Johansson <olof@lixom.net>,
        Hanjun Guo <hanjun.guo@linaro.org>, dann.frazier@canonical.com,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        ACPI Devel Maling List <linux-acpi@vger.kernel.org>,
        Linuxarm <linuxarm@huawei.com>,
        Linux PCI <linux-pci@vger.kernel.org>,
        Corey Minyard <minyard@acm.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        linux-arch <linux-arch@vger.kernel.org>,
        Randy Dunlap <rdunlap@infradead.org>,
        Zhichang Yuan <yuanzhichang@hisilicon.com>,
        Gabriele Paoloni <gabriele.paoloni@huawei.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-acpi-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Tue, Jan 23, 2018 at 5:36 PM, John Garry <john.garry@huawei.com> wrote:
> On some platforms(such as Hip06/Hip07), the legacy ISA/LPC devices access
> I/O with some special host-local I/O ports known on x86. As their I/O space
> are not memory mapped like PCI/PCIE MMIO host bridges, this patch is meant
> to support a new class of I/O host controllers where the local IO ports of
> the children devices are translated into the Indirect I/O address space.
>
> Through the handler attach callback, all the I/O translations are done
> before starting the enumeration on children devices and the translated
> addresses are replaced in the children resources.

The changelog is somewhat dry for a patch adding over 300 lines of new
code and a new file for that matter.

> Signed-off-by: John Garry <john.garry@huawei.com>
> Signed-off-by: Zhichang Yuan <yuanzhichang@hisilicon.com>
> Signed-off-by: Gabriele Paoloni <gabriele.paoloni@huawei.com>
> ---
>  drivers/acpi/arm64/Makefile          |   1 +
>  drivers/acpi/arm64/acpi_indirectio.c | 273 +++++++++++++++++++++++++++++++++++
>  drivers/acpi/internal.h              |   5 +
>  drivers/acpi/scan.c                  |   1 +
>  4 files changed, 280 insertions(+)
>  create mode 100644 drivers/acpi/arm64/acpi_indirectio.c
>
> diff --git a/drivers/acpi/arm64/Makefile b/drivers/acpi/arm64/Makefile
> index 1017def..f4a7f46 100644
> --- a/drivers/acpi/arm64/Makefile
> +++ b/drivers/acpi/arm64/Makefile
> @@ -1,2 +1,3 @@
>  obj-$(CONFIG_ACPI_IORT)        += iort.o
>  obj-$(CONFIG_ACPI_GTDT)        += gtdt.o
> +obj-$(CONFIG_INDIRECT_PIO)     += acpi_indirectio.o
> diff --git a/drivers/acpi/arm64/acpi_indirectio.c b/drivers/acpi/arm64/acpi_indirectio.c
> new file mode 100644
> index 0000000..2649f57
> --- /dev/null
> +++ b/drivers/acpi/arm64/acpi_indirectio.c
> @@ -0,0 +1,273 @@

SPDX license identifier here?

> +/*
> + * ACPI support for indirect-IO bus.
> + *
> + * Copyright (C) 2017 HiSilicon Limited, All Rights Reserved.
> + * Author: Gabriele Paoloni <gabriele.paoloni@huawei.com>
> + * Author: Zhichang Yuan <yuanzhichang@hisilicon.com>
> + * Author: John Garry <john.garry@huawei.com>
> + *
> + * This program is free software; you can redistribute it and/or modify
> + * it under the terms of the GNU General Public License version 2 as
> + * published by the Free Software Foundation.

And then you can skip the above.

Also I would like to see some description of what's there in this file
to appear here.

> + */
> +
> +#include <linux/acpi.h>
> +#include <linux/logic_pio.h>
> +#include <linux/mfd/core.h>
> +#include <linux/platform_device.h>
> +
> +ACPI_MODULE_NAME("indirect IO");
> +
> +#define ACPI_INDIRECTIO_NAME_LENGTH 255
> +
> +#define INDIRECT_IO_INFO(desc) ((unsigned long)&desc)
> +
> +struct acpi_indirectio_mfd_cell {
> +       struct mfd_cell_acpi_match acpi_match;
> +       char name[ACPI_INDIRECTIO_NAME_LENGTH];
> +       char pnpid[ACPI_INDIRECTIO_NAME_LENGTH];
> +};
> +
> +struct acpi_indirectio_host_data {
> +       resource_size_t io_size;
> +       resource_size_t io_start;
> +};
> +
> +struct acpi_indirectio_device_desc {

Why don't you use a consistent naming convention and call this
acpi_indirect_io_device_desc (and analogously everywhere above and
below)?

> +       struct acpi_indirectio_host_data pdata; /* device relevant info data */
> +       int (*pre_setup)(struct acpi_device *adev,
> +                        struct acpi_indirectio_host_data *pdata);
> +};
> +
> +static int acpi_translate_logicio_res(struct acpi_device *adev,
> +               struct acpi_device *host, struct resource *resource)
> +{
> +       unsigned long sys_port;
> +       struct device *dev = &adev->dev;
> +       resource_size_t length = resource->end - resource->start;
> +
> +       sys_port = logic_pio_trans_hwaddr(&host->fwnode, resource->start,
> +                                       length);
> +
> +       if (sys_port == -1) {

Would if (sysp_port < 0) not work here?

> +               dev_err(dev, "translate bus-addr(0x%llx) fail!\n",
> +                       resource->start);

That's not a very informative message.  What are users expected to do
in response to seeing it?

> +               return -EFAULT;
> +       }
> +
> +       resource->start = sys_port;
> +       resource->end = sys_port + length;
> +
> +       return 0;
> +}
> +
> +/*
> + * update/set the current I/O resource of the designated device node.
> + * after this calling, the enumeration can be started as the I/O resource
> + * had been translated to logicial I/O from bus-local I/O.
> + *
> + * @child: the device node to be updated the I/O resource;
> + * @hostdev: the device node where 'adev' is attached, which can be not
> + *  the parent of 'adev';
> + * @res: double pointer to be set to the address of the updated resources
> + * @num_res: address of the variable to contain the number of updated resources
> + *
> + * return 0 when successful, negative is for failure.
> + */

The above should be a proper kerneldoc comment.

> +int acpi_indirectio_set_logicio_res(struct device *child,
> +                                        struct device *hostdev,
> +                                        const struct resource **res,
> +                                        int *num_res)
> +{
> +       struct acpi_device *adev;
> +       struct acpi_device *host;
> +       struct resource_entry *rentry;
> +       LIST_HEAD(resource_list);
> +       struct resource *resources = NULL;
> +       int count;
> +       int i;
> +       int ret = -EIO;
> +
> +       if (!child || !hostdev)
> +               return -EINVAL;
> +
> +       host = to_acpi_device(hostdev);
> +       adev = to_acpi_device(child);
> +
> +       /* check the device state */
> +       if (!adev->status.present) {
> +               dev_info(child, "ACPI: device is not present!\n");
> +               return 0;
> +       }
> +       /* whether the child had been enumerated? */
> +       if (acpi_device_enumerated(adev)) {
> +               dev_info(child, "ACPI: had been enumerated!\n");
> +               return 0;
> +       }
> +
> +       count = acpi_dev_get_resources(adev, &resource_list, NULL, NULL);
> +       if (count <= 0) {
> +               dev_err(&adev->dev, "failed to get ACPI resources\n");
> +               return count ? count : -EIO;
> +       }
> +
> +       resources = kcalloc(count, sizeof(struct resource), GFP_KERNEL);
> +       if (!resources) {
> +               acpi_dev_free_resource_list(&resource_list);
> +               return -ENOMEM;
> +       }
> +       count = 0;
> +       list_for_each_entry(rentry, &resource_list, node)
> +               resources[count++] = *rentry->res;
> +
> +       acpi_dev_free_resource_list(&resource_list);
> +
> +       /* translate the I/O resources */
> +       for (i = 0; i < count; i++) {
> +               if (resources[i].flags & IORESOURCE_IO) {
> +                       ret = acpi_translate_logicio_res(adev, host,
> +                                                       &resources[i]);

You don't need to break this line as far as I'm concerned.

> +                       if (ret) {
> +                               kfree(resources);
> +                               dev_err(child,
> +                                       "Translate I/O range failed (%d)!\n",
> +                                       ret);

And this too.

> +                               return ret;
> +                       }
> +               }
> +       }
> +       *res = resources;
> +       *num_res = count;
> +
> +       return ret;
> +}
> +
> +int

Don't break the line here, please.

> +acpi_indirectio_pre_setup(struct acpi_device *adev,
> +                         struct acpi_indirectio_host_data *pdata)

As a non-static function, this requires a kerneldoc comment.

In particular, the comment should describe who and when is expected to
call this function (and which also applies to the comment preceding
the previous function).

Apparently, they both need to be called before the initial namespace
scan for the acpi_indirectio_attach() below to work, right?

> +{
> +       struct platform_device *pdev;
> +       struct mfd_cell *mfd_cells;
> +       struct logic_pio_hwaddr *range;
> +       struct acpi_device *child;
> +       struct acpi_indirectio_mfd_cell *acpi_indirectio_mfd_cells;
> +       int size, ret, count = 0, cell_num = 0;
> +
> +       range = kzalloc(sizeof(*range), GFP_KERNEL);
> +       if (!range)
> +               return -ENOMEM;
> +       range->fwnode = &adev->fwnode;
> +       range->flags = PIO_INDIRECT;
> +       range->size = pdata->io_size;
> +       range->hw_start = pdata->io_start;
> +
> +       ret = logic_pio_register_range(range);
> +       if (ret)
> +               goto free_range;
> +
> +       list_for_each_entry(child, &adev->children, node)
> +               cell_num++;
> +
> +       /* allocate the mfd cells */
> +       size = sizeof(*mfd_cells) + sizeof(*acpi_indirectio_mfd_cells);
> +       mfd_cells = kcalloc(cell_num, size, GFP_KERNEL);
> +       if (!mfd_cells) {
> +               ret = -ENOMEM;
> +               goto free_range;
> +       }
> +
> +       acpi_indirectio_mfd_cells = (struct acpi_indirectio_mfd_cell *)
> +                                       &mfd_cells[cell_num];
> +       /* Only consider the children of the host */
> +       list_for_each_entry(child, &adev->children, node) {
> +               struct mfd_cell *mfd_cell = &mfd_cells[count];
> +               struct acpi_indirectio_mfd_cell *acpi_indirectio_mfd_cell =
> +                                       &acpi_indirectio_mfd_cells[count];
> +               const struct mfd_cell_acpi_match *acpi_match =
> +                                       &acpi_indirectio_mfd_cell->acpi_match;
> +               char *name = &acpi_indirectio_mfd_cell[count].name[0];
> +               char *pnpid = &acpi_indirectio_mfd_cell[count].pnpid[0];
> +               struct mfd_cell_acpi_match match = {
> +                               .pnpid = pnpid,
> +               };
> +
> +               snprintf(name, ACPI_INDIRECTIO_NAME_LENGTH, "indirect-io-%s",
> +                        acpi_device_hid(child));
> +               snprintf(pnpid, ACPI_INDIRECTIO_NAME_LENGTH, "%s",
> +                        acpi_device_hid(child));
> +
> +               memcpy((void *)acpi_match, (void *)&match, sizeof(*acpi_match));
> +               mfd_cell->name = name;
> +               mfd_cell->acpi_match = acpi_match;
> +
> +               ret =
> +               acpi_indirectio_set_logicio_res(&child->dev,
> +                                               &adev->dev,
> +                                               &mfd_cell->resources,
> +                                               &mfd_cell->num_resources);
> +               if (ret) {
> +                       dev_err(&child->dev, "set resource failed (%d)\n", ret);
> +                       goto free_mfd_res;
> +               }
> +               count++;
> +       }
> +
> +       pdev = acpi_create_platform_device(adev, NULL);
> +       if (IS_ERR_OR_NULL(pdev)) {
> +               dev_err(&adev->dev, "Create platform device for host failed!\n");
> +               ret = PTR_ERR(pdev);
> +               goto free_mfd_res;
> +       }
> +       acpi_device_set_enumerated(adev);
> +
> +       ret = mfd_add_devices(&pdev->dev, PLATFORM_DEVID_NONE,
> +                       mfd_cells, cell_num, NULL, 0, NULL);
> +       if (ret) {
> +               dev_err(&pdev->dev, "failed to add mfd cells (%d)\n", ret);
> +               goto free_mfd_res;
> +       }
> +
> +       return ret;
> +
> +free_mfd_res:
> +       while (cell_num--)
> +               kfree(mfd_cells[cell_num].resources);
> +       kfree(mfd_cells);
> +free_range:
> +       kfree(range);
> +
> +       return ret;
> +}
> +
> +/* All the host devices which apply indirect-IO can be listed here. */
> +static const struct acpi_device_id acpi_indirect_host_id[] = {
> +       {""},
> +};
> +
> +static int acpi_indirectio_attach(struct acpi_device *adev,
> +                               const struct acpi_device_id *id)
> +{
> +       struct acpi_indirectio_device_desc *hostdata;
> +       int ret;
> +
> +       hostdata = (struct acpi_indirectio_device_desc *)id->driver_data;
> +       if (!hostdata || !hostdata->pre_setup)
> +               return -EINVAL;
> +
> +       ret = hostdata->pre_setup(adev, &hostdata->pdata);
> +
> +       if (ret < 0)
> +               return ret;
> +
> +       return 1;
> +}
> +
> +static struct acpi_scan_handler acpi_indirect_handler = {

acpi_indirect_io_handler?

> +       .ids = acpi_indirect_host_id,
> +       .attach = acpi_indirectio_attach,
> +};
> +
> +void __init acpi_indirectio_scan_init(void)
> +{
> +       acpi_scan_add_handler(&acpi_indirect_handler);
> +}
> diff --git a/drivers/acpi/internal.h b/drivers/acpi/internal.h
> index 1d0a501..d6b1a95 100644
> --- a/drivers/acpi/internal.h
> +++ b/drivers/acpi/internal.h
> @@ -31,6 +31,11 @@
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
> index b0fe527..8ea6f69 100644
> --- a/drivers/acpi/scan.c
> +++ b/drivers/acpi/scan.c
> @@ -2141,6 +2141,7 @@ int __init acpi_scan_init(void)
>         acpi_amba_init();
>         acpi_watchdog_init();
>         acpi_init_lpit();
> +       acpi_indirectio_scan_init();
>
>         acpi_scan_add_handler(&generic_device_handler);
>
> --
> 1.9.1
>
