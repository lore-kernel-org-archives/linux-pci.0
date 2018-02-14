Return-Path: <linux-acpi-owner@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <1518543933-22456-8-git-send-email-john.garry@huawei.com>
References: <1518543933-22456-1-git-send-email-john.garry@huawei.com> <1518543933-22456-8-git-send-email-john.garry@huawei.com>
From: Andy Shevchenko <andy.shevchenko@gmail.com>
Date: Wed, 14 Feb 2018 15:53:21 +0200
Message-ID: <CAHp75Ve7C4AJYK6AC=o-jzw6b2p8c8GBRd70Zjv+vYWbfytufg@mail.gmail.com>
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
        Rob Herring <robh@kernel.org>, Joe Perches <joe@perches.com>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        linux-pci@vger.kernel.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        ACPI Devel Maling List <linux-acpi@vger.kernel.org>,
        Linuxarm <linuxarm@huawei.com>, Corey Minyard <minyard@acm.org>,
        devicetree <devicetree@vger.kernel.org>,
        Linux-Arch <linux-arch@vger.kernel.org>,
        Randy Dunlap <rdunlap@infradead.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-acpi-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Tue, Feb 13, 2018 at 7:45 PM, John Garry <john.garry@huawei.com> wrote:
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

> +       unsigned long sys_port;

> +       sys_port = logic_pio_trans_hwaddr(&host->fwnode, res->start, len);
> +       if (sys_port == -1UL)

Wouldn't it be better to compare with ULONG_MAX?

> +               return -EFAULT;


> +/*

Shouldn't be a kernel-doc?

> + * acpi_indirect_io_set_res - set the resources for a child device
> + * (MFD) of an "indirect IO" host.

In that case this would be one line w/o period at the end.

> + * @child: the device node to be updated the I/O resource
> + * @hostdev: the device node associated with the "indirect IO" host
> + * @res: double pointer to be set to the address of translated resources
> + * @num_res: pointer to variable to hold the number of translated resources
> + *
> + * Returns 0 when successful, and a negative value for failure.
> + *
> + * For a given "indirect IO" host, each child device will have associated
> + * host-relevative address resource. This function will return the translated
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

> +       count = acpi_dev_get_resources(adev, &resource_list, NULL, NULL);
> +       if (count <= 0) {
> +               dev_err(child, "failed to get resources\n");
> +               return count ? count : -EIO;
> +       }
> +
> +       resources = kcalloc(count, sizeof(*resources), GFP_KERNEL);
> +       if (!resources) {
> +               acpi_dev_free_resource_list(&resource_list);
> +               return -ENOMEM;
> +       }
> +       count = 0;
> +       list_for_each_entry(rentry, &resource_list, node)
> +               resources[count++] = *rentry->res;
> +
> +       acpi_dev_free_resource_list(&resource_list);

It has similarities with acpi_create_platform_device().
I guess we can utilize existing code.

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

Perhaps,

   ret = ...
   if (ret)
    break;
  }

  if (ret) {
                       kfree(resources);
                       dev_err(child, "translate IO range failed(%d)\n", ret);
                       return ret;
  }

  *res = resources;
  *num_res = count;
  return 0;

?

> +}
> +
> +/*
> + * acpi_indirect_io_setup - scan handler for "indirect IO" host.
> + * @adev: "indirect IO" host ACPI device pointer
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

Plain x is equivalent to &x[0].

> +               struct mfd_cell_acpi_match match = {
> +                       .pnpid = pnpid,
> +               };
> +
> +               snprintf(name, ACPI_INDIRECT_IO_NAME_LEN, "indirect-io-%s",
> +                        acpi_device_hid(child));
> +               snprintf(pnpid, ACPI_INDIRECT_IO_NAME_LEN, "%s",
> +                        acpi_device_hid(child))

> +               memcpy((void *)acpi_match, (void *)&match, sizeof(*acpi_match));

Casting to void * is pointless. In both cases.

> +               mfd_cell->name = name;
> +               mfd_cell->acpi_match = acpi_match;
> +
> +               ret = acpi_indirect_io_set_res(&child->dev, &adev->dev,
> +                                              &mfd_cell->resources,
> +                                              &mfd_cell->num_resources);
> +               if (ret) {
> +                       dev_err(&child->dev, "set resource failed (%d)\n", ret);
> +                       goto free_mfd_resources;
> +               }
> +               count++;
> +       }
> +
> +       pdev = acpi_create_platform_device(adev, NULL);
> +       if (IS_ERR_OR_NULL(pdev)) {
> +               dev_err(&adev->dev, "create platform device for host failed\n");

> +               ret = PTR_ERR(pdev);

So, NULL case will return 0. Is it expected?

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

One question, what a scope of use of this function? Is it ->probe() time?
If it's so, can we use devm_* variants?

-- 
With Best Regards,
Andy Shevchenko
