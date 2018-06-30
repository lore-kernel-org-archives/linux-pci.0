Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.99]:34508 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751358AbeF3B4b (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Fri, 29 Jun 2018 21:56:31 -0400
Date: Fri, 29 Jun 2018 20:56:29 -0500
From: Bjorn Helgaas <helgaas@kernel.org>
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc: Bjorn Helgaas <bhelgaas@google.com>, linux-pci@vger.kernel.org
Subject: Re: [PATCH v1] PCI/ASPM: Convert to use match_string() helper
Message-ID: <20180630015629.GN40928@bhelgaas-glaptop.roam.corp.google.com>
References: <20180529133247.19728-1-andriy.shevchenko@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20180529133247.19728-1-andriy.shevchenko@linux.intel.com>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Tue, May 29, 2018 at 04:32:47PM +0300, Andy Shevchenko wrote:
> The new helper returns index of the matching string in an array.
> We are going to use it here.
> 
> Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>

Applied to pci/aspm for v4.19, thanks!

> ---
>  drivers/pci/pcie/aspm.c | 8 +++-----
>  1 file changed, 3 insertions(+), 5 deletions(-)
> 
> diff --git a/drivers/pci/pcie/aspm.c b/drivers/pci/pcie/aspm.c
> index c687c817b47d..0e88b3ad065f 100644
> --- a/drivers/pci/pcie/aspm.c
> +++ b/drivers/pci/pcie/aspm.c
> @@ -1127,11 +1127,9 @@ static int pcie_aspm_set_policy(const char *val,
>  
>  	if (aspm_disabled)
>  		return -EPERM;
> -	for (i = 0; i < ARRAY_SIZE(policy_str); i++)
> -		if (!strncmp(val, policy_str[i], strlen(policy_str[i])))
> -			break;
> -	if (i >= ARRAY_SIZE(policy_str))
> -		return -EINVAL;
> +	i = match_string(policy_str, ARRAY_SIZE(policy_str), val);
> +	if (i < 0)
> +		return i;
>  	if (i == aspm_policy)
>  		return 0;
>  
> -- 
> 2.17.0
> 
