Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from esa6.dell-outbound.iphmx.com ([68.232.149.229]:15971 "EHLO
        esa6.dell-outbound.iphmx.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726867AbeG3XPD (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 30 Jul 2018 19:15:03 -0400
Cc: <mr.nuke.me@gmail.com>, <keith.busch@intel.com>,
        <linux-pci@vger.kernel.org>, <Austin.Bolen@dell.com>,
        <Stuart.Hayes@dell.com>, <Narendra.K@dell.com>,
        <Christopher.Arzola@dell.com>, <David.Chalfant@dell.com>,
        <okaya@kernel.org>
From: <Alex_Gagniuc@Dellteam.com>
To: <lukas@wunner.de>
Subject: Re: Should a PCIe Link Down event set the PCI_DEV_DISCONNECTED bit?
Date: Mon, 30 Jul 2018 21:38:04 +0000
Message-ID: <c9a2b3463fd04f3eb7725f985c569b03@ausx13mps321.AMER.DELL.COM>
References: <47727551-86ce-040a-2516-efa47ee3a76e@gmail.com>
 <20180727071813.GA6128@wunner.de>
 <f6aa0b881a824b4f82a29dad300aaaea@ausx13mps321.AMER.DELL.COM>
 <20180727170543.GA5326@wunner.de>
 <99604d46a7554eb38ee6c1579c53d835@ausx13mps321.AMER.DELL.COM>
 <20180728183130.GA21482@wunner.de>
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On 07/28/2018 01:31 PM, Lukas Wunner wrote:=0A=
> On Fri, Jul 27, 2018 at 05:51:04PM +0000, Alex_Gagniuc@Dellteam.com wrote=
:=0A=
>> I think PCI_DEV_DISCONNECTED is a documentation issue above all else.=0A=
>> The history I was given is that drivers would take a very long time to=
=0A=
>> tear down a device. Config space IO to an nonexistent device took a long=
=0A=
>> while to time out. Performance was one motivation -- and was not documen=
ted.=0A=
> =0A=
> Often it is possible for the driver to detect surprise removal by=0A=
> checking if mmio reads return "all ones".  But in some cases that's=0A=
> a valid value to read from mmio and then this approach won't work.=0A=
> Also, checking every mmio read may negatively impact performance.=0A=
=0A=
A colleague and me beat that dead horse to the afterdeath. Consensus was =
=0A=
that the return value is less reliable than a coin toss (of a two-heads =0A=
coin).=0A=
=0A=
> Finally, if the card was quickly swapped and the link to the new=0A=
> card is already up, you may be accessing that new card.  (mmio=0A=
> accesses may then still return all ones if the BARs are blank,=0A=
> but at least config space accesses should work.)=0A=
=0A=
I'm really not worried about this cases. Assuming that someone goes to =0A=
the effort to swap thing this fast, the IRQ would print an "already =0A=
getting powered down" message, or something of the sorts. It would be =0A=
plainly obvious to even the most casual dmesg observer.=0A=
=0A=
 From what I can tell, the hotplug code is well armed to handle such =0A=
races and resolve them automatically.=0A=
=0A=
> Once it has been determined that the device has been surprise removed,=0A=
> that fact should be cached somewhere to short-circuit any further device=
=0A=
> accesses.  PCI_DEV_DISCONNECTED can act as such a cache.=0A=
=0A=
I do insist that you spell SURPRISE!!! this way. :)=0A=
=0A=
>> Thanks for all the info. The fix that I was settling on is (pasted)=0A=
>> below. Though that seems to conflict a bit with what you are trying to=
=0A=
>> do. Now I'm a little conflicted If I should try to submit the below or n=
ot.=0A=
>>=0A=
>> --- a/drivers/pci/hotplug/pciehp_pci.c=0A=
>> +++ b/drivers/pci/hotplug/pciehp_pci.c=0A=
>> @@ -74,6 +74,7 @@ int pciehp_unconfigure_device(struct slot *p_slot)=0A=
>>           ctrl_dbg(ctrl, "%s: domain:bus:dev =3D %04x:%02x:00\n",=0A=
>>                    __func__, pci_domain_nr(parent), parent->number);=0A=
>>           pciehp_get_adapter_status(p_slot, &presence);=0A=
>> +       presence =3D presence && pciehp_check_link_active(ctrl);=0A=
> =0A=
> That approach won't work if the card was quickly swapped and the link=0A=
> to the new card is already up when pciehp_unconfigure_device() runs.=0A=
=0A=
You're right. We should use the PD/link status gathered at the time of =0A=
the interrupt.=0A=
=0A=
> FWIW, the below is what I had in mind (on top of Bjorn's pci/hotplug=0A=
> branch).  Does this work for you?=0A=
=0A=
This, and another patch (you have been CC'd) solve my problem of =0A=
crashing during surprise removal. Thanks!=0A=
=0A=
Alex=0A=
=0A=
> -- >8 --=0A=
> Subject: [PATCH] PCI: pciehp: Differentiate between surprise and safe rem=
oval=0A=
> =0A=
> When removing PCI devices below a hotplug bridge, pciehp marks them as=0A=
> disconnected if the card is no longer present in the slot or it quiesces=
=0A=
> them if the card is still present (by disabling INTx interrupts, bus=0A=
> mastering and SERR# reporting).=0A=
> =0A=
> To detect whether the card is still present, pciehp checks the Presence=
=0A=
> Detect State bit in the Slot Status register.  The problem with this=0A=
> approach is that even if the card is present, the link to it may be=0A=
> down, and it that case it would be better to mark the devices as=0A=
> disconnected instead of trying to quiesce them.  Moreover, if the card=0A=
> in the slot was quickly replaced by another one, the Presence Detect=0A=
> State bit would be set, yet trying to quiesce the new card's devices=0A=
> would be wrong and the correct thing to do is to mark the previous=0A=
> card's devices as disconnected.=0A=
> =0A=
> Instead of looking at the Presence Detect State bit, it is better to=0A=
> differentiate whether the card was surprise removed versus safely=0A=
> removed (via sysfs or an Attention Button press).  On surprise removal,=
=0A=
> the devices should be marked as disconnected, whereas on safe removal it=
=0A=
> is correct to quiesce the devices.=0A=
> =0A=
> The knowledge whether a surprise removal or a safe removal is at hand=0A=
> does exist further up in the call stack:  A surprise removal is=0A=
> initiated by pciehp_handle_presence_or_link_change(), a safe removal by=
=0A=
> pciehp_handle_disable_request().=0A=
> =0A=
> Pass that information down to pciehp_unconfigure_device() and use it in=
=0A=
> lieu of the Presence Detect State bit.  While there, add kernel-doc to=0A=
> pciehp_unconfigure_device() and pciehp_configure_device().=0A=
> =0A=
> Signed-off-by: Lukas Wunner <lukas@wunner.de>=0A=
> Cc: Alexandru Gagniuc <mr.nuke.me@gmail.com>=0A=
> ---=0A=
>   drivers/pci/hotplug/pciehp.h      |  2 +-=0A=
>   drivers/pci/hotplug/pciehp_ctrl.c | 22 +++++++++++++---------=0A=
>   drivers/pci/hotplug/pciehp_pci.c  | 23 ++++++++++++++++++++---=0A=
>   3 files changed, 34 insertions(+), 13 deletions(-)=0A=
> =0A=
> diff --git a/drivers/pci/hotplug/pciehp.h b/drivers/pci/hotplug/pciehp.h=
=0A=
> index 652c46d9b215..bce29ae769dd 100644=0A=
> --- a/drivers/pci/hotplug/pciehp.h=0A=
> +++ b/drivers/pci/hotplug/pciehp.h=0A=
> @@ -195,7 +195,7 @@ void pciehp_handle_button_press(struct slot *slot);=
=0A=
>   void pciehp_handle_disable_request(struct slot *slot);=0A=
>   void pciehp_handle_presence_or_link_change(struct slot *slot, u32 event=
s);=0A=
>   int pciehp_configure_device(struct slot *p_slot);=0A=
> -void pciehp_unconfigure_device(struct slot *p_slot);=0A=
> +void pciehp_unconfigure_device(struct slot *p_slot, bool presence);=0A=
>   void pciehp_queue_pushbutton_work(struct work_struct *work);=0A=
>   struct controller *pcie_init(struct pcie_device *dev);=0A=
>   int pcie_init_notification(struct controller *ctrl);=0A=
> diff --git a/drivers/pci/hotplug/pciehp_ctrl.c b/drivers/pci/hotplug/pcie=
hp_ctrl.c=0A=
> index d7d55160b5f8..8836648e145f 100644=0A=
> --- a/drivers/pci/hotplug/pciehp_ctrl.c=0A=
> +++ b/drivers/pci/hotplug/pciehp_ctrl.c=0A=
> @@ -40,6 +40,9 @@=0A=
>      hotplug controller logic=0A=
>    */=0A=
>   =0A=
> +#define SAFE_REMOVAL	 true=0A=
> +#define SURPRISE_REMOVAL false=0A=
> +=0A=
>   static void set_slot_off(struct controller *ctrl, struct slot *pslot)=
=0A=
>   {=0A=
>   	/* turn off slot, turn on Amber LED, turn off Green LED if supported*/=
=0A=
> @@ -115,12 +118,13 @@ static int board_added(struct slot *p_slot)=0A=
>   /**=0A=
>    * remove_board - Turns off slot and LEDs=0A=
>    * @p_slot: slot where board is being removed=0A=
> + * @safe_removal: whether the board is safely removed (versus surprise r=
emoved)=0A=
>    */=0A=
> -static void remove_board(struct slot *p_slot)=0A=
> +static void remove_board(struct slot *p_slot, bool safe_removal)=0A=
>   {=0A=
>   	struct controller *ctrl =3D p_slot->ctrl;=0A=
>   =0A=
> -	pciehp_unconfigure_device(p_slot);=0A=
> +	pciehp_unconfigure_device(p_slot, safe_removal);=0A=
>   =0A=
>   	if (POWER_CTRL(ctrl)) {=0A=
>   		pciehp_power_off_slot(p_slot);=0A=
> @@ -138,7 +142,7 @@ static void remove_board(struct slot *p_slot)=0A=
>   }=0A=
>   =0A=
>   static int pciehp_enable_slot(struct slot *slot);=0A=
> -static int pciehp_disable_slot(struct slot *slot);=0A=
> +static int pciehp_disable_slot(struct slot *slot, bool safe_removal);=0A=
>   =0A=
>   void pciehp_request(struct controller *ctrl, int action)=0A=
>   {=0A=
> @@ -230,7 +234,7 @@ void pciehp_handle_disable_request(struct slot *slot)=
=0A=
>   	slot->state =3D POWEROFF_STATE;=0A=
>   	mutex_unlock(&slot->lock);=0A=
>   =0A=
> -	ctrl->request_result =3D pciehp_disable_slot(slot);=0A=
> +	ctrl->request_result =3D pciehp_disable_slot(slot, SAFE_REMOVAL);=0A=
>   }=0A=
>   =0A=
>   void pciehp_handle_presence_or_link_change(struct slot *slot, u32 event=
s)=0A=
> @@ -257,7 +261,7 @@ void pciehp_handle_presence_or_link_change(struct slo=
t *slot, u32 events)=0A=
>   		if (events & PCI_EXP_SLTSTA_PDC)=0A=
>   			ctrl_info(ctrl, "Slot(%s): Card not present\n",=0A=
>   				  slot_name(slot));=0A=
> -		pciehp_disable_slot(slot);=0A=
> +		pciehp_disable_slot(slot, SURPRISE_REMOVAL);=0A=
>   		break;=0A=
>   	default:=0A=
>   		mutex_unlock(&slot->lock);=0A=
> @@ -343,7 +347,7 @@ static int pciehp_enable_slot(struct slot *slot)=0A=
>   	return ret;=0A=
>   }=0A=
>   =0A=
> -static int __pciehp_disable_slot(struct slot *p_slot)=0A=
> +static int __pciehp_disable_slot(struct slot *p_slot, bool safe_removal)=
=0A=
>   {=0A=
>   	u8 getstatus =3D 0;=0A=
>   	struct controller *ctrl =3D p_slot->ctrl;=0A=
> @@ -357,17 +361,17 @@ static int __pciehp_disable_slot(struct slot *p_slo=
t)=0A=
>   		}=0A=
>   	}=0A=
>   =0A=
> -	remove_board(p_slot);=0A=
> +	remove_board(p_slot, safe_removal);=0A=
>   	return 0;=0A=
>   }=0A=
>   =0A=
> -static int pciehp_disable_slot(struct slot *slot)=0A=
> +static int pciehp_disable_slot(struct slot *slot, bool safe_removal)=0A=
>   {=0A=
>   	struct controller *ctrl =3D slot->ctrl;=0A=
>   	int ret;=0A=
>   =0A=
>   	pm_runtime_get_sync(&ctrl->pcie->port->dev);=0A=
> -	ret =3D __pciehp_disable_slot(slot);=0A=
> +	ret =3D __pciehp_disable_slot(slot, safe_removal);=0A=
>   	pm_runtime_put(&ctrl->pcie->port->dev);=0A=
>   =0A=
>   	mutex_lock(&slot->lock);=0A=
> diff --git a/drivers/pci/hotplug/pciehp_pci.c b/drivers/pci/hotplug/pcieh=
p_pci.c=0A=
> index ec3f065bb1c0..079aac163484 100644=0A=
> --- a/drivers/pci/hotplug/pciehp_pci.c=0A=
> +++ b/drivers/pci/hotplug/pciehp_pci.c=0A=
> @@ -34,6 +34,14 @@=0A=
>   #include "../pci.h"=0A=
>   #include "pciehp.h"=0A=
>   =0A=
> +/**=0A=
> + * pciehp_configure_device() - enumerate PCI devices below a hotplug bri=
dge=0A=
> + * @p_slot: PCIe hotplug slot=0A=
> + *=0A=
> + * Enumerate PCI devices below a hotplug bridge and add them to the syst=
em.=0A=
> + * Return 0 on success, %-EEXIST if the devices are already enumerated o=
r=0A=
> + * %-ENODEV if enumeration failed.=0A=
> + */=0A=
>   int pciehp_configure_device(struct slot *p_slot)=0A=
>   {=0A=
>   	struct pci_dev *dev;=0A=
> @@ -76,9 +84,19 @@ int pciehp_configure_device(struct slot *p_slot)=0A=
>   	return ret;=0A=
>   }=0A=
>   =0A=
> -void pciehp_unconfigure_device(struct slot *p_slot)=0A=
> +/**=0A=
> + * pciehp_unconfigure_device() - remove PCI devices below a hotplug brid=
ge=0A=
> + * @p_slot: PCIe hotplug slot=0A=
> + * @presence: whether the card is still present in the slot;=0A=
> + *	true for safe removal via sysfs or an Attention Button press,=0A=
> + *	false for surprise removal=0A=
> + *=0A=
> + * Unbind PCI devices below a hotplug bridge from their drivers and remo=
ve=0A=
> + * them from the system.  Safely removed devices are quiesced.  Surprise=
=0A=
> + * removed devices are marked as such to prevent further accesses.=0A=
> + */=0A=
> +void pciehp_unconfigure_device(struct slot *p_slot, bool presence)=0A=
>   {=0A=
> -	u8 presence =3D 0;=0A=
>   	struct pci_dev *dev, *temp;=0A=
>   	struct pci_bus *parent =3D p_slot->ctrl->pcie->port->subordinate;=0A=
>   	u16 command;=0A=
> @@ -86,7 +104,6 @@ void pciehp_unconfigure_device(struct slot *p_slot)=0A=
>   =0A=
>   	ctrl_dbg(ctrl, "%s: domain:bus:dev =3D %04x:%02x:00\n",=0A=
>   		 __func__, pci_domain_nr(parent), parent->number);=0A=
> -	pciehp_get_adapter_status(p_slot, &presence);=0A=
>   =0A=
>   	pci_lock_rescan_remove();=0A=
>   =0A=
> =0A=
=0A=
