Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-ig0-f171.google.com ([209.85.213.171]:47946 "EHLO
	mail-ig0-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751778AbaD2QVw (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Tue, 29 Apr 2014 12:21:52 -0400
Received: by mail-ig0-f171.google.com with SMTP id c1so577313igq.16
        for <linux-pci@vger.kernel.org>; Tue, 29 Apr 2014 09:21:51 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <CAHH3p5KYoPdRO-SEBGMwEPC5dhRd0j_nq_jDz+Z2WMuzOPKREA@mail.gmail.com>
References: <CAHH3p5+9VCYwS6JdB8aFJ0i4JLcFTMgSgiKOaE2GMnhfWM1bWA@mail.gmail.com>
 <CAErSpo7cDPa0vujMmppWV2RM3vn6=WJ7MCcP8CvwhT4Zn==MwA@mail.gmail.com>
 <CAHH3p5+qEeYaNKm-L4_RmnkmXeA2030u4t3D+J2wUwBEWiPBPQ@mail.gmail.com>
 <CAErSpo6+_Tnh9+r50_qK-v0ubpv_pqTcnS7DhMiNi8GbWmsgJA@mail.gmail.com>
 <CAHH3p5+xTwMaDW-k-0UUZ+21EhCCt2voWXP2jZf_PbRqOdukiA@mail.gmail.com>
 <CAErSpo7jd2smdoju31r7SWVp4KjNmN+qDAxSUxmVCnUSUOfKTw@mail.gmail.com>
 <CAHH3p5LKay-1gcgCn1fatM0hOL1Tc+a81Za+ePVjJ6oPo8+6rg@mail.gmail.com>
 <CAErSpo5VWnAG3xnhn0zgpyC22Eum=ZVR=BM8j2Rvt+=i7LZgjA@mail.gmail.com>
 <CAHH3p5+aRDq3j_au2Kou6Ef9L+iLaCUVV7hwZPhmD_HU6TxzqQ@mail.gmail.com> <CAHH3p5KYoPdRO-SEBGMwEPC5dhRd0j_nq_jDz+Z2WMuzOPKREA@mail.gmail.com>
From: Bjorn Helgaas <bhelgaas@google.com>
Date: Tue, 29 Apr 2014 10:21:29 -0600
Message-ID: <CAErSpo7gtOoh_swzOtSyzkjRXUuZvLWwWpBeqHgy-9J4oB6b7g@mail.gmail.com>
Subject: Re: Intel NIC testing on ARM
To: shiv prakash Agarwal <chhotu.shiv@gmail.com>
Cc: "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
	Linux NICS <linux.nics@intel.com>,
	"e1000-devel@lists.sourceforge.net"
	<e1000-devel@lists.sourceforge.net>,
	Thierry Reding <thierry.reding@gmail.com>,
	"linux-tegra@vger.kernel.org" <linux-tegra@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

[+cc igb, tegra folks]

On Tue, Apr 29, 2014 at 9:25 AM, shiv prakash Agarwal
<chhotu.shiv@gmail.com> wrote:
> Also if I disable enabling bus master from igb driver, then ethernet
> functionality does not work due to below issue:

This looks like an igb or (more likely) a tegra host bridge driver
issue, so hopefully somebody there can help you.

> root@tegra-ubuntu:~# dhclient eth0
> [   82.642468] IPv6: ADDRCONF(NETDEV_UP): eth0: link is not ready
> [   86.741124] igb: eth0 NIC Link is Up 1000 Mbps Full Duplex, Flow Control:
> RX
> [   86.763938] IPv6: ADDRCONF(NETDEV_CHANGE): eth0: link becomes ready
> [   96.748110] ------------[ cut here ]------------
> [   96.756653] WARNING: at
> /home/shiv/kernel_builds/linux/kernel/net/sched/sch_generic.c:255
> dev_watchdog+0x264/0
> x284()
> [   96.775062] NETDEV WATCHDOG: eth0 (igb): transmit queue 0 timed out
> [   96.785783] Modules linked in:
> [   96.791521] CPU: 0 PID: 0 Comm: swapper/0 Not tainted
> 3.10.33-gce40538-dirty #289
> [   96.804501] [<c00167e0>] (unwind_backtrace+0x0/0x140) from [<c0013134>]
> (show_stack+0x18/0x1c)
> [   96.819303] [<c0013134>] (show_stack+0x18/0x1c) from [<c0066604>]
> (warn_slowpath_common+0x54/0x70)
> [   96.834651] [<c0066604>] (warn_slowpath_common+0x54/0x70) from
> [<c00666cc>] (warn_slowpath_fmt+0x38/0x48)
> [   96.851027] [<c00666cc>] (warn_slowpath_fmt+0x38/0x48) from [<c068cd50>]
> (dev_watchdog+0x264/0x284)
> [   96.866561] [<c068cd50>] (dev_watchdog+0x264/0x284) from [<c0075be4>]
> (call_timer_fn+0x44/0x15c)
> [   96.881647] [<c0075be4>] (call_timer_fn+0x44/0x15c) from [<c0075fdc>]
> (run_timer_softirq+0x218/0x2b8)
> [   96.897412] [<c0075fdc>] (run_timer_softirq+0x218/0x2b8) from
> [<c006e994>] (__do_softirq+0xf4/0x2a0)
> [   96.913000] [<c006e994>] (__do_softirq+0xf4/0x2a0) from [<c006ebf8>]
> (do_softirq+0x54/0x60)
> [   96.927287] [<c006ebf8>] (do_softirq+0x54/0x60) from [<c006eea8>]
> (irq_exit+0x98/0xd0)
> [   96.940975] [<c006eea8>] (irq_exit+0x98/0xd0) from [<c000fa78>]
> (handle_IRQ+0x44/0x98)
> [   96.954572] [<c000fa78>] (handle_IRQ+0x44/0x98) from [<c00084e4>]
> (gic_handle_irq+0x30/0x64)
> [   96.969013] [<c00084e4>] (gic_handle_irq+0x30/0x64) from [<c000ec40>]
> (__irq_svc+0x40/0x70)
> [   96.983212] Exception stack(0xc0b33eb8 to 0xc0b33f00)
> [   96.991948] 3ea0:
> c0b33f10 00000000
> [   97.005878] 3ec0: 00000000 000f4240 c1cc2658 c1cc03e8 c0c79744 00000001
> 00002138 00000000
> [   97.019879] 3ee0: c0b33f08 c07bcd20 3b9ac9ff c0b33f00 c02863bc c003dbd4
> 20000153 ffffffff
> [   97.034051] [<c000ec40>] (__irq_svc+0x40/0x70) from [<c003dbd4>]
> (tegra_idle_enter_pd+0x11c/0x260)
> [   97.049398] [<c003dbd4>] (tegra_idle_enter_pd+0x11c/0x260) from
> [<c059135c>] (cpuidle_enter_state+0x48/0x104)
> [   97.066323] [<c059135c>] (cpuidle_enter_state+0x48/0x104) from
> [<c0591570>] (cpuidle_idle_call+0x158/0x298)
> [   97.082960] [<c0591570>] (cpuidle_idle_call+0x158/0x298) from
> [<c0010018>] (arch_cpu_idle+0x10/0x40)
> [   97.098580] [<c0010018>] (arch_cpu_idle+0x10/0x40) from [<c00adf6c>]
> (cpu_idle_loop+0x9c/0x23c)
> [   97.113506] [<c00adf6c>] (cpu_idle_loop+0x9c/0x23c) from [<c0ab4a28>]
> (start_kernel+0x2c4/0x318)
> [   97.128431] ---[ end trace 67ee6f365a411999 ]---
> [   97.153381] igb 0000:01:00.0 eth0: Reset adapter
> [  101.738002] igb: eth0 NIC Link is Up 1000 Mbps Full Duplex, Flow Control:
> RX
> [  121.741066] igb 0000:01:00.0 eth0: Reset adapter
> [  125.738392] igb: eth0 NIC Link is Up 1000 Mbps Full Duplex, Flow Control:
> RX
> [  133.776217] init: alsa-restore main process (814) terminated with status
> 99
> [  133.856801] init: plymouth-stop pre-start process (843) terminated with
> status 1
> [  145.741028] igb 0000:01:00.0 eth0: Reset adapter
> [  149.738496] igb: eth0 NIC Link is Up 1000 Mbps Full Duplex, Flow Control:
> RX
> [  164.749112] igb 0000:01:00.0 eth0: Reset adapter
> [  168.739933] igb: eth0 NIC Link is Up 1000 Mbps Full Duplex, Flow Control:
> RX
> [  183.740495] igb 0000:01:00.0 eth0: Reset adapter
> [  187.738360] igb: eth0 NIC Link is Up 1000 Mbps Full Duplex, Flow Control:
> RX
> [  202.749111] igb 0000:01:00.0 eth0: Reset adapter
> [  206.739319] igb: eth0 NIC Link is Up 1000 Mbps Full Duplex, Flow Control:
> RX
> [  216.749057] igb 0000:01:00.0 eth0: Reset adapter
> [  220.739305] igb: eth0 NIC Link is Up 1000 Mbps Full Duplex, Flow Control:
> RX
> [  240.749111] igb 0000:01:00.0 eth0: Reset adapter
> [  244.739199] igb: eth0 NIC Link is Up 1000 Mbps Full Duplex, Flow Control:
> RX
> [  259.740507] igb 0000:01:00.0 eth0: Reset adapter
> [  263.738512] igb: eth0 NIC Link is Up 1000 Mbps Full Duplex, Flow Control:
> RX
> [  278.749107] igb 0000:01:00.0 eth0: Reset adapter
> [  282.739504] igb: eth0 NIC Link is Up 1000 Mbps Full Duplex, Flow Control:
> RX
> ------------------------CONTINUES for
> EVER---------------------------------------------------
>
>
> On Tue, Apr 29, 2014 at 8:53 PM, shiv prakash Agarwal
> <chhotu.shiv@gmail.com> wrote:
>>
>> Hi Bjorn,
>>
>> 1. Sorry, bus master is not enabled by core but my internel driver during
>> enumeration.
>> 2. I disabled this but later pci_set_master from igb driver enables bus
>> master and subsequently any config space write results in hang. Below is
>> log.
>>
>>
>> [    4.755092] tun: Universal TUN/TAP device driver, 1.6
>> [    4.760412] tun: (C) 1999-2004 Max Krasnyansky <maxk@qualcomm.com>
>> [    4.767129] igb: Intel(R) Gigabit Ethernet Network Driver - version
>> 5.0.3-k
>> [    4.774440] igb: Copyright (c) 2007-2013 Intel Corporation.
>> [    4.780364] PCI: enabling device 0000:01:00.0 (0140 -> 0142)
>> [   15.325507] Unhandled fault: imprecise external abort (0x1406) at
>> 0x00000000
>> [   15.332896] Internal error: : 1406 [#1] PREEMPT SMP ARM
>> [   15.338369] Modules linked in:
>> [   15.341599] CPU: 0 PID: 1 Comm: swapper/0 Not tainted
>> 3.10.33-gce40538-dirty #290
>> [   15.349437] task: ef092a40 ti: ef0d6000 task.ti: ef0d6000
>> [   15.355102] PC is at igb_reset_hw_82580+0xdc/0x244
>> [   15.360128] LR is at try_to_del_timer_sync+0x5c/0x68
>> [   15.365330] pc : [<c04697e8>]    lr : [<c0076134>]    psr: 60000013
>> [   15.365330] sp : ef0d7de0  ip : 00000000  fp : 00000001
>> [   15.377337] r10: ef00e000  r9 : 00000000  r8 : 301103b3
>> [   15.398091] r7 : 0c1c0241  r6 : c0c66000  r5 : 00000000  r4 : ef00e910
>> [   15.420140] r3 : f0400000  r2 : 00000000  r1 : a0000013  r0 : 00000000
>> [   15.427067] ata1: SATA link down (SStatus 0 SControl 300)
>> [   15.462779] Flags: nZCv  IRQs on  FIQs on  Mode SVC_32  ISA ARM
>> Segment kernel
>> [   15.485460] Control: 10c5387d  Table: 8000406a  DAC: 00000015
>> [   15.506469]
>> [   15.506469] PC: 0xc0469768:
>> [   15.540959] 9768  e19630b3 e3130004 1a000067 f57ff04f e3e02000 e5943004
>> e58320d8 f57ff04f
>> [   15.564657] 9788  e3a02000 e5943004 e5832100 f57ff04f e3a02008 e5943004
>> e5832400 e5943004
>> [   15.588227] 97a8  e5932008 f57ff04f e3a0000a ebf032ad e3550000 1a00002f
>> e3a05000 e3877301
>> [   15.611781] 97c8  f57ff04f e5943004 e5837000 e5943004 e5932008 f57ff04f
>> e3550000 1a000032
>> [   15.635375] 97e8  e1a00004 eb000c16 e3500000 0a000003 e30031f2 e19630b3
>> e3130004 1a00003b
>> [   15.658895] 9808  f57ff04f e3a02601 e5943004 e5832008 f57ff04f e3e02000
>> e5943004 e58320d8
>> [   15.682360] 9828  e5943004 e59320c0 f57ff04f e1a00004 ebfffb62 e3500000
>> 0a000003 e300320a
>> [   15.705742] 9848  e19630b3 e3130004 1a000021 e1a00004 eb000707 e3550000
>> e1a06000 0a000003
>> [   15.729109]
>> [   15.729109] LR: 0xc00760b4:
>> [   15.762894] 60b4  e1a01000 e5943000 e1560003 1a000001 e1a00007 e8bd80f8
>> e1a00007 eb1cebf1
>> [   15.786093] 60d4  eafffff0 e92d4030 e24dd00c e92d4000 e8bd4000 e1a05000
>> e28d1004 e280000c
>> [   15.809207] 60f4  ebffffe3 e5903004 e1a04000 e1530005 03e05000 0a000006
>> e3a03000 e1a00005
>> [   15.832362] 6114  e5853020 e1a01004 e3a02001 ebfffe5e e1a05000 e1a00004
>> e59d1004 eb1cebd9
>> [   15.855667] 6134  e1a00005 e28dd00c e8bd8030 e92d4010 e92d4000 e8bd4000
>> e1a0300d e3c32d7f
>> [   15.879163] 6154  e3a03000 e3c2203f e34033ff e5922004 e1a04000 e0023003
>> e3530000 0a000009
>> [   15.902736] 6174  e590300c e3130002 1a000006 e59f0028 e3001424 ebffc124
>> e1a00004 ebffffd0
>> [   15.926442] 6194  e3500000 aa000003 e1a00004 ebffffcc e3500000 bafffffb
>> e8bd8010 c096c744
>> [   15.950171]
>> [   15.950171] SP: 0xef0d7d60:
>> [   15.984886] 7d60  fdc42000 ef0d6000 60000013 ffffffff ef0d7dcc c000ec60
>> ef0d6000 ef00e000
>> [   16.008775] 7d80  c04697e8 60000013 ffffffff ef0d7dcc 301103b3 c000ebd8
>> 00000000 a0000013
>> [   16.032678] 7da0  00000000 f0400000 ef00e910 00000000 c0c66000 0c1c0241
>> 301103b3 00000000
>> [   16.056575] 7dc0  ef00e000 00000001 00000000 ef0d7de0 c0076134 c04697e8
>> 60000013 ffffffff
>> [   16.080528] 7de0  c046970c eb704000 00000000 ef00e4c0 eb704068 c045f978
>> eb704068 c03e9270
>> [   16.104568] 7e00  30110193 00000002 30110393 00000000 00110013 00000000
>> ef00e920 ef00e910
>> [   16.128769] 7e20  eb704068 60000013 00000004 00004f38 c0b2c604 eb704000
>> ef0d7e74 c0c220bc
>> [   16.152801] 7e40  eb704068 c0c64f38 c0b2c604 c0c220f0 00000000 c02bb0cc
>> c081637c eb704000
>> [   16.176726]
>> [   16.176726] R3: 0xf03fff80:
>> [   16.211382] ff80  ******** ******** ******** ******** ******** ********
>> ******** ********
>> [   16.235062] ffa0  ******** ******** ******** ******** ******** ********
>> ******** ********
>> [   16.258515] ffc0  ******** ******** ******** ******** ******** ********
>> ******** ********
>> [   16.281734] ffe0  ******** ******** ******** ******** ******** ********
>> ******** ********
>> [   16.304940] 0000  00000000 00000000 00000000 00000000 00000000 00000000
>> 00000000 00000000
>> [  100.543440] 0020  00000000 00000000 00000000 00000000 00000000 00000000
>> 00000000 00000000
>> [  184.781705] 0040
>>  CTRL-A Z for help |115200 8N1 | NOR | Minicom 2.5    | VT102 |
>> Offline
>>
>>
>>
>>
>>
>>
>> On Mon, Apr 28, 2014 at 11:30 PM, Bjorn Helgaas <bhelgaas@google.com>
>> wrote:
>>>
>>> On Sat, Apr 26, 2014 at 12:09 PM, shiv prakash Agarwal
>>> <chhotu.shiv@gmail.com> wrote:
>>> > Thanks Bjorn,
>>> >
>>> > 1. I see PCI core setting this bit while enumeration.
>>> > 2. Avoiding this setting allows successful enumeration, otherwise hang
>>> > occurs in any subsequent device config space write.
>>> > 3. Yes, no dma operation happening but hang happens on device config
>>> > space
>>> > write.
>>>
>>> OK, let me know when you figure out where the core is turning on Bus
>>> Master and what config access we're doing when the hang occurs.
>>>
>>> > On Fri, Apr 25, 2014 at 8:08 PM, Bjorn Helgaas <bhelgaas@google.com>
>>> > wrote:
>>> >>
>>> >> On Thu, Apr 24, 2014 at 11:40 PM, shiv prakash Agarwal
>>> >> <chhotu.shiv@gmail.com> wrote:
>>> >> > Thanks Bjorn,
>>> >> >
>>> >> > On furthur debug, I found that this hang happens on enabling Bus
>>> >> > Master
>>> >> > Enable bit(bit 2) of command register (offset 0x4) in config space
>>> >> > of
>>> >> > device. On disabling this bit, no hang occurs.
>>> >> >
>>> >> > Any idea on this behaviour?
>>> >>
>>> >> It'd  be easier if you gave a few more details.  Where exactly did you
>>> >> remove the Bus Master enable?  The PCI core should not enable Bus
>>> >> Master for an endpoint at all unless the driver requests it, and based
>>> >> on the dmesg fragment you posted, I don't think the driver is involved
>>> >> yet.
>>> >>
>>> >> Bus mastering affects transactions originated by the device, of
>>> >> course.  So if the hang only happens if Bus Master is enabled, it
>>> >> sounds like the hang happens when the device performs a DMA or other
>>> >> transaction.  But if the driver hasn't claimed the device yet, the
>>> >> device shouldn't be doing anything at all, even if Bus Master is
>>> >> enabled.
>>> >>
>>> >> There might be more clues if you would post the *entire* dmesg log
>>> >> instead of just a fragment.
>>> >>
>>> >> > On Thu, Apr 24, 2014 at 10:07 PM, Bjorn Helgaas
>>> >> > <bhelgaas@google.com>
>>> >> > wrote:
>>> >> >>
>>> >> >> On Thu, Apr 24, 2014 at 1:47 AM, shiv prakash Agarwal
>>> >> >> <chhotu.shiv@gmail.com> wrote:
>>> >> >> > Hi Bjorn,
>>> >> >> >
>>> >> >> > Below is the hang:
>>> >> >> >
>>> >> >> >
>>> >> >> > PCI host bridge to bus 0000:00
>>> >> >> >
>>> >> >> > pci_bus 0000:00: root bus resource [mem 0x32100000-0x3fffffff]
>>> >> >> >
>>> >> >> > pci_bus 0000:00: root bus resource [mem 0x12100000-0x320fffff
>>> >> >> > pref]
>>> >> >> >
>>> >> >> > pci_bus 0000:00: root bus resource [io  0x1000-0xffff]
>>> >> >> >
>>> >> >> > pci_bus 0000:00: No busn resource found for root bus, will use
>>> >> >> > [bus
>>> >> >> > 00-ff]
>>> >> >> >
>>> >> >> > pci 0000:00:00.0: [10de:0e12] type 01 class 0x060400
>>> >> >> >
>>> >> >> > pci 0000:00:00.0: PME# supported from D0 D1 D2 D3hot D3cold
>>> >> >> >
>>> >> >> > PCI: bus0: Fast back to back transfers disabled
>>> >> >> >
>>> >> >> > pci 0000:00:00.0: bridge configuration invalid ([bus 00-00]),
>>> >> >> > reconfiguring
>>> >> >> >
>>> >> >> > pci 0000:01:00.0: [8086:1533] type 00 class 0x020000
>>> >> >> >
>>> >> >> > pci 0000:01:00.0: reg 10: [mem 0x00000000-0x000fffff]
>>> >> >> >
>>> >> >> > Unhandled fault: imprecise external abort (0x1406) at 0x00000000
>>> >> >> >
>>> >> >> > Internal error: : 1406 [#1] PREEMPT SMP ARM
>>> >> >> >
>>> >> >> > Modules linked in:
>>> >> >> >
>>> >> >> > CPU: 0 PID: 1 Comm: swapper/0 Not tainted 3.10.24 #2
>>> >> >> >
>>> >> >> > task: ef06fa40 ti: ef0b2000 task.ti: ef0b2000
>>> >> >>
>>> >> >> This looks like it's happening before the igb driver is involved.
>>> >> >> There must be a bridge from bus 0000:00 to bus 0000:01.  It looks
>>> >> >> like
>>> >> >> 0000:00:00.0 might be the bridge, but we haven't finished
>>> >> >> enumerating
>>> >> >> it yet.  So it seems likely that this is happening in the PCI core.
>>> >> >>
>>> >> >> Can you get a backtrace at the point of the fault?  Maybe add a
>>> >> >> dump_stack() there?
>>> >> >>
>>> >> >> The 01:00.0 BAR contains zero, which is not itself a problem.  Zero
>>> >> >> is
>>> >> >> what you'd expect after power-up if no firmware or anything had
>>> >> >> programmed it.  The PCI core should notice that this is invalid
>>> >> >> (it's
>>> >> >> not inside any of the root bus resources) and reprogram it, but we
>>> >> >> haven't gotten that far yet.
>>> >> >>
>>> >> >> > On Tue, Apr 22, 2014 at 9:31 PM, Bjorn Helgaas
>>> >> >> > <bhelgaas@google.com>
>>> >> >> > wrote:
>>> >> >> >> On Tue, Apr 22, 2014 at 3:50 AM, shiv prakash Agarwal
>>> >> >> >> <chhotu.shiv@gmail.com> wrote:
>>> >> >> >>> Hi All,
>>> >> >> >>>
>>> >> >> >>> Has anybody tested below Intel I210 NIC card using igb driver
>>> >> >> >>> on
>>> >> >> >>> ARM?
>>> >> >> >>>
>>> >> >> >>>
>>> >> >> >>>
>>> >> >> >>>
>>> >> >> >>> http://www.intel.com/content/www/us/en/ethernet-controllers/ethernet-controller-i210-i211-family.html
>>> >> >> >>>
>>> >> >> >>> It hangs during configuration stage for me. Actually it shows
>>> >> >> >>> BAR0
>>> >> >> >>> requirement as 0 which is non-zero for x86.
>>> >> >> >>
>>> >> >> >> Can you give any more details about this, e.g., a complete dmesg
>>> >> >> >> log,
>>> >> >> >> which should contain details about enumeration and resource
>>> >> >> >> allocation?
>>> >> >
>>> >> >
>>> >
>>> >
>>
>>
>
