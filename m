Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail.linuxfoundation.org ([140.211.169.12]:40262 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751800AbcKHG7x (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 8 Nov 2016 01:59:53 -0500
Date: Tue, 8 Nov 2016 08:00:01 +0100
From: Greg KH <gregkh@linuxfoundation.org>
To: Long Li <longli@exchange.microsoft.com>
Cc: "K. Y. Srinivasan" <kys@microsoft.com>,
        Haiyang Zhang <haiyangz@microsoft.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        devel@linuxdriverproject.org, linux-kernel@vger.kernel.org,
        linux-pci@vger.kernel.org
Subject: Re: [Resend] [PATCH] pci-hyperv: use kmalloc to allocate hypercall
 params buffer
Message-ID: <20161108070001.GA13866@kroah.com>
References: <1478592854-17303-1-git-send-email-longli@exchange.microsoft.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1478592854-17303-1-git-send-email-longli@exchange.microsoft.com>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Tue, Nov 08, 2016 at 12:14:14AM -0800, Long Li wrote:
> From: Long Li <longli@microsoft.com>
> 
> hv_do_hypercall assumes that we pass a segment from a physically continuous buffer. Buffer allocated on the stack may not work if CONFIG_VMAP_STACK=y is set. Use kmalloc to allocate this buffer.

Please wrap your changelog at 72 columns.

> 
> Signed-off-by: Long Li <longli@microsoft.com>
> Reported-by: Haiyang Zhang <haiyangz@microsoft.com>
> ---
>  drivers/pci/host/pci-hyperv.c | 24 +++++++++++++-----------
>  1 file changed, 13 insertions(+), 11 deletions(-)
> 
> diff --git a/drivers/pci/host/pci-hyperv.c b/drivers/pci/host/pci-hyperv.c
> index 763ff87..97e6daf 100644
> --- a/drivers/pci/host/pci-hyperv.c
> +++ b/drivers/pci/host/pci-hyperv.c
> @@ -378,6 +378,7 @@ struct hv_pcibus_device {
>  	struct msi_domain_info msi_info;
>  	struct msi_controller msi_chip;
>  	struct irq_domain *irq_domain;
> +	struct retarget_msi_interrupt retarget_msi_interrupt_params;

Can you handle potentially unaligned accesses like this?  Is there some
lock preventing you from using this structure more than once at the same
time?

>  };
>  
>  /*
> @@ -774,7 +775,7 @@ void hv_irq_unmask(struct irq_data *data)
>  {
>  	struct msi_desc *msi_desc = irq_data_get_msi_desc(data);
>  	struct irq_cfg *cfg = irqd_cfg(data);
> -	struct retarget_msi_interrupt params;
> +	struct retarget_msi_interrupt *params;
>  	struct hv_pcibus_device *hbus;
>  	struct cpumask *dest;
>  	struct pci_bus *pbus;
> @@ -785,23 +786,24 @@ void hv_irq_unmask(struct irq_data *data)
>  	pdev = msi_desc_to_pci_dev(msi_desc);
>  	pbus = pdev->bus;
>  	hbus = container_of(pbus->sysdata, struct hv_pcibus_device, sysdata);
> -
> -	memset(&params, 0, sizeof(params));
> -	params.partition_id = HV_PARTITION_ID_SELF;
> -	params.source = 1; /* MSI(-X) */
> -	params.address = msi_desc->msg.address_lo;
> -	params.data = msi_desc->msg.data;
> -	params.device_id = (hbus->hdev->dev_instance.b[5] << 24) |
> +	params = &hbus->retarget_msi_interrupt_params;
> +
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
>  
> -	hv_do_hypercall(HVCALL_RETARGET_INTERRUPT, &params, NULL);
> +	hv_do_hypercall(HVCALL_RETARGET_INTERRUPT, params, NULL);

As you only use this in one spot, why not just allocate it here and then
free it?  Why add it to the pcibus device structure?

thanks,

greg k-h
