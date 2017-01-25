Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.136]:58142 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1750731AbdAYR6O (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Wed, 25 Jan 2017 12:58:14 -0500
Date: Wed, 25 Jan 2017 11:58:09 -0600
From: Bjorn Helgaas <helgaas@kernel.org>
To: kilian.singer@quantumtechnology.info
Cc: linux-pci@vger.kernel.org,
        Mika Westerberg <mika.westerberg@linux.intel.com>,
        Lukas Wunner <lukas@wunner.de>,
        "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>,
        Ben Hutchings <ben@decadent.org.uk>,
        Daniel Vetter <daniel.vetter@intel.com>,
        Dave Airlie <airlied@gmail.com>,
        Chris Wilson <chris@chris-wilson.co.uk>,
        Lyude <lyude@redhat.com>
Subject: Re: PCI: Revert "PCI: Add runtime PM support for PCIe ports"
Message-ID: <20170125175809.GA14892@bhelgaas-glaptop.roam.corp.google.com>
References: <20161227235737.GB24366@bhelgaas-glaptop.roam.corp.google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
In-Reply-To: <20161227235737.GB24366@bhelgaas-glaptop.roam.corp.google.com>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

[+cc Ben, since this bug was reported against a Debian stretch kernel,
Daniel, Dave, Chris, Lyude]

On Tue, Dec 27, 2016 at 05:57:37PM -0600, Bjorn Helgaas wrote:
> Hi Killian,
> 
> Thanks for the report (https://bugzilla.kernel.org/show_bug.cgi?id=190861)
> and all the debugging you've done.  Below is a revert of the troublesome
> commit.  Can you test it and verify that it also fixes the problem?
> 
> I assume Mika is looking at this and will have a better solution soon.
> But if not, I'll queue this up for v4.10.
> 
> 
> commit e648b1ca2b94d207289fedc2538d33c57cdbc4de
> Author: Bjorn Helgaas <bhelgaas@google.com>
> Date:   Tue Dec 27 17:27:30 2016 -0600
> 
>     Revert "PCI: Add runtime PM support for PCIe ports"
>     
>     Revert 006d44e49a25 ("PCI: Add runtime PM support for PCIe ports").
>     
>     Killian reported that on a Lenovo W54l with i7-4810MQ, Intel HD Graphics
>     4600, and NVIDIA Quadro® K1100M, locking the screen kills all keyboard and
>     mouse interaction.  Reverting 006d44e49a25 fixes the problem.
>     
>     Link: https://bugzilla.kernel.org/show_bug.cgi?id=190861
>     Reported-by: kilian.singer@quantumtechnology.info
>     Signed-off-by: Bjorn Helgaas <bhelgaas@google.com>
>     CC: stable@vger.kernel.org	# v4.8+
>     CC: Mika Westerberg <mika.westerberg@linux.intel.com>

I dropped this revert, since Kilian has confirmed that 3846fd9b8600
("drm/probe-helpers: Drop locking from poll_enable"), which is already
in Linus' tree, fixes the problem.

Unfortunately the 3846fd9b8600 changelog does not mention this problem and
I don't know what's required to backport the fix to v4.9.

> diff --git a/drivers/pci/pcie/portdrv_core.c b/drivers/pci/pcie/portdrv_core.c
> index 9698289..dcb185c 100644
> --- a/drivers/pci/pcie/portdrv_core.c
> +++ b/drivers/pci/pcie/portdrv_core.c
> @@ -11,7 +11,6 @@
>  #include <linux/kernel.h>
>  #include <linux/errno.h>
>  #include <linux/pm.h>
> -#include <linux/pm_runtime.h>
>  #include <linux/string.h>
>  #include <linux/slab.h>
>  #include <linux/pcieport_if.h>
> @@ -343,8 +342,6 @@ static int pcie_device_init(struct pci_dev *pdev, int service, int irq)
>  		return retval;
>  	}
>  
> -	pm_runtime_no_callbacks(device);
> -
>  	return 0;
>  }
>  
> diff --git a/drivers/pci/pcie/portdrv_pci.c b/drivers/pci/pcie/portdrv_pci.c
> index 8aa3f14..d3af264 100644
> --- a/drivers/pci/pcie/portdrv_pci.c
> +++ b/drivers/pci/pcie/portdrv_pci.c
> @@ -85,26 +85,6 @@ static int pcie_port_resume_noirq(struct device *dev)
>  	return 0;
>  }
>  
> -static int pcie_port_runtime_suspend(struct device *dev)
> -{
> -	return to_pci_dev(dev)->bridge_d3 ? 0 : -EBUSY;
> -}
> -
> -static int pcie_port_runtime_resume(struct device *dev)
> -{
> -	return 0;
> -}
> -
> -static int pcie_port_runtime_idle(struct device *dev)
> -{
> -	/*
> -	 * Assume the PCI core has set bridge_d3 whenever it thinks the port
> -	 * should be good to go to D3.  Everything else, including moving
> -	 * the port to D3, is handled by the PCI core.
> -	 */
> -	return to_pci_dev(dev)->bridge_d3 ? 0 : -EBUSY;
> -}
> -
>  static const struct dev_pm_ops pcie_portdrv_pm_ops = {
>  	.suspend	= pcie_port_device_suspend,
>  	.resume		= pcie_port_device_resume,
> @@ -113,9 +93,6 @@ static const struct dev_pm_ops pcie_portdrv_pm_ops = {
>  	.poweroff	= pcie_port_device_suspend,
>  	.restore	= pcie_port_device_resume,
>  	.resume_noirq	= pcie_port_resume_noirq,
> -	.runtime_suspend = pcie_port_runtime_suspend,
> -	.runtime_resume	= pcie_port_runtime_resume,
> -	.runtime_idle	= pcie_port_runtime_idle,
>  };
>  
>  #define PCIE_PORTDRV_PM_OPS	(&pcie_portdrv_pm_ops)
> @@ -149,31 +126,11 @@ static int pcie_portdrv_probe(struct pci_dev *dev,
>  		return status;
>  
>  	pci_save_state(dev);
> -
> -	if (pci_bridge_d3_possible(dev)) {
> -		/*
> -		 * Keep the port resumed 100ms to make sure things like
> -		 * config space accesses from userspace (lspci) will not
> -		 * cause the port to repeatedly suspend and resume.
> -		 */
> -		pm_runtime_set_autosuspend_delay(&dev->dev, 100);
> -		pm_runtime_use_autosuspend(&dev->dev);
> -		pm_runtime_mark_last_busy(&dev->dev);
> -		pm_runtime_put_autosuspend(&dev->dev);
> -		pm_runtime_allow(&dev->dev);
> -	}
> -
>  	return 0;
>  }
>  
>  static void pcie_portdrv_remove(struct pci_dev *dev)
>  {
> -	if (pci_bridge_d3_possible(dev)) {
> -		pm_runtime_forbid(&dev->dev);
> -		pm_runtime_get_noresume(&dev->dev);
> -		pm_runtime_dont_use_autosuspend(&dev->dev);
> -	}
> -
>  	pcie_port_device_remove(dev);
>  }
>  
> --
> To unsubscribe from this list: send the line "unsubscribe linux-pci" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
