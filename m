Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-vc0-f176.google.com ([209.85.220.176]:53706 "EHLO
	mail-vc0-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S933147AbaGQPIi (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Thu, 17 Jul 2014 11:08:38 -0400
Received: by mail-vc0-f176.google.com with SMTP id id10so204677vcb.21
        for <linux-pci@vger.kernel.org>; Thu, 17 Jul 2014 08:08:37 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <CAE9FiQUn4QByiaPqKnk=CCmCXsnaqVfNCjynoyNM3FucrKGhew@mail.gmail.com>
References: <CAKAYmMLfxkmaVxaPDd6z=B0ESQ3mR=dUG4OFFgEoy0295qLYgg@mail.gmail.com>
	<CAKAYmMLhPhukBbR8NhPk3EigmvwiX+DEGj-Mod7zpHMnZKRsLw@mail.gmail.com>
	<CAErSpo7vooChRfSF6oY8GcqVYZruv-7_D0zm3a4M_KDVMbWNiA@mail.gmail.com>
	<CAE9FiQWomktcpSHeFwxWBLXmAsbdXEHv6sOrNXodobkBw=mRKA@mail.gmail.com>
	<CAE9FiQW+GbprQZNvHC-ek1cSydP3KWcjgAU0ii5_jECC1+tXrg@mail.gmail.com>
	<CAKAYmMJf=TdpdyALZQOoAmdgPjpzFu-OP7rMLzyaFRno-36F6Q@mail.gmail.com>
	<CAE9FiQUn4QByiaPqKnk=CCmCXsnaqVfNCjynoyNM3FucrKGhew@mail.gmail.com>
Date: Thu, 17 Jul 2014 08:08:37 -0700
Message-ID: <CAKAYmMJOWtn268Kipwm6JVamrsrfxCG=Ju8E56-ZCXctBn+12A@mail.gmail.com>
Subject: Re: Error assigning BAR 0 to hotplugged device
From: Chuck Tuffli <ctuffli@gmail.com>
To: Yinghai Lu <yinghai@kernel.org>
Cc: "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
	Bjorn Helgaas <bhelgaas@google.com>
Content-Type: text/plain; charset=UTF-8
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Wed, Jul 16, 2014 at 7:15 PM, Yinghai Lu <yinghai@kernel.org> wrote:
> On Wed, Jul 16, 2014 at 6:00 PM, Chuck Tuffli <ctuffli@gmail.com> wrote:
>> On Wed, Jul 16, 2014 at 4:47 PM, Yinghai Lu <yinghai@kernel.org> wrote:
>> ...
>>> in the tree:
>>>    80:03.0 ==> 96:00.0 ==> 97:08.0 ==> 98:00.0 ==> 99:00.0 ==> 9a:00.0
>>> ==> 9b:15.0
>>>
>>> only 97:08.0 and 99:00.0 is hotplug+.
>>>
>>> and kernel will honor BIOS set value at first, and realloc will only work on
>>> unassigned/invalid assigned BARs. and hpmem_size will be only treated at
>>> optional size even on hotplug slots.
>>
>> Does this mean the only time the kernel will re-allocate the BARs and
>> use hpmemsize is if they have the value 0x0? If so, does realloc have
>> any limitations with respect to where in the tree the invalid BAR
>> exists? In my example, could realloc fix 80:03.0? 9b:15.0?
>
> the problem is 9b:15.0 is not hotplugable, when a5:00.0 is not
> inserted into the slot,
> realloc will not pre-reserve range for 9b:15.0.
>
>> If the BIOS doesn't allocate enough memory mapped IO resources for
>> devices, it sounds like the kernel can't really fix this problem,
>> right?
>
> Yes. You need to fix BIOS at first.
>
> So it will be final products or just development prototype?

This is a prototype development system I'm using to develop software.
Since a BIOS fix isn't likely to happen, are there existing features I
can use to work around this problem?

--chuck
