Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from resqmta-ch2-09v.sys.comcast.net ([69.252.207.41]:58330 "EHLO
        resqmta-ch2-09v.sys.comcast.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1751102AbdBLESy (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Sat, 11 Feb 2017 23:18:54 -0500
From: Joshua Kinard <kumba@gentoo.org>
Subject: Re: [PATCH 12/12] MIPS: PCI: Fix IP27 for the PCI_PROBE_ONLY case
To: Bjorn Helgaas <bhelgaas@google.com>
References: <20170207061356.8270-1-kumba@gentoo.org>
 <20170207061356.8270-13-kumba@gentoo.org>
 <CAErSpo6yKAE1_c1eZJapnjD1g0pocyOxed3_Eumdp_026uhDuA@mail.gmail.com>
 <eafc94c6-1931-e2ce-7e03-d84d8e181e81@gentoo.org>
 <CAErSpo4LsrPCtdZwp6CyT0jKhXLt3j=fGSiFjpRRTPUjFoKHtQ@mail.gmail.com>
Cc: Ralf Baechle <ralf@linux-mips.org>,
        James Hogan <james.hogan@imgtec.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
        Linux/MIPS <linux-mips@linux-mips.org>,
        "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>
Message-ID: <c7ed6a1d-f625-d294-8910-dd2d93d34292@gentoo.org>
Date: Sat, 11 Feb 2017 23:09:51 -0500
MIME-Version: 1.0
In-Reply-To: <CAErSpo4LsrPCtdZwp6CyT0jKhXLt3j=fGSiFjpRRTPUjFoKHtQ@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On 02/09/2017 16:29, Bjorn Helgaas wrote:

[snip]

>>>> However, IP27 is completely different in this regard.  Instead of 
>>>> using ioremapped addresses for I/O, IP27 has a dedicated address 
>>>> range, 0x92xxxxxxxxxxxxxx, that is used for all I/O access.  Since 
>>>> this is uncached physical address space, the generic MIPS PCI code 
>>>> will not probe it correctly and thus, the original behavior of 
>>>> PCI_PROBE_ONLY needs to be restored only for the IP27 platform to 
>>>> bypass this logic and have working PCI, at least for the IO6/IO6G 
>>>> board that houses the base devices, until a better solution is found.
>>> 
>>> It sounds like there's something different about how ioremap() works on
>>>  these platforms and PCI probing is tripping over that.  I'd really like
>>>  to understand more about this difference to see if we can converge that
>>>  instead of adding back the PCI_PROBE_ONLY usage.
>> 
>> I'd need to go and dig around in the IP27 headers again for this machine 
>> to see what ioremap() is actually doing, but I *think* it returns uncached
>> physical addresses in most instances because of a special feature of the
>> CPU, the R10000-family, which makes uncached access very fast.  I think
>> only the IP27 platform uses this capability.  Other R1x0-based systems
>> don't (although, I might be wrong about IP27's successor in IP35).
> 
> ioremap() must return a CPU virtual address.  It can take advantage of 
> arch-specific features, special address ranges that are uncached, special 
> identity mappings, or whatever, but from the caller's point of view, the 
> return value must be usable as a virtual address without any special 
> handling.

Apparently, MIPS's implementation of ioremap does not guarantee that a virtual
address is always returned.  Quoting from arch/mips/include/asm/io.h around
line #236:

/*
 * ioremap     -   map bus memory into CPU space
 * @offset:    bus address of the memory
 * @size:      size of the resource to map
 *
 * ioremap performs a platform specific sequence of operations to
 * make bus memory CPU accessible via the readb/readw/readl/writeb/
 * writew/writel functions and the other mmio helpers. The returned
 * address is not guaranteed to be usable directly as a virtual
 * address.
 */

It looks like the qla1280.c driver calls pci_ioremap_bar(), which calls
ioremap_nocache(), and on MIPS, that's just an alias (as far as I can tell) to
ioremap(), and it has the same limitation, that the address returned may not
be usable as a CPU virtual address.


> This is from ip27-dmesg-working_pci-20170208.txt:
> 
>   PCI host bridge to bus 0002:00
>   pci_bus 0002:00: root bus resource [mem 0x920000000f200000-0x920000000f9fffff]
>   pci_bus 0002:00: root bus resource [io  0x920000000fa00000-0x920000000fbfffff]
>   pci_bus 0002:00: root bus resource [bus 02-ff]
>   pci 0002:00:00.0: [1077:1020] type 00 class 0x010000
>   pci 0002:00:00.0: reg 0x10: [io  0xf200000-0xf2000ff]
>   pci 0002:00:00.0: reg 0x14: [mem 0x0f200000-0x0f200fff]
>   pci 0002:00:00.0: reg 0x30: [mem 0x00000000-0x0000ffff pref]
> 
> There's something wrong here: all the resources printed above, including the
> BARs, should be CPU physical addresses (as are all the /proc/iomem 
> addresses).  The "root bus resources" are windows through the host bridge to
> PCI.  The BAR resources should be inside those windows.
> 
> I'm sure the bridge translates between CPU physical addresses and PCI bus 
> addresses, probably by chopping off all those high-order bits.  The PCI core
> needs to know about this, and it looks like pcibios_scanbus() is trying to
> tell it by using pci_add_resource_offset().  But the PCI core isn't getting
> the message because we don't see the "(bus address [%#010llx-%#010llx])"
> being printed by pci_register_host_bridge().
> 
> A correct dmesg log would look something like this:
> 
>   PCI host bridge to bus 0002:00
>   pci_bus 0002:00: root bus resource [mem 0x920000000f200000-0x920000000f9fffff]
> (bus address [0x0f200000-0x0f9fffff])
>   pci 0002:00:00.0: reg 0x14: [mem 0x920000000f200000-0x920000000f200fff]
> 
> This would mean that for 0002:00:00.0, pdev->resource[1] contains the CPU 
> physical address 0x920000000f200000, and the host bridge translates that to 
> 0x0f200000, which is what the 32-bit BAR1 would contain.
> 
> I think "lspci" should show you the CPU addresses (0x920000000f200000) and 
> "lspci -b" should show you the actual BAR values (0x0f200000).
> 
> Your dmesg log is showing you 0x0f200000, which is probably the BAR value. 
> __pci_read_base() reads the BAR value and runs it through 
> pcibios_bus_to_resource(), which *should* be converting it to 
> 0x920000000f200000 (the reverse of the translation done by the host bridge).
> But since the PCI core doesn't know about that translation, 
> pcibios_bus_to_resource() does nothing.
> 
> So I think there's something wrong with the way you're using 
> pci_add_resource_offset().

This is basically the same conclusion I've come to.  I've found a "partial"
solution, but I'm pretty sure it's wrong.

It seems the reason IP30 works without PCI_PROBE_ONLY now is because it doesn't
need special casing on the addresses in order to work.  IP27, on the other
hand, needs all I/O accesses to go through the 0x92xxx range or you'll run into
hardware-enforced barriers that will panic the kernel.

First attempt I did was to simply subtract NODE_IO_BASE(_n) from the address
values that ultimately get fed to pci_add_resource_offset().  That yields this
kind of output:

[    8.065146] PCI host bridge to bus 0000:00
[    8.113572] pci_bus 0000:00: root bus resource [mem 0x0b200000-0x0b9fffff]
[    8.196284] pci_bus 0000:00: root bus resource [io  0xba00000-0xbbfffff]
[    8.276934] pci_bus 0000:00: root bus resource [bus 00-ff]
[    8.343199] PCI host bridge to bus 0001:00
[    8.392144] pci_bus 0001:00: root bus resource [mem 0x0c200000-0x0c9fffff]
[    8.474899] pci_bus 0001:00: root bus resource [io  0xca00000-0xcbfffff]
[    8.555520] pci_bus 0001:00: root bus resource [bus 01-ff]
[    8.622536] pci 0001:00:00.0: can't claim BAR 0 [mem 0x00000000-0x07ffffff]: no compatible bridge window
[    8.735665] pci 0001:00:01.0: can't claim BAR 0 [mem 0x00000000-0x07ffffff]: no compatible bridge window
[    8.850128] PCI host bridge to bus 0002:00
[    8.899049] pci_bus 0002:00: root bus resource [mem 0x0f200000-0x0f9fffff]
[    8.981794] pci_bus 0002:00: root bus resource [io  0xfa00000-0xfbfffff]
[    9.062413] pci_bus 0002:00: root bus resource [bus 02-ff]
[    9.130425] pci 0002:00:00.0: can't claim BAR 0 [io  0xf200000-0xf2000ff]: no compatible bridge window
[    9.240674] pci 0002:00:00.0: can't claim BAR 6 [mem 0x00000000-0x0000ffff pref]: no compatible bridge window
[    9.360079] pci 0002:00:01.0: can't claim BAR 0 [io  0xf400000-0xf4000ff]: no compatible bridge window
[    9.472148] pci 0002:00:01.0: can't claim BAR 6 [mem 0x00000000-0x0000ffff pref]: no compatible bridge window
[    9.591555] pci 0002:00:06.0: can't claim BAR 0 [mem 0x0fa00000-0x0fafffff]: no compatible bridge window
[    9.705685] pci 0002:00:07.0: can't claim BAR 0 [mem 0x00000000-0x00001fff]: no compatible bridge window
[    9.819933] qla1280: QLA1040 found on PCI bus 0, dev 0
[    9.881644] PCI: Enabling device 0002:00:00.0 (0006 -> 0007)

Despite the above errors, it succeeds in probing and finds devices and boots
into userland.  The error message above stems from 'pci_claim_resource' in
drivers/pci/setup-res.c because it can't seem to find the parent bridge.  Not
sure if that's good or bad.  But it does boot, and it would remove one of the
two #ifdef hacks in my patch.

So I next looked at the offset bit you mentioned, and after some fiddling
around in pci-bridge.c, got this dmesg output, which matches what you say
should be the correct dmesg output:

[    8.095560] PCI host bridge to bus 0000:00
[    8.143949] pci_bus 0000:00: root bus resource [mem 0x920000000b200000-0x920000000b9fffff] (bus address [0x0b200000-0x0b9fffff])
[    8.283216] pci_bus 0000:00: root bus resource [io  0x920000000ba00000-0x920000000bbfffff] (bus address [0xba00000-0xbbfffff])
[    8.420442] pci_bus 0000:00: root bus resource [bus 00-ff]
[    8.486711] PCI host bridge to bus 0001:00
[    8.535656] pci_bus 0001:00: root bus resource [mem 0x920000000c200000-0x920000000c9fffff] (bus address [0x0c200000-0x0c9fffff])
[    8.674965] pci_bus 0001:00: root bus resource [io  0x920000000ca00000-0x920000000cbfffff] (bus address [0xca00000-0xcbfffff])
[    8.812144] pci_bus 0001:00: root bus resource [bus 01-ff]
[    8.879140] pci 0001:00:00.0: can't claim BAR 0 [mem 0x00000000-0x07ffffff]: no compatible bridge window
[    8.992298] pci 0001:00:01.0: can't claim BAR 0 [mem 0x00000000-0x07ffffff]: no compatible bridge window
[    9.106732] PCI host bridge to bus 0002:00
[    9.155679] pci_bus 0002:00: root bus resource [mem 0x920000000f200000-0x920000000f9fffff] (bus address [0x0f200000-0x0f9fffff])
[    9.294974] pci_bus 0002:00: root bus resource [io  0x920000000fa00000-0x920000000fbfffff] (bus address [0xfa00000-0xfbfffff])
[    9.432168] pci_bus 0002:00: root bus resource [bus 02-ff]
[    9.500118] pci 0002:00:00.0: can't claim BAR 0 [io  0xf200000-0xf2000ff]: no compatible bridge window
[    9.610326] pci 0002:00:00.0: can't claim BAR 6 [mem 0x00000000-0x0000ffff pref]: no compatible bridge window
[    9.729688] pci 0002:00:01.0: can't claim BAR 0 [io  0xf400000-0xf4000ff]: no compatible bridge window
[    9.841764] pci 0002:00:01.0: can't claim BAR 6 [mem 0x00000000-0x0000ffff pref]: no compatible bridge window
[    9.961151] pci 0002:00:06.0: can't claim BAR 0 [mem 0x0fa00000-0x0fafffff]: no compatible bridge window
[   10.075344] pci 0002:00:07.0: can't claim BAR 0 [mem 0x00000000-0x00001fff]: no compatible bridge window
[   10.189528] qla1280: QLA1040 found on PCI bus 0, dev 0
[   10.251300] PCI: Enabling device 0002:00:00.0 (0006 -> 0007)
[   10.320129] Unhandled kernel unaligned access[#1]:
[   10.376908] CPU: 1 PID: 1 Comm: swapper/0 Not tainted 4.10.0-rc7-mipsgit-20170208 #24
[   10.471163] task: a8000000e077c880 task.stack: a8000000e0780000
[   10.542378] $ 0   : 0000000000000000 0000000000024680 0000000000000000 0000000000000000
[   10.638730] $ 4   : 000000000065e0c0 0000000000000010 a800000000450a18 240000000f20000a
[   10.735084] $ 8   : a8000000007a3978 a8000000e00c05b0 0000000000000000 a80000000145ef30
[   10.831440] $12   : ffffffff94005ce1 000000001000001e ffffffffffffff80 00000000007e0000
[   10.927796] $16   : a8000000e078f920 a800000000450a14 0000000000000000 ffffffffa4600000
[   11.024149] $20   : 240000000f20000a a8000000004509b8 a8000000006b9930 a8000000007eb1b8
[   11.120506] $24   : 0000000000940000 00000000007e0000
[   11.216860] $28   : a8000000e0780000 a8000000e078f8d0 a8000000e00c1650 a800000000024680
[   11.313216] Hi    : 0000000000000000
[   11.356156] Lo    : 0000000000002800
[   11.399117] epc   : a80000000002de44 do_ade+0x4f4/0x960
[   11.461952] ra    : a800000000024680 ret_from_exception+0x0/0x18
[   11.534204] Status: 94005ce3 KX SX UX KERNEL EXL IE
[   11.593903] Cause : 00008014 (ExcCode 05)
[   11.642080] BadVA : 240000000f20000b
[   11.685020] PrId  : 00000f14 (R14000)

And you can see that while the dmesg output is correct, the end result is not.
The issue goes back to what MIPS's ioremap() is doing when it encounters the
specialized cached-uncached attribute of the R1x0k CPUs on IP27, it tries
adding 0x9200000000000000, which is IP27's IO_BASE, to one of the addresses
during qla1280's probe, which wraps around to 0x240000000xxxxxxx and is
invalid in MIPS.  This leads to the unhandled kernel unaligned access panic.

I tried implementing a custom plat_ioremap() that would subtract the IO_BASE
off of the address being ioremapped by qla1280.  MIPS has a generic template
available to do this in arch/mips/include/asm/mach-generic/ioremap.h, but it
appears my gcc version is recent enough to have some new checks enabled that
choke on casting a phys_addr_t to void __iomem * (-Wint-to-pointer-cast), and
I've given up finding a workaround that doesn't involve invasive changes to
MIPS's ioremapping core.

--J
