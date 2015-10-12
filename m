Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-vk0-f49.google.com ([209.85.213.49]:35208 "EHLO
	mail-vk0-f49.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752524AbbJLWzZ (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Mon, 12 Oct 2015 18:55:25 -0400
MIME-Version: 1.0
In-Reply-To: <alpine.LRH.2.20.1510120808240.3251@math.ut.ee>
References: <alpine.LRH.2.20.1510071147520.8345@math.ut.ee>
	<CAE9FiQXM9YxRwcbG577Pcqmj7YbOa0yk6hYELb2FpTtct5u2jg@mail.gmail.com>
	<alpine.LRH.2.20.1510120808240.3251@math.ut.ee>
Date: Mon, 12 Oct 2015 15:55:24 -0700
Message-ID: <CAE9FiQXHsgYaTgF2rsWFJXSYJ=kH3j63ageJ2H8F5wnzbFgxRg@mail.gmail.com>
Subject: Re: 4.3-rc3 BAR allocation problems on multiple machines
From: Yinghai Lu <yinghai@kernel.org>
To: Meelis Roos <mroos@linux.ee>
Cc: Linux Kernel list <linux-kernel@vger.kernel.org>,
	"linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Mon, Oct 12, 2015 at 6:04 AM, Meelis Roos <mroos@linux.ee> wrote:
>> > sparc64 machines:
>>
>> git://git.kernel.org/pub/scm/linux/kernel/git/yinghai/linux-yinghai.git
>> for-pci-v4.4-next
>>
>> It should fix some "no compatible bridge window"
>
> Blade 100: still has 2 address conflicts:
> http://kodu.ut.ee/~mroos/dm/dm.sb100+patch
>
> V240: still has a lot of address conflicts:
> http://kodu.ut.ee/~mroos/dm/dm.v240+patch
>
> V210: fixes the line
> pci 0001:00:07.0: can't claim BAR 0 [io  0x7fe01000000-0x7fe0100ffff]: address conflict with 0001:00:06.0 [io  0x7fe01000600-0x7fe0100061f]
>
> These lines are still present:
>
> pci 0001:00:07.0: can't claim BAR 1 [mem 0x7ff00000000-0x7ff000fffff]: address conflict with Video RAM area [??? 0x7ff000a0000-0x7ff000bffff flags 0x80000000]
> pci 0001:00:07.0: can't claim BAR 2 [mem 0x7ff00000000-0x7ff000fffff]: address conflict with Video RAM area [??? 0x7ff000a0000-0x7ff000bffff flags 0x80000000]
>
you should not have those.

Looks like you are using old branch before 2015-10-05.

If you use the git directly, please update the branch to local again.

Thanks

Yinghai
