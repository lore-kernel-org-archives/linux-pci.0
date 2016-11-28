Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.136]:38966 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752406AbcK1TZh (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Mon, 28 Nov 2016 14:25:37 -0500
Date: Mon, 28 Nov 2016 13:25:30 -0600
From: Bjorn Helgaas <helgaas@kernel.org>
To: Lukas Wunner <lukas@wunner.de>
Cc: linux-pci@vger.kernel.org,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Subject: Re: [PATCH] x86/platform/intel-mid: Constify mid_pci_platform_pm
Message-ID: <20161128192530.GO16033@bhelgaas-glaptop.roam.corp.google.com>
References: <c2b767a782f9a0e1780e5c201d245d1be5b7d78a.1476011255.git.lukas@wunner.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <c2b767a782f9a0e1780e5c201d245d1be5b7d78a.1476011255.git.lukas@wunner.de>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Sun, Oct 09, 2016 at 01:12:55PM +0200, Lukas Wunner wrote:
> -.data          56
> +.data           0
> -.rodata        32
> +.rodata        88
> 
> Cc: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
> Signed-off-by: Lukas Wunner <lukas@wunner.de>

Acked-by: Bjorn Helgaas <bhelgaas@google.com>

It'd be nice if this had a changelog.  I'm happy if this goes via the
x86 tree.

I can't remember a discussion about having this code in drivers/pci in
the first place.  Would it make sense to move it to
arch/x86/platform/intel-mid/?

8e522e1d321b ("x86/platform/intel-mid: Add Intel Penwell to ID table")
fixed a sync issue and added a comment about staying in sync with
arch/x86/platform/intel-mid/pwr.c.  Maybe moving this code to arch/x86
would help with that?

Looks like we'd have to expose pci_platform_pm_ops and
pci_set_platform_pm(), but setting platform-specific PM ops does seem
like something that would fit in the arch directories, so maybe that
wouldn't be a bad thing.

> ---
>  drivers/pci/pci-mid.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/pci/pci-mid.c b/drivers/pci/pci-mid.c
> index a8b52dc..566ded1 100644
> --- a/drivers/pci/pci-mid.c
> +++ b/drivers/pci/pci-mid.c
> @@ -54,7 +54,7 @@ static bool mid_pci_need_resume(struct pci_dev *dev)
>  	return false;
>  }
>  
> -static struct pci_platform_pm_ops mid_pci_platform_pm = {
> +static const struct pci_platform_pm_ops mid_pci_platform_pm = {
>  	.is_manageable	= mid_pci_power_manageable,
>  	.set_state	= mid_pci_set_power_state,
>  	.get_state	= mid_pci_get_power_state,
> -- 
> 2.9.3
> 
> --
> To unsubscribe from this list: send the line "unsubscribe linux-pci" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
