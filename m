Return-Path: <linux-acpi-owner@vger.kernel.org>
From: "Rafael J. Wysocki" <rjw@rjwysocki.net>
To: Yinghai Lu <yinghai@kernel.org>
Cc: Bjorn Helgaas <bhelgaas@google.com>,
	David Miller <davem@davemloft.net>,
	Benjamin Herrenschmidt <benh@kernel.crashing.org>,
	Wei Yang <weiyang@linux.vnet.ibm.com>, TJ <linux@iam.tj>,
	Yijing Wang <wangyijing@huawei.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	"linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
	Len Brown <lenb@kernel.org>,
	ACPI Devel Maling List <linux-acpi@vger.kernel.org>
Subject: Re: [PATCH v4 13/52] PCI, acpiphp: Add missing realloc list checking after resource allocation
Date: Tue, 25 Aug 2015 02:37:13 +0200
Message-ID: <3540278.fBlMDMjYYH@vostro.rjw.lan>
In-Reply-To: <CAE9FiQWW_zzZGoq-rrbe+R==-xwRHMkTAtFRGGkN-GK-F6NWsg@mail.gmail.com>
References: <1440138067-4314-1-git-send-email-yinghai@kernel.org> <205780224.0d92UNafyF@vostro.rjw.lan> <CAE9FiQWW_zzZGoq-rrbe+R==-xwRHMkTAtFRGGkN-GK-F6NWsg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Sender: linux-acpi-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Monday, August 24, 2015 03:14:26 PM Yinghai Lu wrote:
> On Mon, Aug 24, 2015 at 3:09 PM, Rafael J. Wysocki <rjw@rjwysocki.net> wrote:
> > On Thursday, August 20, 2015 11:20:28 PM Yinghai Lu wrote:
> >> We check the realloc list, as list must be empty after allocation.
> >>
> >> Add missing one acpiphp driver.
> >>
> >> Signed-off-by: Yinghai Lu <yinghai@kernel.org>
> >> Cc: "Rafael J. Wysocki" <rjw@rjwysocki.net>
> >> Cc: Len Brown <lenb@kernel.org>
> >> Cc: linux-acpi@vger.kernel.org
> >> ---
> >>  drivers/pci/hotplug/acpiphp_glue.c | 1 +
> >>  1 file changed, 1 insertion(+)
> >>
> >> diff --git a/drivers/pci/hotplug/acpiphp_glue.c b/drivers/pci/hotplug/acpiphp_glue.c
> >> index ff53856..1c7c1d7 100644
> >> --- a/drivers/pci/hotplug/acpiphp_glue.c
> >> +++ b/drivers/pci/hotplug/acpiphp_glue.c
> >> @@ -507,6 +507,7 @@ static void enable_slot(struct acpiphp_slot *slot)
> >>               }
> >>       }
> >>       __pci_bus_assign_resources(bus, &add_list, NULL);
> >> +     BUG_ON(!list_empty(&add_list));
> >
> > Is crashing the kernel the best we can do here?
> >
> > What about bailing out with a WARN_ON() instead?  Surely, the kernel can work
> > without the new device?
> 
> That should not happen.
> If that list is not empty, we could have broken the assign logic for
> optional or additional
> resource allocation.
> 
> We have other two BUG_ON checking in drivers/pci/setup-bus.c.
> 
> Do we need to change them all to WARN_ON()?
> 
> or you prefer this version instead:

I like this patch better, but the question really is how bad things can get
if we continue.  And if they can get critically bad, whether or not we still
are able to catch that critical error later on.

> ---
> 
> Subject: [PATCH] PCI: Separate realloc list checking after allocation
> 
> We check the realloc list, as list must be empty after allocation.
> 
> Separate the realloc list checking to another function.
> 
> Add checking that is missed in acpiphp driver.
> 
> -v2: change to WARN_ON addording to Rafael.
> 
> Signed-off-by: Yinghai Lu <yinghai@kernel.org>
> Cc: "Rafael J. Wysocki" <rjw@rjwysocki.net>
> Cc: Len Brown <lenb@kernel.org>
> Cc: linux-acpi@vger.kernel.org
> ---
>  drivers/pci/hotplug/acpiphp_glue.c |    1 +
>  drivers/pci/pci.h                  |    1 +
>  drivers/pci/setup-bus.c            |   12 +++++++++---
>  3 files changed, 11 insertions(+), 3 deletions(-)
> 
> Index: linux-2.6/drivers/pci/hotplug/acpiphp_glue.c
> ===================================================================
> --- linux-2.6.orig/drivers/pci/hotplug/acpiphp_glue.c
> +++ linux-2.6/drivers/pci/hotplug/acpiphp_glue.c
> @@ -507,6 +507,7 @@ static void enable_slot(struct acpiphp_s
>          }
>      }
>      __pci_bus_assign_resources(bus, &add_list, NULL);
> +    pci_bus_check_realloc(&add_list);
> 
>      acpiphp_sanitize_bus(bus);
>      pcie_bus_configure_settings(bus);
> Index: linux-2.6/drivers/pci/pci.h
> ===================================================================
> --- linux-2.6.orig/drivers/pci/pci.h
> +++ linux-2.6/drivers/pci/pci.h
> @@ -237,6 +237,7 @@ void __pci_bus_size_bridges(struct pci_b
>  void __pci_bus_assign_resources(const struct pci_bus *bus,
>                  struct list_head *realloc_head,
>                  struct list_head *fail_head);
> +void pci_bus_check_realloc(struct list_head *realloc_head);
>  bool pci_bus_clip_resource(struct pci_dev *dev, int idx);
> 
>  void pci_reassigndev_resource_alignment(struct pci_dev *dev);
> Index: linux-2.6/drivers/pci/setup-bus.c
> ===================================================================
> --- linux-2.6.orig/drivers/pci/setup-bus.c
> +++ linux-2.6/drivers/pci/setup-bus.c
> @@ -349,6 +349,12 @@ out:
>      }
>  }
> 
> +void pci_bus_check_realloc(struct list_head *realloc_head)
> +{
> +    if (WARN_ON(!list_empty(realloc_head)))
> +        free_list(realloc_head);
> +}
> +
>  /**
>   * assign_requested_resources_sorted() - satisfy resource requests
>   *
> @@ -1860,7 +1866,7 @@ again:
>      /* Depth last, allocate resources and update the hardware. */
>      __pci_bus_assign_resources(bus, add_list, &fail_head);
>      if (add_list)
> -        BUG_ON(!list_empty(add_list));
> +        pci_bus_check_realloc(add_list);
>      tried_times++;
> 
>      /* any device complain? */
> @@ -1935,7 +1941,7 @@ void pci_assign_unassigned_bridge_resour
>  again:
>      __pci_bus_size_bridges(parent, &add_list);
>      __pci_bridge_assign_resources(bridge, &add_list, &fail_head);
> -    BUG_ON(!list_empty(&add_list));
> +    pci_bus_check_realloc(&add_list);
>      tried_times++;
> 
>      if (list_empty(&fail_head))
> @@ -1994,6 +2000,6 @@ void pci_assign_unassigned_bus_resources
>                               &add_list);
>      up_read(&pci_bus_sem);
>      __pci_bus_assign_resources(bus, &add_list, NULL);
> -    BUG_ON(!list_empty(&add_list));
> +    pci_bus_check_realloc(&add_list);
>  }
>  EXPORT_SYMBOL_GPL(pci_assign_unassigned_bus_resources);

