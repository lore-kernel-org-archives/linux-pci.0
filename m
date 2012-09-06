Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-pb0-f46.google.com ([209.85.160.46]:49415 "EHLO
	mail-pb0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932411Ab2IFRad (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Thu, 6 Sep 2012 13:30:33 -0400
MIME-Version: 1.0
In-Reply-To: <1346942071-15188-1-git-send-email-prarit@redhat.com>
References: <1346622458-30595-2-git-send-email-yinghai@kernel.org>
	<1346942071-15188-1-git-send-email-prarit@redhat.com>
Date: Thu, 6 Sep 2012 10:30:33 -0700
Message-ID: <CAE9FiQUwFbeRG9Rqj0HC-Nu-HPwe0GJt22HSnaTHu5A0FV7-9Q@mail.gmail.com>
Subject: Re: [PATCH part1 1/4] PCI, pciehp: Turn on link again after power off
 the slot
From: Yinghai Lu <yinghai@kernel.org>
To: Prarit Bhargava <prarit@redhat.com>
Cc: linux-pci@vger.kernel.org,
	Kenji Kaneshige <kaneshige.kenji@jp.fujitsu.com>,
	stable@vger.kernel.org
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Thu, Sep 6, 2012 at 7:34 AM, Prarit Bhargava <prarit@redhat.com> wrote:
> Signed-off-by: Yinghai Lu <yinghai@kernel.org>
> Cc: Kenji Kaneshige <kaneshige.kenji@jp.fujitsu.com>
> Cc: stable@vger.kernel.org
>
>>diff --git a/drivers/pci/hotplug/pciehp_hpc.c b/drivers/pci/hotplug/pciehp_hpc.c
>>index 13b2eaf..7cee8db 100644
>>--- a/drivers/pci/hotplug/pciehp_hpc.c
>>+++ b/drivers/pci/hotplug/pciehp_hpc.c
>>@@ -631,6 +631,8 @@ int pciehp_power_off_slot(struct slot * slot)
>>       slot_cmd = POWER_OFF;
>>       cmd_mask = PCI_EXP_SLTCTL_PCC;
>>       retval = pcie_write_cmd(ctrl, slot_cmd, cmd_mask);
>>+      /* need to enable link again for present bit report */
>>+      pciehp_link_enable(ctrl);
>
> You're not checking the return value of pciehp_link_enable().  I wonder if
> enabling the link is the only way to get the present bit to report correctly...

that is silicon problem. and no one noticed that before.

>
> Also, should the pciehp_link_enable() be called in pciehp_power_on_slot() if
> we already reenable it on the power off?

we call that in pciehp_power_on_slot for another case:
BIOS could have link disable on pcie slot if there is no card plugged
in that slot.

Thanks

Yinghai
