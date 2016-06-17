Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.136]:35790 "EHLO mail.kernel.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751129AbcFQUsc (ORCPT <rfc822;linux-pci@vger.kernel.org>);
	Fri, 17 Jun 2016 16:48:32 -0400
Date: Fri, 17 Jun 2016 15:48:24 -0500
From: Bjorn Helgaas <helgaas@kernel.org>
To: Mika Westerberg <mika.westerberg@linux.intel.com>
Cc: Bjorn Helgaas <bhelgaas@google.com>,
	"Rafael J. Wysocki" <rjw@rjwysocki.net>,
	Qipeng Zha <qipeng.zha@intel.com>,
	Qi Zheng <qi.zheng@intel.com>, Dave Airlie <airlied@gmail.com>,
	Mathias Nyman <mathias.nyman@intel.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Lukas Wunner <lukas@wunner.de>,
	Andreas Noever <andreas.noever@gmail.com>,
	linux-pci@vger.kernel.org, linux-pm@vger.kernel.org
Subject: Re: [PATCH v5 4/4] PCI: Add runtime PM support for PCIe ports
Message-ID: <20160617204824.GB10416@localhost>
References: <1461919919-120102-1-git-send-email-mika.westerberg@linux.intel.com>
 <1461919919-120102-5-git-send-email-mika.westerberg@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1461919919-120102-5-git-send-email-mika.westerberg@linux.intel.com>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Fri, Apr 29, 2016 at 11:51:59AM +0300, Mika Westerberg wrote:
