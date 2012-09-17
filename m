Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-ie0-f174.google.com ([209.85.223.174]:35597 "EHLO
	mail-ie0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757507Ab2IQXxB (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Mon, 17 Sep 2012 19:53:01 -0400
Received: by ieak13 with SMTP id k13so1364423iea.19
        for <linux-pci@vger.kernel.org>; Mon, 17 Sep 2012 16:53:00 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <CAE9FiQXW4GcKwt0d2S1qGLCQk86X0j7_xSTrGD7Sy5h3-rUWHw@mail.gmail.com>
References: <1346622458-30595-2-git-send-email-yinghai@kernel.org>
 <1346942071-15188-1-git-send-email-prarit@redhat.com> <CAE9FiQUwFbeRG9Rqj0HC-Nu-HPwe0GJt22HSnaTHu5A0FV7-9Q@mail.gmail.com>
 <CAErSpo5bg2miZ4qwLiXewDuURX5NhD5wNmPdfpKTtGF0z9OuzA@mail.gmail.com> <CAE9FiQXW4GcKwt0d2S1qGLCQk86X0j7_xSTrGD7Sy5h3-rUWHw@mail.gmail.com>
From: Bjorn Helgaas <bhelgaas@google.com>
Date: Mon, 17 Sep 2012 17:52:40 -0600
Message-ID: <CAErSpo7czA3C_yQcX_ntCMGEYLUHdbJysNFwTWY=QZ=bD9OpmA@mail.gmail.com>
Subject: Re: [PATCH part1 1/4] PCI, pciehp: Turn on link again after power off
 the slot
To: Yinghai Lu <yinghai@kernel.org>
Cc: Prarit Bhargava <prarit@redhat.com>, linux-pci@vger.kernel.org,
	Kenji Kaneshige <kaneshige.kenji@jp.fujitsu.com>,
	stable@vger.kernel.org
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Mon, Sep 17, 2012 at 5:25 PM, Yinghai Lu <yinghai@kernel.org> wrote:
> On Mon, Sep 17, 2012 at 4:06 PM, Bjorn Helgaas <bhelgaas@google.com> wrote:
>>
>> So now we have two situations that should be the same, but they're not:
>>
>>   1) Slot is empty at boot, and BIOS leaves link disabled.  Link
>> remains disabled until pciehp_power_on_slot() enables it.
>>   2) We hot-remove a card, so the slot is now empty, but
>> pciehp_power_off_slot() leaves the link enabled.  Link stays *enabled*
>> until another disable/enable sequence in pciehp_power_off_slot().
>>
>> Why should these be different?  In both cases the slot is empty, but
>> in case 1 the link is disabled, while in case 2 it is enabled.  If we
>> can detect a hot-add in case 1, why can't we detect it after a
>> hot-remove even if the link is disabled?
>
> silicon problem. assume that case is not well tested.
>
> we filed the bug to vendor, and they can not explain that so far.
> system hotplug fpga report correct present status to the chipset.
> looks like the silicon get confused somehow.
>
>>
>> Or maybe case 1 is broken on this box, and hot-add to that slot
>> doesn't work correctly either?
>
> works. with and without this patch.

This patch is just black magic then.  I don't want to intentionally
treat a slot that's empty at boot differently than one that is empty
after a hot-remove.
