Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.136]:50548 "EHLO mail.kernel.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752101AbcFKAVJ (ORCPT <rfc822;linux-pci@vger.kernel.org>);
	Fri, 10 Jun 2016 20:21:09 -0400
Date: Fri, 10 Jun 2016 19:21:05 -0500
From: Bjorn Helgaas <helgaas@kernel.org>
To: Ben Dooks <ben.dooks@codethink.co.uk>
Cc: linux-kernel@lists.codethink.co.uk,
	Bjorn Helgaas <bhelgaas@google.com>, linux-pci@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] pci: make bus_attr_resource_alignemnt static
Message-ID: <20160611002105.GI16462@localhost>
References: <1465468933-6922-1-git-send-email-ben.dooks@codethink.co.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1465468933-6922-1-git-send-email-ben.dooks@codethink.co.uk>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Thu, Jun 09, 2016 at 11:42:13AM +0100, Ben Dooks wrote:
> The symbol bus_attr_resource_alignment is not exported or declared
> elsewhere, so make it static to fix the following warning:
> 
> drivers/pci/pci.c:4900:1: warning: symbol 'bus_attr_resource_alignment' was not declared. Should it be static?
> 
> Signed-off-by: Ben Dooks <ben.dooks@codethink.co.uk>

Applied to pci/misc for v4.8, thanks, Ben.

> ---
> Cc: Bjorn Helgaas <bhelgaas@google.com>
> Cc: linux-pci@vger.kernel.org
> Cc: linux-kernel@vger.kernel.org
> ---
>  drivers/pci/pci.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/pci/pci.c b/drivers/pci/pci.c
> index c8b4dbd..9add285 100644
> --- a/drivers/pci/pci.c
> +++ b/drivers/pci/pci.c
> @@ -4897,7 +4897,7 @@ static ssize_t pci_resource_alignment_store(struct bus_type *bus,
>  	return pci_set_resource_alignment_param(buf, count);
>  }
>  
> -BUS_ATTR(resource_alignment, 0644, pci_resource_alignment_show,
> +static BUS_ATTR(resource_alignment, 0644, pci_resource_alignment_show,
>  					pci_resource_alignment_store);
>  
>  static int __init pci_resource_alignment_sysfs_init(void)
> -- 
> 2.8.1
> 
> --
> To unsubscribe from this list: send the line "unsubscribe linux-pci" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
