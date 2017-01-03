Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-yw0-f196.google.com ([209.85.161.196]:36585 "EHLO
        mail-yw0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1758988AbdACPt5 (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 3 Jan 2017 10:49:57 -0500
Received: by mail-yw0-f196.google.com with SMTP id r204so38841332ywb.3
        for <linux-pci@vger.kernel.org>; Tue, 03 Jan 2017 07:49:57 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <1483435737.20054.6.camel@suse.com>
References: <CAJCQCtS5gQObZr1j0stEnx9+U890_N-2FBFx_fZCZtmD8-2qJQ@mail.gmail.com>
 <Pine.LNX.4.44L0.1701021626410.28032-100000@netrider.rowland.org>
 <CAJCQCtTGYUFCvwPzugJ4TUtFPGKTy7r+HJr_1o8s=cbASa4zUA@mail.gmail.com> <1483435737.20054.6.camel@suse.com>
From: Chris Murphy <lists@colorremedies.com>
Date: Tue, 3 Jan 2017 08:19:38 -0700
Message-ID: <CAJCQCtQo3DiaBG2LjSJtcMPpCyEH9hDP5-kmURcoEVRLrz0zRQ@mail.gmail.com>
Subject: Re: Thunderbolt adapter fails to instantiate USB and device
 enumeration if already connected at boot time
To: Oliver Neukum <oneukum@suse.com>
Cc: Chris Murphy <lists@colorremedies.com>,
        Alan Stern <stern@rowland.harvard.edu>,
        linux-pci@vger.kernel.org, linux-usb@vger.kernel.org
Content-Type: text/plain; charset=UTF-8
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Tue, Jan 3, 2017 at 2:28 AM, Oliver Neukum <oneukum@suse.com> wrote:
> On Mon, 2017-01-02 at 14:45 -0700, Chris Murphy wrote:
>> I see these lines in the problem case, which don't occur in the
>> working case.
>>
>> [    0.561046] pci_bus 0000:37: busn_res: [bus 37-ff] end is updated
>> to 37
>> [    0.561047] pci_bus 0000:37: busn_res: can not insert [bus 37]
>> under domain [bus 00-ff] (conflicts with (null) [bus 00-fe])
>>
>> [    0.579446] pci 0000:37:00.0: can't claim BAR 0 [mem
>> 0xb0000000-0xb000ffff]: address conflict with PCI Bus 0000:00 [mem
>> 0x40000000-0xdfffffff window]
>>
>> [    0.602277] pci 0000:37:00.0: can't derive routing for PCI INT A
>> [    0.602280] pci 0000:37:00.0: PCI INT A: not connected
>> [    0.612304] pci 0000:37:00.0: xHCI HW not ready after 5 sec (HC
>> bug?) status = 0xffffffff
>
> Have you tried "pci=realloc"?

No effect. Attached that dmesg to the bug report anyway though.

-- 
Chris Murphy
