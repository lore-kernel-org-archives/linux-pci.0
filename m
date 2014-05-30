Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-ie0-f174.google.com ([209.85.223.174]:43091 "EHLO
	mail-ie0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S933305AbaE3PhN (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Fri, 30 May 2014 11:37:13 -0400
Received: by mail-ie0-f174.google.com with SMTP id lx4so1831115iec.5
        for <linux-pci@vger.kernel.org>; Fri, 30 May 2014 08:37:12 -0700 (PDT)
Date: Fri, 30 May 2014 09:37:10 -0600
From: Bjorn Helgaas <bhelgaas@google.com>
To: Yijing Wang <wangyijing@huawei.com>
Cc: linux-pci@vger.kernel.org, Yinghai Lu <yinghai@kernel.org>
Subject: Re: [PATCH v2] PCI: make pci_bus_add_device() void
Message-ID: <20140530153710.GB4607@google.com>
References: <1401418863-10884-1-git-send-email-wangyijing@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1401418863-10884-1-git-send-email-wangyijing@huawei.com>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Fri, May 30, 2014 at 11:01:03AM +0800, Yijing Wang wrote:
> Kernel will WARN_ON(retval < 0) if device_attach() fail with
> error in pci_bus_add_device(). currently, all the kernel code
> to check pci_bus_add_device() return value only for printing
> warning message, no other actions. So make pci_bus_add_device()
> void and clean all the unnecessary checkingi codes.
> 
> Signed-off-by: Yijing Wang <wangyijing@huawei.com>

Applied to pci/misc for v3.16, thanks!

> ---
> v1->v2: Convert pci_bus_add_device() void, squash all changes into a single patch
> ---
>  drivers/edac/i82875p_edac.c         |    7 +------
>  drivers/pci/bus.c                   |   10 ++--------
>  drivers/pci/iov.c                   |    2 +-
>  drivers/platform/x86/asus-wmi.c     |    3 +--
>  drivers/platform/x86/eeepc-laptop.c |    3 +--
>  include/linux/pci.h                 |    2 +-
>  6 files changed, 7 insertions(+), 20 deletions(-)
> 
> diff --git a/drivers/edac/i82875p_edac.c b/drivers/edac/i82875p_edac.c
> index 8d0450b..8705ba6 100644
> --- a/drivers/edac/i82875p_edac.c
> +++ b/drivers/edac/i82875p_edac.c
> @@ -293,12 +293,7 @@ static int i82875p_setup_overfl_dev(struct pci_dev *pdev,
>  		if (dev == NULL)
>  			return 1;
>  
> -		err = pci_bus_add_device(dev);
> -		if (err) {
> -			i82875p_printk(KERN_ERR,
> -				"%s(): pci_bus_add_device() Failed\n",
> -				__func__);
> -		}
> +		pci_bus_add_device(dev);
>  		pci_bus_assign_resources(dev->bus);
>  	}
>  
> diff --git a/drivers/pci/bus.c b/drivers/pci/bus.c
> index ba2bf55..447d393 100644
> --- a/drivers/pci/bus.c
> +++ b/drivers/pci/bus.c
> @@ -235,7 +235,7 @@ void __weak pcibios_resource_survey_bus(struct pci_bus *bus) { }
>   *
>   * This adds add sysfs entries and start device drivers
>   */
> -int pci_bus_add_device(struct pci_dev *dev)
> +void pci_bus_add_device(struct pci_dev *dev)
>  {
>  	int retval;
>  
> @@ -252,8 +252,6 @@ int pci_bus_add_device(struct pci_dev *dev)
>  	WARN_ON(retval < 0);
>  
>  	dev->is_added = 1;
> -
> -	return 0;
>  }
>  
>  /**
> @@ -266,16 +264,12 @@ void pci_bus_add_devices(const struct pci_bus *bus)
>  {
>  	struct pci_dev *dev;
>  	struct pci_bus *child;
> -	int retval;
>  
>  	list_for_each_entry(dev, &bus->devices, bus_list) {
>  		/* Skip already-added devices */
>  		if (dev->is_added)
>  			continue;
> -		retval = pci_bus_add_device(dev);
> -		if (retval)
> -			dev_err(&dev->dev, "Error adding device (%d)\n",
> -				retval);
> +		pci_bus_add_device(dev);
>  	}
>  
>  	list_for_each_entry(dev, &bus->devices, bus_list) {
> diff --git a/drivers/pci/iov.c b/drivers/pci/iov.c
> index de7a747..cb6f247 100644
> --- a/drivers/pci/iov.c
> +++ b/drivers/pci/iov.c
> @@ -106,7 +106,7 @@ static int virtfn_add(struct pci_dev *dev, int id, int reset)
>  	pci_device_add(virtfn, virtfn->bus);
>  	mutex_unlock(&iov->dev->sriov->lock);
>  
> -	rc = pci_bus_add_device(virtfn);
> +	pci_bus_add_device(virtfn);
>  	sprintf(buf, "virtfn%u", id);
>  	rc = sysfs_create_link(&dev->dev.kobj, &virtfn->dev.kobj, buf);
>  	if (rc)
> diff --git a/drivers/platform/x86/asus-wmi.c b/drivers/platform/x86/asus-wmi.c
> index c5e082f..91ef69a 100644
> --- a/drivers/platform/x86/asus-wmi.c
> +++ b/drivers/platform/x86/asus-wmi.c
> @@ -642,8 +642,7 @@ static void asus_rfkill_hotplug(struct asus_wmi *asus)
>  			dev = pci_scan_single_device(bus, 0);
>  			if (dev) {
>  				pci_bus_assign_resources(bus);
> -				if (pci_bus_add_device(dev))
> -					pr_err("Unable to hotplug wifi\n");
> +				pci_bus_add_device(dev);
>  			}
>  		} else {
>  			dev = pci_get_slot(bus, 0);
> diff --git a/drivers/platform/x86/eeepc-laptop.c b/drivers/platform/x86/eeepc-laptop.c
> index 399e8c5..9b0c57c 100644
> --- a/drivers/platform/x86/eeepc-laptop.c
> +++ b/drivers/platform/x86/eeepc-laptop.c
> @@ -633,8 +633,7 @@ static void eeepc_rfkill_hotplug(struct eeepc_laptop *eeepc, acpi_handle handle)
>  			dev = pci_scan_single_device(bus, 0);
>  			if (dev) {
>  				pci_bus_assign_resources(bus);
> -				if (pci_bus_add_device(dev))
> -					pr_err("Unable to hotplug wifi\n");
> +				pci_bus_add_device(dev);
>  			}
>  		} else {
>  			dev = pci_get_slot(bus, 0);
> diff --git a/include/linux/pci.h b/include/linux/pci.h
> index 65f22e8..71d9673 100644
> --- a/include/linux/pci.h
> +++ b/include/linux/pci.h
> @@ -781,7 +781,7 @@ int pci_scan_slot(struct pci_bus *bus, int devfn);
>  struct pci_dev *pci_scan_single_device(struct pci_bus *bus, int devfn);
>  void pci_device_add(struct pci_dev *dev, struct pci_bus *bus);
>  unsigned int pci_scan_child_bus(struct pci_bus *bus);
> -int __must_check pci_bus_add_device(struct pci_dev *dev);
> +void pci_bus_add_device(struct pci_dev *dev);
>  void pci_read_bridge_bases(struct pci_bus *child);
>  struct resource *pci_find_parent_resource(const struct pci_dev *dev,
>  					  struct resource *res);
> -- 
> 1.7.1
> 
> 
> --
> To unsubscribe from this list: send the line "unsubscribe linux-pci" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
