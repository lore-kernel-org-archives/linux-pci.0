Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from szxga02-in.huawei.com ([119.145.14.65]:40399 "EHLO
	szxga02-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751091AbcCYGuB (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Fri, 25 Mar 2016 02:50:01 -0400
Subject: Re: Question about PCI I/O space in ARM64
To: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
References: <56F209A9.4040304@huawei.com>
 <20160323101840.GA21390@e104818-lin.cambridge.arm.com>
 <8793380.nuVa09lFue@wuerfel> <56F35BAA.50800@huawei.com>
 <20160324175728.GC21749@red-moon>
CC: Arnd Bergmann <arnd@arndb.de>,
	Catalin Marinas <catalin.marinas@arm.com>,
	<linux-pci@vger.kernel.org>,
	linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
	Gabriele Paoloni <gabriele.paoloni@huawei.com>,
	Linuxarm <linuxarm@huawei.com>, <linux-kernel@vger.kernel.org>,
	Zhou Wang <wangzhou1@hisilicon.com>, <jdelvare@suse.de>,
	"xuwei (O)" <xuwei5@hisilicon.com>
From: Kefeng Wang <wangkefeng.wang@huawei.com>
Message-ID: <56F4DF80.5070707@huawei.com>
Date: Fri, 25 Mar 2016 14:49:36 +0800
MIME-Version: 1.0
In-Reply-To: <20160324175728.GC21749@red-moon>
Content-Type: text/plain; charset="windows-1252"
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>



On 2016/3/25 1:57, Lorenzo Pieralisi wrote:
> [+ Jean]
> 
> On Thu, Mar 24, 2016 at 11:14:50AM +0800, Kefeng Wang wrote:
> 
> [...]
> 
>>>> You need a PCI host controller driver (e.g.
>>>> drivers/pci/host/pci-host-generic.c) and corresponding bindings in DT or
>>>> ACPI.
>>
>> In our inner test, there are some board without pcie host driver(even
>> without pci host controller).
> 
> So I guess those drivers are for devices that are attached to an LPC
> controller that is not part of a PCI host controller, right ?
> 
> BTW, what happened to this (not that I particularly like this patchset) ?

They are working on it, and will upstream again.

> 
> https://lkml.org/lkml/2015/12/29/154
> 
[...]
> 
> I agree with Arnd on this and we need to patch the eg f71805f driver too
> (or we just do not build on ARM) to make it request the IO port region it
> needs to actually probe the device, it is not correct to assume IO space
> is available and mapped, I think that's a driver bug rather than anything
> else, Jean can certainly shed some light here.

Ok, so Jean, would you take a look this? Thanks.

Kefeng
> 
>> Define some arch in/out func instead of generic ops? when in/out vals, check
>> whether or not the pci_iobase is mapped.
> 
> I do not think the problem should be solved in the IO accessors
> implementation, see above.
> 
> Lorenzo
> 
> .
> 

