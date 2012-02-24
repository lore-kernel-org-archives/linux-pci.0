Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mprc.pku.edu.cn ([162.105.203.9]:49498 "EHLO mprc.pku.edu.cn"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753982Ab2BXHK4 (ORCPT <rfc822;linux-pci@vger.kernel.org>);
	Fri, 24 Feb 2012 02:10:56 -0500
Message-ID: <1330064364.12600.3.camel@epip-laptop>
Subject: Re: [PATCH v2 11/12] unicore32/PCI: use pci_flags PCI_PROBE_ONLY
 instead of arm-specific flag
From: Guan Xuetao <gxt@mprc.pku.edu.cn>
Reply-To: gxt@mprc.pku.edu.cn
To: Bjorn Helgaas <bhelgaas@google.com>
Cc: linux-pci@vger.kernel.org, linux-arch@vger.kernel.org
Date: Fri, 24 Feb 2012 14:19:24 +0800
In-Reply-To: <20120223194358.20708.90268.stgit@bhelgaas.mtv.corp.google.com>
References: <20120223194209.20708.54480.stgit@bhelgaas.mtv.corp.google.com>
	 <20120223194358.20708.90268.stgit@bhelgaas.mtv.corp.google.com>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Thu, 2012-02-23 at 12:43 -0700, Bjorn Helgaas wrote:
> CC: Guan Xuetao <gxt@mprc.pku.edu.cn>
> Signed-off-by: Bjorn Helgaas <bhelgaas@google.com>
> ---
>  arch/unicore32/kernel/pci.c |    6 +++---
>  1 files changed, 3 insertions(+), 3 deletions(-)
> 
> diff --git a/arch/unicore32/kernel/pci.c b/arch/unicore32/kernel/pci.c
> index a8f07fe..6c1248f 100644
> --- a/arch/unicore32/kernel/pci.c
> +++ b/arch/unicore32/kernel/pci.c
> @@ -19,9 +19,9 @@
>  #include <linux/slab.h>
>  #include <linux/init.h>
>  #include <linux/io.h>
> +#include <asm-generic/pci-bridge.h>
I recommend that asm-generic/pci-bridge.h should be inserted into
asm/pci.h file.

Regards,
Guan Xuetao

>  
>  static int debug_pci;
> -static int use_firmware;
>  
>  #define CONFIG_CMD(bus, devfn, where)	\
>  	(0x80000000 | (bus->number << 16) | (devfn << 8) | (where & ~3))
> @@ -276,7 +276,7 @@ static int __init pci_common_init(void)
>  
>  	pci_fixup_irqs(pci_common_swizzle, pci_puv3_map_irq);
>  
> -	if (!use_firmware) {
> +	if (!pci_has_flag(PCI_PROBE_ONLY)) {
>  		/*
>  		 * Size the bridge windows.
>  		 */
> @@ -303,7 +303,7 @@ char * __devinit pcibios_setup(char *str)
>  		debug_pci = 1;
>  		return NULL;
>  	} else if (!strcmp(str, "firmware")) {
> -		use_firmware = 1;
> +		pci_add_flags(PCI_PROBE_ONLY);
>  		return NULL;
>  	}
>  	return str;


