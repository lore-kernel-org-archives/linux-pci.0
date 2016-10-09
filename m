Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mga01.intel.com ([192.55.52.88]:58865 "EHLO mga01.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751130AbcJIOFR (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Sun, 9 Oct 2016 10:05:17 -0400
Message-ID: <1476021678.11323.352.camel@linux.intel.com>
Subject: Re: [PATCH] x86/platform/intel-mid: Constify mid_pci_platform_pm
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: Lukas Wunner <lukas@wunner.de>, linux-pci@vger.kernel.org
Date: Sun, 09 Oct 2016 17:01:18 +0300
In-Reply-To: <c2b767a782f9a0e1780e5c201d245d1be5b7d78a.1476011255.git.lukas@wunner.de>
References: <c2b767a782f9a0e1780e5c201d245d1be5b7d78a.1476011255.git.lukas@wunner.de>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Sun, 2016-10-09 at 13:12 +0200, Lukas Wunner wrote:
> -.data          56
> +.data           0
> -.rodata        32
> +.rodata        88
> 
> Cc: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
> Signed-off-by: Lukas Wunner <lukas@wunner.de>

Acked-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>

> ---
>  drivers/pci/pci-mid.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/pci/pci-mid.c b/drivers/pci/pci-mid.c
> index a8b52dc..566ded1 100644
> --- a/drivers/pci/pci-mid.c
> +++ b/drivers/pci/pci-mid.c
> @@ -54,7 +54,7 @@ static bool mid_pci_need_resume(struct pci_dev *dev)
>  	return false;
>  }
>  
> -static struct pci_platform_pm_ops mid_pci_platform_pm = {
> +static const struct pci_platform_pm_ops mid_pci_platform_pm = {
>  	.is_manageable	= mid_pci_power_manageable,
>  	.set_state	= mid_pci_set_power_state,
>  	.get_state	= mid_pci_get_power_state,

-- 
Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Intel Finland Oy
