Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mout.gmx.net ([212.227.17.21]:56550 "EHLO mout.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753417Ab3EaUq3 (ORCPT <rfc822;linux-pci@vger.kernel.org>);
	Fri, 31 May 2013 16:46:29 -0400
Received: from mailout-de.gmx.net ([10.1.76.24]) by mrigmx.server.lan
 (mrigmx002) with ESMTP (Nemesis) id 0Lbx7K-1U1n0B2JxU-00jK4Y for
 <linux-pci@vger.kernel.org>; Fri, 31 May 2013 22:46:27 +0200
Message-ID: <51A90C21.7010602@gmx.de>
Date: Fri, 31 May 2013 22:46:25 +0200
From: Helge Deller <deller@gmx.de>
MIME-Version: 1.0
To: Bjorn Helgaas <bhelgaas@google.com>
CC: linux-parisc@vger.kernel.org, linux-pci@vger.kernel.org
Subject: Re: [PATCH] parisc/PCI: lba: fix: convert to pci_create_root_bus()
 for correct root bus resources
References: <20130530141033.GA3665@ls3530.box> <CAErSpo69AxKgz8Dg8+T7n5jsuOzdSoCUstqrX+uUh8TZ08ayqg@mail.gmail.com> <51A7ACBF.4030601@gmx.de> <20130530211244.GA28735@google.com> <51A7C763.4080704@gmx.de>
In-Reply-To: <51A7C763.4080704@gmx.de>
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On 05/30/2013 11:40 PM, Helge Deller wrote:
> On 05/30/2013 11:12 PM, Bjorn Helgaas wrote:
>> On Thu, May 30, 2013 at 09:47:11PM +0200, Helge Deller wrote:
>>> Maybe you could help me with another problem which I have with my C3000 as well?
>>>
>>> That's the current log:
>>> Found devices:
>>> 1. Astro BC Runway Port at 0xfffffffffed00000 [10] { 12, 0x0, 0x582, 0x0000b }
>>> 2. Elroy PCI Bridge at 0xfffffffffed30000 [10/0] { 13, 0x0, 0x782, 0x0000a }
>>> 3. Elroy PCI Bridge at 0xfffffffffed32000 [10/1] { 13, 0x0, 0x782, 0x0000a }
>>> 4. Elroy PCI Bridge at 0xfffffffffed38000 [10/4] { 13, 0x0, 0x782, 0x0000a }
>>> 5. Elroy PCI Bridge at 0xfffffffffed3c000 [10/6] { 13, 0x0, 0x782, 0x0000a }
>>> 6. Allegro W2 at 0xfffffffffffa0000 [32] { 0, 0x0, 0x5dc, 0x00004 }
>>> 7. Memory at 0xfffffffffed10200 [49] { 1, 0x0, 0x09c, 0x00009 }
>>> CPU(s): 1 x PA8700 (PCX-W2) at 750.000000 MHz
>>> Whole cache flush 492314 cycles, flushing 7983104 bytes 1594427 cycles
>>> Setting cache flush threshold to 180000 (1 CPUs online)
>>> SBA found Astro 2.1 at 0xfffffffffed00000
>>
>>> Elroy version TR4.0 (0x5) found at 0xfffffffffed30000
>>> LBA 10:0: PCI host bridge to bus 0000:00
>>> pci_bus 0000:00: root bus resource [io  0x0000-0x1fff]
>>> pci_bus 0000:00: root bus resource [mem 0xfffffffff2000000-0xfffffffff23fffff] (bus address [0xf2000000-0xf23fffff])
>>> pci_bus 0000:00: root bus resource [bus 00]
>>> pci 0000:00:0c.0: [1011:0019] type 00 class 0x020000
>>> pci 0000:00:0c.0: reg 10: [io  0x1000-0x107f]
>>> pci 0000:00:0c.0: reg 14: [mem 0xfffffffff2008000-0xfffffffff20083ff]
>>> pci 0000:00:0c.0: reg 30: [mem 0xfffffffff2040000-0xfffffffff207ffff pref]
>>> pci 0000:00:0d.0: [11d4:1889] type 00 class 0x040100
>>> pci 0000:00:0d.0: reg 10: [mem 0xfffffffff200c000-0xfffffffff200c1ff pref]
>>> pci 0000:00:0d.0: reg 14: [mem 0xfffffffff200b000-0xfffffffff200b00f pref]
>>> pci 0000:00:0d.0: reg 18: [mem 0xfffffffff200a000-0xfffffffff200a00f pref]
>>> pci 0000:00:0d.0: reg 1c: [mem 0xfffffffff2009000-0xfffffffff200900f pref]
>>> pci 0000:00:0d.0: supports D2
>>> pci 0000:00:0e.0: [100b:0002] type 00 class 0x01018a
>>> PCI: Enabled native mode for NS87415 (pif=0x8f)
>>> pci 0000:00:0e.0: reg 10: [io  0x0f00-0x0f07]
>>> pci 0000:00:0e.0: reg 14: [io  0x0e00-0x0e03]
>>> pci 0000:00:0e.0: reg 18: [io  0x0d00-0x0d07]
>>> pci 0000:00:0e.0: reg 1c: [io  0x0b00-0x0b03]
>>> pci 0000:00:0e.0: reg 20: [io  0x0a00-0x0a0f]
>>> pci 0000:00:0e.1: [100b:000e] type 00 class 0x068000
>>> pci 0000:00:0e.2: [100b:0012] type 00 class 0x0c0310
>>> pci 0000:00:0e.2: reg 10: [mem 0xfffffffff2007000-0xfffffffff2007fff]
>>> pci 0000:00:0e.2: reg 14: [mem 0xfffffffff2006000-0xfffffffff2006fff]
>>> pci 0000:00:0f.0: [1000:000b] type 00 class 0x010000
>>> pci 0000:00:0f.0: reg 10: [io  0x0900-0x09ff]
>>> pci 0000:00:0f.0: reg 14: [mem 0xfffffffff2005000-0xfffffffff20053ff 64bit]
>>> pci 0000:00:0f.0: reg 1c: [mem 0xfffffffff2002000-0xfffffffff2003fff 64bit]
>>> pci 0000:00:0f.0: supports D1 D2
>>> pci 0000:00:0f.1: [1000:000b] type 00 class 0x010000
>>> pci 0000:00:0f.1: reg 10: [io  0x0800-0x08ff]
>>> pci 0000:00:0f.1: reg 14: [mem 0xfffffffff2004000-0xfffffffff20043ff 64bit]
>>> pci 0000:00:0f.1: reg 1c: [mem 0xfffffffff2000000-0xfffffffff2001fff 64bit]
>>> pci 0000:00:0f.1: supports D1 D2
>>
>>> Elroy version TR4.0 (0x5) found at 0xfffffffffed32000
>>> LBA 10:1: PCI host bridge to bus 0000:01
>>> pci_bus 0000:01: root bus resource [io  0x12000-0x13fff] (bus address [0x2000-0x3fff])
>>> pci_bus 0000:01: root bus resource [mem 0xfffffffff6000000-0xfffffffff6ffffff] (bus address [0xf6000000-0xf6ffffff])
>>
>> 16MB window (probably "directed range").
>>
>>> pci_bus 0000:01: root bus resource [mem 0xfffffffff2400000-0xfffffffff27fffff] (bus address [0xf2400000-0xf27fffff])
>>
>> 4MB window (probably "distributed range").
>>
>>> pci_bus 0000:01: root bus resource [bus 01-02]
>>> pci 0000:01:04.0: [103c:1005] type 00 class 0x038000
>>> pci 0000:01:04.0: reg 10: [mem 0xf6000000-0xf7ffffff]
>>
>> This BAR requires 32MB, so it doesn't fit inside the window.
>>
>> Has this device ever worked on Linux, or do you know if it works on HP-UX?
> 
> Yes, that's a simple HP graphics framebuffer card for HP-UX:
> 01:04.0 Display controller: Hewlett-Packard Company A4977A Visualize EG (rev 03)
>         Flags: 66MHz, medium devsel
>         Memory at f6000000 (32-bit, non-prefetchable) [size=32M]
>         Expansion ROM at f2400000 [disabled] [size=64K]
> 
>> If so, our idea of the LBA 10:1 bridge windows is probably wrong.  There
>> is no generic mechanism for LBA window workarounds (i.e., nothing like
>> the PCI quirk mechanism), but you might be able to detect and work
>> around this issue in lba_pat_resources() or lba_legacy_resources().
>> Of course, you have to know where to get the correct window info.  It
>> looks like lba_legacy_resources() reads that directly from hardware
>> via sba_distributed_lmmio() and sba_directed_lmmio().  I'd be surprised
>> if the hardware registers gave the wrong values, since they're probably
>> used directly for routing.
>>
>>> pci 0000:01:04.0: reg 30: [mem 0xfffffffff2400000-0xfffffffff240ffff pref]
>>> pci 0000:01:05.0: [121a:0002] type 00 class 0x040000
>>> pci 0000:01:05.0: reg 10: [mem 0xf8000000-0xf8ffffff pref]
>>
>> Also wrong because it doesn't fit in any window we know about.
> 
> 01:05.0 Multimedia video controller: 3Dfx Interactive, Inc. Voodoo 2 (rev 02)
>         Flags: fast devsel
>         Memory at f8000000 (32-bit, prefetchable) [size=16M]
> 
> -> from PC. IIRC, it worked once for me under Linux in this machine (when the C3000 workaround worked).
> 
>>> pci 0000:01:06.0: [3388:0021] type 01 class 0x060400
>>> pci 0000:01:06.0: supports D1 D2
>>> pci 0000:01:06.0: PME# supported from D1 D2 D3hot D3cold
> 
> 01:06.0 PCI bridge: Hint Corp HB6 Universal PCI-PCI bridge (non-transparent mode) (rev 12) (prog-if 00 [Normal decode])
>         Flags: bus master, fast Back2Back, medium devsel, latency 255
>         Bus: primary=01, secondary=02, subordinate=02, sec-latency=255
>         I/O behind bridge: 00000000-00000fff
>         Memory behind bridge: f9000000-fbffffff
>         Prefetchable memory behind bridge: ffffffff00000000-ffffffff000fffff
>         Capabilities: [80] Power Management version 2
>         Capabilities: [90] CompactPCI hot-swap <?>
>         Capabilities: [a0] Vital Product Data
> 
> -> I don't know any longer what that is.
> Will plug it out.
> 
>>> pci 0000:01:04.0: no compatible bridge window for [mem 0xf6000000-0xf7ffffff]
>>>
>>> ^^ HERE ^^^
>>> That's actually the problem.
>>> pci 0000:01:04.0, pci 0000:01:05.0 and maybe pci 0000:01:06.0 should be:
>>> pci 0000:00:04.0, pci 0000:00:05.0 and maybe pci 0000:00:06.0.
>>>
>>> This problem is documented in lba_pci.c as a bug on the C3000 machines, that
>>> everything listed under PCI02 actually lives under PCI00.
>>> Just search for the lengthy comment in lba_pci.c (search for keyword C3000).
>>>
>>> Can you maybe give me some hints how I can build a proper workaround for that problem?
>>> Is there any similar workaround in the pci codebase which I haven't found yet?
>>> The reference code in lba_pci.c doesn't compile any longer, but maybe 
>>> it's possible to reactivate it somehow?
>>>
>>>
>>> iosapic: no IRTE for 0000:01:04.0 (IRQ not connected?)
>>> pci 0000:01:05.0: no compatible bridge window for [mem 0xf8000000-0xf8ffffff pref]
>>> iosapic: no IRTE for 0000:01:05.0 (IRQ not connected?)
>>> pci_bus 0000:02: busn_res: can not insert [bus 02-ff] under [bus 01-02] (conflicts with (null) [bus 01-02])
>>
>> The PCI core does know that LBA 10:0 leads only to [bus 01-02], but maybe
>> we try to set the end of the range higher during enumeration, in case we
>> find bridges?  We *shouldn't* go past bus 02 though, because then we might
>> falsely believe a device on bus 03 was under this LBA.  I'm not sure what's
>> going on here.
>>
>>> pci 0000:02:00.0: [102b:0525] type 00 class 0x030000
>>> pci 0000:02:00.0: reg 10: [mem 0xfa000000-0xfbffffff pref]
>>> pci 0000:02:00.0: reg 14: [mem 0xf9800000-0xf9803fff]
>>> pci 0000:02:00.0: reg 18: [mem 0xf9000000-0xf97fffff]
>>> pci 0000:02:00.0: reg 30: [mem 0xf9820000-0xf983ffff pref]
>>
>> These are all wrong, too.
>>
>>> pci 0000:01:06.0: PCI bridge to [bus 02-ff]
>>>
>>> ^^^^ HERE ^^^^
>>> Should this be something like (in **): ?
>>>    pci 0000:01:06.0: PCI bridge to *BUS 02-ff* [bus 02-ff
>>> But probably it's related to the C3000 bug mentioned above.
>>>    
>>>
>>> pci 0000:01:06.0:   bridge window [io  0x0000-0x0fff]
>>
>> Something's wrong here, too.  The host bridge I/O window is
>> [io  0x12000-0x13fff] (bus address [0x2000-0x3fff]), and this
>> P2P bridge window is not inside it.
>>
>>> pci 0000:01:06.0:   bridge window [mem 0xf9000000-0xfbffffff]
>>
>> This looks wrong, too.
>>
>>> pci 0000:01:06.0:   bridge window [mem 0xffffffff00000000-0xffffffff000fffff 64bit pref]
>>> pci 0000:01:06.0: address space collision: [io  0x0000-0x0fff] conflicts with PCI01 Ports [io  0x12000-0x13fff]
>>> pci 0000:01:06.0: no compatible bridge window for [mem 0xf9000000-0xfbffffff]
>>> pci 0000:01:06.0: no compatible bridge window for [mem 0xffffffff00000000-0xffffffff000fffff 64bit pref]
>>> pci 0000:01:06.0: no compatible bridge window for [??? 0x00000000 flags 0x0]
>>
>> I don't know what's going on here -- looks like that resource is all zeroes?
>>
>>> pci_bus 0000:02: busn_res: [bus 02-ff] end is updated to 02
>>> pci 0000:01:06.0: device not available (can't reserve [io  0x0000-0x0fff])
>>> pci 0000:01:06.0: Error enabling bridge (-22), continuing
> 
>>> Elroy version TR4.0 (0x5) found at 0xfffffffffed38000
>>> LBA 10:4: PCI host bridge to bus 0000:03
>>> pci_bus 0000:03: root bus resource [io  0x28000-0x29fff] (bus address [0x8000-0x9fff])
>>> pci_bus 0000:03: root bus resource [mem 0xfffffffff3000000-0xfffffffff33fffff] (bus address [0xf3000000-0xf33fffff])
>>> pci_bus 0000:03: root bus resource [bus 03]
>>> pci 0000:03:01.0: [12ae:0001] type 00 class 0x020000
>>> pci 0000:03:01.0: reg 10: [mem 0xfffffffff3000000-0xfffffffff3003fff]
>>> pci 0000:03:03.0: [1011:0019] type 00 class 0x020000
>>> pci 0000:03:03.0: reg 10: [io  0x28000-0x2807f]
>>> pci 0000:03:03.0: reg 14: [mem 0xfffffffff3004000-0xfffffffff300407f]
>>> pci 0000:03:03.0: reg 30: [mem 0xfffffffff3040000-0xfffffffff307ffff pref]
>>> Elroy version TR4.0 (0x5) found at 0xfffffffffed3c000
>>> .....
>>
>> Wow, this is a real train wreck.  Has this configuration ever worked under
>> Linux?  Does it work under HP-UX?
> 
> I think all devices beside 01:06.0 worked under Linux in the past.
> I'll take out the 01:06.0 and try again.
> 
>>  Maybe it has devices that aren't
>> officially supported and the firmware did the wrong thing?  (Though it'd
>> still be nice if Linux did something more sensible than this.)

Ok, I removed all unnecessary cards, incl. 100MBit NIC, 1000MBit NIC, Matrox G200 and a Visualize FX.

Now it works nicely and as expected.
Even the Visualize EG graphics card and the Voodo2 work (which were my main problem) :-)


THANKS!


Found devices:
1. Astro BC Runway Port at 0xfffffffffed00000 [10] { 12, 0x0, 0x582, 0x0000b }
2. Elroy PCI Bridge at 0xfffffffffed30000 [10/0] { 13, 0x0, 0x782, 0x0000a }
3. Elroy PCI Bridge at 0xfffffffffed32000 [10/1] { 13, 0x0, 0x782, 0x0000a }
4. Elroy PCI Bridge at 0xfffffffffed38000 [10/4] { 13, 0x0, 0x782, 0x0000a }
5. Elroy PCI Bridge at 0xfffffffffed3c000 [10/6] { 13, 0x0, 0x782, 0x0000a }
6. Allegro W2 at 0xfffffffffffa0000 [32] { 0, 0x0, 0x5dc, 0x00004 }
7. Memory at 0xfffffffffed10200 [49] { 1, 0x0, 0x09c, 0x00009 }
CPU(s): 1 x PA8700 (PCX-W2) at 750.000000 MHz
SBA found Astro 2.1 at 0xfffffffffed00000
Elroy version TR4.0 (0x5) found at 0xfffffffffed30000
LBA 10:0: PCI host bridge to bus 0000:00
pci_bus 0000:00: root bus resource [io  0x0000-0x1fff]
pci_bus 0000:00: root bus resource [mem 0xfffffffff4000000-0xfffffffff47fffff] (bus address [0xf4000000-0xf47fffff])
pci_bus 0000:00: root bus resource [bus 00]
pci 0000:00:0c.0: [1011:0019] type 00 class 0x020000
pci 0000:00:0c.0: reg 10: [io  0x1000-0x107f]
pci 0000:00:0c.0: reg 14: [mem 0xfffffffff4008000-0xfffffffff40083ff]
pci 0000:00:0c.0: reg 30: [mem 0xfffffffff4040000-0xfffffffff407ffff pref]
pci 0000:00:0d.0: [11d4:1889] type 00 class 0x040100
pci 0000:00:0d.0: reg 10: [mem 0xfffffffff400c000-0xfffffffff400c1ff pref]
pci 0000:00:0d.0: reg 14: [mem 0xfffffffff400b000-0xfffffffff400b00f pref]
pci 0000:00:0d.0: reg 18: [mem 0xfffffffff400a000-0xfffffffff400a00f pref]
pci 0000:00:0d.0: reg 1c: [mem 0xfffffffff4009000-0xfffffffff400900f pref]
pci 0000:00:0d.0: supports D2
pci 0000:00:0e.0: [100b:0002] type 00 class 0x01018a
PCI: Enabled native mode for NS87415 (pif=0x8f)
pci 0000:00:0e.0: reg 10: [io  0x0f00-0x0f07]
pci 0000:00:0e.0: reg 14: [io  0x0e00-0x0e03]
pci 0000:00:0e.0: reg 18: [io  0x0d00-0x0d07]
pci 0000:00:0e.0: reg 1c: [io  0x0b00-0x0b03]
pci 0000:00:0e.0: reg 20: [io  0x0a00-0x0a0f]
pci 0000:00:0e.1: [100b:000e] type 00 class 0x068000
pci 0000:00:0e.2: [100b:0012] type 00 class 0x0c0310
pci 0000:00:0e.2: reg 10: [mem 0xfffffffff4007000-0xfffffffff4007fff]
pci 0000:00:0e.2: reg 14: [mem 0xfffffffff4006000-0xfffffffff4006fff]
pci 0000:00:0f.0: [1000:000b] type 00 class 0x010000
pci 0000:00:0f.0: reg 10: [io  0x0900-0x09ff]
pci 0000:00:0f.0: reg 14: [mem 0xfffffffff4005000-0xfffffffff40053ff 64bit]
pci 0000:00:0f.0: reg 1c: [mem 0xfffffffff4002000-0xfffffffff4003fff 64bit]
pci 0000:00:0f.0: supports D1 D2
pci 0000:00:0f.1: [1000:000b] type 00 class 0x010000
pci 0000:00:0f.1: reg 10: [io  0x0800-0x08ff]
pci 0000:00:0f.1: reg 14: [mem 0xfffffffff4004000-0xfffffffff40043ff 64bit]
pci 0000:00:0f.1: reg 1c: [mem 0xfffffffff4000000-0xfffffffff4001fff 64bit]
pci 0000:00:0f.1: supports D1 D2
Elroy version TR4.0 (0x5) found at 0xfffffffffed32000
LBA 10:1: PCI host bridge to bus 0000:01
pci_bus 0000:01: root bus resource [io  0x12000-0x13fff] (bus address [0x2000-0x3fff])
pci_bus 0000:01: root bus resource [mem 0xfffffffffa000000-0xfffffffffbffffff] (bus address [0xfa000000-0xfbffffff])
pci_bus 0000:01: root bus resource [mem 0xfffffffff4800000-0xfffffffff4ffffff] (bus address [0xf4800000-0xf4ffffff])
pci_bus 0000:01: root bus resource [bus 01]
pci 0000:01:04.0: [103c:1005] type 00 class 0x038000
pci 0000:01:04.0: reg 10: [mem 0xfffffffffa000000-0xfffffffffbffffff]
pci 0000:01:04.0: reg 30: [mem 0xfffffffff4800000-0xfffffffff480ffff pref]
iosapic: hpa not registered for 0000:01:04.0
Elroy version TR4.0 (0x5) found at 0xfffffffffed38000
LBA 10:4: PCI host bridge to bus 0000:02
pci_bus 0000:02: root bus resource [io  0x28000-0x29fff] (bus address [0x8000-0x9fff])
pci_bus 0000:02: root bus resource [mem 0xfffffffff9000000-0xfffffffff9ffffff] (bus address [0xf9000000-0xf9ffffff])
pci_bus 0000:02: root bus resource [mem 0xfffffffff6000000-0xfffffffff67fffff] (bus address [0xf6000000-0xf67fffff])
pci_bus 0000:02: root bus resource [bus 02]
pci 0000:02:03.0: [121a:0002] type 00 class 0x040000
pci 0000:02:03.0: reg 10: [mem 0xfffffffff9000000-0xfffffffff9ffffff pref]
iosapic: hpa not registered for 0000:02:03.0
Elroy version TR4.0 (0x5) found at 0xfffffffffed3c000
LBA 10:6: PCI host bridge to bus 0000:03
pci_bus 0000:03: root bus resource [io  0x3c000-0x3dfff] (bus address [0xc000-0xdfff])
pci_bus 0000:03: root bus resource [mem 0xfffffffff7000000-0xfffffffff77fffff] (bus address [0xf7000000-0xf77fffff])
pci_bus 0000:03: root bus resource [bus 03]
.....
.....
STI GSC/PCI core graphics driver Version 0.9a
sti 0000:01:04.0: enabling SERR and PARITY (0002 -> 0142)
STI PCI graphic ROM found at fffffffff4800000 (64 kB), fb at fffffffffa000000 (32 MB)
    id 2d08c0a7-9a02587, conforms to spec rev. 8.0a
    graphics card name: PCI_GRAFFITIX1024
sticon: Initializing STI text console.
Console: switching to colour STI console 128x48
Console: switching to colour frame buffer device 128x48
fb0: stifb 1024x768-8 frame buffer device, PCI_GRAFFITIX1024, id: 2d08c0a7, mmio: 0xfffffffffa100000
sstfb 0000:02:03.0: enabling SERR and PARITY (0002 -> 0142)
Voodoo2 (revision 2) with ICS ICS5342 dac
framebuffer at 0xfffffffff9400000, mapped to 0x0000000000700000, size 2MB
fb1: Voodoo2 frame buffer device at 0x0000000000700000
.....

lspci -v:
---------
00:0c.0 Ethernet controller: Digital Equipment Corporation DECchip 21142/43 (rev 41)
	Subsystem: Hewlett-Packard Company Device 104f
	Flags: bus master, medium devsel, latency 255, IRQ 65
	I/O ports at 1000 [size=128]
	Memory at fffffffff4008000 (32-bit, non-prefetchable) [size=1K]
	Expansion ROM at fffffffff4040000 [disabled] [size=256K]
	Kernel driver in use: tulip

00:0d.0 Multimedia audio controller: Analog Devices AD1889 sound chip
	Subsystem: Analog Devices AD1889 sound chip
	Flags: bus master, medium devsel, latency 255, IRQ 66
	Memory at fffffffff400c000 (32-bit, prefetchable) [size=512]
	Memory at fffffffff400b000 (32-bit, prefetchable) [size=16]
	Memory at fffffffff400a000 (32-bit, prefetchable) [size=16]
	Memory at fffffffff4009000 (32-bit, prefetchable) [size=16]
	Capabilities: [dc] Power Management version 1

00:0e.0 IDE interface: National Semiconductor Corporation 87415/87560 IDE (rev 03) (prog-if 8f [Master SecP SecO PriP PriO])
	Flags: bus master, medium devsel, latency 255, IRQ 7
	I/O ports at 0f00 [size=8]
	I/O ports at 0e00 [size=4]
	I/O ports at 0d00 [size=8]
	I/O ports at 0b00 [size=4]
	I/O ports at 0a00 [size=16]
	Kernel driver in use: NS87415_IDE

00:0e.1 Bridge: National Semiconductor Corporation 87560 Legacy I/O (rev 01)
	Flags: bus master, medium devsel, latency 255, IRQ 67
	Kernel driver in use: SuperIO

00:0e.2 USB controller: National Semiconductor Corporation USB Controller (rev 02) (prog-if 10 [OHCI])
	Flags: bus master, medium devsel, latency 240, IRQ 1
	Memory at fffffffff4007000 (32-bit, non-prefetchable) [size=4K]
	Memory at fffffffff4006000 (32-bit, non-prefetchable) [size=4K]
	Kernel driver in use: ohci_hcd

00:0f.0 SCSI storage controller: LSI Logic / Symbios Logic 53C896/897 (rev 07)
	Subsystem: LSI Logic / Symbios Logic LSI53C896/7 PCI to Dual Channel Ultra2 SCSI Multifunction Controller
	Flags: bus master, medium devsel, latency 255, IRQ 68
	I/O ports at 0900 [size=256]
	Memory at fffffffff4005000 (64-bit, non-prefetchable) [size=1K]
	Memory at fffffffff4002000 (64-bit, non-prefetchable) [size=8K]
	Capabilities: [40] Power Management version 2
	Kernel driver in use: sym53c8xx

00:0f.1 SCSI storage controller: LSI Logic / Symbios Logic 53C896/897 (rev 07)
	Subsystem: LSI Logic / Symbios Logic LSI53C896/7 PCI to Dual Channel Ultra2 SCSI Multifunction Controller
	Flags: bus master, medium devsel, latency 255, IRQ 68
	I/O ports at 0800 [size=256]
	Memory at fffffffff4004000 (64-bit, non-prefetchable) [size=1K]
	Memory at fffffffff4000000 (64-bit, non-prefetchable) [size=8K]
	Capabilities: [40] Power Management version 2
	Kernel driver in use: sym53c8xx

01:04.0 Display controller: Hewlett-Packard Company A4977A Visualize EG (rev 03)
	Flags: 66MHz, medium devsel
	Memory at fffffffffa000000 (32-bit, non-prefetchable) [size=32M]
	Expansion ROM at fffffffff4800000 [disabled] [size=64K]
	Kernel driver in use: sti

02:03.0 Multimedia video controller: 3Dfx Interactive, Inc. Voodoo 2 (rev 02)
	Flags: fast devsel
	Memory at fffffffff9000000 (32-bit, prefetchable) [size=16M]
	Kernel driver in use: sstfb
