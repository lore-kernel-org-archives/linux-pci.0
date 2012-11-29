Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mprc.pku.edu.cn ([162.105.203.9]:37387 "EHLO mprc.pku.edu.cn"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753190Ab2K2Bhw (ORCPT <rfc822;linux-pci@vger.kernel.org>);
	Wed, 28 Nov 2012 20:37:52 -0500
From: guanxuetao@mprc.pku.edu.cn
Message-ID: <62357.162.105.80.111.1354154524.squirrel@mprc.pku.edu.cn>
In-Reply-To: <1353530100-728-6-git-send-email-wfp5p@virginia.edu>
References: <1353530100-728-1-git-send-email-wfp5p@virginia.edu>
    <1353530100-728-6-git-send-email-wfp5p@virginia.edu>
Date: Thu, 29 Nov 2012 10:02:04 +0800 (CST)
Subject: Re: [PATCH 5/9] unicore32/PCI: Remove CONFIG_HOTPLUG ifdefs
To: "Bill Pemberton" <wfp5p@virginia.edu>
Cc: gregkh@linuxfoundation.org, linux-pci@vger.kernel.org,
	"Guan Xuetao" <gxt@mprc.pku.edu.cn>,
	"Bjorn Helgaas" <bhelgaas@google.com>
MIME-Version: 1.0
Content-Type: text/plain;charset=GB2312
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

> Remove conditional code based on CONFIG_HOTPLUG being false.  It's
> always on now in preparation of it going away as an option.
>
> Signed-off-by: Bill Pemberton <wfp5p@virginia.edu>
> Cc: Guan Xuetao <gxt@mprc.pku.edu.cn>
> Cc: Bjorn Helgaas <bhelgaas@google.com>

Acked-by: Guan Xuetao <gxt@mprc.pku.edu.cn>

> ---
>  arch/unicore32/kernel/pci.c | 2 --
>  1 file changed, 2 deletions(-)
>
> diff --git a/arch/unicore32/kernel/pci.c b/arch/unicore32/kernel/pci.c
> index b0056f6..7c43592 100644
> --- a/arch/unicore32/kernel/pci.c
> +++ b/arch/unicore32/kernel/pci.c
> @@ -250,9 +250,7 @@ void __devinit pcibios_fixup_bus(struct pci_bus *bus)
>  	printk(KERN_INFO "PCI: bus%d: Fast back to back transfers %sabled\n",
>  		bus->number, (features & PCI_COMMAND_FAST_BACK) ? "en" : "dis");
>  }
> -#ifdef CONFIG_HOTPLUG
>  EXPORT_SYMBOL(pcibios_fixup_bus);
> -#endif
>
>  static int __init pci_common_init(void)
>  {
> --
> 1.8.0
>

