Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from userp1040.oracle.com ([156.151.31.81]:51342 "EHLO
	userp1040.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756072Ab3FGWbl (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Fri, 7 Jun 2013 18:31:41 -0400
From: Yinghai Lu <yinghai@kernel.org>
To: Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@elte.hu>,
	"H. Peter Anvin" <hpa@zytor.com>,
	Bjorn Helgaas <bhelgaas@google.com>,
	"Rafael J. Wysocki" <rjw@sisk.pl>
Cc: linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
	Yinghai Lu <yinghai@kernel.org>
Subject: [PATCH v3 17/27] genirq: Bail out early in free_desc()
Date: Fri,  7 Jun 2013 15:31:03 -0700
Message-Id: <1370644273-10495-18-git-send-email-yinghai@kernel.org>
In-Reply-To: <1370644273-10495-1-git-send-email-yinghai@kernel.org>
References: <1370644273-10495-1-git-send-email-yinghai@kernel.org>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

We pre-reserve irq range for hot-added ioapic, and later only
some are used via realloc.
So during hot-remove, we need to clear bits in allocated_irqs
for both case.

Check if the irq_desc is there at first, and bail out early if
irq_desc is not allocated yet.
We can use irq_free_descs to clear allocated_irqs bits for
preserved irqs only.

Signed-off-by: Yinghai Lu <yinghai@kernel.org>
---
 kernel/irq/irqdesc.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/kernel/irq/irqdesc.c b/kernel/irq/irqdesc.c
index b48f65b..32f099e 100644
--- a/kernel/irq/irqdesc.c
+++ b/kernel/irq/irqdesc.c
@@ -170,6 +170,9 @@ static void free_desc(unsigned int irq)
 {
 	struct irq_desc *desc = irq_to_desc(irq);
 
+	if (!desc)
+		return;
+
 	unregister_irq_proc(irq, desc);
 
 	mutex_lock(&sparse_irq_lock);
-- 
1.8.1.4

