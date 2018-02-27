Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from usa-sjc-mx-foss1.foss.arm.com ([217.140.101.70]:39252 "EHLO
        foss.arm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751554AbeB0RuE (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Tue, 27 Feb 2018 12:50:04 -0500
Date: Tue, 27 Feb 2018 17:49:57 +0000
From: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
To: Shawn Lin <shawn.lin@rock-chips.com>
Cc: Bjorn Helgaas <bhelgaas@google.com>, linux-pci@vger.kernel.org
Subject: Re: [PATCH] PCI: Fix possible NULL pointer dereference for
 of_pci_bus_find_domain_nr
Message-ID: <20180227174957.GA12756@e107981-ln.cambridge.arm.com>
References: <1519526762-136838-1-git-send-email-shawn.lin@rock-chips.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1519526762-136838-1-git-send-email-shawn.lin@rock-chips.com>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Sun, Feb 25, 2018 at 10:46:02AM +0800, Shawn Lin wrote:
> pci_register_host_bridge records bus->domain_nr from
> pci_bus_find_domain_nr but not guarantee not to pass a NULL
> struct device *parent to it which could be explained by the hint
> of checkcing for parent device before calling set_dev_node(),
> just lines after that. So of_pci_bus_find_domain_nr wisely check
> the parent pointer at the very beginning, but forgot to check it
> again when trying to get of_node from parent, which could causes
> a NULL pointer dereference. Fix it by dumping the NULL pointer
> address simply, if no parent available.
> 
> Signed-off-by: Shawn Lin <shawn.lin@rock-chips.com>
> ---
> 
>  drivers/pci/pci.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/pci/pci.c b/drivers/pci/pci.c
> index f6a4dd1..ef18c48 100644
> --- a/drivers/pci/pci.c
> +++ b/drivers/pci/pci.c
> @@ -5612,7 +5612,7 @@ static int of_pci_bus_find_domain_nr(struct device *parent)
>  		domain = pci_get_new_domain_nr();
>  	} else {
>  		dev_err(parent, "Node %pOF has inconsistent \"linux,pci-domain\" property in DT\n",
> -			parent->of_node);
> +			parent ? parent->of_node : NULL);

I really need to get rid of this function in its current form. In the
interim, I think that printing NULL as faulting node gives no
information whatsoever so this patch should be updated either by
avoiding to print or better by demoting the dev_err() to a pr_err(),
whatever works better for Bjorn.

Thanks,
Lorenzo

>  		domain = -1;
>  	}
>  
> -- 
> 1.9.1
> 
> 