> Add back runtime PM support for PCIe ports that was removed in
> commit fe9a743a2601 ("PCI/PM: Drop unused runtime PM support code for
> PCIe ports").
> 
> First of all we cannot enable it automatically for all ports since there
> has been problems previously as can be seen in [1]. In summary suspended
> PCIe ports were not able to deal with ACPI based hotplug reliably. One
> reason why this might happen is the fact that when a PCIe port is powered
> down, config space access to the devices behind the port is not possible.
> If the BIOS hotplug SMI handler assumes the port is always in D0 it will
> not be able to find the hotplugged devices. To be on the safe side only
> enable runtime PM if the port does not claim to support hotplug.
> 
> For PCIe ports not using hotplug we enable and allow runtime PM
> automatically. Since 'bridge_d3' can be changed any time we check this in
> driver ->runtime_idle() and ->runtime_suspend() and only allow runtime
> suspend if the flag is still set. Use autosuspend with default of 10ms idle
> time to prevent the port from repeatedly suspending and resuming on
> continuous configuration space access of devices behind the port.
> 
> The actual power transition to D3 and back is handled in the PCI core.
> 
> Idea to automatically unblock (allow) runtime PM for PCIe ports came from
> Dave Airlie.
> 
> [1] https://bugzilla.kernel.org/show_bug.cgi?id=53811
> 
> Signed-off-by: Lukas Wunner <lukas@wunner.de>
> Signed-off-by: Mika Westerberg <mika.westerberg@linux.intel.com>
> Acked-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> ---
>  drivers/pci/pcie/portdrv_core.c |  2 ++
>  drivers/pci/pcie/portdrv_pci.c  | 50 +++++++++++++++++++++++++++++++++++++++++
>  2 files changed, 52 insertions(+)
> 
> diff --git a/drivers/pci/pcie/portdrv_core.c b/drivers/pci/pcie/portdrv_core.c
> index 88122dc2e1b1..65b1a624826b 100644
> --- a/drivers/pci/pcie/portdrv_core.c
> +++ b/drivers/pci/pcie/portdrv_core.c
> @@ -11,6 +11,7 @@
>  #include <linux/kernel.h>
>  #include <linux/errno.h>
>  #include <linux/pm.h>
> +#include <linux/pm_runtime.h>
>  #include <linux/string.h>
>  #include <linux/slab.h>
>  #include <linux/pcieport_if.h>
> @@ -343,6 +344,7 @@ static int pcie_device_init(struct pci_dev *pdev, int service, int irq)
>  		     get_descriptor_id(pci_pcie_type(pdev), service));
>  	device->parent = &pdev->dev;
>  	device_enable_async_suspend(device);
> +	pm_runtime_no_callbacks(device);
>  
>  	retval = device_register(device);
>  	if (retval) {
> diff --git a/drivers/pci/pcie/portdrv_pci.c b/drivers/pci/pcie/portdrv_pci.c
> index 6c6bb03392ea..f4409af00756 100644
> --- a/drivers/pci/pcie/portdrv_pci.c
> +++ b/drivers/pci/pcie/portdrv_pci.c
> @@ -93,6 +93,26 @@ static int pcie_port_resume_noirq(struct device *dev)
>  	return 0;
>  }
>  
> +static int pcie_port_runtime_suspend(struct device *dev)
> +{
> +	return to_pci_dev(dev)->bridge_d3 ? 0 : -EBUSY;
> +}
> +
> +static int pcie_port_runtime_resume(struct device *dev)
> +{
> +	return 0;
> +}
> +
> +static int pcie_port_runtime_idle(struct device *dev)
> +{
> +	/*
> +	 * Rely the PCI core has set bridge_d3 whenever it thinks the port
> +	 * should be good to go to D3. Everything else, including moving
> +	 * the port to D3, is handled by the PCI core.
> +	 */
> +	return to_pci_dev(dev)->bridge_d3 ? 0 : -EBUSY;
> +}
> +
>  static const struct dev_pm_ops pcie_portdrv_pm_ops = {
>  	.suspend	= pcie_port_device_suspend,
>  	.resume		= pcie_port_device_resume,
> @@ -101,6 +121,9 @@ static const struct dev_pm_ops pcie_portdrv_pm_ops = {
>  	.poweroff	= pcie_port_device_suspend,
>  	.restore	= pcie_port_device_resume,
>  	.resume_noirq	= pcie_port_resume_noirq,
> +	.runtime_suspend = pcie_port_runtime_suspend,
> +	.runtime_resume	= pcie_port_runtime_resume,
> +	.runtime_idle	= pcie_port_runtime_idle,
>  };
>  
>  #define PCIE_PORTDRV_PM_OPS	(&pcie_portdrv_pm_ops)
> @@ -134,11 +157,38 @@ static int pcie_portdrv_probe(struct pci_dev *dev,
>  		return status;
>  
>  	pci_save_state(dev);
> +
> +	/*
> +	 * Prevent runtime PM if the port is advertising support for PCIe
> +	 * hotplug. Otherwise the BIOS hotplug SMI code might not be able
> +	 * to enumerate devices behind this port properly (the port is
> +	 * powered down preventing all config space accesses to the
> +	 * subordinate devices). We can't be sure for native PCIe hotplug
> +	 * either so prevent that as well.

Can we wordsmith this comment a bit?  I'm not sure what "BIOS hotplug
SMI code" even is or why it is relevant.  And it seems x86-centric so
may not apply to other arches.

> +	 */
> +	if (!dev->is_hotplug_bridge) {

Your changelog mentions ACPI hotplug (I assume this means acpiphp).
Would it be sufficient to prevent runtime PM when we're using acpiphp?
That would be more selective and would avoid penalizing non-ACPI
platforms and newer systems that use native pciehp.

PCIe r3.0, sec 6.7.3.4 says a port should generate a wakeup event
using PME on hotplug events that occur when the port is in D1, D2, or
D3hot (it doesn't mention D3cold).  Is that relevant here?  Is there a
way to control which D-states we use based on which ones can assert
PME?

> +		/*
> +		 * Keep the port resumed 10ms to make sure things like
> +		 * config space accesses from userspace (lspci) will not
> +		 * cause the port to repeatedly suspend and resume.
> +		 */
> +		pm_runtime_set_autosuspend_delay(&dev->dev, 10);
> +		pm_runtime_use_autosuspend(&dev->dev);
> +		pm_runtime_put_autosuspend(&dev->dev);
> +		pm_runtime_allow(&dev->dev);
> +	}
> +
>  	return 0;
>  }
>  
>  static void pcie_portdrv_remove(struct pci_dev *dev)
>  {
> +	if (!dev->is_hotplug_bridge) {
> +		pm_runtime_forbid(&dev->dev);
> +		pm_runtime_get_noresume(&dev->dev);
> +		pm_runtime_dont_use_autosuspend(&dev->dev);
> +	}
> +
>  	pcie_port_device_remove(dev);
>  }
>  
> -- 
> 2.8.0.rc3
> 
> --
> To unsubscribe from this list: send the line "unsubscribe linux-pci" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
