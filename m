Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-ig0-f180.google.com ([209.85.213.180]:51326 "EHLO
	mail-ig0-f180.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751346AbaJAUHS (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Wed, 1 Oct 2014 16:07:18 -0400
Received: by mail-ig0-f180.google.com with SMTP id uq10so1095353igb.13
        for <linux-pci@vger.kernel.org>; Wed, 01 Oct 2014 13:07:17 -0700 (PDT)
Date: Wed, 1 Oct 2014 14:07:14 -0600
From: Bjorn Helgaas <bhelgaas@google.com>
To: Yinghai Lu <yinghai@kernel.org>
Cc: linux-pci@vger.kernel.org
Subject: Re: [PATCH] PCI: add back missing MEM_64 mask check for hotplug path
Message-ID: <20141001200714.GD4171@google.com>
References: <1408756512-16885-1-git-send-email-yinghai@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1408756512-16885-1-git-send-email-yinghai@kernel.org>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Fri, Aug 22, 2014 at 06:15:07PM -0700, Yinghai Lu wrote:
> We missed that in
> |  commit 5b28541552ef5eeffc41d6936105f38c2508e566
> |    PCI: Restrict 64-bit prefetchable bridge windows to 64-bit resources
> for pci hotplug path.
> 
> We have MEM_64 in type_mask from pci_assign_unassigned_root_bus_resources()
> for boot path.

Applied to pci/resource for v3.18, thanks.

I added a stable tag for v3.16+, since 5b28541552ef appeared in v3.16.

> 
> Signed-off-by: Yinghai Lu <yinghai@kernel.org>
> 
> ---
>  drivers/pci/setup-bus.c |    2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> Index: linux-2.6/drivers/pci/setup-bus.c
> ===================================================================
> --- linux-2.6.orig/drivers/pci/setup-bus.c
> +++ linux-2.6/drivers/pci/setup-bus.c
> @@ -1652,7 +1652,7 @@ void pci_assign_unassigned_bridge_resour
>  	struct pci_dev_resource *fail_res;
>  	int retval;
>  	unsigned long type_mask = IORESOURCE_IO | IORESOURCE_MEM |
> -				  IORESOURCE_PREFETCH;
> +				  IORESOURCE_PREFETCH | IORESOURCE_MEM_64;
>  
>  again:
>  	__pci_bus_size_bridges(parent, &add_list);
