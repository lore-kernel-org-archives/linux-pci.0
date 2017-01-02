Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-yw0-f194.google.com ([209.85.161.194]:35907 "EHLO
        mail-yw0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932838AbdABVpB (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 2 Jan 2017 16:45:01 -0500
Received: by mail-yw0-f194.google.com with SMTP id r204so36680737ywb.3
        for <linux-pci@vger.kernel.org>; Mon, 02 Jan 2017 13:45:01 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <Pine.LNX.4.44L0.1701021626410.28032-100000@netrider.rowland.org>
References: <CAJCQCtS5gQObZr1j0stEnx9+U890_N-2FBFx_fZCZtmD8-2qJQ@mail.gmail.com>
 <Pine.LNX.4.44L0.1701021626410.28032-100000@netrider.rowland.org>
From: Chris Murphy <lists@colorremedies.com>
Date: Mon, 2 Jan 2017 14:45:00 -0700
Message-ID: <CAJCQCtTGYUFCvwPzugJ4TUtFPGKTy7r+HJr_1o8s=cbASa4zUA@mail.gmail.com>
Subject: Re: Thunderbolt adapter fails to instantiate USB and device
 enumeration if already connected at boot time
To: Alan Stern <stern@rowland.harvard.edu>
Cc: linux-usb@vger.kernel.org, linux-pci@vger.kernel.org
Content-Type: text/plain; charset=UTF-8
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Mon, Jan 2, 2017 at 2:28 PM, Alan Stern <stern@rowland.harvard.edu> wrote:
> On Mon, 2 Jan 2017, Chris Murphy wrote:
>
>> crossposting linux-usb@ and linux-pci@
>>
>> I filed a bug https://bugzilla.kernel.org/show_bug.cgi?id=191681 but
>> was told I need to post to the list first. I'm not actually sure this
>> is a USB bug, as filed in the bug report, because I think this
>> USB-C/Thunderbolt port is really a PCIe port that needs to become a
>> USB port only once the adapter is connected.
>>
>> Anyway, the gist of the problem is that if the USB-C to USB 3 adapter
>> is connected at boot time, the kernel doesn't instantiate a USB port
>> at all. So if for example I have a USB flash drive connected to the
>> adapter with a Linux live OS on it, the firmware sees the stick, finds
>> the bootloader, the bootloader finds and loads the kernel and
>> initramfs - so clearly up to this point it's working properly. But
>> then I end up at a dracut shell because there's not root fs to be
>> found. And there's no rootfs because there's no USB bus at all as far
>> as the kernel is concerned.
>>
>> If the adapter is not connected at boot time, is connected later on,
>> it all works as I'd expect it to work. I can plug it in, unplug it,
>> plug it back in, and it always works fine. So weirdly it's just a "if
>> connected at boot time" something is becoming deeply confused.
>>
>> I've tested 4.10-rc1 from kernel.org; but it's been a problem since
>> kernel 4.7.7 at least. The bug report has lspci, dmidecode, and two
>> dmesg outputs from boots with the adapter connected at boot time, and
>> not at boot time (but connected later). That bug report is 4.10-rc1
>> based with CONFIG_PCIEASPM_DEBUG=y
>> CONFIG_PCI_DEBUG=y but I'm not really seeing much additional
>> information that helps figure out what the source of the problem is.
>
> Considering that the failed boot log contains no USB messages at all,
> and no messages referring to PCI bus 0000:37 (the bus associated with
> the adapter), this certainly looks like a PCI problem.

I see these lines in the problem case, which don't occur in the working case.

[    0.561046] pci_bus 0000:37: busn_res: [bus 37-ff] end is updated to 37
[    0.561047] pci_bus 0000:37: busn_res: can not insert [bus 37]
under domain [bus 00-ff] (conflicts with (null) [bus 00-fe])

[    0.579446] pci 0000:37:00.0: can't claim BAR 0 [mem
0xb0000000-0xb000ffff]: address conflict with PCI Bus 0000:00 [mem
0x40000000-0xdfffffff window]

[    0.602277] pci 0000:37:00.0: can't derive routing for PCI INT A
[    0.602280] pci 0000:37:00.0: PCI INT A: not connected
[    0.612304] pci 0000:37:00.0: xHCI HW not ready after 5 sec (HC
bug?) status = 0xffffffff




-- 
Chris Murphy
