Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.136]:50454 "EHLO mail.kernel.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752292AbcFKAUB (ORCPT <rfc822;linux-pci@vger.kernel.org>);
	Fri, 10 Jun 2016 20:20:01 -0400
Date: Fri, 10 Jun 2016 19:19:56 -0500
From: Bjorn Helgaas <helgaas@kernel.org>
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc: linux-pci@vger.kernel.org, Bjorn Helgaas <bhelgaas@google.com>,
	"Rafael J . Wysocki" <rjw@rjwysocki.net>, linux-pm@vger.kernel.org
Subject: Re: [PATCH v1 1/1] PCI / PM: enforce type casting for pci_power_t
Message-ID: <20160611001956.GH16462@localhost>
References: <1465321713-146178-1-git-send-email-andriy.shevchenko@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1465321713-146178-1-git-send-email-andriy.shevchenko@linux.intel.com>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Tue, Jun 07, 2016 at 08:48:33PM +0300, Andy Shevchenko wrote:
> When cast pci_power_t type of variables a static analizer tool complains on
> that.
> 
> 	include/linux/pci.h:119:37: warning: cast from restricted pci_power_t
> 
> Enforce type casting to make static analizer happy.
> 
> Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>

Applied to pci/pm for v4.8, thanks, Andy.

> ---
>  include/linux/pci.h | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/include/linux/pci.h b/include/linux/pci.h
> index b67e4df..8d74834 100644
> --- a/include/linux/pci.h
> +++ b/include/linux/pci.h
> @@ -116,7 +116,7 @@ extern const char *pci_power_names[];
>  
>  static inline const char *pci_power_name(pci_power_t state)
>  {
> -	return pci_power_names[1 + (int) state];
> +	return pci_power_names[1 + (__force int) state];
>  }
>  
>  #define PCI_PM_D2_DELAY		200
> -- 
> 2.8.1
> 
> --
> To unsubscribe from this list: send the line "unsubscribe linux-pci" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
