Return-Path: <linux-acpi-owner@vger.kernel.org>
Date: Fri, 14 Sep 2012 13:35:01 +0900
From: Taku Izumi <izumi.taku@jp.fujitsu.com>
To: Bjorn Helgaas <bhelgaas@google.com>
Cc: linux-pci@vger.kernel.org, linux-acpi@vger.kernel.org,
	kaneshige.kenji@jp.fujitsu.com, yinghai@kernel.org,
	jiang.liu@huawei.com
Subject: Re: [PATCH v2 4/6] ACPI, PCI: add acpi_pci_roots protection
Message-Id: <20120914133501.e17d1395.izumi.taku@jp.fujitsu.com>
In-Reply-To: <CAErSpo54LO_mow3dNSJ2-Aj4xBs=Zrk9fiAuFzZKdh9=YKyWuA@mail.gmail.com>
References: <20120903165831.29aed72c.izumi.taku@jp.fujitsu.com>
	<20120903170602.375b00cc.izumi.taku@jp.fujitsu.com>
	<CAErSpo54LO_mow3dNSJ2-Aj4xBs=Zrk9fiAuFzZKdh9=YKyWuA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-acpi-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Wed, 12 Sep 2012 17:40:45 -0600
Bjorn Helgaas <bhelgaas@google.com> wrote:

> On Mon, Sep 3, 2012 at 2:06 AM, Taku Izumi <izumi.taku@jp.fujitsu.com> wrote:
> > Use mutex and RCU to protect global acpi_pci_roots list against
> > PCI host bridge hotplug operations.
> >
> > RCU is used to avoid possible deadlock in function acpi_pci_find_root()
> > and acpi_get_pci_rootbridge_handle(). A possible call graph:
> > acpi_pci_register_driver()
> >         mutex_lock(&acpi_pci_root_lock)
> >                 driver->add(root)
> >                         ......
> >                                 acpi_pci_find_root()
> 
> Where does this path occur?  I didn't see in in the current tree
> (where the only users of acpi_pci_register_driver() are for
> acpi_pci_slot_driver and acpi_pci_hp_driver).  Maybe it's in Yinghai's
> work, which adds more acpi_pci_register_driver() users.

  First I protected acpi_pci_roots list by using mutex(acpi_pci_root_lock).
  In that case I faced deadlock at the following path:
  acpiphp_glue_init
     + acpi_pci_register_driver
       ...
         + add_bridge
           + acpi_pci_find_root

  So I used RCU instead.

> RCU seems unnecessarily complicated for this list, but I haven't gone
> through Yinghai's work yet, so I don't know what it requires.
> 
> In acpi_pci_root_start() and acpi_pci_root_remove(), we have the
> struct acpi_pci_root, which has all sorts of information that would be
> useful to the .add() and .remove() methods of sub-drivers.  It seems
> sort of stupid that we only pass the acpi_handle to the sub-drivers,
> forcing them to use hacks like acpi_pci_find_root() to look up the
> information we just threw away.  Can we just fix the .add() and
> .remove() interfaces to pass something more useful so we avoid the
> need for this deadlock path?

  Maybe yes. Do you prefer imprementation without RCU ?

  Best regards,
  Taku Izumi
