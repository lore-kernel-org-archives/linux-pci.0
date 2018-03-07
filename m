Return-Path: <SRS0=MUuQ=F5=rjwysocki.net=rjw@kernel.org>
Return-Path: <SRS0=MUuQ=F5=rjwysocki.net=rjw@kernel.org>
From: "Rafael J. Wysocki" <rjw@rjwysocki.net>
To: Bjorn Helgaas <helgaas@kernel.org>
Cc: linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org, Keith Busch <keith.busch@intel.com>, Sinan Kaya <okaya@codeaurora.org>, Lukas Wunner <lukas@wunner.de>
Subject: Re: [PATCH v1 2/9] PCI/PM: Clear PCIe PME Status bit in core, not PCIe port driver
Date: Wed, 07 Mar 2018 11:27:03 +0100
Message-ID: <5379448.nrM4VZMk5Q@aspire.rjw.lan>
In-Reply-To: <152040321483.240786.16597888035806933750.stgit@bhelgaas-glaptop.roam.corp.google.com>
References: <152040297576.240786.1532465558381209070.stgit@bhelgaas-glaptop.roam.corp.google.com> <152040321483.240786.16597888035806933750.stgit@bhelgaas-glaptop.roam.corp.google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
List-ID: <linux-pci.vger.kernel.org>

On Wednesday, March 7, 2018 7:13:34 AM CET Bjorn Helgaas wrote:
> From: Bjorn Helgaas <bhelgaas@google.com>
> 
> fe31e69740ed ("PCI/PCIe: Clear Root PME Status bits early during system
> resume") added a .resume_noirq() callback to the PCIe port driver to clear
> the PME Status bit during resume to work around a BIOS issue.
> 
> The BIOS evidently enabled PME interrupts for ACPI-based runtime wakeups
> but did not clear the PME Status bit during resume, which meant PMEs after
> resume did not trigger interrupts because PME Status did not transition
> from cleared to set.
> 
> The fix was in the PCIe port driver, so it worked when CONFIG_PCIEPORTBUS
> was set.  But I think we *always* want the fix because the platform may use
> PME interrupts even if Linux is built without the PCIe port driver.
> 
> Move the fix from the port driver to the PCI core so we can work around
> this "PME doesn't work after waking from a sleep state" issue regardless of
> CONFIG_PCIEPORTBUS.
> 
> Signed-off-by: Bjorn Helgaas <bhelgaas@google.com>
> ---
>  drivers/pci/pci-driver.c       |   14 ++++++++++++++
>  drivers/pci/pcie/portdrv_pci.c |   15 ---------------
>  2 files changed, 14 insertions(+), 15 deletions(-)
> 
> diff --git a/drivers/pci/pci-driver.c b/drivers/pci/pci-driver.c
> index 3bed6beda051..bf0704b75f79 100644
> --- a/drivers/pci/pci-driver.c
> +++ b/drivers/pci/pci-driver.c
> @@ -525,6 +525,18 @@ static void pci_pm_default_resume_early(struct pci_dev *pci_dev)
>  	pci_fixup_device(pci_fixup_resume_early, pci_dev);
>  }
>  
> +static void pcie_resume_early(struct pci_dev *pci_dev)

I'd call it pcie_pme_root_status_cleanup() or similar so it is more clear
what this function is for.

LGTM otherwise.

> +{
> +	/*
> +	 * Some BIOSes forget to clear Root PME Status bits after system wakeup
> +	 * which breaks ACPI-based runtime wakeup on PCI Express, so clear those
> +	 * bits now just in case (shouldn't hurt).
> +	 */
> +	if (pci_is_pcie(pci_dev) &&
> +	    pci_pcie_type(pci_dev) == PCI_EXP_TYPE_ROOT_PORT)
> +		pcie_clear_root_pme_status(pci_dev);
> +}
> +
>  /*
>   * Default "suspend" method for devices that have no driver provided suspend,
>   * or not even a driver at all (second part).
> @@ -873,6 +885,8 @@ static int pci_pm_resume_noirq(struct device *dev)
>  	if (pci_has_legacy_pm_support(pci_dev))
>  		return pci_legacy_resume_early(dev);
>  
> +	pcie_resume_early(pci_dev);
> +
>  	if (drv && drv->pm && drv->pm->resume_noirq)
>  		error = drv->pm->resume_noirq(dev);
>  
> diff --git a/drivers/pci/pcie/portdrv_pci.c b/drivers/pci/pcie/portdrv_pci.c
> index 4413dd85e923..f91afd09e356 100644
> --- a/drivers/pci/pcie/portdrv_pci.c
> +++ b/drivers/pci/pcie/portdrv_pci.c
> @@ -62,20 +62,6 @@ static int pcie_portdrv_restore_config(struct pci_dev *dev)
>  }
>  
>  #ifdef CONFIG_PM
> -static int pcie_port_resume_noirq(struct device *dev)
> -{
> -	struct pci_dev *pdev = to_pci_dev(dev);
> -
> -	/*
> -	 * Some BIOSes forget to clear Root PME Status bits after system wakeup
> -	 * which breaks ACPI-based runtime wakeup on PCI Express, so clear those
> -	 * bits now just in case (shouldn't hurt).
> -	 */
> -	if (pci_pcie_type(pdev) == PCI_EXP_TYPE_ROOT_PORT)
> -		pcie_clear_root_pme_status(pdev);
> -	return 0;
> -}
> -
>  static int pcie_port_runtime_suspend(struct device *dev)
>  {
>  	return to_pci_dev(dev)->bridge_d3 ? 0 : -EBUSY;
> @@ -103,7 +89,6 @@ static const struct dev_pm_ops pcie_portdrv_pm_ops = {
>  	.thaw		= pcie_port_device_resume,
>  	.poweroff	= pcie_port_device_suspend,
>  	.restore	= pcie_port_device_resume,
> -	.resume_noirq	= pcie_port_resume_noirq,
>  	.runtime_suspend = pcie_port_runtime_suspend,
>  	.runtime_resume	= pcie_port_runtime_resume,
>  	.runtime_idle	= pcie_port_runtime_idle,
> 
> 
