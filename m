Return-Path: <linux-acpi-owner@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <1518543933-22456-8-git-send-email-john.garry@huawei.com>
References: <1518543933-22456-1-git-send-email-john.garry@huawei.com> <1518543933-22456-8-git-send-email-john.garry@huawei.com>
From: "Rafael J. Wysocki" <rafael@kernel.org>
Date: Wed, 14 Feb 2018 10:21:10 +0100
Message-ID: <CAJZ5v0hZ8eUstCaOo4bth1LonM+_RqZ0pSi5U1E2pLfA_eNCiA@mail.gmail.com>
Subject: Re: [PATCH v13 7/9] ACPI: Translate the I/O range of non-MMIO devices
 before scanning
To: John Garry <john.garry@huawei.com>
Cc: Mika Westerberg <mika.westerberg@linux.intel.com>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Hanjun Guo <hanjun.guo@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Mark Rutland <mark.rutland@arm.com>,
        Olof Johansson <olof@lixom.net>,
        Dann Frazier <dann.frazier@canonical.com>,
        Andy Shevchenko <andy.shevchenko@gmail.com>,
        Rob Herring <robh@kernel.org>, Joe Perches <joe@perches.com>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Linux PCI <linux-pci@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        ACPI Devel Maling List <linux-acpi@vger.kernel.org>,
        Linuxarm <linuxarm@huawei.com>, Corey Minyard <minyard@acm.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        linux-arch <linux-arch@vger.kernel.org>,
        Randy Dunlap <rdunlap@infradead.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-acpi-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Tue, Feb 13, 2018 at 6:45 PM, John Garry <john.garry@huawei.com> wrote:
