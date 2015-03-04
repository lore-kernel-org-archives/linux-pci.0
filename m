Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail.skyhub.de ([78.46.96.112]:36668 "EHLO mail.skyhub.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754527AbbCDKSG (ORCPT <rfc822;linux-pci@vger.kernel.org>);
	Wed, 4 Mar 2015 05:18:06 -0500
Date: Wed, 4 Mar 2015 11:16:49 +0100
From: Borislav Petkov <bp@alien8.de>
To: Yinghai Lu <yinghai@kernel.org>
Cc: Matt Fleming <matt.fleming@intel.com>,
	"H. Peter Anvin" <hpa@zytor.com>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Thomas Gleixner <tglx@linutronix.de>,
	Ingo Molnar <mingo@redhat.com>, Jiri Kosina <jkosina@suse.cz>,
	Borislav Petkov <bp@suse.de>, Baoquan He <bhe@redhat.com>,
	linux-kernel@vger.kernel.org, linux-efi@vger.kernel.org,
	linux-pci@vger.kernel.org, Kees Cook <keescook@chromium.org>
Subject: Re: [PATCH v2 04/15] x86, kaslr: get kaslr_enabled back correctly
Message-ID: <20150304101649.GA3663@pd.tnic>
References: <1425456048-16236-1-git-send-email-yinghai@kernel.org>
 <1425456048-16236-5-git-send-email-yinghai@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
In-Reply-To: <1425456048-16236-5-git-send-email-yinghai@kernel.org>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Wed, Mar 04, 2015 at 12:00:37AM -0800, Yinghai Lu wrote:
> commit f47233c2d34f ("x86/mm/ASLR: Propagate base load address calculation")
> is using address as value for kaslr_enabled.
> 
> That will random kaslr_enabled get that set or cleared.
> Will have problem for system really have kaslr enabled.
> 
> -v2: update changelog.

This is still not good enough. Please do this:

In commit f47233c2d34f we did A. The problem with that is B. Change the
code to do C.

Now you only have to fill out the A,B and C variables with the
respective text which is understandable even for people who don't know
this code.

> 
> Fixes: f47233c2d34f ("x86/mm/ASLR: Propagate base load address calculation")
> Cc: Matt Fleming <matt.fleming@intel.com>
> Cc: Borislav Petkov <bp@suse.de>
> Cc: Kees Cook <keescook@chromium.org>
> Cc: Jiri Kosina <jkosina@suse.cz>
> Acked-by: Jiri Kosina <jkosina@suse.cz>
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

early_memremap() needs its retval checked before accessing it.

> +	kaslr_enabled = *(data + offset);
> +	early_memunmap(data, offset + 1);
>  }
>  
>  static void __init parse_setup_data(void)
> -- 
> 1.8.4.5
> 

-- 
Regards/Gruss,
    Boris.

ECO tip #101: Trim your mails when you reply.
--
