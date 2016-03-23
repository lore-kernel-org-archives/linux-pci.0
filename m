Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from szxga02-in.huawei.com ([119.145.14.65]:29289 "EHLO
	szxga02-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750921AbcCWDOo (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Tue, 22 Mar 2016 23:14:44 -0400
To: <linux-pci@vger.kernel.org>, <catalin.marinas@arm.com>,
	linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
	<wangkefeng.wang@huawei.com>
CC: Gabriele Paoloni <gabriele.paoloni@huawei.com>,
	Arnd Bergmann <arnd@arndb.de>, <linux-kernel@vger.kernel.org>,
	<Lorenzo.Pieralisi@arm.com>, Linuxarm <linuxarm@huawei.com>,
	Zhou Wang <wangzhou1@hisilicon.com>
From: Kefeng Wang <wangkefeng.wang@huawei.com>
Subject: Question about PCI I/O space in ARM64
Message-ID: <56F209A9.4040304@huawei.com>
Date: Wed, 23 Mar 2016 11:12:41 +0800
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Hi all，

If no pci, the PCI I/O space(16M) is mapped into an irrelevant mem space(right ?), not a right IO space,
that is, no one call pci_remap_iospace() to remap the memory mapped I/O space, once driver
like f71805f loaded, write value to IO space(see f71805f_init->f71805f_find->superio_enter->outb),
we met following oops,
------------------------
Unable to handle kernel paging request at virtual address ffffffbffee0002e
pgd = ffffffc1d68d4000
[ffffffbffee0002e] *pgd=0000000000000000, *pud=0000000000000000
Internal error: Oops: 94000046 [#1] PREEMPT SMP
Modules linked in: f71805f(+) hwmon
CPU: 3 PID: 1659 Comm: insmod Not tainted 4.5.0+ #88
Hardware name: linux,dummy-virt (DT)
task: ffffffc1f6665400 ti: ffffffc1d6418000 task.ti: ffffffc1d6418000
PC is at f71805f_find+0x6c/0x358 [f71805f]
------------------------

I am not clear about PCI I/O, but if this is indeed a bug, how to solve this issue,
any advice will be appreciated.

Thanks
Kefeng

