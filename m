Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.99]:37214 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727585AbeHFVov (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Mon, 6 Aug 2018 17:44:51 -0400
Date: Mon, 6 Aug 2018 14:34:10 -0500
From: Bjorn Helgaas <helgaas@kernel.org>
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc: Heiner Kallweit <hkallweit1@gmail.com>, linux-pci@vger.kernel.org,
        Bjorn Helgaas <bhelgaas@google.com>
Subject: Re: [PATCH v1] PCI/ASPM: Convert to use sysfs_match_string() helper
Message-ID: <20180806193410.GB30691@bhelgaas-glaptop.roam.corp.google.com>
References: <20180803095137.52401-1-andriy.shevchenko@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20180803095137.52401-1-andriy.shevchenko@linux.intel.com>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Fri, Aug 03, 2018 at 12:51:37PM +0300, Andy Shevchenko wrote:
> The commit
> 
>   4cec16861a40 ("PCI/ASPM: Convert to use match_string() helper")
> 
> didn't take into consideration small but crucial detail about scope of
> usage, i.e. sysfs interface provided to handle the ASPM policy. Due to
> this in most of the cases input string comes with a new line symbol.
> 
> Use sysfs_match_string() helper to take into account above.
> 
> Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
> Reported-by: Heiner Kallweit <hkallweit1@gmail.com>
> Fixes: 4cec16861a40 ("PCI/ASPM: Convert to use match_string() helper")

Folded into original patch on pci/aspm for v4.19, thanks!

> ---
>  drivers/pci/pcie/aspm.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/pci/pcie/aspm.c b/drivers/pci/pcie/aspm.c
> index 0e88b3ad065f..5326916715d2 100644
> --- a/drivers/pci/pcie/aspm.c
> +++ b/drivers/pci/pcie/aspm.c
> @@ -1127,7 +1127,7 @@ static int pcie_aspm_set_policy(const char *val,
>  
>  	if (aspm_disabled)
>  		return -EPERM;
> -	i = match_string(policy_str, ARRAY_SIZE(policy_str), val);
> +	i = sysfs_match_string(policy_str, val);
>  	if (i < 0)
>  		return i;
>  	if (i == aspm_policy)
> -- 
> 2.18.0
> 
