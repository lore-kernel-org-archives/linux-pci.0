Return-Path: <linux-kernel-owner@vger.kernel.org>
Date: Sat, 31 Oct 2015 14:51:42 -0400 (EDT)
Message-Id: <20151031.145142.372881581221024297.davem@davemloft.net>
To: yinghai@kernel.org
Cc: khalid.aziz@oracle.com, bhelgaas@google.com,
	benh@kernel.crashing.org, weiyang@linux.vnet.ibm.com, linux@iam.tj,
	wangyijing@huawei.com, linux-pci@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v8 00/61] PCI: Resource allocation cleanup for v4.4
From: David Miller <davem@davemloft.net>
In-Reply-To: <CAE9FiQU5YkwFVuEiDOCT+BDrrSLGhTiDfW7GZV6qVtBRKDBpDw@mail.gmail.com>
References: <1445979353-1728-1-git-send-email-yinghai@kernel.org>
	<5633E570.6040906@oracle.com>
	<CAE9FiQU5YkwFVuEiDOCT+BDrrSLGhTiDfW7GZV6qVtBRKDBpDw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

From: Yinghai Lu <yinghai@kernel.org>
Date: Fri, 30 Oct 2015 18:53:23 -0700

> On Fri, Oct 30, 2015 at 2:47 PM, Khalid Aziz <khalid.aziz@oracle.com> wrote:
>>
>> I applied patches 1-8 and 11-16 to 4.3.0-rc7 to test on sparc platforms. I
>> am seeing a "can't claim BAR" message on a T4:
>>
>> pci 0000:04:00.0: can't claim BAR 6 [mem 0x84000000000-0x8400000ffff]:
>> address conflict with 0000:04:00.0 [mem 0x84000000000-0x840007fffff]
> 
> PCI: scan_bus[/pci@400/pci@1/pci@0/pci@0/pci@0] bus no 4
>   * /pci@400/pci@1/pci@0/pci@0/pci@0/display@0
>     create device, devfn: 0, type: display
>     class: 0x30000 device name: 0000:04:00.0
>     parse addresses (80 bytes) @ fff8001fffe34f40
>   start: 84000000000, end: 840007fffff, i: 10
>   start: 84000800000, end: 8400081ffff, i: 14
>   start: 85100000000, end: 8510000007f, i: 18
>   start: 84000000000, end: 8400000ffff, i: 30
> 
> so the BAR 6 the ROM bar is overlapping with BAR0.
> and the ROM bar get rejected.

This is the way OF seems to work.

It maps all of the ROMs essentially to the same address range, but
only enables one at a time as it inspects the ROMs and builds the
device tree during power-on.

Then it makes sure all of them are disabled, and can therefore use
some of that address range for mapping other BARs.

So if ROMs are disabled, you cannot put the address of such ROMs BAR
in the kernel's assigned PCI address resource list.

I hope that is what you are doing?
