Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from aserp1040.oracle.com ([141.146.126.69]:48565 "EHLO
	aserp1040.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932217AbbJIQTk (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Fri, 9 Oct 2015 12:19:40 -0400
Message-ID: <1444407541.17726.5.camel@oracle.com>
Subject: Re: [PATCH v7 04/60] sparc/PCI: Reserve legacy mmio after PCI mmio
From: Khalid Aziz <khalid.aziz@oracle.com>
To: Yinghai Lu <yinghai@kernel.org>
Cc: Bjorn Helgaas <bhelgaas@google.com>,
	David Miller <davem@davemloft.net>,
	Benjamin Herrenschmidt <benh@kernel.crashing.org>,
	Wei Yang <weiyang@linux.vnet.ibm.com>, TJ <linux@iam.tj>,
	Yijing Wang <wangyijing@huawei.com>, linux-pci@vger.kernel.org,
	linux-kernel@vger.kernel.org
Date: Fri, 09 Oct 2015 10:19:01 -0600
In-Reply-To: <1444340359-8011-5-git-send-email-yinghai@kernel.org>
References: <1444340359-8011-1-git-send-email-yinghai@kernel.org>
	 <1444340359-8011-5-git-send-email-yinghai@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Thu, 2015-10-08 at 14:38 -0700, Yinghai Lu wrote:
> On one system found bunch of claim resource fail from pci device.
> pci_sun4v f02b894c: PCI host bridge to bus 0000:00
> pci_bus 0000:00: root bus resource [io  0x2007e00000000-0x2007e0fffffff] (bus address [0x0000-0xfffffff])
> pci_bus 0000:00: root bus resource [mem 0x2000000000000-0x200007effffff] (bus address [0x00000000-0x7effffff])
> pci_bus 0000:00: root bus resource [mem 0x2000100000000-0x20007ffffffff] (bus address [0x100000000-0x7ffffffff])
> ...
> PCI: Claiming 0000:00:02.0: Resource 14: 0002000000000000..00020000004fffff [200]
> pci 0000:00:02.0: can't claim BAR 14 [mem 0x2000000000000-0x20000004fffff]: address conflict with Video RAM area [??? 0x20000000a0000-0x20000000bffff flags 0x80000000]
> pci 0000:02:00.0: can't claim BAR 0 [mem 0x2000000000000-0x20000000fffff]: no compatible bridge window
> PCI: Claiming 0000:02:00.0: Resource 3: 0002000000100000..0002000000103fff [200]
> pci 0000:02:00.0: can't claim BAR 3 [mem 0x2000000100000-0x2000000103fff]: no compatible bridge window
> PCI: Claiming 0000:02:00.1: Resource 0: 0002000000200000..00020000002fffff [200]
> pci 0000:02:00.1: can't claim BAR 0 [mem 0x2000000200000-0x20000002fffff]: no compatible bridge window
> PCI: Claiming 0000:02:00.1: Resource 3: 0002000000104000..0002000000107fff [200]
> pci 0000:02:00.1: can't claim BAR 3 [mem 0x2000000104000-0x2000000107fff]: no compatible bridge window
> PCI: Claiming 0000:02:00.2: Resource 0: 0002000000300000..00020000003fffff [200]
> pci 0000:02:00.2: can't claim BAR 0 [mem 0x2000000300000-0x20000003fffff]: no compatible bridge window
> PCI: Claiming 0000:02:00.2: Resource 3: 0002000000108000..000200000010bfff [200]
> pci 0000:02:00.2: can't claim BAR 3 [mem 0x2000000108000-0x200000010bfff]: no compatible bridge window
> PCI: Claiming 0000:02:00.3: Resource 0: 0002000000400000..00020000004fffff [200]
> pci 0000:02:00.3: can't claim BAR 0 [mem 0x2000000400000-0x20000004fffff]: no compatible bridge window
> PCI: Claiming 0000:02:00.3: Resource 3: 000200000010c000..000200000010ffff [200]
> pci 0000:02:00.3: can't claim BAR 3 [mem 0x200000010c000-0x200000010ffff]: no compatible bridge window
> 
> The bridge 00:02.0 resource does not get reserved as Video RAM take the position early,
> and following children all failed.
> 
> Move down Video RAM area reservation after pci mmio get reserved,
> so we leave pci driver to use those regions.
> 
> Signed-off-by: Yinghai Lu <yinghai@kernel.org>

Tested on sparc platforms

Tested-by: Khalid Aziz <khalid.aziz@oracle.com> 



