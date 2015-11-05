Return-Path: <linux-kernel-owner@vger.kernel.org>
From: Grygorii Strashko <grygorii.strashko@ti.com>
To: Kishon Vijay Abraham I <kishon@ti.com>,
	Bjorn Helgaas <bhelgaas@google.com>
CC: <tony@atomide.com>, <nsekhar@ti.com>, <linux-omap@vger.kernel.org>,
	<linux-pci@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	Grygorii Strashko <grygorii.strashko@ti.com>,
	Thomas Gleixner <tglx@linutronix.de>,
	Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Subject: [PATCH] PCI: dra7xx: mark dra7xx_pcie_msi irq as IRQF_NO_THREAD
Date: Thu, 5 Nov 2015 20:43:10 +0200
Message-ID: <1446748990-27722-1-git-send-email-grygorii.strashko@ti.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On -RT, TI DRA7 PCIe driver always produces below backtrace when the
first PCI interrupt is triggered:

------------[ cut here ]------------
WARNING: CPU: 1 PID: 82 at kernel/irq/handle.c:150 handle_irq_event_percpu+0x14c/0x174()
irq 460 handler irq_default_primary_handler+0x0/0x14 enabled interrupts
Modules linked in: ahci_platform(+) ti_vip(+) libahci_platform xhci_pci(+) c_can_platform(+)
libahci xhci_hcd ti_vpe c_can libata v4l2_mem2mem can_dev gpio_keys leds_gpio
snd_soc_simple_card usbcore spi_ti_qspi videobuf2_core extcon_usb_gpio omap_wdt
ti_vpdma videobuf2_dma_contig ti_soc_thermal videobuf2_memops dwc3_omap extcon
rtc_omap ov1063x v4l2_common videodev media snd_soc_tlv320aic3x omap_rng rng_core omap_remoteproc
CPU: 1 PID: 82 Comm: irq/26-dra7-pci Not tainted 4.1.10-rt10-02638-g6486d7e-dirty #1
Hardware name: Generic DRA74X (Flattened Device Tree)
Backtrace:
[<c0013060>] (dump_backtrace) from [<c0013280>] (show_stack+0x18/0x1c)
 r7:c07acca0 r6:00000000 r5:c09034e4 r4:00000000
[<c0013268>] (show_stack) from [<c061ef14>] (dump_stack+0x90/0xac)
[<c061ee84>] (dump_stack) from [<c00436e4>] (warn_slowpath_common+0x7c/0xb8)
 r7:c07acca0 r6:00000096 r5:00000009 r4:ee4d3e38
[<c0043668>] (warn_slowpath_common) from [<c0043758>] (warn_slowpath_fmt+0x38/0x40)
 r8:ee3fcc00 r7:000001cc r6:00000000 r5:00000002 r4:c07acc78
[<c0043724>] (warn_slowpath_fmt) from [<c0085fd0>] (handle_irq_event_percpu+0x14c/0x174)
 r3:000001cc r2:c07acc78
 r4:ecfcdd80
[<c0085e84>] (handle_irq_event_percpu) from [<c008607c>] (handle_irq_event+0x84/0xb8)
 r10:00000001 r9:ee4b59c0 r8:ee1d0900 r7:00000001 r6:00000000 r5:ecfcdd80
 r4:ee3fcc00
[<c0085ff8>] (handle_irq_event) from [<c0089240>] (handle_simple_irq+0x90/0x118)
 r5:ee4a9020 r4:ee3fcc00
[<c00891b0>] (handle_simple_irq) from [<c0085514>] (generic_handle_irq+0x30/0x44)
 r5:ee4a9020 r4:000001cc
[<c00854e4>] (generic_handle_irq) from [<c034a7d4>] (dra7xx_pcie_msi_irq_handler+0x7c/0x8c)
 r5:ee4a9020 r4:00000001
[<c034a758>] (dra7xx_pcie_msi_irq_handler) from [<c0086f08>] (irq_forced_thread_fn+0x28/0x5c)
 r5:ee1d0900 r4:ee4b59c0
