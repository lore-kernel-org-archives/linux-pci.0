Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-pd0-f170.google.com ([209.85.192.170]:60178 "EHLO
	mail-pd0-f170.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754174AbaICSmw (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Wed, 3 Sep 2014 14:42:52 -0400
Received: by mail-pd0-f170.google.com with SMTP id r10so11705662pdi.1
        for <linux-pci@vger.kernel.org>; Wed, 03 Sep 2014 11:42:48 -0700 (PDT)
Date: Wed, 3 Sep 2014 12:43:19 -0600
From: Bjorn Helgaas <bhelgaas@google.com>
To: Tobias Klauser <tklauser@distanz.ch>
Cc: linux-pci@vger.kernel.org
Subject: Re: [PATCH] PCI: Remove unnecessary variable in pci_add_dynid()
Message-ID: <20140903184319.GC26073@google.com>
References: <1406277374-559-1-git-send-email-tklauser@distanz.ch>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1406277374-559-1-git-send-email-tklauser@distanz.ch>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Fri, Jul 25, 2014 at 10:36:14AM +0200, Tobias Klauser wrote:
> The variable retval in pci_add_dynid() is only used to store the return
> value of driver_attach() and is then directly returned. Remove the
> variable and directly pass on driver_attach()'s return value.
> 
> Signed-off-by: Tobias Klauser <tklauser@distanz.ch>

Applied to pci/misc for v3.18, thanks!

> ---
>  drivers/pci/pci-driver.c | 5 +----
>  1 file changed, 1 insertion(+), 4 deletions(-)
> 
> diff --git a/drivers/pci/pci-driver.c b/drivers/pci/pci-driver.c
> index d04c5ad..2b3c894 100644
> --- a/drivers/pci/pci-driver.c
> +++ b/drivers/pci/pci-driver.c
> @@ -55,7 +55,6 @@ int pci_add_dynid(struct pci_driver *drv,
>  		  unsigned long driver_data)
>  {
>  	struct pci_dynid *dynid;
> -	int retval;
>  
>  	dynid = kzalloc(sizeof(*dynid), GFP_KERNEL);
>  	if (!dynid)
> @@ -73,9 +72,7 @@ int pci_add_dynid(struct pci_driver *drv,
>  	list_add_tail(&dynid->node, &drv->dynids.list);
>  	spin_unlock(&drv->dynids.lock);
>  
> -	retval = driver_attach(&drv->driver);
> -
> -	return retval;
> +	return driver_attach(&drv->driver);
>  }
>  EXPORT_SYMBOL_GPL(pci_add_dynid);
>  
> -- 
> 2.0.1
> 
> 
