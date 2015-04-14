Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-qk0-f179.google.com ([209.85.220.179]:34762 "EHLO
	mail-qk0-f179.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754101AbbDNWYG (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Tue, 14 Apr 2015 18:24:06 -0400
Received: by qkgx75 with SMTP id x75so40499818qkg.1
        for <linux-pci@vger.kernel.org>; Tue, 14 Apr 2015 15:24:05 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <CAEkKNCc37WTu+E=2G2pSjGhW6-6YBVygfTzQoiAVc48-7qVDhA@mail.gmail.com>
References: <CAEkKNCc9BpCXNCw1RD2gngUhSs13_-P_rtk=w4tVDW+3QaR6xQ@mail.gmail.com>
 <CAErSpo5K9utm4Bt75L75jTY5HPZO8qTtHfy9OzVqzxjV3FAW4A@mail.gmail.com>
 <20150414135840.GB19151@google.com> <CAEkKNCc37WTu+E=2G2pSjGhW6-6YBVygfTzQoiAVc48-7qVDhA@mail.gmail.com>
From: Bjorn Helgaas <bhelgaas@google.com>
Date: Tue, 14 Apr 2015 17:23:16 -0500
Message-ID: <CAErSpo6L0JLPnd1=Dc5m6io2GKSDU6joGBxQKJNnCHj9Xo_hFQ@mail.gmail.com>
Subject: Re: PCI Out of Resources
To: moussa ba <musaba@gmail.com>
Cc: "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
	Yinghai Lu <yinghai@kernel.org>
Content-Type: text/plain; charset=UTF-8
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

[+cc Yinghai]

On Tue, Apr 14, 2015 at 4:43 PM, moussa ba <musaba@gmail.com> wrote:
> Bjorn,
>
> See the bug filed here:
>
> https://bugzilla.kernel.org/show_bug.cgi?id=96651
>
> It was apparently misfiled to go to drivers_pci.  See the text of the
> bug filing below.  This was tested on 3.10, 3.19 and 4.0
>
> 20 PCI drives installed on a 2 Node system via 5 PCI switches. Only 16
> drives are actually recognized by the Linux.  All 20 drives are
> visible via lspci. I am unable to find an appropriate address in
> /proc/iomem to assign these regions to.
>
>
> #setpci -s 0000:90:00.0 BASE_ADDRESS_5=0x.......
>
> Not specifying the address because I had no idea where to put it, I
> would find empty spots in /proc/iomem but thse would fall within the
> address space of one of the pci bridges...
>
> We are missing 4 drives with the following error seen in dmesg for
> each drive, one given her as an example:
>
> [    0.983954] pci 0000:8e:00.0: can't claim BAR 6 [mem
> 0xffffc000-0xffffffff pref]: no compatible bridge window
> [    0.984106] pci 0000:02:02.0: BAR 14: no space for [mem size 0x00100000]
> [    0.984108] pci 0000:02:02.0: BAR 14: failed to assign [mem size 0x00100000]
> [    0.984110] pci 0000:02:04.0: BAR 14: no space for [mem size 0x00100000]
> [    0.984111] pci 0000:02:04.0: BAR 14: failed to assign [mem size 0x00100000]
> [    0.984113] pci 0000:02:02.0: BAR 13: no space for [io  size 0x1000]
> [    0.984114] pci 0000:02:02.0: BAR 13: failed to assign [io  size 0x1000]
> [    0.984116] pci 0000:02:04.0: BAR 13: no space for [io  size 0x1000]
> [    0.984117] pci 0000:02:04.0: BAR 13: failed to assign [io  size 0x1000]
> [    0.984119] pci 0000:03:00.0: BAR 5: no space for [mem size 0x00002000]
> [    0.984120] pci 0000:03:00.0: BAR 5: failed to assign [mem size 0x00002000]
> [    0.984122] pci 0000:03:00.0: BAR 2: no space for [mem size 0x00001000]
> [    0.984123] pci 0000:03:00.0: BAR 2: failed to assign [mem size 0x00001000]
> [    0.984124] pci 0000:03:00.0: BAR 3: no space for [mem size 0x00001000]
> [    0.984125] pci 0000:03:00.0: BAR 3: failed to assign [mem size 0x00001000]
> [    0.984128] pci 0000:03:00.0: BAR 4: no space for [io  size 0x0010]
> [    0.984129] pci 0000:03:00.0: BAR 4: failed to assign [io  size 0x0010]
> [    0.984132] pci 0000:02:02.0: PCI bridge to [bus 03]
> [    0.984142] pci 0000:02:03.0: PCI bridge to [bus 04]
> [    0.984154] pci 0000:05:00.0: BAR 5: no space for [mem size 0x00002000]
> [    0.984155] pci 0000:05:00.0: BAR 5: failed to assign [mem size 0x00002000]
> [    0.984156] pci 0000:05:00.0: BAR 2: no space for [mem size 0x00001000]
> [    0.984157] pci 0000:05:00.0: BAR 2: failed to assign [mem size 0x00001000]
> [    0.984159] pci 0000:05:00.0: BAR 3: no space for [mem size 0x00001000]
> [    0.984160] pci 0000:05:00.0: BAR 3: failed to assign [mem size 0x00001000]
> [    0.984161] pci 0000:05:00.0: BAR 4: no space for [io  size 0x0010]
> [    0.984163] pci 0000:05:00.0: BAR 4: failed to assign [io  size 0x0010]

Linux assigns space for endpoint BARs, but it doesn't automatically
reassign bridge windows to make space for downstream devices.  Does
booting with "pci=realloc" make any difference?

Bjorn
