Return-Path: <linux-kernel-owner@vger.kernel.org>
From: Keith Busch <keith.busch@intel.com>
To: LKML <linux-kernel@vger.kernel.org>,
	Thomas Gleixner <tglx@linutronix.de>, linux-pci@vger.kernel.org
Cc: Bjorn Helgaas <bhelgaas@google.com>,
	Jon Derrick <jonathan.derrick@intel.com>,
	Keith Busch <keith.busch@intel.com>
Subject: [PATCH 2/2] vmd: use untracked irq handler
Date: Fri, 17 Jun 2016 16:00:21 -0600
Message-Id: <1466200821-29159-2-git-send-email-keith.busch@intel.com>
In-Reply-To: <1466200821-29159-1-git-send-email-keith.busch@intel.com>
References: <1466200821-29159-1-git-send-email-keith.busch@intel.com>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

There is no way to know which device in a VMD tiggered an interrupt
without invoking every registered driver's actions. This uses the
untracked irq handler so that a less used device does not trigger
spurious interrupt.

We have been previously recommending users enable "noirqdebug", but do
not want to force a system setting just to keep this domain functional.

Signed-off-by: Keith Busch <keith.busch@intel.com>
---
 arch/x86/pci/vmd.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/x86/pci/vmd.c b/arch/x86/pci/vmd.c
index 7792aba..613cac7 100644
--- a/arch/x86/pci/vmd.c
+++ b/arch/x86/pci/vmd.c
@@ -195,7 +195,7 @@ static int vmd_msi_init(struct irq_domain *domain, struct msi_domain_info *info,
 	vmdirq->virq = virq;
 
 	irq_domain_set_info(domain, virq, vmdirq->irq->vmd_vector, info->chip,
-			    vmdirq, handle_simple_irq, vmd, NULL);
+			    vmdirq, handle_untracked_irq, vmd, NULL);
 	return 0;
 }
 
-- 
2.7.2
