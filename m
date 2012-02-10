Return-Path: <linux-arch-owner@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <CAE9FiQXZqGHAQvrwiMsQsvtDM6ggV1+=uYztV0pNQHh_n8F0rQ@mail.gmail.com>
References: <20120210023424.10311.82445.stgit@bhelgaas.mtv.corp.google.com>
 <20120210023636.10311.79110.stgit@bhelgaas.mtv.corp.google.com> <CAE9FiQXZqGHAQvrwiMsQsvtDM6ggV1+=uYztV0pNQHh_n8F0rQ@mail.gmail.com>
From: Bjorn Helgaas <bhelgaas@google.com>
Date: Thu, 9 Feb 2012 20:37:52 -0800
Message-ID: <CAErSpo76wbkAUGR-S6iC1NBVM4xf8-=-t5KQWvr0jagh1nPpAg@mail.gmail.com>
Subject: Re: [PATCH v2 03/18] PCI: add struct pci_host_bridge_window with
 CPU/bus address offset
To: Yinghai Lu <yinghai@kernel.org>
Cc: linux-pci@vger.kernel.org, linux-arch@vger.kernel.org
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Thu, Feb 9, 2012 at 7:49 PM, Yinghai Lu <yinghai@kernel.org> wrote:
> On Thu, Feb 9, 2012 at 6:36 PM, Bjorn Helgaas <bhelgaas@google.com> wrote:
>> Some PCI host bridges apply an address offset, so bus addresses on PCI are
>> different from CPU addresses.  This patch adds a way for architectures to
>> tell the PCI core about this offset.  For example:
>>
>>    LIST_HEAD(resources);
>>    pci_add_resource_offset(&resources, host->io_space, host->io_offset);
>>    pci_add_resource_offset(&resources, host->mem_space, host->mem_offset);
>>    pci_scan_root_bus(parent, bus, ops, sysdata, &resources);
>>
>> Signed-off-by: Bjorn Helgaas <bhelgaas@google.com>
>> ---
>>  drivers/pci/bus.c   |   30 +++++++++++++++++++-----------
>>  drivers/pci/probe.c |   32 +++++++++++++++++++++++---------
>>  include/linux/pci.h |    9 +++++++++
>>  3 files changed, 51 insertions(+), 20 deletions(-)
>>
>> diff --git a/drivers/pci/bus.c b/drivers/pci/bus.c
>> index 398f5d8..4ce5ef2 100644
>> --- a/drivers/pci/bus.c
>> +++ b/drivers/pci/bus.c
>> @@ -18,28 +18,36 @@
>>
>>  #include "pci.h"
>>
>> -void pci_add_resource(struct list_head *resources, struct resource *res)
>> +void pci_add_resource_offset(struct list_head *resources, struct resource *res,
>> +                            resource_size_t offset)
>>  {
>> -       struct pci_bus_resource *bus_res;
>> +       struct pci_host_bridge_window *window;
>>
>> -       bus_res = kzalloc(sizeof(struct pci_bus_resource), GFP_KERNEL);
>> -       if (!bus_res) {
>> -               printk(KERN_ERR "PCI: can't add bus resource %pR\n", res);
>> +       window = kzalloc(sizeof(struct pci_host_bridge_window), GFP_KERNEL);
>> +       if (!window) {
>> +               printk(KERN_ERR "PCI: can't add host bridge window %pR\n", res);
>>                return;
>>        }
>>
>> -       bus_res->res = res;
>> -       list_add_tail(&bus_res->list, resources);
>> +       window->res = res;
>> +       window->offset = offset;
>> +       list_add_tail(&window->list, resources);
>> +}
>> +EXPORT_SYMBOL(pci_add_resource_offset);
>> +
>> +void pci_add_resource(struct list_head *resources, struct resource *res)
>> +{
>> +       pci_add_resource_offset(resources, res, 0);
>>  }
>>  EXPORT_SYMBOL(pci_add_resource);
>>
>>  void pci_free_resource_list(struct list_head *resources)
>>  {
>> -       struct pci_bus_resource *bus_res, *tmp;
>> +       struct pci_host_bridge_window *window, *tmp;
>>
>> -       list_for_each_entry_safe(bus_res, tmp, resources, list) {
>> -               list_del(&bus_res->list);
>> -               kfree(bus_res);
>> +       list_for_each_entry_safe(window, tmp, resources, list) {
>> +               list_del(&window->list);
>> +               kfree(window);
>>        }
>>  }
>>  EXPORT_SYMBOL(pci_free_resource_list);
>> diff --git a/drivers/pci/probe.c b/drivers/pci/probe.c
>> index 2ffe8a3..69c1b11 100644
>> --- a/drivers/pci/probe.c
>> +++ b/drivers/pci/probe.c
>> @@ -1544,12 +1544,15 @@ unsigned int __devinit pci_scan_child_bus(struct pci_bus *bus)
>>  struct pci_bus *pci_create_root_bus(struct device *parent, int bus,
>>                struct pci_ops *ops, void *sysdata, struct list_head *resources)
>>  {
>> -       int error, i;
>> +       int error;
>>        struct pci_host_bridge *bridge;
>>        struct pci_bus *b, *b2;
>>        struct device *dev;
>> -       struct pci_bus_resource *bus_res, *n;
>> +       struct pci_host_bridge_window *window, *n;
>>        struct resource *res;
>> +       resource_size_t offset;
>> +       char bus_addr[64];
>> +       char *fmt;
>>
>>        bridge = kzalloc(sizeof(*bridge), GFP_KERNEL);
>>        if (!bridge)
>> @@ -1599,19 +1602,30 @@ struct pci_bus *pci_create_root_bus(struct device *parent, int bus,
>>        b->number = b->secondary = bus;
>>
>>        bridge->bus = b;
>> -
>> -       /* Add initial resources to the bus */
>> -       list_for_each_entry_safe(bus_res, n, resources, list)
>> -               list_move_tail(&bus_res->list, &b->resources);
>> +       INIT_LIST_HEAD(&bridge->windows);
>>
>>        if (parent)
>>                dev_info(parent, "PCI host bridge to bus %s\n", dev_name(&b->dev));
>>        else
>>                printk(KERN_INFO "PCI host bridge to bus %s\n", dev_name(&b->dev));
>>
>> -       pci_bus_for_each_resource(b, res, i) {
>> -               if (res)
>> -                       dev_info(&b->dev, "root bus resource %pR\n", res);
>> +       /* Add initial resources to the bus */
>> +       list_for_each_entry_safe(window, n, resources, list) {
>> +               list_move_tail(&window->list, &bridge->windows);
>> +               res = window->res;
>> +               offset = window->offset;
>> +               pci_bus_add_resource(b, res, 0);
>
> you put two copies of root resource list ?

The root bus has a list of resources, as it always has.

The host bridge also has a list that contains the same resources.  In
addition, this list contains the offset the host bridge applies to
each aperture.

So yes, there are two lists, but they are not the same.  I don't think
it makes sense to add the offset information to the resource list of
every bus, because the offset is always zero for P2P bridges.

Bjorn
