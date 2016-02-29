Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from devils.ext.ti.com ([198.47.26.153]:37294 "EHLO
	devils.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754885AbcB2PwN (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Mon, 29 Feb 2016 10:52:13 -0500
From: Murali Karicheri <m-karicheri2@ti.com>
To: <linux-pci@vger.kernel.org>, <gregkh@linuxfoundation.org>,
	<stable@vger.kernel.org>, <bhelgaas@google.com>,
	<linux-arm-kernel@lists.infradead.org>,
	<linux-kernel@vger.kernel.org>
Subject: [PATCH v2] PCI: keystone: fix msi code that retrieves the pp struct ptr
Date: Mon, 29 Feb 2016 10:51:53 -0500
Message-ID: <1456761113-8416-1-git-send-email-m-karicheri2@ti.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Recent update to pcie-designware core driver, 
'commit cbce7900598c ("PCI: designware: Make driver arch-agnostic")'
broke the keystone PCI driver. After this commit, we see a kernel crash on
Keystone SoC as shown below in the boot log. This is because, the way pp
struct ptr is retrieved from  msi desc has changed and require similar
update in pci-keystone-dw.c as well. This patch fixes this issue. 

[    1.012999] pci 0000:00:00.0: PCI bridge to [bus 01]
[    1.018073] pci 0000:00:00.0:   bridge window [io  0x1000-0x1fff]
[    1.024308] pci 0000:00:00.0:   bridge window [mem 0x60000000-0x600fffff]
[    1.031216] pci 0000:00:00.0:   bridge window [mem 0x60100000-0x601fffff
pref]
[    1.038736] Unable to handle kernel NULL pointer dereference at virtual
address 00000030
[    1.046950] pgd = c0003000
[    1.049750] [00000030] *pgd=80000800004003, *pmd=00000000
[    1.055265] Internal error: Oops: 206 [#1] PREEMPT SMP ARM
[    1.060860] Modules linked in:
[    1.064013] CPU: 0 PID: 1 Comm: swapper/0 Not tainted 4.4.2-00139-gb74f926 #2
[    1.071266] Hardware name: Keystone
[    1.074853] task: eb888000 ti: eb890000 task.ti: eb890000
[    1.080364] PC is at ks_dw_pcie_msi_irq_unmask+0x24/0x58
[    1.085785] LR is at ks_dw_pcie_msi_irq_unmask+0x18/0x58
[    1.091206] pc : [<c02f65c8>]    lr : [<c02f65bc>]    psr: 60000093
[    1.091206] sp : eb891bc8  ip : 00000000  fp : ebb15010
[    1.102915] r10: 00000051  r9 : 60000013  r8 : ebafaa20
[    1.108247] r7 : ebaa9f80  r6 : eb9fd0c0  r5 : ebafa9d0  r4 : ebafa9c0
[    1.114889] r3 : 00000051  r2 : 00000000  r1 : 00000001  r0 : ebb14c18
[    1.121533] Flags: nZCv  IRQs off  FIQs on  Mode SVC_32  ISA ARM  Segment
kernel
[    1.129049] Control: 30c5387d  Table: 00003000  DAC: fffffffd
[    1.134905] Process swapper/0 (pid: 1, stack limit = 0xeb890210)
[    1.141023] Stack: (0xeb891bc8 to 0xeb892000)

Cc: Bjorn Helgaas <bhelgaas@google.com>
Cc: <stable@vger.kernel.org> # 4.4.x
Signed-off-by: Murali Karicheri <m-karicheri2@ti.com>
---
 v2 - Looks like I missed the fix version format for stable.
      Fixed it per best of my knowledge.
 v1 - Resending as per stable submission procedure
 drivers/pci/host/pci-keystone-dw.c | 11 +++--------
 1 file changed, 3 insertions(+), 8 deletions(-)

diff --git a/drivers/pci/host/pci-keystone-dw.c b/drivers/pci/host/pci-keystone-dw.c
index ed34c95..6153853 100644
--- a/drivers/pci/host/pci-keystone-dw.c
+++ b/drivers/pci/host/pci-keystone-dw.c
@@ -58,11 +58,6 @@
 
 #define to_keystone_pcie(x)	container_of(x, struct keystone_pcie, pp)
 
-static inline struct pcie_port *sys_to_pcie(struct pci_sys_data *sys)
-{
-	return sys->private_data;
-}
-
 static inline void update_reg_offset_bit_pos(u32 offset, u32 *reg_offset,
 					     u32 *bit_pos)
 {
@@ -108,7 +103,7 @@ static void ks_dw_pcie_msi_irq_ack(struct irq_data *d)
 	struct pcie_port *pp;
 
 	msi = irq_data_get_msi_desc(d);
-	pp = sys_to_pcie(msi_desc_to_pci_sysdata(msi));
+	pp = (struct pcie_port *) msi_desc_to_pci_sysdata(msi);
 	ks_pcie = to_keystone_pcie(pp);
 	offset = d->irq - irq_linear_revmap(pp->irq_domain, 0);
 	update_reg_offset_bit_pos(offset, &reg_offset, &bit_pos);
@@ -146,7 +141,7 @@ static void ks_dw_pcie_msi_irq_mask(struct irq_data *d)
 	u32 offset;
 
 	msi = irq_data_get_msi_desc(d);
-	pp = sys_to_pcie(msi_desc_to_pci_sysdata(msi));
+	pp = (struct pcie_port *) msi_desc_to_pci_sysdata(msi);
 	ks_pcie = to_keystone_pcie(pp);
 	offset = d->irq - irq_linear_revmap(pp->irq_domain, 0);
 
@@ -167,7 +162,7 @@ static void ks_dw_pcie_msi_irq_unmask(struct irq_data *d)
 	u32 offset;
 
 	msi = irq_data_get_msi_desc(d);
-	pp = sys_to_pcie(msi_desc_to_pci_sysdata(msi));
+	pp = (struct pcie_port *) msi_desc_to_pci_sysdata(msi);
 	ks_pcie = to_keystone_pcie(pp);
 	offset = d->irq - irq_linear_revmap(pp->irq_domain, 0);
 
-- 
1.9.1

