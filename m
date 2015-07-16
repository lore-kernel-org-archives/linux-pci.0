Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-ie0-f176.google.com ([209.85.223.176]:34146 "EHLO
	mail-ie0-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753135AbbGPEWJ (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Thu, 16 Jul 2015 00:22:09 -0400
Received: by iebmu5 with SMTP id mu5so47918991ieb.1
        for <linux-pci@vger.kernel.org>; Wed, 15 Jul 2015 21:22:08 -0700 (PDT)
Date: Wed, 15 Jul 2015 23:22:03 -0500
From: Bjorn Helgaas <bhelgaas@google.com>
To: Yijing Wang <wangyijing@huawei.com>
Cc: linux-pci@vger.kernel.org, Rajat Jain <rajatja@google.com>,
	Guenter Roeck <linux@roeck-us.net>,
	"Rafael J. Wysocki" <rjw@rjwysocki.net>
Subject: Re: [PATCH] PCI: Use a local mutex instead of pci_bus_sem to avoid
 deadlock
Message-ID: <20150716042203.GC25591@google.com>
References: <1434021134-6519-1-git-send-email-wangyijing@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1434021134-6519-1-git-send-email-wangyijing@huawei.com>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

[+cc Guenter, Rafael]

On Thu, Jun 11, 2015 at 07:12:14PM +0800, Yijing Wang wrote:
> Rajat Jain reported a deadlock when a hierarchical hot plug
> thread and aer recovery thread both run.
> https://lkml.org/lkml/2015/3/11/861
> 
> thread 1:
> pciehp_enable_slot()
> 	pciehp_configure_device()
> 		pci_bus_add_devices()
> 			device_attach(dev)
> 				device_lock(dev) //acquire device mutex successfully
> 			...
> 			pciehp_probe(dev)
> 				__pci_hp_register()
> 					pci_create_slot()
> 						down_write(pci_bus_sem) //deadlock here
> 
> thread 2:
> aer_isr_one_error()
> 	aer_process_err_device()
> 		do_recovery()
> 			broadcast_error_message()
> 				pci_walk_bus()
> 					down_read(&pci_bus_sem) //acquire pci_bus_sem successfully
> 						report_error_detected(dev)
> 							device_lock(dev) // deadlock here
> 
> Now we use pci_bus_sem to protect pci_slot creation and destroy,
> it's unnecessary. We could introduce a new local mutex instead of
> pci_bus_sem to avoid the deadlock.

I see there's definitely a problem here, and using a new mutex instead of
pci_bus_sem certainly avoids the deadlock.

I'm trying to convince myself that it is safe.  I think we need to protect:

  - search of bus->slots list in get_slot()
  - addition to bus->slots list in pci_create_slot()
  - search of bus->devices list in pci_create_slot()
  - search of bus->devices list in pci_slot_release()
  - deletion from bus->slots list in pci_slot_release()

Most other maintenance of these lists is protected by pci_bus_sem, so using
a different mutex here seems like a problem.

If I'm mistaken, please correct me and explain why this patch is safe.

> Signed-off-by: Yijing Wang <wangyijing@huawei.com>
> ---
>  drivers/pci/slot.c |   11 ++++++-----
>  1 files changed, 6 insertions(+), 5 deletions(-)
> 
> diff --git a/drivers/pci/slot.c b/drivers/pci/slot.c
> index 396c200..feb08de 100644
> --- a/drivers/pci/slot.c
> +++ b/drivers/pci/slot.c
> @@ -14,6 +14,7 @@
>  
>  struct kset *pci_slots_kset;
>  EXPORT_SYMBOL_GPL(pci_slots_kset);
> +static DEFINE_MUTEX(pci_slot_mutex);
>  
>  static ssize_t pci_slot_attr_show(struct kobject *kobj,
>  					struct attribute *attr, char *buf)
> @@ -195,7 +196,7 @@ static struct pci_slot *get_slot(struct pci_bus *parent, int slot_nr)
>  {
>  	struct pci_slot *slot;
>  	/*
> -	 * We already hold pci_bus_sem so don't worry
> +	 * We already hold pci_slot_mutex so don't worry
>  	 */
>  	list_for_each_entry(slot, &parent->slots, list)
>  		if (slot->number == slot_nr) {
> @@ -253,7 +254,7 @@ struct pci_slot *pci_create_slot(struct pci_bus *parent, int slot_nr,
>  	int err = 0;
>  	char *slot_name = NULL;
>  
> -	down_write(&pci_bus_sem);
> +	mutex_lock(&pci_slot_mutex);
>  
>  	if (slot_nr == -1)
>  		goto placeholder;
> @@ -310,7 +311,7 @@ placeholder:
>  
>  out:
>  	kfree(slot_name);
> -	up_write(&pci_bus_sem);
> +	mutex_unlock(&pci_slot_mutex);
>  	return slot;
>  err:
>  	kfree(slot);
> @@ -332,9 +333,9 @@ void pci_destroy_slot(struct pci_slot *slot)
>  	dev_dbg(&slot->bus->dev, "dev %02x, dec refcount to %d\n",
>  		slot->number, atomic_read(&slot->kobj.kref.refcount) - 1);
>  
> -	down_write(&pci_bus_sem);
> +	mutex_lock(&pci_slot_mutex);
>  	kobject_put(&slot->kobj);
> -	up_write(&pci_bus_sem);
> +	mutex_unlock(&pci_slot_mutex);
>  }
>  EXPORT_SYMBOL_GPL(pci_destroy_slot);
>  
> -- 
> 1.7.1
> 
