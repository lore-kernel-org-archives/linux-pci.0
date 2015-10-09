Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.136]:48173 "EHLO mail.kernel.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751231AbbJIXjs (ORCPT <rfc822;linux-pci@vger.kernel.org>);
	Fri, 9 Oct 2015 19:39:48 -0400
Date: Fri, 9 Oct 2015 18:39:45 -0500
From: Bjorn Helgaas <helgaas@kernel.org>
To: Alexander Kuleshov <kuleshovmail@gmail.com>
Cc: Bjorn Helgaas <bhelgaas@google.com>,
	Thomas Gleixner <tglx@linutronix.de>,
	Ingo Molnar <mingo@redhat.com>,
	"H . Peter Anvin" <hpa@zytor.com>, x86@kernel.org,
	linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] x86/pci/legacy: make pci_subsys_init static
Message-ID: <20151009233944.GA623@localhost>
References: <1444330306-14076-1-git-send-email-kuleshovmail@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1444330306-14076-1-git-send-email-kuleshovmail@gmail.com>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Fri, Oct 09, 2015 at 12:51:46AM +0600, Alexander Kuleshov wrote:
> The pci_subsys_init() is a subsys_initcall that can be declared
> static.
> 
> Signed-off-by: Alexander Kuleshov <kuleshovmail@gmail.com>

Applied to pci/misc for v4.4, thanks, Alexander!

I tweaked the subject to match the file's history.

> ---
>  arch/x86/pci/legacy.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/arch/x86/pci/legacy.c b/arch/x86/pci/legacy.c
> index 5b662c0..ea6f380 100644
> --- a/arch/x86/pci/legacy.c
> +++ b/arch/x86/pci/legacy.c
> @@ -54,7 +54,7 @@ void pcibios_scan_specific_bus(int busn)
>  }
>  EXPORT_SYMBOL_GPL(pcibios_scan_specific_bus);
>  
> -int __init pci_subsys_init(void)
> +static int __init pci_subsys_init(void)
>  {
>  	/*
>  	 * The init function returns an non zero value when
> -- 
> 2.6.0
> 
> --
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
