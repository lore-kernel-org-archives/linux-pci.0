Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.136]:35320 "EHLO mail.kernel.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751087AbcDLErc (ORCPT <rfc822;linux-pci@vger.kernel.org>);
	Tue, 12 Apr 2016 00:47:32 -0400
Date: Mon, 11 Apr 2016 23:47:29 -0500
From: Bjorn Helgaas <helgaas@kernel.org>
To: Adrian-Ken Rueegsegger <ken@codelabs.ch>
Cc: linux-pci@vger.kernel.org
Subject: Re: [RFC PATCH] x86/PCI: Refine PCI support check in pcibios_init()
Message-ID: <20160412044729.GC11361@localhost>
References: <1458729269-9440-1-git-send-email-ken@codelabs.ch>
 <1458729269-9440-2-git-send-email-ken@codelabs.ch>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1458729269-9440-2-git-send-email-ken@codelabs.ch>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Wed, Mar 23, 2016 at 11:34:29AM +0100, Adrian-Ken Rueegsegger wrote:
> Also consider raw_pci_ext_ops when validating if a system has PCI
> support. This leads to proper resource allocation via
> pcibios_resource_survey() in the case where PCI config space is
> exclusively accessed through MMCONFIG.
> 
> Signed-off-by: Adrian-Ken Rueegsegger <ken@codelabs.ch>

Applied to pci/enumeration for v4.7, thanks!

> ---
>  arch/x86/pci/common.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/arch/x86/pci/common.c b/arch/x86/pci/common.c
> index 8fd6f44..50b123d 100644
> --- a/arch/x86/pci/common.c
> +++ b/arch/x86/pci/common.c
> @@ -517,7 +517,7 @@ void __init pcibios_set_cache_line_size(void)
>  
>  int __init pcibios_init(void)
>  {
> -	if (!raw_pci_ops) {
> +	if (!raw_pci_ops && !raw_pci_ext_ops) {
>  		printk(KERN_WARNING "PCI: System does not support PCI\n");
>  		return 0;
>  	}
> -- 
> 2.1.4
> 
> --
> To unsubscribe from this list: send the line "unsubscribe linux-pci" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
