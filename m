Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.99]:54382 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752908AbdLMVoC (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Wed, 13 Dec 2017 16:44:02 -0500
Date: Wed, 13 Dec 2017 15:43:59 -0600
From: Bjorn Helgaas <helgaas@kernel.org>
To: Mika Westerberg <mika.westerberg@linux.intel.com>
Cc: Bjorn Helgaas <bhelgaas@google.com>,
        Ashok Raj <ashok.raj@intel.com>,
        Keith Busch <keith.busch@intel.com>,
        "Rafael J . Wysocki" <rafael.j.wysocki@intel.com>,
        Lukas Wunner <lukas@wunner.de>,
        Michael Jamet <michael.jamet@intel.com>,
        Yehezkel Bernat <yehezkel.bernat@intel.com>,
        Mario.Limonciello@dell.com, linux-pci@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v5] PCI: hotplug: Drop checking of PCI_BRIDGE_CONTROL in
 *_unconfigure_device()
Message-ID: <20171213214357.GI30595@bhelgaas-glaptop.roam.corp.google.com>
References: <20171109111508.47678-1-mika.westerberg@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20171109111508.47678-1-mika.westerberg@linux.intel.com>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Thu, Nov 09, 2017 at 02:15:08PM +0300, Mika Westerberg wrote:
> During PCIe surprise hot-unplug the device is not accessible anymore and
> register reads return 0xffffffff. When that happens pciehp_unconfigure_device()
> may inadvertently think the device below the bridge may be a display
> device of somesort as reading PCI_BRIDGE_CONTROL register also returns
> 0xff. This results failure of the remove operation:
> 
>   pciehp 0000:00:1c.0:pcie004: Slot(0): Link Down
>   pciehp 0000:00:1c.0:pcie004: Slot(0): Card present
>   pciehp 0000:00:1c.0:pcie004: Cannot remove display device 0000:01:00.0
> 
> Because of this the hierarchy is left untouched preventing further
> hotplug operations.
> 
> Now, it is not clear why the check is there in the first place and why
> we would like to prevent removing a bridge if it has PCI_BRIDGE_CTL_VGA
> set. In case of PCIe surprise hot-unplug, it would not even be possible
> to prevent the removal.
> 
> Given this and the issue described above, I think it makes sense to drop
> the whole PCI_BRIDGE_CONTROL check from pciehp_unconfigure_device().
> While there do the same for shpchp_configure_device() based on the same
> reasoning and the fact that the same bug might trigger in standard PCI
> hotplug as well.
> 
> Signed-off-by: Mika Westerberg <mika.westerberg@linux.intel.com>

Applied to pci/hotplug for v4.16, thanks!

> ---
> The previous version (v4) of the patch can be found here:
> 
>   https://patchwork.kernel.org/patch/10026551/
> 
> Changes from v4:
> 
>   - Drop the check from shpchp_configure_device() as well
> 
>  drivers/pci/hotplug/pciehp_pci.c | 12 ------------
>  drivers/pci/hotplug/shpchp_pci.c | 12 ------------
>  2 files changed, 24 deletions(-)
> 
> diff --git a/drivers/pci/hotplug/pciehp_pci.c b/drivers/pci/hotplug/pciehp_pci.c
> index 2a1ca020cf5a..acc360d1a1fb 100644
> --- a/drivers/pci/hotplug/pciehp_pci.c
> +++ b/drivers/pci/hotplug/pciehp_pci.c
> @@ -79,7 +79,6 @@ int pciehp_configure_device(struct slot *p_slot)
>  int pciehp_unconfigure_device(struct slot *p_slot)
>  {
>  	int rc = 0;
> -	u8 bctl = 0;
>  	u8 presence = 0;
>  	struct pci_dev *dev, *temp;
>  	struct pci_bus *parent = p_slot->ctrl->pcie->port->subordinate;
> @@ -101,17 +100,6 @@ int pciehp_unconfigure_device(struct slot *p_slot)
>  	list_for_each_entry_safe_reverse(dev, temp, &parent->devices,
>  					 bus_list) {
>  		pci_dev_get(dev);
> -		if (dev->hdr_type == PCI_HEADER_TYPE_BRIDGE && presence) {
> -			pci_read_config_byte(dev, PCI_BRIDGE_CONTROL, &bctl);
> -			if (bctl & PCI_BRIDGE_CTL_VGA) {
> -				ctrl_err(ctrl,
> -					 "Cannot remove display device %s\n",
> -					 pci_name(dev));
> -				pci_dev_put(dev);
> -				rc = -EINVAL;
> -				break;
> -			}
> -		}
>  		if (!presence) {
>  			pci_dev_set_disconnected(dev, NULL);
>  			if (pci_has_subordinate(dev))
> diff --git a/drivers/pci/hotplug/shpchp_pci.c b/drivers/pci/hotplug/shpchp_pci.c
> index ea63db58b4b1..79f1682c858e 100644
> --- a/drivers/pci/hotplug/shpchp_pci.c
> +++ b/drivers/pci/hotplug/shpchp_pci.c
> @@ -78,7 +78,6 @@ int shpchp_configure_device(struct slot *p_slot)
>  int shpchp_unconfigure_device(struct slot *p_slot)
>  {
>  	int rc = 0;
> -	u8 bctl = 0;
>  	struct pci_bus *parent = p_slot->ctrl->pci_dev->subordinate;
>  	struct pci_dev *dev, *temp;
>  	struct controller *ctrl = p_slot->ctrl;
> @@ -93,17 +92,6 @@ int shpchp_unconfigure_device(struct slot *p_slot)
>  			continue;
>  
>  		pci_dev_get(dev);
> -		if (dev->hdr_type == PCI_HEADER_TYPE_BRIDGE) {
> -			pci_read_config_byte(dev, PCI_BRIDGE_CONTROL, &bctl);
> -			if (bctl & PCI_BRIDGE_CTL_VGA) {
> -				ctrl_err(ctrl,
> -					 "Cannot remove display device %s\n",
> -					 pci_name(dev));
> -				pci_dev_put(dev);
> -				rc = -EINVAL;
> -				break;
> -			}
> -		}
>  		pci_stop_and_remove_bus_device(dev);
>  		pci_dev_put(dev);
>  	}
> -- 
> 2.14.2
> 
