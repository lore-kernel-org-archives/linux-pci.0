Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from eu1sys200aog107.obsmtp.com ([207.126.144.123]:60810 "EHLO
	eu1sys200aog107.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1750999AbaANH5g (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Tue, 14 Jan 2014 02:57:36 -0500
Message-ID: <52D4ED5D.80105@mellanox.com>
Date: Tue, 14 Jan 2014 09:55:09 +0200
From: Or Gerlitz <ogerlitz@mellanox.com>
MIME-Version: 1.0
To: Wei Yang <weiyang@linux.vnet.ibm.com>, <linux-pci@vger.kernel.org>,
	<yinghai@kernel.org>, <bhelgaas@google.com>, <amirv@mellanox.com>,
	<jackm@dev.mellanox.co.il>, <eugenia@mellanox.com>,
	Guo Chao <yan@linux.vnet.ibm.com>
CC: Gavin Shan <shangw@linux.vnet.ibm.com>,
	Benjamin Herrenschmidt <benh@au1.ibm.com>
Subject: Re: mlx4_core probe error after applying Yinghai's patch
References: <20140114062215.GA19345@richard>
In-Reply-To: <20140114062215.GA19345@richard>
Content-Type: text/plain; charset="ISO-8859-1"; format=flowed
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On 14/01/2014 08:22, Wei Yang wrote:
> All,
>
> I am testing Yinghai's patch based on 3.13-rc1, after applying these four
> patches, there is an error during probe for mlx4_core.
>
> Code base we did the test:
>    $ git oneline -5
>    298a335 PCI: Try best to allocate pref mmio 64bit above 4g
>    b730e81 PCI: Try to allocate mem64 above 4G at first
>    4e27325 PCI: Don't use 4G bus address directly in resource allocation
>    ab6c20f PCI: pcibus address to resource converting take bus instead of dev
>    6ce4eac Linux 3.13-rc1
>    
> Error log:
>    mlx4_core 0003:05:00.0: Multiple PFs not yet supported.  Skipping PF.
>    mlx4_core: probe of 0003:05:00.0 failed with error -22
>
> My analysis:
>    After careful investigation, I guess this error is not introduced by
>    Yinghai's patch. This looks more like an error from device itself. Since
>    this error really happens after applying Yinghai's patch(especially the last
>    one 298a335), I would like to include Yinghai in this loop.

Sorry, can you provide pointers please? I don't see 298a335 on Linus 
3.13-rc8+ tree nor in net-next,

$ git log --oneline --author=Yinghai v3.12..
e7cc5cf PCI: Remove duplicate pci_disable_device() from 
pcie_portdrv_remove()
cf3e1fe PCI: Workaround missing pci_set_master in pci drivers
bee7f9c ACPI / x86: Increase override tables number limit
6979287 x86/mm: Add 'step_size' comments to init_mem_mapping()

So  are you referring to patches on the PCI development tree
git://git.kernel.org/pub/scm/linux/kernel/git/helgaas/pci.git "next" 
branch? which

Or.
