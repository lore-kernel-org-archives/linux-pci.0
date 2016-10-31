Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from resqmta-po-01v.sys.comcast.net ([96.114.154.160]:57796 "EHLO
        resqmta-po-01v.sys.comcast.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S945937AbcJaThE (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 31 Oct 2016 15:37:04 -0400
From: Joshua Kinard <kumba@gentoo.org>
Subject: Re: [PATCH] MIPS/PCI: Claim bus resources on PCI_PROBE_ONLY set-ups
To: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
References: <20160623221441.3154.31310.stgit@bhelgaas-glaptop2.roam.corp.google.com>
 <20160623221655.3154.89258.stgit@bhelgaas-glaptop2.roam.corp.google.com>
 <6ec8688e-57ed-33b3-3fe0-55d7d69a2c47@gentoo.org>
 <20161017180955.GA28905@red-moon>
 <df80ff94-cb57-6da8-cc54-a8640f16fd0d@gentoo.org>
 <20161019110447.GB1721@red-moon>
Cc: Bjorn Helgaas <bhelgaas@google.com>,
        Ralf Baechle <ralf@linux-mips.org>, linux-mips@linux-mips.org,
        Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
        Jayachandran C <jchandra@broadcom.com>,
        Ganesan Ramalingam <ganesanr@broadcom.com>,
        David Daney <david.daney@cavium.com>,
        linux-pci@vger.kernel.org, Andy Isaacson <adi@hexapodia.org>,
        Yinghai Lu <yinghai@kernel.org>
Message-ID: <0a4b52ab-f31a-15cf-ee2c-b2a7be5ea62a@gentoo.org>
Date: Mon, 31 Oct 2016 15:36:52 -0400
MIME-Version: 1.0
In-Reply-To: <20161019110447.GB1721@red-moon>
Content-Type: text/plain; charset=windows-1252
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On 10/19/2016 07:04, Lorenzo Pieralisi wrote:
> On Mon, Oct 17, 2016 at 08:30:38PM -0400, Joshua Kinard wrote:
>> On 10/17/2016 14:09, Lorenzo Pieralisi wrote:
>>> On Mon, Oct 17, 2016 at 12:36:34AM -0400, Joshua Kinard wrote:
>>>> On 06/23/2016 18:16, Bjorn Helgaas wrote:
>>>>> We claim PCI BAR and bridge window resources in pci_bus_assign_resources(),
>>>>> but when PCI_PROBE_ONLY is set, we treat those resources as immutable and
>>>>> don't call pci_bus_assign_resources(), so the resources aren't put in the
>>>>> resource tree.
>>>>>
>>>>> When the resources aren't in the tree, they don't show up in /proc/iomem,
>>>>> we can't detect conflicts, and we need special cases elsewhere for
>>>>> PCI_PROBE_ONLY or resources without a parent pointer.
>>>>>
>>>>> Claim all PCI BAR and window resources in the PCI_PROBE_ONLY case.
>>>>>
>>>>> If a PCI_PROBE_ONLY platform assigns conflicting resources, Linux can't fix
>>>>> the conflicts.  Previously we didn't notice the conflicts, but now we will,
>>>>> which may expose new failures.
>>>>>
>>>>> Signed-off-by: Bjorn Helgaas <bhelgaas@google.com>
>>>>> ---
>>
>> [snip]
>>
>>>>
>>>> So I finally tested this on two SGI platforms, IP30 and IP27.  For IP30, it
>>>> works fine once I drop the "pci_set_flags(PCI_PROBE_ONLY);" call.  IP30 uses
>>>> standard virtual addressing via ioremap and the like for all of its PCI stuff,
>>>> so it was trivial to fix it.
>>>>
>>>> IP27, on the other hand, is not happy with this change.  I don't know about
>>>> mainline IP27, as that's generally bitrotted and didn't boot the last time I
>>>> tried it, but under the refactored code I'm using that actually boots, this
>>>> platform still needs to bypass *all* attempts to claim or assign the PCI addresses.
>>>>
>>>> I suspect the difference with IP27 is unlike normal systems, IP27 uses special
>>>> physical addresses in the 0x92xxxxxxxxxxxxxx block to address I/O devices, so
>>>> there's no proper ioremap or use of virtual addressing for I/O.  Ralf, does
>>>> this sound correct?
>>>>
>>>> If I use the patches I got plus this change and set PCI_PROBE_ONLY, this is
>>>> what happens:
>>>>
>>>> [   47.299511] PCI host bridge to bus 0001:00
>>>> [   47.348155] pci_bus 0001:00: root bus resource [mem
>>>> 0x920000000f200000-0x920000000f9fffff]
>>>> [   47.447663] pci_bus 0001:00: root bus resource [io
>>>> 0x920000000fa00000-0x920000000fbfffff]
>>>> [   47.547183] pci_bus 0001:00: root bus resource [bus 01-ff]
>>>> [   47.616581] pci 0001:00:00.0: can't claim BAR 0 [io  0xf200000-0xf2000ff]:
>>>> no compatible bridge window
>>>> [   47.726766] pci 0001:00:00.0: can't claim BAR 1 [mem 0x0f200000-0x0f200fff]:
>>>> no compatible bridge window
>>>> [   47.840937] pci 0001:00:00.0: can't claim BAR 6 [mem 0x00000000-0x0000ffff
>>>> pref]: no compatible bridge window
>>>> [   47.960317] pci 0001:00:01.0: can't claim BAR 0 [io  0xf400000-0xf4000ff]:
>>>> no compatible bridge window
>>>> [   48.072399] pci 0001:00:01.0: can't claim BAR 1 [mem 0x0f400000-0x0f400fff]:
>>>> no compatible bridge window
>>>> [   48.186560] pci 0001:00:01.0: can't claim BAR 6 [mem 0x00000000-0x0000ffff
>>>> pref]: no compatible bridge window
>>>> [   48.305957] pci 0001:00:02.0: can't claim BAR 0 [mem 0x0f600000-0x0f6fffff]:
>>>> no compatible bridge window
>>>> [   48.420098] pci 0001:00:06.0: can't claim BAR 0 [mem 0x0fa00000-0x0fafffff]:
>>>> no compatible bridge window
>>>> [   48.534294] pci 0001:00:07.0: can't claim BAR 0 [mem 0x00000000-0x00001fff]:
>>>> no compatible bridge window
>>>> [   48.648541] qla1280: QLA1040 found on PCI bus 0, dev 0
>>>> [   48.710232] PCI: Enabling device 0001:00:00.0 (0006 -> 0007)
>>>> [   48.779231] qla1280 0001:00:00.0: can't ioremap BAR 1: [mem size 0x00001000]
>>>> [   48.863145] qla1280: Unable to map I/O memory
>>>> [   48.916520] qla1280: QLA1040 found on PCI bus 0, dev 1
>>>> [   48.977298] PCI: Enabling device 0001:00:01.0 (0006 -> 0007)
>>>> [   49.046128] qla1280 0001:00:01.0: can't ioremap BAR 1: [mem size 0x00001000]
>>>> [   49.130201] qla1280: Unable to map I/O memory
>>>> [   49.183068] IOC3 0001:00:02.0: can't ioremap BAR 0: [mem size 0x00100000]
>>>> [   49.264292] ioc3: Unable to remap PCI BAR for 0001:00:02.0.
>>>> [   49.331533] IOC3 0001:00:06.0: can't ioremap BAR 0: [mem size 0x00100000]
>>>> [   49.412984] ioc3: Unable to remap PCI BAR for 0001:00:06.0.
>>>>
>>>>
>>>> If I disable PCI_PROBE_ONLY, then this:
>>>>
>>>> [   47.588033] PCI host bridge to bus 0001:00
>>>> [   47.636649] pci_bus 0001:00: root bus resource [mem
>>>> 0x920000000f200000-0x920000000f9fffff]
>>>> [   47.736144] pci_bus 0001:00: root bus resource [io
>>>> 0x920000000fa00000-0x920000000fbfffff]
>>>> [   47.835621] pci_bus 0001:00: root bus resource [bus 01-ff]
>>>> [   47.905023] pci 0001:00:02.0: BAR 0: no space for [mem size 0x00100000]
>>>> [   47.982775] pci 0001:00:02.0: BAR 0: failed to assign [mem size 0x00100000]
>>>> [   48.066586] pci 0001:00:06.0: BAR 0: no space for [mem size 0x00100000]
>>>> [   48.146173] pci 0001:00:06.0: BAR 0: failed to assign [mem size 0x00100000]
>>>> [   48.229972] pci 0001:00:00.0: BAR 6: no space for [mem size 0x00010000 pref]
>>>> [   48.314783] pci 0001:00:00.0: BAR 6: failed to assign [mem size 0x00010000 pref]
>>>> [   48.403825] pci 0001:00:01.0: BAR 6: no space for [mem size 0x00010000 pref]
>>>> [   48.488655] pci 0001:00:01.0: BAR 6: failed to assign [mem size 0x00010000 pref]
>>>> [   48.577695] pci 0001:00:00.0: BAR 1: no space for [mem size 0x00001000]
>>>> [   48.657260] pci 0001:00:00.0: BAR 1: failed to assign [mem size 0x00001000]
>>>> [   48.741068] pci 0001:00:01.0: BAR 1: no space for [mem size 0x00001000]
>>>> [   48.820644] pci 0001:00:01.0: BAR 1: failed to assign [mem size 0x00001000]
>>>> [   48.904452] pci 0001:00:00.0: BAR 0: no space for [io  size 0x0100]
>>>> [   48.979840] pci 0001:00:00.0: BAR 0: failed to assign [io  size 0x0100]
>>>> [   49.059459] pci 0001:00:01.0: BAR 0: no space for [io  size 0x0100]
>>>> [   49.134855] pci 0001:00:01.0: BAR 0: failed to assign [io  size 0x0100]
>>>> [   49.214588] qla1280: QLA1040 found on PCI bus 0, dev 0
>>>> [   49.277249] qla1280 0001:00:00.0: can't ioremap BAR 1: [??? 0x00000000 flags
>>>> 0x0]
>>>> [   49.366330] qla1280: Unable to map I/O memory
>>>> [   49.419832] qla1280: QLA1040 found on PCI bus 0, dev 1
>>>> [   49.481211] qla1280 0001:00:01.0: can't ioremap BAR 1: [??? 0x00000000 flags
>>>> 0x0]
>>>> [   49.570560] qla1280: Unable to map I/O memory
>>>> [   49.623439] IOC3 0001:00:02.0: can't ioremap BAR 0: [??? 0x00000000 flags 0x0]
>>>> [   49.709857] ioc3: Unable to remap PCI BAR for 0001:00:02.0.
>>>> [   49.777113] IOC3 0001:00:06.0: can't ioremap BAR 0: [??? 0x00000000 flags 0x0]
>>>> [   49.863796] ioc3: Unable to remap PCI BAR for 0001:00:06.0.
>>>>
>>>>
>>>> The only fix I could come up with was more IP27 #ifdef hackery to retain the
>>>> original code for IP27, but use the new conditional logic for all other
>>>> platforms.  Would a patch for this be acceptable (with verbose comment), or is
>>>> there a better way to deal with IP27 that doesn't involve re-writing its I/O
>>>> addressing support entirely?
>>>
>>> Would you mind providing a kernel boot log, lspci output and /proc/iomem
>>> /proc/ioports for your "working" system boot ? That would help debugging
>>> what's the expected resources allocation for the system and consequently
>>> where the problem currently lies.
>>
>> Sure.  I've disabled line-wrapping on this message so my mail client doesn't
>> mangle the output.
> 
> Ok, I think this exactly showed what Bjorn wanted to see by claiming
> resources because the problem is that the value in the BARs is not
> contained in any bridge window, for the reason that you just mentioned
> (ie the "special" physical addresses flags).
> 
> In the PCI_PROBE_ONLY case, claiming resources fail, which means that
> we set the resource flags res->flags |= IORESOURCE_UNSET, which causes
> pci_ioremap_bar() to fail.
> 
> So, it is correct to claim the resources if PCI_PROBE_ONLY, this fails
> because the values in the BARs and the PCI host bridge window resources
> have different formats (ie the PCI bridge window resources have addresses
> that contain the special flags you mentioned) the question I have is
> why the PCI root bridge window should be set with the flags in it
> instead of a "pure" IO address.
> 
> Is my reading of the problem correct ?