> On some platforms (such as arm64-based hip06/hip07), access to legacy
> ISA/LPC devices through access IO space is required, similar to x86
> platforms. As the I/O for these devices are not memory mapped like
> PCI/PCIE MMIO host bridges, they require special low-level device
> operations through some host to generate IO accesses, i.e. a non-
> transparent bridge.
>
> Through the logical PIO framework, hosts are able to register address
> ranges in the logical PIO space for IO accesses. For hosts which require
> a LLDD to generate the IO accesses, through the logical PIO framework
> the host also registers accessors as a backend to generate the physical
> bus transactions for IO space accesses (called indirect IO).
>
> When describing the indirect IO child device in APCI tables, the IO
> resource is the host-specific address for the child (generally a
> bus address).
> An example is as follows:
>   Device (LPC0) {
>     Name (_HID, "HISI0191")  // HiSi LPC
>     Name (_CRS, ResourceTemplate () {
>       Memory32Fixed (ReadWrite, 0xa01b0000, 0x1000)
>     })
>   }
>
>   Device (LPC0.IPMI) {
>     Name (_HID, "IPI0001")
>     Name (LORS, ResourceTemplate() {
>       QWordIO (
>         ResourceConsumer,
>         MinNotFixed,     // _MIF
>         MaxNotFixed,     // _MAF
>         PosDecode,
>         EntireRange,
>         0x0,             // _GRA
>         0xe4,            // _MIN
>         0x3fff,          // _MAX
>         0x0,             // _TRA
>         0x04,            // _LEN
>         , ,
>         BTIO
>       )
>     })
>
> Since the IO resource for the child is a host-specific address,
> special translation are required to retrieve the logical PIO address
> for that child.
>
> To overcome the problem of associating this logical PIO address
> with the child device, a scan handler is added to scan the ACPI
> namespace for known indirect IO hosts. This scan handler creates an
> MFD per child with the translated logical PIO address as it's IO
> resource, as a substitute for the normal platform device which ACPI
> would create during device enumeration.
>
> Signed-off-by: John Garry <john.garry@huawei.com>
> Signed-off-by: Zhichang Yuan <yuanzhichang@hisilicon.com>
> Signed-off-by: Gabriele Paoloni <gabriele.paoloni@huawei.com>

Just a few minor nits below.

> ---
>  drivers/acpi/arm64/Makefile          |   1 +
>  drivers/acpi/arm64/acpi_indirectio.c | 250 +++++++++++++++++++++++++++++++++++
>  drivers/acpi/internal.h              |   5 +
>  drivers/acpi/scan.c                  |   1 +
>  4 files changed, 257 insertions(+)
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
> index 0000000..51a1b92
> --- /dev/null
> +++ b/drivers/acpi/arm64/acpi_indirectio.c
> @@ -0,0 +1,250 @@
> +// SPDX-License-Identifier: GPL-2.0+
> +/*
> + * Copyright (C) 2017 HiSilicon Limited, All Rights Reserved.
> + * Author: Gabriele Paoloni <gabriele.paoloni@huawei.com>
> + * Author: Zhichang Yuan <yuanzhichang@hisilicon.com>
> + * Author: John Garry <john.garry@huawei.com>
> + *
> + * This file implements functunality to scan the ACPI namespace and config
> + * devices under "indirect IO" hosts. An "indirect IO" host allows child
> + * devices to use logical IO accesses when the host, itself, does not provide
> + * a transparent bridge. The device setup creates a per-child MFD with a
> + * logical port IO resource.
> + */
> +
> +#include <linux/acpi.h>
> +#include <linux/logic_pio.h>
> +#include <linux/mfd/core.h>
> +#include <linux/platform_device.h>
> +
> +ACPI_MODULE_NAME("indirect IO");
> +
> +#define ACPI_INDIRECT_IO_NAME_LEN 255
> +
> +struct acpi_indirect_io_mfd_cell {
> +       struct mfd_cell_acpi_match acpi_match;
> +       char name[ACPI_INDIRECT_IO_NAME_LEN];
> +       char pnpid[ACPI_INDIRECT_IO_NAME_LEN];
> +};
> +
> +static int acpi_indirect_io_xlat_res(struct acpi_device *adev,
> +                                    struct acpi_device *host,
> +                                    struct resource *res)
> +{
> +       unsigned long sys_port;
> +       resource_size_t len = res->end - res->start;
> +
> +       sys_port = logic_pio_trans_hwaddr(&host->fwnode, res->start, len);
> +       if (sys_port == -1UL)
> +               return -EFAULT;
> +
> +       res->start = sys_port;
> +       res->end = sys_port + len;
> +
> +       return 0;
> +}
> +
> +/*
> + * acpi_indirect_io_set_res - set the resources for a child device
> + * (MFD) of an "indirect IO" host.

The above should fit into a single line.

I'd make it something like "acpi_indirect_io_set_res - set "indirect
IO" host child (MFD) resources" and it already is explained in the
comment below.

> + * @child: the device node to be updated the I/O resource
> + * @hostdev: the device node associated with the "indirect IO" host
> + * @res: double pointer to be set to the address of translated resources
> + * @num_res: pointer to variable to hold the number of translated resources
> + *
> + * Returns 0 when successful, and a negative value for failure.
> + *
> + * For a given "indirect IO" host, each child device will have associated
> + * host-relevative address resource. This function will return the translated

host-relative

> + * logical PIO addresses for each child devices resources.
> + */
> +static int acpi_indirect_io_set_res(struct device *child,
> +                                   struct device *hostdev,
> +                                   const struct resource **res,
> +                                   int *num_res)
> +{
> +       struct acpi_device *adev;
> +       struct acpi_device *host;
> +       struct resource_entry *rentry;
> +       LIST_HEAD(resource_list);
> +       struct resource *resources;
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
> +               dev_info(child, "device is not present\n");

dev_dbg()?

> +               return 0;
> +       }
> +       /* whether the child had been enumerated? */
> +       if (acpi_device_enumerated(adev)) {
> +               dev_info(child, "had been enumerated\n");

Again, dev_dbg()?

> +               return 0;
> +       }
> +
> +       count = acpi_dev_get_resources(adev, &resource_list, NULL, NULL);
> +       if (count <= 0) {
> +               dev_err(child, "failed to get resources\n");

I'd use dev_dbg() here too (the message may not even be meaningful to a user).

> +               return count ? count : -EIO;
> +       }
> +
> +       resources = kcalloc(count, sizeof(*resources), GFP_KERNEL);
> +       if (!resources) {

And you don't print anything here, I wonder why?

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
> +               if (!(resources[i].flags & IORESOURCE_IO))
> +                       continue;
> +               ret = acpi_indirect_io_xlat_res(adev, host, &resources[i]);
> +               if (ret) {
> +                       kfree(resources);
> +                       dev_err(child, "translate IO range failed(%d)\n", ret);
> +                       return ret;
> +               }
> +       }
> +       *res = resources;
> +       *num_res = count;
> +
> +       return ret;
> +}
> +
> +/*
> + * acpi_indirect_io_setup - scan handler for "indirect IO" host.
> + * @adev: "indirect IO" host ACPI device pointer

One extra empty comment line here, please.

> + * Returns 0 when successful, and a negative value for failure.
> + *
> + * Setup an "indirect IO" host by scanning all child devices, and
> + * create a per-device MFD with logical PIO translated IO resources.
> + */
> +static int acpi_indirect_io_setup(struct acpi_device *adev)
> +{
> +       struct platform_device *pdev;
> +       struct mfd_cell *mfd_cells;
> +       struct logic_pio_hwaddr *range;
> +       struct acpi_device *child;
> +       struct acpi_indirect_io_mfd_cell *acpi_indirect_io_mfd_cells;
> +       int size, ret, count = 0, cell_num = 0;
> +
> +       range = kzalloc(sizeof(*range), GFP_KERNEL);
> +       if (!range)
> +               return -ENOMEM;
> +       range->fwnode = &adev->fwnode;
> +       range->flags = PIO_INDIRECT;
> +       range->size = PIO_INDIRECT_SIZE;
> +
> +       ret = logic_pio_register_range(range);
> +       if (ret)
> +               goto free_range;
> +
> +       list_for_each_entry(child, &adev->children, node)
> +               cell_num++;
> +
> +       /* allocate the mfd cell and companion acpi info, one per child */
> +       size = sizeof(*mfd_cells) + sizeof(*acpi_indirect_io_mfd_cells);
> +       mfd_cells = kcalloc(cell_num, size, GFP_KERNEL);
> +       if (!mfd_cells) {
> +               ret = -ENOMEM;
> +               goto free_range;
> +       }
> +
> +       acpi_indirect_io_mfd_cells = (struct acpi_indirect_io_mfd_cell *)
> +                                       &mfd_cells[cell_num];
> +       /* Only consider the children of the host */
> +       list_for_each_entry(child, &adev->children, node) {
> +               struct mfd_cell *mfd_cell = &mfd_cells[count];
> +               struct acpi_indirect_io_mfd_cell *acpi_indirect_io_mfd_cell =
> +                                       &acpi_indirect_io_mfd_cells[count];
> +               const struct mfd_cell_acpi_match *acpi_match =
> +                                       &acpi_indirect_io_mfd_cell->acpi_match;
> +               char *name = &acpi_indirect_io_mfd_cell[count].name[0];
> +               char *pnpid = &acpi_indirect_io_mfd_cell[count].pnpid[0];
> +               struct mfd_cell_acpi_match match = {
> +                       .pnpid = pnpid,
> +               };
> +
> +               snprintf(name, ACPI_INDIRECT_IO_NAME_LEN, "indirect-io-%s",
> +                        acpi_device_hid(child));
> +               snprintf(pnpid, ACPI_INDIRECT_IO_NAME_LEN, "%s",
> +                        acpi_device_hid(child));
> +
> +               memcpy((void *)acpi_match, (void *)&match, sizeof(*acpi_match));
> +               mfd_cell->name = name;
> +               mfd_cell->acpi_match = acpi_match;
> +
> +               ret = acpi_indirect_io_set_res(&child->dev, &adev->dev,
> +                                              &mfd_cell->resources,
> +                                              &mfd_cell->num_resources);
> +               if (ret) {
> +                       dev_err(&child->dev, "set resource failed (%d)\n", ret);

Again, please consider using dev_dbg() here and below (for the same
reason as above).

> +                       goto free_mfd_resources;
> +               }
> +               count++;
> +       }
> +
> +       pdev = acpi_create_platform_device(adev, NULL);
> +       if (IS_ERR_OR_NULL(pdev)) {
> +               dev_err(&adev->dev, "create platform device for host failed\n");
> +               ret = PTR_ERR(pdev);
> +               goto free_mfd_resources;
> +       }
> +       acpi_device_set_enumerated(adev);
> +
> +       ret = mfd_add_devices(&pdev->dev, PLATFORM_DEVID_NONE,
> +                             mfd_cells, cell_num, NULL, 0, NULL);
> +       if (ret) {
> +               dev_err(&pdev->dev, "failed to add mfd cells (%d)\n", ret);
> +               goto free_mfd_resources;
> +       }
> +
> +       return ret;

return 0;

You know that ret must be 0 here anyway.

> +
> +free_mfd_resources:
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
> +static const struct acpi_device_id acpi_indirect_io_host_id[] = {
> +       {}
> +};
> +
> +static int acpi_indirect_io_attach(struct acpi_device *adev,
> +                                  const struct acpi_device_id *id)
> +{
> +       int ret = acpi_indirect_io_setup(adev);
> +
> +       if (ret < 0)
> +               return ret;
> +
> +       return 1;

The above can be written as

return ret < 0 ? ret : 1;

to save a few lines of code (you are using this pattern above, so why
not here?).

> +}
> +
> +static struct acpi_scan_handler acpi_indirect_io_handler = {
> +       .ids = acpi_indirect_io_host_id,
> +       .attach = acpi_indirect_io_attach,
> +};
> +
> +void __init acpi_indirect_io_scan_init(void)
> +{
> +       acpi_scan_add_handler(&acpi_indirect_io_handler);
> +}
> diff --git a/drivers/acpi/internal.h b/drivers/acpi/internal.h
> index 1d0a501..680f3cf 100644
> --- a/drivers/acpi/internal.h
> +++ b/drivers/acpi/internal.h
> @@ -31,6 +31,11 @@
>  void acpi_platform_init(void);
>  void acpi_pnp_init(void);
>  void acpi_int340x_thermal_init(void);
> +#ifdef CONFIG_INDIRECT_PIO
> +void acpi_indirect_io_scan_init(void);
> +#else
> +static inline void acpi_indirect_io_scan_init(void) {}
> +#endif
>  #ifdef CONFIG_ARM_AMBA
>  void acpi_amba_init(void);
>  #else
> diff --git a/drivers/acpi/scan.c b/drivers/acpi/scan.c
> index 8e63d93..204da8a 100644
> --- a/drivers/acpi/scan.c
> +++ b/drivers/acpi/scan.c
> @@ -2155,6 +2155,7 @@ int __init acpi_scan_init(void)
>         acpi_amba_init();
>         acpi_watchdog_init();
>         acpi_init_lpit();
> +       acpi_indirect_io_scan_init();
>
>         acpi_scan_add_handler(&generic_device_handler);
>
> --

But generally

Acked-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>

for the generic ACPI changes.
