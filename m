Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.99]:58542 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1034023AbeCASxM (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Thu, 1 Mar 2018 13:53:12 -0500
Date: Thu, 1 Mar 2018 12:53:09 -0600
From: Bjorn Helgaas <helgaas@kernel.org>
To: Shawn Lin <shawn.lin@rock-chips.com>
Cc: Bjorn Helgaas <bhelgaas@google.com>, linux-pci@vger.kernel.org,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
Subject: Re: [RESEND PATCH v2] PCI: Fix possible NULL pointer dereference for
 of_pci_bus_find_domain_nr
Message-ID: <20180301185309.GJ13722@bhelgaas-glaptop.roam.corp.google.com>
References: <1519867615-37327-1-git-send-email-shawn.lin@rock-chips.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1519867615-37327-1-git-send-email-shawn.lin@rock-chips.com>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Thu, Mar 01, 2018 at 09:26:55AM +0800, Shawn Lin wrote:
> If the "parent" pointer passed to of_pci_bus_find_domain_nr() is NULL,
> don't dereference it.
> 
> Signed-off-by: Shawn Lin <shawn.lin@rock-chips.com>

Applied to pci/misc for v4.17, thanks!

> ---
> 
> Changes in v2:
> - Convert to use pr_err and only print valid device node if 'parent'
> isn't NULL.
> 
>  drivers/pci/pci.c | 5 +++--
>  1 file changed, 3 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/pci/pci.c b/drivers/pci/pci.c
> index ae654e2..06f7f9d 100644
> --- a/drivers/pci/pci.c
> +++ b/drivers/pci/pci.c
> @@ -5607,8 +5607,9 @@ static int of_pci_bus_find_domain_nr(struct device *parent)
>  		use_dt_domains = 0;
>  		domain = pci_get_new_domain_nr();
>  	} else {
> -		dev_err(parent, "Node %pOF has inconsistent \"linux,pci-domain\" property in DT\n",
> -			parent->of_node);
> +		if (parent)
> +			pr_err("Node %pOF has ", parent->of_node);
> +		pr_err("Inconsistent \"linux,pci-domain\" property in DT\n");
>  		domain = -1;
>  	}
>  
> -- 
> 1.9.1
> 
> 
