Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from szxga01-in.huawei.com ([58.251.152.64]:19902 "EHLO
	szxga01-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751119AbbCaGie (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Tue, 31 Mar 2015 02:38:34 -0400
Message-ID: <551A40E8.4080708@huawei.com>
Date: Tue, 31 Mar 2015 14:38:32 +0800
From: Yijing Wang <wangyijing@huawei.com>
MIME-Version: 1.0
To: Yinghai Lu <yinghai@kernel.org>
CC: Bjorn Helgaas <bhelgaas@google.com>,
	PCI <linux-pci@vger.kernel.org>,
	"Herui (Ray)" <Ray.herui@huawei.com>
Subject: Re: Assign mem resource fail after remove and rescan
References: <55167C1C.6010001@huawei.com> <CAE9FiQWWNmJA1qKDaumuc8+EOj7E+fhbaZaNzTVyaDzbX4j9Hg@mail.gmail.com>
In-Reply-To: <CAE9FiQWWNmJA1qKDaumuc8+EOj7E+fhbaZaNzTVyaDzbX4j9Hg@mail.gmail.com>
Content-Type: text/plain; charset="ISO-8859-1"
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On 2015/3/29 14:18, Yinghai Lu wrote:
> On Sat, Mar 28, 2015 at 3:02 AM, Yijing Wang <wangyijing@huawei.com> wrote:
>> ...
>>
>> I compared above log and found after we did remove and rescan, the bridge requested resource size extended to 0x06000000,
>> and when system boot up, it requested only 0x4800000.
>>
>> In hotplug(remove and rescan) path, we would call calculate_mem_align() function which would align the resource at 0x2000000.
> 
> Looks like we align the size too early. Please check if attach patch
> could fix the problem.
> 

Hi Yinghai,
   I tested it, remove and rescan 05:19.0 device is ok now, but
if do the operations for the parent device of 05:19.0, the result is
still fail.

-[0000:00]-+-00.0  Intel Corporation 2nd Generation Core Processor Family DRAM Controller
           +-01.0-[01]--
           +-16.0  Intel Corporation 6 Series/C200 Series Chipset Family MEI Controller #1
           +-19.0  Intel Corporation 82579LM Gigabit Network Connection
           +-1a.0  Intel Corporation 6 Series/C200 Series Chipset Family USB Enhanced Host Controller #2
           +-1c.0-[02-21]----00.0-[03-21]--+-01.0-[04-12]----00.0-[05-12]----19.0-[06-12]----00.0  PLX Technology, Inc. Device 1009
           |                               +-05.0-[13]--

Remove and rescan for 04:00.0

...
[  152.657657] pci_bus 0000:06: busn_res: [bus 06-12] is released
[  152.659086] pci_bus 0000:05: busn_res: [bus 05-12] is released
[  165.353539] pci_bus 0000:01: busn_res: [bus 01] end is updated to 01
[  165.353789] pci 0000:04:00.0: [10b5:9797] type 01 class 0x060400
[  165.354149] pci 0000:04:00.0: PME# supported from D0 D3hot D3cold
[  165.362337] pci_bus 0000:05: busn_res: can not insert [bus 05-ff] under [bus 04-12] (conflicts with (null) [bus 04-12])
[  165.362935] pci 0000:05:19.0: [10b5:9797] type 01 class 0x060400
[  165.363250] pci 0000:05:19.0: PME# supported from D0 D3hot D3cold
[  165.365996] pci 0000:04:00.0: PCI bridge to [bus 05-ff]
[  165.366026] pci 0000:04:00.0:   bridge window [mem 0xe4000000-0xe87fffff]
[  165.368389] pci 0000:06:00.0: [10b5:1009] type 00 class 0x088000
[  165.368458] pci 0000:06:00.0: reg 0x10: [mem 0xe8000000-0xe87fffff]
[  165.368524] pci 0000:06:00.0: reg 0x18: [mem 0xe4000000-0xe7ffffff 64bit]
[  165.369912] pci 0000:05:19.0: PCI bridge to [bus 06-ff]
[  165.369939] pci 0000:05:19.0:   bridge window [mem 0xe4000000-0xe87fffff]
[  165.369958] pci_bus 0000:06: busn_res: [bus 06-ff] end is updated to 12
[  165.369972] pci_bus 0000:05: busn_res: [bus 05-ff] end is updated to 12
[  165.369984] pci_bus 0000:04: busn_res: [bus 04-12] end is updated to 12
[  165.370014] pci_bus 0000:13: busn_res: [bus 13] end is updated to 13
[  165.370259] pci_bus 0000:16: busn_res: [bus 16] end is updated to 16
[  165.370304] pci_bus 0000:17: busn_res: [bus 17] end is updated to 17
[  165.370334] pci_bus 0000:18: busn_res: [bus 18-20] end is updated to 20
[  165.370346] pci_bus 0000:15: busn_res: [bus 15-20] end is updated to 20
[  165.370358] pci_bus 0000:14: busn_res: [bus 14-20] end is updated to 20
[  165.370384] pci_bus 0000:21: busn_res: [bus 21] end is updated to 21
[  165.370395] pci_bus 0000:03: busn_res: [bus 03-21] end is updated to 21
[  165.370404] pci_bus 0000:02: busn_res: [bus 02-21] end is updated to 21
[  165.374463] pci_bus 0000:22: busn_res: [bus 22] end is updated to 22
[  165.374657] pci_bus 0000:24: busn_res: [bus 24] end is updated to 24
[  165.374670] pci_bus 0000:23: busn_res: [bus 23-24] end is updated to 24
[  165.374956] pci 0000:04:00.0: BAR 14: no space for [mem size 0x06000000]
[  165.374960] pci 0000:04:00.0: BAR 14: failed to assign [mem size 0x06000000]
[  165.374965] pci 0000:05:19.0: BAR 14: no space for [mem size 0x04800000]
[  165.374968] pci 0000:05:19.0: BAR 14: failed to assign [mem size 0x04800000]
[  165.374973] pci 0000:06:00.0: BAR 2: no space for [mem size 0x04000000 64bit]
[  165.374977] pci 0000:06:00.0: BAR 2: failed to assign [mem size 0x04000000 64bit]
[  165.374981] pci 0000:06:00.0: BAR 0: no space for [mem size 0x00800000]
[  165.374984] pci 0000:06:00.0: BAR 0: failed to assign [mem size 0x00800000]
[  165.374989] pci 0000:05:19.0: PCI bridge to [bus 06-12]
[  165.375025] pci 0000:04:00.0: PCI bridge to [bus 05-12]
[  165.375064] pci 0000:23:00.0: PCI bridge to [bus 24]



> Thanks
> 
> Yinghai
> 


-- 
Thanks!
Yijing

