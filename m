Return-Path: <SRS0=n5sN=7I=nuetzel-hh.de=Dieter@kernel.org>
Return-Path: <SRS0=n5sN=7I=nuetzel-hh.de=Dieter@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8;
 format=flowed
Date: Mon, 07 Aug 2017 00:30:19 +0200
From: =?UTF-8?Q?Dieter_N=C3=BCtzel?= <Dieter@nuetzel-hh.de>
To: =?UTF-8?Q?Christian_K=C3=B6nig?= <deathsimple@vodafone.de>
Cc: helgaas@kernel.org, linux-pci@vger.kernel.org,
 dri-devel@lists.freedesktop.org, platform-driver-x86@vger.kernel.org,
 linux-kernel@vger.kernel.org, amd-gfx@lists.freedesktop.org
Subject: Re: Resizeable PCI BAR support V5
In-Reply-To: <92b1fd57-2ad0-ab7b-33e3-3f4227dcc2db@vodafone.de>
References: <1496998787-6371-1-git-send-email-deathsimple@vodafone.de>
 <b71010ca149411909076e83d1c22b2b8@nuetzel-hh.de>
 <92b1fd57-2ad0-ab7b-33e3-3f4227dcc2db@vodafone.de>
Message-ID: <c4ebbddfa34dd5c3c93b7a20ac2e7948@nuetzel-hh.de>
List-ID: <linux-pci.vger.kernel.org>

Hello Christian,

after (long ;-)) vacation, injured wife (bad lumbago/luckily NO disc 
prolapse) on 2cond day @ our target, our daughter's 12th birthday, 
school start for both kids and mostly dad work I'm back...

Do you have a V6 handy.
Will do my fingers dirty if no Intel guy beats me at it.

Greetings,
Dieter

Am 30.06.2017 14:55, schrieb Christian König:
> Hi Dieter,
> 
> thanks a lot for testing that.
> 
>> But I think my poor little FUJITSU PRIMERGY TX150 S7, Xeon X3470 
>> (Nehalem), PCIe 2.0, 24 GB is to old for this stuff...
> Well, actually you only need to figure out how to enable a PCIe window
> above the 4GB limit.
> 
> Could be that the BIOS supports this with the ACPI tables (totally
> unlikely) or you could try to dig up the Northbridge documentation for
> this CPU from Intel and use my patch for the AMD CPUs as blueprint how
> to do this on an Intel CPU as well.
> 
> Fact is you GFX hardware is perfectly capable of doing this, it's just
> that the BIOS/Motherboard didn't enabled a PCIe window per default to
> avoid problems with 32bit OSes.
> 
> Regards,
> Christian.
> 
> Am 30.06.2017 um 01:51 schrieb Dieter Nützel:
>> Hello Christian,
>> 
>> I've running this since you've sent it on-top of amd-staging-4.11. But 
>> I think my poor little FUJITSU PRIMERGY TX150 S7, Xeon X3470 
>> (Nehalem), PCIe 2.0, 24 GB is to old for this stuff...
>> 
>> [    1.066475] pci 0000:05:00.0: VF(n) BAR0 space: [mem 
>> 0x00000000-0x0003ffff 64bit] (contains BAR0 for 16 VFs)
>> [    1.066489] pci 0000:05:00.0: VF(n) BAR2 space: [mem 
>> 0x00000000-0x003fffff 64bit] (contains BAR2 for 16 VFs)
>> [    1.121656] pci 0000:00:1c.0: BAR 15: assigned [mem 
>> 0x80000000-0x801fffff 64bit pref]
>> [    1.121659] pci 0000:00:1c.6: BAR 15: assigned [mem 
>> 0x80200000-0x803fffff 64bit pref]
>> [    1.121662] pci 0000:01:00.0: BAR 6: assigned [mem 
>> 0xb0120000-0xb013ffff pref]
>> [    1.121681] pci 0000:05:00.0: BAR 6: assigned [mem 
>> 0xb0280000-0xb02fffff pref]
>> [    1.121683] pci 0000:05:00.0: BAR 9: no space for [mem size 
>> 0x00400000 64bit]
>> [    1.121684] pci 0000:05:00.0: BAR 9: failed to assign [mem size 
>> 0x00400000 64bit]
>> [    1.121685] pci 0000:05:00.0: BAR 7: no space for [mem size 
>> 0x00040000 64bit]
>> [    1.121687] pci 0000:05:00.0: BAR 7: failed to assign [mem size 
>> 0x00040000 64bit]
>> [    3.874180] amdgpu 0000:01:00.0: BAR 0: releasing [mem 
>> 0xc0000000-0xcfffffff 64bit pref]
>> [    3.874182] amdgpu 0000:01:00.0: BAR 2: releasing [mem 
>> 0xb0400000-0xb05fffff 64bit pref]
>> [    3.874198] pcieport 0000:00:03.0: BAR 15: releasing [mem 
>> 0xb0400000-0xcfffffff 64bit pref]
>> [    3.874215] pcieport 0000:00:03.0: BAR 15: no space for [mem size 
>> 0x300000000 64bit pref]
>> [    3.874217] pcieport 0000:00:03.0: BAR 15: failed to assign [mem 
>> size 0x300000000 64bit pref]
>> [    3.874221] amdgpu 0000:01:00.0: BAR 0: no space for [mem size 
>> 0x200000000 64bit pref]
>> [    3.874223] amdgpu 0000:01:00.0: BAR 0: failed to assign [mem size 
>> 0x200000000 64bit pref]
>> [    3.874226] amdgpu 0000:01:00.0: BAR 2: no space for [mem size 
>> 0x00200000 64bit pref]
>> [    3.874227] amdgpu 0000:01:00.0: BAR 2: failed to assign [mem size 
>> 0x00200000 64bit pref]
>> [    3.874258] [drm] Not enough PCI address space for a large BAR.
>> [    3.874261] amdgpu 0000:01:00.0: BAR 0: assigned [mem 
>> 0xc0000000-0xcfffffff 64bit pref]
>> [    3.874269] amdgpu 0000:01:00.0: BAR 2: assigned [mem 
>> 0xb0400000-0xb05fffff 64bit pref]
>> [    3.874288] [drm] Detected VRAM RAM=8192M, BAR=256M
>> 
>> Anyway rebase for current amd-staging-4.11 needed.
>> Find attached dmesg-amd-staging-4.11-1.g7262353-default+.log.xz
>> 
>> Greetings,
>> Dieter
>> 
>> Am 09.06.2017 10:59, schrieb Christian König:
>>> Hi everyone,
>>> 
>>> This is the fith incarnation of this set of patches. It enables 
>>> device
>>> drivers to resize and most likely also relocate the PCI BAR of 
>>> devices
>>> they manage to allow the CPU to access all of the device local memory 
>>> at once.
>>> 
>>> This is very useful for GFX device drivers where the default PCI BAR 
>>> is only
>>> about 256MB in size for compatibility reasons, but the device easily 
>>> have
>>> multiple gigabyte of local memory.
>>> 
>>> Some changes since V4:
>>> 1. Rebased on 4.11.
>>> 2. added the rb from Andy Shevchenko to patches which look complete 
>>> now.
>>> 3. Move releasing the BAR and reallocating it on error to the driver 
>>> side.
>>> 4. Add amdgpu support for GMC V6 hardware generation as well.
>>> 
>>> Please review and/or comment,
>>> Christian.
>>> 
>>> _______________________________________________
>>> dri-devel mailing list
>>> dri-devel@lists.freedesktop.org
>>> https://lists.freedesktop.org/mailman/listinfo/dri-devel
