Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-qt0-f193.google.com ([209.85.216.193]:42534 "EHLO
        mail-qt0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S964881AbeF0Q1K (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 27 Jun 2018 12:27:10 -0400
Received: by mail-qt0-f193.google.com with SMTP id y31-v6so2170368qty.9
        for <linux-pci@vger.kernel.org>; Wed, 27 Jun 2018 09:27:10 -0700 (PDT)
Subject: Re: [PATCH v1] PCI: Data corruption happening due to race condition
To: Hari Vyas <hari.vyas@broadcom.com>, bhelgaas@google.com
Cc: linux-pci@vger.kernel.org
References: <20180626115356.GA24588@wunner.de>
 <1530092297-10165-1-git-send-email-hari.vyas@broadcom.com>
From: Ray Jui <ray.jui@broadcom.com>
Message-ID: <4a27d5b4-6578-8f91-fc6f-6409733f2e15@broadcom.com>
Date: Wed, 27 Jun 2018 09:27:04 -0700
MIME-Version: 1.0
In-Reply-To: <1530092297-10165-1-git-send-email-hari.vyas@broadcom.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Are you re-sending v1 version of this patch or this is actually v2?

Thanks,

Ray

On 6/27/2018 2:38 AM, Hari Vyas wrote:
> When a pci device is detected, a variable is_added is set to
> 1 in pci device structure and proc, sys entries are created.
> 
> When a pci device is removed, first is_added is checked for one
> and then device is detached with clearing of proc and sys
> entries and at end, is_added is set to 0.
> 
> is_added and is_busmaster are bit fields in pci_dev structure
> sharing same memory location.
> 
> A strange issue was observed with multiple times removal and
> rescan of a pcie nvme device using sysfs commands where is_added
> flag was observed as zero instead of one while removing device
> and proc,sys entries are not cleared.  This causes issue in
> later device addition with warning message "proc_dir_entry"
> already registered.
> 
> Debugging revealed a race condition between pcie core driver
> enabling is_added bit(pci_bus_add_device()) and nvme driver
> reset work-queue enabling is_busmaster bit (by pci_set_master()).
> As both fields are not handled in atomic manner and that clears
> is_added bit.
> 
> Fix protects is_added and is_busmaster bits updation by a spin
> locking mechanism.
> 
> Signed-off-by: Hari Vyas <hari.vyas@broadcom.com>
> Reviewed-by: Ray Jui <ray.jui@broadcom.com>
> ---
>   drivers/pci/bus.c        | 3 +++
>   drivers/pci/pci-driver.c | 2 ++
>   drivers/pci/pci.c        | 7 +++++++
>   drivers/pci/probe.c      | 1 +
>   drivers/pci/remove.c     | 5 +++++
>   include/linux/pci.h      | 1 +
>   6 files changed, 19 insertions(+)
> 
> diff --git a/drivers/pci/bus.c b/drivers/pci/bus.c
> index 35b7fc8..61d389d 100644
> --- a/drivers/pci/bus.c
> +++ b/drivers/pci/bus.c
> @@ -310,6 +310,7 @@ void __weak pcibios_bus_add_device(struct pci_dev *pdev) { }
>   void pci_bus_add_device(struct pci_dev *dev)
>   {
>   	int retval;
> +	unsigned long flags;
>   
>   	/*
>   	 * Can not put in pci_device_add yet because resources
> @@ -330,7 +331,9 @@ void pci_bus_add_device(struct pci_dev *dev)
>   		return;
>   	}
>   
> +	spin_lock_irqsave(&dev->lock, flags);
>   	dev->is_added = 1;
> +	spin_unlock_irqrestore(&dev->lock, flags);
>   }
>   EXPORT_SYMBOL_GPL(pci_bus_add_device);
>   
> diff --git a/drivers/pci/pci-driver.c b/drivers/pci/pci-driver.c
> index c125d53..547bcd7 100644
> --- a/drivers/pci/pci-driver.c
> +++ b/drivers/pci/pci-driver.c
> @@ -123,6 +123,8 @@ static ssize_t new_id_store(struct device_driver *driver, const char *buf,
>   		pdev->subsystem_device = subdevice;
>   		pdev->class = class;
>   
> +		spin_lock_init(&pdev->lock);
> +
>   		if (pci_match_id(pdrv->id_table, pdev))
>   			retval = -EEXIST;
>   
> diff --git a/drivers/pci/pci.c b/drivers/pci/pci.c
> index 97acba7..bcb1f96 100644
> --- a/drivers/pci/pci.c
> +++ b/drivers/pci/pci.c
> @@ -1649,6 +1649,7 @@ void pci_disable_enabled_device(struct pci_dev *dev)
>   void pci_disable_device(struct pci_dev *dev)
>   {
>   	struct pci_devres *dr;
> +	unsigned long flags;
>   
>   	dr = find_pci_dr(dev);
>   	if (dr)
> @@ -1662,7 +1663,9 @@ void pci_disable_device(struct pci_dev *dev)
>   
>   	do_pci_disable_device(dev);
>   
> +	spin_lock_irqsave(&dev->lock, flags);
>   	dev->is_busmaster = 0;
> +	spin_unlock_irqrestore(&dev->lock, flags);
>   }
>   EXPORT_SYMBOL(pci_disable_device);
>   
> @@ -3664,6 +3667,7 @@ void __iomem *devm_pci_remap_cfg_resource(struct device *dev,
>   static void __pci_set_master(struct pci_dev *dev, bool enable)
>   {
>   	u16 old_cmd, cmd;
> +	unsigned long flags;
>   
>   	pci_read_config_word(dev, PCI_COMMAND, &old_cmd);
>   	if (enable)
> @@ -3675,7 +3679,10 @@ static void __pci_set_master(struct pci_dev *dev, bool enable)
>   			enable ? "enabling" : "disabling");
>   		pci_write_config_word(dev, PCI_COMMAND, cmd);
>   	}
> +
> +	spin_lock_irqsave(&dev->lock, flags);
>   	dev->is_busmaster = enable;
> +	spin_unlock_irqrestore(&dev->lock, flags);
>   }
>   
>   /**
> diff --git a/drivers/pci/probe.c b/drivers/pci/probe.c
> index ac876e3..9203b88 100644
> --- a/drivers/pci/probe.c
> +++ b/drivers/pci/probe.c
> @@ -2102,6 +2102,7 @@ struct pci_dev *pci_alloc_dev(struct pci_bus *bus)
>   	INIT_LIST_HEAD(&dev->bus_list);
>   	dev->dev.type = &pci_dev_type;
>   	dev->bus = pci_bus_get(bus);
> +	spin_lock_init(&dev->lock);
>   
>   	return dev;
>   }
> diff --git a/drivers/pci/remove.c b/drivers/pci/remove.c
> index 6f072ea..ff57bd6 100644
> --- a/drivers/pci/remove.c
> +++ b/drivers/pci/remove.c
> @@ -17,13 +17,18 @@ static void pci_free_resources(struct pci_dev *dev)
>   
>   static void pci_stop_dev(struct pci_dev *dev)
>   {
> +	unsigned long flags;
> +
>   	pci_pme_active(dev, false);
>   
>   	if (dev->is_added) {
>   		device_release_driver(&dev->dev);
>   		pci_proc_detach_device(dev);
>   		pci_remove_sysfs_dev_files(dev);
> +
> +		spin_lock_irqsave(&dev->lock, flags);
>   		dev->is_added = 0;
> +		spin_unlock_irqrestore(&dev->lock, flags);
>   	}
>   
>   	if (dev->bus->self)
> diff --git a/include/linux/pci.h b/include/linux/pci.h
> index 340029b..6940825 100644
> --- a/include/linux/pci.h
> +++ b/include/linux/pci.h
> @@ -365,6 +365,7 @@ struct pci_dev {
>   
>   	bool		match_driver;		/* Skip attaching driver */
>   
> +	spinlock_t	lock;			/* Protect is_added and is_busmaster */
>   	unsigned int	transparent:1;		/* Subtractive decode bridge */
>   	unsigned int	multifunction:1;	/* Multi-function device */
>   
> 
