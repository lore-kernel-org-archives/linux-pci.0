Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.99]:53722 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1750916AbdLMQ3f (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Wed, 13 Dec 2017 11:29:35 -0500
Date: Wed, 13 Dec 2017 10:29:31 -0600
From: Bjorn Helgaas <helgaas@kernel.org>
To: Dongdong Liu <liudongdong3@huawei.com>
Cc: rjw@sisk.pl, linux-pci@vger.kernel.org, stable@vger.kernel.org,
        linuxarm@huawei.com
Subject: Re: [PATCH V2 1/2] PCI/portdrv: Fix switch devctrl error report
 enable
Message-ID: <20171213162931.GD30595@bhelgaas-glaptop.roam.corp.google.com>
References: <1512467438-42850-1-git-send-email-liudongdong3@huawei.com>
 <1512467438-42850-2-git-send-email-liudongdong3@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1512467438-42850-2-git-send-email-liudongdong3@huawei.com>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Tue, Dec 05, 2017 at 05:50:37PM +0800, Dongdong Liu wrote:
> Current code has a bug, switch upstream/downstream port error report
> is disabled.
> DevCtl: Report errors: Correctable- Non-Fatal- Fatal- Unsupported-
> 
> We call aer_probe() for a root port, and it enables AER reporting for
> the root port and any downstream devices:
> 
> aer_probe(root port)                        # only binds to root ports
>   aer_enable_rootport
>     set_downstream_devices_error_reporting(root, true)
>       set_device_error_reporting(root, true)
>         pci_enable_pcie_error_reporting
>           pcie_capability_set_word(root, PCI_EXP_DEVCTL, PCI_EXP_AER_FLAGS)
>         pci_walk_bus(root->subordinate set_device_error_reporting, true)
>           set_device_error_reporting(dev, true)
>             pci_enable_pcie_error_reporting
>               pcie_capability_set_word(dev, PCI_EXP_DEVCTL,
> PCI_EXP_AER_FLAGS)
> 
> We later call pcie_portdrv_probe() for every downstream bridge (it
> matches PCI_CLASS_BRIDGE_PCI devices, then discards any non-PCIe
> devices), and it *disables* AER reporting:
> 
> pcie_portdrv_probe(switch port)
>   pcie_port_device_register
>     get_port_device_capability
>       pci_disable_pcie_error_reporting
>         pcie_capability_clear_word(dev, PCI_EXP_DEVCTL, PCI_EXP_AER_FLAGS)
> 
> The result is that we first enable AER for the downstream switch
> ports, then we disable it again.
> 
> It does not need to disable AER for upstream/downstream ports as
> AER driver only binds to root ports.
> 
> Fixes: 2bd50dd800b5(PCI: PCIe: Disable PCIe port services during port
> initialization)

While you're correcting nits, use the conventional style here:

  Fixes: 2bd50dd800b5 ("PCI: PCIe: Disable PCIe port services during port initialization")

all on one line for greppability.

> Signed-off-by: Dongdong Liu <liudongdong3@huawei.com>
> CC: stable@vger.kernel.org
> ---
>  drivers/pci/pcie/portdrv_core.c | 4 +++-
>  1 file changed, 3 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/pci/pcie/portdrv_core.c b/drivers/pci/pcie/portdrv_core.c
> index a592103..a0dff44 100644
> --- a/drivers/pci/pcie/portdrv_core.c
> +++ b/drivers/pci/pcie/portdrv_core.c
> @@ -241,7 +241,9 @@ static int get_port_device_capability(struct pci_dev *dev)
>  		 * Disable AER on this port in case it's been enabled by the
>  		 * BIOS (the AER service driver will enable it when necessary).
>  		 */
> -		pci_disable_pcie_error_reporting(dev);
> +		if ((pci_pcie_type(dev) != PCI_EXP_TYPE_UPSTREAM) &&
> +		    (pci_pcie_type(dev) != PCI_EXP_TYPE_DOWNSTREAM))
> +			pci_disable_pcie_error_reporting(dev);

I'm not sure this code is in the right place.  This is
get_port_device_capability(); we should be *getting* information, not
*configuring* the device here.

If we're not prepared to handle AER events, I think it's probably
a good idea to disable them, but I'd rather do it in the
pci_init_capabilities() path, e.g., in pci_aer_init().

pciehp is not a capability, but I think we should also move the
disabling of PCI_EXP_SLTCTL_CCIE | PCI_EXP_SLTCTL_HPIE interrupts out
of get_port_device_capability().  Maybe to pci_configure_device()?

I also do not think we should check for upstream/downstream ports.  If
we're going to disable AER (and I think that probably does make
sense), we should do it for every device until we're ready to handle
AER events.

>  	}
>  	/* VC support */
>  	if (pci_find_ext_capability(dev, PCI_EXT_CAP_ID_VC))
> -- 
> 1.9.1
> 
