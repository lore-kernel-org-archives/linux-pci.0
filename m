Return-Path: <linux-kernel-owner@vger.kernel.org>
Date: Fri, 11 Nov 2016 15:03:59 -0600
From: Bjorn Helgaas <helgaas@kernel.org>
To: Long Li <longli@exchange.microsoft.com>
Cc: "K. Y. Srinivasan" <kys@microsoft.com>,
        Haiyang Zhang <haiyangz@microsoft.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        devel@linuxdriverproject.org, linux-pci@vger.kernel.org,
        linux-kernel@vger.kernel.org, Long Li <longli@microsoft.com>
Subject: Re: [PATCH 1/2 v3] pci-hyperv: properly handle pci bus remove
Message-ID: <20161111210359.GD9868@bhelgaas-glaptop.roam.corp.google.com>
References: <1475563367-16511-1-git-send-email-longli@exchange.microsoft.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1475563367-16511-1-git-send-email-longli@exchange.microsoft.com>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Mon, Oct 03, 2016 at 11:42:47PM -0700, Long Li wrote:
> From: Long Li <longli@microsoft.com>
> 
> hv_pci_devices_present is called in hv_pci_remove when we remove a PCI device from host (e.g. by disabling SRIOV on a device). In hv_pci_remove, the bus is already removed before the call, so we don't need to rescan the bus in the workqueue scheduled from hv_pci_devices_present. By introducing status hv_pcibus_removed, we can avoid this situation.
> 
> Signed-off-by: Long Li <longli@microsoft.com>
> Tested-by: Cathy Avery <cavery@redhat.com>
> Reported-by: Xiaofeng Wang <xiaofwan@redhat.com>

I need an ack from the Hyper-V maintainers.  I see acks for previous
versions, but I don't know whether you've changed things that would
invalidate those acks.  If the acks still apply, please include them
and repost these patches.

Also, please run "git log --oneline drivers/pci/host/pci-hyperv.c" and make
your subject line match the previous ones.

> ---
>  drivers/pci/host/pci-hyperv.c | 20 +++++++++++++++++---
>  1 file changed, 17 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/pci/host/pci-hyperv.c b/drivers/pci/host/pci-hyperv.c
> index a8deeca..4a37598 100644
> --- a/drivers/pci/host/pci-hyperv.c
> +++ b/drivers/pci/host/pci-hyperv.c
> @@ -348,6 +348,7 @@ enum hv_pcibus_state {
>  	hv_pcibus_init = 0,
>  	hv_pcibus_probed,
>  	hv_pcibus_installed,
> +	hv_pcibus_removed,
>  	hv_pcibus_maximum
>  };
>  
> @@ -1481,13 +1482,24 @@ static void pci_devices_present_work(struct work_struct *work)
>  		put_pcichild(hpdev, hv_pcidev_ref_initial);
>  	}
>  
> -	/* Tell the core to rescan bus because there may have been changes. */
> -	if (hbus->state == hv_pcibus_installed) {
> +	switch (hbus->state) {
> +	case hv_pcibus_installed:
> +		/*
> +		 * Tell the core to rescan bus
> +		 * because there may have been changes.
> +		 */
>  		pci_lock_rescan_remove();
>  		pci_scan_child_bus(hbus->pci_bus);
>  		pci_unlock_rescan_remove();
> -	} else {
> +		break;
> +
> +	case hv_pcibus_init:
> +	case hv_pcibus_probed:
>  		survey_child_resources(hbus);
> +		break;
> +
> +	default:
> +		break;
>  	}
>  
>  	up(&hbus->enum_sem);
> @@ -2163,6 +2175,7 @@ static int hv_pci_probe(struct hv_device *hdev,
>  	hbus = kzalloc(sizeof(*hbus), GFP_KERNEL);
>  	if (!hbus)
>  		return -ENOMEM;
> +	hbus->state = hv_pcibus_init;
>  
>  	/*
>  	 * The PCI bus "domain" is what is called "segment" in ACPI and
> @@ -2305,6 +2318,7 @@ static int hv_pci_remove(struct hv_device *hdev)
>  		pci_stop_root_bus(hbus->pci_bus);
>  		pci_remove_root_bus(hbus->pci_bus);
>  		pci_unlock_rescan_remove();
> +		hbus->state = hv_pcibus_removed;
>  	}
>  
>  	ret = hv_send_resources_released(hdev);
> -- 
> 1.8.5.6
> 
> --
> To unsubscribe from this list: send the line "unsubscribe linux-pci" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
