Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-vk0-f48.google.com ([209.85.213.48]:35827 "EHLO
	mail-vk0-f48.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751695AbbJMGTu (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Tue, 13 Oct 2015 02:19:50 -0400
MIME-Version: 1.0
In-Reply-To: <alpine.LRH.2.20.1510130800380.3972@math.ut.ee>
References: <alpine.LRH.2.20.1510071147520.8345@math.ut.ee>
	<CAE9FiQXM9YxRwcbG577Pcqmj7YbOa0yk6hYELb2FpTtct5u2jg@mail.gmail.com>
	<alpine.LRH.2.20.1510120808240.3251@math.ut.ee>
	<CAE9FiQXHsgYaTgF2rsWFJXSYJ=kH3j63ageJ2H8F5wnzbFgxRg@mail.gmail.com>
	<alpine.LRH.2.20.1510130800380.3972@math.ut.ee>
Date: Mon, 12 Oct 2015 23:19:49 -0700
Message-ID: <CAE9FiQWiXXVb-1SH5sCEp7Ffbb5=xfoRP6Em2EKS90GHa0P63Q@mail.gmail.com>
Subject: Re: 4.3-rc3 BAR allocation problems on multiple machines
From: Yinghai Lu <yinghai@kernel.org>
To: Meelis Roos <mroos@linux.ee>
Cc: Linux Kernel list <linux-kernel@vger.kernel.org>,
	"linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Mon, Oct 12, 2015 at 10:06 PM, Meelis Roos <mroos@linux.ee> wrote:
>> >> > sparc64 machines:
>
> Updated on V210 - the others were more recent. Now I get more BAR
> warning there too:
>
> http://kodu.ut.ee/~mroos/dm/dm.v210+patches

other warning:

[   38.829890] pci 0001:00:07.0: can't claim BAR 2 [mem
0x7ff00000000-0x7ff000fffff]: address conflict with 0001:00:07.0 [mem
0x7ff00000000-0x7ff000fffff]
[   38.829924] pci 0001:00:06.0: can't claim BAR 0 [io
0x7fe01000000-0x7fe0100000f]: address conflict with 0001:00:07.0 [io
0x7fe01000000-0x7fe0100ffff]
[   38.829957] pci 0001:00:0d.0: can't claim BAR 0 [io
0x7fe01000900-0x7fe01000907]: address conflict with 0001:00:07.0 [io
0x7fe01000000-0x7fe0100ffff]
[   38.829988] pci 0001:00:0d.0: can't claim BAR 1 [io
0x7fe01000918-0x7fe0100091f]: address conflict with 0001:00:07.0 [io
0x7fe01000000-0x7fe0100ffff]
[   38.830019] pci 0001:00:0d.0: can't claim BAR 2 [io
0x7fe01000910-0x7fe01000917]: address conflict with 0001:00:07.0 [io
0x7fe01000000-0x7fe0100ffff]
[   38.830050] pci 0001:00:0d.0: can't claim BAR 3 [io
0x7fe01000908-0x7fe0100090f]: address conflict with 0001:00:07.0 [io
0x7fe01000000-0x7fe0100ffff]
[   38.830081] pci 0001:00:0d.0: can't claim BAR 4 [io
0x7fe01000920-0x7fe0100092f]: address conflict with 0001:00:07.0 [io
0x7fe01000000-0x7fe0100ffff]

are real overlapping
1. between BAR1 and BAR2 for 0001:00:07.0.
2. between BAR from 0001:00:07.0 and 0001:00:06.0 io.

I would suspect 00001:00:07.0 is not assigned by firmware.


[   38.830112] PCI: /pci@1e,600000 can't claim Video RAM area [mem
0x7ff000a0000-0x7ff000bffff]: address conflict with 0001:00:07.0 [mem
0x7ff00000000-0x7ff000fffff]
[   38.830150] PCI: /pci@1e,600000 can't claim System ROM [mem
0x7ff000f0000-0x7ff000fffff]: address conflict with 0001:00:07.0 [mem
0x7ff00000000-0x7ff000fffff]
[   38.830187] PCI: /pci@1e,600000 can't claim Video ROM [mem
0x7ff000c0000-0x7ff000c7fff]: address conflict with 0001:00:07.0 [mem
0x7ff00000000-0x7ff000fffff]

those are intended.

Anyway OBP does not assign resource to 00001:00:07.0 ?

Thanks

Yinghai
