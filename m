Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from usa-sjc-mx-foss1.foss.arm.com ([217.140.101.70]:43742 "EHLO
        foss.arm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752152AbeCORBs (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Thu, 15 Mar 2018 13:01:48 -0400
Date: Thu, 15 Mar 2018 17:01:31 +0000
From: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
To: Dexuan Cui <decui@microsoft.com>
Cc: "bhelgaas@google.com" <bhelgaas@google.com>,
        "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
        KY Srinivasan <kys@microsoft.com>,
        Stephen Hemminger <sthemmin@microsoft.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "driverdev-devel@linuxdriverproject.org"
        <driverdev-devel@linuxdriverproject.org>,
        Haiyang Zhang <haiyangz@microsoft.com>,
        "olaf@aepfle.de" <olaf@aepfle.de>,
        "apw@canonical.com" <apw@canonical.com>,
        "jasowang@redhat.com" <jasowang@redhat.com>,
        "vkuznets@redhat.com" <vkuznets@redhat.com>,
        "marcelo.cerri@canonical.com" <marcelo.cerri@canonical.com>,
        "Michael Kelley (EOSG)" <Michael.H.Kelley@microsoft.com>
Subject: Re: [PATCH v4 1/2] PCI: hv: Serialize the present and eject work
 items
Message-ID: <20180315170131.GA22134@e107981-ln.cambridge.arm.com>
References: <KL1P15301MB0006C96F94181FFB93A222D8BFD00@KL1P15301MB0006.APCP153.PROD.OUTLOOK.COM>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <KL1P15301MB0006C96F94181FFB93A222D8BFD00@KL1P15301MB0006.APCP153.PROD.OUTLOOK.COM>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Thu, Mar 15, 2018 at 02:20:53PM +0000, Dexuan Cui wrote:
> When we hot-remove the device, we first receive a PCI_EJECT message and
> then receive a PCI_BUS_RELATIONS message with bus_rel->device_count == 0.
> 
> The first message is offloaded to hv_eject_device_work(), and the second
> is offloaded to pci_devices_present_work(). Both the paths can be running
> list_del(&hpdev->list_entry), causing general protection fault, because
> system_wq can run them concurrently.
> 
> The patch eliminates the race condition.
> 
> Tested-by: Adrian Suhov <v-adsuho@microsoft.com>
> Tested-by: Chris Valean <v-chvale@microsoft.com>
> Signed-off-by: Dexuan Cui <decui@microsoft.com>
> Reviewed-by: Michael Kelley <mikelley@microsoft.com>
> Acked-by: Haiyang Zhang <haiyangz@microsoft.com>
> Cc: stable@vger.kernel.org

I need to know either what commit you are fixing (ie Fixes: tag - which
is preferrable) or you tell me which kernel versions we are targeting
for the stable backport.

Thanks,
Lorenzo

> Cc: Vitaly Kuznetsov <vkuznets@redhat.com>
> Cc: Jack Morgenstein <jackm@mellanox.com>
> Cc: Stephen Hemminger <sthemmin@microsoft.com>
> Cc: K. Y. Srinivasan <kys@microsoft.com>
> ---
>  drivers/pci/host/pci-hyperv.c | 17 ++++++++++++++---
>  1 file changed, 14 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/pci/host/pci-hyperv.c b/drivers/pci/host/pci-hyperv.c
> index 2faf38eab785..5e67dff779a7 100644
> --- a/drivers/pci/host/pci-hyperv.c
> +++ b/drivers/pci/host/pci-hyperv.c
> @@ -461,6 +461,8 @@ struct hv_pcibus_device {
>  	struct retarget_msi_interrupt retarget_msi_interrupt_params;
>  
>  	spinlock_t retarget_msi_interrupt_lock;
> +
> +	struct workqueue_struct *wq;
>  };
>  
>  /*
> @@ -1770,7 +1772,7 @@ static void hv_pci_devices_present(struct hv_pcibus_device *hbus,
>  	spin_unlock_irqrestore(&hbus->device_list_lock, flags);
>  
>  	get_hvpcibus(hbus);
> -	schedule_work(&dr_wrk->wrk);
> +	queue_work(hbus->wq, &dr_wrk->wrk);
>  }
>  
>  /**
> @@ -1848,7 +1850,7 @@ static void hv_pci_eject_device(struct hv_pci_dev *hpdev)
>  	get_pcichild(hpdev, hv_pcidev_ref_pnp);
>  	INIT_WORK(&hpdev->wrk, hv_eject_device_work);
>  	get_hvpcibus(hpdev->hbus);
> -	schedule_work(&hpdev->wrk);
> +	queue_work(hpdev->hbus->wq, &hpdev->wrk);
>  }
>  
>  /**
> @@ -2463,11 +2465,17 @@ static int hv_pci_probe(struct hv_device *hdev,
>  	spin_lock_init(&hbus->retarget_msi_interrupt_lock);
>  	sema_init(&hbus->enum_sem, 1);
>  	init_completion(&hbus->remove_event);
> +	hbus->wq = alloc_ordered_workqueue("hv_pci_%x", 0,
> +					   hbus->sysdata.domain);
> +	if (!hbus->wq) {
> +		ret = -ENOMEM;
> +		goto free_bus;
> +	}
>  
>  	ret = vmbus_open(hdev->channel, pci_ring_size, pci_ring_size, NULL, 0,
>  			 hv_pci_onchannelcallback, hbus);
>  	if (ret)
> -		goto free_bus;
> +		goto destroy_wq;
>  
>  	hv_set_drvdata(hdev, hbus);
>  
> @@ -2536,6 +2544,8 @@ static int hv_pci_probe(struct hv_device *hdev,
>  	hv_free_config_window(hbus);
>  close:
>  	vmbus_close(hdev->channel);
> +destroy_wq:
> +	destroy_workqueue(hbus->wq);
>  free_bus:
>  	free_page((unsigned long)hbus);
>  	return ret;
> @@ -2615,6 +2625,7 @@ static int hv_pci_remove(struct hv_device *hdev)
>  	irq_domain_free_fwnode(hbus->sysdata.fwnode);
>  	put_hvpcibus(hbus);
>  	wait_for_completion(&hbus->remove_event);
> +	destroy_workqueue(hbus->wq);
>  	free_page((unsigned long)hbus);
>  	return 0;
>  }
> -- 
> 2.7.4
> 