Sorry, been tied up lately.  I haven't done a deep-dive of the way the PCI
code actually assigns/claims addresses, but this sounds mostly correct to
me.  Reading in the document I cited, these addresses are actually "virtual
addresses", but I am uncertain if they're "virtual" in the same sense that
the Linux kernel regards as virtual (as in allocated by the kernel's memory
manager).


> Why do the PCI host bridge windows have to contain that 0x92 tag in the
> upper bits ?

It's a hardware-specific mechanism.  The IP27 platform was a
massively-scalable (for its time) system that supported up to 128 CPUs
spread across 64 nodeboards in 8 racks (4 nodeboards per system module).  So
SGI designed the address space big enough such that all nodes and all
devices assigned to each node could be addressed by using offsets from the
address space of Node 0.

The basic bit assignment for an address runs like this:

63:62 - address space selection
61:59 - cache algorithm
58:57 - uncached attribute
56:44 - not translated by TLB
39:00 - index to physical space when 63:62 == 10b (physical addressing)

IP27 uses this bit assignment to layout five address spaces:
  - Cached (63:62 are any value other than 10b)
  - HUB Special (58:57 == 00b)
  - I/O Special (58:57 == 01b)
  - Memory Special (58:57 == 10b)
  - Uncached (58:57 == 11b)

