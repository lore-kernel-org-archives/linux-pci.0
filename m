Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-pg0-f48.google.com ([74.125.83.48]:34376 "EHLO
        mail-pg0-f48.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751201AbcLEQx1 (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 5 Dec 2016 11:53:27 -0500
Received: by mail-pg0-f48.google.com with SMTP id x23so138495638pgx.1
        for <linux-pci@vger.kernel.org>; Mon, 05 Dec 2016 08:52:42 -0800 (PST)
Date: Mon, 5 Dec 2016 08:52:40 -0800
From: Stephen Hemminger <stephen@networkplumber.org>
To: Long Li <longli@exchange.microsoft.com>
Cc: "K. Y. Srinivasan" <kys@microsoft.com>,
        Haiyang Zhang <haiyangz@microsoft.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        devel@linuxdriverproject.org, linux-kernel@vger.kernel.org,
        linux-pci@vger.kernel.org
Subject: Re: [PATCH] pci-hyperv: use kmalloc to allocate hypercall params
 buffer
Message-ID: <20161205085240.23f686fc@xeon-e3>
In-Reply-To: <1478642678-31659-1-git-send-email-longli@exchange.microsoft.com>
References: <1478642678-31659-1-git-send-email-longli@exchange.microsoft.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Tue,  8 Nov 2016 14:04:38 -0800
Long Li <longli@exchange.microsoft.com> wrote:

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

It looks like the additional locking here is being overly paranoid.
The caller is already holding the irq descriptor lock. Look at fixup_irqs.
