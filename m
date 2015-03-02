Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from cantor2.suse.de ([195.135.220.15]:43691 "EHLO mx2.suse.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750802AbbCBJjg (ORCPT <rfc822;linux-pci@vger.kernel.org>);
	Mon, 2 Mar 2015 04:39:36 -0500
Date: Mon, 2 Mar 2015 10:39:33 +0100 (CET)
From: Jiri Kosina <jkosina@suse.cz>
To: Yinghai Lu <yinghai@kernel.org>
cc: Matt Fleming <matt.fleming@intel.com>,
	Thomas Gleixner <tglx@linutronix.de>,
	"H. Peter Anvin" <hpa@zytor.com>, Ingo Molnar <mingo@redhat.com>,
	Borislav Petkov <bp@suse.de>,
	Bjorn Helgaas <bhelgaas@google.com>,
	linux-kernel@vger.kernel.org, linux-efi@vger.kernel.org,
	linux-pci@vger.kernel.org
Subject: Re: [PATCH 1/8] x86, kaslr: get kaslr_enabled back correctly
In-Reply-To: <1425176259-30087-2-git-send-email-yinghai@kernel.org>
Message-ID: <alpine.LNX.2.00.1503021038401.9089@pobox.suse.cz>
References: <1425176259-30087-1-git-send-email-yinghai@kernel.org> <1425176259-30087-2-git-send-email-yinghai@kernel.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Sat, 28 Feb 2015, Yinghai Lu wrote:

> We should access variable with referrence instead of using physical
> address as value.
> 
> Cc: Matt Fleming <matt.fleming@intel.com>
> Cc: Borislav Petkov <bp@suse.de>
> Signed-off-by: Yinghai Lu <yinghai@kernel.org>

	Acked-by: Jiri Kosina <jkosina@suse.cz>


Thanks for fixing my brainfart. This is not fixing the problem with the 
later variable overwrite, but definitely needs to go in as well.

Thanks.

> ---
>  arch/x86/kernel/setup.c | 8 +++++++-
>  1 file changed, 7 insertions(+), 1 deletion(-)
> 
> diff --git a/arch/x86/kernel/setup.c b/arch/x86/kernel/setup.c
> index 98dc931..05d444f 100644
> --- a/arch/x86/kernel/setup.c
> +++ b/arch/x86/kernel/setup.c
> @@ -429,7 +429,13 @@ static void __init reserve_initrd(void)
>  
>  static void __init parse_kaslr_setup(u64 pa_data, u32 data_len)
>  {
> -	kaslr_enabled = (bool)(pa_data + sizeof(struct setup_data));
> +	/* kaslr_setup_data is defined in aslr.c */
> +	unsigned char *data;
> +	unsigned long offset = sizeof(struct setup_data);
> +
> +	data = early_memremap(pa_data, offset + 1);
> +	kaslr_enabled = *(data + offset);
> +	early_memunmap(data, offset + 1);
>  }
>  
>  static void __init parse_setup_data(void)

-- 
Jiri Kosina
SUSE Labs
