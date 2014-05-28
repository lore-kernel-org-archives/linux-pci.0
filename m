Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-ie0-f170.google.com ([209.85.223.170]:55466 "EHLO
	mail-ie0-f170.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751916AbaE1DWR (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Tue, 27 May 2014 23:22:17 -0400
Received: by mail-ie0-f170.google.com with SMTP id at1so9774627iec.15
        for <linux-pci@vger.kernel.org>; Tue, 27 May 2014 20:22:17 -0700 (PDT)
Date: Tue, 27 May 2014 21:22:13 -0600
From: Bjorn Helgaas <bhelgaas@google.com>
To: Yijing Wang <wangyijing@huawei.com>
Cc: linux-pci@vger.kernel.org, Yinghai Lu <yinghai@kernel.org>
Subject: Re: [PATCH] PCI: fix return in pci_bus_add_device
Message-ID: <20140528032213.GP11907@google.com>
References: <1400729544-7940-1-git-send-email-wangyijing@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1400729544-7940-1-git-send-email-wangyijing@huawei.com>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

[+cc Yinghai]

On Thu, May 22, 2014 at 11:32:24AM +0800, Yijing Wang wrote:
> Fix device_attach() return vaule in pci_bus_add_device
> instead of meaningless 0.
> 
> Signed-off-by: Yijing Wang <wangyijing@huawei.com>
> ---
>  drivers/pci/bus.c |    2 +-
>  1 files changed, 1 insertions(+), 1 deletions(-)
> 
> diff --git a/drivers/pci/bus.c b/drivers/pci/bus.c
> index ba2bf55..42b42b7 100644
> --- a/drivers/pci/bus.c
> +++ b/drivers/pci/bus.c
> @@ -253,7 +253,7 @@ int pci_bus_add_device(struct pci_dev *dev)
>  
>  	dev->is_added = 1;
>  
> -	return 0;
> +	return retval;

I'd like to see a Reviewed-by: from Yinghai, since he recently changed
this area, e.g.,

  4f535093cf8f PCI: Put pci_dev in device tree as early as possible
  58d9a38f6fac PCI: Skip attaching driver in device_add()

Bjorn

>  }
>  
>  /**
> -- 
> 1.7.1
> 
> 
> --
> To unsubscribe from this list: send the line "unsubscribe linux-pci" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
