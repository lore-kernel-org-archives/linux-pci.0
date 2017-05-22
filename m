Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.99]:41648 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1757907AbdEVUEM (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Mon, 22 May 2017 16:04:12 -0400
Date: Mon, 22 May 2017 15:04:08 -0500
From: Bjorn Helgaas <helgaas@kernel.org>
To: Vincent Legoll <vincent.legoll@gmail.com>
Cc: hpa@zytor.com, mingo@redhat.com, tglx@linutronix.de,
        bhelgaas@google.com, x86@kernel.org, linux-pci@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] PCI: fix whitespace in printk() to align log entries
Message-ID: <20170522200408.GA19733@bhelgaas-glaptop.roam.corp.google.com>
References: <1495357481-15750-1-git-send-email-vincent.legoll@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1495357481-15750-1-git-send-email-vincent.legoll@gmail.com>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Sun, May 21, 2017 at 11:04:41AM +0200, Vincent Legoll wrote:
> Remove the space character between "PCI" and the colon.
> 
> This was printed before the patch:
> 
> PCI : PCI BIOS area is rw and x. Use pci=nobios if you want it NX.
> 
> Whereas other PCI printks are like that:
> 
> $ dmesg | grep 'PCI:'
> [    0.649178] PCI: MMCONFIG for domain 0000 [bus 00-7f] at [mem 0xf0000000-0xf7ffffff] (base 0xf0000000)
> [    0.649180] PCI: MMCONFIG at [mem 0xf0000000-0xf7ffffff] reserved in E820
> [    0.649186] PCI: Using configuration type 1 for base access
> [    0.676407] PCI: Using host bridge windows from ACPI; if necessary, use "pci=nocrs" and report a bug
> [    0.784009] PCI: Using ACPI for IRQ routing
> [    0.795599] PCI: pci_cache_line_size set to 64 bytes
> [    0.811154] PCI: CLS 0 bytes, default 64
> 
> Signed-off-by: Vincent Legoll <vincent.legoll@gmail.com>

Applied to pci/misc for v4.13, thanks!

> ---
>  arch/x86/pci/pcbios.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/arch/x86/pci/pcbios.c b/arch/x86/pci/pcbios.c
> index c1bdb9e..7659540 100644
> --- a/arch/x86/pci/pcbios.c
> +++ b/arch/x86/pci/pcbios.c
> @@ -46,7 +46,7 @@ static inline void set_bios_x(void)
>  	pcibios_enabled = 1;
>  	set_memory_x(PAGE_OFFSET + BIOS_BEGIN, (BIOS_END - BIOS_BEGIN) >> PAGE_SHIFT);
>  	if (__supported_pte_mask & _PAGE_NX)
> -		printk(KERN_INFO "PCI : PCI BIOS area is rw and x. Use pci=nobios if you want it NX.\n");
> +		printk(KERN_INFO "PCI: PCI BIOS area is rw and x. Use pci=nobios if you want it NX.\n");
>  }
>  
>  /*
> -- 
> 2.7.4
> 
