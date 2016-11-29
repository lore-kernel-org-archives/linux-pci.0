Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.136]:57370 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751758AbcK2XZJ (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Tue, 29 Nov 2016 18:25:09 -0500
Date: Tue, 29 Nov 2016 17:25:03 -0600
From: Bjorn Helgaas <helgaas@kernel.org>
To: Long Li <longli@exchange.microsoft.com>
Cc: "K. Y. Srinivasan" <kys@microsoft.com>,
        Haiyang Zhang <haiyangz@microsoft.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        devel@linuxdriverproject.org, linux-pci@vger.kernel.org,
        linux-kernel@vger.kernel.org, Long Li <longli@microsoft.com>
Subject: Re: [PATCH] pci-hyperv: use kmalloc to allocate hypercall params
 buffer
Message-ID: <20161129232503.GA7375@bhelgaas-glaptop.roam.corp.google.com>
References: <1478642678-31659-1-git-send-email-longli@exchange.microsoft.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1478642678-31659-1-git-send-email-longli@exchange.microsoft.com>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Tue, Nov 08, 2016 at 02:04:38PM -0800, Long Li wrote:
> From: Long Li <longli@microsoft.com>
> 
> hv_do_hypercall assumes that we pass a segment from a physically
> continuous buffer. Buffer allocated on the stack may not work if
> CONFIG_VMAP_STACK=y is set.
> 
> Change to use kmalloc to allocate this buffer.
> 
> The v2 patch adds locking to access the pre-allocated buffer.
> 
> Signed-off-by: Long Li <longli@microsoft.com>
> Reported-by: Haiyang Zhang <haiyangz@microsoft.com>

Applied with KY's ack to pci/host-hv, thanks!

> ---
>  drivers/pci/host/pci-hyperv.c | 29 +++++++++++++++++++----------
>  1 file changed, 19 insertions(+), 10 deletions(-)
> 
> diff --git a/drivers/pci/host/pci-hyperv.c b/drivers/pci/host/pci-hyperv.c
> index 763ff87..ca553df 100644
> --- a/drivers/pci/host/pci-hyperv.c
> +++ b/drivers/pci/host/pci-hyperv.c
> @@ -378,6 +378,8 @@ struct hv_pcibus_device {
>  	struct msi_domain_info msi_info;
>  	struct msi_controller msi_chip;
>  	struct irq_domain *irq_domain;
> +	struct retarget_msi_interrupt retarget_msi_interrupt_params;
> +	spinlock_t retarget_msi_interrupt_lock;;
>  };
>  
>  /*
> @@ -774,34 +776,40 @@ void hv_irq_unmask(struct irq_data *data)
>  {
>  	struct msi_desc *msi_desc = irq_data_get_msi_desc(data);
>  	struct irq_cfg *cfg = irqd_cfg(data);
> -	struct retarget_msi_interrupt params;
> +	struct retarget_msi_interrupt *params;
>  	struct hv_pcibus_device *hbus;
>  	struct cpumask *dest;
>  	struct pci_bus *pbus;
>  	struct pci_dev *pdev;
>  	int cpu;
> +	unsigned long flags;
>  
>  	dest = irq_data_get_affinity_mask(data);
>  	pdev = msi_desc_to_pci_dev(msi_desc);
>  	pbus = pdev->bus;
>  	hbus = container_of(pbus->sysdata, struct hv_pcibus_device, sysdata);
>  
> -	memset(&params, 0, sizeof(params));
> -	params.partition_id = HV_PARTITION_ID_SELF;
> -	params.source = 1; /* MSI(-X) */
> -	params.address = msi_desc->msg.address_lo;
> -	params.data = msi_desc->msg.data;
> -	params.device_id = (hbus->hdev->dev_instance.b[5] << 24) |
> +	spin_lock_irqsave(&hbus->retarget_msi_interrupt_lock, flags);
> +
> +	params = &hbus->retarget_msi_interrupt_params;
> +	memset(params, 0, sizeof(*params));
> +	params->partition_id = HV_PARTITION_ID_SELF;
> +	params->source = 1; /* MSI(-X) */
> +	params->address = msi_desc->msg.address_lo;
> +	params->data = msi_desc->msg.data;
> +	params->device_id = (hbus->hdev->dev_instance.b[5] << 24) |
>  			   (hbus->hdev->dev_instance.b[4] << 16) |
>  			   (hbus->hdev->dev_instance.b[7] << 8) |
>  			   (hbus->hdev->dev_instance.b[6] & 0xf8) |
>  			   PCI_FUNC(pdev->devfn);
> -	params.vector = cfg->vector;
> +	params->vector = cfg->vector;
>  
>  	for_each_cpu_and(cpu, dest, cpu_online_mask)
> -		params.vp_mask |= (1ULL << vmbus_cpu_number_to_vp_number(cpu));
> +		params->vp_mask |= (1ULL << vmbus_cpu_number_to_vp_number(cpu));
> +
> +	hv_do_hypercall(HVCALL_RETARGET_INTERRUPT, params, NULL);
>  
> -	hv_do_hypercall(HVCALL_RETARGET_INTERRUPT, &params, NULL);
> +	spin_unlock_irqrestore(&hbus->retarget_msi_interrupt_lock, flags);
>  
>  	pci_msi_unmask_irq(data);
>  }
> @@ -2186,6 +2194,7 @@ static int hv_pci_probe(struct hv_device *hdev,
>  	INIT_LIST_HEAD(&hbus->resources_for_children);
>  	spin_lock_init(&hbus->config_lock);
>  	spin_lock_init(&hbus->device_list_lock);
> +	spin_lock_init(&hbus->retarget_msi_interrupt_lock);
>  	sema_init(&hbus->enum_sem, 1);
>  	init_completion(&hbus->remove_event);
>  
> -- 
> 2.7.4
> 
> --
> To unsubscribe from this list: send the line "unsubscribe linux-pci" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
