Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.99]:59750 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726052AbeIDWCb (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Tue, 4 Sep 2018 18:02:31 -0400
Date: Tue, 4 Sep 2018 12:36:23 -0500
From: Bjorn Helgaas <helgaas@kernel.org>
To: Lukas Wunner <lukas@wunner.de>
Cc: Rajat Jain <rajatxjain@gmail.com>,
        Shaohua Li <shaohua.li@intel.com>, linux-pci@vger.kernel.org
Subject: Re: [PATCH] PCI/ASPM: Fix link_state teardown on device removal
Message-ID: <20180904173623.GE107892@bhelgaas-glaptop.roam.corp.google.com>
References: <3005bd6cf124c5fcc7f0720e973e741ba95919c7.1533012643.git.lukas@wunner.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <3005bd6cf124c5fcc7f0720e973e741ba95919c7.1533012643.git.lukas@wunner.de>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Tue, Jul 31, 2018 at 06:58:46AM +0200, Lukas Wunner wrote:
> Upon removal of the last device on a bus, the link_state of the bridge
> leading to that bus is sought to be torn down by having pci_stop_dev()
> call pcie_aspm_exit_link_state().
> 
> When ASPM was originally introduced by commit 7d715a6c1ae5 ("PCI: add
> PCI Express ASPM support"), it determined whether the device being
> removed is the last one by calling list_empty() on the bridge's
> subordinate devices list.  That didn't work because the device is only
> removed from the list slightly later in pci_destroy_dev().
> 
> Commit 3419c75e15f8 ("PCI: properly clean up ASPM link state on device
> remove") attempted to fix it by calling list_is_last(), but that's not
> correct either because it checks whether the device is at the *end* of
> the list, not whether it's the last one *left* in the list.  If the user
> removes the device which happens to be at the end of the list via sysfs
> but other devices are preceding the device in the list, the link_state
> is torn down prematurely.
> 
> The real fix is to move the invocation of pcie_aspm_exit_link_state() to
> pci_destroy_dev() and reinstate the call to list_empty().  Remove a
> duplicate check for dev->bus->self because pcie_aspm_exit_link_state()
> already contains an identical check.
> 
> Fixes: 7d715a6c1ae5 ("PCI: add PCI Express ASPM support")
> Signed-off-by: Lukas Wunner <lukas@wunner.de>
> Cc: Shaohua Li <shaohua.li@intel.com>
> Cc: stable@vger.kernel.org # v2.6.26

Applied to pci/aspm for v4.20, thanks!

> ---
> Alex Chiang, the author of 3419c75e15f8, cannot be cc'ed as the hp.com
> e-mail address used to author that commit bounces with 550 User unknown.
> Same for the canonical.com address used on Alex' last contribution
> 856b185dd23d.
> 
>  drivers/pci/pcie/aspm.c | 2 +-
>  drivers/pci/remove.c    | 4 +---
>  2 files changed, 2 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/pci/pcie/aspm.c b/drivers/pci/pcie/aspm.c
> index 0e88b3ad065f..e492b8e47fb1 100644
> --- a/drivers/pci/pcie/aspm.c
> +++ b/drivers/pci/pcie/aspm.c
> @@ -991,7 +991,7 @@ void pcie_aspm_exit_link_state(struct pci_dev *pdev)
>  	 * All PCIe functions are in one slot, remove one function will remove
>  	 * the whole slot, so just wait until we are the last function left.
>  	 */
> -	if (!list_is_last(&pdev->bus_list, &parent->subordinate->devices))
> +	if (!list_empty(&parent->subordinate->devices))
>  		goto out;
>  
>  	link = parent->link_state;
> diff --git a/drivers/pci/remove.c b/drivers/pci/remove.c
> index 01ec7fcb5634..fb107fb5bb21 100644
> --- a/drivers/pci/remove.c
> +++ b/drivers/pci/remove.c
> @@ -24,9 +24,6 @@ static void pci_stop_dev(struct pci_dev *dev)
>  		pci_remove_sysfs_dev_files(dev);
>  		dev->is_added = 0;
>  	}
> -
> -	if (dev->bus->self)
> -		pcie_aspm_exit_link_state(dev);
>  }
>  
>  static void pci_destroy_dev(struct pci_dev *dev)
> @@ -40,6 +37,7 @@ static void pci_destroy_dev(struct pci_dev *dev)
>  	list_del(&dev->bus_list);
>  	up_write(&pci_bus_sem);
>  
> +	pcie_aspm_exit_link_state(dev);
>  	pci_bridge_d3_update(dev);
>  	pci_free_resources(dev);
>  	put_device(&dev->dev);
> -- 
> 2.18.0
> 
