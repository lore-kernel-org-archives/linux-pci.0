Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.99]:37102 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1750735AbdH1SZH (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Mon, 28 Aug 2017 14:25:07 -0400
Date: Mon, 28 Aug 2017 13:25:05 -0500
From: Bjorn Helgaas <helgaas@kernel.org>
To: Colin King <colin.king@canonical.com>
Cc: Kishon Vijay Abraham I <kishon@ti.com>,
        Bjorn Helgaas <bhelgaas@google.com>, linux-pci@vger.kernel.org,
        kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH][pci-next] PCI: endpoint: fix incorrect end of table
 check in while loop
Message-ID: <20170828182505.GH8154@bhelgaas-glaptop.roam.corp.google.com>
References: <20170823160303.23366-1-colin.king@canonical.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20170823160303.23366-1-colin.king@canonical.com>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Wed, Aug 23, 2017 at 05:03:03PM +0100, Colin King wrote:
> From: Colin Ian King <colin.king@canonical.com>
> 
> Currently, the while loop will iterate until a matching name is found
> or until the id pointer wraps around to NULL (the latter is incorrect).
> 
> The end of a pci_epf_device_id table is terminated with zero'd entries
> for name and driver_data, so can change the while loop to iterate while
> the first character in the name is a non-zero character.
> 
> Detected by CoverityScan, CID#1454557 ("Logically dead code")
> 
> Fixes: 9e9d6eb48623 ("PCI: endpoint: Add an API to get matching "pci_epf_device_id")
> Signed-off-by: Colin Ian King <colin.king@canonical.com>

Kishon, do you want to ack this, please?

> ---
>  drivers/pci/endpoint/pci-epf-core.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/pci/endpoint/pci-epf-core.c b/drivers/pci/endpoint/pci-epf-core.c
> index ae6fac5995e3..70eccc04ee7f 100644
> --- a/drivers/pci/endpoint/pci-epf-core.c
> +++ b/drivers/pci/endpoint/pci-epf-core.c
> @@ -273,7 +273,7 @@ pci_epf_match_device(const struct pci_epf_device_id *id, struct pci_epf *epf)
>  	if (!id || !epf)
>  		return NULL;
>  
> -	while (id) {
> +	while (*id->name) {
>  		if (strcmp(epf->name, id->name) == 0)
>  			return id;
>  		id++;
> -- 
> 2.14.1
> 
