Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-yw0-f46.google.com ([209.85.213.46]:41390 "EHLO
	mail-yw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1030383Ab2CTQXv (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Tue, 20 Mar 2012 12:23:51 -0400
Received: by yhmm54 with SMTP id m54so222217yhm.19
        for <linux-pci@vger.kernel.org>; Tue, 20 Mar 2012 09:23:51 -0700 (PDT)
From: Jiang Liu <liuj97@gmail.com>
To: Yinghai Lu <yinghai@kernel.org>
Cc: Jiang Liu <jiang.liu@huawei.com>,
	Suresh Siddha <suresh.b.siddha@intel.com>,
	Jesse Barnes <jbarnes@virtuousgeek.org>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Ashok Raj <ashok.raj@intel.com>, linux-pci@vger.kernel.org,
	chenkeping@huawei.com
Subject: [PATCH 2/6] x86,IRQ: Mark unused entries in 'ioapics' array as free at startup
Date: Wed, 21 Mar 2012 00:20:59 +0800
Message-Id: <1332260463-13924-4-git-send-email-jiang.liu@huawei.com>
In-Reply-To: <1332260463-13924-1-git-send-email-jiang.liu@huawei.com>
References: <1332260463-13924-1-git-send-email-jiang.liu@huawei.com>
In-Reply-To: <CAE9FiQXC7T7JQRfiry8nHaRYN3ggy9vfzc2jDUzar80hv6pEvw@mail.gmail.com>
References: <CAE9FiQXC7T7JQRfiry8nHaRYN3ggy9vfzc2jDUzar80hv6pEvw@mail.gmail.com>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Unused entries in ioapics array should be marked as free at startup,
so they could be used by hot-added IOAPICs.

Signed-off-by: Jiang Liu <jiang.liu@huawei.com>
---
 arch/x86/kernel/apic/io_apic.c |    4 ++++
 1 files changed, 4 insertions(+), 0 deletions(-)

diff --git a/arch/x86/kernel/apic/io_apic.c b/arch/x86/kernel/apic/io_apic.c
index 7412eb8..622374f 100644
--- a/arch/x86/kernel/apic/io_apic.c
+++ b/arch/x86/kernel/apic/io_apic.c
@@ -392,6 +392,10 @@ int __init arch_early_irq_init(void)
 		cpumask_set_cpu(0, cfg->domain);
 	}
 
+	/* Mark all left entries as free for IOAPIC hot-adding. */
+	for (i = nr_ioapics; i < MAX_IO_APICS; i++)
+		ioapics[i].mp_config.apicid = 0xff;
+
 	return 0;
 }
 
-- 
1.7.5.4

