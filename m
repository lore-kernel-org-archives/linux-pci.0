Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-qc0-f175.google.com ([209.85.216.175]:53936 "EHLO
	mail-qc0-f175.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750772Ab3HGEBQ (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Wed, 7 Aug 2013 00:01:16 -0400
Received: by mail-qc0-f175.google.com with SMTP id s11so662118qcv.6
        for <linux-pci@vger.kernel.org>; Tue, 06 Aug 2013 21:01:15 -0700 (PDT)
Date: Tue, 6 Aug 2013 22:01:12 -0600
From: Bjorn Helgaas <bhelgaas@google.com>
To: Yinghai Lu <yinghai@kernel.org>
Cc: linux-pci@vger.kernel.org, Yijing Wang <wangyijing@huawei.com>,
	Jiang Liu <liuj97@gmail.com>,
	Kenji Kaneshige <kaneshige.kenji@jp.fujitsu.com>
Subject: Re: [PATCH v2 2/3] PCI: Separate stop and remove devices in pciehp
Message-ID: <20130807040112.GA14662@google.com>
References: <1374937868-24437-1-git-send-email-yinghai@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1374937868-24437-1-git-send-email-yinghai@kernel.org>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

[+cc Kenji]

On Sat, Jul 27, 2013 at 08:11:06AM -0700, Yinghai Lu wrote:
> commit dc087f2f6a2925e81831f3016b9cbb6e470e7423
> (PCI: Simplify IOV implementation and fix reference count races)
> broke the pcie native hotplug with SRIOV enabled: PF is not freed
> during hot-remove, and later hot-add do not work as old pci_dev
> is still around, and can not create new pci_dev.
> 
> That commit need VFs to be removed via pci_disable_sriov/virtfn_remove
> to make sure ref to PF is put back.

Huh.  I wish we didn't have virtfn_remove() at all.  I wish the
normal device removal path, i.e., pci_stop_and_remove_bus_device(),
could deal with VFs directly.  I don't know all the history there,
so maybe there's some reason that's not feasible.

> So we can not call stop_and_remove for VF before PF, that will
> make VF get removed directly before PF's driver try to use
> pci_disable_sriov/virtfn_remove to do it.
> 
> Solution is separating stop and remove in two iterations.
> 
> In first iteration, we stop VF driver at first with iterating devices
> reversely, and later during stop PF driver, disable_sriov will use
> virtfn_remove to remove VFs.
> 
> Also some driver (like mlx4_core) need VF's driver get stopped before PF's.
> 
> Need this one for v3.11.
> 
> -v2: separate VGA checking to another patch according to Bjorn.
>      and after patches that make pciehp to be built-in
> 
> Signed-off-by: Yinghai Lu <yinghai@kernel.org>
> Cc: Yijing Wang <wangyijing@huawei.com>
> Cc: Jiang Liu <liuj97@gmail.com>
> 
> ---
>  drivers/pci/hotplug/pciehp_pci.c |   15 +++++++++++++--
>  drivers/pci/pci.h                |    3 +++
>  drivers/pci/remove.c             |    4 ++--
>  3 files changed, 18 insertions(+), 4 deletions(-)
> 
> Index: linux-2.6/drivers/pci/hotplug/pciehp_pci.c
> ===================================================================
> --- linux-2.6.orig/drivers/pci/hotplug/pciehp_pci.c
> +++ linux-2.6/drivers/pci/hotplug/pciehp_pci.c
> @@ -109,6 +109,13 @@ int pciehp_unconfigure_device(struct slo
>  	}
>  
>  	/*
> +	 * Now VF need to be removed via virtfn_remove to make
> +	 * sure ref to PF is put back. Some driver (mlx4_core) need
> +	 * VF's driver get stopped before PF.
> +	 * So we need to stop VF driver at first, that means
> +	 * loop reversely, and later during stop PF driver,
> +	 * disable_sriov will use virtfn_remove to remove VFs.
> +	 *
>  	 * Stopping an SR-IOV PF device removes all the associated VFs,
>  	 * which will update the bus->devices list and confuse the
>  	 * iterator.  Therefore, iterate in reverse so we remove the VFs
> @@ -116,8 +123,7 @@ int pciehp_unconfigure_device(struct slo
>  	 */
>  	list_for_each_entry_safe_reverse(dev, temp, &parent->devices,
>  					 bus_list) {
> -		pci_dev_get(dev);
> -		pci_stop_and_remove_bus_device(dev);
> +		pci_stop_bus_device(dev);
>  		/*
>  		 * Ensure that no new Requests will be generated from
>  		 * the device.
> @@ -128,6 +134,11 @@ int pciehp_unconfigure_device(struct slo
>  			command |= PCI_COMMAND_INTX_DISABLE;
>  			pci_write_config_word(dev, PCI_COMMAND, command);

This "disable bus mastering, SERR reporting, and INTx" stuff seems
like it's in the wrong place.  I don't think it's specific to
pciehp, and it seems like it should be in the generic PCI device
removal path.  Kenji added it with 2326e2b99, "in accordance with
the specification," but I don't know specifically what he was
referring to.

But this isn't trivial and it's not part of your patch, so we can
worry about that later.

>  		}
> +	}
> +
> +	list_for_each_entry_safe(dev, temp, &parent->devices, bus_list) {
> +		pci_dev_get(dev);
> +		pci_remove_bus_device(dev);
>  		pci_dev_put(dev);

I don't see the point of the pci_dev_get()/pci_dev_put() here.  It
doesn't do anything useful, does it?

The pci_dev_get() doesn't help: it will keep a racing path from
removing the dev *after* we call pci_dev_get(), but that racing path
could just as easily remove the dev *before* we call pci_dev_get().

And there's no reason to hold onto a reference after we call
pci_remove_bus_device(), because we don't do anything else with the
device before we call pci_dev_put().

>  	}
>  
> Index: linux-2.6/drivers/pci/remove.c
> ===================================================================
> --- linux-2.6.orig/drivers/pci/remove.c
> +++ linux-2.6/drivers/pci/remove.c
> @@ -56,7 +56,7 @@ void pci_remove_bus(struct pci_bus *bus)
>  }
>  EXPORT_SYMBOL(pci_remove_bus);
>  
> -static void pci_stop_bus_device(struct pci_dev *dev)
> +void pci_stop_bus_device(struct pci_dev *dev)
>  {
>  	struct pci_bus *bus = dev->subordinate;
>  	struct pci_dev *child, *tmp;
> @@ -76,7 +76,7 @@ static void pci_stop_bus_device(struct p
>  	pci_stop_dev(dev);
>  }
>  
> -static void pci_remove_bus_device(struct pci_dev *dev)
> +void pci_remove_bus_device(struct pci_dev *dev)
>  {
>  	struct pci_bus *bus = dev->subordinate;
>  	struct pci_dev *child, *tmp;
> Index: linux-2.6/drivers/pci/pci.h
> ===================================================================
> --- linux-2.6.orig/drivers/pci/pci.h
> +++ linux-2.6/drivers/pci/pci.h
> @@ -317,4 +317,7 @@ static inline int pci_dev_specific_reset
>  }
>  #endif
>  
> +void pci_stop_bus_device(struct pci_dev *dev);
> +void pci_remove_bus_device(struct pci_dev *dev);
> +
>  #endif /* DRIVERS_PCI_H */
