Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from fgwmail6.fujitsu.co.jp ([192.51.44.36]:43029 "EHLO
	fgwmail6.fujitsu.co.jp" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751196Ab2IGJ0V (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Fri, 7 Sep 2012 05:26:21 -0400
Date: Fri, 7 Sep 2012 18:26:12 +0900
From: Taku Izumi <izumi.taku@jp.fujitsu.com>
To: Yinghai Lu <yinghai@kernel.org>
Cc: linux-pci@vger.kernel.org, bhelgaas@google.com,
	linux-acpi@vger.kernel.org, kaneshige.kenji@jp.fujitsu.com,
	jiang.liu@huawei.com
Subject: Re: [PATCH v2 6/6] ACPI, PCI: add resoruce-assign code for devices
 under hot-added hostbridge
Message-Id: <20120907182612.92efef7d.izumi.taku@jp.fujitsu.com>
In-Reply-To: <CAE9FiQVXtTf3+jpbYzHk3D3VVm-bXEB9EcgkBwkEtYR-SRiKHA@mail.gmail.com>
References: <20120903165831.29aed72c.izumi.taku@jp.fujitsu.com>
	<20120903170705.4e6dbc2c.izumi.taku@jp.fujitsu.com>
	<CAE9FiQVXtTf3+jpbYzHk3D3VVm-bXEB9EcgkBwkEtYR-SRiKHA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Mon, 3 Sep 2012 13:27:11 -0700
Yinghai Lu <yinghai@kernel.org> wrote:

> On Mon, Sep 3, 2012 at 1:07 AM, Taku Izumi <izumi.taku@jp.fujitsu.com> wrote:
> >
> > Devices under hot-added hostbridge have no chance to assign resources
> > and to configure them, so this patch adds such code for hot-added
> > hostbridges at acpi_pci_root_start().
> >
> > Signed-off-by: Taku Izumi <izumi.taku@jp.fujitsu.com>
> > ---
> >  drivers/acpi/pci_root.c |   17 +++++++++++++++++
> >  include/acpi/acpi_bus.h |    1 +
> >  2 files changed, 18 insertions(+)
> >
> > Index: Bjorn-next-0903/drivers/acpi/pci_root.c
> > ===================================================================
> > --- Bjorn-next-0903.orig/drivers/acpi/pci_root.c
> > +++ Bjorn-next-0903/drivers/acpi/pci_root.c
> > @@ -39,6 +39,7 @@
> >  #include <acpi/acpi_bus.h>
> >  #include <acpi/acpi_drivers.h>
> >  #include <acpi/apei.h>
> > +#include <linux/pci_hotplug.h>
> >
> >  #define PREFIX "ACPI: "
> >
> > @@ -461,6 +462,9 @@ static int __devinit acpi_pci_root_add(s
> >         if (!root)
> >                 return -ENOMEM;
> >
> > +       if (system_state != SYSTEM_BOOTING)
> > +               root->hot_added = true;
> > +
> >         segment = 0;
> >         status = acpi_evaluate_integer(device->handle, METHOD_NAME__SEG, NULL,
> >                                        &segment);
> > @@ -639,6 +643,7 @@ static int acpi_pci_root_start(struct ac
> >  {
> >         struct acpi_pci_root *root = acpi_driver_data(device);
> >         struct acpi_pci_driver *driver;
> > +       struct pci_dev *pdev;
> >
> >         mutex_lock(&acpi_pci_root_lock);
> >         list_for_each_entry(driver, &acpi_pci_drivers, node)
> > @@ -646,6 +651,18 @@ static int acpi_pci_root_start(struct ac
> >                         driver->add(device->handle);
> >         mutex_unlock(&acpi_pci_root_lock);
> >
> > +       /*
> > +        * Devices under hot-added hostbridge have no chance to assign
> > +        * resources and to configure them, so do that here
> > +        */
> > +       if (root->hot_added) {
> > +               pci_bus_size_bridges(root->bus);
> > +               pci_bus_assign_resources(root->bus);
> > +               list_for_each_entry(pdev, &root->bus->devices, bus_list)
> > +                       pci_configure_slot(pdev);
> > +               pci_enable_bridges(root->bus);
> > +       }
> > +
> >         pci_bus_add_devices(root->bus);
> 
> after looking at your simplified version in patch5 and patch6
> found that you do not understand my patchset correctly.
> 
> in my patchset there is change on:
> acpi_pci_root_add
> acpi_pci_root_start
> acpi_pci_root_remove
> 
> and
> handle_root_bridge_insertion/acpi_root_configure_bridge
> handle_root_bridge_removal
> 
> for hot add path:
> handle_root_bridge_insertion will call
>       acpi_pci_root_add: it will scan the root bus and find all pci device
>       acpi_root_configure_bridge: it will survey fw set pci resource,
> and assigned unsigned resource
>       acpi_pci_root_start: it will start acpi_pci driver for ioapic
> controller and dmar iommu
>                                     then call pci_bus_add_devices to
> load other pci device drivers.
> 
> for hot remove path:
>       acpi_pci_root_remove: will call pci_stop_bus_devices() to stop
> drivers for all normal pci devices.
>                                         then stop acpi_pci driver for
> dmar and ioapic driver
>                                         then call
> pci_stop_and_remove_bus to remove the root bus.
> 
> the point is : keep the driver of ioapic and dmar  driver loading
> before normal pci drivers, and later
> stop driver for dmar/iommu, after unloading pci drivers.

 Sorry for too late response.
 I failed at rebasing. I'll resend this patch.
 Could you please review these again?

Best regards,
Taku Izumi <izumi.taku@jp.fujitsu.com>

