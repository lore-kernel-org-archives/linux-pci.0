Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from foss.arm.com ([217.140.101.70]:45298 "EHLO foss.arm.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754621AbcCWKSq (ORCPT <rfc822;linux-pci@vger.kernel.org>);
	Wed, 23 Mar 2016 06:18:46 -0400
Date: Wed, 23 Mar 2016 10:18:40 +0000
From: Catalin Marinas <catalin.marinas@arm.com>
To: Kefeng Wang <wangkefeng.wang@huawei.com>
Cc: linux-pci@vger.kernel.org,
	linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
	Lorenzo.Pieralisi@arm.com,
	Gabriele Paoloni <gabriele.paoloni@huawei.com>,
	Arnd Bergmann <arnd@arndb.de>, Linuxarm <linuxarm@huawei.com>,
	linux-kernel@vger.kernel.org, Zhou Wang <wangzhou1@hisilicon.com>
Subject: Re: Question about PCI I/O space in ARM64
Message-ID: <20160323101840.GA21390@e104818-lin.cambridge.arm.com>
References: <56F209A9.4040304@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <56F209A9.4040304@huawei.com>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Wed, Mar 23, 2016 at 11:12:41AM +0800, Kefeng Wang wrote:
> If no pci, the PCI I/O space(16M) is mapped into an irrelevant mem space(right ?),

No. It is not mapped at all.

> not a right IO space,
> that is, no one call pci_remap_iospace() to remap the memory mapped I/O space, once driver
> like f71805f loaded, write value to IO space(see f71805f_init->f71805f_find->superio_enter->outb),
> we met following oops,
> ------------------------
> Unable to handle kernel paging request at virtual address ffffffbffee0002e
> pgd = ffffffc1d68d4000
> [ffffffbffee0002e] *pgd=0000000000000000, *pud=0000000000000000
> Internal error: Oops: 94000046 [#1] PREEMPT SMP
> Modules linked in: f71805f(+) hwmon
> CPU: 3 PID: 1659 Comm: insmod Not tainted 4.5.0+ #88
> Hardware name: linux,dummy-virt (DT)
> task: ffffffc1f6665400 ti: ffffffc1d6418000 task.ti: ffffffc1d6418000
> PC is at f71805f_find+0x6c/0x358 [f71805f]
> ------------------------

That's caused by not having a mapped PCI I/O space.

> I am not clear about PCI I/O, but if this is indeed a bug, how to solve this issue,
> any advice will be appreciated.

You need a PCI host controller driver (e.g.
drivers/pci/host/pci-host-generic.c) and corresponding bindings in DT or
ACPI.

-- 
Catalin
