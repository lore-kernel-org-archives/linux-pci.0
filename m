Return-Path: <linux-kernel-owner@vger.kernel.org>
Date: Fri, 24 Mar 2017 09:55:36 -0500
From: Bjorn Helgaas <helgaas@kernel.org>
To: Long Li <longli@exchange.microsoft.com>
Cc: "K. Y. Srinivasan" <kys@microsoft.com>,
        Haiyang Zhang <haiyangz@microsoft.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Stephen Hemminger <sthemmin@microsoft.com>,
        devel@linuxdriverproject.org, linux-pci@vger.kernel.org,
        linux-kernel@vger.kernel.org, Long Li <longli@microsoft.com>
Subject: Re: [PATCH 1/2 v5] pci-hyperv: properly handle pci bus remove
Message-ID: <20170324145536.GB25380@bhelgaas-glaptop.roam.corp.google.com>
References: <1490306290-6382-1-git-send-email-longli@exchange.microsoft.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1490306290-6382-1-git-send-email-longli@exchange.microsoft.com>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Thu, Mar 23, 2017 at 02:58:10PM -0700, Long Li wrote:
> From: Long Li <longli@microsoft.com>
> 
> hv_pci_devices_present is called in hv_pci_remove when we remove a PCI
> device from host (e.g. by disabling SRIOV on a device). In hv_pci_remove,
> the bus is already removed before the call, so we don't need to rescan the
> bus in the workqueue scheduled from hv_pci_devices_present.
> 
> By introducing status hv_pcibus_removed, we can avoid this situation.
> 
> Signed-off-by: Long Li <longli@microsoft.com>
> Reported-by: Xiaofeng Wang <xiaofwan@redhat.com>
> Acked-by: K. Y. Srinivasan <kys@microsoft.com>

Applied both patches to pci/host-hv for v4.12, thanks!  They both applied
perfectly :)

> ---
>  drivers/pci/host/pci-hyperv.c | 20 +++++++++++++++++---
>  1 file changed, 17 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/pci/host/pci-hyperv.c b/drivers/pci/host/pci-hyperv.c
> index ada9856..39fafda 100644
> --- a/drivers/pci/host/pci-hyperv.c
> +++ b/drivers/pci/host/pci-hyperv.c
> @@ -350,6 +350,7 @@ enum hv_pcibus_state {
>  	hv_pcibus_init = 0,
>  	hv_pcibus_probed,
>  	hv_pcibus_installed,
> +	hv_pcibus_removed,
>  	hv_pcibus_maximum
>  };
>  
> @@ -1504,13 +1505,24 @@ static void pci_devices_present_work(struct work_struct *work)
>  		put_pcichild(hpdev, hv_pcidev_ref_initial);
>  	}
>  
> -	/* Tell the core to rescan bus because there may have been changes. */
> -	if (hbus->state == hv_pcibus_installed) {
> +	switch(hbus->state) {
> +	case hv_pcibus_installed:
> +		/*
> +		* Tell the core to rescan bus
> +		* because there may have been changes.
> +		*/
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
> @@ -2185,6 +2197,7 @@ static int hv_pci_probe(struct hv_device *hdev,
>  	hbus = kzalloc(sizeof(*hbus), GFP_KERNEL);
>  	if (!hbus)
>  		return -ENOMEM;
> +	hbus->state = hv_pcibus_init;
>  
>  	/*
>  	 * The PCI bus "domain" is what is called "segment" in ACPI and
> @@ -2348,6 +2361,7 @@ static int hv_pci_remove(struct hv_device *hdev)
>  		pci_stop_root_bus(hbus->pci_bus);
>  		pci_remove_root_bus(hbus->pci_bus);
>  		pci_unlock_rescan_remove();
> +		hbus->state = hv_pcibus_removed;
>  	}
>  
>  	hv_pci_bus_exit(hdev);
> -- 
> 2.7.4
> 
