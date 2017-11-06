Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.99]:32972 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752548AbdKFXOQ (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Mon, 6 Nov 2017 18:14:16 -0500
Date: Mon, 6 Nov 2017 17:14:09 -0600
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
Subject: Re: [PATCH v4] PCI: pciehp: Drop checking of PCI_BRIDGE_CONTROL in
 pciehp_unconfigure_device()
Message-ID: <20171106231409.GI31930@bhelgaas-glaptop.roam.corp.google.com>
References: <20171025112940.77890-1-mika.westerberg@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20171025112940.77890-1-mika.westerberg@linux.intel.com>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Wed, Oct 25, 2017 at 02:29:40PM +0300, Mika Westerberg wrote:
> During surprise hot-unplug the device is not accessible anymore and
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
> set. In case of surprise hot-unplug, it would not even be possible to
> prevent the removal. It may be due to the fact that pciehp_pci.c pretty
> much copies similar implementation from shpchp_pci.c and this check was
> just left there in the code without further thinking if it is actually
> needed at all.
> 
> Given this and the issue described above, I think it makes sense to drop
> the whole PCI_BRIDGE_CONTROL check from pciehp_unconfigure_device()
> which is what this patch does.
> 
> Signed-off-by: Mika Westerberg <mika.westerberg@linux.intel.com>
> ---
> The previous version of the patch can be found here:
> 
>   https://patchwork.kernel.org/patch/10024145/
> 
> Changes from the previous version:
> 
>   * Drop the whole PCI_BRIDGE_CONTROL check
>   * Update patch subject to reflect that
> 
>  drivers/pci/hotplug/pciehp_pci.c | 12 ------------
>  1 file changed, 12 deletions(-)
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

As you mention, shpchp_unconfigure_device() contains the same code; is
there any reason not to remove it from there as well?

I know you probably can't test shpchp, and neither can I, but it looks
like it has the same issue, and I don't want to avoid fixing it there
just for want of testing.

I wish we knew more about why that PCI_BRIDGE_CTL_VGA check was there
in the first place.  I think it was added by Dely Sy in 2004 [1].
LinkedIn thinks he's still at Intel; any chance you could ping him and
see if he has any insight?  My guess is that it was originally in a
path that didn't have to worry about surprise unplug.  But I still
don't know why it would be a problem.

Bjorn

[1] https://git.kernel.org/pub/scm/linux/kernel/git/tglx/history.git/commit/?id=c16b4b14d980
