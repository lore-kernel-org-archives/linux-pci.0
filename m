Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.136]:51160 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1750966AbdBJVN3 (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Fri, 10 Feb 2017 16:13:29 -0500
Date: Fri, 10 Feb 2017 15:13:25 -0600
From: Bjorn Helgaas <helgaas@kernel.org>
To: Gabriel Krisman Bertazi <krisman@collabora.co.uk>
Cc: bhelgaas@google.com, linux-pci@vger.kernel.org
Subject: Re: [PATCH] pci: Don't duplicate fix up for positive error code
Message-ID: <20170210211325.GM29169@bhelgaas-glaptop.roam.corp.google.com>
References: <20170206153414.23854-1-krisman@collabora.co.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20170206153414.23854-1-krisman@collabora.co.uk>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Mon, Feb 06, 2017 at 01:34:14PM -0200, Gabriel Krisman Bertazi wrote:
> Function __pci_device_probe tries to be careful about a PCI driver
> probe() hook returning a positive value, but this is not really
> necessary, since the same fix up is already done in
> local_pci_probe (preceded by a noisy warning), which renders this
> instance dead code.
> 
> Signed-off-by: Gabriel Krisman Bertazi <krisman@collabora.co.uk>

Applied to pci/enumeration for v4.11, thanks, Gabriel!

> ---
>  drivers/pci/pci-driver.c | 2 --
>  1 file changed, 2 deletions(-)
> 
> diff --git a/drivers/pci/pci-driver.c b/drivers/pci/pci-driver.c
> index 1ccce1cd6aca..3e0516ee9eab 100644
> --- a/drivers/pci/pci-driver.c
> +++ b/drivers/pci/pci-driver.c
> @@ -381,8 +381,6 @@ static int __pci_device_probe(struct pci_driver *drv, struct pci_dev *pci_dev)
>  		id = pci_match_device(drv, pci_dev);
>  		if (id)
>  			error = pci_call_probe(drv, pci_dev, id);
> -		if (error >= 0)
> -			error = 0;
>  	}
>  	return error;
>  }
> -- 
> 2.11.0
> 
