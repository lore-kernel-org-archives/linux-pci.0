Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:52203 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752080AbbCPMOM (ORCPT <rfc822;linux-pci@vger.kernel.org>);
	Mon, 16 Mar 2015 08:14:12 -0400
Date: Mon, 16 Mar 2015 13:14:06 +0100
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Fam Zheng <famz@redhat.com>
Cc: linux-kernel@vger.kernel.org, Bjorn Helgaas <bhelgaas@google.com>,
	linux-pci@vger.kernel.org, yhlu.kernel.send@gmail.com
Subject: Re: [RFC PATCH] PCI: Disable MSI/MSI-X only if device is shutdown
Message-ID: <20150316062407-mutt-send-email-mst@redhat.com>
References: <1426137682-12287-1-git-send-email-famz@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1426137682-12287-1-git-send-email-famz@redhat.com>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Thu, Mar 12, 2015 at 01:21:22PM +0800, Fam Zheng wrote:
> If the device doesn't support shutdown, disabling interrupts may cause
> trouble. For example, virtio-scsi-pci doesn't implement shutdown, and
> after we disable MSI-X, futher notifications from device will be
> delivered to IRQ, which is unexpected.


> This IRQ will not be cleared, and
> may prevent us from making progress, by keep triggering interrupts.

I would say:
	Since there's no handler, the interrupt line will never be cleared,
	causing a deadlock.

> 
> Signed-off-by: Fam Zheng <famz@redhat.com>

However, see below:

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

So the following bus reset will disable msi anyway,
IMHO there's no need to do it in software.
kexec is more interesting. This is an attempt to leave
device in a consistent state:

	commit d52877c7b1afb8c37ebe17e2005040b79cb618b0
	Author: Yinghai Lu <yhlu.kernel.send@gmail.com>
	Date:   Wed Apr 23 14:58:09 2008 -0700
	    pci/irq: let pci_device_shutdown to call pci_msi_shutdown v2

but arguably, it's better to disable msi/msix when kexec
starts - for example, kexec might run after a crash (kdump)
and shutdown callbacks are not invoked in that case.


The reason this does not trigger for MPT is because
it has an intx handler so that gets invoked.

So here's my proposal:
- for 4.0, let's just do a virtio specific work-around,
  this seems safer.
- for 4.1, let's disable msi/msix first thing on
  kexec startup, before driver probe.

I'll post both patches shortly.

>  #ifdef CONFIG_KEXEC
>  	/*
> -- 
> 1.9.3




