Return-Path: <linux-arch-owner@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <CAE9FiQXtYfcqjSKLxiYqgtMfqZts2kvM8G1M5Kw0VemmtvTBPA@mail.gmail.com>
References: <20120210023424.10311.82445.stgit@bhelgaas.mtv.corp.google.com>
 <20120210023631.10311.37307.stgit@bhelgaas.mtv.corp.google.com> <CAE9FiQXtYfcqjSKLxiYqgtMfqZts2kvM8G1M5Kw0VemmtvTBPA@mail.gmail.com>
From: Bjorn Helgaas <bhelgaas@google.com>
Date: Thu, 9 Feb 2012 20:16:49 -0800
Message-ID: <CAErSpo4Wu+BSDymLmN0r-z2bLeYnD_9P96PtR6tEGKFkxWwLDg@mail.gmail.com>
Subject: Re: [PATCH v2 02/18] PCI: add struct pci_host_bridge and a list of
 all bridges found
To: Yinghai Lu <yinghai@kernel.org>
Cc: linux-pci@vger.kernel.org, linux-arch@vger.kernel.org
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Thu, Feb 9, 2012 at 7:47 PM, Yinghai Lu <yinghai@kernel.org> wrote:
> On Thu, Feb 9, 2012 at 6:36 PM, Bjorn Helgaas <bhelgaas@google.com> wrote:
>> This adds a list of all PCI host bridges we find and a way to look up
>> the host bridge from a pci_dev.
>>
>> Signed-off-by: Bjorn Helgaas <bhelgaas@google.com>
>> ---
>>  drivers/pci/probe.c |   39 ++++++++++++++++++++++++++++++++++-----
>>  include/linux/pci.h |    5 +++++
>>  2 files changed, 39 insertions(+), 5 deletions(-)
>>
>> diff --git a/drivers/pci/probe.c b/drivers/pci/probe.c
>> index da0d655..2ffe8a3 100644
>> --- a/drivers/pci/probe.c
>> +++ b/drivers/pci/probe.c
>> @@ -15,6 +15,8 @@
>>  #define CARDBUS_LATENCY_TIMER  176     /* secondary latency timer */
>>  #define CARDBUS_RESERVE_BUSNR  3
>>
>> +static LIST_HEAD(pci_host_bridges);
>> +
>>  /* Ugh.  Need to stop exporting this to modules. */
>>  LIST_HEAD(pci_root_buses);
>>  EXPORT_SYMBOL(pci_root_buses);
>> @@ -42,6 +44,23 @@ int no_pci_devices(void)
>>  }
>>  EXPORT_SYMBOL(no_pci_devices);
>>
>> +static struct pci_host_bridge *pci_host_bridge(struct pci_dev *dev)
>> +{
>> +       struct pci_bus *bus;
>> +       struct pci_host_bridge *bridge;
>> +
>> +       bus = dev->bus;
>> +       while (bus->parent)
>> +               bus = bus->parent;
>> +
>> +       list_for_each_entry(bridge, &pci_host_bridges, list) {
>> +               if (bridge->bus == bus)
>> +                       return bridge;
>> +       }
>> +
>> +       return NULL;
>> +}
>> +
>
> so pci_host_bridge(dev) still is expensive.

Yes, it is relatively expensive.  However, it is used only when
converting between bus addresses and CPU addresses, which is done
rarely.  We only do it when reading or writing a BAR.  I suppose one
could add a pointer to struct pci_bus or something, but I don't think
it's worth it.

>>  /*
>>  * PCI Bus Class
>>  */
>> @@ -1526,20 +1545,23 @@ struct pci_bus *pci_create_root_bus(struct device *parent, int bus,
>>                struct pci_ops *ops, void *sysdata, struct list_head *resources)
>>  {
>>        int error, i;
>> +       struct pci_host_bridge *bridge;
>>        struct pci_bus *b, *b2;
>>        struct device *dev;
>>        struct pci_bus_resource *bus_res, *n;
>>        struct resource *res;
>>
>> +       bridge = kzalloc(sizeof(*bridge), GFP_KERNEL);
>> +       if (!bridge)
>> +               return NULL;
>> +
>>        b = pci_alloc_bus();
>>        if (!b)
>> -               return NULL;
>> +               goto err_bus;
>>
>>        dev = kzalloc(sizeof(*dev), GFP_KERNEL);
>> -       if (!dev) {
>> -               kfree(b);
>> -               return NULL;
>> -       }
>> +       if (!dev)
>> +               goto err_dev;
>>
>>        b->sysdata = sysdata;
>>        b->ops = ops;
>> @@ -1576,6 +1598,8 @@ struct pci_bus *pci_create_root_bus(struct device *parent, int bus,
>>
>>        b->number = b->secondary = bus;
>>
>> +       bridge->bus = b;
>> +
>>        /* Add initial resources to the bus */
>>        list_for_each_entry_safe(bus_res, n, resources, list)
>>                list_move_tail(&bus_res->list, &b->resources);
>> @@ -1591,6 +1615,7 @@ struct pci_bus *pci_create_root_bus(struct device *parent, int bus,
>>        }
>>
>>        down_write(&pci_bus_sem);
>> +       list_add_tail(&bridge->list, &pci_host_bridges);
>>        list_add_tail(&b->node, &pci_root_buses);
>>        up_write(&pci_bus_sem);
>>
>> @@ -1600,11 +1625,15 @@ class_dev_reg_err:
>>        device_unregister(dev);
>>  dev_reg_err:
>>        down_write(&pci_bus_sem);
>> +       list_del(&bridge->list);
>>        list_del(&b->node);
>>        up_write(&pci_bus_sem);
>>  err_out:
>>        kfree(dev);
>> +err_dev:
>>        kfree(b);
>> +err_bus:
>> +       kfree(bridge);
>>        return NULL;
>>  }
>>
>> diff --git a/include/linux/pci.h b/include/linux/pci.h
>> index a16b1df..dfb2b64 100644
>> --- a/include/linux/pci.h
>> +++ b/include/linux/pci.h
>> @@ -388,6 +388,11 @@ static inline void pci_add_saved_cap(struct pci_dev *pci_dev,
>>        hlist_add_head(&new_cap->next, &pci_dev->saved_cap_space);
>>  }
>>
>> +struct pci_host_bridge {
>> +       struct list_head list;
>> +       struct pci_bus *bus;            /* root bus */
>> +};
>> +
>
> also still have two list: one for host bridges and one for root buses.

Yes.

You previously suggested overloading bus->self.  Currently bus->self
is null for root buses.  For non-root buses, it points to the pci_dev
of the upstream P2P bridge.  So I think you're suggesting that for
root buses, bus->self could point to a struct pci_host_bridge, even
though its type is "struct pci_dev *".  That seems ugly to me.  If
that's not what you mean, can you show an example to help me
understand?

You also suggested adding a "struct pci_host_bridge *" to pci_sysdata.
 That's an x86-specific structure, so doesn't help here, since what
I'm doing is shared across all architectures.

I do agree that the list of host bridges and the list of root buses
are somewhat redundant.  Obviously, it would be trivial to drop the
root bus list and replace it with the host bridge list, and that might
be a good thing to do in the future.

If you have a suggestion here, please write more about it so I can
understand it.

Bjorn
