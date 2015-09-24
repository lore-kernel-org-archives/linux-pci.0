Return-Path: <linux-kernel-owner@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <CAL-B5D0f10Q6C5jmjzysowDjJ=Z8iA1tSSAQwUp9qcxW-WeMPw@mail.gmail.com>
References: <CAL-B5D3FgF+o7BcLBe7O_gcxy2jf3w43bXeDJuRH2VS2ES0A7Q@mail.gmail.com>
	<CAE9FiQWY1gdpzdqToBM0sNgfCRnRfEEgJfn-J9igorLH1K80JA@mail.gmail.com>
	<CAL-B5D0f10Q6C5jmjzysowDjJ=Z8iA1tSSAQwUp9qcxW-WeMPw@mail.gmail.com>
Date: Thu, 24 Sep 2015 12:01:57 -0700
Message-ID: <CAE9FiQVXox9UbaQKZvatLwdqbEp6k9QpRcSCeFNROdK6=5qq2Q@mail.gmail.com>
Subject: Re: [RFC] PCI: Unassigned Expansion ROM BARs
From: Yinghai Lu <yinghai@kernel.org>
To: Myron Stowe <myron.stowe@gmail.com>
Cc: linux-pci <linux-pci@vger.kernel.org>,
	LKML <linux-kernel@vger.kernel.org>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Alex Williamson <alex.williamson@redhat.com>
Content-Type: text/plain; charset=UTF-8
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Thu, Sep 24, 2015 at 10:06 AM, Myron Stowe <myron.stowe@gmail.com> wrote:
> On Wed, Sep 23, 2015 at 9:21 PM, Yinghai Lu <yinghai@kernel.org> wrote:
>> On Wed, Sep 23, 2015 at 7:47 PM, Myron Stowe <myron.stowe@gmail.com> wrote:
>>>
>>> The kernel expects device Expansion ROM BARs to be programmed with valid
>>> values - even if the respective Expansion ROM's Enable bit is 0 (i.e. the
>>> device’s expansion ROM address space is disabled).  This seems to be the
>>> main contention point with said BIOS engineers.  If an Expansion ROM BAR is
>>> not programmed, the kernel will attempt to find available resources and, if
>>> successful, program it.  As this occurs various 'dmesg' entries
>>> related to kernel's actions are output.
>> ...
>>> There is a kernel boot parameter, pci=norom, that is intended to disable the
>>> kernel's resource assignment actions for Expansion ROMs that do not already
>>> have BIOS assigned address ranges.  Note however, if I remember correctly,
>>> that this only works if the Expansion ROM BAR is set to "0" by the BIOS
>>> before hand-off.
>>
>> option rom is used by legacy bios to enable booting from external device.
>> usually BIOS call the option rom, so the firmware will be loaded to
>> add on cards.
>> and firmware get started.
>> Also option rom would include tools that is used to configure behavior of cards
>> like add/remove raid.
>
> I'm not sure what you are getting at here but yes, there are use cases
> where the BIOS
> needs to access the Expansion ROM, one of the more common being PXE booting from
> a NIC device where the PXE boot content is retrieved from the ROM, but
> that has little,
> if anything, to do with what I'm after here.
>
> The BIOS engineers are expressing that the kernel should *never* need
> to access the Expansion
> ROM, and thus should *never* try to allocate resources for these BARs
> and program them
> to sane address range values.

They are wrong.
It still depends on how addon card firmware and drivers
from OS to use it.

>
>
> I know you work with bringing up new hardware.  So picture yourself
> sitting with some
> members from your platform's BIOS team.  They tell you: "The OS is
> incorrect in thinking
> it needs to find, and program, sane resource range values into a
> device's Expansion ROM
> BAR.  We (the BIOS) hand-off the platform with these disabled, thus
> whatever values are in
> the ROMs BAR should be totally ignored, and the OS should never touch
> them."  What would you
> reply with to them in an attempt to show that your position (i.e. the
> kernel finding, and programming
> values under these circumstances) is correct and that the BIOS opinion
> is in-correct?  That is
> what I'm after.

Some addon cards drivers are use ROM bar to talk to card.
like  Intel DC21285 driver in drivers/mtd/maps/pci.c

>
>>
>> Also there is some use case that kernel driver try to get some parameters from
>> BIOS. like intel soft raid ? --- bad practice !
>
> Again, your replies are so terse I have no idea what you are saying; it's
> undecipherable!  Are you indicating that you agree with the BIOS
> engineers views?

No.

Just some addon card/drivers would avoid accessing expand rom to get
parameter or settings.



>
>>
>> I would like to treat option rom BAR as optional resources during
>> resource allocation.
>>
>> https://git.kernel.org/cgit/linux/kernel/git/yinghai/linux-yinghai.git/patch/?id=7f689da33302e4871fd18aee2c19abb5e3ea5261
>>
>> Subject: PCI: Treat ROM resource as optional during realloc
>>
>> Current on realloc path, we just ignore ROM resource if we can not assign
>> them in first try.
>>
>> Treat ROM resources as optional resources,so try to allocate them together
>> with required ones, if can not assign them, could go with other required
>> resources only, and try to allocate them second time in expand path.
>
> Yes, while they may have lower priority in obtaining resources, your still
> attempting to do so initially.  The BIOS engineers seem to believe that this is
> incorrect - the OS should not even attempt to allocate them in the first try.

Some drivers may use it, and we don't know who is really need them.
so just give it a try.

Or do we want to keep a white list to say which device should have
ROM bar as mush have, and other is optional to have ?

Thanks

Yinghai
