Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-ig0-f175.google.com ([209.85.213.175]:36029 "EHLO
	mail-ig0-f175.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1161881AbbEEV3I (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Tue, 5 May 2015 17:29:08 -0400
Received: by igblo3 with SMTP id lo3so113352024igb.1
        for <linux-pci@vger.kernel.org>; Tue, 05 May 2015 14:29:08 -0700 (PDT)
Date: Tue, 5 May 2015 16:29:05 -0500
From: Bjorn Helgaas <bhelgaas@google.com>
To: Wei Yang <weiyang@linux.vnet.ibm.com>
Cc: gwshan@linux.vnet.ibm.com, linux-pci@vger.kernel.org
Subject: Re: [PATCH] pci/iov: return a reference to PF on destroying VF
Message-ID: <20150505212905.GB24643@google.com>
References: <1428655984-26903-1-git-send-email-weiyang@linux.vnet.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1428655984-26903-1-git-send-email-weiyang@linux.vnet.ibm.com>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Fri, Apr 10, 2015 at 04:53:04PM +0800, Wei Yang wrote:
> Each VF will get a reference to its PF, while it is not returned back in
> all cases and leave a removed PF's pci_dev un-released.
> 
> As commit ac205b7b ("PCI: make sriov work with hotplug remove") indicates,
> when removing devices on a bus, we do it in the reverse order. This means
> we would remove VFs first, then PFs. After doing so, VF's removal is done
> with pci_stop_and_remove_bus_device() instead of virtfn_remove().
> virtfn_remove() returns the reference of its PF, while
> pci_stop_and_remove_bus_device() doesn't.

Please use conventional citation style (12-char SHA1).

ac205b7bb72f appeared in v3.4.  Did that commit cause a regression?
Should this patch be marked for stable?

"After doing so, VF removal is done with pci_stop_and_remove_device() ..."
After doing what?  After removing the VFs and PFs?  After commit
ac205b7bb72f?

Prior to your patch, the VF reference was released in virtfn_remove(),
which is only called via pci_disable_sriov().  This typically happens in
a driver .remove() method.  The reference is *not* released if we call
pci_stop_and_remove_bus_device(VF) directly, as we would via the
remove_store() (sysfs "remove" file) or hot unplug paths, e.g.,
pciehp_unconfigure_device().

After your patch, the VF reference is released in pci_destroy_dev().  This
is called from pci_disable_sriov(), so it happens in that path as before.
But pci_destroy_dev() is called from pci_stop_and_remove_bus_device(), so
the reference is now released for all the paths that use
pci_stop_and_remove_bus_device().

What about the other things done in virtfn_remove(), e.g., the sysfs link
removal?  Your patch fixes a reference count leak, but don't we still have
a sysfs link leak?

It would be useful to mention a way to cause the leak.  I suspect writing
to a VF's sysfs "remove" file is the easiest.

> This patches moves the return of PF's reference to pci_destroy_dev() to
> make sure the PF's pci_dev is released in any case.
> 
> Signed-off-by: Wei Yang <weiyang@linux.vnet.ibm.com>
> ---
>  drivers/pci/iov.c    |    1 -
>  drivers/pci/remove.c |    5 +++++
>  2 files changed, 5 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/pci/iov.c b/drivers/pci/iov.c
> index 4b3a4ea..9b04bde 100644
> --- a/drivers/pci/iov.c
> +++ b/drivers/pci/iov.c
> @@ -167,7 +167,6 @@ static void virtfn_remove(struct pci_dev *dev, int id, int reset)
>  
>  	/* balance pci_get_domain_bus_and_slot() */
>  	pci_dev_put(virtfn);
> -	pci_dev_put(dev);
>  }
>  
>  static int sriov_enable(struct pci_dev *dev, int nr_virtfn)
> diff --git a/drivers/pci/remove.c b/drivers/pci/remove.c
> index 8bd76c9..836ddf6 100644
> --- a/drivers/pci/remove.c
> +++ b/drivers/pci/remove.c
> @@ -41,6 +41,11 @@ static void pci_destroy_dev(struct pci_dev *dev)
>  	list_del(&dev->bus_list);
>  	up_write(&pci_bus_sem);
>  
> +#ifdef CONFIG_PCI_IOV
> +	if (dev->is_virtfn)
> +		pci_dev_put(dev->physfn);
> +#endif
> +
>  	pci_free_resources(dev);
>  	put_device(&dev->dev);
>  }
> -- 
> 1.7.9.5
> 
