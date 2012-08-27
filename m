Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from plane.gmane.org ([80.91.229.3]:50425 "EHLO plane.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754504Ab2H0UXH (ORCPT <rfc822;linux-pci@vger.kernel.org>);
	Mon, 27 Aug 2012 16:23:07 -0400
Received: from list by plane.gmane.org with local (Exim 4.69)
	(envelope-from <glp-linux-pci@m.gmane.org>)
	id 1T65px-0000C6-Qp
	for linux-pci@vger.kernel.org; Mon, 27 Aug 2012 22:23:06 +0200
Received: from zccy01cs103.houston.hp.com ([15.211.201.83])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <linux-pci@vger.kernel.org>; Mon, 27 Aug 2012 22:23:05 +0200
Received: from craig.hada by zccy01cs103.houston.hp.com with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <linux-pci@vger.kernel.org>; Mon, 27 Aug 2012 22:23:05 +0200
To: linux-pci@vger.kernel.org
From: Craig Hada <craig.hada@hp.com>
Subject: Re: [PATCH] intel-iommu: Default to non-coherent for domains unattached to iommus
Date: Mon, 27 Aug 2012 20:22:51 +0000 (UTC)
Message-ID: <loom.20120827T205743-275@post.gmane.org>
References: <20111111224849.9756.13368.stgit@bling.home>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Alex Williamson <alex.williamson <at> redhat.com> writes:

> 
> domain_update_iommu_coherency() currently default to setting domains
> as coherent when the domain is not attached to any iommus.  This
> allows for a window in domain_context_mapping_one() where such a
> domain can update context entries non-coherenty, and only after
> update the domain capability to clear iommu_coherency.
> 
> This can be seen using KVM device assignment on VT-d systems that
> do not support coherency in the ecap register.  When a device is
> added to a guest, a domain is created (iommu_coherency = 0), the
> device is attached, and ranges are mapped.  If we then hot unplug
> the device, the coherency is updated and set to the default (1)
> since no iommus are attached to the domain.  A subsequenct attach
> of a device makes use of the same dmar domain (now marked coherent)
> updates context entries with cohrency enabled, and only disables
> coherency as the last step in the process.
> 
> To fix this, switch domain_update_iommu_coherency() to use the
> safer, non-coherent default for domains not attached to iommus.
> 
> Signed-off-by: Alex Williamson <alex.williamson <at> redhat.com>
> Tested-by: Donald Dutile <ddutile <at> redhat.com>
> Acked-by: Donald Dutile <ddutile <at> redhat.com>
> ---
> 
>  drivers/iommu/intel-iommu.c |    4 +++-
>  1 files changed, 3 insertions(+), 1 deletions(-)
> 
> diff --git a/drivers/iommu/intel-iommu.c b/drivers/iommu/intel-iommu.c
> index c0c7820..6b9d8c1 100644
> --- a/drivers/iommu/intel-iommu.c
> +++ b/drivers/iommu/intel-iommu.c
> @@ -560,7 +560,9 @@ static void domain_update_iommu_coherency(struct
dmar_domain *domain)
>  {
>  	int i;
> 
> -	domain->iommu_coherency = 1;
> +	i = find_first_bit(&domain->iommu_bmp, g_num_of_iommus);
> +
> +	domain->iommu_coherency = i < g_num_of_iommus ? 1 : 0;
> 
>  	for_each_set_bit(i, &domain->iommu_bmp, g_num_of_iommus) {
>  		if (!ecap_coherent(g_iommus[i]->ecap)) {
> 
> 

Is there any resolution for this issue? I have run into it on two different
systems where the IOMMU is in non-coherent mode. The relevant output from the
dmesg follows.

DRHD: handling fault status reg 2
NMI: IOCK error (debug interrupt?) for reason 71 on CPU 0.
CPU 0
Modules linked in: be2net(+) ext4 mbcache jbd2 sd_mod crc_t10dif aesni_intel cry
ptd aes_x86_64 aes_generic hpsa dm_mirror dm_region_hash dm_log dm_mod [last unl
oaded: scsi_wait_scan]

Pid: 698, comm: kdump Not tainted 3.5.0+ #12 HP ProLiant BL460c G7
RIP: 0010:[<ffffffff8143781c>]  [<ffffffff8143781c>] dmar_fault+0x13c/0x210
RSP: 0000:ffff88100b203e28  EFLAGS: 00000086
RAX: 00000000c0000002 RBX: ffff880fbadaf840 RCX: 0000000000000096
RDX: 00000000ba25b000 RSI: 000000000000010c RDI: 0000000000000046
RBP: ffff88100b203e88 R08: ffffffff81ccd160 R09: 000000000000047a
R10: 0000000000000200 R11: 0000000000080000 R12: 0000000000000000
R13: ffff880fbadaf85c R14: 0000000000000100 R15: ffffc90006050100
FS:  00007f2702847700(0000) GS:ffff88100b200000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 0000000000ea3028 CR3: 0000000fb5ed1000 CR4: 00000000000007f0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000ffff0ff0 DR7: 0000000000000400
Process kdump (pid: 698, threadinfo ffff880fb7084000, task ffff880fb7154b30)
Stack:
 0000000000000000 ffff880fb816f388 ffff880fb86b6100 ffff880fb832c010
 0000000000000002 0000000000000096 0000000000000286 ffff880fbadac8c0
 0000000000000040 0000000000000040 0000000000000000 0000000000000005
Call Trace:
 <IRQ>
 [<ffffffff810ddb1d>] handle_irq_event_percpu+0x6d/0x220
 [<ffffffff810ddd12>] handle_irq_event+0x42/0x70
 [<ffffffff810e13c9>] handle_edge_irq+0x69/0x120
 [<ffffffff810153cc>] handle_irq+0x5c/0x150
 [<ffffffff8105897b>] ? irq_enter+0x1b/0x80
 [<ffffffff8152ffed>] do_IRQ+0x5d/0xe0
 [<ffffffff815261ea>] common_interrupt+0x6a/0x6a
 <EOI>
 [<ffffffff8152e3a9>] ? system_call_fastpath+0x16/0x1b
Code: 00 48 89 c1 4d 01 f7 49 8d 77 0c 48 89 f0 48 03 03 8b 00 85 c0 0f 89 06 ff
 ff ff 49 8d 57 08 48 03 13 44 8b 12 4c 03 3b 41 8b 17 <41> 8b 7f 04 48 c1 e7 20
 41 89 d7 48 03 33 4e 8d 3c 3f ba 00 00
DMAR:[DMA Read] Request device [02:00.0] fault addr fba25b000
DMAR:[fault reason 02] Present bit in context entry is clear
be2net 0000:02:00.0: opcode 0-0 failed:status 71-0
be2net 0000:02:00.0: Emulex OneConnect 10Gbps NIC(be3) initialization failed
64bit 0000:02:00.1 uses identity mapping
be2net 0000:02:00.1: irq 75 for MSI/MSI-X
be2net 0000:02:00.1: Created only 1 receive queues
be2net 0000:02:00.1: eth0: Emulex OneConnect 10Gbps NIC(be3) port 1
64bit 0000:02:00.2 uses identity mapping
be2net 0000:02:00.2: irq 76 for MSI/MSI-X
be2net 0000:02:00.2: Created only 1 receive queues
be2net 0000:02:00.2: eth1: Emulex OneConnect 10Gbps NIC(be3) port 0
64bit 0000:02:00.3 uses identity mapping
be2net 0000:02:00.3: irq 77 for MSI/MSI-X
be2net 0000:02:00.3: Created only 1 receive queues
be2net 0000:02:00.3: eth2: Emulex OneConnect 10Gbps NIC(be3) port 1




