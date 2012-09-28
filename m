Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from fgwmail5.fujitsu.co.jp ([192.51.44.35]:38191 "EHLO
	fgwmail5.fujitsu.co.jp" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751121Ab2I1APH (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Thu, 27 Sep 2012 20:15:07 -0400
Date: Fri, 28 Sep 2012 09:15:20 +0900
From: Taku Izumi <izumi.taku@jp.fujitsu.com>
To: Bjorn Helgaas <bhelgaas@google.com>
Cc: linux-pci@vger.kernel.org, linux-acpi@vger.kernel.org,
	kaneshige.kenji@jp.fujitsu.com, yinghai@kernel.org,
	jiang.liu@huawei.com
Subject: Re: [PATCH v3 7/8] ACPI, PCI: add hostbridge removal function
Message-Id: <20120928091520.92bf495b.izumi.taku@jp.fujitsu.com>
In-Reply-To: <CAErSpo5bTDWCoVbzP-zz_ZcbSL-QJg+eFwoJHQxvaeQAY5OG2A@mail.gmail.com>
References: <20120918151215.59ea763b.izumi.taku@jp.fujitsu.com>
	<20120918152553.8c8390d8.izumi.taku@jp.fujitsu.com>
	<CAErSpo7hYHkFAgFy=q6ASV_15r-y_Cp=92nUdRAnBSGLi9ZMrA@mail.gmail.com>
	<CAErSpo5bTDWCoVbzP-zz_ZcbSL-QJg+eFwoJHQxvaeQAY5OG2A@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Thu, 27 Sep 2012 10:48:09 -0600
Bjorn Helgaas <bhelgaas@google.com> wrote:

> On Fri, Sep 21, 2012 at 2:09 PM, Bjorn Helgaas <bhelgaas@google.com> wrote:
> > On Tue, Sep 18, 2012 at 12:25 AM, Taku Izumi <izumi.taku@jp.fujitsu.com> wrote:
> >>
> >> Currently there's no PCI-related clean-up code
> >> in acpi_pci_root_remove() function.
> >> This patch introduces function for hostbridge removal,
> >> and brings back pci_stop_bus_devices() function.
> >>
> >> Signed-off-by: Taku Izumi <izumi.taku@jp.fujitsu.com>
> >> ---
> >>  drivers/acpi/pci_bind.c     |    7 +++++++
> >>  drivers/acpi/pci_root.c     |    7 +++++++
> >>  drivers/pci/remove.c        |   27 +++++++++++++++++++++++++++
> >>  include/acpi/acpi_drivers.h |    1 +
> >>  include/linux/pci.h         |    2 ++
> >>  5 files changed, 44 insertions(+)
> >>
> >> Index: Bjorn-next-0903/drivers/pci/remove.c
> >> ===================================================================
> >> --- Bjorn-next-0903.orig/drivers/pci/remove.c
> >> +++ Bjorn-next-0903/drivers/pci/remove.c
> >> @@ -92,3 +92,30 @@ void pci_stop_and_remove_bus_device(stru
> >>         pci_destroy_dev(dev);
> >>  }
> >>  EXPORT_SYMBOL(pci_stop_and_remove_bus_device);
> >> +
> >> +void pci_stop_bus_devices(struct pci_bus *bus)
> >> +{
> >> +       struct pci_dev *dev, *tmp;
> >> +
> >> +       list_for_each_entry_safe_reverse(dev, tmp, &bus->devices, bus_list) {
> >> +               if (dev->subordinate)
> >> +                       pci_stop_bus_devices(dev->subordinate);
> >> +               pci_stop_dev(dev);
> >> +       }
> >> +
> >> +}
> >> +EXPORT_SYMBOL(pci_stop_bus_devices);
> >> +
> >> +void pci_remove_host_bridge(struct pci_host_bridge *bridge)
> >> +{
> >> +       struct pci_bus *root = bridge->bus;
> >> +       struct pci_dev *dev, *tmp;
> >> +
> >> +       list_for_each_entry_safe_reverse(dev, tmp, &root->devices, bus_list)
> >> +               pci_stop_and_remove_bus_device(dev);
> >> +
> >> +       pci_remove_bus(root);
> >> +
> >> +       device_unregister(&bridge->dev);
> >> +}
> >> +EXPORT_SYMBOL(pci_remove_host_bridge);
> >> Index: Bjorn-next-0903/drivers/acpi/pci_root.c
> >> ===================================================================
> >> --- Bjorn-next-0903.orig/drivers/acpi/pci_root.c
> >> +++ Bjorn-next-0903/drivers/acpi/pci_root.c
> >> @@ -652,8 +652,10 @@ static int acpi_pci_root_remove(struct a
> >>  {
> >>         struct acpi_pci_root *root = acpi_driver_data(device);
> >>         struct acpi_pci_driver *driver;
> >> +       struct pci_host_bridge *bridge = to_pci_host_bridge(root->bus->bridge);
> >>
> >>         mutex_lock(&acpi_pci_root_lock);
> >> +       pci_stop_bus_devices(root->bus);
> >>         list_for_each_entry(driver, &acpi_pci_drivers, node)
> >>                 if (driver->remove)
> >>                         driver->remove(root);
> >> @@ -661,6 +663,11 @@ static int acpi_pci_root_remove(struct a
> >>         device_set_run_wake(root->bus->bridge, false);
> >>         pci_acpi_remove_bus_pm_notifier(device);
> >>
> >> +       acpi_pci_irq_del_prt(root->bus);
> >
> > acpi_pci_irq_del_prt() does not actually have a dependency on the
> > struct pci_bus, so I think its interface should be changed so it takes
> > a segment number and a bus number instead of the "struct pci_bus *".
> > The same applies to acpi_pci_irq_add_prt().
> >
> > This basically boils down to reverting 859a3f86ca8 and d9efae3688a.  I
> > acked those changes at the time, but I think they were a mistake.  The
> > reason is that passing in the struct pci_bus * ties them into the host
> > bridge add/remove flow in a way that's not necessary.
> >
> > If we get rid of the struct pci_bus * dependency, then we can easily
> > add the _PRT before doing PCI enumeration behind the bridge, and we
> > can remove the _PRT after removing the PCI devices.  I think this is
> > one small step toward getting rid of the add/start and stop/remove
> > split.
> 
> I'm going to work on doing this if nobody else is interested.

  I'll do that. Maybee that is separeted from this patchset.

  Best regards,
  Taku Izumi

> 
> >> +       acpi_pci_unbind_root(device);
> >> +
> >> +       pci_remove_host_bridge(bridge);
> >> +
> >>         list_del(&root->node);
> >>         mutex_unlock(&acpi_pci_root_lock);
> >>         kfree(root);
> >> Index: Bjorn-next-0903/include/linux/pci.h
> >> ===================================================================
> >> --- Bjorn-next-0903.orig/include/linux/pci.h
> >> +++ Bjorn-next-0903/include/linux/pci.h
> >> @@ -734,6 +734,8 @@ extern struct pci_dev *pci_dev_get(struc
> >>  extern void pci_dev_put(struct pci_dev *dev);
> >>  extern void pci_remove_bus(struct pci_bus *b);
> >>  extern void pci_stop_and_remove_bus_device(struct pci_dev *dev);
> >> +extern void pci_stop_bus_devices(struct pci_bus *bus);
> >> +extern void pci_remove_host_bridge(struct pci_host_bridge *bridge);
> >>  void pci_setup_cardbus(struct pci_bus *bus);
> >>  extern void pci_sort_breadthfirst(void);
> >>  #define dev_is_pci(d) ((d)->bus == &pci_bus_type)
> >> Index: Bjorn-next-0903/drivers/acpi/pci_bind.c
> >> ===================================================================
> >> --- Bjorn-next-0903.orig/drivers/acpi/pci_bind.c
> >> +++ Bjorn-next-0903/drivers/acpi/pci_bind.c
> >> @@ -118,3 +118,10 @@ int acpi_pci_bind_root(struct acpi_devic
> >>
> >>         return 0;
> >>  }
> >> +
> >> +void  acpi_pci_unbind_root(struct acpi_device *device)
> >> +{
> >> +       device->ops.bind = NULL;
> >> +       device->ops.unbind = NULL;
> >> +}
> >> +
> >> Index: Bjorn-next-0903/include/acpi/acpi_drivers.h
> >> ===================================================================
> >> --- Bjorn-next-0903.orig/include/acpi/acpi_drivers.h
> >> +++ Bjorn-next-0903/include/acpi/acpi_drivers.h
> >> @@ -101,6 +101,7 @@ struct pci_bus;
> >>
> >>  struct pci_dev *acpi_get_pci_dev(acpi_handle);
> >>  int acpi_pci_bind_root(struct acpi_device *device);
> >> +void acpi_pci_unbind_root(struct acpi_device *device);
> >>
> >>  /* Arch-defined function to add a bus to the system */
> >>
> >>
> 


-- 
Taku Izumi <izumi.taku@jp.fujitsu.com>

