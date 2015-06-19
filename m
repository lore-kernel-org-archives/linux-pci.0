Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-ig0-f174.google.com ([209.85.213.174]:37841 "EHLO
	mail-ig0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751818AbbFSDC6 (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Thu, 18 Jun 2015 23:02:58 -0400
Received: by igblr2 with SMTP id lr2so5012164igb.0
        for <linux-pci@vger.kernel.org>; Thu, 18 Jun 2015 20:02:58 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <20150619022612.GI7710@google.com>
References: <1434235142-2751-1-git-send-email-yinghai@kernel.org>
	<20150619022612.GI7710@google.com>
Date: Thu, 18 Jun 2015 20:02:57 -0700
Message-ID: <CAE9FiQVZngaPYvxi1DcXDLvDnDvx6qb2md1xbhMBc0uCPyLisw@mail.gmail.com>
Subject: Re: [PATCH] PCI: get correct bridge mmio size with old size checking
From: Yinghai Lu <yinghai@kernel.org>
To: Bjorn Helgaas <bhelgaas@google.com>
Cc: "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Thu, Jun 18, 2015 at 7:26 PM, Bjorn Helgaas <bhelgaas@google.com> wrote:
> On Sat, Jun 13, 2015 at 03:39:02PM -0700, Yinghai Lu wrote:
>> Found allocation request too big size for must+optional during pci
>> bus rescan via /sys/bus/pci/rescan, and fail with that size.
>>
>> [ 1217.699800] pci 0000:85:02.0: bridge window [mem 0x00100000-0x001fffff] to [bus 86] add_size 100000 add_align 100000
>> [ 1217.699821] pci 0000:85:03.0: bridge window [mem 0x00100000-0x001fffff] to [bus 87] add_size 100000 add_align 100000
>> [ 1217.699907] pci 0000:85:02.0: res[14]=[mem 0x00100000-0x001fffff] res_to_dev_res add_size 100000 min_align 100000
>> [ 1217.699909] pci 0000:85:03.0: res[14]=[mem 0x00100000-0x001fffff] res_to_dev_res add_size 100000 min_align 100000
>> [ 1217.699933] pci 0000:85:02.0: BAR 14: assigned [mem 0xedf00000-0xee0fffff]
>> [ 1217.699936] pci 0000:85:03.0: BAR 14: no space for [mem size 0x00200000]
>> [ 1217.699939] pci 0000:85:03.0: BAR 14: failed to assign [mem size 0x00200000]
>>
>> After close look, for 85:02.0 only need 1M for must+optional.
>
> I'm pretty sure this is fixing a bug, but I haven't figured out how it
> works yet.  (Is there a bugzilla or URL for an email problem report?)

No bugzilla, and it is with internal test with current upstream +
pci/next ... + my local
patches.

>
> Please strip out timestamps unless they help understand the problem.

ok.

>
> Are both 85:02.0 and 85:03.0 relevant to the problem?  If not, strip out
> the one that doesn't matter.

kind of. please check more detail printout:

[ 1217.699800] pci 0000:85:02.0: bridge window [mem
0x00100000-0x001fffff] to [bus 86] add_size 100000 add_align 100000
[ 1217.699821] pci 0000:85:03.0: bridge window [mem
0x00100000-0x001fffff] to [bus 87] add_size 100000 add_align 100000
[ 1217.699904] pci 0000:85:02.0: res[14]=[mem 0x00100000-0x001fffff]
res_to_dev_res add_size 100000 min_align 100000
[ 1217.699907] pci 0000:85:02.0: res[14]=[mem 0x00100000-0x001fffff]
res_to_dev_res add_size 100000 min_align 100000
[ 1217.699909] pci 0000:85:03.0: res[14]=[mem 0x00100000-0x001fffff]
res_to_dev_res add_size 100000 min_align 100000
[ 1217.699911] pci 0000:85:02.0: res[14]=[mem 0x00100000-0x001fffff]
res_to_dev_res add_size 100000 min_align 100000
[ 1217.699913] pci 0000:85:02.0: res[14]=[mem 0x00100000-0x001fffff]
res_to_dev_res add_size 100000 min_align 100000
[ 1217.699915] pci 0000:85:03.0: res[14]=[mem 0x00100000-0x001fffff]
res_to_dev_res add_size 100000 min_align 100000
[ 1217.699918] pci 0000:85:02.0: res[14]=[mem 0x00100000-0x001fffff]
res_to_dev_res add_size 100000 min_align 100000
[ 1217.699920] pci 0000:85:02.0: res[14]=[mem 0x00100000-0x002fffff]
res_to_dev_res add_size 100000 min_align 100000
[ 1217.699922] pci 0000:85:03.0: res[14]=[mem 0x00100000-0x001fffff]
res_to_dev_res add_size 100000 min_align 100000
[ 1217.699925] pci 0000:85:03.0: res[14]=[mem 0x00100000-0x002fffff]
res_to_dev_res add_size 100000 min_align 100000
[ 1217.699933] pci 0000:85:02.0: BAR 14: assigned [mem 0xedf00000-0xee0fffff]
[ 1217.699936] pci 0000:85:03.0: BAR 14: no space for [mem size 0x00200000]
[ 1217.699939] pci 0000:85:03.0: BAR 14: failed to assign [mem size 0x00200000]
[ 1217.699946] pci 0000:85:03.0: BAR 15: assigned [mem
0xfc17ff00000-0xfc17fffffff 64bit pref]
[ 1217.699950] pci 0000:85:02.0: BAR 13: assigned [io  0xb000-0xbfff]
[ 1217.699953] pci 0000:85:03.0: BAR 13: assigned [io  0xc000-0xcfff]
[ 1217.699964] pci 0000:85:02.0: BAR 14: assigned [mem 0xedf00000-0xedffffff]
[ 1217.699966] pci 0000:85:03.0: BAR 14: assigned [mem 0xee000000-0xee0fffff]
[ 1217.699968] pci 0000:85:03.0: BAR 14: [mem 0xee000000-0xee0fffff]
(failed to expand by 0x100000)
[ 1217.699971] pci 0000:85:03.0: failed to add 100000 res[14]=[mem
0xee000000-0xee0fffff]
[ 1217.699976] pci 0000:85:02.0: BAR 14: [mem 0xedf00000-0xedffffff]
(failed to expand by 0x100000)
[ 1217.699980] pci 0000:85:02.0: failed to add 100000 res[14]=[mem
0xedf00000-0xedffffff]
[ 1217.699986] pci 0000:86:00.0: res[6]=[mem 0xedf40000-0xedf3ffff
pref] res_to_dev_res add_size 20000 min_align 0
[ 1217.699991] pci 0000:86:00.0: res[6]=[mem 0xedf40000-0xedf3ffff
pref] res_to_dev_res add_size 20000 min_align 0
[ 1217.699995] pci 0000:86:00.0: res[6]=[mem 0xedf40000-0xedf3ffff
pref] res_to_dev_res add_size 20000 min_align 0
[ 1217.699998] pci 0000:86:00.0: res[6]=[mem 0xedf40000-0xedf3ffff
pref] res_to_dev_res add_size 20000 min_align 0
[ 1217.700001] pci 0000:86:00.1: res[6]=[mem 0xedfa0000-0xedf9ffff
pref] res_to_dev_res add_size 20000 min_align 0
[ 1217.700005] pci 0000:86:00.0: res[6]=[mem 0xedf40000-0xedf3ffff
pref] res_to_dev_res add_size 20000 min_align 0
[ 1217.700011] pci 0000:86:00.0: res[6]=[mem 0xedf40000-0xedf3ffff
pref] res_to_dev_res add_size 20000 min_align 0
[ 1217.700014] pci 0000:86:00.1: res[6]=[mem 0xedfa0000-0xedf9ffff
pref] res_to_dev_res add_size 20000 min_align 0
[ 1217.700019] pci 0000:86:00.0: BAR 0: assigned [mem 0xedfe0000-0xedffffff]
[ 1217.700029] pci 0000:86:00.0: BAR 1: assigned [mem 0xedfc0000-0xedfdffff]
[ 1217.700034] pci 0000:86:00.0: BAR 6: assigned [mem
0xedfa0000-0xedfbffff pref]
[ 1217.700037] pci 0000:86:00.1: BAR 0: assigned [mem 0xedf80000-0xedf9ffff]
[ 1217.700045] pci 0000:86:00.1: BAR 1: assigned [mem 0xedf60000-0xedf7ffff]
[ 1217.700051] pci 0000:86:00.1: BAR 6: assigned [mem
0xedf40000-0xedf5ffff pref]
[ 1217.700053] pci 0000:86:00.0: BAR 2: assigned [io  0xb000-0xb01f]
[ 1217.700064] pci 0000:86:00.1: BAR 2: assigned [io  0xb020-0xb03f]
[ 1217.700073] pci 0000:85:02.0: PCI bridge to [bus 86]
[ 1217.700076] pci 0000:85:02.0:   bridge window [io  0xb000-0xbfff]
[ 1217.700085] pci 0000:85:02.0:   bridge window [mem 0xedf00000-0xedffffff]
[ 1217.700097] pci 0000:87:00.0: res[6]=[mem 0xee000000-0xedffffff
pref] res_to_dev_res add_size 40000 min_align 0
[ 1217.700099] pci 0000:87:00.0: res[6]=[mem 0xee000000-0xedffffff
pref] res_to_dev_res add_size 40000 min_align 0
[ 1217.700101] pci 0000:87:00.0: res[6]=[mem 0xee000000-0xedffffff
pref] res_to_dev_res add_size 40000 min_align 0
[ 1217.700103] pci 0000:87:00.0: res[6]=[mem 0xee000000-0xedffffff
pref] res_to_dev_res add_size 40000 min_align 0
[ 1217.700106] pci 0000:87:00.1: res[6]=[mem 0xee080000-0xee07ffff
pref] res_to_dev_res add_size 40000 min_align 0
[ 1217.700109] pci 0000:87:00.0: res[6]=[mem 0xee000000-0xedffffff
pref] res_to_dev_res add_size 40000 min_align 0
[ 1217.700112] pci 0000:87:00.0: res[6]=[mem 0xee000000-0xedffffff
pref] res_to_dev_res add_size 40000 min_align 0
[ 1217.700114] pci 0000:87:00.1: res[6]=[mem 0xee080000-0xee07ffff
pref] res_to_dev_res add_size 40000 min_align 0
[ 1217.700116] pci 0000:87:00.0: BAR 6: assigned [mem
0xee0c0000-0xee0fffff pref]
[ 1217.700119] pci 0000:87:00.1: BAR 6: assigned [mem
0xee080000-0xee0bffff pref]
[ 1217.700121] pci 0000:87:00.0: BAR 2: assigned [mem
0xfc17fffc000-0xfc17fffffff 64bit]
[ 1217.700136] pci 0000:87:00.1: BAR 2: assigned [mem
0xfc17fff8000-0xfc17fffbfff 64bit]
[ 1217.700147] pci 0000:87:00.0: BAR 0: assigned [mem
0xfc17fff7000-0xfc17fff7fff 64bit]
[ 1217.700166] pci 0000:87:00.1: BAR 0: assigned [mem
0xfc17fff6000-0xfc17fff6fff 64bit]
[ 1217.700177] pci 0000:87:00.0: BAR 4: assigned [io  0xc000-0xc0ff]
[ 1217.700186] pci 0000:87:00.1: BAR 4: assigned [io  0xc400-0xc4ff]
[ 1217.700197] pci 0000:85:03.0: PCI bridge to [bus 87]
[ 1217.700200] pci 0000:85:03.0:   bridge window [io  0xc000-0xcfff]
[ 1217.700209] pci 0000:85:03.0:   bridge window [mem 0xee000000-0xee0fffff]
[ 1217.700216] pci 0000:85:03.0:   bridge window [mem
0xfc17ff00000-0xfc17fffffff 64bit pref]


>
> I'll try to work through this more tomorrow and figure out what's going on.
> But if you have any hints, or could walk me through an example, it might
> save me some time :)

that happens when we do the rescan or realloc(release and retry).
as we preserve the old size in the resource.

>
>>               size = min_size;
>>       if (old_size == 1)
>>               old_size = 0;
>> +     size = ALIGN(size + size1, align);
>>       if (size < old_size)
>>               size = old_size;
>> -     size = ALIGN(size + size1, align);
>> +
>
> Please don't add an extra blank line here; the extra line makes
> calculate_memsize() look different from calculate_iosize() for no good
> reason.

Sorry for that. I got the some impression from Ingo or someone else.
like to have

int func(int a)
{
        int b;

        b = a .....

        return b;
}

aka leave the blank line after declaration/define, and before last return.

Thanks

Yinghai
