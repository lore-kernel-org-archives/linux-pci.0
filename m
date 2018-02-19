Return-Path: <linux-acpi-owner@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <1519062520-198902-8-git-send-email-john.garry@huawei.com>
References: <1519062520-198902-1-git-send-email-john.garry@huawei.com> <1519062520-198902-8-git-send-email-john.garry@huawei.com>
From: "Rafael J. Wysocki" <rafael@kernel.org>
Date: Mon, 19 Feb 2018 22:38:19 +0100
Message-ID: <CAJZ5v0jL9mVq43+NtnkUAuEqan17ZNqNPBqBpKwCYRiQn0Ni2w@mail.gmail.com>
Subject: Re: [PATCH v14 7/9] ACPI / scan: do not enumerate Indirect IO host children
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

On Mon, Feb 19, 2018 at 6:48 PM, John Garry <john.garry@huawei.com> wrote:
> Through the logical PIO framework systems which otherwise have
> no IO space access to legacy ISA/LPC devices may access these
> devices through so-called "indirect IO" method. In this, IO
> space accesses for non-PCI hosts are redirected to a host
> LLDD to manually generate the IO space (bus) accesses. Hosts
> are able to register a region in logical PIO space to map to
> its bus address range.
>
> Indirect IO child devices have an associated host-specific bus
> address. Special translation is required to map between
> a logical PIO address for a device and it's host bus address.
>
> Since in the ACPI tables the child device IO resources would
> be the host-specific values, it is required the ACPI scan code
> should not enumerate these devices, and that this should be
> the responsibility of the host driver so that it can "fixup"
> the resources so that they map to the appropriate logical PIO
> addresses.
>
> To avoid enumerating these child devices, we check whether
> the parent for a device is a member of a known list of
> "indirect IO" hosts. For now, the HiSilicon LPC host
> controller ID is added.
>
> To flag a device to not be enumerated, we reuse the existing
> serial bus slave flag.
>
> Signed-off-by: John Garry <john.garry@huawei.com>

Acked-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>

> ---
>  drivers/acpi/scan.c | 14 ++++++++++++++
>  1 file changed, 14 insertions(+)
>
> diff --git a/drivers/acpi/scan.c b/drivers/acpi/scan.c
> index 8e63d93..c1a60852 100644
> --- a/drivers/acpi/scan.c
> +++ b/drivers/acpi/scan.c
> @@ -1524,11 +1524,25 @@ static int acpi_check_serial_bus_slave(struct acpi_resource *ares, void *data)
>         return -1;
>  }
>
> +static bool acpi_is_indirect_io_slave(struct acpi_device *device)
> +{
> +       struct acpi_device *parent = device->parent;
> +       const struct acpi_device_id indirect_io_hosts[] = {
> +               {"HISI0191", 0},
> +               {}
> +       };
> +
> +       return parent && !acpi_match_device_ids(parent, indirect_io_hosts);
> +}
> +
>  static bool acpi_is_serial_bus_slave(struct acpi_device *device)
>  {
>         struct list_head resource_list;
>         bool is_serial_bus_slave = false;
>
> +       if (acpi_is_indirect_io_slave(device))
> +               return true;
> +
>         /* Macs use device properties in lieu of _CRS resources */
>         if (x86_apple_machine &&
>             (fwnode_property_present(&device->fwnode, "spiSclkPeriod") ||
> --
> 1.9.1
>
