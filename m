Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from szxga02-in.huawei.com ([119.145.14.65]:3901 "EHLO
	szxga02-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754975AbbDILMc (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Thu, 9 Apr 2015 07:12:32 -0400
Message-ID: <55265E8E.7070509@huawei.com>
Date: Thu, 9 Apr 2015 19:12:14 +0800
From: Yijing Wang <wangyijing@huawei.com>
MIME-Version: 1.0
To: Yinghai Lu <yinghai@kernel.org>
CC: Bjorn Helgaas <bhelgaas@google.com>,
	PCI <linux-pci@vger.kernel.org>,
	"Herui (Ray)" <Ray.herui@huawei.com>
Subject: Re: Assign mem resource fail after remove and rescan
References: <55167C1C.6010001@huawei.com>	<CAE9FiQWWNmJA1qKDaumuc8+EOj7E+fhbaZaNzTVyaDzbX4j9Hg@mail.gmail.com>	<551A40E8.4080708@huawei.com> <CAE9FiQUQ_Kz8sNzu9RmOfoe4xEwfZ3atGcfQ39UAp4dRz2rRFA@mail.gmail.com>
In-Reply-To: <CAE9FiQUQ_Kz8sNzu9RmOfoe4xEwfZ3atGcfQ39UAp4dRz2rRFA@mail.gmail.com>
Content-Type: text/plain; charset="ISO-8859-1"
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On 2015/4/2 6:21, Yinghai Lu wrote:
> On Mon, Mar 30, 2015 at 11:38 PM, Yijing Wang <wangyijing@huawei.com> wrote:
>> On 2015/3/29 14:18, Yinghai Lu wrote:
>>> On Sat, Mar 28, 2015 at 3:02 AM, Yijing Wang <wangyijing@huawei.com> wrote:
>>>> ...
>>>>
>>>> I compared above log and found after we did remove and rescan, the bridge requested resource size extended to 0x06000000,
>>>> and when system boot up, it requested only 0x4800000.
>>>>
>>    I tested it, remove and rescan 05:19.0 device is ok now, but
>> if do the operations for the parent device of 05:19.0, the result is
>> still fail.
> 
> Found the problem, attached patch should fix the problem.


Hi Yinghai, sorry for the delay reply, this fix works, dmesg info:

...
[  181.567872] pci_bus 0000:06: busn_res: [bus 06-ff] end is updated to 12
[  181.567886] pci_bus 0000:05: busn_res: [bus 05-ff] end is updated to 12
[  181.567899] pci_bus 0000:04: busn_res: [bus 04-12] end is updated to 12
[  181.567928] pci_bus 0000:13: busn_res: [bus 13] end is updated to 13
[  181.568177] pci_bus 0000:16: busn_res: [bus 16] end is updated to 16
[  181.568233] pci_bus 0000:17: busn_res: [bus 17] end is updated to 17
[  181.568263] pci_bus 0000:18: busn_res: [bus 18-20] end is updated to 20
[  181.568274] pci_bus 0000:15: busn_res: [bus 15-20] end is updated to 20
[  181.568286] pci_bus 0000:14: busn_res: [bus 14-20] end is updated to 20
[  181.568313] pci_bus 0000:21: busn_res: [bus 21] end is updated to 21
[  181.568323] pci_bus 0000:03: busn_res: [bus 03-21] end is updated to 21
[  181.568333] pci_bus 0000:02: busn_res: [bus 02-21] end is updated to 21
[  181.568355] pci_bus 0000:22: busn_res: [bus 22] end is updated to 22
[  181.568545] pci_bus 0000:24: busn_res: [bus 24] end is updated to 24
[  181.568558] pci_bus 0000:23: busn_res: [bus 23-24] end is updated to 24
[  181.574379] pci 0000:04:00.0: BAR 14: assigned [mem 0xe4000000-0xe87fffff]
[  181.574390] pci 0000:05:19.0: BAR 14: assigned [mem 0xe4000000-0xe87fffff]
[  181.574398] pci 0000:06:00.0: BAR 2: assigned [mem 0xe4000000-0xe7ffffff 64bit]
[  181.574429] pci 0000:06:00.0: BAR 0: assigned [mem 0xe8000000-0xe87fffff]
[  181.574441] pci 0000:05:19.0: PCI bridge to [bus 06-12]
[  181.574456] pci 0000:05:19.0:   bridge window [mem 0xe4000000-0xe87fffff]
[  181.574482] pci 0000:04:00.0: PCI bridge to [bus 05-12]
[  181.574496] pci 0000:04:00.0:   bridge window [mem 0xe4000000-0xe87fffff]
[  181.574528] pci 0000:23:00.0: PCI bridge to [bus 24]
...

> 
> Thanks
> 
> Yinghai
> 


-- 
Thanks!
Yijing

