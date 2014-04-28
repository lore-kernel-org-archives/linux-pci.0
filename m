Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-ie0-f175.google.com ([209.85.223.175]:33624 "EHLO
	mail-ie0-f175.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751601AbaD1TIU (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Mon, 28 Apr 2014 15:08:20 -0400
Received: by mail-ie0-f175.google.com with SMTP id rl12so902760iec.34
        for <linux-pci@vger.kernel.org>; Mon, 28 Apr 2014 12:08:20 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <CAHH3p5LKay-1gcgCn1fatM0hOL1Tc+a81Za+ePVjJ6oPo8+6rg@mail.gmail.com>
References: <CAHH3p5+9VCYwS6JdB8aFJ0i4JLcFTMgSgiKOaE2GMnhfWM1bWA@mail.gmail.com>
 <CAErSpo7cDPa0vujMmppWV2RM3vn6=WJ7MCcP8CvwhT4Zn==MwA@mail.gmail.com>
 <CAHH3p5+qEeYaNKm-L4_RmnkmXeA2030u4t3D+J2wUwBEWiPBPQ@mail.gmail.com>
 <CAErSpo6+_Tnh9+r50_qK-v0ubpv_pqTcnS7DhMiNi8GbWmsgJA@mail.gmail.com>
 <CAHH3p5+xTwMaDW-k-0UUZ+21EhCCt2voWXP2jZf_PbRqOdukiA@mail.gmail.com>
 <CAErSpo7jd2smdoju31r7SWVp4KjNmN+qDAxSUxmVCnUSUOfKTw@mail.gmail.com> <CAHH3p5LKay-1gcgCn1fatM0hOL1Tc+a81Za+ePVjJ6oPo8+6rg@mail.gmail.com>
From: Bjorn Helgaas <bhelgaas@google.com>
Date: Mon, 28 Apr 2014 12:00:16 -0600
Message-ID: <CAErSpo5VWnAG3xnhn0zgpyC22Eum=ZVR=BM8j2Rvt+=i7LZgjA@mail.gmail.com>
Subject: Re: Intel NIC testing on ARM
To: shiv prakash Agarwal <chhotu.shiv@gmail.com>
Cc: "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Sat, Apr 26, 2014 at 12:09 PM, shiv prakash Agarwal
<chhotu.shiv@gmail.com> wrote:
> Thanks Bjorn,
>
> 1. I see PCI core setting this bit while enumeration.
> 2. Avoiding this setting allows successful enumeration, otherwise hang
> occurs in any subsequent device config space write.
> 3. Yes, no dma operation happening but hang happens on device config space
> write.

OK, let me know when you figure out where the core is turning on Bus
Master and what config access we're doing when the hang occurs.

> On Fri, Apr 25, 2014 at 8:08 PM, Bjorn Helgaas <bhelgaas@google.com> wrote:
>>
>> On Thu, Apr 24, 2014 at 11:40 PM, shiv prakash Agarwal
>> <chhotu.shiv@gmail.com> wrote:
>> > Thanks Bjorn,
>> >
>> > On furthur debug, I found that this hang happens on enabling Bus Master
>> > Enable bit(bit 2) of command register (offset 0x4) in config space of
>> > device. On disabling this bit, no hang occurs.
>> >
>> > Any idea on this behaviour?
>>
>> It'd  be easier if you gave a few more details.  Where exactly did you
>> remove the Bus Master enable?  The PCI core should not enable Bus
>> Master for an endpoint at all unless the driver requests it, and based
>> on the dmesg fragment you posted, I don't think the driver is involved
>> yet.
>>
>> Bus mastering affects transactions originated by the device, of
>> course.  So if the hang only happens if Bus Master is enabled, it
>> sounds like the hang happens when the device performs a DMA or other
>> transaction.  But if the driver hasn't claimed the device yet, the
>> device shouldn't be doing anything at all, even if Bus Master is
>> enabled.
>>
>> There might be more clues if you would post the *entire* dmesg log
>> instead of just a fragment.
>>
>> > On Thu, Apr 24, 2014 at 10:07 PM, Bjorn Helgaas <bhelgaas@google.com>
>> > wrote:
>> >>
>> >> On Thu, Apr 24, 2014 at 1:47 AM, shiv prakash Agarwal
>> >> <chhotu.shiv@gmail.com> wrote:
>> >> > Hi Bjorn,
>> >> >
>> >> > Below is the hang:
>> >> >
>> >> >
>> >> > PCI host bridge to bus 0000:00
>> >> >
>> >> > pci_bus 0000:00: root bus resource [mem 0x32100000-0x3fffffff]
>> >> >
>> >> > pci_bus 0000:00: root bus resource [mem 0x12100000-0x320fffff pref]
>> >> >
>> >> > pci_bus 0000:00: root bus resource [io  0x1000-0xffff]
>> >> >
>> >> > pci_bus 0000:00: No busn resource found for root bus, will use [bus
>> >> > 00-ff]
>> >> >
>> >> > pci 0000:00:00.0: [10de:0e12] type 01 class 0x060400
>> >> >
>> >> > pci 0000:00:00.0: PME# supported from D0 D1 D2 D3hot D3cold
>> >> >
>> >> > PCI: bus0: Fast back to back transfers disabled
>> >> >
>> >> > pci 0000:00:00.0: bridge configuration invalid ([bus 00-00]),
>> >> > reconfiguring
>> >> >
>> >> > pci 0000:01:00.0: [8086:1533] type 00 class 0x020000
>> >> >
>> >> > pci 0000:01:00.0: reg 10: [mem 0x00000000-0x000fffff]
>> >> >
>> >> > Unhandled fault: imprecise external abort (0x1406) at 0x00000000
>> >> >
>> >> > Internal error: : 1406 [#1] PREEMPT SMP ARM
>> >> >
>> >> > Modules linked in:
>> >> >
>> >> > CPU: 0 PID: 1 Comm: swapper/0 Not tainted 3.10.24 #2
>> >> >
>> >> > task: ef06fa40 ti: ef0b2000 task.ti: ef0b2000
>> >>
>> >> This looks like it's happening before the igb driver is involved.
>> >> There must be a bridge from bus 0000:00 to bus 0000:01.  It looks like
>> >> 0000:00:00.0 might be the bridge, but we haven't finished enumerating
>> >> it yet.  So it seems likely that this is happening in the PCI core.
>> >>
>> >> Can you get a backtrace at the point of the fault?  Maybe add a
>> >> dump_stack() there?
>> >>
>> >> The 01:00.0 BAR contains zero, which is not itself a problem.  Zero is
>> >> what you'd expect after power-up if no firmware or anything had
>> >> programmed it.  The PCI core should notice that this is invalid (it's
>> >> not inside any of the root bus resources) and reprogram it, but we
>> >> haven't gotten that far yet.
>> >>
>> >> > On Tue, Apr 22, 2014 at 9:31 PM, Bjorn Helgaas <bhelgaas@google.com>
>> >> > wrote:
>> >> >> On Tue, Apr 22, 2014 at 3:50 AM, shiv prakash Agarwal
>> >> >> <chhotu.shiv@gmail.com> wrote:
>> >> >>> Hi All,
>> >> >>>
>> >> >>> Has anybody tested below Intel I210 NIC card using igb driver on
>> >> >>> ARM?
>> >> >>>
>> >> >>>
>> >> >>>
>> >> >>> http://www.intel.com/content/www/us/en/ethernet-controllers/ethernet-controller-i210-i211-family.html
>> >> >>>
>> >> >>> It hangs during configuration stage for me. Actually it shows BAR0
>> >> >>> requirement as 0 which is non-zero for x86.
>> >> >>
>> >> >> Can you give any more details about this, e.g., a complete dmesg
>> >> >> log,
>> >> >> which should contain details about enumeration and resource
>> >> >> allocation?
>> >
>> >
>
>
