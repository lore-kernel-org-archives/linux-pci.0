Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from e28smtp08.in.ibm.com ([122.248.162.8]:49728 "EHLO
	e28smtp08.in.ibm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750962AbaANI16 (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Tue, 14 Jan 2014 03:27:58 -0500
Received: from /spool/local
	by e28smtp08.in.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
	for <linux-pci@vger.kernel.org> from <weiyang@linux.vnet.ibm.com>;
	Tue, 14 Jan 2014 13:57:56 +0530
Received: from d28relay04.in.ibm.com (d28relay04.in.ibm.com [9.184.220.61])
	by d28dlp01.in.ibm.com (Postfix) with ESMTP id 7E168E0057
	for <linux-pci@vger.kernel.org>; Tue, 14 Jan 2014 14:00:44 +0530 (IST)
Received: from d28av02.in.ibm.com (d28av02.in.ibm.com [9.184.220.64])
	by d28relay04.in.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id s0E8RoYk51708126
	for <linux-pci@vger.kernel.org>; Tue, 14 Jan 2014 13:57:50 +0530
Received: from d28av02.in.ibm.com (localhost [127.0.0.1])
	by d28av02.in.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id s0E8RphZ027386
	for <linux-pci@vger.kernel.org>; Tue, 14 Jan 2014 13:57:52 +0530
Date: Tue, 14 Jan 2014 16:27:49 +0800
From: Wei Yang <weiyang@linux.vnet.ibm.com>
To: Or Gerlitz <ogerlitz@mellanox.com>
Cc: Wei Yang <weiyang@linux.vnet.ibm.com>, linux-pci@vger.kernel.org,
	yinghai@kernel.org, bhelgaas@google.com, amirv@mellanox.com,
	jackm@dev.mellanox.co.il, eugenia@mellanox.com,
	Guo Chao <yan@linux.vnet.ibm.com>,
	Gavin Shan <shangw@linux.vnet.ibm.com>,
	Benjamin Herrenschmidt <benh@au1.ibm.com>
Subject: Re: mlx4_core probe error after applying Yinghai's patch
Message-ID: <20140114082749.GA21105@richard>
Reply-To: Wei Yang <weiyang@linux.vnet.ibm.com>
References: <20140114062215.GA19345@richard>
 <52D4ED5D.80105@mellanox.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <52D4ED5D.80105@mellanox.com>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Tue, Jan 14, 2014 at 09:55:09AM +0200, Or Gerlitz wrote:
>On 14/01/2014 08:22, Wei Yang wrote:
>>All,
>>
>>I am testing Yinghai's patch based on 3.13-rc1, after applying these four
>>patches, there is an error during probe for mlx4_core.
>>
>>Code base we did the test:
>>   $ git oneline -5
>>   298a335 PCI: Try best to allocate pref mmio 64bit above 4g
>>   b730e81 PCI: Try to allocate mem64 above 4G at first
>>   4e27325 PCI: Don't use 4G bus address directly in resource allocation
>>   ab6c20f PCI: pcibus address to resource converting take bus instead of dev
>>   6ce4eac Linux 3.13-rc1
>>Error log:
>>   mlx4_core 0003:05:00.0: Multiple PFs not yet supported.  Skipping PF.
>>   mlx4_core: probe of 0003:05:00.0 failed with error -22
>>
>>My analysis:
>>   After careful investigation, I guess this error is not introduced by
>>   Yinghai's patch. This looks more like an error from device itself. Since
>>   this error really happens after applying Yinghai's patch(especially the last
>>   one 298a335), I would like to include Yinghai in this loop.
>
>Sorry, can you provide pointers please? I don't see 298a335 on Linus
>3.13-rc8+ tree nor in net-next,
>
>$ git log --oneline --author=Yinghai v3.12..
>e7cc5cf PCI: Remove duplicate pci_disable_device() from
>pcie_portdrv_remove()
>cf3e1fe PCI: Workaround missing pci_set_master in pci drivers
>bee7f9c ACPI / x86: Increase override tables number limit
>6979287 x86/mm: Add 'step_size' comments to init_mem_mapping()
>

Or

Thanks for your reply. The SHA index in only on my system, since as I know the
last patch is not in upstream yet.

You can find the first three patches here:
https://git.kernel.org/cgit/linux/kernel/git/helgaas/pci.git/ pci/resource

And the last one is here:
https://lkml.org/lkml/2013/12/19/701

BTW, this card is flushed with FW built in IBM.

Yinghai,

If these are not the latest one, please let us know.

And 

>So  are you referring to patches on the PCI development tree
>git://git.kernel.org/pub/scm/linux/kernel/git/helgaas/pci.git "next"
>branch? which
>
>Or.

-- 
Richard Yang
Help you, Help me

