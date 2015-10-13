Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-vk0-f54.google.com ([209.85.213.54]:32770 "EHLO
	mail-vk0-f54.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752028AbbJMFnD (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Tue, 13 Oct 2015 01:43:03 -0400
MIME-Version: 1.0
In-Reply-To: <alpine.LRH.2.20.1510130800380.3972@math.ut.ee>
References: <alpine.LRH.2.20.1510071147520.8345@math.ut.ee>
	<CAE9FiQXM9YxRwcbG577Pcqmj7YbOa0yk6hYELb2FpTtct5u2jg@mail.gmail.com>
	<alpine.LRH.2.20.1510120808240.3251@math.ut.ee>
	<CAE9FiQXHsgYaTgF2rsWFJXSYJ=kH3j63ageJ2H8F5wnzbFgxRg@mail.gmail.com>
	<alpine.LRH.2.20.1510130800380.3972@math.ut.ee>
Date: Mon, 12 Oct 2015 22:43:01 -0700
Message-ID: <CAE9FiQVAtPGgzwwMaHjGjyzOD8wKb0TqCd1wynF6-ZmFqZzEaQ@mail.gmail.com>
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
>> >>
>> >> git://git.kernel.org/pub/scm/linux/kernel/git/yinghai/linux-yinghai.git
>> >> for-pci-v4.4-next
>> >>
>> >> It should fix some "no compatible bridge window"
>> >
>> > Blade 100: still has 2 address conflicts:
>> > http://kodu.ut.ee/~mroos/dm/dm.sb100+patch
>> >
>> > V240: still has a lot of address conflicts:
>> > http://kodu.ut.ee/~mroos/dm/dm.v240+patch
>> >
>> > V210: fixes the line
>> > pci 0001:00:07.0: can't claim BAR 0 [io  0x7fe01000000-0x7fe0100ffff]: address conflict with 0001:00:06.0 [io  0x7fe01000600-0x7fe0100061f]
>> >
>> > These lines are still present:
>> >
>> > pci 0001:00:07.0: can't claim BAR 1 [mem 0x7ff00000000-0x7ff000fffff]: address conflict with Video RAM area [??? 0x7ff000a0000-0x7ff000bffff flags 0x80000000]
>> > pci 0001:00:07.0: can't claim BAR 2 [mem 0x7ff00000000-0x7ff000fffff]: address conflict with Video RAM area [??? 0x7ff000a0000-0x7ff000bffff flags 0x80000000]
>> >
>> you should not have those.
>>
>> Looks like you are using old branch before 2015-10-05.
>>
>> If you use the git directly, please update the branch to local again.
>
> Updated on V210 - the others were more recent. Now I get more BAR
> warning there too:
>
> http://kodu.ut.ee/~mroos/dm/dm.v210+patches
>

interesting, mem and mem64 is overlapping.

[   38.824625] /pci@1f,700000: TOMATILLO PCI Bus Module ver[4:0]
[   38.824654] /pci@1f,700000: PCI IO [io
0x7f601000000-0x7f601ffffff] offset 7f601000000
[   38.824680] /pci@1f,700000: PCI MEM [mem
0x7f700000000-0x7f7ffffffff] offset 7f700000000
[   38.824704] /pci@1f,700000: PCI MEM64 [mem
0x7f700000000-0x7f7ffffffff] offset 7f700000000
[   38.826310] PCI: Scanning PBM /pci@1f,700000
[   38.826479] schizo f0069c00: PCI host bridge to bus 0000:00
[   38.826506] pci_bus 0000:00: root bus resource [io
0x7f601000000-0x7f601ffffff] (bus address [0x0000-0xffffff])
[   38.826536] pci_bus 0000:00: root bus resource [mem
0x7f700000000-0x7f7ffffffff] (bus address [0x00000000-0xffffffff])
[   38.826565] pci_bus 0000:00: root bus resource [mem
0x7f700000000-0x7f7ffffffff] (bus address [0x00000000-0xffffffff])

We need to add more sanitary checking.

Can you send boot log after booting with "debug ignore_loglevel ofpci_debug=1" ?

Thanks

Yinghai
