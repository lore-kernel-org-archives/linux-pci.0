Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-bk0-f46.google.com ([209.85.214.46]:45695 "EHLO
	mail-bk0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1759345Ab2DYW05 convert rfc822-to-8bit (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Wed, 25 Apr 2012 18:26:57 -0400
MIME-Version: 1.0
In-Reply-To: <CAErSpo46AzF9aifaMyDbCe2dXwfdvE68mgWwiUrxnzoTyKJktg@mail.gmail.com>
References: <CAD52pS-CJBSz3EhFf4Mt3=o8=-3soa-b=XjDjdra=BP=M-4RLw@mail.gmail.com>
	<Pine.LNX.4.44L0.1204111531170.1351-100000@iolanthe.rowland.org>
	<CAErSpo46AzF9aifaMyDbCe2dXwfdvE68mgWwiUrxnzoTyKJktg@mail.gmail.com>
Date: Thu, 26 Apr 2012 01:26:55 +0300
Message-ID: <CAD52pS815u61dfPnTJuGPED+Rvspn4CyHfzLZFVd5u2uy_afeg@mail.gmail.com>
Subject: Re: PROBLEM: OHCI HCD - computer freezes during boot
From: Calin Demian <c.demian20@gmail.com>
To: Bjorn Helgaas <bhelgaas@google.com>
Cc: Alan Stern <stern@rowland.harvard.edu>,
	USB list <linux-usb@vger.kernel.org>, linux-pci@vger.kernel.org
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

I have some interesting news. I tested the latest source (available
via git) with the requested commandline arguments. I attached the
results to bug 43073 in bugzilla.kernel.org: an image of frozen boot
attempt and the dmesg of a successfull boot (same source).

2012/4/23 Bjorn Helgaas <bhelgaas@google.com>:
> On Wed, Apr 11, 2012 at 1:38 PM, Alan Stern <stern@rowland.harvard.edu> wrote:
>> On Wed, 11 Apr 2012, Calin Demian wrote:
>>
>>> Hi!
>>> Yes, in fact I did allready follow the execution, and it looks like this:
>>> function                                file
>>> pci_apply_final_quirks           /drivers/pci/quirks.c
>>> pci_fixup_device                    ~
>>> pci_do_fixups                        ~
>>> here, for the ohci busses 2 functions are called:
>>>   nv_msi_ht_cap_quirk_all       /drivers/usb/host/pci-quirks.c
>>
>> What is that?  It's not present in my copy of the kernel source.
>>
>>>   quirk_usb_early_handoff        ~
>>> quirk_usb_early_handoff calls the following 3 functions:
>>>   pci_enable_device(pdev)         /drivers/pci/pci.c
>>>   quirk_usb_handoff_ohci(pdev)    /drivers/usb/host/pci-quirks.c
>>>   pci_disable_device(pdev)
>>>
>>> The execution stops inside pci_disable_device, but because
>>> quirk_usb_handoff_ohci is the only function that has changed between
>>> versions 3.0.13 and 3.0.20 from the list of files mentioned above, it
>>> seems that this function changed behaviour in a way that my computer
>>> doesn't like.
>>
>> That cannot be right.  The call to pci_disable_device was added after
>> the change to quirk_usb_handoff_ohci.
>>
>>>   Further trace:
>>>   pci_disable_device
>>>     do_pci_disable_device
>>>       pci_read_config_word
>>
>> I have no idea why your computer would crash inside or after
>> pci_read_config_word.
>>
>> Anyway, this is a PCI problem, not a USB problem.  Maybe the PCI
>> experts can help.  I have CC'ed the linux-pci mailing list.
>>
>> Alan Stern
>>
>>> with respect,
>>> Calin Demian
>>>
>>>
>>> 2012/4/11 Alan Stern <stern@rowland.harvard.edu>:
>>> > On Wed, 11 Apr 2012, Calin Demian wrote:
>>> >
>>> >> 1.Boot problem: computer stops responding during boot.
>>> >>
>>> >> 2.The symptom doesn't occur allways, but when it does, it is at the
>>> >> same point during the boot process. The last messages displayed differ
>>> >> between different kernel versions, but are the same each time.
>>> >>   I would appreciate if you could take a look at function
>>> >> "quirk_usb_handoff_ohci" in file /drivers/usb/host/pci-quirks.c -
>>> >> which was modified in version 3.0.17 of the mainline kernel. The
>>> >> problem appeared when upgrading Ubuntu from mainline kernel version
>>> >> 3.0.13 to version 3.0.20. Searching the changelogs I found that this
>>> >> function was modified between the two releases. The  computer freezes
>>> >> durin applying the quirks (pci_apply_final_quirks) for bus
>>> >> 0000:00:13.1 (the 2nd OHCI bus). Controller is ALI  (EHCI 8 ports +
>>> >> OHCI 3x3 ports), dev_id 5237(OHCI).
>
> It sounds like this is a regression between 3.0.13 and 3.0.20.  Can
> you please open a bug report here:
>
> https://bugzilla.kernel.org/enter_bug.cgi?product=Drivers&component=PCI
>
> and attach dmesg or serial console logs with "debug ignore_loglevel
> initcall_debug" for both kernels?  For 3.0.20 you probably can't get a
> dmesg log because of the hang, so a digital photo would be fine, too.
>
> Thanks,
>  Bjorn
