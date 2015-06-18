Return-Path: <linux-kernel-owner@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <20150618161258.32739.29646.stgit@bhelgaas-glaptop2.roam.corp.google.com>
References: <20150618161207.32739.62577.stgit@bhelgaas-glaptop2.roam.corp.google.com>
	<20150618161258.32739.29646.stgit@bhelgaas-glaptop2.roam.corp.google.com>
Date: Thu, 18 Jun 2015 11:02:39 -0700
Message-ID: <CACK8Z6Gw3dM1a+kmyBbs1i7FJW-uvfE7NAGLir+ku1ExK9+Qfg@mail.gmail.com>
Subject: Re: [PATCH 4/4] PCI: pciehp: Inline the "handle event" functions into
 the ISR
From: Rajat Jain <rajatja@google.com>
To: Bjorn Helgaas <bhelgaas@google.com>
Cc: linux-pci@vger.kernel.org, Yinghai Lu <yinghai@kernel.org>,
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset=UTF-8
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Ok to add:
Reviewed-by: Rajat Jain <rajatja@google.com>

On Thu, Jun 18, 2015 at 9:12 AM, Bjorn Helgaas <bhelgaas@google.com> wrote:
> The pciehp_handle_*() functions (pciehp_handle_attention_button(), etc.)
> only contain a line or two of useful code, so it's clumsy to put
> them in separate functions.  All they so is add an event to a work queue,
> and it's clearer to see that directly in the ISR.
>
> Inline them directly into pcie_isr().  No functional change.
>
> Signed-off-by: Bjorn Helgaas <bhelgaas@google.com>
> ---
>  drivers/pci/hotplug/pciehp.h      |    6 --
>  drivers/pci/hotplug/pciehp_ctrl.c |  105 -------------------------------------
>  drivers/pci/hotplug/pciehp_hpc.c  |   39 +++++++++++---
>  3 files changed, 32 insertions(+), 118 deletions(-)
>
> diff --git a/drivers/pci/hotplug/pciehp.h b/drivers/pci/hotplug/pciehp.h
> index ce4d12c..57cd132 100644
> --- a/drivers/pci/hotplug/pciehp.h
> +++ b/drivers/pci/hotplug/pciehp.h
> @@ -132,11 +132,7 @@ struct controller {
>
>  int pciehp_sysfs_enable_slot(struct slot *slot);
>  int pciehp_sysfs_disable_slot(struct slot *slot);
> -u8 pciehp_handle_attention_button(struct slot *p_slot);
> -u8 pciehp_handle_switch_change(struct slot *p_slot);
> -u8 pciehp_handle_presence_change(struct slot *p_slot);
> -u8 pciehp_handle_power_fault(struct slot *p_slot);
> -void pciehp_handle_linkstate_change(struct slot *p_slot);
> +void pciehp_queue_interrupt_event(struct slot *slot, u32 event_type);
>  int pciehp_configure_device(struct slot *p_slot);
>  int pciehp_unconfigure_device(struct slot *p_slot);
>  void pciehp_queue_pushbutton_work(struct work_struct *work);
> diff --git a/drivers/pci/hotplug/pciehp_ctrl.c b/drivers/pci/hotplug/pciehp_ctrl.c
> index 7ed37dc..f379612 100644
> --- a/drivers/pci/hotplug/pciehp_ctrl.c
> +++ b/drivers/pci/hotplug/pciehp_ctrl.c
> @@ -37,7 +37,7 @@
>
>  static void interrupt_event_handler(struct work_struct *work);
>
> -static void pciehp_queue_interrupt_event(struct slot *p_slot, u32 event_type)
> +void pciehp_queue_interrupt_event(struct slot *p_slot, u32 event_type)
>  {
>         struct event_info *info;
>
> @@ -53,109 +53,6 @@ static void pciehp_queue_interrupt_event(struct slot *p_slot, u32 event_type)
>         queue_work(p_slot->wq, &info->work);
>  }
>
> -u8 pciehp_handle_attention_button(struct slot *p_slot)
> -{
> -       u32 event_type;
> -       struct controller *ctrl = p_slot->ctrl;
> -
> -       /*
> -        *  Button pressed - See if need to TAKE ACTION!!!
> -        */
> -       ctrl_info(ctrl, "Button pressed on Slot(%s)\n", slot_name(p_slot));
> -       event_type = INT_BUTTON_PRESS;
> -
> -       pciehp_queue_interrupt_event(p_slot, event_type);
> -
> -       return 0;
> -}
> -
> -u8 pciehp_handle_switch_change(struct slot *p_slot)
> -{
> -       u8 getstatus;
> -       u32 event_type;
> -       struct controller *ctrl = p_slot->ctrl;
> -
> -       pciehp_get_latch_status(p_slot, &getstatus);
> -       if (getstatus) {
> -               /*
> -                * Switch opened
> -                */
> -               ctrl_info(ctrl, "Latch open on Slot(%s)\n", slot_name(p_slot));
> -               event_type = INT_SWITCH_OPEN;
> -       } else {
> -               /*
> -                *  Switch closed
> -                */
> -               ctrl_info(ctrl, "Latch close on Slot(%s)\n", slot_name(p_slot));
> -               event_type = INT_SWITCH_CLOSE;
> -       }
> -
> -       pciehp_queue_interrupt_event(p_slot, event_type);
> -
> -       return 1;
> -}
> -
> -u8 pciehp_handle_presence_change(struct slot *p_slot)
> -{
> -       u32 event_type;
> -       u8 presence_save;
> -       struct controller *ctrl = p_slot->ctrl;
> -
> -       /* Switch is open, assume a presence change
> -        * Save the presence state
> -        */
> -       pciehp_get_adapter_status(p_slot, &presence_save);
> -       if (presence_save) {
> -               /*
> -                * Card Present
> -                */
> -               ctrl_info(ctrl, "Card present on Slot(%s)\n", slot_name(p_slot));
> -               event_type = INT_PRESENCE_ON;
> -       } else {
> -               /*
> -                * Not Present
> -                */
> -               ctrl_info(ctrl, "Card not present on Slot(%s)\n",
> -                         slot_name(p_slot));
> -               event_type = INT_PRESENCE_OFF;
> -       }
> -
> -       pciehp_queue_interrupt_event(p_slot, event_type);
> -
> -       return 1;
> -}
> -
> -u8 pciehp_handle_power_fault(struct slot *p_slot)
> -{
> -       u32 event_type;
> -       struct controller *ctrl = p_slot->ctrl;
> -
> -       ctrl_err(ctrl, "Power fault on slot %s\n", slot_name(p_slot));
> -       event_type = INT_POWER_FAULT;
> -       ctrl_info(ctrl, "Power fault bit %x set\n", 0);
> -       pciehp_queue_interrupt_event(p_slot, event_type);
> -
> -       return 1;
> -}
> -
> -void pciehp_handle_linkstate_change(struct slot *p_slot)
> -{
> -       u32 event_type;
> -       struct controller *ctrl = p_slot->ctrl;
> -
> -       if (pciehp_check_link_active(ctrl)) {
> -               ctrl_info(ctrl, "slot(%s): Link Up event\n",
> -                         slot_name(p_slot));
> -               event_type = INT_LINK_UP;
> -       } else {
> -               ctrl_info(ctrl, "slot(%s): Link Down event\n",
> -                         slot_name(p_slot));
> -               event_type = INT_LINK_DOWN;
> -       }
> -
> -       pciehp_queue_interrupt_event(p_slot, event_type);
> -}
> -
>  /* The following routines constitute the bulk of the
>     hotplug controller logic
>   */
> diff --git a/drivers/pci/hotplug/pciehp_hpc.c b/drivers/pci/hotplug/pciehp_hpc.c
> index e9daaa3..2913f7e 100644
> --- a/drivers/pci/hotplug/pciehp_hpc.c
> +++ b/drivers/pci/hotplug/pciehp_hpc.c
> @@ -535,6 +535,8 @@ static irqreturn_t pcie_isr(int irq, void *dev_id)
>         struct pci_dev *dev;
>         struct slot *slot = ctrl->slot;
>         u16 detected, intr_loc;
> +       u8 open, present;
> +       bool link;
>
>         /*
>          * In order to guarantee that all interrupt events are
> @@ -580,25 +582,44 @@ static irqreturn_t pcie_isr(int irq, void *dev_id)
>                 return IRQ_HANDLED;
>
>         /* Check MRL Sensor Changed */
> -       if (intr_loc & PCI_EXP_SLTSTA_MRLSC)
> -               pciehp_handle_switch_change(slot);
> +       if (intr_loc & PCI_EXP_SLTSTA_MRLSC) {
> +               pciehp_get_latch_status(slot, &open);
> +               ctrl_info(ctrl, "Latch %s on Slot(%s)\n",
> +                         open ? "open" : "close", slot_name(slot));
> +               pciehp_queue_interrupt_event(slot, open ? INT_SWITCH_OPEN :
> +                                            INT_SWITCH_CLOSE);
> +       }
>
>         /* Check Attention Button Pressed */
> -       if (intr_loc & PCI_EXP_SLTSTA_ABP)
> -               pciehp_handle_attention_button(slot);
> +       if (intr_loc & PCI_EXP_SLTSTA_ABP) {
> +               ctrl_info(ctrl, "Button pressed on Slot(%s)\n",
> +                         slot_name(slot));
> +               pciehp_queue_interrupt_event(slot, INT_BUTTON_PRESS);
> +       }
>
>         /* Check Presence Detect Changed */
> -       if (intr_loc & PCI_EXP_SLTSTA_PDC)
> -               pciehp_handle_presence_change(slot);
> +       if (intr_loc & PCI_EXP_SLTSTA_PDC) {
> +               pciehp_get_adapter_status(slot, &present);
> +               ctrl_info(ctrl, "Card %spresent on Slot(%s)\n",
> +                         present ? "" : "not ", slot_name(slot));
> +               pciehp_queue_interrupt_event(slot, present ? INT_PRESENCE_ON :
> +                                            INT_PRESENCE_OFF);
> +       }
>
>         /* Check Power Fault Detected */
>         if ((intr_loc & PCI_EXP_SLTSTA_PFD) && !ctrl->power_fault_detected) {
>                 ctrl->power_fault_detected = 1;
> -               pciehp_handle_power_fault(slot);
> +               ctrl_err(ctrl, "Power fault on slot %s\n", slot_name(slot));
> +               pciehp_queue_interrupt_event(slot, INT_POWER_FAULT);
>         }
>
> -       if (intr_loc & PCI_EXP_SLTSTA_DLLSC)
> -               pciehp_handle_linkstate_change(slot);
> +       if (intr_loc & PCI_EXP_SLTSTA_DLLSC) {
> +               link = pciehp_check_link_active(ctrl);
> +               ctrl_info(ctrl, "slot(%s): Link %s event\n",
> +                         slot_name(slot), link ? "Up" : "Down");
> +               pciehp_queue_interrupt_event(slot, link ? INT_LINK_UP :
> +                                            INT_LINK_DOWN);
> +       }
>
>         return IRQ_HANDLED;
>  }
>
