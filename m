Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-lb0-f202.google.com ([209.85.217.202]:40620 "EHLO
	mail-lb0-f202.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750741Ab2J3ECk (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Tue, 30 Oct 2012 00:02:40 -0400
Received: by mail-lb0-f202.google.com with SMTP id l12so351776lbo.1
        for <linux-pci@vger.kernel.org>; Mon, 29 Oct 2012 21:02:38 -0700 (PDT)
Date: Mon, 29 Oct 2012 22:02:37 -0600
From: Bjorn Helgaas <bhelgaas@google.com>
To: Taku Izumi <izumi.taku@jp.fujitsu.com>
Cc: linux-pci@vger.kernel.org, linux-acpi@vger.kernel.org,
	kaneshige.kenji@jp.fujitsu.com, yinghai@kernel.org,
	jiang.liu@huawei.com
Subject: Re: [PATCH v3 7/8] ACPI, PCI: add hostbridge removal function
Message-ID: <20121030040237.GA10472@google.com>
References: <20120918151215.59ea763b.izumi.taku@jp.fujitsu.com>
 <20120918152553.8c8390d8.izumi.taku@jp.fujitsu.com>
 <CAErSpo7hYHkFAgFy=q6ASV_15r-y_Cp=92nUdRAnBSGLi9ZMrA@mail.gmail.com>
 <20120928184627.0b039d14.izumi.taku@jp.fujitsu.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20120928184627.0b039d14.izumi.taku@jp.fujitsu.com>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

I think I'm missing patches 7/8 and 8/8 from this series.  Can
you repost them to make sure I have the latest versions?

Note the comments below:

On Fri, Sep 28, 2012 at 06:46:27PM +0900, Taku Izumi wrote:
> 
> Currently there's no PCI-related clean-up code
> in acpi_pci_root_remove() function.
> This patch introduces function for hostbridge removal,
> and brings back pci_stop_bus_devices() function.
> 
> diff: rebased against current next
>       updated according to Bjorn's comment
> 
> Signed-off-by: Taku Izumi <izumi.taku@jp.fujitsu.com>
> ---
>  drivers/acpi/pci_bind.c     |    7 +++++++
>  drivers/acpi/pci_root.c     |    6 ++++++
>  drivers/pci/remove.c        |   28 ++++++++++++++++++++++++++++
>  include/acpi/acpi_drivers.h |    1 +
>  include/linux/pci.h         |    2 ++
>  5 files changed, 44 insertions(+)
> 
> Index: Bjorn-next-0925-configchange/drivers/pci/remove.c
> ===================================================================
> --- Bjorn-next-0925-configchange.orig/drivers/pci/remove.c
> +++ Bjorn-next-0925-configchange/drivers/pci/remove.c
> @@ -111,3 +111,31 @@ void pci_stop_and_remove_bus_device(stru
>  	pci_remove_bus_device(dev);
>  }
>  EXPORT_SYMBOL(pci_stop_and_remove_bus_device);
> +
> +void pci_stop_bus_devices(struct pci_bus *bus)
> +{
> +	struct pci_dev *dev, *tmp;
> +
> +	list_for_each_entry_safe_reverse(dev, tmp,
> +					 &bus->devices, bus_list) {
> +		pci_stop_bus_device(dev);
> +	}
> +
> +}
> +EXPORT_SYMBOL(pci_stop_bus_devices);

I'm hesitant to introduce pci_stop_bus_devices() again, particularly
when it is exported.  The stop/remove split introduces the state where
devices are "stopped" but haven't been "removed" yet.

In this state, the driver .remove() method has been called, sysfs has
been cleaned up, and the struct device has been unregistered, but the 
struct pci_dev itself still exists.  Obviously, this state *must*
exist internally in the PCI core as we remove the PCI device.

The problem is that we have non-core code that *depends* on being
run while in this transitory state.  I think this is a design mistake.

The code that depends on this state is basically just the stuff in the
acpi_pci_drivers list, namely, acpi_pci_hp_driver and acpi_pci_slot_driver.
I suspect that the main reason we have the acpi_pci_drivers list and the
whole acpi_pci_register_driver() infrastructure is so that these PCI
host bridge "sub-drivers" can be built as modules.

I don't think there's really any value in having these sub-drivers as
modules, and it leads to a lot of complication in the code.  I'm pretty
sure that forcing them to be selected at build-time will let us make
things much simpler.

If we have to have pci_stop_bus_devices() as an interim measure, I can
live with it, but it doesn't need to be exported, does it?

> +void pci_remove_host_bridge(struct pci_host_bridge *bridge)
> +{
> +	struct pci_bus *root = bridge->bus;
> +	struct pci_dev *dev, *tmp;
> +
> +	list_for_each_entry_safe_reverse(dev, tmp,
> +					 &root->devices, bus_list) {
> +		pci_remove_bus_device(dev);
> +	}
> +
> +	pci_remove_bus(root);
> +
> +	device_unregister(&bridge->dev);
> +}
> +EXPORT_SYMBOL(pci_remove_host_bridge);
> Index: Bjorn-next-0925-configchange/drivers/acpi/pci_root.c
> ===================================================================
> --- Bjorn-next-0925-configchange.orig/drivers/acpi/pci_root.c
> +++ Bjorn-next-0925-configchange/drivers/acpi/pci_root.c
> @@ -659,8 +659,10 @@ static int acpi_pci_root_remove(struct a
>  {
>  	struct acpi_pci_root *root = acpi_driver_data(device);
>  	struct acpi_pci_driver *driver;
> +	struct pci_host_bridge *bridge = to_pci_host_bridge(root->bus->bridge);
>  
>  	mutex_lock(&acpi_pci_root_lock);
> +	pci_stop_bus_devices(root->bus);
>  	list_for_each_entry(driver, &acpi_pci_drivers, node)
>  		if (driver->remove)
>  			driver->remove(root);
> @@ -668,6 +670,10 @@ static int acpi_pci_root_remove(struct a
>  	device_set_run_wake(root->bus->bridge, false);
>  	pci_acpi_remove_bus_pm_notifier(device);
>  
> +	acpi_pci_unbind_root(device);
> +
> +	pci_remove_host_bridge(bridge);
> +
>  	list_del(&root->node);
>  	mutex_unlock(&acpi_pci_root_lock);
>  	kfree(root);
> Index: Bjorn-next-0925-configchange/include/linux/pci.h
> ===================================================================
> --- Bjorn-next-0925-configchange.orig/include/linux/pci.h
> +++ Bjorn-next-0925-configchange/include/linux/pci.h
> @@ -734,6 +734,8 @@ extern struct pci_dev *pci_dev_get(struc
>  extern void pci_dev_put(struct pci_dev *dev);
>  extern void pci_remove_bus(struct pci_bus *b);
>  extern void pci_stop_and_remove_bus_device(struct pci_dev *dev);
> +extern void pci_stop_bus_devices(struct pci_bus *bus);
> +extern void pci_remove_host_bridge(struct pci_host_bridge *bridge);
>  void pci_setup_cardbus(struct pci_bus *bus);
>  extern void pci_sort_breadthfirst(void);
>  #define dev_is_pci(d) ((d)->bus == &pci_bus_type)
> Index: Bjorn-next-0925-configchange/drivers/acpi/pci_bind.c
> ===================================================================
> --- Bjorn-next-0925-configchange.orig/drivers/acpi/pci_bind.c
> +++ Bjorn-next-0925-configchange/drivers/acpi/pci_bind.c
> @@ -118,3 +118,10 @@ int acpi_pci_bind_root(struct acpi_devic
>  
>  	return 0;
>  }
> +
> +void  acpi_pci_unbind_root(struct acpi_device *device)
> +{
> +	device->ops.bind = NULL;
> +	device->ops.unbind = NULL;
> +}
> +
> Index: Bjorn-next-0925-configchange/include/acpi/acpi_drivers.h
> ===================================================================
> --- Bjorn-next-0925-configchange.orig/include/acpi/acpi_drivers.h
> +++ Bjorn-next-0925-configchange/include/acpi/acpi_drivers.h
> @@ -101,6 +101,7 @@ struct pci_bus;
>  
>  struct pci_dev *acpi_get_pci_dev(acpi_handle);
>  int acpi_pci_bind_root(struct acpi_device *device);
> +void acpi_pci_unbind_root(struct acpi_device *device);
>  
>  /* Arch-defined function to add a bus to the system */
>  
> 
