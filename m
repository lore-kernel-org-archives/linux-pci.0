Return-Path: <linux-kernel-owner@vger.kernel.org>
From: Yinghai Lu <yinghai@kernel.org>
To: Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@elte.hu>,
	"H. Peter Anvin" <hpa@zytor.com>,
	Jesse Barnes <jbarnes@virtuousgeek.org>
Cc: linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
	Yinghai Lu <yinghai@kernel.org>
Subject: [PATCH 06/13] genirq: bail out early in free_desc()
Date: Thu, 23 Feb 2012 19:48:52 -0800
Message-Id: <1330055339-11662-7-git-send-email-yinghai@kernel.org>
In-Reply-To: <1330055339-11662-1-git-send-email-yinghai@kernel.org>
References: <1330055339-11662-1-git-send-email-yinghai@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

So we can use irq_free_descs to clear allocated_irqs bits for
preserved irqs.

Signed-off-by: Yinghai Lu <yinghai@kernel.org>
---
 kernel/irq/irqdesc.c |    3 +++
 1 files changed, 3 insertions(+), 0 deletions(-)

diff --git a/kernel/irq/irqdesc.c b/kernel/irq/irqdesc.c
index b1d6e51..da82457 100644
--- a/kernel/irq/irqdesc.c
+++ b/kernel/irq/irqdesc.c
@@ -169,6 +169,9 @@ static void free_desc(unsigned int irq)
 {
 	struct irq_desc *desc = irq_to_desc(irq);
 
+	if (!desc)
+		return;
+
 	unregister_irq_proc(irq, desc);
 
 	mutex_lock(&sparse_irq_lock);
-- 
1.7.7

