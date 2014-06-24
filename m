Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from szxga01-in.huawei.com ([119.145.14.64]:6398 "EHLO
	szxga01-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751870AbaFXIbb (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Tue, 24 Jun 2014 04:31:31 -0400
From: Yijing Wang <wangyijing@huawei.com>
To: Bjorn Helgaas <bhelgaas@google.com>
CC: <linux-pci@vger.kernel.org>, Thomas Gleixner <tglx@linutronix.de>,
	"H. Peter Anvin" <hpa@zytor.com>, <x86@kernel.org>,
	Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>,
	Wuyun <wuyun.wu@huawei.com>, Yijing Wang <wangyijing@huawei.com>
Subject: [PATCH] x86/MSI: Clean up unnecessary override function
Date: Tue, 24 Jun 2014 16:30:45 +0800
Message-ID: <1403598645-11272-1-git-send-email-wangyijing@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

MSI driver provides several weak functions allow
platform to override. These override functions
arch_msi/x_mask_irq(), arch_restore_msi_irqs(),
arch_teardown_msi_irqs() in x86 don't provide
platform specific function, still call the
default functions. So cleanup these override
functions.

Signed-off-by: Yijing Wang <wangyijing@huawei.com>
---
 arch/x86/kernel/x86_init.c |   22 ----------------------
 1 files changed, 0 insertions(+), 22 deletions(-)

diff --git a/arch/x86/kernel/x86_init.c b/arch/x86/kernel/x86_init.c
index e48b674..00529fa 100644
--- a/arch/x86/kernel/x86_init.c
+++ b/arch/x86/kernel/x86_init.c
@@ -113,11 +113,7 @@ struct x86_msi_ops x86_msi = {
 	.setup_msi_irqs		= native_setup_msi_irqs,
 	.compose_msi_msg	= native_compose_msi_msg,
 	.teardown_msi_irq	= native_teardown_msi_irq,
-	.teardown_msi_irqs	= default_teardown_msi_irqs,
-	.restore_msi_irqs	= default_restore_msi_irqs,
 	.setup_hpet_msi		= default_setup_hpet_msi,
-	.msi_mask_irq		= default_msi_mask_irq,
-	.msix_mask_irq		= default_msix_mask_irq,
 };
 
 /* MSI arch specific hooks */
@@ -126,28 +122,10 @@ int arch_setup_msi_irqs(struct pci_dev *dev, int nvec, int type)
 	return x86_msi.setup_msi_irqs(dev, nvec, type);
 }
 
-void arch_teardown_msi_irqs(struct pci_dev *dev)
-{
-	x86_msi.teardown_msi_irqs(dev);
-}
-
 void arch_teardown_msi_irq(unsigned int irq)
 {
 	x86_msi.teardown_msi_irq(irq);
 }
-
-void arch_restore_msi_irqs(struct pci_dev *dev)
-{
-	x86_msi.restore_msi_irqs(dev);
-}
-u32 arch_msi_mask_irq(struct msi_desc *desc, u32 mask, u32 flag)
-{
-	return x86_msi.msi_mask_irq(desc, mask, flag);
-}
-u32 arch_msix_mask_irq(struct msi_desc *desc, u32 flag)
-{
-	return x86_msi.msix_mask_irq(desc, flag);
-}
 #endif
 
 struct x86_io_apic_ops x86_io_apic_ops = {
-- 
1.7.1