So if 63:62 are 10b (physical address), 61:59 are 010b (uncached), and 58:57
are 01b (I/O space), that results in the address 0x92xxxxxxxxxxxxxx, which
tells the hardware you're trying to access uncached I/O space, and thus, an
I/O device.  The remaining bits in the address are used to specify the
particular node the device is attached to all the way down to the
device-specific address value itself.  There's also things like "little
windows" and "big windows" that I don't fully understand just yet, as
they're a function of the Crosstalk (XIO) bus that the PCI busses are
actually attached to within the system.


> By not claiming resources, as you can see in the log below
> /proc/iomem and /proc/ioports do not report the PCI devices resource
> usages and the respective resources are not reserved in the kernel,
> which is wrong and that's exactly why Bjorn patched the kernel.
> 
> Please let me know.
> 
> Thanks,
> Lorenzo

Yup, I can see that on my SGI Octane machine (IP30 platform), which is
architecturally-similar to IP27, but uses a more "normal" addressing layout.
 Previously, it was also setting the PCI_PROBE_ONLY flag and thus
/proc/iomem looked very similar to IP27's output.  Now, however, Octane's
/proc/iomem looks more like this:

# cat /proc/iomem
00000000-00003fff : reserved
1d200000-1d9fffff : Bridge MEM
  d080000000-d080003fff : 0001:00:03.0
  1d204000-1d204fff : 0001:00:02.0
  1d205000-1d205fff : 0001:00:02.1
  1d206000-1d206fff : 0001:00:02.2
  1d207000-1d2070ff : 0001:00:02.3
  1d207100-1d20717f : 0001:00:01.0
1f200000-1f9fffff : Bridge MEM
  f080100000-f0801fffff : 0000:00:02.0
  f080010000-f08001ffff : 0000:00:00.0
  f080030000-f08003ffff : 0000:00:01.0
  f080000000-f080000fff : 0000:00:00.0
  f080020000-f080020fff : 0000:00:01.0
20004000-20a27fff : reserved
  20004000-207180b7 : Kernel code
  207180b8-2090ffff : Kernel data
20a28000-20efffff : System RAM
20f00000-20ffffff : System RAM
21000000-9fffffff : System RAM
f080100000-f0801fffff : ioc3

And /proc/ioports:
# cat /proc/ioports
1da00000-1dbfffff : Bridge IO
  1da00000-1da000ff : 0001:00:01.0
  1da00400-1da0047f : 0001:00:01.0
1fa00000-1fbfffff : Bridge IO
  f100000000-f1000000ff : 0000:00:00.0
  f100000100-f1000001ff : 0000:00:01.0

