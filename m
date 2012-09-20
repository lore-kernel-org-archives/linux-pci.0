Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-bk0-f46.google.com ([209.85.214.46]:52195 "EHLO
	mail-bk0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751262Ab2ITFl7 (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Thu, 20 Sep 2012 01:41:59 -0400
MIME-Version: 1.0
In-Reply-To: <20120918152641.410dad43.izumi.taku@jp.fujitsu.com>
References: <20120918151215.59ea763b.izumi.taku@jp.fujitsu.com>
	<20120918152641.410dad43.izumi.taku@jp.fujitsu.com>
Date: Wed, 19 Sep 2012 22:41:57 -0700
Message-ID: <CAE9FiQU_-FYdy0ARuGaoCEg+F+5t0tDF-WToFhafGWbbAWBvDw@mail.gmail.com>
Subject: Re: [PATCH v3 8/8] ACPI, PCI: add resoruce-assign code for devices
 under hot-added hostbridge
From: Yinghai Lu <yinghai@kernel.org>
To: Taku Izumi <izumi.taku@jp.fujitsu.com>
Cc: linux-pci@vger.kernel.org, bhelgaas@google.com,
	linux-acpi@vger.kernel.org, kaneshige.kenji@jp.fujitsu.com,
	jiang.liu@huawei.com
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Mon, Sep 17, 2012 at 11:26 PM, Taku Izumi <izumi.taku@jp.fujitsu.com> wrote:
>
> Devices under hot-added hostbridge have no chance to assign resources
> and to configure them, so this patch adds such code for hot-added
> hostbridges at acpi_pci_root_start().
>
> Signed-off-by: Taku Izumi <izumi.taku@jp.fujitsu.com>
> ---
>  drivers/acpi/pci_root.c |   17 +++++++++++++++++
>  include/acpi/acpi_bus.h |    1 +
>  2 files changed, 18 insertions(+)
>
> Index: Bjorn-next-0903/drivers/acpi/pci_root.c
> ===================================================================
> --- Bjorn-next-0903.orig/drivers/acpi/pci_root.c
> +++ Bjorn-next-0903/drivers/acpi/pci_root.c
> @@ -38,6 +38,7 @@
>  #include <acpi/acpi_bus.h>
>  #include <acpi/acpi_drivers.h>
>  #include <acpi/apei.h>
> +#include <linux/pci_hotplug.h>
>
>  #define PREFIX "ACPI: "
>
> @@ -459,6 +460,9 @@ static int __devinit acpi_pci_root_add(s
>         if (!root)
>                 return -ENOMEM;
>
> +       if (system_state != SYSTEM_BOOTING)
> +               root->hot_added = true;
> +

should be moved down just before return.

>         segment = 0;
>         status = acpi_evaluate_integer(device->handle, METHOD_NAME__SEG, NULL,
>                                        &segment);
> @@ -636,6 +640,7 @@ static int acpi_pci_root_start(struct ac
>  {
>         struct acpi_pci_root *root = acpi_driver_data(device);
>         struct acpi_pci_driver *driver;
> +       struct pci_dev *pdev;
>
>         mutex_lock(&acpi_pci_root_lock);
>         list_for_each_entry(driver, &acpi_pci_drivers, node)
> @@ -643,6 +648,18 @@ static int acpi_pci_root_start(struct ac
>                         driver->add(root);
>         mutex_unlock(&acpi_pci_root_lock);
>
> +       /*
> +        * Devices under hot-added hostbridge have no chance to assign
> +        * resources and to configure them, so do that here
> +        */
> +       if (root->hot_added) {
> +               pci_bus_size_bridges(root->bus);
> +               pci_bus_assign_resources(root->bus);
> +               list_for_each_entry(pdev, &root->bus->devices, bus_list)
> +                       pci_configure_slot(pdev);
> +               pci_enable_bridges(root->bus);
> +       }

should move that before acpi_pci_drivers.add calling

> +
>         pci_bus_add_devices(root->bus);
>
>         return 0;
> Index: Bjorn-next-0903/include/acpi/acpi_bus.h
> ===================================================================
> --- Bjorn-next-0903.orig/include/acpi/acpi_bus.h
> +++ Bjorn-next-0903/include/acpi/acpi_bus.h
> @@ -407,6 +407,7 @@ struct acpi_pci_root {
>         u32 osc_support_set;    /* _OSC state of support bits */
>         u32 osc_control_set;    /* _OSC state of control bits */
>         phys_addr_t mcfg_addr;
> +       bool hot_added;
>  };
>
>  /* helper */
>
