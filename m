Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.136]:33374 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1750828AbdBCRTD (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Fri, 3 Feb 2017 12:19:03 -0500
Date: Fri, 3 Feb 2017 11:18:59 -0600
From: Bjorn Helgaas <helgaas@kernel.org>
To: "Matthew R. Ochs" <mrochs@linux.vnet.ibm.com>
Cc: Bjorn Helgaas <bhelgaas@google.com>, linux-pci@vger.kernel.org,
        Uma Krishnan <ukrishn@linux.vnet.ibm.com>
Subject: Re: [PATCH] PCI: Increase VPD access timeout
Message-ID: <20170203171859.GA10291@bhelgaas-glaptop.roam.corp.google.com>
References: <1480442440-11540-1-git-send-email-mrochs@linux.vnet.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1480442440-11540-1-git-send-email-mrochs@linux.vnet.ibm.com>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Tue, Nov 29, 2016 at 12:00:40PM -0600, Matthew R. Ochs wrote:
> The PCI core uses a fixed 50ms timeout when waiting for VPD accesses to
> complete. When an access does not complete within this period, a warning
> is logged and an error returned to the caller.
> 
> While this default timeout is valid for most hardware, some devices can
> experience longer access delays under certain circumstances. For example,
> one of the IBM CXL Flash devices can take up to ~120ms in a worst-case
> scenario. These types of devices can benefit from an extended timeout.
> 
> To support devices with a longer access delay, increase the timeout in
> pci_vpd_wait() to 125ms. The PCI specification is silent with respect to
> VPD delays, therefore there is no concern for violating a threshold.
> 
> Signed-off-by: Matthew R. Ochs <mrochs@linux.vnet.ibm.com>

Applied to pci/vpd for v4.11, with Tested-by Uma and Reviewed-by Gavin,
thanks!

> ---
>  drivers/pci/access.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/pci/access.c b/drivers/pci/access.c
> index d11cdbb..61b5a6b 100644
> --- a/drivers/pci/access.c
> +++ b/drivers/pci/access.c
> @@ -355,7 +355,7 @@ static size_t pci_vpd_size(struct pci_dev *dev, size_t old_size)
>  static int pci_vpd_wait(struct pci_dev *dev)
>  {
>  	struct pci_vpd *vpd = dev->vpd;
> -	unsigned long timeout = jiffies + msecs_to_jiffies(50);
> +	unsigned long timeout = jiffies + msecs_to_jiffies(125);
>  	unsigned long max_sleep = 16;
>  	u16 status;
>  	int ret;
> -- 
> 2.1.0
> 
> --
> To unsubscribe from this list: send the line "unsubscribe linux-pci" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
