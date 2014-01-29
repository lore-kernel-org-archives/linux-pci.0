Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-ie0-f174.google.com ([209.85.223.174]:38499 "EHLO
	mail-ie0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751335AbaA2XM0 (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Wed, 29 Jan 2014 18:12:26 -0500
Received: by mail-ie0-f174.google.com with SMTP id tp5so2764398ieb.33
        for <linux-pci@vger.kernel.org>; Wed, 29 Jan 2014 15:12:25 -0800 (PST)
Date: Wed, 29 Jan 2014 16:12:22 -0700
From: Bjorn Helgaas <bhelgaas@google.com>
To: Djalal Harouni <tixxdz@opendz.org>
Cc: linux-pci@vger.kernel.org
Subject: Re: [PATCH] PCI: fix a memory leak of pci_host_bridge on error path
Message-ID: <20140129231222.GI16825@google.com>
References: <1389741079-12976-1-git-send-email-tixxdz@opendz.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1389741079-12976-1-git-send-email-tixxdz@opendz.org>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Wed, Jan 15, 2014 at 12:11:19AM +0100, Djalal Harouni wrote:
> On error paths make sure that the pci_host_bridge struct is freed.
> 
> Signed-off-by: Djalal Harouni <tixxdz@opendz.org>

Applied to pci/misc, thanks!

> ---
> On top of linux-next.
> 
>  drivers/pci/probe.c | 10 +++++-----
>  1 file changed, 5 insertions(+), 5 deletions(-)
> 
> diff --git a/drivers/pci/probe.c b/drivers/pci/probe.c
> index 23cdfac..483566c 100644
> --- a/drivers/pci/probe.c
> +++ b/drivers/pci/probe.c
> @@ -1771,15 +1771,13 @@ struct pci_bus *pci_create_root_bus(struct device *parent, int bus,
>  	bridge->dev.release = pci_release_host_bridge_dev;
>  	dev_set_name(&bridge->dev, "pci%04x:%02x", pci_domain_nr(b), bus);
>  	error = pcibios_root_bridge_prepare(bridge);
> -	if (error) {
> -		kfree(bridge);
> -		goto err_out;
> -	}
> +	if (error)
> +		goto host_bridge_err;
>  
>  	error = device_register(&bridge->dev);
>  	if (error) {
>  		put_device(&bridge->dev);
> -		goto err_out;
> +		goto host_bridge_err;
>  	}
>  	b->bridge = get_device(&bridge->dev);
>  	device_enable_async_suspend(b->bridge);
> @@ -1836,6 +1834,8 @@ struct pci_bus *pci_create_root_bus(struct device *parent, int bus,
>  class_dev_reg_err:
>  	put_device(&bridge->dev);
>  	device_unregister(&bridge->dev);
> +host_bridge_err:
> +	kfree(bridge);
>  err_out:
>  	kfree(b);
>  	return NULL;
> -- 
> 1.7.11.7
> 
