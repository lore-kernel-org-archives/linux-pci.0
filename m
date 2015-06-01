Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-ig0-f171.google.com ([209.85.213.171]:35748 "EHLO
	mail-ig0-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751468AbbFAXci (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Mon, 1 Jun 2015 19:32:38 -0400
Received: by igbyr2 with SMTP id yr2so74509390igb.0
        for <linux-pci@vger.kernel.org>; Mon, 01 Jun 2015 16:32:36 -0700 (PDT)
Date: Mon, 1 Jun 2015 18:32:33 -0500
From: Bjorn Helgaas <bhelgaas@google.com>
To: Wei Yang <weiyang@linux.vnet.ibm.com>
Cc: gwshan@linux.vnet.ibm.com, linuxppc-dev@lists.ozlabs.org,
	linux-pci@vger.kernel.org
Subject: Re: [PATCH V7 04/10] powerpc/eeh: Trace first 7 BARs in address cache
Message-ID: <20150601233233.GE3631@google.com>
References: <1431999312-10517-1-git-send-email-weiyang@linux.vnet.ibm.com>
 <1432032612-21701-1-git-send-email-weiyang@linux.vnet.ibm.com>
 <1432032612-21701-5-git-send-email-weiyang@linux.vnet.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1432032612-21701-5-git-send-email-weiyang@linux.vnet.ibm.com>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

The subject says "Trace first 7 BARs..."  I think maybe you meant "Track
first 7 BARs" or maybe "Cache only BARs, not windows or IOV BARs"

On Tue, May 19, 2015 at 06:50:06PM +0800, Wei Yang wrote:
> EEH address cache, which helps to locate the PCI device according to
> the given (physical) MMIO address, didn't cover PCI bridges. 

"doesn't contain PCI bridge windows"?

I see that eeh_addr_cache_insert_dev() ignores bridges because it never
calls __eeh_addr_cache_insert_dev() when "(dev->class >> 16) ==
PCI_BASE_CLASS_BRIDGE".  I think it would be more technically correct if
you removed that test and relied on the "i <= PCI_ROM_RESOURCE" test in
this patch, because it is legal (though rare) for bridge devices to have
two BARs, and I assume you would want to put those in your cache if they
exist.

> Also, it
> shouldn't return PF with address in PF's IOV BARs. Instead, the VFs
> should be returned.
> The patch restricts the address cache to cover first 7 BARs for the
> above purposes.
> 
> [gwshan: changelog]
> Signed-off-by: Wei Yang <weiyang@linux.vnet.ibm.com>
> Acked-by: Gavin Shan <gwshan@linux.vnet.ibm.com>
> ---
>  arch/powerpc/kernel/eeh_cache.c |    2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/arch/powerpc/kernel/eeh_cache.c b/arch/powerpc/kernel/eeh_cache.c
> index eeabeab..f6c5f05 100644
> --- a/arch/powerpc/kernel/eeh_cache.c
> +++ b/arch/powerpc/kernel/eeh_cache.c
> @@ -196,7 +196,7 @@ static void __eeh_addr_cache_insert_dev(struct pci_dev *dev)
>  	}
>  
>  	/* Walk resources on this device, poke them into the tree */
> -	for (i = 0; i < DEVICE_COUNT_RESOURCE; i++) {
> +	for (i = 0; i <= PCI_ROM_RESOURCE; i++) {
>  		unsigned long start = pci_resource_start(dev,i);
>  		unsigned long end = pci_resource_end(dev,i);
>  		unsigned int flags = pci_resource_flags(dev,i);
> -- 
> 1.7.9.5
> 
