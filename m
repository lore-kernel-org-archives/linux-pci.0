Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.136]:44783 "EHLO mail.kernel.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751286AbcCLAaf (ORCPT <rfc822;linux-pci@vger.kernel.org>);
	Fri, 11 Mar 2016 19:30:35 -0500
Date: Fri, 11 Mar 2016 18:30:29 -0600
From: Bjorn Helgaas <helgaas@kernel.org>
To: Mika Westerberg <mika.westerberg@linux.intel.com>
Cc: Bjorn Helgaas <bhelgaas@google.com>,
	"Rafael J. Wysocki" <rjw@rjwysocki.net>,
	Qipeng Zha <qipeng.zha@intel.com>,
	Qi Zheng <qi.zheng@intel.com>, linux-pci@vger.kernel.org,
	linux-pm@vger.kernel.org
Subject: Re: [PATCH 4/6] PCI: Add runtime PM support for PCIe ports
Message-ID: <20160312003029.GL4725@localhost>
References: <1456750566-116248-1-git-send-email-mika.westerberg@linux.intel.com>
 <1456750566-116248-5-git-send-email-mika.westerberg@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1456750566-116248-5-git-send-email-mika.westerberg@linux.intel.com>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Mon, Feb 29, 2016 at 02:56:04PM +0200, Mika Westerberg wrote:
> Add back runtime PM support for PCIe ports that was removed in
> commit fe9a743a2601 ("PCI/PM: Drop unused runtime PM support code for PCIe
> ports").
> 
> First of all we cannot enable it automatically for all root ports since
> there have been problems previously, 

Pointers to these problems would be useful.

> so we enable it only based on per port
> configuration (runtime_suspend_allowed).

I see that the next patch basically adds a quirk to set
runtime_suspend_allowed for Sunrisepoint.  How do we prevent this
from being a maintenance nightmare?  I don't want to have to add
a quirk for every new device that supports runtime PM.

> Furthermore we need to check that
> the device, if wake capable, can do so from D3cold (which is the state it
> goes after the root port is powered down).

I don't see this check.  I was expecting something like
device_may_wakeup(&pdev->dev) && !pci_pme_capable(pdev, PCI_D3cold)
like you did in the "Move PCIe ports to D3hot during suspend" patch.

> This follows what we did for
> PCIe port system suspend already.
> 
> Runtime PM is still blocked and needs to be unblocked from userspace like
> with other PCI devices.

Can you expand on this a bit?  I assume you mean that runtime PM is
disabled by default, and userspace has to enable it with a sysfs switch or
something?  Can you include information about how to do that?

> Signed-off-by: Mika Westerberg <mika.westerberg@linux.intel.com>
> ---
>  drivers/pci/pcie/portdrv_pci.c | 49 ++++++++++++++++++++++++++++++++++++++++++
>  1 file changed, 49 insertions(+)
> 
> diff --git a/drivers/pci/pcie/portdrv_pci.c b/drivers/pci/pcie/portdrv_pci.c
> index fe3349685141..eb0f425f51cc 100644
> --- a/drivers/pci/pcie/portdrv_pci.c
> +++ b/drivers/pci/pcie/portdrv_pci.c
> @@ -85,6 +85,7 @@ enum pcie_port_type {
>  
>  struct pcie_port_config {
>  	bool suspend_allowed;
> +	bool runtime_suspend_allowed;
>  };
>  
>  static const struct pcie_port_config pcie_port_configs[] = {
> @@ -154,6 +155,11 @@ static bool pcie_port_suspend_allowed(struct pci_dev *pdev)
>  	return pcie_port_can_suspend(pdev);
>  }
>  
> +static bool pcie_port_runtime_suspend_allowed(struct pci_dev *pdev)
> +{
> +	return pcie_port_get_config(pdev)->runtime_suspend_allowed;
> +}
> +
>  static int pcie_port_suspend_noirq(struct device *dev)
>  {
>  	struct pci_dev *pdev = to_pci_dev(dev);
> @@ -188,6 +194,34 @@ static int pcie_port_resume_noirq(struct device *dev)
>  	return 0;
>  }
>  
> +static int pcie_port_runtime_suspend(struct device *dev)
> +{
> +	struct pci_dev *pdev = to_pci_dev(dev);
> +
> +	/*
> +	 * All devices behind the port are assumed to be in D3cold so
> +	 * update their state now.
> +	 */
> +	__pci_bus_set_current_state(pdev->subordinate, PCI_D3cold);
> +	return 0;
> +}
> +
> +static int pcie_port_runtime_resume(struct device *dev)
> +{
> +	return 0;
> +}
> +
> +static int pcie_port_runtime_idle(struct device *dev)
> +{
> +	struct pci_dev *pdev = to_pci_dev(dev);
> +
> +	if (pcie_port_can_suspend(pdev)) {
> +		pm_schedule_suspend(dev, 10);
> +		return 0;
> +	}
> +	return -EBUSY;
> +}
> +
>  static const struct dev_pm_ops pcie_portdrv_pm_ops = {
>  	.suspend	= pcie_port_device_suspend,
>  	.resume		= pcie_port_device_resume,
> @@ -197,12 +231,20 @@ static const struct dev_pm_ops pcie_portdrv_pm_ops = {
>  	.restore	= pcie_port_device_resume,
>  	.suspend_noirq	= pcie_port_suspend_noirq,
>  	.resume_noirq	= pcie_port_resume_noirq,
> +	.runtime_suspend = pcie_port_runtime_suspend,
> +	.runtime_resume	= pcie_port_runtime_resume,
> +	.runtime_idle	= pcie_port_runtime_idle,
>  };
>  
>  #define PCIE_PORTDRV_PM_OPS	(&pcie_portdrv_pm_ops)
>  
>  #else /* !PM */
>  
> +static inline bool pcie_port_runtime_suspend_allowed(struct pci_dev *pdev)
> +{
> +	return false;
> +}
> +
>  #define PCIE_PORTDRV_PM_OPS	NULL
>  #endif /* !PM */
>  
> @@ -230,11 +272,18 @@ static int pcie_portdrv_probe(struct pci_dev *dev,
>  		return status;
>  
>  	pci_save_state(dev);
> +
> +	if (pcie_port_runtime_suspend_allowed(dev))
> +		pm_runtime_put_noidle(&dev->dev);
> +
>  	return 0;
>  }
>  
>  static void pcie_portdrv_remove(struct pci_dev *dev)
>  {
> +	if (pcie_port_runtime_suspend_allowed(dev))
> +		pm_runtime_get_noresume(&dev->dev);
> +
>  	pcie_port_device_remove(dev);
>  }
>  
> -- 
> 2.7.0
> 
> --
> To unsubscribe from this list: send the line "unsubscribe linux-pci" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
