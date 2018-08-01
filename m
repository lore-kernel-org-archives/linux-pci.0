Return-Path: <SRS0=YUos=KQ=linux.intel.com=mika.westerberg@kernel.org>
Return-Path: <SRS0=YUos=KQ=linux.intel.com=mika.westerberg@kernel.org>
Date: Wed, 1 Aug 2018 19:43:58 +0300
From: Mika Westerberg <mika.westerberg@linux.intel.com>
To: Lukas Wunner <lukas@wunner.de>
Cc: Bjorn Helgaas <helgaas@kernel.org>, Ashok Raj <ashok.raj@intel.com>,
	Keith Busch <keith.busch@intel.com>,
	Yinghai Lu <yinghai@kernel.org>, Sinan Kaya <okaya@kernel.org>,
	linux-pci@vger.kernel.org, Alexandru Gagniuc <mr.nuke.me@gmail.com>
Subject: Re: [PATCH] PCI: pciehp: Differentiate between surprise and safe
 removal
Message-ID: <20180801164358.GI2534@lahna.fi.intel.com>
References: <dac488604766f3dcb948e702210ecc381c4f907b.1533015755.git.lukas@wunner.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <dac488604766f3dcb948e702210ecc381c4f907b.1533015755.git.lukas@wunner.de>
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

Below we turn off power to the slot if it has power controller. Even if
we disable slot from sysfs, I think it ends up being inaccessible after
power is turned off. I wonder if we should mark the devices disconnected
in that case as well?

>  
>  	if (POWER_CTRL(ctrl)) {
>  		pciehp_power_off_slot(p_slot);
