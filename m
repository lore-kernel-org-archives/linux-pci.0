Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.99]:41954 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725870AbeHNX5Y (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Tue, 14 Aug 2018 19:57:24 -0400
Date: Tue, 14 Aug 2018 16:08:21 -0500
From: Bjorn Helgaas <helgaas@kernel.org>
To: Bert Kenward <bkenward@solarflare.com>
Cc: Bjorn Helgaas <bhelgaas@google.com>, linux-pci@vger.kernel.org
Subject: Re: [PATCH] pci/vpd: Ensure VPD is checked before timeout
Message-ID: <20180814210821.GB28888@bhelgaas-glaptop.roam.corp.google.com>
References: <66bbf8b3-bab9-1860-12c9-1c187ddc4201@solarflare.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <66bbf8b3-bab9-1860-12c9-1c187ddc4201@solarflare.com>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Thu, Jul 26, 2018 at 04:21:29PM +0100, Bert Kenward wrote:
> We check the timeout before we check the VPD access completion bit.
> On a very heavily loaded system this can cause VPD access to timeout.
> We should check the completion bit before checking the timeout.
> 
> Signed-off-by: Bert Kenward <bkenward@solarflare.com>

Applied to pci/misc for v4.19, thanks!

> ---
>  drivers/pci/vpd.c | 7 +++++--
>  1 file changed, 5 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/pci/vpd.c b/drivers/pci/vpd.c
> index 8617565ba561..4963c2e2bd4c 100644
> --- a/drivers/pci/vpd.c
> +++ b/drivers/pci/vpd.c
> @@ -146,7 +146,7 @@ static int pci_vpd_wait(struct pci_dev *dev)
>  	if (!vpd->busy)
>  		return 0;
>  
> -	while (time_before(jiffies, timeout)) {
> +	do {
>  		ret = pci_user_read_config_word(dev, vpd->cap + PCI_VPD_ADDR,
>  						&status);
>  		if (ret < 0)
> @@ -160,10 +160,13 @@ static int pci_vpd_wait(struct pci_dev *dev)
>  		if (fatal_signal_pending(current))
>  			return -EINTR;
>  
> +		if (time_after(jiffies, timeout))
> +			break;
> +
>  		usleep_range(10, max_sleep);
>  		if (max_sleep < 1024)
>  			max_sleep *= 2;
> -	}
> +	} while (true);
>  
>  	pci_warn(dev, "VPD access failed.  This is likely a firmware bug on this device.  Contact the card vendor for a firmware update\n");
>  	return -ETIMEDOUT;
> -- 
> 2.13.6
> 
