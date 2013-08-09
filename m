Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-pa0-f53.google.com ([209.85.220.53]:48387 "EHLO
	mail-pa0-f53.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751569Ab3HIREK (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Fri, 9 Aug 2013 13:04:10 -0400
Received: by mail-pa0-f53.google.com with SMTP id lb1so5108249pab.40
        for <linux-pci@vger.kernel.org>; Fri, 09 Aug 2013 10:04:09 -0700 (PDT)
Date: Fri, 9 Aug 2013 11:04:04 -0600
From: Bjorn Helgaas <bhelgaas@google.com>
To: Yinghai Lu <yinghai@kernel.org>
Cc: "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
	Yijing Wang <wangyijing@huawei.com>,
	Jiang Liu <liuj97@gmail.com>,
	Kenji Kaneshige <kaneshige.kenji@jp.fujitsu.com>
Subject: Re: [PATCH v2 2/3] PCI: Separate stop and remove devices in pciehp
Message-ID: <20130809170404.GA29690@google.com>
References: <1374937868-24437-1-git-send-email-yinghai@kernel.org>
 <20130807040112.GA14662@google.com>
 <CAE9FiQVXhg299RKsoa8eCqoN7b9c0HaeTGHCnxQY=9vkSYaJJg@mail.gmail.com>
 <CAE9FiQWftukxyNiyM2znVPh7x82de3nhRMQwGHigZtOvU6xQ6g@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <CAE9FiQWftukxyNiyM2znVPh7x82de3nhRMQwGHigZtOvU6xQ6g@mail.gmail.com>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Wed, Aug 07, 2013 at 06:49:25PM -0700, Yinghai Lu wrote:
> On Tue, Aug 6, 2013 at 11:34 PM, Yinghai Lu <yinghai@kernel.org> wrote:
> > On Tue, Aug 6, 2013 at 9:01 PM, Bjorn Helgaas <bhelgaas@google.com> wrote:
> >>
> >> Huh.  I wish we didn't have virtfn_remove() at all.  I wish the
> >> normal device removal path, i.e., pci_stop_and_remove_bus_device(),
> >> could deal with VFs directly.  I don't know all the history there,
> >> so maybe there's some reason that's not feasible.
> >
> > I had one draft version, but looks more confusing.
> 
> please check attached that make pci_stop_and_remove_bus_device()
> could be used with VF.
> 
> It could replace
> https://patchwork.kernel.org/patch/2834638/
> https://patchwork.kernel.org/patch/2834639/
> 
> Please choose one of the solutions.
> 
> but we still need
> https://patchwork.kernel.org/patch/2834640/
> as VFs that does not use ARI could be on other virtual bus.
> so they will not be removed directly.

[I inlined your patch below for convenience]

> Subject: [PATCH] PCI: Release PF ref during removing VF
> From: Yinghai Lu <yinghai@kernel.org>
> 
> commit dc087f2f6a2925e81831f3016b9cbb6e470e7423
> (PCI: Simplify IOV implementation and fix reference count races)
> broke the pcie native hotplug with SRIOV enabled: PF is not freed
> during hot-remove, and later hot-add do not work as old pci_dev
> is still around, and can not create new pci_dev.
> 
> That commit need VFs to be removed via pci_disable_sriov/virtfn_remove
> to make sure ref to PF is put back.
> 
> So we can not call stop_and_remove for VF before PF, that will
> make VF get removed directly before PF's driver try to use
> pci_disable_sriov/virtfn_remove to do it.
> 
> Solution would be
> 1. separating stop and remove in two iterations.
> 2. or make pci_stop_and_remove_bus_device could be used on VF.
> 
> This patch is second solution:
> Separate PF ref releasing from virtfn_remove, all that during
> pci_destroy_dev for VFs.

I like the second approach better, but I think the call path and
locking is way too messy:

    virtfn_remove
      mutex_lock(&iov->dev->sriov->lock)          <--
      pci_stop_and_remove_bus_device
        mutex_trylock(&iov->dev->sriov->lock)     <--
        pci_stop_bus_device
        pci_remove_bus_device
          pci_destroy_dev
            virtfn_release
              virtfn_remove_bus
              pci_dev_put

I think it could be fixed, but it would require significant SR-IOV
rework, and I'm dubious that we can get it done in time for v3.11.

What would happen if we just reverted dc087f2f6a2 for now?  Jiang?

> Signed-off-by: Yinghai Lu <yinghai@kernel.org>
> 
> ---
>  drivers/pci/iov.c    |   34 +++++++++++++++++++++++++++++-----
>  drivers/pci/pci.h    |    4 ++++
>  drivers/pci/remove.c |   17 +++++++++++++++++
>  3 files changed, 50 insertions(+), 5 deletions(-)
> 
> Index: linux-2.6/drivers/pci/iov.c
> ===================================================================
> --- linux-2.6.orig/drivers/pci/iov.c
> +++ linux-2.6/drivers/pci/iov.c
> @@ -132,9 +132,37 @@ failed:
>  	return rc;
>  }
>  
> -static void virtfn_remove(struct pci_dev *dev, int id, int reset)
> +void virtfn_release(struct pci_dev *virtfn)
>  {
> +	int i;
> +	struct pci_dev *dev;
>  	char buf[VIRTFN_ID_LEN];
> +
> +	if (!virtfn->is_virtfn)
> +		return;
> +
> +	dev = virtfn->physfn;
> +
> +	/*
> +	 * Remove link to virtfn for PF.
> +	 * pci_disable_sriov() could be called after pci_stop_dev() is
> +	 * called for PF. So check sd to avoid spurious sfsfs warning.
> +	 */
> +	if (dev->dev.kobj.sd)
> +		for (i = 0; i < dev->sriov->num_VFs; i++)
> +			if ((virtfn_bus(dev, i) == virtfn->bus->number) &&
> +			    (virtfn_devfn(dev, i) == virtfn->devfn)) {
> +				sprintf(buf, "virtfn%u", i);
> +				sysfs_remove_link(&dev->dev.kobj, buf);
> +				break;
> +			}
> +
> +	virtfn_remove_bus(dev->bus, virtfn->bus);
> +	pci_dev_put(dev);
> +}
> +
> +static void virtfn_remove(struct pci_dev *dev, int id, int reset)
> +{
>  	struct pci_dev *virtfn;
>  	struct pci_sriov *iov = dev->sriov;
>  
> @@ -149,8 +177,6 @@ static void virtfn_remove(struct pci_dev
>  		__pci_reset_function(virtfn);
>  	}
>  
> -	sprintf(buf, "virtfn%u", id);
> -	sysfs_remove_link(&dev->dev.kobj, buf);
>  	/*
>  	 * pci_stop_dev() could have been called for this virtfn already,
>  	 * so the directory for the virtfn may have been removed before.
> @@ -161,12 +187,10 @@ static void virtfn_remove(struct pci_dev
>  
>  	mutex_lock(&iov->dev->sriov->lock);
>  	pci_stop_and_remove_bus_device(virtfn);
> -	virtfn_remove_bus(dev->bus, virtfn->bus);
>  	mutex_unlock(&iov->dev->sriov->lock);
>  
>  	/* balance pci_get_domain_bus_and_slot() */
>  	pci_dev_put(virtfn);
> -	pci_dev_put(dev);
>  }
>  
>  static int sriov_migration(struct pci_dev *dev)
> Index: linux-2.6/drivers/pci/pci.h
> ===================================================================
> --- linux-2.6.orig/drivers/pci/pci.h
> +++ linux-2.6/drivers/pci/pci.h
> @@ -262,6 +262,7 @@ int pci_iov_resource_bar(struct pci_dev
>  resource_size_t pci_sriov_resource_alignment(struct pci_dev *dev, int resno);
>  void pci_restore_iov_state(struct pci_dev *dev);
>  int pci_iov_bus_range(struct pci_bus *bus);
> +void virtfn_release(struct pci_dev *dev);
>  
>  #else
>  static inline int pci_iov_init(struct pci_dev *dev)
> @@ -284,6 +285,9 @@ static inline int pci_iov_bus_range(stru
>  {
>  	return 0;
>  }
> +void virtfn_release(struct pci_dev *dev)
> +{
> +}
>  
>  #endif /* CONFIG_PCI_IOV */
>  
> Index: linux-2.6/drivers/pci/remove.c
> ===================================================================
> --- linux-2.6.orig/drivers/pci/remove.c
> +++ linux-2.6/drivers/pci/remove.c
> @@ -38,6 +38,8 @@ static void pci_destroy_dev(struct pci_d
>  	list_del(&dev->bus_list);
>  	up_write(&pci_bus_sem);
>  
> +	virtfn_release(dev);
> +
>  	pci_free_resources(dev);
>  	put_device(&dev->dev);
>  }
> @@ -107,8 +109,23 @@ static void pci_remove_bus_device(struct
>   */
>  void pci_stop_and_remove_bus_device(struct pci_dev *dev)
>  {
> +#ifdef CONFIG_PCI_ATS
> +	struct pci_sriov *iov = NULL;
> +	int locked = 0;
> +
> +	if (dev->is_virtfn) {
> +		iov = dev->physfn->sriov;
> +		locked = mutex_trylock(&iov->dev->sriov->lock);
> +	}
> +#endif
> +
>  	pci_stop_bus_device(dev);
>  	pci_remove_bus_device(dev);
> +
> +#ifdef CONFIG_PCI_ATS
> +	if (locked)
> +		mutex_unlock(&iov->dev->sriov->lock);
> +#endif
>  }
>  EXPORT_SYMBOL(pci_stop_and_remove_bus_device);
>  
