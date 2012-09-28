Return-Path: <linux-acpi-owner@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <1348733519-24684-5-git-send-email-yinghai@kernel.org>
References: <1348733519-24684-1-git-send-email-yinghai@kernel.org> <1348733519-24684-5-git-send-email-yinghai@kernel.org>
From: Bjorn Helgaas <bhelgaas@google.com>
Date: Fri, 28 Sep 2012 17:46:11 -0600
Message-ID: <CAErSpo4WYEFg9HBRm8z=sSUTYLv5eLNfH07RQaQGh2+ZScp8sw@mail.gmail.com>
Subject: Re: [PATCH 4/8] PCI, ACPI: assign unassigned resource for hot add
 root bus
To: Yinghai Lu <yinghai@kernel.org>
Cc: Len Brown <lenb@kernel.org>,
	Taku Izumi <izumi.taku@jp.fujitsu.com>,
	Jiang Liu <jiang.liu@huawei.com>, linux-pci@vger.kernel.org,
	linux-acpi@vger.kernel.org
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-acpi-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Thu, Sep 27, 2012 at 2:11 AM, Yinghai Lu <yinghai@kernel.org> wrote:
> After we get hot-added ioapic registered.
> pci_enable_bridges will try to enable ioapic irq for pci bridges.

What makes this specifically related to IOAPICs?

> Signed-off-by: Yinghai Lu <yinghai@kernel.org>
> ---
>  drivers/acpi/pci_root.c |    7 +++++++
>  1 files changed, 7 insertions(+), 0 deletions(-)
>
> diff --git a/drivers/acpi/pci_root.c b/drivers/acpi/pci_root.c
> index bce469c..27adbfd 100644
> --- a/drivers/acpi/pci_root.c
> +++ b/drivers/acpi/pci_root.c
> @@ -644,12 +644,19 @@ static int acpi_pci_root_start(struct acpi_device *device)
>         struct acpi_pci_root *root = acpi_driver_data(device);
>         struct acpi_pci_driver *driver;
>
> +       if (system_state != SYSTEM_BOOTING)
> +               pci_assign_unassigned_bus_resources(root->bus);
> +
>         mutex_lock(&acpi_pci_root_lock);
>         list_for_each_entry(driver, &acpi_pci_drivers, node)
>                 if (driver->add)
>                         driver->add(root);
>         mutex_unlock(&acpi_pci_root_lock);
>
> +       /* need to after hot-added ioapic is registered */
> +       if (system_state != SYSTEM_BOOTING)
> +               pci_enable_bridges(root->bus);

Theoretically, we should be able to assign resources and enable
bridges here regardless of the system_state.

I think the reason you don't want to do it while SYSTEM_BOOTING is
because we currently do this at boot-time:

    acpi_pci_root_add
        pci_scan_child_bus
    acpi_pci_root_start
        pci_bus_add_devices
    <account for some motherboard (PNP0C01) resources>
    pcibios_assign_resources            # fs_initcall
        pci_assign_unassigned_resources
            pci_enable_bridges

and without the SYSTEM_BOOTING check, we might assign PCI resources at
boot-time that conflict with motherboard resources.

Is that right?

This is completely non-obvious and future readers deserve a hint about
what's going on here.

The right way to do this would be to pay attention to the host bridge
apertures, and assign resources from within the apertures.  Then we
could always assign PCI resources when adding a host bridge instead of
in an fs_initcall.  I understand we still have legacy issues and
machines where we still don't pay attention to _CRS.  But if we're
doing things to work around a broken design, it's important to be
aware of how the design is broken so we have some hope of eventually
fixing the design.

>         pci_bus_add_devices(root->bus);
>
>         return 0;
> --
> 1.7.7
>
