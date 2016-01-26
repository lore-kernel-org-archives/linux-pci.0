Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mx2.suse.de ([195.135.220.15]:34959 "EHLO mx2.suse.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754335AbcAZKMs (ORCPT <rfc822;linux-pci@vger.kernel.org>);
	Tue, 26 Jan 2016 05:12:48 -0500
Date: Tue, 26 Jan 2016 11:12:44 +0100
From: Borislav Petkov <bp@suse.de>
To: "Jean Delvare (by way of Jean Delvare <jdelvare@suse.de>)"
	<jdelvare@suse.de>
Cc: linux-pci@vger.kernel.org, Bjorn Helgaas <bhelgaas@google.com>,
	john.ronciak@intel.com, tony.luck@intel.com,
	Thomas Renninger <trenn@suse.de>
Subject: Re: [PATCH] PCI: aer_inject: Log actual error causes
Message-ID: <20160126101244.GB8475@pd.tnic>
References: <20160126095205.0e5923bd@endymion.delvare>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
In-Reply-To: <20160126095205.0e5923bd@endymion.delvare>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Tue, Jan 26, 2016 at 09:52:05AM +0100, Jean Delvare (by way of Jean Delvare <jdelvare@suse.de>) wrote:
> The aer_inject driver is very quiet. In most cases, it merely returns
> an error code to user-space, leaving the user with little clue about
> the actual reason for the failure.
> 
> So, log error messages for 4 of the most frequent causes of failure:
> * Can't find the root port of the specified device.
> * Device doesn't support AER.
> * Root port doesn't support AER.
> * AER device not found.
> This gives the user a chance to understand why aer-inject failed.
> 
> Based on a preliminary patch by Thomas Renninger.
> 
> Signed-off-by: Jean Delvare <jdelvare@suse.de>
> Cc: Thomas Renninger <trenn@suse.de>
> Cc: Bjorn Helgaas <bhelgaas@google.com>
> ---
>  drivers/pci/pcie/aer/aer_inject.c |    8 +++++++-
>  1 file changed, 7 insertions(+), 1 deletion(-)
> 
> --- linux-4.5-rc0.orig/drivers/pci/pcie/aer/aer_inject.c	2016-01-20 09:25:54.815852332 +0100
> +++ linux-4.5-rc0/drivers/pci/pcie/aer/aer_inject.c	2016-01-26 09:41:17.361994839 +0100
> @@ -334,12 +334,14 @@ static int aer_inject(struct aer_error_i
>  		return -ENODEV;
>  	rpdev = pcie_find_root_port(dev);
>  	if (!rpdev) {
> +		dev_err(&dev->dev, "aer_inject: Root port not found\n");
>  		ret = -ENODEV;
>  		goto out_put;
>  	}
>  
>  	pos_cap_err = pci_find_ext_capability(dev, PCI_EXT_CAP_ID_ERR);
>  	if (!pos_cap_err) {
> +		dev_err(&dev->dev, "aer_inject: Device doesn't support AER\n");
>  		ret = -EPERM;

Btw, this -EPERM looks wrong - if we're checking for capabilities, we
shouldn't be returning -EPERM but maybe something like -ENODEV or so.

>  		goto out_put;
>  	}
> @@ -350,6 +352,8 @@ static int aer_inject(struct aer_error_i
>  
>  	rp_pos_cap_err = pci_find_ext_capability(rpdev, PCI_EXT_CAP_ID_ERR);
>  	if (!rp_pos_cap_err) {
> +		dev_err(&rpdev->dev,
> +			"aer_inject: Root port doesn't support AER\n");
>  		ret = -EPERM;

Ditto.

>  		goto out_put;
>  	}
> @@ -462,8 +466,10 @@ static int aer_inject(struct aer_error_i
>  			goto out_put;
>  		}
>  		aer_irq(-1, edev);
> -	} else
> +	} else {
> +		dev_err(&rpdev->dev, "aer_inject: AER device not found\n");

So other error prints in that function do printk(KERN_WARNING. Why
dev_err()?

Why not pr_err() and define pr_fmt to "aer_inject: " and then drop
that prefix from the messages?

Thanks.

-- 
Regards/Gruss,
    Boris.

SUSE Linux GmbH, GF: Felix Imendörffer, Jane Smithard, Graham Norton, HRB 21284 (AG Nürnberg)
-- 
