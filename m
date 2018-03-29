Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from cloudserver094114.home.pl ([79.96.170.134]:60475 "EHLO
        cloudserver094114.home.pl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750735AbeC2LBZ (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 29 Mar 2018 07:01:25 -0400
From: "Rafael J. Wysocki" <rjw@rjwysocki.net>
To: Arnd Bergmann <arnd@arndb.de>
Cc: Bjorn Helgaas <bhelgaas@google.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] pci: move pcie_pme_root_status_cleanup into SUSPEND section
Date: Thu, 29 Mar 2018 13:01:42 +0200
Message-ID: <8350395.vIT3VM8fAC@aspire.rjw.lan>
In-Reply-To: <20180328134747.2062348-1-arnd@arndb.de>
References: <20180328134747.2062348-1-arnd@arndb.de>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Wednesday, March 28, 2018 3:47:18 PM CEST Arnd Bergmann wrote:
> The power management code in pci-driver.c is a maze of #ifdefs, and
> the newly added pcie_pme_root_status_cleanup function ended up in the
> wrong one of them, causing a harmless warning in some configurations:
> 
> drivers/pci/pci-driver.c:527:13: error: 'pcie_pme_root_status_cleanup' defined but not used [-Werror=unused-function]
>  static void pcie_pme_root_status_cleanup(struct pci_dev *pci_dev)
>              ^~~~~~~~~~~~~~~~~~~~~~~~~~~~
> 
> This moves the definition into the correct #ifdef section.
> 
> Fixes: 6c4dfc1389e1 ("PCI/PM: Clear PCIe PME Status bit in core, not PCIe port driver")
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>
> ---
>  drivers/pci/pci-driver.c | 25 ++++++++++++-------------
>  1 file changed, 12 insertions(+), 13 deletions(-)
> 
> diff --git a/drivers/pci/pci-driver.c b/drivers/pci/pci-driver.c
> index b9bca74e9eff..6ace47099fc5 100644
> --- a/drivers/pci/pci-driver.c
> +++ b/drivers/pci/pci-driver.c
> @@ -524,19 +524,6 @@ static void pci_pm_default_resume_early(struct pci_dev *pci_dev)
>  	pci_fixup_device(pci_fixup_resume_early, pci_dev);
>  }
>  
> -static void pcie_pme_root_status_cleanup(struct pci_dev *pci_dev)
> -{
> -	/*
> -	 * Some BIOSes forget to clear Root PME Status bits after system
> -	 * wakeup, which breaks ACPI-based runtime wakeup on PCI Express.
> -	 * Clear those bits now just in case (shouldn't hurt).
> -	 */
> -	if (pci_is_pcie(pci_dev) &&
> -	    (pci_pcie_type(pci_dev) == PCI_EXP_TYPE_ROOT_PORT ||
> -	     pci_pcie_type(pci_dev) == PCI_EXP_TYPE_RC_EC))
> -		pcie_clear_root_pme_status(pci_dev);
> -}
> -
>  /*
>   * Default "suspend" method for devices that have no driver provided suspend,
>   * or not even a driver at all (second part).
> @@ -726,6 +713,18 @@ static void pci_pm_complete(struct device *dev)
>  #endif /* !CONFIG_PM_SLEEP */
>  
>  #ifdef CONFIG_SUSPEND
> +static void pcie_pme_root_status_cleanup(struct pci_dev *pci_dev)
> +{
> +	/*
> +	 * Some BIOSes forget to clear Root PME Status bits after system
> +	 * wakeup, which breaks ACPI-based runtime wakeup on PCI Express.
> +	 * Clear those bits now just in case (shouldn't hurt).
> +	 */
> +	if (pci_is_pcie(pci_dev) &&
> +	    (pci_pcie_type(pci_dev) == PCI_EXP_TYPE_ROOT_PORT ||
> +	     pci_pcie_type(pci_dev) == PCI_EXP_TYPE_RC_EC))
> +		pcie_clear_root_pme_status(pci_dev);
> +}
>  
>  static int pci_pm_suspend(struct device *dev)
>  {
> 

Reviewed-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
