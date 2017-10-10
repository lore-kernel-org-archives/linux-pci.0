Return-Path: <SRS0=9KjW=BJ=gmail.com=jim2101024@kernel.org>
Return-Path: <SRS0=9KjW=BJ=gmail.com=jim2101024@kernel.org>
MIME-Version: 1.0
In-Reply-To: <CAC3K-4qy09zdRuCw+OO1XsBha4LagXDVe_yp9SOY-0ZpaiNKUQ@mail.gmail.com>
References: <fbda4c0b-8db7-bc93-3bc7-6bac577c4f07@gmail.com>
 <CAJ8Y1dQPtGbwt+O9uWrfY9xKaZqSYZ_z5=TKHgNY1=GR+PMLwQ@mail.gmail.com>
 <20171010111024.GV25517@bhelgaas-glaptop.roam.corp.google.com> <CAC3K-4qy09zdRuCw+OO1XsBha4LagXDVe_yp9SOY-0ZpaiNKUQ@mail.gmail.com>
From: Jim Quinlan <jim2101024@gmail.com>
Date: Tue, 10 Oct 2017 12:18:58 -0400
Message-ID: <CANCKTBtbGgyy-=gYA90WdJAzzTa8k9MS4=adhSsMk+DfiSk9dQ@mail.gmail.com>
Subject: Re: pci_bus warnings about adjacent RW1C bits w/ iproc-pci
To: Jon Mason <jon.mason@broadcom.com>
Cc: Bjorn Helgaas <helgaas@kernel.org>, Ray Jui <ray.jui@broadcom.com>,
	Florian Fainelli <f.fainelli@gmail.com>,
	bcm-kernel-feedback-list <bcm-kernel-feedback-list@broadcom.com>, Ray Jui <rjui@broadcom.com>,
	Hauke Mehrtens <hauke@hauke-m.de>, =?UTF-8?B?UmFmYcWCIE1pxYJlY2tp?= <rafal@milecki.pl>,
	Bjorn Helgaas <bhelgaas@google.com>, linux-pci <linux-pci@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
List-ID: <linux-pci.vger.kernel.org>

BTW, can someone point out to me what precise provision in the PCI
spec says that 8/16/32 bit config space writes must be provided?

