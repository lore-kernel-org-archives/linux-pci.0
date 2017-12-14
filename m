Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail1.windriver.com ([147.11.146.13]:50282 "EHLO
        mail1.windriver.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751101AbdLNCWW (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 13 Dec 2017 21:22:22 -0500
From: <cao.zou@windriver.com>
To: <jingoohan1@gmail.com>
CC: <Joao.Pinto@synopsys.com>, <bhelgaas@google.com>,
        <linux-pci@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: [PATCH] PCI: designware: add a check of msi_desc in irqchip
Date: Thu, 14 Dec 2017 10:21:23 +0800
Message-ID: <1513218083-5461-2-git-send-email-cao.zou@windriver.com>
In-Reply-To: <1513218083-5461-1-git-send-email-cao.zou@windriver.com>
References: <1513218083-5461-1-git-send-email-cao.zou@windriver.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

From: Zou Cao <cao.zou@windriver.com>

When PCIE host setup, 32 MSI irq descriptions are created, but its
msi_desc is NULL, msi_desc is bound in MSI irq requested by PCI device,
normally just part of MSI are used, for others not used MSI irqs, its
msi_desc is NULL, it is dangerous for MSI irq mask when MSI irq mask use
the msi_desc to mask irq without checking, normally not used MSI irqs are
never masked, it looks fine, but in some specified case, such as kdump,
machine_kexec_mask_interrupts will force to mask these not used MSI irqs,
than a crash will happen with NULL msi_desc. it is necessary to add check
of msi_desc in irqchip, if we still bind the msi_desc only in irqs request
and mask MSI irq by msi_desc.

Add dwc_pci_msi_mask/unmask_irq, so we can get a chance to check the
msi_desc.

here is reproduced crash log in IMX7-SABER board with Intel 1030 PCI,
when running kdump by "echo c > /proc/sysrq-trigger":

sysrq: SysRq : Trigger a crash
Unable to handle kernel NULL pointer dereference at virtual address 00000000
pgd = 98ee1839
[00000000] *pgd=00000000
Internal error: Oops: 805 [#1] SMP ARM
Modules linked in:
CPU: 0 PID: 1370 Comm: sh Not tainted 4.15.0-rc3-00033-ga638349 #1
Hardware name: Freescale i.MX7 Dual (Device Tree)
PC is at sysrq_handle_crash+0x50/0x98
LR is at sysrq_handle_crash+0x50/0x98
<snip>
Backtrace:
[<c047a15c>] (msi_set_mask_bit) from [<c047a1f0>] (pci_msi_mask_irq+0x14/0x18)
[<c047a1dc>] (pci_msi_mask_irq) from [<c011142c>] (machine_crash_shutdown+0xd8/0x190)
[<c0111354>] (machine_crash_shutdown) from [<c01b2924>] (__crash_kexec+0x5c/0xa0)
[<c01b28c8>] (__crash_kexec) from [<c01b29dc>] (crash_kexec+0x74/0x80)
[<c01b2968>] (crash_kexec) from [<c010cfa4>] (die+0x220/0x358)
[<c010cd84>] (die) from [<c01169f0>] (__do_kernel_fault.part.0+0x5c/0x7c)
[<c0116994>] (__do_kernel_fault.part.0) from [<c0116784>] (do_page_fault+0x2cc/0x37c)
[<c01164b8>] (do_page_fault) from [<c0116970>] (do_translation_fault+0xb0/0xbc)
[<c01168c0>] (do_translation_fault) from [<c010138c>] (do_DataAbort+0x3c/0xbc)
[<c0101350>] (do_DataAbort) from [<c010d944>] (__dabt_svc+0x64/0xa0)
Exception stack(0xec08bdf8 to 0xec08be40)
bde0:                                                       00000000 ec08be10
be00: 00000000 00000000 00000000 00000001 00000063 00000000 00000007 ec08a000
be20: 00000000 ec08be5c ec08be48 ec08be48 c04c46b8 c04c46b8 60060013 ffffffff
[<c04c4668>] (sysrq_handle_crash) from [<c04c4900>] (__handle_sysrq+0xe0/0x254)
[<c04c4820>] (__handle_sysrq) from [<c04c4aec>] (write_sysrq_trigger+0x78/0x90)
[<c04c4a74>] (write_sysrq_trigger) from [<c029148c>] (proc_reg_write+0x68/0x90)
[<c0291424>] (proc_reg_write) from [<c0229ef8>] (__vfs_write+0x34/0x12c)
[<c0229ec4>] (__vfs_write) from [<c022a16c>] (vfs_write+0xa8/0x16c)
[<c022a0c4>] (vfs_write) from [<c022a340>] (SyS_write+0x44/0x90)
[<c022a2fc>] (SyS_write) from [<c0108220>] (ret_fast_syscall+0x0/0x28)

Signed-off-by: Zou Cao <cao.zou@windriver.com>
---
 drivers/pci/dwc/pcie-designware-host.c | 24 ++++++++++++++++++++----
 1 file changed, 20 insertions(+), 4 deletions(-)

diff --git a/drivers/pci/dwc/pcie-designware-host.c b/drivers/pci/dwc/pcie-designware-host.c
index 81e2157..485c4df 100644
--- a/drivers/pci/dwc/pcie-designware-host.c
+++ b/drivers/pci/dwc/pcie-designware-host.c
@@ -45,12 +45,28 @@ static int dw_pcie_wr_own_conf(struct pcie_port *pp, int where, int size,
 	return dw_pcie_write(pci->dbi_base + where, size, val);
 }
 
+static void dwc_pci_msi_mask_irq(struct irq_data *data)
+{
+	struct msi_desc *desc = irq_data_get_msi_desc(data);
+
+	if (desc)
+		pci_msi_mask_irq(data);
+}
+
+static void dwc_pci_msi_unmask_irq(struct irq_data *data)
+{
+	struct msi_desc *desc = irq_data_get_msi_desc(data);
+
+	if (desc)
+		pci_msi_unmask_irq(data);
+}
+
 static struct irq_chip dw_msi_irq_chip = {
 	.name = "PCI-MSI",
-	.irq_enable = pci_msi_unmask_irq,
-	.irq_disable = pci_msi_mask_irq,
-	.irq_mask = pci_msi_mask_irq,
-	.irq_unmask = pci_msi_unmask_irq,
+	.irq_enable = dwc_pci_msi_unmask_irq,
+	.irq_disable = dwc_pci_msi_mask_irq,
+	.irq_mask = dwc_pci_msi_mask_irq,
+	.irq_unmask = dwc_pci_msi_unmask_irq,
 };
 
 /* MSI int handler */
-- 
1.9.1
