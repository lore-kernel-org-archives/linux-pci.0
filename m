Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-wg0-f50.google.com ([74.125.82.50]:36170 "EHLO
	mail-wg0-f50.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754049AbbCBNOC (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Mon, 2 Mar 2015 08:14:02 -0500
Received: by wghk14 with SMTP id k14so33360797wgh.3
        for <linux-pci@vger.kernel.org>; Mon, 02 Mar 2015 05:14:01 -0800 (PST)
Date: Mon, 2 Mar 2015 13:13:58 +0000
From: Matt Fleming <matt@codeblueprint.co.uk>
To: Yinghai Lu <yinghai@kernel.org>
Cc: Matt Fleming <matt.fleming@intel.com>,
	Thomas Gleixner <tglx@linutronix.de>,
	"H. Peter Anvin" <hpa@zytor.com>, Ingo Molnar <mingo@redhat.com>,
	Jiri Kosina <jkosina@suse.cz>, Borislav Petkov <bp@suse.de>,
	Bjorn Helgaas <bhelgaas@google.com>,
	linux-kernel@vger.kernel.org, linux-efi@vger.kernel.org,
	linux-pci@vger.kernel.org
Subject: Re: [PATCH 1/8] x86, kaslr: get kaslr_enabled back correctly
Message-ID: <20150302131358.GD24476@codeblueprint.co.uk>
References: <1425176259-30087-1-git-send-email-yinghai@kernel.org>
 <1425176259-30087-2-git-send-email-yinghai@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1425176259-30087-2-git-send-email-yinghai@kernel.org>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Sat, 28 Feb, at 06:17:32PM, Yinghai Lu wrote:
> We should access variable with referrence instead of using physical
> address as value.
> 
> Cc: Matt Fleming <matt.fleming@intel.com>
> Cc: Borislav Petkov <bp@suse.de>
> Signed-off-by: Yinghai Lu <yinghai@kernel.org>
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

ACK in principle, but could we change 'offset' to 'size' or 'len' along
with the commit log updates people have suggested?

-- 
Matt Fleming, Intel Open Source Technology Center
