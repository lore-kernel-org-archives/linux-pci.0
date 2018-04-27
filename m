Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.99]:40602 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1759307AbeD0V5W (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Fri, 27 Apr 2018 17:57:22 -0400
Date: Fri, 27 Apr 2018 16:57:20 -0500
From: Bjorn Helgaas <helgaas@kernel.org>
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc: Bjorn Helgaas <bhelgaas@google.com>, linux-pci@vger.kernel.org,
        Thomas Gleixner <tglx@linutronix.de>,
        "H . Peter Anvin" <hpa@zytor.com>, Ingo Molnar <mingo@redhat.com>,
        x86@kernel.org, Mika Westerberg <mika.westerberg@linux.intel.com>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] x86/PCI: Make pci=earlydump output neat
Message-ID: <20180427215720.GJ8199@bhelgaas-glaptop.roam.corp.google.com>
References: <20180425101507.51531-1-andriy.shevchenko@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20180425101507.51531-1-andriy.shevchenko@linux.intel.com>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Wed, Apr 25, 2018 at 01:15:07PM +0300, Andy Shevchenko wrote:
> Currently the early dump of PCI configuration space looks quite unhelpful, e.g.
> 
> [    0.000000]   60:
> [    0.000000]  00
> [    0.000000]  00
> [    0.000000]  00
> [    0.000000]  00
> [    0.000000]  00
> [    0.000000]  00
> [    0.000000]  00
> [    0.000000]  00
> [    0.000000]  00
> [    0.000000]  00
> [    0.000000]  00
> [    0.000000]  00
> [    0.000000]  00
> [    0.000000]  00
> [    0.000000]  00
> [    0.000000]  00
> [    0.000000]
> 
> which makes really hard to get anything out of this. Convert the function to
> use print_hex_dump() to make output neat.
> 
> In the result we will have
> 
> [    0.000000] 00000060: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
> 
> which is much, much better.
> 
> Reviewed-by: Mika Westerberg <mika.westerberg@linux.intel.com>
> Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>

Applied with Ingo's ack to pci/enumeration for v4.18, thanks!

> ---
> - add Mika's tag
> - address style issue
>  arch/x86/pci/early.c | 19 +++++--------------
>  1 file changed, 5 insertions(+), 14 deletions(-)
> 
> diff --git a/arch/x86/pci/early.c b/arch/x86/pci/early.c
> index f0114007e915..e5f753cbb1c3 100644
> --- a/arch/x86/pci/early.c
> +++ b/arch/x86/pci/early.c
> @@ -59,24 +59,15 @@ int early_pci_allowed(void)
>  
>  void early_dump_pci_device(u8 bus, u8 slot, u8 func)
>  {
> +	u32 value[256 / 4];
>  	int i;
> -	int j;
> -	u32 val;
>  
> -	printk(KERN_INFO "pci 0000:%02x:%02x.%d config space:",
> -	       bus, slot, func);
> +	pr_info("pci 0000:%02x:%02x.%d config space:\n", bus, slot, func);
>  
> -	for (i = 0; i < 256; i += 4) {
> -		if (!(i & 0x0f))
> -			printk("\n  %02x:",i);
> +	for (i = 0; i < 256; i += 4)
> +		value[i / 4] = read_pci_config(bus, slot, func, i);
>  
> -		val = read_pci_config(bus, slot, func, i);
> -		for (j = 0; j < 4; j++) {
> -			printk(" %02x", val & 0xff);
> -			val >>= 8;
> -		}
> -	}
> -	printk("\n");
> +	print_hex_dump(KERN_INFO, "", DUMP_PREFIX_OFFSET, 16, 1, value, 256, false);
>  }
>  
>  void early_dump_pci_devices(void)
> -- 
> 2.17.0
> 
