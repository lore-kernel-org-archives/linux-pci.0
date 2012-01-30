Return-Path: <linux-arch-owner@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <20120130165719.3231.43751.stgit@bhelgaas.mtv.corp.google.com>
References: <20120130165430.3231.97740.stgit@bhelgaas.mtv.corp.google.com>
	<20120130165719.3231.43751.stgit@bhelgaas.mtv.corp.google.com>
Date: Mon, 30 Jan 2012 12:52:24 -0800
Message-ID: <CAE9FiQUXjjk=twgwWVB01JMD9GokEVjOoiRLYZYRTPSPXHYfFw@mail.gmail.com>
Subject: Re: [RFC PATCH v1 02/18] PCI: add struct pci_host_bridge and a list
 of all bridges found
From: Yinghai Lu <yinghai@kernel.org>
To: Bjorn Helgaas <bhelgaas@google.com>
Cc: linux-pci@vger.kernel.org, linux-arch@vger.kernel.org
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Mon, Jan 30, 2012 at 8:57 AM, Bjorn Helgaas <bhelgaas@google.com> wrote:
> This adds a list of all PCI host bridges we find and a way to look up
> the host bridge from a pci_dev.
> ---
>  drivers/pci/probe.c |   39 ++++++++++++++++++++++++++++++++++-----
>  include/linux/pci.h |    5 +++++
>  2 files changed, 39 insertions(+), 5 deletions(-)
>
> diff --git a/drivers/pci/probe.c b/drivers/pci/probe.c
> index da0d655..2ffe8a3 100644
> --- a/drivers/pci/probe.c
> +++ b/drivers/pci/probe.c
> @@ -15,6 +15,8 @@
>  #define CARDBUS_LATENCY_TIMER  176     /* secondary latency timer */
>  #define CARDBUS_RESERVE_BUSNR  3
>
> +static LIST_HEAD(pci_host_bridges);
> +
>  /* Ugh.  Need to stop exporting this to modules. */
>  LIST_HEAD(pci_root_buses);
>  EXPORT_SYMBOL(pci_root_buses);
> @@ -42,6 +44,23 @@ int no_pci_devices(void)
>  }
>  EXPORT_SYMBOL(no_pci_devices);
>
> +static struct pci_host_bridge *pci_host_bridge(struct pci_dev *dev)
> +{
> +       struct pci_bus *bus;
> +       struct pci_host_bridge *bridge;
> +
> +       bus = dev->bus;
> +       while (bus->parent)
> +               bus = bus->parent;
> +
> +       list_for_each_entry(bridge, &pci_host_bridges, list) {
> +               if (bridge->bus == bus)
> +                       return bridge;
> +       }
> +
> +       return NULL;
> +}
> +
>  /*
>  * PCI Bus Class
>  */
> @@ -1526,20 +1545,23 @@ struct pci_bus *pci_create_root_bus(struct device *parent, int bus,
>                struct pci_ops *ops, void *sysdata, struct list_head *resources)
>  {
>        int error, i;
> +       struct pci_host_bridge *bridge;
>        struct pci_bus *b, *b2;
>        struct device *dev;
>        struct pci_bus_resource *bus_res, *n;
>        struct resource *res;
>
> +       bridge = kzalloc(sizeof(*bridge), GFP_KERNEL);
> +       if (!bridge)
> +               return NULL;
> +
>        b = pci_alloc_bus();
>        if (!b)
> -               return NULL;
> +               goto err_bus;
>
>        dev = kzalloc(sizeof(*dev), GFP_KERNEL);
> -       if (!dev) {
> -               kfree(b);
> -               return NULL;
> -       }
> +       if (!dev)
> +               goto err_dev;
>
>        b->sysdata = sysdata;
>        b->ops = ops;
> @@ -1576,6 +1598,8 @@ struct pci_bus *pci_create_root_bus(struct device *parent, int bus,
>
>        b->number = b->secondary = bus;
>
> +       bridge->bus = b;
> +
>        /* Add initial resources to the bus */
>        list_for_each_entry_safe(bus_res, n, resources, list)
>                list_move_tail(&bus_res->list, &b->resources);
> @@ -1591,6 +1615,7 @@ struct pci_bus *pci_create_root_bus(struct device *parent, int bus,
>        }
>
>        down_write(&pci_bus_sem);
> +       list_add_tail(&bridge->list, &pci_host_bridges);
>        list_add_tail(&b->node, &pci_root_buses);
>        up_write(&pci_bus_sem);

we already have list for root_bus. So there will be two lists.

wonder if we can overload bus->self point to struct host_bridge.

or just do not add host_bridge , and instead only add another field
like struct list_head windows in pci_sysdata?

Thanks

Yinghai
