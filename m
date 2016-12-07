Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.136]:50912 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S932583AbcLGWxT (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Wed, 7 Dec 2016 17:53:19 -0500
Date: Wed, 7 Dec 2016 16:53:15 -0600
From: Bjorn Helgaas <helgaas@kernel.org>
To: Lukas Wunner <lukas@wunner.de>
Cc: x86@kernel.org,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Bjorn Helgaas <bhelgaas@google.com>, linux-pci@vger.kernel.org
Subject: Re: [PATCH] x86/platform/intel-mid: Constify mid_pci_platform_pm
Message-ID: <20161207225315.GI22129@bhelgaas-glaptop.roam.corp.google.com>
References: <ba07572b4c4fad1f60593454693a58137f518896.1480859081.git.lukas@wunner.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <ba07572b4c4fad1f60593454693a58137f518896.1480859081.git.lukas@wunner.de>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Sun, Dec 04, 2016 at 03:35:55PM +0100, Lukas Wunner wrote:
> This struct never needs to be modified.  The size of pci-mid.o ELF
> sections changes thusly:
> 
> -.data          56
> +.data           0
> -.rodata        32
> +.rodata        88
> 
> Acked-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
> Acked-by: Bjorn Helgaas <bhelgaas@google.com>
> Signed-off-by: Lukas Wunner <lukas@wunner.de>

Ingo, do you want this, since you've taken the previous updates?

It's trivial but doesn't apply cleanly to my tree, which makes me think
it might be based on other changes I don't have.

> ---
> 
> Link to Andy's ack:
> https://www.spinics.net/lists/linux-pci/msg54977.html
> 
> Link to Bjorn's ack:
> https://www.spinics.net/lists/linux-pci/msg56476.html
> 
>  drivers/pci/pci-mid.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/pci/pci-mid.c b/drivers/pci/pci-mid.c
> index c7f3408..1c4af72 100644
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
> 2.10.2
> 
> --
> To unsubscribe from this list: send the line "unsubscribe linux-pci" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
