Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-vc0-f174.google.com ([209.85.220.174]:46461 "EHLO
	mail-vc0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754842Ab2GKU4X (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Wed, 11 Jul 2012 16:56:23 -0400
Received: by vcbf11 with SMTP id f11so1062003vcb.19
        for <linux-pci@vger.kernel.org>; Wed, 11 Jul 2012 13:56:22 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <CAErSpo6rEcu3gwScEDxJ7DXzeMpT4DBGgAyhNE9qpPo4wEMouw@mail.gmail.com>
References: <1340437325-29282-1-git-send-email-yinghai@kernel.org>
	<1340437325-29282-3-git-send-email-yinghai@kernel.org>
	<CAErSpo5K9EqAQSKA5_YdM2WThWddJr4XDbFHr84h_MPHvSqJmg@mail.gmail.com>
	<20120711162120.GA17988@google.com>
	<CAE9FiQUeJ3fyjamtxgx=_PeZC0Qdofx5ou8Gbg_ikSGTCbC06g@mail.gmail.com>
	<CAErSpo4nrhBg7SSknmtG=Ss+UGmUJthQ7EBuedNFdyV0PUQuxQ@mail.gmail.com>
	<CAE9FiQVbaYszsqq6WYENQu18a52m2fD9svtdFV2y4DeDnYWJcA@mail.gmail.com>
	<CAErSpo7f1hvQ2sg8TTu-d2dy1ST8xNEfR0odESihQtRh=KMi5A@mail.gmail.com>
	<CAE9FiQU3RbdnBssTT6tiGP9GjtyLHBbdaor2qF=26d8WLf72cw@mail.gmail.com>
	<CAErSpo6rEcu3gwScEDxJ7DXzeMpT4DBGgAyhNE9qpPo4wEMouw@mail.gmail.com>
Date: Wed, 11 Jul 2012 13:56:22 -0700
Message-ID: <CAE9FiQXTjEqLLGx=EzxoWNqKTPF+g4=PNMiiTLkdUyf0LX-JUg@mail.gmail.com>
Subject: Re: [PATCH 2/5] pciehp: Don't enable presence notification while
 surprise removal is not supported.
From: Yinghai Lu <yinghai@kernel.org>
To: Bjorn Helgaas <bhelgaas@google.com>
Cc: linux-pci@vger.kernel.org,
	Kenji Kaneshige <kaneshige.kenji@jp.fujitsu.com>
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Wed, Jul 11, 2012 at 1:48 PM, Bjorn Helgaas <bhelgaas@google.com> wrote:
>>
>> When hotplug surprise is supported, attention button may not there.
>> So have to use present bit to trigger the sequence online work, and
>> offline clean up work.
>
> Well, there is an "Attention Button Present" bit.  Why wouldn't we use
> that instead of trying to infer the button's presence from Hot-Plug
> Surprise?

so you want this ?

diff --git a/drivers/pci/hotplug/pciehp_ctrl.c
b/drivers/pci/hotplug/pciehp_ctrl.c
index 27f4429..f103a4ca 100644
--- a/drivers/pci/hotplug/pciehp_ctrl.c
+++ b/drivers/pci/hotplug/pciehp_ctrl.c
@@ -463,7 +463,7 @@ static void interrupt_event_handler(struct
work_struct *work)
                break;
        case INT_PRESENCE_ON:
        case INT_PRESENCE_OFF:
-               if (!HP_SUPR_RM(ctrl))
+               if (ATTN_BUTTN(ctrl))
                        break;
                ctrl_dbg(ctrl, "Surprise Removal\n");
                handle_surprise_event(p_slot);

that should keep current user expected behavior that kernel only bring
the card online after press the button.
