Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-oa0-f53.google.com ([209.85.219.53]:65338 "EHLO
	mail-oa0-f53.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752556AbaDXHr7 (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Thu, 24 Apr 2014 03:47:59 -0400
Received: by mail-oa0-f53.google.com with SMTP id j17so2185705oag.26
        for <linux-pci@vger.kernel.org>; Thu, 24 Apr 2014 00:47:59 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <CAErSpo7cDPa0vujMmppWV2RM3vn6=WJ7MCcP8CvwhT4Zn==MwA@mail.gmail.com>
References: <CAHH3p5+9VCYwS6JdB8aFJ0i4JLcFTMgSgiKOaE2GMnhfWM1bWA@mail.gmail.com>
	<CAErSpo7cDPa0vujMmppWV2RM3vn6=WJ7MCcP8CvwhT4Zn==MwA@mail.gmail.com>
Date: Thu, 24 Apr 2014 13:17:59 +0530
Message-ID: <CAHH3p5+qEeYaNKm-L4_RmnkmXeA2030u4t3D+J2wUwBEWiPBPQ@mail.gmail.com>
Subject: Re: Intel NIC testing on ARM
From: shiv prakash Agarwal <chhotu.shiv@gmail.com>
To: Bjorn Helgaas <bhelgaas@google.com>
Cc: "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Hi Bjorn,

Below is the hang:


PCI host bridge to bus 0000:00

pci_bus 0000:00: root bus resource [mem 0x32100000-0x3fffffff]

pci_bus 0000:00: root bus resource [mem 0x12100000-0x320fffff pref]

pci_bus 0000:00: root bus resource [io  0x1000-0xffff]

pci_bus 0000:00: No busn resource found for root bus, will use [bus 00-ff]

pci 0000:00:00.0: [10de:0e12] type 01 class 0x060400

pci 0000:00:00.0: PME# supported from D0 D1 D2 D3hot D3cold

PCI: bus0: Fast back to back transfers disabled

pci 0000:00:00.0: bridge configuration invalid ([bus 00-00]), reconfiguring

pci 0000:01:00.0: [8086:1533] type 00 class 0x020000

pci 0000:01:00.0: reg 10: [mem 0x00000000-0x000fffff]

Unhandled fault: imprecise external abort (0x1406) at 0x00000000

Internal error: : 1406 [#1] PREEMPT SMP ARM

Modules linked in:

CPU: 0 PID: 1 Comm: swapper/0 Not tainted 3.10.24 #2

task: ef06fa40 ti: ef0b2000 task.ti: ef0b2000


On Tue, Apr 22, 2014 at 9:31 PM, Bjorn Helgaas <bhelgaas@google.com> wrote:
> On Tue, Apr 22, 2014 at 3:50 AM, shiv prakash Agarwal
> <chhotu.shiv@gmail.com> wrote:
>> Hi All,
>>
>> Has anybody tested below Intel I210 NIC card using igb driver on ARM?
>>
>> http://www.intel.com/content/www/us/en/ethernet-controllers/ethernet-controller-i210-i211-family.html
>>
>> It hangs during configuration stage for me. Actually it shows BAR0
>> requirement as 0 which is non-zero for x86.
>
> Can you give any more details about this, e.g., a complete dmesg log,
> which should contain details about enumeration and resource
> allocation?