[<c0086ee0>] (irq_forced_thread_fn) from [<c00871dc>] (irq_thread+0x128/0x204)
 r7:00000001 r6:00000000 r5:ee4d2000 r4:ee4b59e4
[<c00870b4>] (irq_thread) from [<c005e2fc>] (kthread+0xd4/0xec)
 r10:00000000 r9:00000000 r8:00000000 r7:c00870b4 r6:ee4b59c0 r5:ee4b5a00
 r4:00000000
[<c005e228>] (kthread) from [<c000faa8>] (ret_from_fork+0x14/0x2c)
 r7:00000000 r6:00000000 r5:c005e228 r4:ee4b5a00
---[ end trace 0000000000000002 ]---

This backtrace is triggered because dra7xx_pcie_msi_irq_handler()
forced to be threaded by default on -RT but, in the same time, it's
IRQ dispatcher and calls generic_handle_irq(), which leads to
handle_simple_irq() call. The handle_simple_irq() expected to be
called with IRQ disabled.

The same issue will also happen if kernel will boot with "threadirqs"
cmdline parameter (CONFIG_IRQ_FORCED_THREADING).

As discussed in [1], the current DRA7 PCIe hw configuration supports
32 interrupts, which cannot change because it's hardwired in silicon,
this is a single status read and assuming that only a few (most of the
time it will be exactly ONE) of those interrupts are pending at the
same time is pretty much a sane assumption. And recommended fix for
this issue is to request dra7xx_pcie_msi IRQ with IRQF_NO_THREAD flag.

[1] https://lkml.org/lkml/2015/11/3/660

Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Signed-off-by: Grygorii Strashko <grygorii.strashko@ti.com>
---
 drivers/pci/host/pci-dra7xx.c | 24 +++++++++++++++++++++++-
 1 file changed, 23 insertions(+), 1 deletion(-)

diff --git a/drivers/pci/host/pci-dra7xx.c b/drivers/pci/host/pci-dra7xx.c
index 6589e7e..31460f4 100644
--- a/drivers/pci/host/pci-dra7xx.c
+++ b/drivers/pci/host/pci-dra7xx.c
@@ -302,8 +302,30 @@ static int __init dra7xx_add_pcie_port(struct dra7xx_pcie *dra7xx,
 		return -EINVAL;
 	}
 
+	/*
+	 * Mark dra7xx_pcie_msi IRQ as IRQF_NO_THREAD
+	 * On -RT and if kernel is booting with "threadirqs" cmd line parameter
+	 * the dra7xx_pcie_msi_irq_handler() will be forced threaded but,
+	 * in the same time, it's IRQ dispatcher and calls generic_handle_irq(),
+	 * which, in turn, will be resolved to handle_simple_irq() call.
+	 * The handle_simple_irq() expected to be called with IRQ disabled, as
+	 * result kernle will display warning:
+	 * "irq XXX handler YYY+0x0/0x14 enabled interrupts".
+	 *
+	 * Current DRA7 PCIe hw configuration supports 32 interrupts,
+	 * which cannot change because it's hardwired in silicon, and can assume
+	 * that only a few (most of the time it will be exactly ONE) of those
+	 * interrupts are pending at the same time. So, It's sane way to dial
+	 * with above issue by marking dra7xx_pcie_msi IRQ as IRQF_NO_THREAD.
+	 * if some platform will utilize a lot of MSI IRQs and will suffer
+	 * form -RT latencies degradation because of that - IRQF_NO_THREAD can
+	 * be removed and "Warning Annihilation" W/A can be applied [1]
+	 *
+	 * [1] https://lkml.org/lkml/2015/11/2/578
+	 */
 	ret = devm_request_irq(&pdev->dev, pp->irq,
-			       dra7xx_pcie_msi_irq_handler, IRQF_SHARED,
+			       dra7xx_pcie_msi_irq_handler,
+			       IRQF_SHARED | IRQF_NO_THREAD,
 			       "dra7-pcie-msi",	pp);
 	if (ret) {
 		dev_err(&pdev->dev, "failed to request irq\n");
-- 
2.6.2