PCI support on IP27 has been a bit weird for a long time, mostly due to it
using a lot of "IRIX'isms" in the code to get it working initially.  Some of
these are actually short-circuits for things that would instead use normal
kernel mechanisms, and no one's really had the time or interest to try and
clean it up.  I've done a significant amount of refactoring of the IP27's
machine-specific code so far the last few months, but haven't spent much
time understanding PCI and XIO some more to make further progress.  Lack of
time has made it difficult to break those code changes down into bite-sized
patches to send back upstream (I should've planned things a bit better...).

--J


>> First, is the boot output from my serial console:
>> [    0.000000] Linux version 4.8.2-mipsgit-20161016 (root@helcaraxe) (gcc version 5.4.0 (Gentoo Hardened 5.4.0 p1.0, pie-0.6.5) ) #4 SMP Mon Oct 17 19:48:30 EDT 2016
>> [    0.000000] ARCH: SGI-IP27
>> [    0.000000] PROMLIB: ARC firmware Version 64 Revision 0
>> [    0.000000] SMP: Discovered 4 cpus on 2 nodes
>> [    0.000000] ************** Topology ********************
>> [    0.000000]     00 01
>> [    0.000000] 00  255 255
>> [    0.000000] 01  255 255
>> [    0.000000] bootconsole [early0] enabled
>> [    0.000000] CPU0 revision is: 00000f14 (R14000)
>> [    0.000000] FPU revision is: 00000900
>> [    0.000000] Checking for the multiply/shift bug... no.
>> [    0.000000] Checking for the daddiu bug... no.
>> [    0.000000] IP27: Running on node 0.
>> [    0.000000] IP27: Node 0 has a primary CPU, CPU is running.
>> [    0.000000] IP27: Node 0 has a secondary CPU, CPU is running.
>> [    0.000000] IP27: Machine is in M mode.
>> [    0.000000] IP27: CPU 1A (CPU0): 500 MHz CPU detected.
>> [    0.000000] Determined physical RAM map:
>> [    0.000000]  memory: 0000000000838000 @ 000000000001c000 (usable)
>> [    0.000000]  memory: 000000000057c000 @ 0000000000854000 (usable after init)
>> [    0.000000] Initrd not found or empty - disabling initrd
>> [    0.000000] cma: Reserved 32 MiB at 0x00000001fe000000
>> [    0.000000] REPLICATION: ON nasid 0, ktext from nasid 0, kdata from nasid 0
>> [    0.000000] REPLICATION: ON nasid 1, ktext from nasid 0, kdata from nasid 0
>> [    0.000000] Primary instruction cache 32kB, VIPT, 2-way, linesize 64 bytes.
>> [    0.000000] Primary data cache 32kB, 2-way, VIPT, no aliases, linesize 32 bytes
>> [    0.000000] Unified secondary cache 8192kB 2-way, linesize 128 bytes.
>> [    0.000000] Zone ranges:
>> [    0.000000]   Normal   [mem 0x0000000000000000-0x00000001ffffffff]
>> [    0.000000] Movable zone start for each node
>> [    0.000000] Early memory node ranges
>> [    0.000000]   node   0: [mem 0x0000000000000000-0x00000000ffffffff]
>> [    0.000000]   node   1: [mem 0x0000000100000000-0x00000001ffffffff]
>> [    0.000000] Initmem setup node 0 [mem 0x0000000000000000-0x00000000ffffffff]
>> [    0.000000] Initmem setup node 1 [mem 0x0000000100000000-0x00000001ffffffff]
>> [    0.000000] percpu: Embedded 4 pages/cpu @a800000002010000 s36096 r0 d29440 u65536
>> [    0.000000] Built 2 zonelists in Node order, mobility grouping on.  Total pages: 522240
>> [    0.000000] Policy zone: Normal
>> [    0.000000] Kernel command line: root=dksc(0,1,0) console=ttyS0,9600
>> [    0.000000] PID hash table entries: 4096 (order: 1, 32768 bytes)
>> [    0.000000] Memory: 8307776K/8388608K available (6498K kernel code, 454K rwdata, 1436K rodata, 5616K init, 543K bss, 48064K reserved, 32768K cma-reserved)
>> [    0.000000] Hierarchical RCU implementation.
>> [    0.000000]  Build-time adjustment of leaf fanout to 64.
>> [    0.000000]  RCU restricting CPUs from NR_CPUS=64 to nr_cpu_ids=4.
>> [    0.000000] RCU: Adjusting geometry for rcu_fanout_leaf=64, nr_cpu_ids=4
>> [    0.000000] NR_IRQS:256
>> [    0.000000] clocksource: HUB: mask: 0xfffffffffffff max_cycles: 0x127350b88, max_idle_ns: 1763180808480 ns
>> [    0.000019] sched_clock: 52 bits at 1250kHz, resolution 800ns, wraps every 4398046510800ns
>> [    0.102422] Console: colour dummy device 80x25
>> [    0.154975] Calibrating delay loop... 749.56 BogoMIPS (lpj=3747840)
>> [    0.317670] pid_max: default: 32768 minimum: 301
>> [    0.377938] Dentry cache hash table entries: 1048576 (order: 9, 8388608 bytes)
>> [    0.592303] Inode-cache hash table entries: 524288 (order: 8, 4194304 bytes)
>> [    0.736316] Mount-cache hash table entries: 16384 (order: 3, 131072 bytes)
>> [    0.817310] Mountpoint-cache hash table entries: 16384 (order: 3, 131072 bytes)
>> [    0.916094] Checking for the daddi bug... no.
>> [    0.976495] Primary instruction cache 32kB, VIPT, 2-way, linesize 64 bytes.
>> [    0.976520] Primary data cache 32kB, 2-way, VIPT, no aliases, linesize 32 bytes
>> [    0.976532] Unified secondary cache 8192kB 2-way, linesize 128 bytes.
>> [    0.979792] IP27: CPU 1B (CPU1): 500 MHz CPU detected.
>> [    0.979824] CPU1 revision is: 00000f14 (R14000)
>> [    0.979831] FPU revision is: 00000900
>> [    1.014463] Primary instruction cache 32kB, VIPT, 2-way, linesize 64 bytes.
>> [    1.014493] Primary data cache 32kB, 2-way, VIPT, no aliases, linesize 32 bytes
>> [    1.014506] Unified secondary cache 8192kB 2-way, linesize 128 bytes.
>> [    1.017888] IP27: CPU 2A (CPU2): 500 MHz CPU detected.
>> [    1.017931] CPU2 revision is: 00000f14 (R14000)
>> [    1.017938] FPU revision is: 00000900
>> [    1.055420] Primary instruction cache 32kB, VIPT, 2-way, linesize 64 bytes.
>> [    1.055452] Primary data cache 32kB, 2-way, VIPT, no aliases, linesize 32 bytes
>> [    1.055467] Unified secondary cache 8192kB 2-way, linesize 128 bytes.
>> [    1.058810] IP27: CPU 2B (CPU3): 500 MHz CPU detected.
>> [    1.058851] CPU3 revision is: 00000f14 (R14000)
>> [    1.058858] FPU revision is: 00000900
>> [    1.092672] Brought up 4 CPUs
>> [    2.484801] devtmpfs: initialized
>> [    2.603700] clocksource: jiffies: mask: 0xffffffff max_cycles: 0xffffffff, max_idle_ns: 19112604462750000 ns
>> [    2.892716] random: fast init done
>> [    2.990752] xor: measuring software checksum speed
>> [    3.146730]    8regs     :   486.400 MB/sec
>> [    3.295350]    8regs_prefetch:   486.400 MB/sec
>> [    3.448144]    32regs    :   486.400 MB/sec
>> [    3.596768]    32regs_prefetch:   486.400 MB/sec
>> [    3.650415] xor: using function: 32regs_prefetch (486.400 MB/sec)
>> [    3.834852] NET: Registered protocol family 16
>> [    3.946535] cpuidle: using governor ladder
>> [    4.043955] cpuidle: using governor menu
>> [    4.089355] xtalk:n0/0 xbow widget (rev 1.3)
>> [    4.140796] xtalk:n0/8 kona widget (rev unknown) registered as a platform device.
>> [    4.230796] xtalk:n0/b bridge widget (rev D) registered as a platform device.
>> [    4.316712] xtalk:n0/c bridge widget (rev D) registered as a platform device.
>> [    4.402590] xtalk:n0/d impact widget (rev B) registered as a platform device.
>> [    4.488444] xtalk:n0/f bridge widget (rev C) registered as a platform device.
>> [    4.574178] xtalk:n1/0 xbow widget (rev 1.3)
>> [    5.247396] raid6: int64x1  gen()    84 MB/s
>> [    5.467370] raid6: int64x1  xor()    80 MB/s
>> [    5.687324] raid6: int64x2  gen()   151 MB/s
>> [    5.907243] raid6: int64x2  xor()   116 MB/s
>> [    6.127125] raid6: int64x4  gen()   235 MB/s
>> [    6.347155] raid6: int64x4  xor()   142 MB/s
>> [    6.567117] raid6: int64x8  gen()   251 MB/s
>> [    6.787018] raid6: int64x8  xor()   175 MB/s
>> [    6.836420] raid6: using algorithm int64x8 gen() 251 MB/s
>> [    6.901352] raid6: .... xor() 175 MB/s, rmw enabled
>> [    6.960002] raid6: using intx1 recovery algorithm
>> [    7.017544] SCSI subsystem initialized
>> [    7.063853] clocksource: Switched to clocksource HUB
>> [    7.363862] FS-Cache: Loaded
>> [   31.643872] NET: Registered protocol family 2
>> [   31.696149] TCP established hash table entries: 65536 (order: 5, 524288 bytes)
>> [   31.787294] TCP bind hash table entries: 65536 (order: 6, 1048576 bytes)
>> [   31.874832] TCP: Hash tables configured (established 65536 bind 65536)
>> [   31.952084] UDP hash table entries: 4096 (order: 3, 131072 bytes)
>> [   32.026304] UDP-Lite hash table entries: 4096 (order: 3, 131072 bytes)
>> [   32.403836] NET: Registered protocol family 1
>> [   32.583876] RPC: Registered named UNIX socket transport module.
>> [   32.653282] RPC: Registered udp transport module.
>> [   32.709785] RPC: Registered tcp transport module.
>> [   32.766346] RPC: Registered tcp NFSv4.1 backchannel transport module.
>> [   34.045622] futex hash table entries: 1024 (order: 3, 131072 bytes)
>> [   34.275238] workingset: timestamp_bits=40 max_order=19 bucket_order=0
>> [   34.350961] zbud: loaded
>> [   37.383916] NFS: Registering the id_resolver key type
>> [   37.442917] Key type id_resolver registered
>> [   37.493101] Key type id_legacy registered
>> [   37.541388] efs: 1.0a - http://aeschi.ch.eu.org/efs/
>> [   37.873853] SGI XFS with ACLs, security attributes, realtime, no debug enabled
>> [   39.453936] Block layer SCSI generic (bsg) driver version 0.4 loaded (major 253)
>> [   39.541066] io scheduler noop registered
>> [   39.588223] io scheduler deadline registered
>> [   39.639639] io scheduler cfq registered (default)
>> [   39.973936] pci_hotplug: PCI Hot Plug PCI Core version: 0.5
>> [   40.148640] Serial: 8250/16550 driver, 4 ports, IRQ sharing enabled
>> [   40.245916] loop: module loaded
>> [   40.283288] mousedev: PS/2 mouse device common for all mice
>> [   40.349460] md: linear personality registered for level -1
>> [   40.414802] md: raid0 personality registered for level 0
>> [   40.478677] md: raid1 personality registered for level 1
>> [   40.542549] md: raid10 personality registered for level 10
>> [   40.609068] md: raid6 personality registered for level 6
>> [   40.672411] md: raid5 personality registered for level 5
>> [   40.736315] md: raid4 personality registered for level 4
>> [   40.800808] PCI host bridge to bus 0000:00
>> [   40.849424] pci_bus 0000:00: root bus resource [mem 0x920000000b200000-0x920000000b9fffff]
>> [   40.948920] pci_bus 0000:00: root bus resource [io  0x920000000ba00000-0x920000000bbfffff]
>> [   41.048408] pci_bus 0000:00: root bus resource [bus 00-ff]
>> [   41.114880] PCI host bridge to bus 0001:00
>> [   41.163629] pci_bus 0001:00: root bus resource [mem 0x920000000c200000-0x920000000c9fffff]
>> [   41.263152] pci_bus 0001:00: root bus resource [io  0x920000000ca00000-0x920000000cbfffff]
>> [   41.362645] pci_bus 0001:00: root bus resource [bus 01-ff]
>> [   41.430847] PCI host bridge to bus 0002:00
>> [   41.478263] pci_bus 0002:00: root bus resource [mem 0x920000000f200000-0x920000000f9fffff]
>> [   41.577771] pci_bus 0002:00: root bus resource [io  0x920000000fa00000-0x920000000fbfffff]
>> [   41.677250] pci_bus 0002:00: root bus resource [bus 02-ff]
>> [   41.746742] qla1280: QLA1040 found on PCI bus 0, dev 0
>> [   41.806687] PCI: Enabling device 0002:00:00.0 (0006 -> 0007)
>> [   41.875796] scsi(0): Enabling vchannel on BRIDGE for SGI/MIPS
>> [   42.324520] random: crng init done
>> [   42.839160] scsi(0:0): Resetting SCSI BUS
>> [   45.964232] scsi host0: QLogic QLA1040 PCI to SCSI Host Adapter
>> [   45.964232]        Firmware version:  7.65.06, Driver version 3.27.1
>> [   46.118149] qla1280: QLA1040 found on PCI bus 0, dev 1
>> [   46.178192] PCI: Enabling device 0002:00:01.0 (0006 -> 0007)
>> [   46.289985] scsi 0:0:1:0: Direct-Access     SEAGATE  SX150176LC       BA12 PQ: 0 ANSI: 2
>> [   46.387174] scsi(0:0:1:0): Sync: period 10, offset 12, Wide, Tagged queuing: depth 31
>> [   46.486875] scsi 0:0:2:0: Direct-Access     SEAGATE  SX150176LC       BA08 PQ: 0 ANSI: 2
>> [   46.583893] scsi(0:0:2:0): Sync: period 10, offset 12, Wide, Tagged queuing: depth 31
>> [   46.683736] scsi 0:0:3:0: Direct-Access     SEAGATE  SX150176LC       BA08 PQ: 0 ANSI: 2
>> [   46.780696] scsi(0:0:3:0): Sync: period 10, offset 12, Wide, Tagged queuing: depth 31
>> [   46.880821] scsi 0:0:4:0: Direct-Access     SEAGATE  SX150176LC       BA11 PQ: 0 ANSI: 2
>> [   46.977716] scsi(0:0:4:0): Sync: period 10, offset 12, Wide, Tagged queuing: depth 31
>> [   47.077797] scsi 0:0:5:0: Direct-Access     SEAGATE  SX150176LC       BA11 PQ: 0 ANSI: 2
>> [   47.174768] scsi(0:0:5:0):[   47.181219] scsi(1:0): Resetting SCSI BUS
>> [   47.251839]  Sync: period 10, offset 12, Wide, Tagged queuing: depth 31
>> [   47.639912] scsi 0:0:6:0: CD-ROM            TOSHIBA  CD-ROM XM-5701TA 0167 PQ: 0 ANSI: 2
>> [   47.736890] scsi(0:0:6:0): Sync: period 10, offset 12
>> [   51.553976] scsi host1: QLogic QLA1040 PCI to SCSI Host Adapter
>> [   51.553976]        Firmware version:  7.65.06, Driver version 3.27.1
>> [   51.998859] ioc3: part: [], serial: [] => class IP27 BaseIO
>> [   52.068783] ioc3-eth: Ethernet address is 08:00:69:05:64:74.
>> [   52.136831] IOC3 0002:00:02.0 eth0: link up, 100Mbps, full-duplex, lpa 0x8DE1
>> [   52.220897] eth0: Using PHY 31, vendor 0x20005c0, model 0, rev 0.
>> [   52.294232] eth0: IOC3 SSRAM has 128 kbyte.
>> [   52.345852] rtc-m48t35 rtc-m48t35: rtc core: registered m48t35 as rtc0
>> [   52.588471] console [ttyS0] enabled
>> [   52.489601] 0002:00:02.0: ttyS0 at IOC3 0xf620178 (irq = 0, base_baud = 458333) is a 16550A
>> [   52.671141] bootconsole [early0] disabled
>> [   54.146680] 0002:00:02.0: ttyS1 at IOC3 0xf620170 (irq = 0, base_baud = 458333) is a 16550A
>> [   54.248408] IOC3 Master Driver loaded for 0002:00:02.0
>> [   54.313895] ioc3: NIC search failed.
>> [   54.356992] ioc3: part: [], serial: [] => class IP27 BaseIO
>> [   54.424356] ioc3: request_irq fails for IRQ 0xffffffff
>> [   54.490948] ioc3-eth: Ethernet address is 00:00:00:00:00:00.
>> [   54.561038] IOC3 0002:00:06.0 eth1: link down
>> [   54.613597] eth1: Using PHY 31, vendor 0x0, model 0, rev 0.
>> [   54.680825] eth1: IOC3 SSRAM has 64 kbyte.
>> [   54.765266] 0002:00:06.0: ttyS2 at IOC3 0xfa20178 (irq = 0, base_baud = 458333) is a 16550A
>> [   54.888655] 0002:00:06.0: ttyS3 at IOC3 0xfa20170 (irq = 0, base_baud = 458333) is a 16550A
>> [   54.990198] IOC3 Master Driver loaded for 0002:00:06.0
>> [   55.052840] NET: Registered protocol family 26
>> [   55.509832] sd 0:0:1:0: [sda] 97693755 512-byte logical blocks: (50.0 GB/46.6 GiB)
>> [   55.515697] sr 0:0:6:0: [sr0] scsi-1 drive
>> [   55.515709] cdrom: Uniform CD-ROM driver Revision: 3.20
>> [   55.520834] sd 0:0:4:0: [sdd] 97693755 512-byte logical blocks: (50.0 GB/46.6 GiB)
>> [   55.523611] sd 0:0:4:0: [sdd] Write Protect is off
>> [   55.526511] sd 0:0:4:0: [sdd] Write cache: disabled, read cache: enabled, supports DPO and FUA
>> [   55.550956]  sdd: sdd1 sdd2 sdd3 sdd4 sdd5 sdd6 sdd9 sdd11
>> [   55.562326] sd 0:0:4:0: [sdd] Attached SCSI disk
>> [   55.564803] sd 0:0:5:0: [sde] 97693755 512-byte logical blocks: (50.0 GB/46.6 GiB)
>> [   55.567564] sd 0:0:5:0: [sde] Write Protect is off
>> [   55.570463] sd 0:0:5:0: [sde] Write cache: disabled, read cache: enabled, supports DPO and FUA
>> [   55.600908] sd 0:0:5:0: [sde] Attached SCSI disk
>> [   55.604715] sd 0:0:2:0: [sdb] 97693755 512-byte logical blocks: (50.0 GB/46.6 GiB)
>> [   55.605297] sd 0:0:3:0: [sdc] 97693755 512-byte logical blocks: (50.0 GB/46.6 GiB)
>> [   55.607054] sd 0:0:2:0: [sdb] Write Protect is off
>> [   55.607592] sd 0:0:3:0: [sdc] Write Protect is off
>> [   55.609959] sd 0:0:2:0: [sdb] Write cache: disabled, read cache: enabled, supports DPO and FUA
>> [   55.610460] sd 0:0:3:0: [sdc] Write cache: disabled, read cache: enabled, supports DPO and FUA
>> [   55.631199]  sdb: sdb1 sdb2 sdb3 sdb4 sdb5 sdb6 sdb9 sdb11
>> [   55.634048]  sdc: sdc1 sdc2 sdc3 sdc4 sdc5 sdc6 sdc9 sdc11
>> [   55.646437] sd 0:0:3:0: [sdc] Attached SCSI disk
>> [   55.647162] sd 0:0:2:0: [sdb] Attached SCSI disk
>> [   57.150140] sd 0:0:1:0: [sda] Write Protect is off
>> [   57.173988] NET: Registered protocol family 10
>> [   57.264566] sd 0:0:1:0: [sda] Write cache: disabled, read cache: enabled, supports DPO and FUA
>> [   57.386960]  sda: sda1 sda2 sda3 sda4 sda5 sda6 sda9 sda11
>> [   57.464000] sd 0:0:1:0: [sda] Attached SCSI disk
>> [   57.544064] sit: IPv6, IPv4 and MPLS over IPv4 tunneling driver
>> [   57.617430] NET: Registered protocol family 17
>> [   57.671360] 8021q: 802.1Q VLAN Support v1.8
>> [   57.722075] sctp: Hash tables configured (bind 1024/1024)
>> [   58.093962] Key type dns_resolver registered
>> [   58.148015] rtc-m48t35 rtc-m48t35: setting system clock to 2016-10-17 23:49:58 UTC (1476748198)
>> [   59.626451] Freeing unused kernel memory: 5616K (a800000000854000 - a800000000dd0000)
>> [   59.720950] This architecture does not have kernel memory protection.
>>
>>
>> Next is /proc/iomem and /proc/ioports:
>> # cat /proc/iomem
>> 0f600000-0f6fffff : ioc3
>>   0f680000-0f687fff : rtc-m48t35
>> 0fa00000-0fafffff : ioc3
>> 920000000b200000-920000000b9fffff : Bridge MEM
>> 920000000c200000-920000000c9fffff : Bridge MEM
>> 920000000f200000-920000000f9fffff : Bridge MEM
>>
>> / # cat /proc/ioports
>> 920000000ba00000-920000000bbfffff : Bridge IO
>> 920000000ca00000-920000000cbfffff : Bridge IO
>> 920000000fa00000-920000000fbfffff : Bridge IO
>>
>>
>> And lspci -vvvx:
>>
>> / # /usr/sbin/lspci -vvvx
>> 0001:00:00.0 Unassigned class [ff00]: Silicon Graphics Intl. Corp. Linc I/O controller
>>         Control: I/O- Mem- BusMaster- SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B- DisINTx-
>>         Status: Cap- 66MHz- UDF- FastB2B- ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR- INTx-
>>         NUMA node: 0
>>         Region 0: Memory at <unassigned> (32-bit, non-prefetchable) [disabled] [size=134217729]
>>         Region 1: Memory at <unassigned> (32-bit, non-prefetchable) [disabled] [size=2]
>>         Region 2: Memory at <unassigned> (32-bit, non-prefetchable) [disabled] [size=2]
>>         Region 3: Memory at <unassigned> (32-bit, non-prefetchable) [disabled] [size=2]
>>         Region 4: Memory at <unassigned> (32-bit, non-prefetchable) [disabled] [size=2]
>>         Region 5: Memory at <unassigned> (32-bit, non-prefetchable) [disabled] [size=2]
>>         Expansion ROM at <unassigned> [disabled] [size=2]
>> lspci: Unable to load libkmod resources: error -12
>> 00: a9 10 02 00 00 00 00 02 00 00 00 ff 00 f8 80 00
>> 10: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
>> 20: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
>> 30: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
>>
>> 0001:00:01.0 Unassigned class [ff00]: Silicon Graphics Intl. Corp. Linc I/O controller
>>         Control: I/O- Mem- BusMaster- SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B- DisINTx-
>>         Status: Cap- 66MHz- UDF- FastB2B- ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR- INTx-
>>         NUMA node: 0
>>         Region 0: Memory at <unassigned> (32-bit, non-prefetchable) [disabled] [size=134217729]
>>         Region 1: Memory at <unassigned> (32-bit, non-prefetchable) [disabled] [size=2]
>>         Region 2: Memory at <unassigned> (32-bit, non-prefetchable) [disabled] [size=2]
>>         Region 3: Memory at <unassigned> (32-bit, non-prefetchable) [disabled] [size=2]
>>         Region 4: Memory at <unassigned> (32-bit, non-prefetchable) [disabled] [size=2]
>>         Region 5: Memory at <unassigned> (32-bit, non-prefetchable) [disabled] [size=2]
>>         Expansion ROM at <unassigned> [disabled] [size=2]
>> 00: a9 10 02 00 00 00 00 02 00 00 00 ff 00 f8 80 00
>> 10: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
>> 20: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
>> 30: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
>>
>> 0002:00:00.0 SCSI storage controller: QLogic Corp. ISP1020 Fast-wide SCSI (rev 05)
>>         Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B- DisINTx-
>>         Status: Cap- 66MHz- UDF- FastB2B- ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR- INTx-
>>         Latency: 64, Cache Line Size: 256 bytes
>>         Interrupt: pin A routed to IRQ 1
>>         NUMA node: 0
>>         Region 0: I/O ports at f200000 [size=257]
>>         Region 1: Memory at 0f200000 (32-bit, non-prefetchable) [size=4097]
>>         Region 2: Memory at <unassigned> (32-bit, non-prefetchable) [size=2]
>>         Region 3: Memory at <unassigned> (32-bit, non-prefetchable) [size=2]
>>         Region 4: Memory at <unassigned> (32-bit, non-prefetchable) [size=2]
>>         Region 5: Memory at <unassigned> (32-bit, non-prefetchable) [size=2]
>>         Expansion ROM at <unassigned> [disabled] [size=65537]
>>         Kernel driver in use: qla1280
>> 00: 77 10 20 10 07 00 00 02 05 00 00 01 40 40 00 00
>> 10: 01 00 20 0f 00 00 20 0f 00 00 00 00 00 00 00 00
>> 20: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
>> 30: 00 00 00 00 00 00 00 00 00 00 00 00 00 01 00 00
>>
>> 0002:00:01.0 SCSI storage controller: QLogic Corp. ISP1020 Fast-wide SCSI (rev 05)
>>         Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B- DisINTx-
>>         Status: Cap- 66MHz- UDF- FastB2B- ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR- INTx-
>>         Latency: 64, Cache Line Size: 256 bytes
>>         Interrupt: pin A routed to IRQ 2
>>         NUMA node: 0
>>         Region 0: I/O ports at f400000 [size=257]
>>         Region 1: Memory at 0f400000 (32-bit, non-prefetchable) [size=4097]
>>         Region 2: Memory at <unassigned> (32-bit, non-prefetchable) [size=2]
>>         Region 3: Memory at <unassigned> (32-bit, non-prefetchable) [size=2]
>>         Region 4: Memory at <unassigned> (32-bit, non-prefetchable) [size=2]
>>         Region 5: Memory at <unassigned> (32-bit, non-prefetchable) [size=2]
>>         Expansion ROM at <unassigned> [disabled] [size=65537]
>>         Kernel driver in use: qla1280
>> 00: 77 10 20 10 07 00 00 02 05 00 00 01 40 40 00 00
>> 10: 01 00 40 0f 00 00 40 0f 00 00 00 00 00 00 00 00
>> 20: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
>> 30: 00 00 00 00 00 00 00 00 00 00 00 00 00 01 00 00
>>
>> 0002:00:02.0 Unassigned class [ff00]: Silicon Graphics Intl. Corp. IOC3 I/O controller (rev 01)
>>         Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B- DisINTx-
>>         Status: Cap- 66MHz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR- INTx-
>>         Latency: 64
>>         Interrupt: pin A routed to IRQ 3
>>         NUMA node: 0
>>         Region 0: Memory at 0f600000 (32-bit, non-prefetchable) [size=1048577]
>>         Region 1: Memory at <unassigned> (32-bit, non-prefetchable) [size=2]
>>         Region 2: Memory at <unassigned> (32-bit, non-prefetchable) [size=2]
>>         Region 3: Memory at <unassigned> (32-bit, non-prefetchable) [size=2]
>>         Region 4: Memory at <unassigned> (32-bit, non-prefetchable) [size=2]
>>         Region 5: Memory at <unassigned> (32-bit, non-prefetchable) [size=2]
>>         Expansion ROM at <unassigned> [disabled] [size=2]
>>         Kernel driver in use: IOC3
>> 00: a9 10 03 00 06 00 80 02 01 00 00 ff 00 40 00 00
>> 10: 00 00 60 0f 00 00 00 00 00 00 00 00 00 00 00 00
>> 20: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
>> 30: 00 00 00 00 00 00 00 00 00 00 00 00 00 01 00 00
>>
>> 0002:00:06.0 Unassigned class [ff00]: Silicon Graphics Intl. Corp. IOC3 I/O controller (rev 01)
>>         Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B- DisINTx-
>>         Status: Cap- 66MHz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR- INTx-
>>         Latency: 64
>>         Interrupt: pin A routed to IRQ 5
>>         NUMA node: 0
>>         Region 0: Memory at 0fa00000 (32-bit, non-prefetchable) [size=1048577]
>>         Region 1: Memory at <unassigned> (32-bit, non-prefetchable) [size=2]
>>         Region 2: Memory at <unassigned> (32-bit, non-prefetchable) [size=2]
>>         Region 3: Memory at <unassigned> (32-bit, non-prefetchable) [size=2]
>>         Region 4: Memory at <unassigned> (32-bit, non-prefetchable) [size=2]
>>         Region 5: Memory at <unassigned> (32-bit, non-prefetchable) [size=2]
>>         Expansion ROM at <unassigned> [disabled] [size=2]
>>         Kernel driver in use: IOC3
>> 00: a9 10 03 00 06 00 80 02 01 00 00 ff 00 40 00 00
>> 10: 00 00 a0 0f 00 00 00 00 00 00 00 00 00 00 00 00
>> 20: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
>> 30: 00 00 00 00 00 00 00 00 00 00 00 00 00 01 00 00
>>
>> 0002:00:07.0 Non-VGA unclassified device: Silicon Graphics Intl. Corp. RAD Audio (rev 70)
>>         Control: I/O- Mem- BusMaster- SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B- DisINTx-
>>         Status: Cap- 66MHz- UDF- FastB2B+ ParErr- DEVSEL=slow >TAbort- <TAbort- <MAbort- >SERR- <PERR- INTx-
>>         NUMA node: 0
>>         Region 0: Memory at <unassigned> (32-bit, non-prefetchable) [disabled] [size=8193]
>>         Region 1: Memory at <unassigned> (32-bit, non-prefetchable) [disabled] [size=2]
>>         Region 2: Memory at <unassigned> (32-bit, non-prefetchable) [disabled] [size=2]
>>         Region 3: Memory at <unassigned> (32-bit, non-prefetchable) [disabled] [size=2]
>>         Region 4: Memory at <unassigned> (32-bit, non-prefetchable) [disabled] [size=2]
>>         Region 5: Memory at <unassigned> (32-bit, non-prefetchable) [disabled] [size=2]
>>         Expansion ROM at <unassigned> [disabled] [size=2]
>> 00: a9 10 05 00 00 00 80 04 70 00 00 00 00 00 00 00
>> 10: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
>> 20: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
>> 30: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
>>
>>
>> IP27 hardware does some interesting things with address spaces, depending on
>> which "mode" you run the machine in.  "M mode" is the only one that's really
>> usable these days (the other, "N mode", doesn't boot).  Under M mode,
>> there's five address spaces, of which, "I/O Space" is selectable by turning on
>> specific bits in the 64-bit memory address.
>>
>> So, given 0x920000000b200000, bits 63:62 select physical addressing (10) and
>> bits 58:57 select I/O space (01), resulting in all PCI addresses (or any I/O
>> address) appearing in the 0x92xxxxxxxxxxxxxx range.  The rest of the bits go
>> on to select which NUMA node the I/O is targeted at and which Crosstalk widget
>> to access, and so on.  I still haven't fully understood it all myself just
>> yet.
>>
>> You can google for document 007-3410-001, "Origin and Onyx2 Programmer's
>> Reference Manual" for more details (it's no longer available via SGI's
>> TechPubs, but it is archived on plenty of other sites).
>>
>> This particular machine that I have has three "BRIDGE" chips in it, all
>> attached to the Crosstalk bus.  Each BRIDGE can address up to 8 PCI devices,
>> but some crosstalk boards slap a BRIDGE chip on for just a single device.  In
>> this instance, the BRIDGE w/ address 0x920000000fxxxxxx is the IO6 at xtalk
>> widget 0xf (this has the basic I/O devices for this machine).  The BRIDGE at
>> 0x920000000cxxxxxx (widget 0xc) is a PCI "shoebox" that can hold up to three
>> PCI-X cards, and the BRIDGE at 0x920000000bxxxxxx (widget 0xb) is an
>> SGI-specific HIPPI board (ID'ed as a LINC I/O controller by pci.ids).
