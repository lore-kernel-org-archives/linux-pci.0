Return-Path: <linux-kernel-owner@vger.kernel.org>
Message-ID: <1444407378.17726.2.camel@oracle.com>
Subject: Re: [PATCH v7 02/60] sparc/PCI: Use correct bus address to resource
 offset
From: Khalid Aziz <khalid.aziz@oracle.com>
Reply-To: khalid.aziz@oracle.com
To: Yinghai Lu <yinghai@kernel.org>
Cc: Bjorn Helgaas <bhelgaas@google.com>,
	David Miller <davem@davemloft.net>,
	Benjamin Herrenschmidt <benh@kernel.crashing.org>,
	Wei Yang <weiyang@linux.vnet.ibm.com>, TJ <linux@iam.tj>,
	Yijing Wang <wangyijing@huawei.com>, linux-pci@vger.kernel.org,
	linux-kernel@vger.kernel.org
Date: Fri, 09 Oct 2015 10:16:18 -0600
In-Reply-To: <1444340359-8011-3-git-send-email-yinghai@kernel.org>
References: <1444340359-8011-1-git-send-email-yinghai@kernel.org>
	 <1444340359-8011-3-git-send-email-yinghai@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Thu, 2015-10-08 at 14:38 -0700, Yinghai Lu wrote:
> After we add 64bit mmio parsing, we got some "no compatible bridge window"
> warning on anther new model that support 64bit resource.
> 
> It turns out that we can not use mem_space.start as 64bit mem space
> offset, aka mem_space.start != offset.
> 
> Use child_phys_addr to calculate exact offset and recorder offset in
> pbm.  Still assume all mem have same offset, otherwise panic early.
> 
> After patch we get correct offset.
> 
> /pci@305: PCI IO [io  0x2007e00000000-0x2007e0fffffff] offset 2007e00000000
> /pci@305: PCI MEM [mem 0x2000000100000-0x200007effffff] offset 2000000000000
> /pci@305: PCI MEM64 [mem 0x2000100000000-0x2000dffffffff] offset 2000000000000
> ...
> pci_sun4v f02ae7f8: PCI host bridge to bus 0000:00
> pci_bus 0000:00: root bus resource [io  0x2007e00000000-0x2007e0fffffff] (bus address [0x0000-0xfffffff])
> pci_bus 0000:00: root bus resource [mem 0x2000000100000-0x200007effffff] (bus address [0x00100000-0x7effffff])
> pci_bus 0000:00: root bus resource [mem 0x2000100000000-0x2000dffffffff] (bus address [0x100000000-0xdffffffff])
> 
> 
> -v2: to make is simple, do not add mem64_offset, and assume
>      mem64_offset == mem_offset, otherwise would make
>      pci_mmap_resource() path too complicated.
> 
> Signed-off-by: Yinghai Lu <yinghai@kernel.org>

Tested on sparc platforms

Tested-by: Khalid Aziz <khalid.aziz@oracle.com> 



