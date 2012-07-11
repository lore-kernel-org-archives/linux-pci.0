Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-gg0-f202.google.com ([209.85.161.202]:44949 "EHLO
	mail-gg0-f202.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755957Ab2GKQVV (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Wed, 11 Jul 2012 12:21:21 -0400
Received: by ggeh3 with SMTP id h3so134849gge.1
        for <linux-pci@vger.kernel.org>; Wed, 11 Jul 2012 09:21:20 -0700 (PDT)
Date: Wed, 11 Jul 2012 10:21:20 -0600
From: Bjorn Helgaas <bhelgaas@google.com>
To: Yinghai Lu <yinghai@kernel.org>
Cc: linux-pci@vger.kernel.org,
	Kenji Kaneshige <kaneshige.kenji@jp.fujitsu.com>
Subject: Re: [PATCH 2/5] pciehp: Don't enable presence notification while
 surprise removal is not supported.
Message-ID: <20120711162120.GA17988@google.com>
References: <1340437325-29282-1-git-send-email-yinghai@kernel.org>
 <1340437325-29282-3-git-send-email-yinghai@kernel.org>
 <CAErSpo5K9EqAQSKA5_YdM2WThWddJr4XDbFHr84h_MPHvSqJmg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <CAErSpo5K9EqAQSKA5_YdM2WThWddJr4XDbFHr84h_MPHvSqJmg@mail.gmail.com>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Tue, Jul 10, 2012 at 04:56:15PM -0600, Bjorn Helgaas wrote:
> On Sat, Jun 23, 2012 at 1:42 AM, Yinghai Lu <yinghai@kernel.org> wrote:
> > If surprise removal is not supported, that event get dropped later.
> > So there is no point to enable that.
> >
> > Also some sick chipset have those bit flip around when the card is not present.
> > and make log full of useless warning.
> 
> HP_SUPR_RM tests the Slot Capabilities "Hot-Plug Surprise" bit, which
> indicates that an adapter might be *removed* without prior
> notification (sec 7.8.9).
> 
> PCI_EXP_SLTCTL_PDCE is the Slot Control "Presence Detect Changed
> Enable" bit, which enables interrupts for any change in the Slot
> Status "Presence Detect State", i.e., we may get interrupts for either
> add or remove events.
> 
> In interrupt_event_handler(), we drop both add and remove events if
> !HP_SUPR_RM().  Specifically, we drop *add* events if surprise
> *removal* isn't supported.  That seems strange -- just from reading
> the spec, it seems that a surprise *add* could occur even if the
> "Hot-Plug Surprise" bit is not set.
> 
> So I'm not convinced that we should even bother looking at the
> "Hot-Plug Surprise" bit...  Maybe we'd be better off if we just
> removed that HP_SUPR_RM() test in interrupt_event_handler() and always
> called handle_surprise_event().

What bad things would happen if we did the following?

I have no way to test this, but I don't understand what benefit
there is in testing HP_SUPR_RM() here.

diff --git a/drivers/pci/hotplug/pciehp_ctrl.c b/drivers/pci/hotplug/pciehp_ctrl.c
index 27f4429..4bbe257 100644
--- a/drivers/pci/hotplug/pciehp_ctrl.c
+++ b/drivers/pci/hotplug/pciehp_ctrl.c
@@ -463,9 +463,8 @@ static void interrupt_event_handler(struct work_struct *work)
 		break;
 	case INT_PRESENCE_ON:
 	case INT_PRESENCE_OFF:
-		if (!HP_SUPR_RM(ctrl))
-			break;
-		ctrl_dbg(ctrl, "Surprise Removal\n");
+		ctrl_dbg(ctrl, "Presence Detect changed (now %spresent)\n",
+			 info->event_type == INT_PRESENCE_OFF ? "not " : "");
 		handle_surprise_event(p_slot);
 		break;
 	default:
