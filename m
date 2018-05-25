Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from smtp.codeaurora.org ([198.145.29.96]:48072 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S967305AbeEYRgu (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 25 May 2018 13:36:50 -0400
Subject: Re: [PATCH] PCI: Try to clean up resources via remove if shutdown
 doesn't exist
To: linux-pci@vger.kernel.org, timur@codeaurora.org
Cc: linux-arm-msm@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        Bjorn Helgaas <bhelgaas@google.com>,
        open list <linux-kernel@vger.kernel.or>,
        kexec@lists.infradead.org
References: <1527257063-15843-1-git-send-email-okaya@codeaurora.org>
From: Sinan Kaya <okaya@codeaurora.org>
Message-ID: <d0970733-d56b-9a96-26cd-4c911c127579@codeaurora.org>
Date: Fri, 25 May 2018 10:36:49 -0700
MIME-Version: 1.0
In-Reply-To: <1527257063-15843-1-git-send-email-okaya@codeaurora.org>
Content-Type: text/plain; charset=utf-8
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

[+cc kexec]

On 5/25/2018 7:04 AM, Sinan Kaya wrote:
> It is up to a driver to implement shutdown() callback. If shutdown()
> callback is not implemented, PCI device can have pending interrupt and
> even do DMA transactions while the system is going down.
> 
> If kexec is in use, this can damage the newly booting kexec kernel
> or even prevent it from booting altogether. Fallback to calling the
> remove() callback if shutdown() isn't implemented for a given driver.
> 
> Signed-off-by: Sinan Kaya <okaya@codeaurora.org>
> ---
>  drivers/pci/pci-driver.c | 9 +++++++++
>  1 file changed, 9 insertions(+)
> 
> diff --git a/drivers/pci/pci-driver.c b/drivers/pci/pci-driver.c
> index 6ace470..4ac72e3 100644
> --- a/drivers/pci/pci-driver.c
> +++ b/drivers/pci/pci-driver.c
> @@ -475,8 +475,17 @@ static void pci_device_shutdown(struct device *dev)
>  
>  	pm_runtime_resume(dev);
>  
> +	/*
> +	 * Try shutdown callback if it exists, otherwise fallback to remove
> +	 * callback. PCI drivers can do DMA and have pending interrupts.
> +	 * Leaving the DMA and interrupts pending could damage the newly
> +	 * booting kexec kernel as well as prevent it from booting altogether
> +	 * if the pending interrupt is level.
> +	 */
>  	if (drv && drv->shutdown)
>  		drv->shutdown(pci_dev);
> +	else if (drv && drv->remove)
> +		drv->remove(pci_dev);
>  
>  	/*
>  	 * If this is a kexec reboot, turn off Bus Master bit on the
> 


-- 
Sinan Kaya
Qualcomm Datacenter Technologies, Inc. as an affiliate of Qualcomm Technologies, Inc.
Qualcomm Technologies, Inc. is a member of the Code Aurora Forum, a Linux Foundation Collaborative Project.
