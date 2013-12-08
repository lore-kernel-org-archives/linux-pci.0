Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from smtp03.online.nl ([194.134.41.33]:39182 "EHLO smtp03.online.nl"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754753Ab3LHOdt (ORCPT <rfc822;linux-pci@vger.kernel.org>);
	Sun, 8 Dec 2013 09:33:49 -0500
Message-ID: <52A4819A.50501@meshcoding.com>
Date: Sun, 08 Dec 2013 15:26:34 +0100
From: Antonio Quartulli <antonio@meshcoding.com>
MIME-Version: 1.0
To: Joerg Roedel <joerg.roedel@amd.com>
CC: Bjorn Helgaas <bhelgaas@google.com>, linux-pci@vger.kernel.org,
	iommu@lists.linux-foundation.org
Subject: Re: warn_slowpath_common in drivers/pci/search.c:44 on linux-3.4.0
References: <20120526082551.GA2723@ritirata.org> <CAErSpo553_-AivRa7VbjHrFraHaO4NYoYR7A9Am5fkDP-CMvSA@mail.gmail.com> <20120529083552.GN2604@amd.com> <20120529085648.GA13941@ritirata.org>
In-Reply-To: <20120529085648.GA13941@ritirata.org>
Content-Type: text/plain; charset=UTF-8
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On 29/05/12 10:56, Antonio Quartulli wrote:
> On Tue, May 29, 2012 at 10:35:53 +0200, Joerg Roedel wrote:
>> Hi Antonio,
>>
>> On Sat, May 26, 2012 at 09:09:52AM -0600, Bjorn Helgaas wrote:
>>> On Sat, May 26, 2012 at 2:25 AM, Antonio Quartulli <ordex@autistici.org> wrote:
>>>> [    1.054279] WARNING: at drivers/pci/search.c:44 pci_find_upstream_pcie_bridge+0x5e/0x70()
>>>> [    1.054385] Hardware name: Latitude E5420
>>>> [    1.054457] Modules linked in:
>>>> [    1.054568] Pid: 1, comm: swapper/0 Not tainted 3.4.0ordex+ #3
>>>> [    1.054643] Call Trace:
>>>> [    1.054716]  [<ffffffff81033d4a>] warn_slowpath_common+0x7a/0xb0
>>>> [    1.054793]  [<ffffffff81033d95>] warn_slowpath_null+0x15/0x20
>>>> [    1.054869]  [<ffffffff8123899e>] pci_find_upstream_pcie_bridge+0x5e/0x70
>>>> [    1.054949]  [<ffffffff813babe7>] intel_iommu_device_group+0x77/0x100
>>>> [    1.055027]  [<ffffffff813b52d5>] add_iommu_group+0x35/0x60
>>>> [    1.055113]  [<ffffffff813b52a0>] ? bus_set_iommu+0x50/0x50
>>>> [    1.055191]  [<ffffffff8132c586>] bus_for_each_dev+0x56/0x90
>>>> [    1.055267]  [<ffffffff813b528b>] bus_set_iommu+0x3b/0x50
>>>> [    1.055344]  [<ffffffff818c4920>] intel_iommu_init+0xab0/0xb3f
>>>> [    1.055421]  [<ffffffff81120b26>] ? sys_mkdirat+0x76/0xd0
>>>> [    1.055499]  [<ffffffff8189b0db>] ? memblock_find_dma_reserve+0x13d/0x13d
>>>> [    1.055578]  [<ffffffff8189b0ee>] pci_iommu_init+0x13/0x3e
>>>> [    1.055655]  [<ffffffff810001ca>] do_one_initcall+0x3a/0x170
>>>> [    1.055732]  [<ffffffff81897c35>] kernel_init+0x148/0x1cc
>>>> [    1.055807]  [<ffffffff81897588>] ? do_early_param+0x86/0x86
>>>> [    1.055884]  [<ffffffff814fc914>] kernel_thread_helper+0x4/0x10
>>>> [    1.055963]  [<ffffffff8105de60>] ? finish_task_switch+0x80/0x110
>>>> [    1.056040]  [<ffffffff814fafdd>] ? retint_restore_args+0xe/0xe
>>>> [    1.056126]  [<ffffffff81897aed>] ? start_kernel+0x30b/0x30b
>>>> [    1.056203]  [<ffffffff814fc910>] ? gs_change+0xb/0xb
>>
>> Hmm, this looks like pci_find_upstream_pcie_bridge() found a PCIe device
>> in the chain which is not a bridge. Can you please post the output of
>> 'lspci -vvv' and 'lspci -t'?
>>
> 
> attached!
> Some days ago I tried to put some printk in the code and, as far as I can
> understand, you are right.
> 
> I hope my lspci output will help!
> 
> Cheers,
> 

Hi guys,

was there any progress about this?
Right now I am using linux-3.10.22 and the WARNING is still present.
The system seems to be working fine, but I don't know if this issue can
trigger side effects or not.


Cheers,

-- 
Antonio Quartulli
