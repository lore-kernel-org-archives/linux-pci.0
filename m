Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-wg0-f47.google.com ([74.125.82.47]:40875 "EHLO
	mail-wg0-f47.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932322AbbCLQVR (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Thu, 12 Mar 2015 12:21:17 -0400
Message-ID: <5501BCF7.9080004@redhat.com>
Date: Thu, 12 Mar 2015 17:21:11 +0100
From: Paolo Bonzini <pbonzini@redhat.com>
MIME-Version: 1.0
To: Fam Zheng <famz@redhat.com>, linux-kernel@vger.kernel.org
CC: Bjorn Helgaas <bhelgaas@google.com>, linux-pci@vger.kernel.org,
	Linux Virtualization <virtualization@lists.linux-foundation.org>
Subject: Re: [RFC PATCH] PCI: Disable MSI/MSI-X only if device is shutdown
References: <1426137682-12287-1-git-send-email-famz@redhat.com>
In-Reply-To: <1426137682-12287-1-git-send-email-famz@redhat.com>
Content-Type: text/plain; charset=windows-1252
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>



On 12/03/2015 06:21, Fam Zheng wrote:
> If the device doesn't support shutdown, disabling interrupts may cause
> trouble. For example, virtio-scsi-pci doesn't implement shutdown, and
> after we disable MSI-X, futher notifications from device will be
> delivered to IRQ, which is unexpected. This IRQ will not be cleared, and
> may prevent us from making progress, by keep triggering interrupts.
> 
> Signed-off-by: Fam Zheng <famz@redhat.com>
> ---
>  drivers/pci/pci-driver.c | 7 ++++---
>  1 file changed, 4 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/pci/pci-driver.c b/drivers/pci/pci-driver.c
> index 3cb2210..fb29c96 100644
> --- a/drivers/pci/pci-driver.c
> +++ b/drivers/pci/pci-driver.c
> @@ -448,10 +448,11 @@ static void pci_device_shutdown(struct device *dev)
>  
>  	pm_runtime_resume(dev);
>  
> -	if (drv && drv->shutdown)
> +	if (drv && drv->shutdown) {
>  		drv->shutdown(pci_dev);
> -	pci_msi_shutdown(pci_dev);
> -	pci_msix_shutdown(pci_dev);
> +		pci_msi_shutdown(pci_dev);
> +		pci_msix_shutdown(pci_dev);
> +	}
>  
>  #ifdef CONFIG_KEXEC
>  	/*
> 

The patch may be okay, but I think the bug here is also that virtio-pci
is not defining a .shutdown callback.  It should define one and call
free_irq (for INTX) and pci_disable_msix.

How is this related to the virtio-scsi patch that you posted?  Do you
need both to fix the problem you reported?

Paolo
