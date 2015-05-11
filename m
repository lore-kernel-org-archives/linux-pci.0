Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from userp1040.oracle.com ([156.151.31.81]:23170 "EHLO
	userp1040.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754302AbbEKNsB (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Mon, 11 May 2015 09:48:01 -0400
Date: Mon, 11 May 2015 09:47:47 -0400
From: Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>
To: Tina Ruchandani <ruchandani.tina@gmail.com>
Cc: Arnd Bergmann <arnd@arndb.de>, y2038@lists.linaro.org,
	Boris Ostrovsky <boris.ostrovsky@oracle.com>,
	David Vrabel <david.vrabel@citrix.com>,
	Bjorn Helgaas <bhelgaas@google.com>,
	xen-devel@lists.xenproject.org, linux-pci@vger.kernel.org
Subject: Re: [PATCH] xen/pcifront: Remove usage of struct timeval
Message-ID: <20150511134747.GB18474@l.oracle.com>
References: <20150511024448.GA2836@tinar>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20150511024448.GA2836@tinar>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Mon, May 11, 2015 at 08:14:48AM +0530, Tina Ruchandani wrote:
> struct timeval uses a 32-bit field for representing seconds,
> which will overflow in the year 2038 and beyond. This patch replaces
> struct timeval with 64-bit ktime_t which is 2038 safe.
> The patch is part of a larger effort to remove instances of
> 32-bit timekeeping variables (timeval, time_t and timespec)
> from the kernel.
> 
> Signed-off-by: Tina Ruchandani <ruchandani.tina@gmail.com>


Looks OK to me.
> ---
>  drivers/pci/xen-pcifront.c | 11 ++++++-----
>  1 file changed, 6 insertions(+), 5 deletions(-)
> 
> diff --git a/drivers/pci/xen-pcifront.c b/drivers/pci/xen-pcifront.c
> index 7cfd2db..43d1d6c 100644
> --- a/drivers/pci/xen-pcifront.c
> +++ b/drivers/pci/xen-pcifront.c
> @@ -20,6 +20,7 @@
>  #include <linux/workqueue.h>
>  #include <linux/bitops.h>
>  #include <linux/time.h>
> +#include <linux/ktime.h>
>  #include <xen/platform_pci.h>
>  
>  #include <asm/xen/swiotlb-xen.h>
> @@ -115,7 +116,7 @@ static int do_pci_op(struct pcifront_device *pdev, struct xen_pci_op *op)
>  	evtchn_port_t port = pdev->evtchn;
>  	unsigned irq = pdev->irq;
>  	s64 ns, ns_timeout;
> -	struct timeval tv;
> +	ktime_t tv;
>  
>  	spin_lock_irqsave(&pdev->sh_info_lock, irq_flags);
>  
> @@ -132,8 +133,8 @@ static int do_pci_op(struct pcifront_device *pdev, struct xen_pci_op *op)
>  	 * (in the latter case we end up continually re-executing poll() with a
>  	 * timeout in the past). 1s difference gives plenty of slack for error.
>  	 */
> -	do_gettimeofday(&tv);
> -	ns_timeout = timeval_to_ns(&tv) + 2 * (s64)NSEC_PER_SEC;
> +	tv = ktime_get_real();
> +	ns_timeout = ktime_to_ns(tv) + 2 * (s64)NSEC_PER_SEC;
>  
>  	xen_clear_irq_pending(irq);
>  
> @@ -141,8 +142,8 @@ static int do_pci_op(struct pcifront_device *pdev, struct xen_pci_op *op)
>  			(unsigned long *)&pdev->sh_info->flags)) {
>  		xen_poll_irq_timeout(irq, jiffies + 3*HZ);
>  		xen_clear_irq_pending(irq);
> -		do_gettimeofday(&tv);
> -		ns = timeval_to_ns(&tv);
> +		tv = ktime_get_real();
> +		ns = ktime_to_ns(tv);
>  		if (ns > ns_timeout) {
>  			dev_err(&pdev->xdev->dev,
>  				"pciback not responding!!!\n");
> -- 
> 2.2.0.rc0.207.ga3a616c
> 
