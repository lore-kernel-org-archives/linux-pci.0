Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-lb0-f174.google.com ([209.85.217.174]:39933 "EHLO
	mail-lb0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754703Ab2GJW4h (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Tue, 10 Jul 2012 18:56:37 -0400
Received: by lbbgm6 with SMTP id gm6so1266324lbb.19
        for <linux-pci@vger.kernel.org>; Tue, 10 Jul 2012 15:56:35 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <1340437325-29282-3-git-send-email-yinghai@kernel.org>
References: <1340437325-29282-1-git-send-email-yinghai@kernel.org> <1340437325-29282-3-git-send-email-yinghai@kernel.org>
From: Bjorn Helgaas <bhelgaas@google.com>
Date: Tue, 10 Jul 2012 16:56:15 -0600
Message-ID: <CAErSpo5K9EqAQSKA5_YdM2WThWddJr4XDbFHr84h_MPHvSqJmg@mail.gmail.com>
Subject: Re: [PATCH 2/5] pciehp: Don't enable presence notification while
 surprise removal is not supported.
To: Yinghai Lu <yinghai@kernel.org>
Cc: linux-pci@vger.kernel.org,
	Kenji Kaneshige <kaneshige.kenji@jp.fujitsu.com>
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Sat, Jun 23, 2012 at 1:42 AM, Yinghai Lu <yinghai@kernel.org> wrote:
> If surprise removal is not supported, that event get dropped later.
> So there is no point to enable that.
>
> Also some sick chipset have those bit flip around when the card is not present.
> and make log full of useless warning.

HP_SUPR_RM tests the Slot Capabilities "Hot-Plug Surprise" bit, which
indicates that an adapter might be *removed* without prior
notification (sec 7.8.9).

PCI_EXP_SLTCTL_PDCE is the Slot Control "Presence Detect Changed
Enable" bit, which enables interrupts for any change in the Slot
Status "Presence Detect State", i.e., we may get interrupts for either
add or remove events.

In interrupt_event_handler(), we drop both add and remove events if
!HP_SUPR_RM().  Specifically, we drop *add* events if surprise
*removal* isn't supported.  That seems strange -- just from reading
the spec, it seems that a surprise *add* could occur even if the
"Hot-Plug Surprise" bit is not set.

So I'm not convinced that we should even bother looking at the
"Hot-Plug Surprise" bit...  Maybe we'd be better off if we just
removed that HP_SUPR_RM() test in interrupt_event_handler() and always
called handle_surprise_event().

> Signed-off-by: Yinghai Lu <yinghai@kernel.org>
> ---
>  drivers/pci/hotplug/pciehp_hpc.c |    5 +++--
>  1 files changed, 3 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/pci/hotplug/pciehp_hpc.c b/drivers/pci/hotplug/pciehp_hpc.c
> index a960fae..d4fa705 100644
> --- a/drivers/pci/hotplug/pciehp_hpc.c
> +++ b/drivers/pci/hotplug/pciehp_hpc.c
> @@ -808,7 +808,7 @@ int pciehp_get_cur_lnk_width(struct slot *slot,
>
>  int pcie_enable_notification(struct controller *ctrl)
>  {
> -       u16 cmd, mask;
> +       u16 cmd = 0, mask;
>
>         /*
>          * TBD: Power fault detected software notification support.
> @@ -820,7 +820,8 @@ int pcie_enable_notification(struct controller *ctrl)
>          * when it is cleared in the interrupt service routine, and
>          * next power fault detected interrupt was notified again.
>          */
> -       cmd = PCI_EXP_SLTCTL_PDCE;
> +       if (HP_SUPR_RM(ctrl))
> +               cmd |= PCI_EXP_SLTCTL_PDCE;
>         if (ATTN_BUTTN(ctrl))
>                 cmd |= PCI_EXP_SLTCTL_ABPE;
>         if (MRL_SENS(ctrl))
> --
> 1.7.7
>
