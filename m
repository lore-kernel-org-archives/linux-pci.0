Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-ob0-f170.google.com ([209.85.214.170]:48836 "EHLO
	mail-ob0-f170.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752664AbbBKWvC (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Wed, 11 Feb 2015 17:51:02 -0500
Received: by mail-ob0-f170.google.com with SMTP id va2so6472495obc.1
        for <linux-pci@vger.kernel.org>; Wed, 11 Feb 2015 14:51:01 -0800 (PST)
Date: Wed, 11 Feb 2015 16:50:57 -0600
From: Bjorn Helgaas <bhelgaas@google.com>
To: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
Cc: linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org,
	jiang.liu@linux.intel.com, "Rafael J. Wysocki" <rjw@rjwysocki.net>
Subject: Re: [PATCH] drivers: of: pci: remove duplicate kfree in
 of_pci_get_host_bridge_resources
Message-ID: <20150211225057.GA16317@google.com>
References: <1423630715-23568-1-git-send-email-lorenzo.pieralisi@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1423630715-23568-1-git-send-email-lorenzo.pieralisi@arm.com>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Wed, Feb 11, 2015 at 04:58:35AM +0000, Lorenzo Pieralisi wrote:
> Commit d2be00c0fb5a ("of/pci: Free resources on failure in
> of_pci_get_host_bridge_resources()") fixed the error code path in
> of_pci_get_host_bridge_resources() by adding code that runs through the
> resources list to free all resources in it and then calls kfree on the
> bus_range resource pointer to complete the memory deallocation.
> Since the bus_range resource is added to the resources list through
> pci_add_resource, the resource_list_for_each_entry loop in the error
> exit path frees it already and freeing it anew could trigger a double
> free, hence this patch removes the superfluos kfree call on the bus_range
> resource.
> 
> Fixes: d2be00c0fb5a ("of/pci: Free resources on failure in of_pci_get_host_bridge_resources()")
> Signed-off-by: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
> Reported-by: Jiang Liu <jiang.liu@linux.intel.com>
> Cc: Bjorn Helgaas <bhelgaas@google.com>
> Cc: Rafael J. Wysocki <rjw@rjwysocki.net>

I applied this to for-linus, and will ask Linus to put it in before
v3.20-rc1, thanks!

Rafael, I applied d2be00c0fb5a, where the bug originally came from, but I
see that you fixed it with 5c493df25a0d and the fix got lost because of an
incorrect merge resolution.  So if you'd rather take this, just let me
know.

> ---
>  drivers/of/of_pci.c | 1 -
>  1 file changed, 1 deletion(-)
> 
> diff --git a/drivers/of/of_pci.c b/drivers/of/of_pci.c
> index 110fece..62426d8 100644
> --- a/drivers/of/of_pci.c
> +++ b/drivers/of/of_pci.c
> @@ -229,7 +229,6 @@ parse_failed:
>  	resource_list_for_each_entry(window, resources)
>  		kfree(window->res);
>  	pci_free_resource_list(resources);
> -	kfree(bus_range);
>  	return err;
>  }
>  EXPORT_SYMBOL_GPL(of_pci_get_host_bridge_resources);
> -- 
> 2.2.1
> 
