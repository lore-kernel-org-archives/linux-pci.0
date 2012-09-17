Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-lb0-f174.google.com ([209.85.217.174]:41379 "EHLO
	mail-lb0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932183Ab2IQXGZ (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Mon, 17 Sep 2012 19:06:25 -0400
Received: by lbbgj3 with SMTP id gj3so4579086lbb.19
        for <linux-pci@vger.kernel.org>; Mon, 17 Sep 2012 16:06:24 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <CAE9FiQUwFbeRG9Rqj0HC-Nu-HPwe0GJt22HSnaTHu5A0FV7-9Q@mail.gmail.com>
References: <1346622458-30595-2-git-send-email-yinghai@kernel.org>
 <1346942071-15188-1-git-send-email-prarit@redhat.com> <CAE9FiQUwFbeRG9Rqj0HC-Nu-HPwe0GJt22HSnaTHu5A0FV7-9Q@mail.gmail.com>
From: Bjorn Helgaas <bhelgaas@google.com>
Date: Mon, 17 Sep 2012 17:06:03 -0600
Message-ID: <CAErSpo5bg2miZ4qwLiXewDuURX5NhD5wNmPdfpKTtGF0z9OuzA@mail.gmail.com>
Subject: Re: [PATCH part1 1/4] PCI, pciehp: Turn on link again after power off
 the slot
To: Yinghai Lu <yinghai@kernel.org>
Cc: Prarit Bhargava <prarit@redhat.com>, linux-pci@vger.kernel.org,
	Kenji Kaneshige <kaneshige.kenji@jp.fujitsu.com>,
	stable@vger.kernel.org
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Thu, Sep 6, 2012 at 11:30 AM, Yinghai Lu <yinghai@kernel.org> wrote:
> On Thu, Sep 6, 2012 at 7:34 AM, Prarit Bhargava <prarit@redhat.com> wrote:
>> Signed-off-by: Yinghai Lu <yinghai@kernel.org>
>> Cc: Kenji Kaneshige <kaneshige.kenji@jp.fujitsu.com>
>> Cc: stable@vger.kernel.org
>>
>>>diff --git a/drivers/pci/hotplug/pciehp_hpc.c b/drivers/pci/hotplug/pciehp_hpc.c
>>>index 13b2eaf..7cee8db 100644
>>>--- a/drivers/pci/hotplug/pciehp_hpc.c
>>>+++ b/drivers/pci/hotplug/pciehp_hpc.c
>>>@@ -631,6 +631,8 @@ int pciehp_power_off_slot(struct slot * slot)
>>>       slot_cmd = POWER_OFF;
>>>       cmd_mask = PCI_EXP_SLTCTL_PCC;
>>>       retval = pcie_write_cmd(ctrl, slot_cmd, cmd_mask);
>>>+      /* need to enable link again for present bit report */
>>>+      pciehp_link_enable(ctrl);
>>
>> You're not checking the return value of pciehp_link_enable().  I wonder if
>> enabling the link is the only way to get the present bit to report correctly...
>
> that is silicon problem. and no one noticed that before.
>
>>
>> Also, should the pciehp_link_enable() be called in pciehp_power_on_slot() if
>> we already reenable it on the power off?
>
> we call that in pciehp_power_on_slot for another case:
> BIOS could have link disable on pcie slot if there is no card plugged
> in that slot.

So now we have two situations that should be the same, but they're not:

  1) Slot is empty at boot, and BIOS leaves link disabled.  Link
remains disabled until pciehp_power_on_slot() enables it.
  2) We hot-remove a card, so the slot is now empty, but
pciehp_power_off_slot() leaves the link enabled.  Link stays *enabled*
until another disable/enable sequence in pciehp_power_off_slot().

Why should these be different?  In both cases the slot is empty, but
in case 1 the link is disabled, while in case 2 it is enabled.  If we
can detect a hot-add in case 1, why can't we detect it after a
hot-remove even if the link is disabled?

Or maybe case 1 is broken on this box, and hot-add to that slot
doesn't work correctly either?
