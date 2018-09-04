Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.99]:37938 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726304AbeIDWT7 (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Tue, 4 Sep 2018 18:19:59 -0400
Date: Tue, 4 Sep 2018 12:53:48 -0500
From: Bjorn Helgaas <helgaas@kernel.org>
To: Lukas Wunner <lukas@wunner.de>
Cc: Mika Westerberg <mika.westerberg@linux.intel.com>,
        Ashok Raj <ashok.raj@intel.com>,
        Keith Busch <keith.busch@intel.com>,
        Yinghai Lu <yinghai@kernel.org>, Sinan Kaya <okaya@kernel.org>,
        linux-pci@vger.kernel.org, Alexandru Gagniuc <mr.nuke.me@gmail.com>
Subject: Re: [PATCH] PCI: pciehp: Differentiate between surprise and safe
 removal
Message-ID: <20180904175348.GF107892@bhelgaas-glaptop.roam.corp.google.com>
References: <dac488604766f3dcb948e702210ecc381c4f907b.1533015755.git.lukas@wunner.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <dac488604766f3dcb948e702210ecc381c4f907b.1533015755.git.lukas@wunner.de>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Tue, Jul 31, 2018 at 07:50:37AM +0200, Lukas Wunner wrote:
> When removing PCI devices below a hotplug bridge, pciehp marks them as
> disconnected if the card is no longer present in the slot or it quiesces
> them if the card is still present (by disabling INTx interrupts, bus
> mastering and SERR# reporting).
> 
> To detect whether the card is still present, pciehp checks the Presence
> Detect State bit in the Slot Status register.  The problem with this
> approach is that even if the card is present, the link to it may be
> down, and it that case it would be better to mark the devices as
> disconnected instead of trying to quiesce them.  Moreover, if the card
> in the slot was quickly replaced by another one, the Presence Detect
> State bit would be set, yet trying to quiesce the new card's devices
> would be wrong and the correct thing to do is to mark the previous
> card's devices as disconnected.
> 
> Instead of looking at the Presence Detect State bit, it is better to
> differentiate whether the card was surprise removed versus safely
> removed (via sysfs or an Attention Button press).  On surprise removal,
> the devices should be marked as disconnected, whereas on safe removal it
> is correct to quiesce the devices.
> 
> The knowledge whether a surprise removal or a safe removal is at hand
> does exist further up in the call stack:  A surprise removal is
> initiated by pciehp_handle_presence_or_link_change(), a safe removal by
> pciehp_handle_disable_request().
> 
> Pass that information down to pciehp_unconfigure_device() and use it in
> lieu of the Presence Detect State bit.  While there, add kernel-doc to
> pciehp_unconfigure_device() and pciehp_configure_device().
> 
> Tested-by: Alexandru Gagniuc <mr.nuke.me@gmail.com>
> Signed-off-by: Lukas Wunner <lukas@wunner.de>
> Cc: Keith Busch <keith.busch@intel.com>

Applied to pci/hotplug for v4.20, thanks!

> ---
>  drivers/pci/hotplug/pciehp.h      |  2 +-
>  drivers/pci/hotplug/pciehp_ctrl.c | 22 +++++++++++++---------
>  drivers/pci/hotplug/pciehp_pci.c  | 23 ++++++++++++++++++++---
>  3 files changed, 34 insertions(+), 13 deletions(-)
> 
> diff --git a/drivers/pci/hotplug/pciehp.h b/drivers/pci/hotplug/pciehp.h
> index 811cf83f956d..39c9c8815a35 100644
> --- a/drivers/pci/hotplug/pciehp.h
> +++ b/drivers/pci/hotplug/pciehp.h
> @@ -181,7 +181,7 @@ void pciehp_handle_button_press(struct slot *slot);
>  void pciehp_handle_disable_request(struct slot *slot);
>  void pciehp_handle_presence_or_link_change(struct slot *slot, u32 events);
>  int pciehp_configure_device(struct slot *p_slot);
> -void pciehp_unconfigure_device(struct slot *p_slot);
> +void pciehp_unconfigure_device(struct slot *p_slot, bool presence);
>  void pciehp_queue_pushbutton_work(struct work_struct *work);
>  struct controller *pcie_init(struct pcie_device *dev);
>  int pcie_init_notification(struct controller *ctrl);
> diff --git a/drivers/pci/hotplug/pciehp_ctrl.c b/drivers/pci/hotplug/pciehp_ctrl.c
> index 6855933ab372..7932e70e9f29 100644
> --- a/drivers/pci/hotplug/pciehp_ctrl.c
> +++ b/drivers/pci/hotplug/pciehp_ctrl.c
> @@ -26,6 +26,9 @@
>     hotplug controller logic
>   */
>  
> +#define SAFE_REMOVAL	 true
> +#define SURPRISE_REMOVAL false
> +
>  static void set_slot_off(struct controller *ctrl, struct slot *pslot)
>  {
>  	/* turn off slot, turn on Amber LED, turn off Green LED if supported*/
> @@ -101,12 +104,13 @@ static int board_added(struct slot *p_slot)
>  /**
>   * remove_board - Turns off slot and LEDs
>   * @p_slot: slot where board is being removed
> + * @safe_removal: whether the board is safely removed (versus surprise removed)
>   */
> -static void remove_board(struct slot *p_slot)
> +static void remove_board(struct slot *p_slot, bool safe_removal)
>  {
>  	struct controller *ctrl = p_slot->ctrl;
>  
> -	pciehp_unconfigure_device(p_slot);
> +	pciehp_unconfigure_device(p_slot, safe_removal);
>  
>  	if (POWER_CTRL(ctrl)) {
>  		pciehp_power_off_slot(p_slot);
> @@ -124,7 +128,7 @@ static void remove_board(struct slot *p_slot)
>  }
>  
>  static int pciehp_enable_slot(struct slot *slot);
> -static int pciehp_disable_slot(struct slot *slot);
> +static int pciehp_disable_slot(struct slot *slot, bool safe_removal);
>  
>  void pciehp_request(struct controller *ctrl, int action)
>  {
> @@ -215,7 +219,7 @@ void pciehp_handle_disable_request(struct slot *slot)
>  	slot->state = POWEROFF_STATE;
>  	mutex_unlock(&slot->lock);
>  
> -	ctrl->request_result = pciehp_disable_slot(slot);
> +	ctrl->request_result = pciehp_disable_slot(slot, SAFE_REMOVAL);
>  }
>  
>  void pciehp_handle_presence_or_link_change(struct slot *slot, u32 events)
> @@ -241,7 +245,7 @@ void pciehp_handle_presence_or_link_change(struct slot *slot, u32 events)
>  		if (events & PCI_EXP_SLTSTA_PDC)
>  			ctrl_info(ctrl, "Slot(%s): Card not present\n",
>  				  slot_name(slot));
> -		pciehp_disable_slot(slot);
> +		pciehp_disable_slot(slot, SURPRISE_REMOVAL);
>  		break;
>  	default:
>  		mutex_unlock(&slot->lock);
> @@ -324,7 +328,7 @@ static int pciehp_enable_slot(struct slot *slot)
>  	return ret;
>  }
>  
> -static int __pciehp_disable_slot(struct slot *p_slot)
> +static int __pciehp_disable_slot(struct slot *p_slot, bool safe_removal)
>  {
>  	u8 getstatus = 0;
>  	struct controller *ctrl = p_slot->ctrl;
> @@ -338,17 +342,17 @@ static int __pciehp_disable_slot(struct slot *p_slot)
>  		}
>  	}
>  
> -	remove_board(p_slot);
> +	remove_board(p_slot, safe_removal);
>  	return 0;
>  }
>  
> -static int pciehp_disable_slot(struct slot *slot)
> +static int pciehp_disable_slot(struct slot *slot, bool safe_removal)
>  {
>  	struct controller *ctrl = slot->ctrl;
>  	int ret;
>  
>  	pm_runtime_get_sync(&ctrl->pcie->port->dev);
> -	ret = __pciehp_disable_slot(slot);
> +	ret = __pciehp_disable_slot(slot, safe_removal);
>  	pm_runtime_put(&ctrl->pcie->port->dev);
>  
>  	mutex_lock(&slot->lock);
> diff --git a/drivers/pci/hotplug/pciehp_pci.c b/drivers/pci/hotplug/pciehp_pci.c
> index 5c58c22e0c08..18f83e554c73 100644
> --- a/drivers/pci/hotplug/pciehp_pci.c
> +++ b/drivers/pci/hotplug/pciehp_pci.c
> @@ -20,6 +20,14 @@
>  #include "../pci.h"
>  #include "pciehp.h"
>  
> +/**
> + * pciehp_configure_device() - enumerate PCI devices below a hotplug bridge
> + * @p_slot: PCIe hotplug slot
> + *
> + * Enumerate PCI devices below a hotplug bridge and add them to the system.
> + * Return 0 on success, %-EEXIST if the devices are already enumerated or
> + * %-ENODEV if enumeration failed.
> + */
>  int pciehp_configure_device(struct slot *p_slot)
>  {
>  	struct pci_dev *dev;
> @@ -62,9 +70,19 @@ int pciehp_configure_device(struct slot *p_slot)
>  	return ret;
>  }
>  
> -void pciehp_unconfigure_device(struct slot *p_slot)
> +/**
> + * pciehp_unconfigure_device() - remove PCI devices below a hotplug bridge
> + * @p_slot: PCIe hotplug slot
> + * @presence: whether the card is still present in the slot;
> + *	true for safe removal via sysfs or an Attention Button press,
> + *	false for surprise removal
> + *
> + * Unbind PCI devices below a hotplug bridge from their drivers and remove
> + * them from the system.  Safely removed devices are quiesced.  Surprise
> + * removed devices are marked as such to prevent further accesses.
> + */
> +void pciehp_unconfigure_device(struct slot *p_slot, bool presence)
>  {
> -	u8 presence = 0;
>  	struct pci_dev *dev, *temp;
>  	struct pci_bus *parent = p_slot->ctrl->pcie->port->subordinate;
>  	u16 command;
> @@ -72,7 +90,6 @@ void pciehp_unconfigure_device(struct slot *p_slot)
>  
>  	ctrl_dbg(ctrl, "%s: domain:bus:dev = %04x:%02x:00\n",
>  		 __func__, pci_domain_nr(parent), parent->number);
> -	pciehp_get_adapter_status(p_slot, &presence);
>  
>  	pci_lock_rescan_remove();
>  
> -- 
> 2.18.0
> 
