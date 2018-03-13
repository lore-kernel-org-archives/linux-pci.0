Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.99]:52268 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751362AbeCMRez (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Tue, 13 Mar 2018 13:34:55 -0400
Date: Tue, 13 Mar 2018 12:34:49 -0500
From: Bjorn Helgaas <helgaas@kernel.org>
To: Lukas Wunner <lukas@wunner.de>
Cc: dri-devel@lists.freedesktop.org, Peter Wu <peter@lekensteyn.nl>,
        Alex Deucher <alexander.deucher@amd.com>,
        nouveau@lists.freedesktop.org, Imre Deak <imre.deak@intel.com>,
        Maik Freudenberg <hhfeuer@gmx.de>,
        Raphael Doursenaud <rdoursenaud@free.fr>,
        Martin Lopatar <lopin@dataplex.cz>,
        Daniel Drake <dan@reactivated.net>,
        Denis Lisov <dennis.lissov@gmail.com>, zigarrre@gmail.com,
        "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>,
        Bjorn Helgaas <bhelgaas@google.com>, linux-pci@vger.kernel.org
Subject: Re: [PATCH v2 1/7] PCI: Restore config space on runtime resume
 despite being unbound
Message-ID: <20180313173449.GA202215@bhelgaas-glaptop.roam.corp.google.com>
References: <cover.1520068884.git.lukas@wunner.de>
 <92fb6e6ae2730915eb733c08e2f76c6a313e3860.1520068884.git.lukas@wunner.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <92fb6e6ae2730915eb733c08e2f76c6a313e3860.1520068884.git.lukas@wunner.de>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Sat, Mar 03, 2018 at 10:53:24AM +0100, Lukas Wunner wrote:
> From: Rafael J. Wysocki <rjw@rjwysocki.net>
> 
> We leave PCI devices not bound to a driver in D0 during runtime suspend.
> But they may have a parent which is bound and can be transitioned to
> D3cold at runtime.  Once the parent goes to D3cold, the unbound child
> may go to D3cold as well.  When the child comes out of D3cold, its BARs
> are uninitialized and thus inaccessible when a driver tries to probe.

There's no clear way to tell whether a BAR is uninitialized.  At
power-up, the writable bits will be zero, which is a valid BAR value.
If enabled in PCI_COMMAND, the BAR is accessible and may conflict with
other devices.

Possible alternate wording:

  When the child goes to D3cold, its internal state, including
  configuration of BARs, MSI, ASPM, MPS, etc., is lost.

> Moreover configuration done during enumeration, e.g. ASPM and MPS, will
> be lost.
> 
> One example are recent hybrid graphics laptops which cut power to the
> discrete GPU when the root port above it goes to ACPI power state D3.
> Users may provoke this by unbinding the GPU driver and allowing runtime
> PM on the GPU via sysfs:  The PM core will then treat the GPU as
> "suspended", which in turn allows the root port to runtime suspend,
> causing the power resources listed in its _PR3 object to be powered off.
> The GPU's BARs will be uninitialized when a driver later probes it.
> 
> Another example are hybrid graphics laptops where the GPU itself (rather
> than the root port) is capable of runtime suspending to D3cold.  If the
> GPU's integrated HDA controller is not bound and the GPU's driver
> decides to runtime suspend to D3cold, the HDA controller's BARs will be
> uninitialized when a driver later probes it.
> 
> Fix by saving and restoring config space over a runtime suspend cycle
> even if the device is not bound.
> 
> Cc: Bjorn Helgaas <bhelgaas@google.com>
> Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> [lukas: add commit message, bikeshed code comments for clarity]
> Signed-off-by: Lukas Wunner <lukas@wunner.de>

Acked-by: Bjorn Helgaas <bhelgaas@google.com>

> ---
> Changes since v1:
> - Replace patch to use pci_save_state() / pci_restore_state()
>   for consistency between runtime PM code path of bound and unbound
>   devices. (Rafael, Bjorn)
> 
>  drivers/pci/pci-driver.c | 17 +++++++++++------
>  1 file changed, 11 insertions(+), 6 deletions(-)
> 
> diff --git a/drivers/pci/pci-driver.c b/drivers/pci/pci-driver.c
> index 3bed6beda051..6a67cdbd0e6a 100644
> --- a/drivers/pci/pci-driver.c
> +++ b/drivers/pci/pci-driver.c
> @@ -1224,11 +1224,14 @@ static int pci_pm_runtime_suspend(struct device *dev)
>  	int error;
>  
>  	/*
> -	 * If pci_dev->driver is not set (unbound), the device should
> -	 * always remain in D0 regardless of the runtime PM status
> +	 * If pci_dev->driver is not set (unbound), we leave the device in D0,
> +	 * but it may go to D3cold when the bridge above it runtime suspends.
> +	 * Save its config space in case that happens.

Thanks for this clarification.

>  	 */
> -	if (!pci_dev->driver)
> +	if (!pci_dev->driver) {
> +		pci_save_state(pci_dev);
>  		return 0;
> +	}
>  
>  	if (!pm || !pm->runtime_suspend)
>  		return -ENOSYS;
> @@ -1276,16 +1279,18 @@ static int pci_pm_runtime_resume(struct device *dev)
>  	const struct dev_pm_ops *pm = dev->driver ? dev->driver->pm : NULL;
>  
>  	/*
> -	 * If pci_dev->driver is not set (unbound), the device should
> -	 * always remain in D0 regardless of the runtime PM status
> +	 * Restoring config space is necessary even if the device is not bound
> +	 * to a driver because although we left it in D0, it may have gone to
> +	 * D3cold when the bridge above it runtime suspended.
>  	 */
> +	pci_restore_standard_config(pci_dev);
> +
>  	if (!pci_dev->driver)
>  		return 0;
>  
>  	if (!pm || !pm->runtime_resume)
>  		return -ENOSYS;
>  
> -	pci_restore_standard_config(pci_dev);
>  	pci_fixup_device(pci_fixup_resume_early, pci_dev);
>  	pci_enable_wake(pci_dev, PCI_D0, false);
>  	pci_fixup_device(pci_fixup_resume, pci_dev);
> -- 
> 2.15.1
> 
