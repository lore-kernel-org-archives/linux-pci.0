Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-ob0-f170.google.com ([209.85.214.170]:34559 "EHLO
	mail-ob0-f170.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752483AbbIOQqr (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Tue, 15 Sep 2015 12:46:47 -0400
Received: by obbda8 with SMTP id da8so139850460obb.1
        for <linux-pci@vger.kernel.org>; Tue, 15 Sep 2015 09:46:47 -0700 (PDT)
Date: Tue, 15 Sep 2015 11:46:42 -0500
From: Bjorn Helgaas <bhelgaas@google.com>
To: Paul Gortmaker <paul.gortmaker@windriver.com>
Cc: linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org
Subject: Re: [PATCH] PCI: create builtin_pci_driver to avoid registration
 boilerplate
Message-ID: <20150915164642.GC25767@google.com>
References: <1440548737-7465-1-git-send-email-paul.gortmaker@windriver.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1440548737-7465-1-git-send-email-paul.gortmaker@windriver.com>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Hi Paul,

On Tue, Aug 25, 2015 at 08:25:37PM -0400, Paul Gortmaker wrote:
> In commit f309d4443130bf814e991f836e919dca22df37ae ("platform_device:
> better support builtin boilerplate avoidance") we introduced the
> builtin_driver macro.
> 
> Here we use that support and extend it to PCI driver registration,
> so where a driver is clearly non-modular and builtin-only, we can
> register it in a similar fashion.  And existing code that is clearly
> non-modular can be updated with the simple mapping of
> 
>      module_pci_driver(...)  ---> builtin_pci_driver(...)
> 
> We've essentially cloned the former to make the latter, and taken
> out the remove/module_exit parts since those never get used in a
> non-modular build of the code.

Do you have any estimate of how many potential users of this there
are?  I took a quick look at users of module_pci_driver() (I see
almost 300 of them in v4.3-rc1), and most of them look like legitimate
modules.  But the comment mentions replacing device_initcall() as
well, so maybe there are more there?

If only a couple would be converted to builtin_pci_driver(), I'm not
sure it's worth it, because it does add more things to look at
(builtin_pci_driver() in addition to module_pci_driver()).

> Cc: Bjorn Helgaas <bhelgaas@google.com>
> Cc: linux-pci@vger.kernel.org
> Signed-off-by: Paul Gortmaker <paul.gortmaker@windriver.com>
> ---
>  include/linux/pci.h | 11 +++++++++++
>  1 file changed, 11 insertions(+)
> 
> diff --git a/include/linux/pci.h b/include/linux/pci.h
> index 88bee285b93d..8da2758e7d0e 100644
> --- a/include/linux/pci.h
> +++ b/include/linux/pci.h
> @@ -1187,6 +1187,17 @@ void pci_unregister_driver(struct pci_driver *dev);
>  	module_driver(__pci_driver, pci_register_driver, \
>  		       pci_unregister_driver)
>  
> +/**
> + * builtin_pci_driver() - Helper macro for registering a PCI driver
> + * @__pci_driver: pci_driver struct
> + *
> + * Helper macro for PCI drivers which do not do anything special in their
> + * init code. This eliminates a lot of boilerplate. Each driver may only
> + * use this macro once, and calling it replaces device_initcall(...)

The builtin_platform_driver() patches I see are single-line patches,
so they don't look like they remove a *lot* of boilerplate.

Bjorn

> + */
> +#define builtin_pci_driver(__pci_driver) \
> +	builtin_driver(__pci_driver, pci_register_driver)
> +
>  struct pci_driver *pci_dev_driver(const struct pci_dev *dev);
>  int pci_add_dynid(struct pci_driver *drv,
>  		  unsigned int vendor, unsigned int device,
> -- 
> 2.5.0
> 
