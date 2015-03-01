Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-ig0-f175.google.com ([209.85.213.175]:34113 "EHLO
	mail-ig0-f175.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752425AbbCACkk (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Sat, 28 Feb 2015 21:40:40 -0500
MIME-Version: 1.0
In-Reply-To: <1425176259-30087-2-git-send-email-yinghai@kernel.org>
References: <1425176259-30087-1-git-send-email-yinghai@kernel.org>
	<1425176259-30087-2-git-send-email-yinghai@kernel.org>
Date: Sat, 28 Feb 2015 18:40:39 -0800
Message-ID: <CAE9FiQXE5YnSQAkkAxob38Qe+aHZ=niAXL6uLF5650KQPfjPPw@mail.gmail.com>
Subject: Re: [PATCH 1/8] x86, kaslr: get kaslr_enabled back correctly
From: Yinghai Lu <yinghai@kernel.org>
To: Matt Fleming <matt.fleming@intel.com>,
	Thomas Gleixner <tglx@linutronix.de>,
	"H. Peter Anvin" <hpa@zytor.com>, Ingo Molnar <mingo@redhat.com>,
	Jiri Kosina <jkosina@suse.cz>, Borislav Petkov <bp@suse.de>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Linus Torvalds <torvalds@linux-foundation.org>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
	"linux-efi@vger.kernel.org" <linux-efi@vger.kernel.org>,
	"linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
	Yinghai Lu <yinghai@kernel.org>
Content-Type: text/plain; charset=UTF-8
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Sat, Feb 28, 2015 at 6:17 PM, Yinghai Lu <yinghai@kernel.org> wrote:
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
> -       kaslr_enabled = (bool)(pa_data + sizeof(struct setup_data));
> +       /* kaslr_setup_data is defined in aslr.c */
> +       unsigned char *data;
> +       unsigned long offset = sizeof(struct setup_data);
> +
> +       data = early_memremap(pa_data, offset + 1);
> +       kaslr_enabled = *(data + offset);
> +       early_memunmap(data, offset + 1);
>  }
>
>  static void __init parse_setup_data(void)
> --

oh, no. the offending commit already got into linus tree.

commit f47233c2d34f243ecdaac179c3408a39ff9216a7
Author: Jiri Kosina <jkosina@suse.cz>
Date:   Fri Feb 13 16:04:55 2015 +0100

    x86/mm/ASLR: Propagate base load address calculation
