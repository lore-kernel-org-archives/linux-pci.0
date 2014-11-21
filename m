Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-bl2on0145.outbound.protection.outlook.com ([65.55.169.145]:15434
	"EHLO na01-bl2-obe.outbound.protection.outlook.com"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S1756487AbaKUBCn (ORCPT <rfc822;linux-pci@vger.kernel.org>);
	Thu, 20 Nov 2014 20:02:43 -0500
From: <suravee.suthikulpanit@amd.com>
To: <jiang.liu@linux.intel.com>, <tglx@linutronix.de>
CC: <marc.zyngier@arm.com>, <linux-arm-kernel@lists.infradead.org>,
	<linux-pci@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	"Suravee Suthikulpanit" <Suravee.Suthikulpanit@amd.com>
Subject: [PATCH] irqdomain: Fix NULL pointer dererence in irq_domain_free_irqs_parent
Date: Thu, 20 Nov 2014 19:02:25 -0600
Message-ID: <1416531745-24661-1-git-send-email-suravee.suthikulpanit@amd.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

From: Suravee Suthikulpanit <Suravee.Suthikulpanit@amd.com>

This patch checks if the parent domain is NULL before recursively freeing
irqs in the parent domains.

In this case, GICv2m is freeing irqs in parent (GIC), which calls
irq_domain_free_irqs_top. This fixes the crash below:

Unble to handle kernel NULL pointer dereference at virtual address 00000018
pgd = fffffe03c78c0000
[00000018] *pgd=00000083c8700003, *pud=00000083c8700003, *pmd=00000083c8700003, *pte=0000000000000000
Internal error: Oops: 96000007 [#1] SMP
Modules linked in: mlx4_core(-) rtc_efi efivarfs [last unloaded: mlx4_en]
CPU: 5 PID: 985 Comm: modprobe Not tainted 3.18.0-rc4-marc-v2m+ #223
task: fffffe03c20c0000 ti: fffffe03c1fb8000 task.ti: fffffe03c1fb8000
PC is at irq_domain_free_irqs_recursive+0x10/0x84
LR is at irq_domain_free_irqs_common+0x8c/0xa0
pc : [<fffffe00000efb2c>] lr : [<fffffe00000f028c>] pstate: 60000145
sp : fffffe03c1fbb9a0
x29: fffffe03c1fbb9a0 x28: fffffe03c1fb8000
x27: fffffe000092f000 x26: fffffe03c10eba00
...
Call trace:
[<fffffe00000efb2c>] irq_domain_free_irqs_recursive+0x10/0x84
[<fffffe00000f0288>] irq_domain_free_irqs_common+0x88/0xa0
[<fffffe00000f030c>] irq_domain_free_irqs_top+0x6c/0x84
[<fffffe00000efb40>] irq_domain_free_irqs_recursive+0x24/0x84
[<fffffe00000f0954>] irq_domain_free_irqs_parent+0x14/0x20
[<fffffe000042c4fc>] gicv2m_irq_domain_free+0x48/0x88
[<fffffe00000efb40>] irq_domain_free_irqs_recursive+0x24/0x84
[<fffffe00000f0288>] irq_domain_free_irqs_common+0x88/0xa0
[<fffffe00000f030c>] irq_domain_free_irqs_top+0x6c/0x84
[<fffffe00000f1a38>] msi_domain_free+0x74/0x8c
[<fffffe00000efb40>] irq_domain_free_irqs_recursive+0x24/0x84
[<fffffe00000f0898>] irq_domain_free_irqs+0x110/0x184
[<fffffe00000f2124>] msi_domain_free_irqs+0x28/0x4c
[<fffffe0000448194>] free_msi_irqs+0x90/0x1d8
[<fffffe0000449278>] pci_disable_msix+0x40/0x50

Signed-off-by: Suravee Suthikulpanit <Suravee.Suthikulpanit@amd.com>
---
 kernel/irq/irqdomain.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/kernel/irq/irqdomain.c b/kernel/irq/irqdomain.c
index 029acf1..4390eb8 100644
--- a/kernel/irq/irqdomain.c
+++ b/kernel/irq/irqdomain.c
@@ -1166,6 +1166,9 @@ int irq_domain_alloc_irqs_parent(struct irq_domain *domain,
 void irq_domain_free_irqs_parent(struct irq_domain *domain,
 				 unsigned int irq_base, unsigned int nr_irqs)
 {
+	if (!domain->parent)
+		return;
+
 	/* irq_domain_free_irqs_recursive() will call parent's free */
 	if (!irq_domain_is_auto_recursive(domain))
 		irq_domain_free_irqs_recursive(domain->parent, irq_base,
-- 
1.9.3

