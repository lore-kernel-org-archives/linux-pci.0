Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.99]:54802 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751409AbeF3T6a (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Sat, 30 Jun 2018 15:58:30 -0400
Date: Sat, 30 Jun 2018 14:58:27 -0500
From: Bjorn Helgaas <helgaas@kernel.org>
To: Keith Busch <keith.busch@intel.com>
Cc: Linux PCI <linux-pci@vger.kernel.org>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Oza Pawandeep <poza@codeaurora.org>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>, linux-pm@vger.kernel.org
Subject: Re: [PATCH] PCI/AER: Prevent runtime power management during recovery
Message-ID: <20180630195827.GD9547@bhelgaas-glaptop.roam.corp.google.com>
References: <20180611222918.1708-1-keith.busch@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20180611222918.1708-1-keith.busch@intel.com>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

[+cc Rafael, linux-pm for a PM perspective]

On Mon, Jun 11, 2018 at 04:29:18PM -0600, Keith Busch wrote:
> A bridge that supports D3 but not hotplug will be subject to runtime
> power management placing it in a non-operation power state if it doesn't
> have any devices attached. This patch will prevent this power management
> during error recovery so that the rescan at the end may be successful.

I assume you're seeing a problem that's fixed by this patch?

I'm not very familiar with the pm_runtime_*() interfaces.  The fact
that drivers/pci/ only contains two calls to pm_runtime_forbid() and
two to pm_runtime_allow() (one in a quirk) makes me wonder if this is
the right approach.

Do we need something similar in other enumeration paths, e.g.,
boot-time enumeration, hot-add, sysfs "rescan" entry, etc?

> Cc: Oza Pawandeep <poza@codeaurora.org>
> Signed-off-by: Keith Busch <keith.busch@intel.com>
> ---
>  drivers/pci/pcie/err.c | 3 +++
>  1 file changed, 3 insertions(+)
> 
> diff --git a/drivers/pci/pcie/err.c b/drivers/pci/pcie/err.c
> index f7ce0cb0b0b7..247b6ce14f0d 100644
> --- a/drivers/pci/pcie/err.c
> +++ b/drivers/pci/pcie/err.c
> @@ -16,6 +16,7 @@
>  #include <linux/kernel.h>
>  #include <linux/errno.h>
>  #include <linux/aer.h>
> +#include <linux/pm_runtime.h>
>  #include "portdrv.h"
>  #include "../pci.h"
>  
> @@ -294,6 +295,7 @@ void pcie_do_fatal_recovery(struct pci_dev *dev, u32 service)
>  		udev = dev->bus->self;
>  
>  	parent = udev->subordinate;
> +	pm_runtime_forbid(&udev->dev);
>  	pci_lock_rescan_remove();
>  	list_for_each_entry_safe_reverse(pdev, temp, &parent->devices,
>  					 bus_list) {
> @@ -329,6 +331,7 @@ void pcie_do_fatal_recovery(struct pci_dev *dev, u32 service)
>  	}
>  
>  	pci_unlock_rescan_remove();
> +	pm_runtime_allow(&udev->dev);
>  }
>  
>  /**
> -- 
> 2.14.3
> 