On Tue, Oct 10, 2017 at 10:59 AM, Jon Mason <jon.mason@broadcom.com> wrote:
> On Tue, Oct 10, 2017 at 7:10 AM, Bjorn Helgaas <helgaas@kernel.org> wrote:
>> On Mon, Oct 09, 2017 at 10:33:01PM -0700, Ray Jui wrote:
>>> Hi Florian,
>>>
>>> This is from the following commit:
>>>
>>> commit fb26592301200dbbe4a9943fe188b57a46716900
>>> Author: Bjorn Helgaas <bhelgaas@google.com>
>>> Date:   Mon Oct 31 16:00:01 2016 -0500
>>>
>>>     PCI: Warn on possible RW1C corruption for sub-32 bit config writes
>>>
>>>     Hardware that supports only 32-bit config writes is not spec-compliant.
>>>     For example, if software performs a 16-bit write, we must do a 32-bit read,
>>>     merge in the 16 bits we intend to write, followed by a 32-bit write.  If
>>>     the 16 bits we *don't* intend to write happen to have any RW1C (write-one-
>>>     to-clear) bits set, we just inadvertently cleared something we shouldn't
>>>     have.
>>>
>>>     Add a rate-limited warning when we do sub-32 bit config writes.  Remove
>>>     similar probe-time warnings from some of the affected host bridge drivers.
>>>
>>>     Signed-off-by: Bjorn Helgaas <bhelgaas@google.com>
>>>     Enthusiastically-Acked-by: Russell King <rmk+kernel@armlinux.org.uk>
>>>     Acked-by: Shawn Lin <shawn.lin@rock-chips.com>      # rockchip
>>>     Acked-by: Thierry Reding <treding@nvidia.com>
>>>
>>> This warning message will show up on every root complex that can only
>>> support 32-bit config register write (instead of 8-bit, 16-bit writes)
>>> and iProc based host controller happens to be one of them.
>>>
>>> This limitation violates the PCIe spec as the 32-bit write may clear
>>> RW1C bits of a config register. But I believe those registers are
>>> usually used in AER which we do not currently support in the iProc
>>> based hos controllers.
>>
>> This warning is ratelimited, but maybe even that is overkill.  It
>> looks like we currently warn on every config write of less than 32
>> bits.  How many of those do you see?  Once per boot might be enough,
>> or maybe once per device (so we get a hint when loading a new driver).
>
> It's fairly trivial to change the warning in question to
> dev_warn_once().  If this is acceptable, I can crank it out.
>
> Thanks,
> Jon
>
>>> On Mon, Oct 9, 2017 at 8:58 PM, Florian Fainelli <f.fainelli@gmail.com> wrote:
>>> > Hi,
>>> >
>>> > With 4.14-rc3 on a BCM5301x device I am seeing the following PCI core
>>> > warnings using pcie_iproc; is this something to be worried about?
>>> >
>>> > [    2.626059] pcie_iproc_bcma bcma0:7: PCI host bridge to bus 0000:00
>>> >
>>> >
>>> >
>>> > [    2.632358] pci_bus 0000:00: root bus resource [mem
>>> > 0x08000000-0x0fffffff]
>>> >
>>> >
>>> > [    2.639207] pci_bus 0000:00: No busn resource found for root bus,
>>> > will use [bus 00-ff]
>>> >
>>> >
>>> > [    2.647188] pci_bus 0000:00: 2-byte config write to 0000:00:00.0
>>> > offset 0x4 may corrupt adjacent RW1C bits
>>> >
>>> >
>>> > [    2.656838] pci_bus 0000:00: 2-byte config write to 0000:00:00.0
>>> > offset 0x4 may corrupt adjacent RW1C bits
>>> >
>>> >
>>> > [    2.666565] pci_bus 0000:00: 2-byte config write to 0000:00:00.0
>>> > offset 0x4c may corrupt adjacent RW1C bits
>>> >
>>> >
>>> > [    2.676524] pci_bus 0000:00: 2-byte config write to 0000:00:00.0
>>> > offset 0x3e may corrupt adjacent RW1C bits
>>> >
>>> >
>>> > [    2.686270] pci_bus 0000:00: 2-byte config write to 0000:00:00.0
>>> > offset 0x4 may corrupt adjacent RW1C bits
>>> >
>>> >
>>> > [    2.695903] pci_bus 0000:00: 1-byte config write to 0000:00:00.0
>>> > offset 0xc may corrupt adjacent RW1C bits
>>> >
>>> >
>>> > [    2.705531] PCI: bus0: Fast back to back transfers disabled
>>> >
>>> >
>>> >
>>> > [    2.711086] pci 0000:00:00.0: bridge configuration invalid ([bus
>>> > 00-00]), reconfiguring
>>> >
>>> >
>>> > [    2.719076] pci_bus 0000:00: 2-byte config write to 0000:00:00.0
>>> > offset 0x3e may corrupt adjacent RW1C bits
>>> >
>>> >
>>> > [    2.728796] pci_bus 0000:00: 2-byte config write to 0000:00:00.0
>>> > offset 0xc8 may corrupt adjacent RW1C bits
>>> >
>>> >
>>> > [    2.738513] pci_bus 0000:00: 2-byte config write to 0000:00:00.0
>>> > offset 0x3e may corrupt adjacent RW1C bits
>>> >
>>> >
>>> > [    2.748225] pci_bus 0000:00: 2-byte config write to 0000:00:00.0
>>> > offset 0x3e may corrupt adjacent RW1C bits
>>> >
>>> >
>>> > [    2.758262] pci 0000:01:00.0: enabling Extended Tags
>>> >
>>> >
>>> >
>>> > [    2.763577] PCI: bus1: Fast back to back transfers disabled
>>> >
>>> >
>>> >
>>> > [    2.769205] pci 0000:00:00.0: BAR 8: assigned [mem
>>> > 0x08000000-0x080fffff]
>>> >
>>> >
>>> > [    2.776017] pci 0000:01:00.0: BAR 0: assigned [mem
>>> > 0x08000000-0x08003fff 64bit]
>>> >
>>> >
>>> > [    2.783338] pci 0000:00:00.0: PCI bridge to [bus 01]
>>> >
>>> >
>>> >
>>> > [    2.788293] pci 0000:00:00.0:   bridge window [mem
>>> > 0x08000000-0x080fffff]
>>> >
>>> >
>>> > [    2.911536] pcie_iproc_bcma bcma0:8: link: UP
>>> >
>>> >
>>> >
>>> > [    2.916052] pcie_iproc_bcma bcma0:8: PCI host bridge to bus 0001:00
>>> >
>>> >
>>> >
>>> > [    2.922349] pci_bus 0001:00: root bus resource [mem
>>> > 0x40000000-0x47ffffff]
>>> >
>>> >
>>> > [    2.929200] pci_bus 0001:00: No busn resource found for root bus,
>>> > will use [bus 00-ff]
>>> >
>>> >
>>> > [    2.937482] PCI: bus0: Fast back to back transfers disabled
>>> >
>>> >
>>> >
>>> > [    2.943075] pci 0001:00:00.0: bridge configuration invalid ([bus
>>> > 00-00]), reconfiguring
>>> >
>>> >
>>> > [    2.951713] PCI: bus1: Fast back to back transfers disabled
>>> >
>>> >
>>> >
>>> > [    2.957354] pci 0001:00:00.0: BAR 8: assigned [mem
>>> > 0x40000000-0x400fffff]
>>> >
>>> >
>>> > [    2.964166] pci 0001:01:00.0: BAR 0: assigned [mem
>>> > 0x40000000-0x40007fff 64bit]
>>> >
>>> >
>>> > [    2.971461] pci 0001:00:00.0: PCI bridge to [bus 01]
>>> >
>>> >
>>> >
>>> > [    2.976434] pci 0001:00:00.0:   bridge window [mem
>>> > 0x40000000-0x400fffff]
>>> > --
>>> > Florian
