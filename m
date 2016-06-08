Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from cloudserver094114.home.net.pl ([79.96.170.134]:47736 "HELO
	cloudserver094114.home.net.pl" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with SMTP id S1753659AbcFHANm (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Tue, 7 Jun 2016 20:13:42 -0400
From: "Rafael J. Wysocki" <rjw@rjwysocki.net>
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc: linux-pci@vger.kernel.org, Bjorn Helgaas <bhelgaas@google.com>,
	linux-pm@vger.kernel.org
Subject: Re: [PATCH v1 1/1] PCI / PM: check all fields in pci_set_platform_pm()
Date: Wed, 08 Jun 2016 02:17:42 +0200
Message-ID: <2053744.vokaYxPbf2@vostro.rjw.lan>
In-Reply-To: <1465223133-73532-1-git-send-email-andriy.shevchenko@linux.intel.com>
References: <1465223133-73532-1-git-send-email-andriy.shevchenko@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Monday, June 06, 2016 05:25:33 PM Andy Shevchenko wrote:
> When assign new PCI platform PM operations check for all mandatory fields to
> prevent NULL pointer dereference.
> 
> Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>

OK in principle, but what's the motivation?

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
>  	pci_platform_pm = ops;
>  	return 0;
> 

