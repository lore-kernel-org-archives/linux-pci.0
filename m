Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-ig0-f176.google.com ([209.85.213.176]:37206 "EHLO
	mail-ig0-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758301AbaDXQhl (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Thu, 24 Apr 2014 12:37:41 -0400
Received: by mail-ig0-f176.google.com with SMTP id uy17so1110663igb.9
        for <linux-pci@vger.kernel.org>; Thu, 24 Apr 2014 09:37:41 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <CAHH3p5+qEeYaNKm-L4_RmnkmXeA2030u4t3D+J2wUwBEWiPBPQ@mail.gmail.com>
References: <CAHH3p5+9VCYwS6JdB8aFJ0i4JLcFTMgSgiKOaE2GMnhfWM1bWA@mail.gmail.com>
 <CAErSpo7cDPa0vujMmppWV2RM3vn6=WJ7MCcP8CvwhT4Zn==MwA@mail.gmail.com> <CAHH3p5+qEeYaNKm-L4_RmnkmXeA2030u4t3D+J2wUwBEWiPBPQ@mail.gmail.com>
From: Bjorn Helgaas <bhelgaas@google.com>
Date: Thu, 24 Apr 2014 10:37:21 -0600
Message-ID: <CAErSpo6+_Tnh9+r50_qK-v0ubpv_pqTcnS7DhMiNi8GbWmsgJA@mail.gmail.com>
Subject: Re: Intel NIC testing on ARM
To: shiv prakash Agarwal <chhotu.shiv@gmail.com>
Cc: "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Thu, Apr 24, 2014 at 1:47 AM, shiv prakash Agarwal
<chhotu.shiv@gmail.com> wrote:
> Hi Bjorn,
>
> Below is the hang:
>
>
> PCI host bridge to bus 0000:00
>
> pci_bus 0000:00: root bus resource [mem 0x32100000-0x3fffffff]
>
> pci_bus 0000:00: root bus resource [mem 0x12100000-0x320fffff pref]
>
> pci_bus 0000:00: root bus resource [io  0x1000-0xffff]
>
> pci_bus 0000:00: No busn resource found for root bus, will use [bus 00-ff]
>
> pci 0000:00:00.0: [10de:0e12] type 01 class 0x060400
>
> pci 0000:00:00.0: PME# supported from D0 D1 D2 D3hot D3cold
>
> PCI: bus0: Fast back to back transfers disabled
>
> pci 0000:00:00.0: bridge configuration invalid ([bus 00-00]), reconfiguring
>
> pci 0000:01:00.0: [8086:1533] type 00 class 0x020000
>
> pci 0000:01:00.0: reg 10: [mem 0x00000000-0x000fffff]
>
> Unhandled fault: imprecise external abort (0x1406) at 0x00000000
>
> Internal error: : 1406 [#1] PREEMPT SMP ARM
>
> Modules linked in:
>
> CPU: 0 PID: 1 Comm: swapper/0 Not tainted 3.10.24 #2
>
> task: ef06fa40 ti: ef0b2000 task.ti: ef0b2000

This looks like it's happening before the igb driver is involved.
There must be a bridge from bus 0000:00 to bus 0000:01.  It looks like
0000:00:00.0 might be the bridge, but we haven't finished enumerating
it yet.  So it seems likely that this is happening in the PCI core.

Can you get a backtrace at the point of the fault?  Maybe add a
dump_stack() there?

The 01:00.0 BAR contains zero, which is not itself a problem.  Zero is
what you'd expect after power-up if no firmware or anything had
programmed it.  The PCI core should notice that this is invalid (it's
not inside any of the root bus resources) and reprogram it, but we
haven't gotten that far yet.

> On Tue, Apr 22, 2014 at 9:31 PM, Bjorn Helgaas <bhelgaas@google.com> wrote:
>> On Tue, Apr 22, 2014 at 3:50 AM, shiv prakash Agarwal
>> <chhotu.shiv@gmail.com> wrote:
>>> Hi All,
>>>
>>> Has anybody tested below Intel I210 NIC card using igb driver on ARM?
>>>
>>> http://www.intel.com/content/www/us/en/ethernet-controllers/ethernet-controller-i210-i211-family.html
>>>
>>> It hangs during configuration stage for me. Actually it shows BAR0
>>> requirement as 0 which is non-zero for x86.
>>
>> Can you give any more details about this, e.g., a complete dmesg log,
>> which should contain details about enumeration and resource
>> allocation?