> 
> > Signed-off-by: Jiang Liu <jiang.liu@huawei.com>
> > Signed-off-by: Yinghai Lu <yinghai@kernel.org>
> > Signed-off-by: Taku Izumi <izumi.taku@jp.fujitsu.com>
> > ---
> >  drivers/acpi/pci_root.c |   50 +++++++++++++++++++++++++++++++-----------------
> >  1 file changed, 33 insertions(+), 17 deletions(-)
> >
> > Index: Bjorn-next-0903/drivers/acpi/pci_root.c
> > ===================================================================
> > --- Bjorn-next-0903.orig/drivers/acpi/pci_root.c
> > +++ Bjorn-next-0903/drivers/acpi/pci_root.c
> > @@ -28,6 +28,7 @@
> >  #include <linux/init.h>
> >  #include <linux/types.h>
> >  #include <linux/mutex.h>
> > +#include <linux/rculist.h>
> >  #include <linux/pm.h>
> >  #include <linux/pm_runtime.h>
> >  #include <linux/pci.h>
> > @@ -86,7 +87,7 @@ int acpi_pci_register_driver(struct acpi
> >         mutex_lock(&acpi_pci_root_lock);
> >         list_add_tail(&driver->node, &acpi_pci_drivers);
> >         if (driver->add)
> > -               list_for_each_entry(root, &acpi_pci_roots, node) {
> > +               list_for_each_entry_rcu(root, &acpi_pci_roots, node) {
> >                         driver->add(root->device->handle);
> >                         n++;
> >                 }
> > @@ -103,7 +104,7 @@ void acpi_pci_unregister_driver(struct a
> >         mutex_lock(&acpi_pci_root_lock);
> >         list_del(&driver->node);
> >         if (driver->remove)
> > -               list_for_each_entry(root, &acpi_pci_roots, node)
> > +               list_for_each_entry_rcu(root, &acpi_pci_roots, node)
> >                         driver->remove(root->device->handle);
> >         mutex_unlock(&acpi_pci_root_lock);
> >  }
> > @@ -112,14 +113,19 @@ EXPORT_SYMBOL(acpi_pci_unregister_driver
> >  acpi_handle acpi_get_pci_rootbridge_handle(unsigned int seg, unsigned int bus)
> >  {
> >         struct acpi_pci_root *root;
> > +       struct acpi_handle *handle = NULL;
> >
> > -       list_for_each_entry(root, &acpi_pci_roots, node)
> > +       rcu_read_lock();
> > +       list_for_each_entry_rcu(root, &acpi_pci_roots, node)
> >                 if ((root->segment == (u16) seg) &&
> > -                   (root->secondary.start == (u16) bus))
> > -                       return root->device->handle;
> > -       return NULL;
> > -}
> > +                   (root->secondary.start == (u16) bus)) {
> > +                       handle = root->device->handle;
> > +                       break;
> > +               }
> > +       rcu_read_unlock();
> >
> > +       return handle;
> > +}
> >  EXPORT_SYMBOL_GPL(acpi_get_pci_rootbridge_handle);
> >
> >  /**
> > @@ -266,10 +272,14 @@ struct acpi_pci_root *acpi_pci_find_root
> >  {
> >         struct acpi_pci_root *root;
> >
> > -       list_for_each_entry(root, &acpi_pci_roots, node) {
> > -               if (root->device->handle == handle)
> > +       rcu_read_lock();
> > +       list_for_each_entry_rcu(root, &acpi_pci_roots, node)
> > +               if (root->device->handle == handle) {
> > +                       rcu_read_unlock();
> >                         return root;
> > -       }
> > +               }
> > +       rcu_read_unlock();
> > +
> >         return NULL;
> >  }
> >  EXPORT_SYMBOL_GPL(acpi_pci_find_root);
> > @@ -506,8 +516,9 @@ static int __devinit acpi_pci_root_add(s
> >          * TBD: Need PCI interface for enumeration/configuration of roots.
> >          */
> >
> > -       /* TBD: Locking */
> > -       list_add_tail(&root->node, &acpi_pci_roots);
> > +       mutex_lock(&acpi_pci_root_lock);
> > +       list_add_tail_rcu(&root->node, &acpi_pci_roots);
> > +       mutex_unlock(&acpi_pci_root_lock);
> >
> >         printk(KERN_INFO PREFIX "%s [%s] (domain %04x %pR)\n",
> >                acpi_device_name(device), acpi_device_bid(device),
> > @@ -526,7 +537,7 @@ static int __devinit acpi_pci_root_add(s
> >                             "Bus %04x:%02x not present in PCI namespace\n",
> >                             root->segment, (unsigned int)root->secondary.start);
> >                 result = -ENODEV;
> > -               goto end;
> > +               goto out_del_root;
> >         }
> >
> >         /*
> > @@ -536,7 +547,7 @@ static int __devinit acpi_pci_root_add(s
> >          */
> >         result = acpi_pci_bind_root(device);
> >         if (result)
> > -               goto end;
> > +               goto out_del_root;
> >
> >         /*
> >          * PCI Routing Table
> > @@ -614,9 +625,12 @@ static int __devinit acpi_pci_root_add(s
> >
> >         return 0;
> >
> > +out_del_root:
> > +       mutex_lock(&acpi_pci_root_lock);
> > +       list_del_rcu(&root->node);
> > +       mutex_unlock(&acpi_pci_root_lock);
> > +       synchronize_rcu();
> >  end:
> > -       if (!list_empty(&root->node))
> > -               list_del(&root->node);
> >         kfree(root);
> >         return result;
> >  }
> > @@ -646,11 +660,13 @@ static int acpi_pci_root_remove(struct a
> >         list_for_each_entry(driver, &acpi_pci_drivers, node)
> >                 if (driver->remove)
> >                         driver->remove(root->device->handle);
> > -       mutex_unlock(&acpi_pci_root_lock);
> >
> >         device_set_run_wake(root->bus->bridge, false);
> >         pci_acpi_remove_bus_pm_notifier(device);
> >
> > +       list_del_rcu(&root->node);
> > +       mutex_unlock(&acpi_pci_root_lock);
> > +       synchronize_rcu();
> >         kfree(root);
> >         return 0;
> >  }
> >
> 


-- 
Taku Izumi <izumi.taku@jp.fujitsu.com>

