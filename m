Return-Path: <linux-kernel-owner@vger.kernel.org>
Date: Fri, 24 Mar 2017 16:34:45 -0500
From: Bjorn Helgaas <helgaas@kernel.org>
To: Christian =?iso-8859-1?Q?K=F6nig?= <deathsimple@vodafone.de>
Cc: linux-pci@vger.kernel.org, dri-devel@lists.freedesktop.org,
        platform-driver-x86@vger.kernel.org, amd-gfx@lists.freedesktop.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/4] PCI: add functionality for resizing resources v2
Message-ID: <20170324213445.GF25380@bhelgaas-glaptop.roam.corp.google.com>
References: <1489408896-25039-1-git-send-email-deathsimple@vodafone.de>
 <1489408896-25039-3-git-send-email-deathsimple@vodafone.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
In-Reply-To: <1489408896-25039-3-git-send-email-deathsimple@vodafone.de>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Mon, Mar 13, 2017 at 01:41:34PM +0100, Christian König wrote:
> From: Christian König <christian.koenig@amd.com>
> 
> This allows device drivers to request resizing their BARs.
> 
> The function only tries to reprogram the windows of the bridge directly above
> the requesting device and only the BAR of the same type (usually mem, 64bit,
> prefetchable). This is done to make sure not to disturb other drivers by
> changing the BARs of their devices.
> 
> If reprogramming the bridge BAR fails the old status is restored and -ENOSPC
> returned to the calling device driver.
> 
> v2: rebase on changes in rbar support
> 
> Signed-off-by: Christian König <christian.koenig@amd.com>
> ---
>  drivers/pci/setup-bus.c | 61 +++++++++++++++++++++++++++++++++++++++++++++++++
>  drivers/pci/setup-res.c | 51 +++++++++++++++++++++++++++++++++++++++++
>  include/linux/pci.h     |  2 ++
>  3 files changed, 114 insertions(+)
> 
> diff --git a/drivers/pci/setup-bus.c b/drivers/pci/setup-bus.c
> index f30ca75..cfab2c7 100644
> --- a/drivers/pci/setup-bus.c
> +++ b/drivers/pci/setup-bus.c
> @@ -1923,6 +1923,67 @@ void pci_assign_unassigned_bridge_resources(struct pci_dev *bridge)
>  }
>  EXPORT_SYMBOL_GPL(pci_assign_unassigned_bridge_resources);
>  
> +int pci_reassign_bridge_resources(struct pci_dev *bridge, unsigned long type)
> +{
> +	const unsigned long type_mask = IORESOURCE_IO | IORESOURCE_MEM |
> +		IORESOURCE_PREFETCH | IORESOURCE_MEM_64;
> +
> +	struct resource saved;
> +	LIST_HEAD(add_list);
> +	LIST_HEAD(fail_head);
> +	struct pci_dev_resource *fail_res;
> +	unsigned i;
> +	int ret = 0;
> +
> +	/* Release all children from the matching bridge resource */
> +	for (i = PCI_BRIDGE_RESOURCES; i < PCI_BRIDGE_RESOURCE_END; ++i) {

Nit: use post-increment unless you need pre-increment.

> +		struct resource *res = &bridge->resource[i];
> +
> +		if ((res->flags & type_mask) != (type & type_mask))
> +			continue;
> +
> +		saved = *res;
> +		if (res->parent) {
> +			release_child_resources(res);

Doesn't this recursively release *all* child resources?  There could
be BARs from several devices, or even windows of downstream bridges,
inside this window.  The drivers of those other devices aren't
expecting things to change here.

> +			release_resource(res);
> +		}
> +		res->start = 0;
> +		res->end = 0;
> +		break;
> +	}
> +
> +	if (i == PCI_BRIDGE_RESOURCE_END)
> +		return -ENOENT;
> +
> +	__pci_bus_size_bridges(bridge->subordinate, &add_list);
> +	__pci_bridge_assign_resources(bridge, &add_list, &fail_head);
> +	BUG_ON(!list_empty(&add_list));
> +
> +	/* restore size and flags */
> +	list_for_each_entry(fail_res, &fail_head, list) {
> +		struct resource *res = fail_res->res;
> +
> +		res->start = fail_res->start;
> +		res->end = fail_res->end;
> +		res->flags = fail_res->flags;
> +	}
> +
> +	/* Revert to the old configuration */
> +	if (!list_empty(&fail_head)) {
> +		struct resource *res = &bridge->resource[i];
> +
> +		res->start = saved.start;
> +		res->end = saved.end;
> +		res->flags = saved.flags;
> +
> +		pci_claim_resource(bridge, i);
> +		ret = -ENOSPC;
> +	}
> +
> +	free_list(&fail_head);
> +	return ret;
> +}
> +
>  void pci_assign_unassigned_bus_resources(struct pci_bus *bus)
>  {
>  	struct pci_dev *dev;
> diff --git a/drivers/pci/setup-res.c b/drivers/pci/setup-res.c
> index 9526e34..3bb1e29 100644
> --- a/drivers/pci/setup-res.c
> +++ b/drivers/pci/setup-res.c
> @@ -363,6 +363,57 @@ int pci_reassign_resource(struct pci_dev *dev, int resno, resource_size_t addsiz
>  	return 0;
>  }
>  
> +int pci_resize_resource(struct pci_dev *dev, int resno, int size)
> +{
> +	struct resource *res = dev->resource + resno;
> +	u32 sizes = pci_rbar_get_possible_sizes(dev, resno);
> +	int old = pci_rbar_get_current_size(dev, resno);
> +	u64 bytes = 1ULL << (size + 20);
> +	int ret = 0;

I think we should fail the request if the device is enabled, i.e., if
the PCI_COMMAND_MEMORY bit is set.  We can't safely change the BAR
while memory decoding is enabled.

I know there's code in pci_std_update_resource() that turns off
PCI_COMMAND_MEMORY, but I think that's a mistake: I think it should
fail when asked to update an enabled BAR the same way
pci_iov_update_resource() does.

I'm not sure why you call pci_reenable_device() below, but I think I
would rather have the driver do something like this:

  pci_disable_device(dev);
  pci_resize_resource(dev, 0, size);
  pci_enable_device(dev);

That way it's very clear to the driver that it must re-read all BARs
after resizing this one.

> +	if (!sizes)
> +		return -ENOTSUPP;
> +
> +	if (!(sizes & (1 << size)))
> +		return -EINVAL;
> +
> +	if (old < 0)
> +		return old;
> +
> +	/* Make sure the resource isn't assigned before making it larger. */
> +	if (resource_size(res) < bytes && res->parent) {
> +		release_resource(res);
> +		res->end = resource_size(res) - 1;
> +		res->start = 0;
> +		if (resno < PCI_BRIDGE_RESOURCES)
> +			pci_update_resource(dev, resno);

Why do we need to write this zero to the BAR?  If PCI_COMMAND_MEMORY
is set, I think this is dangerous, and if it's not set, I think it's
unnecessary.

I think we should set the IORESOURCE_UNSET bit to indicate that the
resource does not have an address assigned to it.  It should get
cleared later anyway, but having IORESOURCE_UNSET will make any debug
messages emitted while reassigning resources make more sense.

> +	}
> +
> +	ret = pci_rbar_set_size(dev, resno, size);
> +	if (ret)
> +		goto error_reassign;
> +
> +	res->end = res->start + bytes - 1;
> +
> +	ret = pci_reassign_bridge_resources(dev->bus->self, res->flags);
> +	if (ret)
> +		goto error_resize;
> +
> +	pci_reenable_device(dev->bus->self);

> +	return 0;
> +
> +error_resize:
> +	pci_rbar_set_size(dev, resno, old);
> +	res->end = res->start + (1ULL << (old + 20)) - 1;
> +
> +error_reassign:
> +	pci_assign_unassigned_bus_resources(dev->bus);
> +	pci_setup_bridge(dev->bus);

Could this bridge-related recovery code go inside
pci_reassign_bridge_resources()?

> +	pci_reenable_device(dev->bus->self);
> +	return ret;
> +}
> +EXPORT_SYMBOL(pci_resize_resource);
> +
>  int pci_enable_resources(struct pci_dev *dev, int mask)
>  {
>  	u16 cmd, old_cmd;
> diff --git a/include/linux/pci.h b/include/linux/pci.h
> index 6954e50..8eaebb4 100644
> --- a/include/linux/pci.h
> +++ b/include/linux/pci.h
> @@ -1055,6 +1055,7 @@ void pci_reset_bridge_secondary_bus(struct pci_dev *dev);
>  void pci_update_resource(struct pci_dev *dev, int resno);
>  int __must_check pci_assign_resource(struct pci_dev *dev, int i);
>  int __must_check pci_reassign_resource(struct pci_dev *dev, int i, resource_size_t add_size, resource_size_t align);
> +int __must_check pci_resize_resource(struct pci_dev *dev, int i, int size);
>  int pci_select_bars(struct pci_dev *dev, unsigned long flags);
>  bool pci_device_is_present(struct pci_dev *pdev);
>  void pci_ignore_hotplug(struct pci_dev *dev);
> @@ -1135,6 +1136,7 @@ void pci_assign_unassigned_resources(void);
>  void pci_assign_unassigned_bridge_resources(struct pci_dev *bridge);
>  void pci_assign_unassigned_bus_resources(struct pci_bus *bus);
>  void pci_assign_unassigned_root_bus_resources(struct pci_bus *bus);
> +int pci_reassign_bridge_resources(struct pci_dev *bridge, unsigned long type);
>  void pdev_enable_device(struct pci_dev *);
>  int pci_enable_resources(struct pci_dev *, int mask);
>  void pci_fixup_irqs(u8 (*)(struct pci_dev *, u8 *),
> -- 
> 2.7.4
> 
