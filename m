Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-oa0-f44.google.com ([209.85.219.44]:51466 "EHLO
	mail-oa0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755812AbaEHUOs (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Thu, 8 May 2014 16:14:48 -0400
Received: by mail-oa0-f44.google.com with SMTP id i11so3775412oag.31
        for <linux-pci@vger.kernel.org>; Thu, 08 May 2014 13:14:47 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <CAErSpo56OLCRyqnDQb34EVOknBTQ2xniqhaMP9RysMW1terBUg@mail.gmail.com>
References: <CAHH3p5L3T7KoMUbAZvbgq2MBzunLRYr2v0tBcQkPp5=8mdiCyg@mail.gmail.com>
	<CAErSpo56OLCRyqnDQb34EVOknBTQ2xniqhaMP9RysMW1terBUg@mail.gmail.com>
Date: Fri, 9 May 2014 01:44:47 +0530
Message-ID: <CAHH3p5J0jFNQJWmYR5qvJc-bnb74f-4Ua1Dz4KLSbtqihXk3Hg@mail.gmail.com>
Subject: Re: Unassigned bars query
From: shiv prakash Agarwal <chhotu.shiv@gmail.com>
To: Bjorn Helgaas <bhelgaas@google.com>
Cc: Pratyush Anand <pratyush.anand@st.com>,
	Yinghai Lu <yinghai@kernel.org>,
	"linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
	Alex Williamson <alex.williamson@redhat.com>
Content-Type: text/plain; charset=UTF-8
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Below is dmesg:

[    0.763264] PCI host bridge to bus 0000:00
[    0.763380] pci_bus 0000:00: root bus resource [mem 0x32100000-0x3fffffff]
[    0.763694] pci_bus 0000:00: root bus resource [mem
0x12100000-0x320fffff pref]
[    0.764030] pci_bus 0000:00: root bus resource [io  0x1000-0xffff]
[    0.764315] pci_bus 0000:00: No busn resource found for root bus,
will use [bus 00-ff]
[    0.765085] PCI: bus0: Fast back to back transfers disabled
[    0.765278] pci 0000:00:00.0: bridge configuration invalid ([bus
00-00]), reconfiguring
[    0.766292] PCI: bus1: Fast back to back transfers disabled
[    0.766658] PCIE: arch_setup_msi_irq(2735)
[    0.767168] pcieport 0000:00:00.0: Signaling PME through PCIe PME interrupt
[    0.767413] pci 0000:01:00.0: Signaling PME through PCIe PME interrupt
[    0.768101] pcieport 0000:00:00.0: BAR 9: assigned [mem
0x12100000-0x121fffff 64bit pref]
[    0.768405] pcieport 0000:00:00.0: PCI bridge to [bus 01]
[    0.768683] pcieport 0000:00:00.0:   bridge window [mem
0x12100000-0x121fffff 64bit pref]

On Thu, May 8, 2014 at 9:37 PM, Bjorn Helgaas <bhelgaas@google.com> wrote:
> [Your original mail was multipart and therefore didn't appear on the
> list; see http://vger.kernel.org/majordomo-info.html.  Please use
> plain text for the mailing list.]
>
> On Thu, May 8, 2014 at 6:18 AM, shiv prakash Agarwal
> <chhotu.shiv@gmail.com> wrote:
>> Why some of bars are unassigned as below?
>>
>> I have one pcie card which needs only 16K pref memory but it remains
>> unassigned although host can provide around 512M pref memory.
>>
>>
>> Region 1: Memory at <unassigned> (32-bit, prefetchable)
>
> The PCI doesn't assign resources by itself.  Most architectures call
> pci_assign_unassigned_resources() somewhere, which does.
>
> But I can't give any more clues without seeing a complete dmesg log
> and "lspci -vv" output.
