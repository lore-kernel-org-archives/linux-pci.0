Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.136]:54526 "EHLO mail.kernel.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751720AbcGSVh4 (ORCPT <rfc822;linux-pci@vger.kernel.org>);
	Tue, 19 Jul 2016 17:37:56 -0400
Date: Tue, 19 Jul 2016 16:37:51 -0500
From: Bjorn Helgaas <helgaas@kernel.org>
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc: linux-pci@vger.kernel.org, Bjorn Helgaas <bhelgaas@google.com>,
	"Rafael J. Wysocki" <rjw@rjwysocki.net>, linux-pm@vger.kernel.org
Subject: Re: [PATCH v1 1/1] PCI / PM: check all fields in
 pci_set_platform_pm()
Message-ID: <20160719213751.GA18635@localhost>
References: <1465223133-73532-1-git-send-email-andriy.shevchenko@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1465223133-73532-1-git-send-email-andriy.shevchenko@linux.intel.com>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Mon, Jun 06, 2016 at 05:25:33PM +0300, Andy Shevchenko wrote:
> When assign new PCI platform PM operations check for all mandatory fields to
> prevent NULL pointer dereference.
> 
> Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
> ---
>  drivers/pci/pci.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/pci/pci.c b/drivers/pci/pci.c
> index c8b4dbd..badbddc 100644
> --- a/drivers/pci/pci.c
> +++ b/drivers/pci/pci.c
> @@ -530,8 +530,8 @@ static const struct pci_platform_pm_ops *pci_platform_pm;
>  
>  int pci_set_platform_pm(const struct pci_platform_pm_ops *ops)
>  {
> -	if (!ops->is_manageable || !ops->set_state || !ops->choose_state
> -	    || !ops->sleep_wake)
> +	if (!ops->is_manageable || !ops->set_state || !ops->choose_state ||
> +	    !ops->sleep_wake || !ops->run_wake || !ops->need_resume)
>  		return -EINVAL;

This looks OK to me.  platform_pci_run_wake() and
platform_pci_need_resume() assume that if pci_platform_pm is set,
pci_platform_pm->run_wake and pci_platform_pm->need_resume are valid
function pointers.  This is analogous to what we already do for
ops->is_manageable, etc.

Rafael, do you want to take this or should I?

>  	pci_platform_pm = ops;
>  	return 0;
> -- 
> 2.8.1
> 
> --
> To unsubscribe from this list: send the line "unsubscribe linux-pci" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
