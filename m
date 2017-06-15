Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.99]:35600 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751623AbdFOVji (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Thu, 15 Jun 2017 17:39:38 -0400
Date: Thu, 15 Jun 2017 16:39:35 -0500
From: Bjorn Helgaas <helgaas@kernel.org>
To: Jean Delvare <jdelvare@suse.de>
Cc: Narendra.K@dell.com, x86@kernel.org, linux-pci@vger.kernel.org,
        Jordan.Hargrave@dell.com, Shyam.Iyer@dell.com, bhelgaas@google.com
Subject: Re: dmi type 0xB1 record - unknown flag
Message-ID: <20170615213935.GH12735@bhelgaas-glaptop.roam.corp.google.com>
References: <20170601143826.5f980444@endymion>
 <68181b62786540ed8ca6ab877151a98b@BLRX13MDC105.AMER.DELL.COM>
 <20170602161311.27eab72d@endymion>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20170602161311.27eab72d@endymion>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Fri, Jun 02, 2017 at 04:13:11PM +0200, Jean Delvare wrote:
> ...
> I think the whole thing can be simplified like this:
> 
> From: Jean Delvare <jdelvare@suse.de>
> Subject: x86/PCI: Simplify Dell DMI B1 quirk
> 
> No need for such convoluted code, when all we need is to call one
> function in one specific case.
> 
> Signed-off-by: Jean Delvare <jdelvare@suse.de>

Applied to pci/misc for v4.13, thanks!

As far as I can tell, the new code is functionally equivalent to the
old code, so I don't think there's any risk here.

> ---
>  arch/x86/pci/common.c |   27 +++++----------------------
>  1 file changed, 5 insertions(+), 22 deletions(-)
> 
> --- linux-4.11.orig/arch/x86/pci/common.c	2017-05-01 04:47:48.000000000 +0200
> +++ linux-4.11/arch/x86/pci/common.c	2017-06-02 16:04:05.737889598 +0200
> @@ -24,7 +24,6 @@ unsigned int pci_probe = PCI_PROBE_BIOS
>  
>  unsigned int pci_early_dump_regs;
>  static int pci_bf_sort;
> -static int smbios_type_b1_flag;
>  int pci_routeirq;
>  int noioapicquirk;
>  #ifdef CONFIG_X86_REROUTE_FOR_BROKEN_BOOT_IRQS
> @@ -197,34 +196,18 @@ static int __init set_bf_sort(const stru
>  static void __init read_dmi_type_b1(const struct dmi_header *dm,
>  				    void *private_data)
>  {
> -	u8 *d = (u8 *)dm + 4;
> +	u8 *data = (u8 *)dm + 4;
>  
>  	if (dm->type != 0xB1)
>  		return;
> -	switch (((*(u32 *)d) >> 9) & 0x03) {
> -	case 0x00:
> -		printk(KERN_INFO "dmi type 0xB1 record - unknown flag\n");
> -		break;
> -	case 0x01: /* set pci=bfsort */
> -		smbios_type_b1_flag = 1;
> -		break;
> -	case 0x02: /* do not set pci=bfsort */
> -		smbios_type_b1_flag = 2;
> -		break;
> -	default:
> -		break;
> -	}
> +	if ((((*(u32 *)data) >> 9) & 0x03) == 0x01)
> +		set_bf_sort((const struct dmi_system_id *)private_data);
>  }
>  
>  static int __init find_sort_method(const struct dmi_system_id *d)
>  {
> -	dmi_walk(read_dmi_type_b1, NULL);
> -
> -	if (smbios_type_b1_flag == 1) {
> -		set_bf_sort(d);
> -		return 0;
> -	}
> -	return -1;
> +	dmi_walk(read_dmi_type_b1, (void *)d);
> +	return 0;
>  }
>  
>  /*
> 
> What do you think?
> 
> Thanks,
> -- 
> Jean Delvare
> SUSE L3 Support
