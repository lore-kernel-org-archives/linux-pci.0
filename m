Return-Path: <SRS0=hqs4=PW=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3B50AC43387
	for <linux-pci@archiver.kernel.org>; Mon, 14 Jan 2019 13:13:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D4CCE20659
	for <linux-pci@archiver.kernel.org>; Mon, 14 Jan 2019 13:13:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726554AbfANNN5 (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Mon, 14 Jan 2019 08:13:57 -0500
Received: from szxga04-in.huawei.com ([45.249.212.190]:17112 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726533AbfANNN5 (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Mon, 14 Jan 2019 08:13:57 -0500
Received: from DGGEMS402-HUB.china.huawei.com (unknown [172.30.72.60])
        by Forcepoint Email with ESMTP id 84B8A3A3818B6C8A6679;
        Mon, 14 Jan 2019 21:13:49 +0800 (CST)
Received: from [127.0.0.1] (10.202.226.43) by DGGEMS402-HUB.china.huawei.com
 (10.3.19.202) with Microsoft SMTP Server id 14.3.408.0; Mon, 14 Jan 2019
 21:13:38 +0800
Subject: Re: [PATCH V2 0/3] nvme pci: two fixes on nvme_setup_irqs
To:     Ming Lei <ming.lei@redhat.com>, <linux-nvme@lists.infradead.org>,
        Christoph Hellwig <hch@lst.de>
References: <20181229032650.27256-1-ming.lei@redhat.com>
CC:     Shan Hai <shan.hai@oracle.com>,
        Keith Busch <keith.busch@intel.com>,
        "Jens Axboe" <axboe@fb.com>, <linux-pci@vger.kernel.org>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Linuxarm <linuxarm@huawei.com>
From:   John Garry <john.garry@huawei.com>
Message-ID: <16226105-49f2-8349-7a71-4b0f37d05e6a@huawei.com>
Date:   Mon, 14 Jan 2019 13:13:32 +0000
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:45.0) Gecko/20100101
 Thunderbird/45.3.0
MIME-Version: 1.0
In-Reply-To: <20181229032650.27256-1-ming.lei@redhat.com>
Content-Type: text/plain; charset="windows-1252"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.202.226.43]
X-CFilter-Loop: Reflected
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On 29/12/2018 03:26, Ming Lei wrote:
> Hi,
>
> The 1st one fixes the case that -EINVAL is returned from pci_alloc_irq_vectors_affinity(),
> and it is found without this patch QEMU may fallback to single queue if CPU cores is >= 64.
>
> The 2st one fixes the case that -ENOSPC is returned from pci_alloc_irq_vectors_affinity(),
> and boot failure is observed on aarch64 system with less irq vectors.
>
> The last one introduces modules parameter of 'default_queues' for addressing irq vector
> exhaustion issue reported by Shan Hai.
>
> Ming Lei (3):
>   PCI/MSI: preference to returning -ENOSPC from
>     pci_alloc_irq_vectors_affinity
>   nvme pci: fix nvme_setup_irqs()
>   nvme pci: introduce module parameter of 'default_queues'
>
>  drivers/nvme/host/pci.c | 31 ++++++++++++++++++++++---------
>  drivers/pci/msi.c       | 20 +++++++++++---------
>  2 files changed, 33 insertions(+), 18 deletions(-)
>
> Cc: Shan Hai <shan.hai@oracle.com>
> Cc: Keith Busch <keith.busch@intel.com>
> Cc: Jens Axboe <axboe@fb.com>
> Cc: linux-pci@vger.kernel.org,
> Cc: Bjorn Helgaas <bhelgaas@google.com>,
>

Hi Ming,

Will this series fix this warning I see in 5.0-rc1/2 on my arm64 system:

[   19.688158] WARNING: CPU: 50 PID: 256 at drivers/pci/msi.c:1269 
pci_irq_get_affinity+0x3c/0x90
[   19.701397] Modules linked in:
[   19.704442] CPU: 50 PID: 256 Comm: kworker/u131:0 Not tainted 
5.0.0-rc2-dirty #1027
[   19.712084] Hardware name: Huawei D06/D06, BIOS Hisilicon D06 UEFI 
RC0 - B601 (V6.01) 11/08/2018
[   19.719625] iommu: Adding device 0000:7d:00.1 to group 4
[   19.720860] Workqueue: nvme-reset-wq nvme_reset_work
[   19.720865] pstate: 60c00009 (nZCv daif +PAN +UAO)
[   19.726921] hns3 0000:7d:00.1: The firmware version is b0311019
[   19.731116] pc : pci_irq_get_affinity+0x3c/0x90
[   19.731121] lr : blk_mq_pci_map_queues+0x44/0xf0
[   19.731122] sp : ffff000012c33b90
[   19.731126] x29: ffff000012c33b90 x28: 0000000000000000
[   19.746325] x27: 0000000000000000 x26: ffff000010f2ccf8
[   19.746330] x25: ffff8a23d9de0008 x24: ffff0000111fd000
[   19.774813] x23: ffff8a23e9232000 x22: 0000000000000001
[   19.780113] x21: ffff0000111fda84 x20: ffff8a23d9ee9280
[   19.790713] x19: 0000000000000017 x18: ffffffffffffffff
[   19.790716] x17: 0000000000000001 x16: 0000000000000019
[   19.790717] x15: ffff0000111fd6c8 x14: ffff000092c33907
[   19.790721] x13: ffff000012c33915 x12: ffff000011215000
[   19.801926] x11: 0000000005f5e0ff x10: ffff7e288f66bc80
[   19.801929] x9 : 0000000000000000 x8 : ffff8a23d9af2100
[   19.812530] x7 : 0000000000000000 x6 : 000000000000003f
[   19.812533] x5 : 0000000000000040 x4 : 3000000000000000
[   19.827474] x3 : 0000000000000018 x2 : ffff8a23e92322c0
[   19.837466] x1 : 0000000000000018 x0 : ffff8a23e92322c0
[   19.837469] Call trace:
[   19.837472]  pci_irq_get_affinity+0x3c/0x90
[   19.837476]  nvme_pci_map_queues+0x90/0xe0
[   19.848074]  blk_mq_update_queue_map+0xbc/0xd8
[   19.848078]  blk_mq_alloc_tag_set+0x1d8/0x338
[   19.858675]  nvme_reset_work+0x1030/0x13f0
[   19.858682]  process_one_work+0x1e0/0x318
[   19.858687]  worker_thread+0x228/0x450
[   19.872323]  kthread+0x128/0x130

I can't see much on lists about this issue. Full log at bottom.

Thanks,
John



[    0.000000] Booting Linux on physical CPU 0x0000010000 [0x480fd010]
[    0.000000] Linux version 5.0.0-rc2-dirty 
(johnpgarry@johnpgarry-ThinkCentre-M93p) (gcc version 7.3.1 20180425 
[linaro-7.3-2018.05-rc1 revision 
38aec9a676236eaa42ca03ccb3a6c1dd0182c29f] (Linaro GCC 7.3-2018.05-rc1)) 
#1027 SMP PREEMPT Mon Jan 14 12:46:02 GMT 2019
[    0.000000] efi: Getting EFI parameters from FDT:
[    0.000000] efi: EFI v2.70 by EDK II
[    0.000000] efi:  SMBIOS 3.0=0x3f2a0000  ACPI 2.0=0x3a000000 
MEMATTR=0x3b845018  ESRT=0x3e5cce18  MEMRESERVE=0x3a2b1e98
[    0.000000] esrt: Reserving ESRT space from 0x000000003e5cce18 to 
0x000000003e5cce50.
[    0.000000] crashkernel reserved: 0x0000000002000000 - 
0x0000000012000000 (256 MB)
[    0.000000] cma: Reserved 32 MiB at 0x000000003c400000
[    0.000000] ACPI: Early table checksum verification disabled
[    0.000000] ACPI: RSDP 0x000000003A000000 000024 (v02 HISI  )
[    0.000000] ACPI: XSDT 0x0000000039FF0000 00009C (v01 HISI   HIP08 
00000000      01000013)
[    0.000000] ACPI: FACP 0x0000000039AD0000 000114 (v06 HISI   HIP08 
00000000 HISI 20151124)
[    0.000000] ACPI: DSDT 0x0000000039A50000 00618A (v02 HISI   HIP08 
00000000 INTL 20170929)
[    0.000000] ACPI: BERT 0x0000000039F50000 000030 (v01 HISI   HIP08 
00000000 HISI 20151124)
[    0.000000] ACPI: HEST 0x0000000039F40000 00013C (v01 HISI   HIP08 
00000000 HISI 20151124)
[    0.000000] ACPI: ERST 0x0000000039F20000 000230 (v01 HISI   HIP08 
00000000 HISI 20151124)
[    0.000000] ACPI: EINJ 0x0000000039F10000 000170 (v01 HISI   HIP08 
00000000 HISI 20151124)
[    0.000000] ACPI: GTDT 0x0000000039AC0000 000060 (v02 HISI   HIP08 
00000000 HISI 20151124)
[    0.000000] ACPI: DBG2 0x0000000039AB0000 00005A (v00 HISI   HIP08 
00000000 HISI 20151124)
[    0.000000] ACPI: MCFG 0x0000000039AA0000 00003C (v01 HISI   HIP08 
00000000 HISI 20151124)
[    0.000000] ACPI: SLIT 0x0000000039A90000 00003C (v01 HISI   HIP08 
00000000 HISI 20151124)
[    0.000000] ACPI: SRAT 0x0000000039A70000 000774 (v03 HISI   HIP08 
00000000 HISI 20151124)
[    0.000000] ACPI: APIC 0x0000000039A60000 001E58 (v04 HISI   HIP08 
00000000 HISI 20151124)
[    0.000000] ACPI: IORT 0x0000000039A40000 0010F4 (v00 HISI   HIP08 
00000000 INTL 20170929)
[    0.000000] ACPI: PPTT 0x0000000031870000 002A30 (v01 HISI   HIP08 
00000000 HISI 20151124)
[    0.000000] ACPI: SPMI 0x0000000031860000 000041 (v05 HISI   HIP08 
00000000 HISI 20151124)
[    0.000000] ACPI: iBFT 0x0000000039A80000 000800 (v01 HISI   HIP08 
00000000      00000000)
[    0.000000] ACPI: SRAT: Node 0 PXM 0 [mem 0x2080000000-0x23ffffffff]
[    0.000000] ACPI: SRAT: Node 0 PXM 0 [mem 0x00000000-0x7fffffff]
[    0.000000] ACPI: SRAT: Node 3 PXM 3 [mem 0xa2000000000-0xa23ffffffff]
[    0.000000] NUMA: NODE_DATA [mem 0x23ffffe840-0x23ffffffff]
[    0.000000] NUMA: Initmem setup node 1 [<memory-less node>]
[    0.000000] NUMA: NODE_DATA [mem 0xa23fc1e1840-0xa23fc1e2fff]
[    0.000000] NUMA: NODE_DATA(1) on node 3
[    0.000000] NUMA: Initmem setup node 2 [<memory-less node>]
[    0.000000] NUMA: NODE_DATA [mem 0xa23fc1e0080-0xa23fc1e183f]
[    0.000000] NUMA: NODE_DATA(2) on node 3
[    0.000000] NUMA: NODE_DATA [mem 0xa23fc1de8c0-0xa23fc1e007f]
[    0.000000] Zone ranges:
[    0.000000]   DMA32    [mem 0x0000000000000000-0x00000000ffffffff]
[    0.000000]   Normal   [mem 0x0000000100000000-0x00000a23ffffffff]
[    0.000000] Movable zone start for each node
[    0.000000] Early memory node ranges
[    0.000000]   node   0: [mem 0x0000000000000000-0x00000000312a2fff]
[    0.000000]   node   0: [mem 0x00000000312a3000-0x000000003185ffff]
[    0.000000]   node   0: [mem 0x0000000031860000-0x0000000039adffff]
[    0.000000]   node   0: [mem 0x0000000039ae0000-0x0000000039aeffff]
[    0.000000]   node   0: [mem 0x0000000039af0000-0x0000000039afffff]
[    0.000000]   node   0: [mem 0x0000000039b00000-0x0000000039cdffff]
[    0.000000]   node   0: [mem 0x0000000039ce0000-0x0000000039d0ffff]
[    0.000000]   node   0: [mem 0x0000000039d10000-0x0000000039e4ffff]
[    0.000000]   node   0: [mem 0x0000000039e50000-0x0000000039f39fff]
[    0.000000]   node   0: [mem 0x0000000039f3a000-0x0000000039f3ffff]
[    0.000000]   node   0: [mem 0x0000000039f40000-0x0000000039f5ffff]
[    0.000000]   node   0: [mem 0x0000000039f60000-0x0000000039feffff]
[    0.000000]   node   0: [mem 0x0000000039ff0000-0x000000003a00ffff]
[    0.000000]   node   0: [mem 0x000000003a010000-0x000000003a2affff]
[    0.000000]   node   0: [mem 0x000000003a2b0000-0x000000003a2b1fff]
[    0.000000]   node   0: [mem 0x000000003a2b2000-0x000000003a2bbfff]
[    0.000000]   node   0: [mem 0x000000003a2bc000-0x000000003f29ffff]
[    0.000000]   node   0: [mem 0x000000003f2a0000-0x000000003f2cffff]
[    0.000000]   node   0: [mem 0x000000003f2d0000-0x000000003fbfffff]
[    0.000000]   node   0: [mem 0x0000002080000000-0x00000023ffffffff]
[    0.000000]   node   3: [mem 0x00000a2000000000-0x00000a23ffffffff]
[    0.000000] Zeroed struct page in unavailable ranges: 1165 pages
[    0.000000] Initmem setup node 0 [mem 
0x0000000000000000-0x00000023ffffffff]
[    0.000000] On node 0 totalpages: 3931136
[    0.000000]   DMA32 zone: 4080 pages used for memmap
[    0.000000]   DMA32 zone: 0 pages reserved
[    0.000000]   DMA32 zone: 261120 pages, LIFO batch:63
[    0.000000]   Normal zone: 57344 pages used for memmap
[    0.000000]   Normal zone: 3670016 pages, LIFO batch:63
[    0.000000] Could not find start_pfn for node 1
[    0.000000] Initmem setup node 1 [mem 
0x0000000000000000-0x0000000000000000]
[    0.000000] On node 1 totalpages: 0
[    0.000000] Could not find start_pfn for node 2
[    0.000000] Initmem setup node 2 [mem 
0x0000000000000000-0x0000000000000000]
[    0.000000] On node 2 totalpages: 0
[    0.000000] Initmem setup node 3 [mem 
0x00000a2000000000-0x00000a23ffffffff]
[    0.000000] On node 3 totalpages: 4194304
[    0.000000]   Normal zone: 65536 pages used for memmap
[    0.000000]   Normal zone: 4194304 pages, LIFO batch:63
[    0.000000] psci: probing for conduit method from ACPI.
[    0.000000] psci: PSCIv1.1 detected in firmware.
[    0.000000] psci: Using standard PSCI v0.2 function IDs
[    0.000000] psci: MIGRATE_INFO_TYPE not supported.
[    0.000000] psci: SMC Calling Convention v1.1
[    0.000000] ACPI: NUMA: SRAT: PXM 0 -> MPIDR 0x10000 -> Node 0
[    0.000000] ACPI: NUMA: SRAT: PXM 0 -> MPIDR 0x10001 -> Node 0
[    0.000000] ACPI: NUMA: SRAT: PXM 0 -> MPIDR 0x10002 -> Node 0
[    0.000000] ACPI: NUMA: SRAT: PXM 0 -> MPIDR 0x10003 -> Node 0
[    0.000000] ACPI: NUMA: SRAT: PXM 0 -> MPIDR 0x10100 -> Node 0
[    0.000000] ACPI: NUMA: SRAT: PXM 0 -> MPIDR 0x10101 -> Node 0
[    0.000000] ACPI: NUMA: SRAT: PXM 0 -> MPIDR 0x10102 -> Node 0
[    0.000000] ACPI: NUMA: SRAT: PXM 0 -> MPIDR 0x10103 -> Node 0
[    0.000000] ACPI: NUMA: SRAT: PXM 0 -> MPIDR 0x10200 -> Node 0
[    0.000000] ACPI: NUMA: SRAT: PXM 0 -> MPIDR 0x10201 -> Node 0
[    0.000000] ACPI: NUMA: SRAT: PXM 0 -> MPIDR 0x10202 -> Node 0
[    0.000000] ACPI: NUMA: SRAT: PXM 0 -> MPIDR 0x10203 -> Node 0
[    0.000000] ACPI: NUMA: SRAT: PXM 0 -> MPIDR 0x10300 -> Node 0
[    0.000000] ACPI: NUMA: SRAT: PXM 0 -> MPIDR 0x10301 -> Node 0
[    0.000000] ACPI: NUMA: SRAT: PXM 0 -> MPIDR 0x10302 -> Node 0
[    0.000000] ACPI: NUMA: SRAT: PXM 0 -> MPIDR 0x10303 -> Node 0
[    0.000000] ACPI: NUMA: SRAT: PXM 0 -> MPIDR 0x10400 -> Node 0
[    0.000000] ACPI: NUMA: SRAT: PXM 0 -> MPIDR 0x10401 -> Node 0
[    0.000000] ACPI: NUMA: SRAT: PXM 0 -> MPIDR 0x10402 -> Node 0
[    0.000000] ACPI: NUMA: SRAT: PXM 0 -> MPIDR 0x10403 -> Node 0
[    0.000000] ACPI: NUMA: SRAT: PXM 0 -> MPIDR 0x10500 -> Node 0
[    0.000000] ACPI: NUMA: SRAT: PXM 0 -> MPIDR 0x10501 -> Node 0
[    0.000000] ACPI: NUMA: SRAT: PXM 0 -> MPIDR 0x10502 -> Node 0
[    0.000000] ACPI: NUMA: SRAT: PXM 0 -> MPIDR 0x10503 -> Node 0
[    0.000000] ACPI: NUMA: SRAT: PXM 1 -> MPIDR 0x30000 -> Node 1
[    0.000000] ACPI: NUMA: SRAT: PXM 1 -> MPIDR 0x30001 -> Node 1
[    0.000000] ACPI: NUMA: SRAT: PXM 1 -> MPIDR 0x30002 -> Node 1
[    0.000000] ACPI: NUMA: SRAT: PXM 1 -> MPIDR 0x30003 -> Node 1
[    0.000000] ACPI: NUMA: SRAT: PXM 1 -> MPIDR 0x30100 -> Node 1
[    0.000000] ACPI: NUMA: SRAT: PXM 1 -> MPIDR 0x30101 -> Node 1
[    0.000000] ACPI: NUMA: SRAT: PXM 1 -> MPIDR 0x30102 -> Node 1
[    0.000000] ACPI: NUMA: SRAT: PXM 1 -> MPIDR 0x30103 -> Node 1
[    0.000000] ACPI: NUMA: SRAT: PXM 1 -> MPIDR 0x30200 -> Node 1
[    0.000000] ACPI: NUMA: SRAT: PXM 1 -> MPIDR 0x30201 -> Node 1
[    0.000000] ACPI: NUMA: SRAT: PXM 1 -> MPIDR 0x30202 -> Node 1
[    0.000000] ACPI: NUMA: SRAT: PXM 1 -> MPIDR 0x30203 -> Node 1
[    0.000000] ACPI: NUMA: SRAT: PXM 1 -> MPIDR 0x30300 -> Node 1
[    0.000000] ACPI: NUMA: SRAT: PXM 1 -> MPIDR 0x30301 -> Node 1
[    0.000000] ACPI: NUMA: SRAT: PXM 1 -> MPIDR 0x30302 -> Node 1
[    0.000000] ACPI: NUMA: SRAT: PXM 1 -> MPIDR 0x30303 -> Node 1
[    0.000000] ACPI: NUMA: SRAT: PXM 1 -> MPIDR 0x30400 -> Node 1
[    0.000000] ACPI: NUMA: SRAT: PXM 1 -> MPIDR 0x30401 -> Node 1
[    0.000000] ACPI: NUMA: SRAT: PXM 1 -> MPIDR 0x30402 -> Node 1
[    0.000000] ACPI: NUMA: SRAT: PXM 1 -> MPIDR 0x30403 -> Node 1
[    0.000000] ACPI: NUMA: SRAT: PXM 1 -> MPIDR 0x30500 -> Node 1
[    0.000000] ACPI: NUMA: SRAT: PXM 1 -> MPIDR 0x30501 -> Node 1
[    0.000000] ACPI: NUMA: SRAT: PXM 1 -> MPIDR 0x30502 -> Node 1
[    0.000000] ACPI: NUMA: SRAT: PXM 1 -> MPIDR 0x30503 -> Node 1
[    0.000000] ACPI: NUMA: SRAT: PXM 2 -> MPIDR 0x50000 -> Node 2
[    0.000000] ACPI: NUMA: SRAT: PXM 2 -> MPIDR 0x50001 -> Node 2
[    0.000000] ACPI: NUMA: SRAT: PXM 2 -> MPIDR 0x50002 -> Node 2
[    0.000000] ACPI: NUMA: SRAT: PXM 2 -> MPIDR 0x50003 -> Node 2
[    0.000000] ACPI: NUMA: SRAT: PXM 2 -> MPIDR 0x50100 -> Node 2
[    0.000000] ACPI: NUMA: SRAT: PXM 2 -> MPIDR 0x50101 -> Node 2
[    0.000000] ACPI: NUMA: SRAT: PXM 2 -> MPIDR 0x50102 -> Node 2
[    0.000000] ACPI: NUMA: SRAT: PXM 2 -> MPIDR 0x50103 -> Node 2
[    0.000000] ACPI: NUMA: SRAT: PXM 2 -> MPIDR 0x50200 -> Node 2
[    0.000000] ACPI: NUMA: SRAT: PXM 2 -> MPIDR 0x50201 -> Node 2
[    0.000000] ACPI: NUMA: SRAT: PXM 2 -> MPIDR 0x50202 -> Node 2
[    0.000000] ACPI: NUMA: SRAT: PXM 2 -> MPIDR 0x50203 -> Node 2
[    0.000000] ACPI: NUMA: SRAT: PXM 2 -> MPIDR 0x50300 -> Node 2
[    0.000000] ACPI: NUMA: SRAT: PXM 2 -> MPIDR 0x50301 -> Node 2
[    0.000000] ACPI: NUMA: SRAT: PXM 2 -> MPIDR 0x50302 -> Node 2
[    0.000000] ACPI: NUMA: SRAT: PXM 2 -> MPIDR 0x50303 -> Node 2
[    0.000000] random: get_random_bytes called from 
start_kernel+0xa8/0x408 with crng_init=0
[    0.000000] percpu: Embedded 23 pages/cpu @(____ptrval____) s55960 
r8192 d30056 u94208
[    0.000000] pcpu-alloc: s55960 r8192 d30056 u94208 alloc=23*4096
[    0.000000] pcpu-alloc: [0] 00 [0] 01 [0] 02 [0] 03 [0] 04 [0] 05 [0] 
06 [0] 07
[    0.000000] pcpu-alloc: [0] 08 [0] 09 [0] 10 [0] 11 [0] 12 [0] 13 [0] 
14 [0] 15
[    0.000000] pcpu-alloc: [0] 16 [0] 17 [0] 18 [0] 19 [0] 20 [0] 21 [0] 
22 [0] 23
[    0.000000] pcpu-alloc: [1] 24 [1] 25 [1] 26 [1] 27 [1] 28 [1] 29 [1] 
30 [1] 31
[    0.000000] pcpu-alloc: [1] 32 [1] 33 [1] 34 [1] 35 [1] 36 [1] 37 [1] 
38 [1] 39
[    0.000000] pcpu-alloc: [1] 40 [1] 41 [1] 42 [1] 43 [1] 44 [1] 45 [1] 
46 [1] 47
[    0.000000] pcpu-alloc: [2] 48 [2] 49 [2] 50 [2] 51 [2] 52 [2] 53 [2] 
54 [2] 55
[    0.000000] pcpu-alloc: [2] 56 [2] 57 [2] 58 [2] 59 [2] 60 [2] 61 [2] 
62 [2] 63
[    0.000000] Detected VIPT I-cache on CPU0
[    0.000000] CPU features: detected: Virtualization Host Extensions
[    0.000000] CPU features: detected: Kernel page table isolation (KPTI)
[    0.000000] CPU features: detected: Hardware dirty bit management
[    0.000000] Built 4 zonelists, mobility grouping on.  Total pages: 
7998480
[    0.000000] Policy zone: Normal
[    0.000000] Kernel command line: BOOT_IMAGE=/john/Image rdinit=/init 
crashkernel=256M@32M earlycon console=ttyAMA0,115200 acpi=force 
pcie_aspm=off scsi_mod.use_blk_mq=y no_console_suspend
[    0.000000] PCIe ASPM is disabled
[    0.000000] printk: log_buf_len individual max cpu contribution: 4096 
bytes
[    0.000000] printk: log_buf_len total cpu_extra contributions: 258048 
bytes
[    0.000000] printk: log_buf_len min size: 131072 bytes
[    0.000000] printk: log_buf_len: 524288 bytes
[    0.000000] printk: early log buf free: 118496(90%)
[    0.000000] software IO TLB: mapped [mem 0x35a40000-0x39a40000] (64MB)
[    0.000000] Memory: 31267276K/32501760K available (11068K kernel 
code, 1606K rwdata, 5344K rodata, 1408K init, 381K bss, 1201716K 
reserved, 32768K cma-reserved)
[    0.000000] SLUB: HWalign=64, Order=0-3, MinObjects=0, CPUs=64, Nodes=4
[    0.000000] rcu: Preemptible hierarchical RCU implementation.
[    0.000000]     Tasks RCU enabled.
[    0.000000] rcu: RCU calculated value of scheduler-enlistment delay 
is 25 jiffies.
[    0.000000] NR_IRQS: 64, nr_irqs: 64, preallocated irqs: 0
[    0.000000] GICv3: GIC: Using split EOI/Deactivate mode
[    0.000000] GICv3: Distributor has no Range Selector support
[    0.000000] GICv3: VLPI support, direct LPI support
[    0.000000] GICv3: CPU0: found redistributor 10000 region 
0:0x00000000ae100000
[    0.000000] SRAT: PXM 0 -> ITS 0 -> Node 0
[    0.000000] ITS [mem 0x202100000-0x20211ffff]
[    0.000000] ITS@0x0000000202100000: Using ITS number 0
[    0.000000] ITS@0x0000000202100000: allocated 8192 Devices 
@23f0560000 (indirect, esz 8, psz 16K, shr 1)
[    0.000000] ITS@0x0000000202100000: allocated 2048 Virtual CPUs 
@23f0548000 (indirect, esz 16, psz 4K, shr 1)
[    0.000000] ITS@0x0000000202100000: allocated 256 Interrupt 
Collections @23f0547000 (flat, esz 16, psz 4K, shr 1)
[    0.000000] GICv3: using LPI property table @0x00000023f0570000
[    0.000000] ITS: Using DirectLPI for VPE invalidation
[    0.000000] ITS: Enabling GICv4 support
[    0.000000] GICv3: CPU0: using allocated LPI pending table 
@0x00000023f0580000
[    0.000000] arch_timer: cp15 timer(s) running at 100.00MHz (phys).
[    0.000000] clocksource: arch_sys_counter: mask: 0xffffffffffffff 
max_cycles: 0x171024e7e0, max_idle_ns: 440795205315 ns
[    0.000001] sched_clock: 56 bits at 100MHz, resolution 10ns, wraps 
every 4398046511100ns
[    0.000137] Console: colour dummy device 80x25
[    0.000184] mempolicy: Enabling automatic NUMA balancing. Configure 
with numa_balancing= or the kernel.numa_balancing sysctl
[    0.000198] ACPI: Core revision 20181213
[    0.000343] Calibrating delay loop (skipped), value calculated using 
timer frequency.. 200.00 BogoMIPS (lpj=400000)
[    0.000346] pid_max: default: 65536 minimum: 512
[    0.000390] LSM: Security Framework initializing
[    0.006682] Dentry cache hash table entries: 4194304 (order: 13, 
33554432 bytes)
[    0.009803] Inode-cache hash table entries: 2097152 (order: 12, 
16777216 bytes)
[    0.009936] Mount-cache hash table entries: 65536 (order: 7, 524288 
bytes)
[    0.010050] Mountpoint-cache hash table entries: 65536 (order: 7, 
524288 bytes)
[    0.036041] ASID allocator initialised with 32768 entries
[    0.044034] rcu: Hierarchical SRCU implementation.
[    0.052048] Platform MSI: ITS@0x202100000 domain created
[    0.052057] PCI/MSI: ITS@0x202100000 domain created
[    0.052099] Remapping and enabling EFI services.
[    0.060044] smp: Bringing up secondary CPUs ...
[    0.107342] Detected VIPT I-cache on CPU1
[    0.107350] GICv3: CPU1: found redistributor 10001 region 
1:0x00000000ae140000
[    0.107356] GICv3: CPU1: using allocated LPI pending table 
@0x00000023f0590000
[    0.107368] CPU1: Booted secondary processor 0x0000010001 [0x480fd010]
[    0.154548] Detected VIPT I-cache on CPU2
[    0.154553] GICv3: CPU2: found redistributor 10002 region 
2:0x00000000ae180000
[    0.154559] GICv3: CPU2: using allocated LPI pending table 
@0x00000023f05a0000
[    0.154568] CPU2: Booted secondary processor 0x0000010002 [0x480fd010]
[    0.201755] Detected VIPT I-cache on CPU3
[    0.201761] GICv3: CPU3: found redistributor 10003 region 
3:0x00000000ae1c0000
[    0.201766] GICv3: CPU3: using allocated LPI pending table 
@0x00000023f05b0000
[    0.201775] CPU3: Booted secondary processor 0x0000010003 [0x480fd010]
[    0.248956] Detected VIPT I-cache on CPU4
[    0.248964] GICv3: CPU4: found redistributor 10100 region 
4:0x00000000ae200000
[    0.248972] GICv3: CPU4: using allocated LPI pending table 
@0x00000023f05c0000
[    0.248986] CPU4: Booted secondary processor 0x0000010100 [0x480fd010]
[    0.296161] Detected VIPT I-cache on CPU5
[    0.296167] GICv3: CPU5: found redistributor 10101 region 
5:0x00000000ae240000
[    0.296172] GICv3: CPU5: using allocated LPI pending table 
@0x00000023f05d0000
[    0.296182] CPU5: Booted secondary processor 0x0000010101 [0x480fd010]
[    0.343370] Detected VIPT I-cache on CPU6
[    0.343376] GICv3: CPU6: found redistributor 10102 region 
6:0x00000000ae280000
[    0.343382] GICv3: CPU6: using allocated LPI pending table 
@0x00000023f05e0000
[    0.343392] CPU6: Booted secondary processor 0x0000010102 [0x480fd010]
[    0.390579] Detected VIPT I-cache on CPU7
[    0.390586] GICv3: CPU7: found redistributor 10103 region 
7:0x00000000ae2c0000
[    0.390592] GICv3: CPU7: using allocated LPI pending table 
@0x00000023f05f0000
[    0.390602] CPU7: Booted secondary processor 0x0000010103 [0x480fd010]
[    0.437799] Detected VIPT I-cache on CPU8
[    0.437808] GICv3: CPU8: found redistributor 10200 region 
8:0x00000000ae300000
[    0.437815] GICv3: CPU8: using allocated LPI pending table 
@0x00000023f0600000
[    0.437827] CPU8: Booted secondary processor 0x0000010200 [0x480fd010]
[    0.485007] Detected VIPT I-cache on CPU9
[    0.485014] GICv3: CPU9: found redistributor 10201 region 
9:0x00000000ae340000
[    0.485020] GICv3: CPU9: using allocated LPI pending table 
@0x00000023f0610000
[    0.485029] CPU9: Booted secondary processor 0x0000010201 [0x480fd010]
[    0.532217] Detected VIPT I-cache on CPU10
[    0.532224] GICv3: CPU10: found redistributor 10202 region 
10:0x00000000ae380000
[    0.532230] GICv3: CPU10: using allocated LPI pending table 
@0x00000023f0620000
[    0.532240] CPU10: Booted secondary processor 0x0000010202 [0x480fd010]
[    0.579427] Detected VIPT I-cache on CPU11
[    0.579435] GICv3: CPU11: found redistributor 10203 region 
11:0x00000000ae3c0000
[    0.579441] GICv3: CPU11: using allocated LPI pending table 
@0x00000023f0630000
[    0.579450] CPU11: Booted secondary processor 0x0000010203 [0x480fd010]
[    0.626636] Detected VIPT I-cache on CPU12
[    0.626645] GICv3: CPU12: found redistributor 10300 region 
12:0x00000000ae400000
[    0.626652] GICv3: CPU12: using allocated LPI pending table 
@0x00000023f0640000
[    0.626665] CPU12: Booted secondary processor 0x0000010300 [0x480fd010]
[    0.673843] Detected VIPT I-cache on CPU13
[    0.673850] GICv3: CPU13: found redistributor 10301 region 
13:0x00000000ae440000
[    0.673857] GICv3: CPU13: using allocated LPI pending table 
@0x00000023f0650000
[    0.673867] CPU13: Booted secondary processor 0x0000010301 [0x480fd010]
[    0.721053] Detected VIPT I-cache on CPU14
[    0.721061] GICv3: CPU14: found redistributor 10302 region 
14:0x00000000ae480000
[    0.721067] GICv3: CPU14: using allocated LPI pending table 
@0x00000023f0660000
[    0.721077] CPU14: Booted secondary processor 0x0000010302 [0x480fd010]
[    0.768262] Detected VIPT I-cache on CPU15
[    0.768270] GICv3: CPU15: found redistributor 10303 region 
15:0x00000000ae4c0000
[    0.768276] GICv3: CPU15: using allocated LPI pending table 
@0x00000023f0670000
[    0.768286] CPU15: Booted secondary processor 0x0000010303 [0x480fd010]
[    0.815486] Detected VIPT I-cache on CPU16
[    0.815495] GICv3: CPU16: found redistributor 10400 region 
16:0x00000000ae500000
[    0.815503] GICv3: CPU16: using allocated LPI pending table 
@0x00000023f0680000
[    0.815516] CPU16: Booted secondary processor 0x0000010400 [0x480fd010]
[    0.862691] Detected VIPT I-cache on CPU17
[    0.862699] GICv3: CPU17: found redistributor 10401 region 
17:0x00000000ae540000
[    0.862705] GICv3: CPU17: using allocated LPI pending table 
@0x00000023f0690000
[    0.862716] CPU17: Booted secondary processor 0x0000010401 [0x480fd010]
[    0.909902] Detected VIPT I-cache on CPU18
[    0.909910] GICv3: CPU18: found redistributor 10402 region 
18:0x00000000ae580000
[    0.909916] GICv3: CPU18: using allocated LPI pending table 
@0x00000023f06a0000
[    0.909926] CPU18: Booted secondary processor 0x0000010402 [0x480fd010]
[    0.957112] Detected VIPT I-cache on CPU19
[    0.957120] GICv3: CPU19: found redistributor 10403 region 
19:0x00000000ae5c0000
[    0.957127] GICv3: CPU19: using allocated LPI pending table 
@0x00000023f06b0000
[    0.957137] CPU19: Booted secondary processor 0x0000010403 [0x480fd010]
[    1.004314] Detected VIPT I-cache on CPU20
[    1.004324] GICv3: CPU20: found redistributor 10500 region 
20:0x00000000ae600000
[    1.004333] GICv3: CPU20: using allocated LPI pending table 
@0x00000023f06c0000
[    1.004346] CPU20: Booted secondary processor 0x0000010500 [0x480fd010]
[    1.051522] Detected VIPT I-cache on CPU21
[    1.051531] GICv3: CPU21: found redistributor 10501 region 
21:0x00000000ae640000
[    1.051537] GICv3: CPU21: using allocated LPI pending table 
@0x00000023f06d0000
[    1.051548] CPU21: Booted secondary processor 0x0000010501 [0x480fd010]
[    1.098733] Detected VIPT I-cache on CPU22
[    1.098742] GICv3: CPU22: found redistributor 10502 region 
22:0x00000000ae680000
[    1.098749] GICv3: CPU22: using allocated LPI pending table 
@0x00000023f06e0000
[    1.098759] CPU22: Booted secondary processor 0x0000010502 [0x480fd010]
[    1.145944] Detected VIPT I-cache on CPU23
[    1.145953] GICv3: CPU23: found redistributor 10503 region 
23:0x00000000ae6c0000
[    1.145960] GICv3: CPU23: using allocated LPI pending table 
@0x00000023f06f0000
[    1.145970] CPU23: Boo found redistributor 30000 region 
24:0x00000000aa100000
[    1.193264] GICv3: CPU24: using allocated LPI pending table 
@0x00000023f0700000
[    1.193285] CPU24: Booted secondary processor 0x0000030000 [0x480fd010]
[    1.240427] Detected VIPT I-cache on CPU25
[    1.240439] GICv3: CPU25: found redistributor 30001 region 
25:0x00000000aa140000
[    1.240447] GICv3: CPU25: using allocated LPI pending table 
@0x00000023f0710000
[    1.240459] CPU25: Booted secondary processor 0x0000030001 [0x480fd010]
[    1.287642] Detected VIPT I-cache on CPU26
[    1.287655] GICv3: CPU26: found redistributor 30002 region 
26:0x00000000aa180000
[    1.287662] GICv3: CPU26: using allocated LPI pending table 
@0x00000023f0720000
[    1.287676] CPU26: Booted secondary processor 0x0000030002 [0x480fd010]
[    1.334858] Detected VIPT I-cache on CPU27
[    1.334871] GICv3: CPU27: found redistributor 30003 region 
27:0x00000000aa1c0000
[    1.334878] GICv3: CPU27: using allocated LPI pending table 
@0x00000023f0730000
[    1.334891] CPU27: Booted secondary processor 0x0000030003 [0x480fd010]
[    1.382072] Detected VIPT I-cache on CPU28
[    1.382089] GICv3: CPU28: found redistributor 30100 region 
28:0x00000000aa200000
[    1.382100] GICv3: CPU28: using allocated LPI pending table 
@0x00000023f0740000
[    1.382118] CPU28: Booted secondary processor 0x0000030100 [0x480fd010]
[    1.429283] Detected VIPT I-cache on CPU29
[    1.429297] GICv3: CPU29: found redistributor 30101 region 
29:0x00000000aa240000
[    1.429305] GICv3: CPU29: using allocated LPI pending table 
@0x00000023f0750000
[    1.429318] CPU29: Booted secondary processor 0x0000030101 [0x480fd010]
[    1.476503] Detected VIPT I-cache on CPU30
[    1.476516] GICv3: CPU30: found redistributor 30102 region 
30:0x00000000aa280000
[    1.476524] GICv3: CPU30: using allocated LPI pending table 
@0x00000023f0760000
[    1.476538] CPU30: Booted secondary processor 0x0000030102 [0x480fd010]
[    1.523719] Detected VIPT I-cache on CPU31
[    1.523734] GICv3: CPU31: found redistributor 30103 region 
31:0x00000000aa2c0000
[    1.523742] GICv3: CPU31: using allocated LPI pending table 
@0x00000023f0770000
[    1.523755] CPU31: Booted secondary processor 0x0000030103 [0x480fd010]
[    1.570949] Detected VIPT I-cache on CPU32
[    1.570966] GICv3: CPU32: found redistributor 30200 region 
32:0x00000000aa300000
[    1.570977] GICv3: CPU32: using allocated LPI pending table 
@0x00000023f0780000
[    1.570993] CPU32: Booted secondary processor 0x0000030200 [0x480fd010]
[    1.618164] Detected VIPT I-cache on CPU33
[    1.618178] GICv3: CPU33: found redistributor 30201 region 
33:0x00000000aa340000
[    1.618187] GICv3: CPU33: using allocated LPI pending table 
@0x00000023f0790000
[    1.618200] CPU33: Booted secondary processor 0x0000030201 [0x480fd010]
[    1.665380] Detected VIPT I-cache on CPU34
[    1.665394] GICv3: CPU34: found redistributor 30202 region 
34:0x00000000aa380000
[    1.665402] GICv3: CPU34: using allocated LPI pending table 
@0x00000023f07a0000
[    1.665415] CPU34: Booted secondary processor 0x0000030202 [0x480fd010]
[    1.712596] Detected VIPT I-cache on CPU35
[    1.712610] GICv3: CPU35: found redistributor 30203 region 
35:0x00000000aa3c0000
[    1.712617] GICv3: CPU35: using allocated LPI pending table 
@0x00000023f07b0000
[    1.712630] CPU35: Booted secondary processor 0x0000030203 [0x480fd010]
[    1.759812] Detected VIPT I-cache on CPU36
[    1.759830] GICv3: CPU36: found redistributor 30300 region 
36:0x00000000aa400000
[    1.759840] GICv3: CPU36: using allocated LPI pending table 
@0x00000023f07c0000
[    1.759858] CPU36: Booted secondary processor 0x0000030300 [0x480fd010]
[    1.807027] Detected VIPT I-cache on CPU37
[    1.807042] GICv3: CPU37: found redistributor 30301 region 
37:0x00000000aa440000
[    1.807051] GICv3: CPU37: using allocated LPI pending table 
@0x00000023f07d0000
[    1.807064] CPU37: Booted secondary processor 0x0000030301 [0x480fd010]
[    1.854242] Detected VIPT I-cache on CPU38
[    1.854257] GICv3: CPU38: found redistributor 30302 region 
38:0x00000000aa480000
[    1.854266] GICv3: CPU38: using allocated LPI pending table 
@0x00000023f07e0000
[    1.854280] CPU38: Booted secondary processor 0x0000030302 [0x480fd010]
[    1.901458] Detected VIPT I-cache on CPU39
[    1.901473] GICv3: CPU39: found redistributor 30303 region 
39:0x00000000aa4c0000
[    1.901481] GICv3: CPU39: using allocated LPI pending table 
@0x00000023f07f0000
[    1.901495] CPU39: Booted secondary processor 0x0000030303 [0x480fd010]
[    1.948677] Detected VIPT I-cache on CPU40
[    1.948696] GICv3: CPU40: found redistributor 30400 region 
40:0x00000000aa500000
[    1.948706] GICv3: CPU40: using allocated LPI pending table 
@0x00000023efc00000
[    1.948723] CPU40: Booted secondary processor 0x0000030400 [0x480fd010]
[    1.995891] Detected VIPT I-cache on CPU41
[    1.995905] GICv3: CPU41: found redistributor 30401 region 
41:0x00000000aa540000
[    1.995914] GICv3: CPU41: using allocated LPI pending table 
@0x00000023efc10000
[    1.995928] CPU41: Booted secondary processor 0x0000030401 [0x480fd010]
[    2.043108] Detected VIPT I-cache on CPU42
[    2.043123] GICv3: CPU42: found redistributor 30402 region 
42:0x00000000aa580000
[    2.043132] GICv3: CPU42: using allocated LPI pending table 
@0x00000023efc20000
[    2.043146] CPU42: Booted secondary processor 0x0000030402 [0x480fd010]
[    2.090325] Detected VIPT I-cache on CPU43
[    2.090341] GICv3: CPU43: found redistributor 30403 region 
43:0x00000000aa5c0000
[    2.090349] GICv3: CPU43: using allocated LPI pending table 
@0x00000023efc30000
[    2.090362] CPU43: Booted secondary processor 0x0000030403 [0x480fd010]
[    2.137541] Detected VIPT I-cache on CPU44
[    2.137560] GICv3: CPU44: found redistributor 30500 region 
44:0x00000000aa600000
[    2.137573] GICv3: CPU44: using allocated LPI pending table 
@0x00000023efc40000
[    2.137590] CPU44: Booted secondary processor 0x0000030500 [0x480fd010]
[    2.184753] Detected VIPT I-cache on CPU45
[    2.184769] GICv3: CPU45: found redistributor 30501 region 
45:0x00000000aa640000
[    2.184778] GICv3: CPU45: using allocated LPI pending table 
@0x00000023efc50000
[    2.184792] CPU45: Booted secondary processor 0x0000030501 [0x480fd010]
[    2.231972] Detected VIPT I-cache on CPU46
[    2.231988] GICv3: CPU46: found redistributor 30502 region 
46:0x00000000aa680000
[    2.231997] GICv3: CPU46: using allocated LPI pending table 
@0x00000023efc60000
[    2.232010] CPU46: Booted secondary processor 0x0000030502 [0x480fd010]
[    2.279190] Detected VIPT I-cache on CPU47
[    2.279206] GICv3: CPU47: found redistributor 30503 region 
47:0x00000000aa6c0000
[    2.279215] GICv3: CPU47: using allocated LPI pending table 
@0x00000023efc70000
[    2.279230] CPU47: Booted secondary processor 0x0000030503 [0x480fd010]
[    2.326845] Detected VIPT I-cache on CPU48
[    2.326886] GICv3: CPU48: found redistributor 50000 region 
48:0x00004000ae100000
[    2.326912] GICv3: CPU48: using allocated LPI pending table 
@0x00000023efc80000
[    2.326936] CPU48: Booted secondary processor 0x0000050000 [0x480fd010]
[    2.374311] Detected VIPT I-cache on CPU49
[    2.374341] GICv3: CPU49: found redistributor 50001 region 
49:0x00004000ae140000
[    2.374350] GICv3: CPU49: using allocated LPI pending table 
@0x00000023efc90000
[    2.374362] CPU49: Booted secondary processor 0x0000050001 [0x480fd010]
[    2.421795] Detected VIPT I-cache on CPU50
[    2.421827] GICv3: CPU50: found redistributor 50002 region 
50:0x00004000ae180000
[    2.421846] GICv3: CPU50: using allocated LPI pending table 
@0x00000023efca0000
[    2.421858] CPU50: Booted secondary processor 0x0000050002 [0x480fd010]
[    2.469275] Detected VIPT I-cache on CPU51
[    2.469306] GICv3: CPU51: found redistributor 50003 region 
51:0x00004000ae1c0000
[    2.469315] GICv3: CPU51: using allocated LPI pending table 
@0x00000023efcb0000
[    2.469327] CPU51: Booted secondary processor 0x0000050003 [0x480fd010]
[    2.516759] Detected VIPT I-cache on CPU52
[    2.516793] GICv3: CPU52: found redistributor 50100 region 
52:0x00004000ae200000
[    2.516808] GICv3: CPU52: using allocated LPI pending table 
@0x00000023efcc0000
[    2.516823] CPU52: Booted secondary processor 0x0000050100 [0x480fd010]
[    2.564240] Detected VIPT I-cache on CPU53
[    2.564271] GICv3: CPU53: found redistributor 50101 region 
53:0x00004000ae240000
[    2.564280] GICv3: CPU53: using allocated LPI pending table 
@0x00000023efcd0000
[    2.564293] CPU53: Booted secondary processor 0x0000050101 [0x480fd010]
[    2.611722] Detected VIPT I-cache on CPU54
[    2.611754
] GICv3: CPU54: found redistributor 50102 region 54:0x00004000ae280000
[    2.611763] GICv3: CPU54: using allocated LPI pending table 
@0x00000023efce0000
[    2.611776] CPU54: Booted secondary processor 0x0000050102 [0x480fd010]
[    2.659206] Detected VIPT I-cache on CPU55
[    2.659238] GICv3: CPU55: found redistributor 50103 region 
55:0x00004000ae2c0000
[    2.659247] GICv3: CPU55: using allocated LPI pending table 
@0x00000023efcf0000
[    2.659259] CPU55: Booted secondary processor 0x0000050103 [0x480fd010]
[    2.706695] Detected VIPT I-cache on CPU56
[    2.706729] GICv3: CPU56: found redistributor 50200 region 
56:0x00004000ae300000
[    2.706746] GICv3: CPU56: using allocated LPI pending table 
@0x00000023efd00000
[    2.706761] CPU56: Booted secondary processor 0x0000050200 [0x480fd010]
[    2.754176] Detected VIPT I-cache on CPU57
[    2.754209] GICv3: CPU57: found redistributor 50201 region 
57:0x00004000ae340000
[    2.754218] GICv3: CPU57: using allocated LPI pending table 
@0x00000023efd10000
[    2.754231] CPU57: Booted secondary processor 0x0000050201 [0x480fd010]
[    2.801660] Detected VIPT I-cache on CPU58
[    2.801693] GICv3: CPU58: found redistributor 50202 region 
58:0x00004000ae380000
[    2.801703] GICv3: CPU58: using allocated LPI pending table 
@0x00000023efd20000
[    2.801716] CPU58: Booted secondary processor 0x0000050202 [0x480fd010]
[    2.849143] Detected VIPT I-cache on CPU59
[    2.849176] GICv3: CPU59: found redistributor 50203 region 
59:0x00004000ae3c0000
[    2.849185] GICv3: CPU59: using allocated LPI pending table 
@0x00000023efd30000
[    2.849198] CPU59: Booted secondary processor 0x0000050203 [0x480fd010]
[    2.896635] Detected VIPT I-cache on CPU60
[    2.896670] GICv3: CPU60: found redistributor 50300 region 
60:0x00004000ae400000
[    2.896687] GICv3: CPU60: using allocated LPI pending table 
@0x00000023efd40000
[    2.896702] CPU60: Booted secondary processor 0x0000050300 [0x480fd010]
[    2.944116] Detected VIPT I-cache on CPU61
[    2.944150] GICv3: CPU61: found redistributor 50301 region 
61:0x00004000ae440000
[    2.944161] GICv3: CPU61: using allocated LPI pending table 
@0x00000023efd50000
[    2.944175] CPU61: Booted secondary processor 0x0000050301 [0x480fd010]
[    2.991599] Detected VIPT I-cache on CPU62
[    2.991633] GICv3: CPU62: found redistributor 50302 region 
62:0x00004000ae480000
[    2.991643] GICv3: CPU62: using allocated LPI pending table 
@0x00000023efd60000
[    2.991656] CPU62: Booted secondary processor 0x0000050302 [0x480fd010]
[    3.039081] Detected VIPT I-cache on CPU63
[    3.039115] GICv3: CPU63: found redistributor 50303 region 
63:0x00004000ae4c0000
[    3.039125] GICv3: CPU63: using allocated LPI pending table 
@0x00000023efd70000
[    3.039139] CPU63: Booted secondary processor 0x0000050303 [0x480fd010]
[    3.039208] smp: Brought up 4 nodes, 64 CPUs
[    3.039317] SMP: Total of 64 processors activated.
[    3.039319] CPU features: detected: GIC system register CPU interface
[    3.039321] CPU features: detected: Privileged Access Never
[    3.039322] CPU features: detected: LSE atomic instructions
[    3.039324] CPU features: detected: User Access Override
[    3.039325] CPU features: detected: Common not Private translations
[    3.039327] CPU features: detected: RAS Extension Support
[    3.039329] CPU features: detected: CRC32 instructions
[    9.112174] CPU: All CPU(s) started at EL2
[    9.112401] alternatives: patching kernel code
[    9.120228] devtmpfs: initialized
[    9.120903] clocksource: jiffies: mask: 0xffffffff max_cycles: 
0xffffffff, max_idle_ns: 7645041785100000 ns
[    9.121043] futex hash table entries: 16384 (order: 8, 1048576 bytes)
[    9.121763] pinctrl core: initialized pinctrl subsystem
[    9.122287] SMBIOS 3.1.1 present.
[    9.122292] DMI: Huawei D06/D06, BIOS Hisilicon D06 UEFI RC0 - B601 
(V6.01) 11/08/2018
[    9.122476] NET: Registered protocol family 16
[    9.123416] audit: initializing netlink subsys (disabled)
[    9.123542] audit: type=2000 audit(2.344:1): state=initialized 
audit_enabled=0 res=1
[    9.123941] cpuidle: using governor menu
[    9.124096] vdso: 2 pages (1 code @ (____ptrval____), 1 data @ 
(____ptrval____))
[    9.124100] hw-breakpoint: found 6 breakpoint and 4 watchpoint registers.
[    9.125107] DMA: preallocated 256 KiB pool for atomic allocations
[    9.125284] ACPI: bus type PCI registered
[    9.125287] acpiphp: ACPI Hot Plug PCI Controller Driver version: 0.5
[    9.125440] Serial: AMBA PL011 UART driver
[    9.130672] HugeTLB registered 1.00 GiB page size, pre-allocated 0 pages
[    9.130676] HugeTLB registered 32.0 MiB page size, pre-allocated 0 pages
[    9.130678] HugeTLB registered 2.00 MiB page size, pre-allocated 0 pages
[    9.130680] HugeTLB registered 64.0 KiB page size, pre-allocated 0 pages
[    9.131174] cryptd: max_cpu_qlen set to 1000
[    9.132028] ACPI: Added _OSI(Module Device)
[    9.132031] ACPI: Added _OSI(Processor Device)
[    9.132033] ACPI: Added _OSI(3.0 _SCP Extensions)
[    9.132035] ACPI: Added _OSI(Processor Aggregator Device)
[    9.132037] ACPI: Added _OSI(Linux-Dell-Video)
[    9.132039] ACPI: Added _OSI(Linux-Lenovo-NV-HDMI-Audio)
[    9.132042] ACPI: Added _OSI(Linux-HPI-Hybrid-Graphics)
[    9.134274] ACPI: 1 ACPI AML tables successfully acquired and loaded
[    9.136455] ACPI: Interpreter enabled
[    9.136458] ACPI: Using GIC for interrupt routing
[    9.136477] ACPI: MCFG table detected, 1 entries
[    9.136482] ACPI: IORT: SMMU-v3[148000000] Mapped to Proximity domain 0
[    9.136532] ACPI: IORT: SMMU-v3[100000000] Mapped to Proximity domain 0
[    9.136564] ACPI: IORT: SMMU-v3[140000000] Mapped to Proximity domain 0
[    9.136593] ACPI: IORT: SMMU-v3[400148000000] Mapped to Proximity 
domain 2
[    9.136630] ACPI: IORT: SMMU-v3[400100000000] Mapped to Proximity 
domain 2
[    9.136660] ACPI: IORT: SMMU-v3[400140000000] Mapped to Proximity 
domain 2
[    9.136760] HEST: Table parsing has been initialized.
[    9.148298] ARMH0011:00: ttyAMA0 at MMIO 0x94080000 (irq = 5, 
base_baud = 0) is a SBSA
[   12.264614] printk: console [ttyAMA0] enabled
[   12.271521] ACPI: PCI Root Bridge [PCI0] (domain 0000 [bus 00-3f])
[   12.277699] acpi PNP0A08:00: _OSC: OS supports [ExtendedConfig 
Segments MSI]
[   12.284802] acpi PNP0A08:00: _OSC: not requesting OS control; OS 
requires [ExtendedConfig ASPM ClockPM MSI]
[   12.295356] acpi PNP0A08:00: [Firmware Bug]: ECAM area [mem 
0xd0000000-0xd3ffffff] not reserved in ACPI namespace
[   12.305612] acpi PNP0A08:00: ECAM at [mem 0xd0000000-0xd3ffffff] for 
[bus 00-3f]
[   12.313020] Remapped I/O 0x00000000efff0000 to [io  0x0000-0xffff window]
[   12.319843] PCI host bridge to bus 0000:00
[   12.323930] pci_bus 0000:00: root bus resource [mem 
0x80000000000-0x83fffffffff pref window]
[   12.332355] pci_bus 0000:00: root bus resource [mem 
0xe0000000-0xeffeffff window]
[   12.339826] pci_bus 0000:00: root bus resource [io  0x0000-0xffff window]
[   12.346602] pci_bus 0000:00: root bus resource [bus 00-3f]
[   12.352082] pci 0000:00:00.0: [19e5:a120] type 01 class 0x060400
[   12.352152] pci 0000:00:00.0: PME# supported from D0 D1 D2 D3hot D3cold
[   12.352229] pci 0000:00:04.0: [19e5:a120] type 01 class 0x060400
[   12.352295] pci 0000:00:04.0: PME# supported from D0 D1 D2 D3hot D3cold
[   12.352363] pci 0000:00:08.0: [19e5:a120] type 01 class 0x060400
[   12.352429] pci 0000:00:08.0: PME# supported from D0 D1 D2 D3hot D3cold
[   12.352496] pci 0000:00:0c.0: [19e5:a120] type 01 class 0x060400
[   12.352562] pci 0000:00:0c.0: PME# supported from D0 D1 D2 D3hot D3cold
[   12.352628] pci 0000:00:10.0: [19e5:a120] type 01 class 0x060400
[   12.352693] pci 0000:00:10.0: PME# supported from D0 D1 D2 D3hot D3cold
[   12.352760] pci 0000:00:12.0: [19e5:a120] type 01 class 0x060400
[   12.352826] pci 0000:00:12.0: PME# supported from D0 D1 D2 D3hot D3cold
[   12.352929] pci 0000:01:00.0: [8086:10fb] type 00 class 0x020000
[   12.352947] pci 0000:01:00.0: reg 0x10: [mem 
0x80000080000-0x800000fffff 64bit pref]
[   12.352952] pci 0000:01:00.0: reg 0x18: [io  0x0020-0x003f]
[   12.352964] pci 0000:01:00.0: reg 0x20: [mem 
0x80000104000-0x80000107fff 64bit pref]
[   12.352969] pci 0000:01:00.0: reg 0x30: [mem 0xfff80000-0xffffffff pref]
[   12.353046] pci 0000:01:00.0: PME# supported from D0 D3hot
[   12.353070] pci 0000:01:00.0: reg 0x184: [mem 0x00000000-0x00003fff 
64bit pref]
[   12.353073] pci 0000:01:00.0: VF(n) BAR0 space: [mem 
0x00000000-0x000fffff 64bit pref] (contains BAR0 for 64 VFs)
[   12.363333] pci 0000:01:00.0: reg 0x190: [mem 0x00000000-0x00003fff 
64bit pref]
[   12.363336] pci 0000:01:00.0: VF(n) BAR3 space: [mem 
0x00000000-0x000fffff 64bit pref] (contains BAR3 for 64 VFs)
[   12.373798] pci 0000:01:00.1: [8086:10fb] type 00 class 0x020000
[   12.373816] pci 0000:01:00.1: reg 0x10: [mem 
0x80000000000-0x8000007ffff 64bit pref]
[   12.373821] pci 0000:01:00.1: reg 0x18: [io  0x0000-0x001f]
[   12.373832] pci 0000:01:00.1: reg 0x20: [mem 
0x80000100000-0x80000103fff 64bit pref]
[   12.373838] pci 0000:01:00.1: reg 0x30: [mem 0xfff80000-0xffffffff pref]
[   12.373915] pci 0000:01:00.1: PME# supported from D0 D3hot
[   12.373937] pci 0000:01:00.1: reg 0x184: [mem 0x00000000-0x00003fff 
64bit pref]
[   12.373939] pci 0000:01:00.1: VF(n) BAR0 space: [mem 
0x00000000-0x000fffff 64bit pref] (contains BAR0 for 64 VFs)
[   12.384199] pci 0000:01:00.1: reg 0x190: [mem 0x00000000-0x00003fff 
64bit pref]
[   12.384202] pci 0000:01:00.1: VF(n) BAR3 space: [mem 
0x00000000-0x000fffff 64bit pref] (contains BAR3 for 64 VFs)
[   12.394788] pci 0000:05:00.0: [19e5:1711] type 00 class 0x030000
[   12.394817] pci 0000:05:00.0: reg 0x10: [mem 0xe0000000-0xe1ffffff pref]
[   12.394829] pci 0000:05:00.0: reg 0x14: [mem 0xe2000000-0xe21fffff]
[   12.394998] pci 0000:05:00.0: supports D1
[   12.395000] pci 0000:05:00.0: PME# supported from D0 D1 D3hot
[   12.395138] pci_bus 0000:00: on NUMA node 0
[   12.395159] pci 0000:00:10.0: BAR 14: assigned [mem 
0xe0000000-0xe2ffffff]
[   12.402024] pci 0000:00:00.0: BAR 14: assigned [mem 
0xe3000000-0xe31fffff]
[   12.408887] pci 0000:00:00.0: BAR 15: assigned [mem 
0x80000000000-0x800005fffff 64bit pref]
[   12.417225] pci 0000:00:12.0: BAR 14: assigned [mem 
0xe3200000-0xe33fffff]
[   12.424087] pci 0000:00:12.0: BAR 15: assigned [mem 
0x80000600000-0x800007fffff 64bit pref]
[   12.432425] pci 0000:00:00.0: BAR 13: assigned [io  0x1000-0x1fff]
[   12.438593] pci 0000:00:12.0: BAR 13: assigned [io  0x2000-0x2fff]
[   12.444763] pci 0000:01:00.0: BAR 0: assigned [mem 
0x80000000000-0x8000007ffff 64bit pref]
[   12.453020] pci 0000:01:00.0: BAR 6: assigned [mem 
0xe3000000-0xe307ffff pref]
[   12.460229] pci 0000:01:00.1: BAR 0: assigned [mem 
0x80000080000-0x800000fffff 64bit pref]
[   12.468485] pci 0000:01:00.1: BAR 6: assigned [mem 
0xe3080000-0xe30fffff pref]
[   12.475695] pci 0000:01:00.0: BAR 4: assigned [mem 
0x80000100000-0x80000103fff 64bit pref]
[   12.483951] pci 0000:01:00.0: BAR 7: assigned [mem 
0x80000104000-0x80000203fff 64bit pref]
[   12.492205] pci 0000:01:00.0: BAR 10: assigned [mem 
0x80000204000-0x80000303fff 64bit pref]
[   12.500545] pci 0000:01:00.1: BAR 4: assigned [mem 
0x80000304000-0x80000307fff 64bit pref]
[   12.508804] pci 0000:01:00.1: BAR 7: assigned [mem 
0x80000308000-0x80000407fff 64bit pref]
[   12.517058] pci 0000:01:00.1: BAR 10: assigned [mem 
0x80000408000-0x80000507fff 64bit pref]
[   12.525399] pci 0000:01:00.0: BAR 2: assigned [io  0x1000-0x101f]
[   12.531482] pci 0000:01:00.1: BAR 2: assigned [io  0x1020-0x103f]
[   12.537565] pci 0000:00:00.0: PCI bridge to [bus 01]
[   12.542518] pci 0000:00:00.0:   bridge window [io  0x1000-0x1fff]
[   12.548599] pci 0000:00:00.0:   bridge window [mem 0xe3000000-0xe31fffff]
[   12.555375] pci 0000:00:00.0:   bridge window [mem 
0x80000000000-0x800005fffff 64bit pref]
[   12.563627] pci 0000:00:04.0: PCI bridge to [bus 02]
[   12.568582] pci 0000:00:08.0: PCI bridge to [bus 03]
[   12.573538] pci 0000:00:0c.0: PCI bridge to [bus 04]
[   12.578495] pci 0000:05:00.0: BAR 0: assigned [mem 
0xe0000000-0xe1ffffff pref]
[   12.585708] pci 0000:05:00.0: BAR 1: assigned [mem 0xe2000000-0xe21fffff]
[   12.592485] pci 0000:00:10.0: PCI bridge to [bus 05]
[   12.597439] pci 0000:00:10.0:   bridge window [mem 0xe0000000-0xe2ffffff]
[   12.604216] pci 0000:00:12.0: PCI bridge to [bus 06]
[   12.609182] pci 0000:00:12.0:   bridge window [io  0x2000-0x2fff]
[   12.615267] pci 0000:00:12.0:   bridge window [mem 0xe3200000-0xe33fffff]
[   12.622044] pci 0000:00:12.0:   bridge window [mem 
0x80000600000-0x800007fffff 64bit pref]
[   12.630337] ACPI: PCI Root Bridge [PCI1] (domain 0000 [bus 7b])
[   12.636248] acpi PNP0A08:01: _OSC: OS supports [ExtendedConfig 
Segments MSI]
[   12.643287] acpi PNP0A08:01: _OSC failed (AE_NOT_FOUND)
[   12.649306] acpi PNP0A08:01: [Firmware Bug]: ECAM area [mem 
0xd7b00000-0xd7bfffff] not reserved in ACPI namespace
[   12.659572] acpi PNP0A08:01: ECAM at [mem 0xd7b00000-0xd7bfffff] for 
[bus 7b]
[   12.666757] PCI host bridge to bus 0000:7b
[   12.670844] pci_bus 0000:7b: root bus resource [mem 
0x148800000-0x148ffffff pref window]
[   12.678921] pci_bus 0000:7b: root bus resource [bus 7b]
[   12.684146] pci_bus 0000:7b: on NUMA node 0
[   12.684174] ACPI: PCI Root Bridge [PCI2] (domain 0000 [bus 7a])
[   12.690084] acpi PNP0A08:02: _OSC: OS supports [ExtendedConfig 
Segments MSI]
[   12.697122] acpi PNP0A08:02: _OSC failed (AE_NOT_FOUND)
[   12.703074] acpi PNP0A08:02: [Firmware Bug]: ECAM area [mem 
0xd7a00000-0xd7afffff] not reserved in ACPI namespace
[   12.713332] acpi PNP0A08:02: ECAM at [mem 0xd7a00000-0xd7afffff] for 
[bus 7a]
[   12.720516] PCI host bridge to bus 0000:7a
[   12.724604] pci_bus 0000:7a: root bus resource [mem 
0x20c000000-0x20c1fffff pref window]
[   12.732683] pci_bus 0000:7a: root bus resource [bus 7a]
[   12.737900] pci 0000:7a:00.0: [19e5:a239] type 00 class 0x0c0310
[   12.737906] pci 0000:7a:00.0: reg 0x10: [mem 0x20c100000-0x20c100fff 
64bit pref]
[   12.737967] pci 0000:7a:01.0: [19e5:a239] type 00 class 0x0c0320
[   12.737974] pci 0000:7a:01.0: reg 0x10: [mem 0x20c101000-0x20c101fff 
64bit pref]
[   12.738033] pci 0000:7a:02.0: [19e5:a238] type 00 class 0x0c0330
[   12.738039] pci 0000:7a:02.0: reg 0x10: [mem 0x20c000000-0x20c0fffff 
64bit pref]
[   12.738099] pci_bus 0000:7a: on NUMA node 0
[   12.738103] pci 0000:7a:02.0: BAR 0: assigned [mem 
0x20c000000-0x20c0fffff 64bit pref]
[   12.746010] pci 0000:7a:00.0: BAR 0: assigned [mem 
0x20c100000-0x20c100fff 64bit pref]
[   12.753916] pci 0000:7a:01.0: BAR 0: assigned [mem 
0x20c101000-0x20c101fff 64bit pref]
[   12.761853] ACPI: PCI Root Bridge [PCI3] (domain 0000 [bus 78-79])
[   12.768023] acpi PNP0A08:03: _OSC: OS supports [ExtendedConfig 
Segments MSI]
[   12.775063] acpi PNP0A08:03: _OSC failed (AE_NOT_FOUND)
[   12.781075] acpi PNP0A08:03: [Firmware Bug]: ECAM area [mem 
0xd7800000-0xd79fffff] not reserved in ACPI namespace
[   12.791326] acpi PNP0A08:03: ECAM at [mem 0xd7800000-0xd79fffff] for 
[bus 78-79]
[   12.798771] PCI host bridge to bus 0000:78
[   12.802857] pci_bus 0000:78: root bus resource [mem 
0x208000000-0x208ffffff pref window]
[   12.810934] pci_bus 0000:78: root bus resource [bus 78-79]
[   12.816412] pci 0000:78:00.0: [19e5:a258] type 00 class 0x100000
[   12.816420] pci 0000:78:00.0: reg 0x18: [mem 0x00000000-0x001fffff 
64bit pref]
[   12.816480] pci_bus 0000:78: on NUMA node 0
[   12.816483] pci 0000:78:00.0: BAR 2: assigned [mem 
0x208000000-0x2081fffff 64bit pref]
[   12.824416] ACPI: PCI Root Bridge [PCI4] (domain 0000 [bus 7c-7d])
[   12.830587] acpi PNP0A08:04: _OSC: OS supports [ExtendedConfig 
Segments MSI]
[   12.837628] acpi PNP0A08:04: _OSC failed (AE_NOT_FOUND)
[   12.843579] acpi PNP0A08:04: [Firmware Bug]: ECAM area [mem 
0xd7c00000-0xd7dfffff] not reserved in ACPI namespace
[   12.853830] acpi PNP0A08:04: ECAM at [mem 0xd7c00000-0xd7dfffff] for 
[bus 7c-7d]
[   12.861277] PCI host bridge to bus 0000:7c
[   12.865362] pci_bus 0000:7c: root bus resource [mem 
0x120000000-0x13fffffff pref window]
[   12.873440] pci_bus 0000:7c: root bus resource [bus 7c-7d]
[   12.878918] pci 0000:7c:00.0: [19e5:a121] type 01 class 0x060400
[   12.878926] pci 0000:7c:00.0: enabling Extended Tags
[   12.883967] pci 0000:7d:00.0: [19e5:a222] type 00 class 0x020000
[   12.883974] pci 0000:7d:00.0: reg 0x10: [mem 0x120430000-0x12043ffff 
64bit pref]
[   12.883978] pci 0000:7d:00.0: reg 0x18: [mem 0x120300000-0x1203fffff 
64bit pref]
[   12.884001] pci 0000:7d:00.0: reg 0x224: [mem 0x00000000-0x0000ffff 
64bit pref]
[   12.884004] pci 0000:7d:00.0: VF(n) BAR0 space: [mem 
0x00000000-0x000dffff 64bit pref] (contains BAR0 for 14 VFs)
[   12.894254] pci 0000:7d:00.0: reg 0x22c: [mem 0x00000000-0x000fffff 
64bit pref]
[   12.894257] pci 0000:7d:00.0: VF(n) BAR2 space: [mem 
0x00000000-0x00dfffff 64bit pref] (contains BAR2 for 14 VFs)
[   12.904560] pci 0000:7d:00.1: [19e5:a222] type 00 class 0x020000
[   12.904567] pci 0000:7d:00.1: reg 0x10: [mem 0x120420000-0x12042ffff 
64bit pref]
[   12.904571] pci 0000:7d:00.1: reg 0x18: [mem 0x120200000-0x1202fffff 
64bit pref]
[   12.904593] pci 0000:7d:00.1: reg 0x224: [mem 0x00000000-0x0000ffff 
64bit pref]
[   12.904595] pci 0000:7d:00.1: VF(n) BAR0 space: [mem 
0x00000000-0x000dffff 64bit pref] (contains BAR0 for 14 VFs)
[   12.914845] pci 0000:7d:00.1: reg 0x22c: [mem 0x00000000-0x000fffff 
64bit pref]
[   12.914848] pci 0000:7d:00.1: VF(n) BAR2 space: [mem 
0x00000000-0x00dfffff 64bit pref] (contains BAR2 for 14 VFs)
[   12.925152] pci 0000:7d:00.2: [19e5:a222] type 00 class 0x020000
[   12.925158] pci 0000:7d:00.2: reg 0x10: [mem 0x120410000-0x12041ffff 
64bit pref]
[   12.925162] pci 0000:7d:00.2: reg 0x18: [mem 0x120100000-0x1201fffff 
64bit pref]
[   12.925221] pci 0000:7d:00.3: [19e5:a221] type 00 class 0x020000
[   12.925227] pci 0000:7d:00.3: reg 0x10: [mem 0x120400000-0x12040ffff 
64bit pref]
[   12.925231] pci 0000:7d:00.3: reg 0x18: [mem 0x120000000-0x1200fffff 
64bit pref]
[   12.925291] pci_bus 0000:7c: on NUMA node 0
[   12.925298] pci 0000:7c:00.0: BAR 15: assigned [mem 
0x120000000-0x1221fffff 64bit pref]
[   12.933291] pci 0000:7d:00.0: BAR 2: assigned [mem 
0x120000000-0x1200fffff 64bit pref]
[   12.941197] pci 0000:7d:00.0: BAR 9: assigned [mem 
0x120100000-0x120efffff 64bit pref]
[   12.949105] pci 0000:7d:00.1: BAR 2: assigned [mem 
0x120f00000-0x120ffffff 64bit pref]
[   12.957011] pci 0000:7d:00.1: BAR 9: assigned [mem 
0x121000000-0x121dfffff 64bit pref]
[   12.964915] pci 0000:7d:00.2: BAR 2: assigned [mem 
0x121e00000-0x121efffff 64bit pref]
[   12.972827] pci 0000:7d:00.3: BAR 2: assigned [mem 
0x121f00000-0x121ffffff 64bit pref]
[   12.980732] pci 0000:7d:00.0: BAR 0: assigned [mem 
0x122000000-0x12200ffff 64bit pref]
[   12.988636] pci 0000:7d:00.0: BAR 7: assigned [mem 
0x122010000-0x1220effff 64bit pref]
[   12.996540] pci 0000:7d:00.1: BAR 0: assigned [mem 
0x1220f0000-0x1220fffff 64bit pref]
[   13.004446] pci 0000:7d:00.1: BAR 7: assigned [mem 
0x122100000-0x1221dffff 64bit pref]
[   13.012351] pci 0000:7d:00.2: BAR 0: assigned [mem 
0x1221e0000-0x1221effff 64bit pref]
[   13.020256] pci 0000:7d:00.3: BAR 0: assigned [mem 
0x1221f0000-0x1221fffff 64bit pref]
[   13.028161] pci 0000:7c:00.0: PCI bridge to [bus 7d]
[   13.033115] pci 0000:7c:00.0:   bridge window [mem 
0x120000000-0x1221fffff 64bit pref]
[   13.041056] ACPI: PCI Root Bridge [PCI5] (domain 0000 [bus 74-76])
[   13.047226] acpi PNP0A08:05: _OSC: OS supports [ExtendedConfig 
Segments MSI]
[   13.054265] acpi PNP0A08:05: _OSC failed (AE_NOT_FOUND)
[   13.060253] acpi PNP0A08:05: [Firmware Bug]: ECAM area [mem 
0xd7400000-0xd76fffff] not reserved in ACPI namespace
[   13.070518] acpi PNP0A08:05: ECAM at [mem 0xd7400000-0xd76fffff] for 
[bus 74-76]
[   13.077974] PCI host bridge to bus 0000:74
[   13.082060] pci_bus 0000:74: root bus resource [mem 
0x144000000-0x147ffffff pref window]
[   13.090138] pci_bus 0000:74: root bus resource [mem 
0xa2000000-0xa2ffffff window]
[   13.097608] pci_bus 0000:74: root bus resource [bus 74-76]
[   13.103085] pci 0000:74:00.0: [19e5:a121] type 01 class 0x060400
[   13.103094] pci 0000:74:00.0: enabling Extended Tags
[   13.108102] pci 0000:74:02.0: [19e5:a230] type 00 class 0x010700
[   13.108114] pci 0000:74:02.0: reg 0x24: [mem 0xa2000000-0xa2007fff]
[   13.108179] pci 0000:74:03.0: [19e5:a235] type 00 class 0x010601
[   13.108191] pci 0000:74:03.0: reg 0x24: [mem 0xa2008000-0xa2008fff]
[   13.108281] pci 0000:75:00.0: [19e5:a250] type 00 class 0x120000
[   13.108290] pci 0000:75:00.0: reg 0x18: [mem 0x144000000-0x1443fffff 
64bit pref]
[   13.108316] pci 0000:75:00.0: reg 0x22c: [mem 0x00000000-0x0000ffff 
64bit pref]
[   13.108318] pci 0000:75:00.0: VF(n) BAR2 space: [mem 
0x00000000-0x003effff 64bit pref] (contains BAR2 for 63 VFs)
[   13.118659] pci_bus 0000:74: on NUMA node 0
[   13.118665] pci 0000:74:00.0: BAR 15: assigned [mem 
0x144000000-0x1447fffff 64bit pref]
[   13.126657] pci 0000:74:02.0: BAR 5: assigned [mem 0xa2000000-0xa2007fff]
[   13.133434] pci 0000:74:03.0: BAR 5: assigned [mem 0xa2008000-0xa2008fff]
[   13.140210] pci 0000:75:00.0: BAR 2: assigned [mem 
0x144000000-0x1443fffff 64bit pref]
[   13.148115] pci 0000:75:00.0: BAR 9: assigned [mem 
0x144400000-0x1447effff 64bit pref]
[   13.156020] pci 0000:74:00.0: PCI bridge to [bus 75]
[   13.160974] pci 0000:74:00.0:   bridge window [mem 
0x144000000-0x1447fffff 64bit pref]
[   13.168915] ACPI: PCI Root Bridge [PCI6] (domain 0000 [bus 80-9f])
[   13.175088] acpi PNP0A08:06: _OSC: OS supports [ExtendedConfig 
Segments MSI]
[   13.182187] acpi PNP0A08:06: _OSC: not requesting OS control; OS 
requires [ExtendedConfig ASPM ClockPM MSI]
[   13.192652] acpi PNP0A08:06: [Firmware Bug]: ECAM area [mem 
0xd8000000-0xd9ffffff] not reserved in ACPI namespace
[   13.202904] acpi PNP0A08:06: ECAM at [mem 0xd8000000-0xd9ffffff] for 
[bus 80-9f]
[   13.210310] Remapped I/O 0x00000000ffff0000 to [io  0x10000-0x1ffff 
window]
[   13.217304] PCI host bridge to bus 0000:80
[   13.221390] pci_bus 0000:80: root bus resource [mem 
0x480000000000-0x483fffffffff pref window]
[   13.229989] pci_bus 0000:80: root bus resource [mem 
0xf0000000-0xfffeffff window]
[   13.237460] pci_bus 0000:80: root bus resource [io  0x10000-0x1ffff 
window] (bus address [0x0000-0xffff])
[   13.247013] pci_bus 0000:80: root bus resource [bus 80-9f]
[   13.252494] pci 0000:80:00.0: [19e5:a120] type 01 class 0x060400
[   13.252572] pci 0000:80:00.0: PME# supported from D0 D1 D2 D3hot D3cold
[   13.252652] pci 0000:80:08.0: [19e5:a120] type 01 class 0x060400
[   13.252727] pci 0000:80:08.0: PME# supported from D0 D1 D2 D3hot D3cold
[   13.252801] pci 0000:80:0c.0: [19e5:a120] type 01 class 0x060400
[   13.252873] pci 0000:80:0c.0: PME# supported from D0 D1 D2 D3hot D3cold
[   13.252947] pci 0000:80:10.0: [19e5:a120] type 01 class 0x060400
[   13.253010] pci 0000:80:10.0: PME# supported from D0 D1 D2 D3hot D3cold
[   13.253213] pci 0000:84:00.0: [19e5:0123] type 00 class 0x010802
[   13.253229] pci 0000:84:00.0: reg 0x10: [mem 0xf0000000-0xf003ffff 64bit]
[   13.253252] pci 0000:84:00.0: reg 0x30: [mem 0xfffe0000-0xffffffff pref]
[   13.253318] pci 0000:84:00.0: supports D1 D2
[   13.253320] pci 0000:84:00.0: PME# supported from D3hot
[   13.253398] pci_bus 0000:80: on NUMA node 2
[   13.253412] pci 0000:80:10.0: BAR 14: assigned [mem 
0xf0000000-0xf00fffff]
[   13.260276] pci 0000:80:00.0: PCI bridge to [bus 81]
[   13.265233] pci 0000:80:08.0: PCI bridge to [bus 82]
[   13.270189] pci 0000:80:0c.0: PCI bridge to [bus 83]
[   13.275147] pci 0000:84:00.0: BAR 0: assigned [mem 
0xf0000000-0xf003ffff 64bit]
[   13.282448] pci 0000:84:00.0: BAR 6: assigned [mem 
0xf0040000-0xf005ffff pref]
[   13.289661] pci 0000:80:10.0: PCI bridge to [bus 84]
[   13.294616] pci 0000:80:10.0:   bridge window [mem 0xf0000000-0xf00fffff]
[   13.301427] ACPI: PCI Root Bridge [PCI7] (domain 0000 [bus bb])
[   13.307337] acpi PNP0A08:07: _OSC: OS supports [ExtendedConfig 
Segments MSI]
[   13.314375] acpi PNP0A08:07: _OSC failed (AE_NOT_FOUND)
[   13.320326] acpi PNP0A08:07: [Firmware Bug]: ECAM area [mem 
0xdbb00000-0xdbbfffff] not reserved in ACPI namespace
[   13.330585] acpi PNP0A08:07: ECAM at [mem 0xdbb00000-0xdbbfffff] for 
[bus bb]
[   13.337769] PCI host bridge to bus 0000:bb
[   13.341855] pci_bus 0000:bb: root bus resource [mem 
0x400148800000-0x400148ffffff pref window]
[   13.350453] pci_bus 0000:bb: root bus resource [bus bb]
[   13.355680] pci_bus 0000:bb: on NUMA node 2
[   13.355706] ACPI: PCI Root Bridge [PCI8] (domain 0000 [bus ba])
[   13.361615] acpi PNP0A08:08: _OSC: OS supports [ExtendedConfig 
Segments MSI]
[   13.368653] acpi PNP0A08:08: _OSC failed (AE_NOT_FOUND)
[   13.374596] acpi PNP0A08:08: [Firmware Bug]: ECAM area [mem 
0xdba00000-0xdbafffff] not reserved in ACPI namespace
[   13.384861] acpi PNP0A08:08: ECAM at [mem 0xdba00000-0xdbafffff] for 
[bus ba]
[   13.392043] PCI host bridge to bus 0000:ba
[   13.396132] pci_bus 0000:ba: root bus resource [mem 
0x40020c000000-0x40020c1fffff pref window]
[   13.404731] pci_bus 0000:ba: root bus resource [bus ba]
[   13.409950] pci 0000:ba:00.0: [19e5:a239] type 00 class 0x0c0310
[   13.409958] pci 0000:ba:00.0: reg 0x10: [mem 
0x40020c100000-0x40020c100fff 64bit pref]
[   13.410026] pci 0000:ba:01.0: [19e5:a239] type 00 class 0x0c0320
[   13.410034] pci 0000:ba:01.0: reg 0x10: [mem 
0x40020c101000-0x40020c101fff 64bit pref]
[   13.410102] pci 0000:ba:02.0: [19e5:a238] type 00 class 0x0c0330
[   13.410109] pci 0000:ba:02.0: reg 0x10: [mem 
0x40020c000000-0x40020c0fffff 64bit pref]
[   13.410177] pci_bus 0000:ba: on NUMA node 2
[   13.410181] pci 0000:ba:02.0: BAR 0: assigned [mem 
0x40020c000000-0x40020c0fffff 64bit pref]
[   13.418609] pci 0000:ba:00.0: BAR 0: assigned [mem 
0x40020c100000-0x40020c100fff 64bit pref]
[   13.427036] pci 0000:ba:01.0: BAR 0: assigned [mem 
0x40020c101000-0x40020c101fff 64bit pref]
[   13.435492] ACPI: PCI Root Bridge [PCI9] (domain 0000 [bus b8-b9])
[   13.441662] acpi PNP0A08:09: _OSC: OS supports [ExtendedConfig 
Segments MSI]
[   13.448700] acpi PNP0A08:09: _OSC failed (AE_NOT_FOUND)
[   13.454660] acpi PNP0A08:09: [Firmware Bug]: ECAM area [mem 
0xdb800000-0xdb9fffff] not reserved in ACPI namespace
[   13.464912] acpi PNP0A08:09: ECAM at [mem 0xdb800000-0xdb9fffff] for 
[bus b8-b9]
[   13.472358] PCI host bridge to bus 0000:b8
[   13.476444] pci_bus 0000:b8: root bus resource [mem 
0x400208000000-0x400208ffffff pref window]
[   13.485043] pci_bus 0000:b8: root bus resource [bus b8-b9]
[   13.490522] pci 0000:b8:00.0: [19e5:a258] type 00 class 0x100000
[   13.490532] pci 0000:b8:00.0: reg 0x18: [mem 0x00000000-0x001fffff 
64bit pref]
[   13.490600] pci_bus 0000:b8: on NUMA node 2
[   13.490603] pci 0000:b8:00.0: BAR 2: assigned [mem 
0x400208000000-0x4002081fffff 64bit pref]
[   13.499060] ACPI: PCI Root Bridge [PCIA] (domain 0000 [bus bc-bd])
[   13.505232] acpi PNP0A08:0a: _OSC: OS supports [ExtendedConfig 
Segments MSI]
[   13.512271] acpi PNP0A08:0a: _OSC failed (AE_NOT_FOUND)
[   13.518223] acpi PNP0A08:0a: [Firmware Bug]: ECAM area [mem 
0xdbc00000-0xdbdfffff] not reserved in ACPI namespace
[   13.528475] acpi PNP0A08:0a: ECAM at [mem 0xdbc00000-0xdbdfffff] for 
[bus bc-bd]
[   13.535919] PCI host bridge to bus 0000:bc
[   13.540004] pci_bus 0000:bc: root bus resource [mem 
0x400120000000-0x40013fffffff pref window]
[   13.548603] pci_bus 0000:bc: root bus resource [bus bc-bd]
[   13.554082] pci 0000:bc:00.0: [19e5:a121] type 01 class 0x060400
[   13.554093] pci 0000:bc:00.0: enabling Extended Tags
[   13.559138] pci 0000:bd:00.0: [19e5:a222] type 00 class 0x020000
[   13.559146] pci 0000:bd:00.0: reg 0x10: [mem 
0x400120210000-0x40012021ffff 64bit pref]
[   13.559151] pci 0000:bd:00.0: reg 0x18: [mem 
0x400120100000-0x4001201fffff 64bit pref]
[   13.559181] pci 0000:bd:00.0: reg 0x224: [mem 0x00000000-0x0000ffff 
64bit pref]
[   13.559183] pci 0000:bd:00.0: VF(n) BAR0 space: [mem 
0x00000000-0x000effff 64bit pref] (contains BAR0 for 15 VFs)
[   13.569435] pci 0000:bd:00.0: reg 0x22c: [mem 0x00000000-0x000fffff 
64bit pref]
[   13.569437] pci 0000:bd:00.0: VF(n) BAR2 space: [mem 
0x00000000-0x00efffff 64bit pref] (contains BAR2 for 15 VFs)
[   13.579752] pci 0000:bd:00.1: [19e5:a222] type 00 class 0x020000
[   13.579760] pci 0000:bd:00.1: reg 0x10: [mem 
0x400120200000-0x40012020ffff 64bit pref]
[   13.579764] pci 0000:bd:00.1: reg 0x18: [mem 
0x400120000000-0x4001200fffff 64bit pref]
[   13.579792] pci 0000:bd:00.1: reg 0x224: [mem 0x00000000-0x0000ffff 
64bit pref]
[   13.579794] pci 0000:bd:00.1: VF(n) BAR0 space: [mem 
0x00000000-0x000effff 64bit pref] (contains BAR0 for 15 VFs)
[   13.590045] pci 0000:bd:00.1: reg 0x22c: [mem 0x00000000-0x000fffff 
64bit pref]
[   13.590047] pci 0000:bd:00.1: VF(n) BAR2 space: [mem 
0x00000000-0x00efffff 64bit pref] (contains BAR2 for 15 VFs)
[   13.600381] pci_bus 0000:bc: on NUMA node 2
[   13.600388] pci 0000:bc:00.0: BAR 15: assigned [mem 
0x400120000000-0x4001221fffff 64bit pref]
[   13.608905] pci 0000:bd:00.0: BAR 2: assigned [mem 
0x400120000000-0x4001200fffff 64bit pref]
[   13.617333] pci 0000:bd:00.0: BAR 9: assigned [mem 
0x400120100000-0x400120ffffff 64bit pref]
[   13.625758] pci 0000:bd:00.1: BAR 2: assigned [mem 
0x400121000000-0x4001210fffff 64bit pref]
[   13.634185] pci 0000:bd:00.1: BAR 9: assigned [mem 
0x400121100000-0x400121ffffff 64bit pref]
[   13.642611] pci 0000:bd:00.0: BAR 0: assigned [mem 
0x400122000000-0x40012200ffff 64bit pref]
[   13.651038] pci 0000:bd:00.0: BAR 7: assigned [mem 
0x400122010000-0x4001220fffff 64bit pref]
[   13.659463] pci 0000:bd:00.1: BAR 0: assigned [mem 
0x400122100000-0x40012210ffff 64bit pref]
[   13.667889] pci 0000:bd:00.1: BAR 7: assigned [mem 
0x400122110000-0x4001221fffff 64bit pref]
[   13.676314] pci 0000:bc:00.0: PCI bridge to [bus bd]
[   13.681269] pci 0000:bc:00.0:   bridge window [mem 
0x400120000000-0x4001221fffff 64bit pref]
[   13.689729] ACPI: PCI Root Bridge [PCIB] (domain 0000 [bus b4-b6])
[   13.695899] acpi PNP0A08:0b: _OSC: OS supports [ExtendedConfig 
Segments MSI]
[   13.702937] acpi PNP0A08:0b: _OSC failed (AE_NOT_FOUND)
[   13.708887] acpi PNP0A08:0b: [Firmware Bug]: ECAM area [mem 
0xdb400000-0xdb6fffff] not reserved in ACPI namespace
[   13.719147] acpi PNP0A08:0b: ECAM at [mem 0xdb400000-0xdb6fffff] for 
[bus b4-b6]
[   13.726612] PCI host bridge to bus 0000:b4
[   13.730701] pci_bus 0000:b4: root bus resource [mem 
0x400144000000-0x400147ffffff pref window]
[   13.739300] pci_bus 0000:b4: root bus resource [mem 
0xa3000000-0xa3ffffff window]
[   13.746771] pci_bus 0000:b4: root bus resource [bus b4-b6]
[   13.752249] pci 0000:b4:00.0: [19e5:a121] type 01 class 0x060400
[   13.752260] pci 0000:b4:00.0: enabling Extended Tags
[   13.757311] pci 0000:b5:00.0: [19e5:a250] type 00 class 0x120000
[   13.757322] pci 0000:b5:00.0: reg 0x18: [mem 
0x400144000000-0x4001443fffff 64bit pref]
[   13.757352] pci 0000:b5:00.0: reg 0x22c: [mem 0x00000000-0x0000ffff 
64bit pref]
[   13.757354] pci 0000 pci 0000:b5:00.0: BAR 2: assigned [mem 
0x400144000000-0x4001443fffff 64bit pref]
[   13.784651] pci 0000:b5:00.0: BAR 9: assigned [mem 
0x400144400000-0x4001447effff 64bit pref]
[   13.793077] pci 0000:b4:00.0: PCI bridge to [bus b5]
[   13.798030] pci 0000:b4:00.0:   bridge window [mem 
0x400144000000-0x4001447fffff 64bit pref]
[   13.812531] pci 0000:05:00.0: vgaarb: VGA device added: 
decodes=io+mem,owns=none,locks=none
[   13.820895] pci 0000:05:00.0: vgaarb: bridge control possible
[   13.826630] pci 0000:05:00.0: vgaarb: setting as boot device (VGA 
legacy resources not available)
[   13.835489] vgaarb: loaded
[   13.838330] SCSI subsystem initialized
[   13.842278] libata version 3.00 loaded.
[   13.842356] ACPI: bus type USB registered
[   13.846389] usbcore: registered new interface driver usbfs
[   13.851877] usbcore: registered new interface driver hub
[   13.857466] usbcore: registered new device driver usb
[   13.862817] pps_core: LinuxPPS API ver. 1 registered
[   13.867772] pps_core: Software ver. 5.3.6 - Copyright 2005-2007 
Rodolfo Giometti <giometti@linux.it>
[   13.876897] PTP clock support registered
[   13.880855] EDAC MC: Ver: 3.0.0
[   13.884179] Registered efivars operations
[   13.889792] Advanced Linux Sound Architecture Driver Initialized.
[   13.896402] clocksource: Switched to clocksource arch_sys_counter
[   13.902738] VFS: Disk quotas dquot_6.6.0
[   13.906677] VFS: Dquot-cache hash table entries: 512 (order 0, 4096 
bytes)
[   13.913640] pnp: PnP ACPI init
[   13.917020] pnp 00:00: Plug and Play ACPI device, IDs PNP0501 (active)
[   13.917114] pnp: PnP ACPI: found 1 devices
[   13.923258] NET: Registered protocol family 2
[   13.927990] tcp_listen_portaddr_hash hash table entries: 16384 
(order: 6, 262144 bytes)
[   13.936169] TCP established hash table entries: 262144 (order: 9, 
2097152 bytes)
[   13.944170] TCP bind hash table entries: 65536 (order: 8, 1048576 bytes)
[   13.951082] TCP: Hash tables configured (established 262144 bind 65536)
[   13.957871] UDP hash table entries: 16384 (order: 7, 524288 bytes)
[   13.964204] UDP-Lite hash table entries: 16384 (order: 7, 524288 bytes)
[   13.971084] NET: Registered protocol family 1
[   13.975820] RPC: Registered named UNIX socket transport module.
[   13.981732] RPC: Registered udp transport module.
[   13.986424] RPC: Registered tcp transport module.
[   13.991116] RPC: Registered tcp NFSv4.1 backchannel transport module.
[   13.997582] pci 0000:7a:00.0: enabling device (0000 -> 0002)
[   14.003250] pci 0000:7a:02.0: enabling device (0000 -> 0002)
[   14.009044] pci 0000:ba:00.0: enabling device (0000 -> 0002)
[   14.014709] pci 0000:ba:02.0: enabling device (0000 -> 0002)
[   14.020422] PCI: CLS 32 bytes, default 64
[   14.020466] Unpacking initramfs...
[   16.964034] Freeing initrd memory: 261820K
[   16.971264] hw perfevents: enabled with armv8_pmuv3_0 PMU driver, 13 
counters available
[   16.979454] kvm [1]: 16-bit VMID
[   16.982673] kvm [1]: IPA Size Limit: 48bits
[   16.986894] kvm [1]: GICv4 support disabled
[   16.991072] kvm [1]: GICv3: no GICV resource entry
[   16.995851] kvm [1]: disabling GICv2 emulation
[   17.000298] kvm [1]: GIC system register CPU interface enabled
[   17.006883] kvm [1]: vgic interrupt IRQ1
[   17.011633] kvm [1]: VHE mode initialized successfully
[   17.036115] Initialise system trusted keyrings
[   17.040624] workingset: timestamp_bits=44 max_order=23 bucket_order=0
[   17.049630] squashfs: version 4.0 (2009/01/31) Phillip Lougher
[   17.055851] NFS: Registering the id_resolver key type
[   17.060899] Key type id_resolver registered
[   17.065071] Key type id_legacy registered
[   17.069071] nfs4filelayout_init: NFSv4 File Layout Driver Registering...
[   17.075805] 9p: Installing v9fs 9p2000 file system support
[   17.096132] Key type asymmetric registered
[   17.100221] Asymmetric key parser 'x509' registered
[   17.105100] Block layer SCSI generic (bsg) driver version 0.4 loaded 
(major 245)
[   17.112484] io scheduler mq-deadline registered
[   17.117003] io scheduler kyber registered
[   17.128253] input: Power Button as 
/devices/LNXSYSTM:00/LNXSYBUS:00/PNP0C0C:00/input/input0
[   17.136608] ACPI: Power Button [PWRB]
[   17.141718] [Firmware Bug]: APEI: Invalid bit width + offset in GAR 
[0x94110034/64/0/3/0]
[   17.150049] EDAC MC0: Giving out device to module ghes_edac.c 
controller ghes_edac: DEV ghes (INTERRUPT)
[   17.159681] GHES: APEI firmware first mode is enabled by APEI bit and 
WHEA _OSC.
[   17.167106] EINJ: Error INJection is initialized.
[   17.175031] Serial: 8250/16550 driver, 4 ports, IRQ sharing enabled
[   17.201879] 00:00: ttyS0 at MMIO 0x3f00003f8 (irq = 6, base_baud = 
115200) is a 16550A
[   17.210578] SuperH (H)SCI(F) driver initialized
[   17.215205] msm_serial: driver initialized
[   17.219448] arm-smmu-v3 arm-smmu-v3.0.auto: option mask 0x0
[   17.225023] arm-smmu-v3 arm-smmu-v3.0.auto: ias 48-bit, oas 48-bit 
(features 0x00000fef)
[   17.233402] arm-smmu-v3 arm-smmu-v3.1.auto: option mask 0x0
[   17.238976] arm-smmu-v3 arm-smmu-v3.1.auto: ias 48-bit, oas 48-bit 
(features 0x00000fef)
[   17.247335] arm-smmu-v3 arm-smmu-v3.2.auto: option mask 0x0
[   17.252907] arm-smmu-v3 arm-smmu-v3.2.auto: ias 48-bit, oas 48-bit 
(features 0x00000fef)
[   17.261224] arm-smmu-v3 arm-smmu-v3.3.auto: option mask 0x0
[   17.266801] arm-smmu-v3 arm-smmu-v3.3.auto: ias 48-bit, oas 48-bit 
(features 0x00000fef)
[   17.275124] arm-smmu-v3 arm-smmu-v3.4.auto: option mask 0x0
[   17.280698] arm-smmu-v3 arm-smmu-v3.4.auto: ias 48-bit, oas 48-bit 
(features 0x00000fef)
[   17.289020] arm-smmu-v3 arm-smmu-v3.5.auto: option mask 0x0
[   17.294593] arm-smmu-v3 arm-smmu-v3.5.auto: ias 48-bit, oas 48-bit 
(features 0x00000fef)
[   17.320389] loop: module loaded
[   17.324359] iommu: Adding device 0000:74:02.0 to group 0
[   17.336788] scsi host0: hisi_sas_v3_hw
[   18.626598] hisi_sas_v3_hw 0000:74:02.0: phyup: phy0 link_rate=11
[   18.632684] hisi_sas_v3_hw 0000:74:02.0: phyup: phy1 link_rate=11
[   18.638768] hisi_sas_v3_hw 0000:74:02.0: phyup: phy2 link_rate=11
[   18.644519] sas: phy-0:0 added to port-0:0, phy_mask:0x1 
(500e004aaaaaaa1f)
[   18.644851] hisi_sas_v3_hw 0000:74:02.0: phyup: phy3 link_rate=11
[   18.644896] sas: DOING DISCOVERY on port 0, pid:2253
[   18.650934] hisi_sas_v3_hw 0000:74:02.0: phyup: phy4 link_rate=11
[   18.650939] hisi_sas_v3_hw 0000:74:02.0: phyup: phy5 link_rate=11
[   18.650955] hisi_sas_v3_hw 0000:74:02.0: phyup: phy6 link_rate=11
[   18.657295] hisi_sas_v3_hw 0000:74:02.0: dev[1:2] found
[   18.663102] hisi_sas_v3_hw 0000:74:02.0: phyup: phy7 link_rate=11
[   18.681004] sas: ex 500e004aaaaaaa1f phy00:U:0 attached: 
0000000000000000 (no device)
[   18.681109] sas: ex 500e004aaaaaaa1f phy01:U:0 attached: 
0000000000000000 (no device)
[   18.681202] sas: ex 500e004aaaaaaa1f phy02:U:0 attached: 
0000000000000000 (no device)
[   18.681293] sas: ex 500e004aaaaaaa1f phy03:U:0 attached: 
0000000000000000 (no device)
[   18.681385] sas: ex 500e004aaaaaaa1f phy04:U:0 attached: 
0000000000000000 (no device)
[   18.681478] sas: ex 500e004aaaaaaa1f phy05:U:0 attached: 
0000000000000000 (no device)
[   18.681570] sas: ex 500e004aaaaaaa1f phy06:U:0 attached: 
0000000000000000 (no device)
[   18.681666] sas: ex 500e004aaaaaaa1f phy07:U:0 attached: 
0000000000000000 (no device)
[   18.681780] sas: ex 500e004aaaaaaa1f phy08:U:8 attached: 
500e004aaaaaaa08 (stp)
[   18.681899] sas: ex 500e004aaaaaaa1f phy09:U:0 attached: 
0000000000000000 (no device)
[   18.681997] sas: ex 500e004aaaaaaa1f phy10:U:0 attached: 
0000000000000000 (no device)
[   18.682097] sas: ex 500e004aaaaaaa1f phy11:U:A attached: 
5000c50085ff5559 (ssp)
[   18.682189] sas: ex 500e004aaaaaaa1f phy12:U:0 attached: 
0000000000000000 (no device)
[   18.682284] sas: ex 500e004aaaaaaa1f phy13:U:0 attached: 
0000000000000000 (no device)
[   18.682375] sas: ex 500e004aaaaaaa1f phy14:U:0 attached: 
0000000000000000 (no device)
[   18.682468] sas: ex 500e004aaaaaaa1f phy15:U:0 attached: 
0000000000000000 (no device)
[   18.682564] sas: ex 500e004aaaaaaa1f phy16:U:B attached: 
5001882016000000 (host)
[   18.682661] sas: ex 500e004aaaaaaa1f phy17:U:B attached: 
5001882016000000 (host)
[   18.682757] sas: ex 500e004aaaaaaa1f phy18:U:B attached: 
5001882016000000 (host)
[   18.682874] sas: ex 500e004aaaaaaa1f phy19:U:B attached: 
5001882016000000 (host)
[   18.682981] sas: ex 500e004aaaaaaa1f phy20:U:B attached: 
5001882016000000 (host)
[   18.683092] sas: ex 500e004aaaaaaa1f phy21:U:B attached: 
5001882016000000 (host)
[   18.683211] sas: ex 500e004aaaaaaa1f phy22:U:B attached: 
5001882016000000 (host)
[   18.683338] sas: ex 500e004aaaaaaa1f phy23:U:B attached: 
5001882016000000 (host)
[   18.683458] sas: ex 500e004aaaaaaa1f phy24:D:B attached: 
500e004aaaaaaa1e (host+target)
[   18.683700] hisi_sas_v3_hw 0000:74:02.0: dev[2:5] found
[   18.689407] hisi_sas_v3_hw 0000:74:02.0: dev[3:1] found
[   18.694776] hisi_sas_v3_hw 0000:74:02.0: dev[4:1] found
[   18.700155] sas: Enter sas_scsi_recover_host busy: 0 failed: 0
[   18.706016] sas: ata1: end_device-0:0:8: dev error handler
[   18.706026] sas: ata1: end_device-0:0:8: Unable to reset ata device?
[   18.870074] ata1.00: ATA-8: SAMSUNG HM320JI, 2SS00_01, max UDMA7
[   18.876075] ata1.00: 625142448 sectors, multi 0: LBA48 NCQ (depth 32)
[   18.888082] ata1.00: configured for UDMA/133
[   18.892355] sas: --- Exit sas_scsi_recover_host: busy: 0 failed: 0 
tries: 1
[   18.902909] scsi 0:0:0:0: Direct-Access     ATA      SAMSUNG HM320JI 
0_01 PQ: 0 ANSI: 5
[   18.911213] sd 0:0:0:0: [sda] 625142448 512-byte logical blocks: (320 
GB/298 GiB)
[   18.912094] scsi 0:0:1:0: Direct-Access     SEAGATE  ST1000NM0023 
0006 PQ: 0 ANSI: 6
[   18.918701] sd 0:0:0:0: [sda] Write Protect is off
[   18.931552] sd 0:0:0:0: [sda] Mode Sense: 00 3a 00 00
[   18.931568] sd 0:0:0:0: [sda] Write cache: enabled, read cache: 
enabled, doesn't support DPO or FUA
[   18.960176] scsi 0:0:2:0: Enclosure         HUAWEI   Expander 12Gx16 
128  PQ: 0 ANSI: 6
[   18.960442] sd 0:0:1:0: [sdb] 1953525168 512-byte logical blocks: 
(1.00 TB/932 GiB)
[   18.963152]  sda: sda1 sda2 sda3
[   18.964415] sd 0:0:0:0: [sda] Attached SCSI disk
[   18.968985] sas: DONE DISCOVERY on port 0, pid:2253, result:0
[   18.976277] sd 0:0:1:0: [sdb] Write Protect is off
[   18.979135] sas: phy1 matched wide port0
[   18.983735] sd 0:0:1:0: [sdb] Mode Sense: db 00 10 08
[   18.988515] sas: phy-0:1 added to port-0:0, phy_mask:0x3 
(500e004aaaaaaa1f)
[   18.988529] sas: phy2 matched wide port0
[   18.988532] sas: phy-0:2 added to port-0:0, phy_mask:0x7 
(500e004aaaaaaa1f)
[   18.988543] sas: phy3 matched wide port0
[   18.988547] sas: phy-0:3 added to port-0:0, phy_mask:0xf 
(500e004aaaaaaa1f)
[   18.988558] sas: phy4 matched wide port0
[   18.988561] sas: phy-0:4 added to port-0:0, phy_mask:0x1f 
(500e004aaaaaaa1f)
[   18.988572] sas: phy5 matched wide port0
[   18.988575] sas: phy-0:5 added to port-0:0, phy_mask:0x3f 
(500e004aaaaaaa1f)
[   18.988585] sas: phy6 matched wide port0
[   18.988589] sas: phy-0:6 added to port-0:0, phy_mask:0x7f 
(500e004aaaaaaa1f)
[   18.988600] sas: phy7 matched wide port0
[   18.988606] sas: phy-0:7 added to port-0:0, phy_mask:0xff 
(500e004aaaaaaa1f)
[   18.989167] sd 0:0:1:0: [sdb] Write cache: enabled, read cache: 
enabled, supports DPO and FUA
[   19.009377]  sdb: sdb1 sdb2
[   19.016366] sd 0:0:1:0: [sdb] Attached SCSI disk
[   19.560763] iommu: Adding device 0000:84:00.0 to group 1
[   19.566966] nvme nvme0: pci function 0000:84:00.0
[   19.571813] iommu: Adding device 0000:74:03.0 to group 2
[   19.577861] ahci 0000:74:03.0: version 3.0
[   19.577971] ahci 0000:74:03.0: SSS flag set, parallel bus scan disabled
[   19.584587] ahci 0000:74:03.0: AHCI 0001.0300 32 slots 2 ports 6 Gbps 
0x3 impl SATA mode
[   19.592667] ahci 0000:74:03.0: flags: 64bit ncq sntf stag pm led clo 
only pmp fbs slum part ccc sxs boh
[   19.602134] ahci 0000:74:03.0: both AHCI_HFLAG_MULTI_MSI flag set and 
custom irq handler implemented
[   19.611773] scsi host1: ahci
[   19.614796] scsi host2: ahci
[   19.617741] ata2: SATA max UDMA/133 abar m4096@0xa2008000 port 
0xa2008100 irq 56
[   19.625126] ata3: SATA max UDMA/133 abar m4096@0xa2008000 port 
0xa2008180 irq 57
[   19.633751] libphy: Fixed MDIO Bus: probed
[   19.638008] tun: Universal TUN/TAP device driver, 1.6
[   19.643379] thunder_xcv, ver 1.0
[   19.646621] thunder_bgx, ver 1.0
[   19.649856] nicpf, ver 1.0
[   19.652794] hclge is initializing
[   19.656095] hns3: Hisilicon Ethernet Network Driver for Hip08 Family 
- version
[   19.663306] hns3: Copyright (c) 2017 Huawei Corporation.
[   19.668722] iommu: Adding device 0000:7d:00.0 to group 3
[   19.674684] hns3 0000:7d:00.0: The firmware version is b0311019
[   19.682894] nvme nvme0: 24/0/0 default/read/poll queues
[   19.687810] hclge driver initialization finished.
[   19.688158] WARNING: CPU: 50 PID: 256 at drivers/pci/msi.c:1269 
pci_irq_get_affinity+0x3c/0x90
[   19.701397] Modules linked in:
[   19.704442] CPU: 50 PID: 256 Comm: kworker/u131:0 Not tainted 
5.0.0-rc2-dirty #1027
[   19.712084] Hardware name: Huawei D06/D06, BIOS Hisilicon D06 UEFI 
RC0 - B601 (V6.01) 11/08/2018
[   19.719625] iommu: Adding device 0000:7d:00.1 to group 4
[   19.720860] Workqueue: nvme-reset-wq nvme_reset_work
[   19.720865] pstate: 60c00009 (nZCv daif +PAN +UAO)
[   19.726921] hns3 0000:7d:00.1: The firmware version is b0311019
[   19.731116] pc : pci_irq_get_affinity+0x3c/0x90
[   19.731121] lr : blk_mq_pci_map_queues+0x44/0xf0
[   19.731122] sp : ffff000012c33b90
[   19.731126] x29: ffff000012c33b90 x28: 0000000000000000
[   19.742816] hclge driver initialization finished.
[   19.746325] x27: 0000000000000000 x26: ffff000010f2ccf8
[   19.746330] x25: ffff8a23d9de0008 x24: ffff0000111fd000
[   19.774813] x23: ffff8a23e9232000 x22: 0000000000000001
[   19.777535] iommu: Adding device 0000:7d:00.2 to group 5
[   19.780113] x21: ffff0000111fda84 x20: ffff8a23d9ee9280
[   19.786089] hns3 0000:7d:00.2: The firmware version is b0311019
[   19.790713] x19: 0000000000000017 x18: ffffffffffffffff
[   19.790716] x17: 0000000000000001 x16: 0000000000000019
[   19.790717] x15: ffff0000111fd6c8 x14: ffff000092c33907
[   19.790721] x13: ffff000012c33915 x12: ffff000011215000
[   19.799746] libphy: hisilicon MII bus: probed
[   19.801926] x11: 0000000005f5e0ff x10: ffff7e288f66bc80
[   19.801929] x9 : 0000000000000000 x8 : ffff8a23d9af2100
[   19.807804] hclge driver initialization finished.
[   19.812530] x7 : 0000000000000000 x6 : 000000000000003f
[   19.812533] x5 : 0000000000000040 x4 : 3000000000000000
[   19.824568] iommu: Adding device 0000:7d:00.3 to group 6
[   19.827474] x3 : 0000000000000018 x2 : ffff8a23e92322c0
[   19.833530] hns3 0000:7d:00.3: The firmware version is b0311019
[   19.837466] x1 : 0000000000000018 x0 : ffff8a23e92322c0
[   19.837469] Call trace:
[   19.837472]  pci_irq_get_affinity+0x3c/0x90
[   19.837476]  nvme_pci_map_queues+0x90/0xe0
[   19.844558] libphy: hisilicon MII bus: probed
[   19.848074]  blk_mq_update_queue_map+0xbc/0xd8
[   19.848078]  blk_mq_alloc_tag_set+0x1d8/0x338
[   19.853769] hclge driver initialization finished.
[   19.858675]  nvme_reset_work+0x1030/0x13f0
[   19.858682]  process_one_work+0x1e0/0x318
[   19.858687]  worker_thread+0x228/0x450
[   19.871312] iommu: Adding device 0000:bd:00.0 to group 7
[   19.872323]  kthread+0x128/0x130
[   19.872328]  ret_from_fork+0x10/0x18
[   19.877506] hns3 0000:bd:00.0: The firmware version is b0311019
[   19.880581] ---[ end trace e3dfe0887464a27e ]---
[   19.880598] WARNING: CPU: 50 PID: 256 at block/blk-mq-pci.c:52 
blk_mq_pci_map_queues+0xe4/0xf0
[   19.894010] hclge driver initialization finished.
[   19.898391] Modules linked in:
[   19.898394] CPU: 50 PID: 256 Comm: kworker/u131:0 Tainted: G        W 
         5.0.0-rc2-dirty #1027
[   19.898395] Hardware name: Huawei D06/D06, BIOS Hisilicon D06 UEFI 
RC0 - B601 (V6.01) 11/08/2018
[   19.898397] Workqueue: nvme-reset-wq nvme_reset_work
[   19.930001] iommu: Adding device 0000:bd:00.1 to group 8
[   19.932786] pstate: 20c00009 (nzCv daif +PAN +UAO)
[   19.932789] pc : blk_mq_pci_map_queues+0xe4/0xf0
[   19.932791] lr : blk_mq_pci_map_queues+0x44/0xf0
[   19.932795] sp : ffff000012c33b90
[   19.942319] hns3 0000:bd:00.1: The firmware version is b0311019
[   19.946081] x29: ffff000012c33b90 x28: 0000000000000000
[   19.946083] x27: 0000000000000000 x26: ffff000010f2ccf8
[   19.946085] x25: ffff8a23d9de0008 x24: ffff0000111fd000
[   19.946086] x23: ffff8a23e9232000 x22: 0000000000000001
[   19.950466] ata2: SATA link down (SStatus 0 SControl 300)
[   19.958160] x21: ffff0000111fda84 x20: 0000000000000000
[   19.958165] x19: 0000000000000017 x18: ffffffffffffffff
[   19.958356] hclge driver initialization finished.
[   19.986330] e1000e: Intel(R) PRO/1000 Network Driver - 3.2.6-k
[   19.986561] x17: 0000000000000001 x16: 0000000000000019
[   19.991170] e1000e: Copyright(c) 1999 - 2015 Intel Corporation.
[   19.994470] x15: ffff0000111fd6c8 x14: ffff000092c33907
[   19.994474] x13: ffff000012c33915 x12: ffff000011215000
[   20.000426] igb: Intel(R) Gigabit Ethernet Network Driver - version 
5.4.0-k
[   20.005681] x11: 0000000005f5e4 : 3000000000000000
[   20.021609] igbvf: Intel(R) Gigabit Virtual Function Network Driver - 
version 2.4.0-k
[   20.026969] x3 : 0000000000000018 x2 : ffff8a23e92322c0
[   20.026974] x1 : 0000000000000018 x0 : 0000000000000018
[   20.032274] igbvf: Copyright (c) 2009 - 2012 Intel Corporation.
[   20.037571] Call trace:
[   20.037574]  blk_mq_pci_map_queues+0xe4/0xf0
[   20.037577]  nvme_pci_map_queues+0x90/0xe0
[   20.042524] sky2: driver version 1.30
[   20.048087]  blk_mq_update_queue_map+0xbc/0xd8
[   20.048090]  blk_mq_alloc_tag_set+0x1d8/0x338
[   20.048094]  nvme_reset_work+0x1030/0x13f0
[   20.053748] VFIO - User Level meta-driver version: 0.3
[   20.059299]  process_one_work+0x1e0/0x318
[   20.059301]  worker_thread+0x228/0x450
[   20.059303]  kthread+0x128/0x130
[   20.059307]  ret_from_fork+0x10/0x18
[   20.065116] ehci_hcd: USB 2.0 'Enhanced' Host Controller (EHCI) Driver
[   20.069903] ---[ end trace e3dfe0887464a27f ]---
[   20.074137]  nvme0n1: p1 p2 p3
[   20.076863] ehci-pci: EHCI PCI platform driver
[   20.077006] ehci-pci 0000:7a:01.0: EHCI Host Controller
[   20.198686] ehci-pci 0000:7a:01.0: new USB bus registered, assigned 
bus number 1
[   20.206174] ehci-pci 0000:7a:01.0: irq 54, io mem 0x20c101000
[   20.224361] ehci-pci 0000:7a:01.0: USB 0.0 started, EHCI 1.00
[   20.230276] hub 1-0:1.0: USB hub found
[   20.234023] hub 1-0:1.0: 2 ports detected
[   20.238324] ehci-pci 0000:ba:01.0: EHCI Host Controller
[   20.243571] ehci-pci 0000:ba:01.0: new USB bus registered, assigned 
bus number 2
[   20.251111] ehci-pci 0000:ba:01.0: irq 54, io mem 0x40020c101000
[   20.272362] ehci-pci 0000:ba:01.0: USB 0.0 started, EHCI 1.00
[   20.278336] hub 2-0:1.0: USB hub found
[   20.282085] hub 2-0:1.0: 2 ports detected
[   20.286253] ehci-platform: EHCI generic platform driver
[   20.291576] ehci-orion: EHCI orion driver
[   20.295625] ehci-exynos: EHCI EXYNOS driver
[   20.299837] ohci_hcd: USB 1.1 'Open' Host Controller (OHCI) Driver
[   20.306015] ohci-pci: OHCI PCI platform driver
[   20.310524] ohci-pci 0000:7a:00.0: OHCI PCI host controller
[   20.316096] ohci-pci 0000:7a:00.0: new USB bus registered, assigned 
bus number 3
[   20.323545] ohci-pci 0000:7a:00.0: irq 54, io mem 0x20c100000
[   20.392594] hub 3-0:1.0: USB hub found
[   20.396336] hub 3-0:1.0: 2 ports detected
[   20.398475] ata3: SATA link down (SStatus 0 SControl 300)
[   20.400609] ohci-pci 0000:ba:00.0: OHCI PCI host controller
[   20.411301] ohci-pci 0000:ba:00.0: new USB bus registered, assigned 
bus number 4
[   20.418774] ohci-pci 0000:ba:00.0: irq 54, io mem 0x40020c100000
[   20.488585] hub 4-0:1.0: USB hub found
[   20.492328] hub 4-0:1.0: 2 ports detected
[   20.496535] ohci-platform: OHCI generic platform driver
[   20.501802] ohci-exynos: OHCI EXYNOS driver
[   20.506093] xhci_hcd 0000:7a:02.0: xHCI Host Controller
[   20.511315] xhci_hcd 0000:7a:02.0: new USB bus registered, assigned 
bus number 5
[   20.518870] xhci_hcd 0000:7a:02.0: hcc params 0x0220f66d hci version 
0x100 quirks 0x0000000000000010
[   20.528283] hub 5-0:1.0: USB hub found
[   20.532032] hub 5-0:1.0: 1 port detected
[   20.536073] xhci_hcd 0000:7a:02.0: xHCI Host Controller
[   20.541294] xhci_hcd 0000:7a:02.0: new USB bus registered, assigned 
bus number 6
[   20.548681] xhci_hcd 0000:7a:02.0: Host supports USB 3.0  SuperSpeed
[   20.555038] usb usb6: We don't know the algorithms for LPM for this 
host, disabling LPM.
[   20.563255] hub 6-0:1.0: USB hub found
[   20.567000] hub 6-0:1.0: 1 port detected
[   20.571098] xhci_hcd 0000:ba:02.0: xHCI Host Controller
[   20.572359] usb 1-1: new high-speed USB device number 2 using ehci-pci
[   20.576339] xhci_hcd 0000:ba:02.0: new USB bus registered, assigned 
bus number 7
[   20.590474] xhci_hcd 0000:ba:02.0: hcc params 0x0220f66d hci version 
0x100 quirks 0x0000000000000010
[   20.599958] hub 7-0:1.0: USB hub found
[   20.603714] hub 7-0:1.0: 1 port detected
[   20.607780] xhci_hcd 0000:ba:02.0: xHCI Host Controller
[   20.613004] xhci_hcd 0000:ba:02.0: new USB bus registered, assigned 
bus number 8
[   20.620391] xhci_hcd 0000:ba:02.0: Host supports USB 3.0  SuperSpeed
[   20.626747] usb usb8: We don't know the algorithms for LPM for th] 
usbcore: registered new interface driver usb-storage
[   20.690169] rtc-efi rtc-efi: registered as rtc0
[   20.694948] i2c /dev entries driver
[   20.699861] sdhci: Secure Digital Host Controller Interface driver
[   20.706032] sdhci: Copyright(c) Pierre Ossman
[   20.710605] Synopsys Designware Multimedia Card Interface Driver
[   20.716878] sdhci-pltfm: SDHCI platform and OF driver helper
[   20.723949] ledtrig-cpu: registered to indicate activity on CPUs
[   20.730567] usbcore: registered new interface driver usbhid
[   20.736132] usbhid: USB HID core driver
[   20.736964] hub 1-1:1.0: USB hub found
[   20.743799] hub 1-1:1.0: 4 ports detected
[   20.788328] NET: Registered protocol family 17
[   20.792835] 9pnet: Installing 9P2000 support
[   20.797115] Key type dns_resolver registered
[   20.801565] registered taskstats version 1
[   20.805653] Loading compiled-in X.509 certificates
[   20.810898] iommu: Adding device 0000:00:00.0 to group 9
[   20.816944] iommu: Adding device 0000:00:04.0 to group 10
[   20.822917] iommu: Adding device 0000:00:08.0 to group 11
[   20.828870] iommu: Adding device 0000:00:0c.0 to group 12
[   20.834827] iommu: Adding device 0000:00:10.0 to group 13
[   20.840801] iommu: Adding device 0000:00:12.0 to group 14
[   20.846795] iommu: Adding device 0000:7c:00.0 to group 15
[   20.852716] iommu: Adding device 0000:74:00.0 to group 16
[   20.858662] iommu: Adding device 0000:80:00.0 to group 17
[   20.864697] iommu: Adding device 0000:80:08.0 to group 18
[   20.870681] iommu: Adding device 0000:80:0c.0 to group 19
[   20.876357] usb 1-2: new high-speed USB device number 3 using ehci-pci
[   20.876672] iommu: Adding device 0000:80:10.0 to group 20
[   20.888892] iommu: Adding device 0000:bc:00.0 to group 21
[   20.894847] iommu: Adding device 0000:b4:00.0 to group 22
[   20.920938] rtc-efi rtc-efi: setting system clock to 
2019-01-14T12:57:29 UTC (1547470649)
[   20.929132] ALSA device list:
[   20.932087]   No soundcards found.
[   20.935881] Freeing unused kernel memory: 1408K
[   20.960386] Run /init as init process
[   21.036960] hub 1-2:1.0: USB hub found
[   21.040799] hub 1-2:1.0: 4 ports detected
[   21.332354] usb 1-2.1: new full-speed USB device number 4 using ehci-pci
[   26.570925] random: fast init done
[   26.576673] input: Keyboard/Mouse KVM 1.1.0 as 
/devices/pci0000:7a/0000:7a:01.0/usb1/1-2/1-2.1/1-2.1:1.0/0003:12D1:0003.0001/input/input1
[   26.648522] hid-generic 0003:12D1:0003.0001: input: USB HID v1.10 
Keyboard [Keyboard/Mouse KVM 1.1.0] on usb-0000:7a:01.0-2.1/input0
[   26.661611] input: Keyboard/Mouse KVM 1.1.0 as 
/devices/pci0000:7a/0000:7a:01.0/usb1/1-2/1-2.1/1-2.1:1.1/0003:12D1:0003.0002/input/input2
[   26.673985] hid-generic 0003:12D1:0003.0002: input: USB HID v1.10 
Mouse [Keyboard/Mouse KVM 1.1.0] on usb-0000:7a:01.0-2.1/input1


