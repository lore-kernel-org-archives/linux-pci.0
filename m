Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-gx0-f174.google.com ([209.85.161.174]:39078 "EHLO
	mail-gx0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1030383Ab2CTQXl (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Tue, 20 Mar 2012 12:23:41 -0400
Received: by gghe5 with SMTP id e5so227759ggh.19
        for <linux-pci@vger.kernel.org>; Tue, 20 Mar 2012 09:23:40 -0700 (PDT)
From: Jiang Liu <liuj97@gmail.com>
To: Yinghai Lu <yinghai@kernel.org>
Cc: Jiang Liu <jiang.liu@huawei.com>,
	Suresh Siddha <suresh.b.siddha@intel.com>,
	Jesse Barnes <jbarnes@virtuousgeek.org>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Ashok Raj <ashok.raj@intel.com>, linux-pci@vger.kernel.org,
	chenkeping@huawei.com
Subject: [PATCH 1/6] x86,IRQ: Fix possible invalid memory access after IOAPIC hot-plugging
Date: Wed, 21 Mar 2012 00:20:58 +0800
Message-Id: <1332260463-13924-3-git-send-email-jiang.liu@huawei.com>
In-Reply-To: <1332260463-13924-1-git-send-email-jiang.liu@huawei.com>
References: <1332260463-13924-1-git-send-email-jiang.liu@huawei.com>
In-Reply-To: <CAE9FiQXC7T7JQRfiry8nHaRYN3ggy9vfzc2jDUzar80hv6pEvw@mail.gmail.com>
References: <CAE9FiQXC7T7JQRfiry8nHaRYN3ggy9vfzc2jDUzar80hv6pEvw@mail.gmail.com>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Function free_ioapic_saved_registers() should mark ioapic->saved_regiters
as NULL after the memory has been freed. Otherwise when hot-adding
another IOAPIC, function alloc_ioapic_saved_registers() may reuse the
stale pointer and cause memory corruption.

Signed-off-by: Jiang Liu <jiang.liu@huawei.com>
---
 arch/x86/kernel/apic/io_apic.c |    1 +
 1 files changed, 1 insertions(+), 0 deletions(-)

diff --git a/arch/x86/kernel/apic/io_apic.c b/arch/x86/kernel/apic/io_apic.c
index da02320..7412eb8 100644
--- a/arch/x86/kernel/apic/io_apic.c
+++ b/arch/x86/kernel/apic/io_apic.c
@@ -362,6 +362,7 @@ static void alloc_ioapic_saved_registers(int idx)
 static void free_ioapic_saved_registers(int idx)
 {
 	kfree(ioapics[idx].saved_registers);
+	ioapics[idx].saved_registers = NULL;
 }
 
 int __init arch_early_irq_init(void)
-- 
1.7.5.4

