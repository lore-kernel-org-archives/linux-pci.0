Return-Path: <linux-kernel-owner@vger.kernel.org>
Date: Thu, 10 Mar 2016 14:47:47 -0500 (EST)
Message-Id: <20160310.144747.2251623069186657973.davem@davemloft.net>
To: helgaas@kernel.org
Cc: yinghai@kernel.org, bhelgaas@google.com, benh@kernel.crashing.org,
	weiyang@linux.vnet.ibm.com, linux@iam.tj, wangyijing@huawei.com,
	khalid.aziz@oracle.com, linux-pci@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v10 02/59] sparc/PCI: Use correct bus address to
 resource offset
From: David Miller <davem@davemloft.net>
In-Reply-To: <20160310182440.GC14873@localhost>
References: <1456366370-28995-1-git-send-email-yinghai@kernel.org>
	<1456366370-28995-3-git-send-email-yinghai@kernel.org>
	<20160310182440.GC14873@localhost>
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

From: Bjorn Helgaas <helgaas@kernel.org>
Date: Thu, 10 Mar 2016 12:24:40 -0600

> Hi Yinghai,
> 
> On Wed, Feb 24, 2016 at 06:11:53PM -0800, Yinghai Lu wrote:
>> After we add 64bit mmio parsing, we got some "no compatible bridge window"
>> warning on anther new model that support 64bit resource.
>> 
>> It turns out that we can not use mem_space.start as 64bit mem space
>> offset, aka there is mem_space.start != offset.
>> 
>> Use child_phys_addr to calculate exact offset and record offset in
>> pbm.
>> 
>> After patch we get correct offset.
>> 
>> /pci@305: PCI IO [io  0x2007e00000000-0x2007e0fffffff] offset 2007e00000000
>> /pci@305: PCI MEM [mem 0x2000000100000-0x200007effffff] offset 2000000000000
>> /pci@305: PCI MEM64 [mem 0x2000100000000-0x2000dffffffff] offset 2000000000000
>> ...
>> pci_sun4v f02ae7f8: PCI host bridge to bus 0000:00
>> pci_bus 0000:00: root bus resource [io  0x2007e00000000-0x2007e0fffffff] (bus address [0x0000-0xfffffff])
> 
> Just double-checking that your ioport space really contains 256M ports.
> It's fine if it does; it's just a little unusual.

It should be 16MB, but we trust the OF properties in the 'pci' device
node to determine these ranges and the above must be what it is
advertising there.
