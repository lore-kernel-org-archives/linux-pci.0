Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mailapp01.imgtec.com ([195.59.15.196]:11851 "EHLO
        mailapp01.imgtec.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751207AbdHFAFI (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Sat, 5 Aug 2017 20:05:08 -0400
From: Paul Burton <paul.burton@imgtec.com>
To: Bjorn Helgaas <bhelgaas@google.com>, <linux-pci@vger.kernel.org>
CC: Bharat Kumar Gogada <bharatku@xilinx.com>,
        Michal Simek <michal.simek@xilinx.com>,
        Ravikiran Gummaluri <rgummal@xilinx.com>,
        <linux-mips@linux-mips.org>, Paul Burton <paul.burton@imgtec.com>
Subject: [PATCH v6 3/6] PCI: xilinx: Translate INTx range to hwirqs 0-3
Date: Sat, 5 Aug 2017 17:03:48 -0700
Message-ID: <20170806000351.17952-4-paul.burton@imgtec.com>
In-Reply-To: <20170806000351.17952-1-paul.burton@imgtec.com>
References: <20170806000351.17952-1-paul.burton@imgtec.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

The pcie-xilinx driver creates an IRQ domain of size 4 for legacy PCI
INTx interrupts, which at first glance seems reasonable since there are
4 possible such interrupts. Unfortunately the driver then proceeds to
use the range 1-4 as the hwirq numbers for INTA-INTD, causing warnings &
broken interrupts when attempting to use INTD/hwirq=4 due to it being
beyond the range of the IRQ domain:

  WARNING: CPU: 0 PID: 1 at kernel/irq/irqdomain.c:365
      irq_domain_associate+0x170/0x220
  error: hwirq 0x4 is too large for dummy
  Modules linked in:
  CPU: 0 PID: 1 Comm: swapper/0 Tainted: G        W
      4.12.0-rc5-00126-g19e1b3a10aad-dirty #427
  Stack : 0000000000000000 0000000000000004 0000000000000006 ffffffff8092c78a
          0000000000000061 ffffffff8018bf60 0000000000000000 0000000000000000
          ffffffff8088c287 ffffffff80811d18 a8000000ffc60000 ffffffff80926678
          0000000000000001 0000000000000000 ffffffff80887880 ffffffff80960000
          ffffffff80920000 ffffffff801e6744 ffffffff80887880 a8000000ffc4f8f8
          000000000000089c ffffffff8018d260 0000000000010000 ffffffff80811d18
          0000000000000000 0000000000000001 0000000000000000 0000000000000000
          0000000000000000 a8000000ffc4f840 0000000000000000 ffffffff8042cf34
          0000000000000000 0000000000000000 0000000000000000 0000000000040c00
          0000000000000000 ffffffff8010d1c8 0000000000000000 ffffffff8042cf34
          ...
  Call Trace:
  [<ffffffff8010d1c8>] show_stack+0x80/0xa0
  [<ffffffff8042cf34>] dump_stack+0xd4/0x110
  [<ffffffff8013ea98>] __warn+0xf0/0x108
  [<ffffffff8013eb14>] warn_slowpath_fmt+0x3c/0x48
  [<ffffffff80196528>] irq_domain_associate+0x170/0x220
  [<ffffffff80196bf0>] irq_create_mapping+0x88/0x118
  [<ffffffff801976a8>] irq_create_fwspec_mapping+0xb8/0x320
  [<ffffffff80197970>] irq_create_of_mapping+0x60/0x70
  [<ffffffff805d1318>] of_irq_parse_and_map_pci+0x20/0x38
  [<ffffffff8049c210>] pci_fixup_irqs+0x60/0xe0
  [<ffffffff8049cd64>] xilinx_pcie_probe+0x28c/0x478
  [<ffffffff804e8ca8>] platform_drv_probe+0x50/0xd0
  [<ffffffff804e73a4>] driver_probe_device+0x2c4/0x3a0
  [<ffffffff804e7544>] __driver_attach+0xc4/0xd0
  [<ffffffff804e5254>] bus_for_each_dev+0x64/0xa8
  [<ffffffff804e5e40>] bus_add_driver+0x1f0/0x268
  [<ffffffff804e8000>] driver_register+0x68/0x118
  [<ffffffff801001a4>] do_one_initcall+0x4c/0x178
  [<ffffffff808d3ca8>] kernel_init_freeable+0x204/0x2b0
  [<ffffffff80730b68>] kernel_init+0x10/0xf8
  [<ffffffff80106218>] ret_from_kernel_thread+0x14/0x1c

Fix this by making use of the new pci_irqd_intx_xlate() helper to
translate the INTx 1-4 range into the 0-3 range suitable for the IRQ
domain of size 4, and stop adding 1 to the hwirq number decoded from the
interrupt FIFO which is already in the range 0-3.

Signed-off-by: Paul Burton <paul.burton@imgtec.com>
Cc: Bharat Kumar Gogada <bharatku@xilinx.com>
Cc: Bjorn Helgaas <bhelgaas@google.com>
Cc: Michal Simek <michal.simek@xilinx.com>
Cc: Ravikiran Gummaluri <rgummal@xilinx.com>
Cc: linux-pci@vger.kernel.org

---

Changes in v6:
- New patch, replacing "PCI: xilinx: Create legacy IRQ domain with size 5".

 drivers/pci/host/pcie-xilinx.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/drivers/pci/host/pcie-xilinx.c b/drivers/pci/host/pcie-xilinx.c
index f63fa5e0278c..83929e6881b2 100644
--- a/drivers/pci/host/pcie-xilinx.c
+++ b/drivers/pci/host/pcie-xilinx.c
@@ -369,6 +369,7 @@ static int xilinx_pcie_intx_map(struct irq_domain *domain, unsigned int irq,
 /* INTx IRQ Domain operations */
 static const struct irq_domain_ops intx_domain_ops = {
 	.map = xilinx_pcie_intx_map,
+	.xlate = pci_irqd_intx_xlate,
 };
 
 /* PCIe HW Functions */
@@ -440,8 +441,8 @@ static irqreturn_t xilinx_pcie_intr_handler(int irq, void *data)
 				   XILINX_PCIE_REG_RPIFR1);
 
 			/* Handle INTx Interrupt */
-			val = ((val & XILINX_PCIE_RPIFR1_INTR_MASK) >>
-				XILINX_PCIE_RPIFR1_INTR_SHIFT) + 1;
+			val = (val & XILINX_PCIE_RPIFR1_INTR_MASK) >>
+				XILINX_PCIE_RPIFR1_INTR_SHIFT;
 			generic_handle_irq(irq_find_mapping(port->leg_domain,
 							    val));
 		}
-- 
2.13.4
