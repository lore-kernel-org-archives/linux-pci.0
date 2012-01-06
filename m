Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:34489 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1758790Ab2AFREZ (ORCPT <rfc822;linux-pci@vger.kernel.org>);
	Fri, 6 Jan 2012 12:04:25 -0500
Date: Fri, 6 Jan 2012 12:04:22 -0500
From: MUNEDA Takahiro <muneda.takahiro@jp.fujitsu.com>
To: linux-pci@vger.kernel.org
Cc: MUNEDA Takahiro <muneda.takahiro@jp.fujitsu.com>
Message-Id: <20120106170422.17595.31912.sendpatchset@dhcp-189-101.bos.redhat.com>
Subject: [PATCH v2] Add pcie_hp=nomsi to disable MSI for pciehp driver
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Not to use MSI/MSI-X for pciehp, add a kernel parameter, pcie_hp=nomsi.

In my environment, while shutting down, following stack trace is shown
sometimes.

  irq 16: nobody cared (try booting with the "irqpoll" option)
  Pid: 1081, comm: reboot Not tainted 3.2.0 #1
  Call Trace:
   <IRQ>  [<ffffffff810cec1d>] __report_bad_irq+0x3d/0xe0
   [<ffffffff810cee1c>] note_interrupt+0x15c/0x210
   [<ffffffff810cc485>] handle_irq_event_percpu+0xb5/0x210
   [<ffffffff810cc621>] handle_irq_event+0x41/0x70
   [<ffffffff810cf675>] handle_fasteoi_irq+0x55/0xc0
   [<ffffffff81015356>] handle_irq+0x46/0xb0
   [<ffffffff814fbe9d>] do_IRQ+0x5d/0xe0
   [<ffffffff814f146e>] common_interrupt+0x6e/0x6e
   [<ffffffff8106b040>] ? __do_softirq+0x60/0x210
   [<ffffffff8108aeb1>] ? hrtimer_interrupt+0x151/0x240
   [<ffffffff814fb5ec>] call_softirq+0x1c/0x30
   [<ffffffff810152d5>] do_softirq+0x65/0xa0
   [<ffffffff8106ae9d>] irq_exit+0xbd/0xe0
   [<ffffffff814fbf8e>] smp_apic_timer_interrupt+0x6e/0x99
   [<ffffffff814f9e5e>] apic_timer_interrupt+0x6e/0x80
   <EOI>  [<ffffffff814f0fb1>] ? _raw_spin_unlock_irqrestore+0x11/0x20
   [<ffffffff812629fc>] pci_bus_write_config_word+0x6c/0x80
   [<ffffffff81266fc2>] pci_intx+0x52/0xa0
   [<ffffffff8127de3d>] pci_intx_for_msi+0x1d/0x30
  [<ffffffff8127e4fb>] pci_msi_shutdown+0x7b/0x110
   [<ffffffff81269d34>] pci_device_shutdown+0x34/0x50
   [<ffffffff81326c4f>] device_shutdown+0x2f/0x140
   [<ffffffff8107b981>] kernel_restart_prepare+0x31/0x40
   [<ffffffff8107b9e6>] kernel_restart+0x16/0x60
   [<ffffffff8107bbfd>] sys_reboot+0x1ad/0x220
   [<ffffffff814f4b90>] ? do_page_fault+0x1e0/0x460
   [<ffffffff811942d0>] ? __sync_filesystem+0x90/0x90
   [<ffffffff8105c9aa>] ? __cond_resched+0x2a/0x40
   [<ffffffff814ef090>] ? _cond_resched+0x30/0x40
   [<ffffffff81169e17>] ? iterate_supers+0xb7/0xd0
   [<ffffffff814f9382>] system_call_fastpath+0x16/0x1b
  handlers:
  [<ffffffff8138a0f0>] usb_hcd_irq
  [<ffffffff8138a0f0>] usb_hcd_irq
  [<ffffffff8138a0f0>] usb_hcd_irq
  Disabling IRQ #16

An un-wanted interrupt is generated when PCI driver switches from
MSI/MSI-X to INTx while shutting down the device.  The interrupt does
not happen if MSI/MSI-X is not used on the device.
I confirmed that this problem does not happen if pcie_hp=nomsi was
specified and hotplug operation worked fine as usual.

v2: Automatically disable MSI/MSI-X against following device:
    PCI bridge: Integrated Device Technology, Inc. Device 807f (rev 02)

Signed-off-by: MUNEDA Takahiro <muneda.takahiro@jp.fujitsu.com>

---
 Documentation/kernel-parameters.txt |    4 ++++
 drivers/pci/hotplug/pciehp_core.c   |   12 ++++++++++++
 drivers/pci/pcie/portdrv.h          |   12 ++++++++++++
 drivers/pci/pcie/portdrv_core.c     |   16 ++++++++++++++--
 4 files changed, 42 insertions(+), 2 deletions(-)

Index: linux-3.2/drivers/pci/hotplug/pciehp_core.c
===================================================================
--- linux-3.2.orig/drivers/pci/hotplug/pciehp_core.c
+++ linux-3.2/drivers/pci/hotplug/pciehp_core.c
@@ -42,6 +42,7 @@ int pciehp_debug;
 int pciehp_poll_mode;
 int pciehp_poll_time;
 int pciehp_force;
+int pciehp_msi_disabled;
 struct workqueue_struct *pciehp_wq;
 struct workqueue_struct *pciehp_ordered_wq;
 
@@ -57,10 +58,12 @@ module_param(pciehp_debug, bool, 0644);
 module_param(pciehp_poll_mode, bool, 0644);
 module_param(pciehp_poll_time, int, 0644);
 module_param(pciehp_force, bool, 0644);
+module_param(pciehp_msi_disabled, bool, 0644);
 MODULE_PARM_DESC(pciehp_debug, "Debugging mode enabled or not");
 MODULE_PARM_DESC(pciehp_poll_mode, "Using polling mechanism for hot-plug events or not");
 MODULE_PARM_DESC(pciehp_poll_time, "Polling mechanism frequency, in seconds");
 MODULE_PARM_DESC(pciehp_force, "Force pciehp, even if OSHP is missing");
+MODULE_PARM_DESC(pciehp_msi, "MSI/MSI-X enabled or not");
 
 #define PCIE_MODULE_NAME "pciehp"
 
@@ -72,6 +75,15 @@ static int get_attention_status	(struct 
 static int get_latch_status	(struct hotplug_slot *slot, u8 *value);
 static int get_adapter_status	(struct hotplug_slot *slot, u8 *value);
 
+static int __init pciehp_setup(char *str)
+{
+	if (!strncmp(str, "nomsi", 5))
+		pciehp_msi_disabled = true;
+
+	return 1;
+}
+__setup("pcie_hp=", pciehp_setup);
+
 /**
  * release_slot - free up the memory used by a slot
  * @hotplug_slot: slot to free
Index: linux-3.2/drivers/pci/pcie/portdrv.h
===================================================================
--- linux-3.2.orig/drivers/pci/pcie/portdrv.h
+++ linux-3.2/drivers/pci/pcie/portdrv.h
@@ -34,6 +34,18 @@ struct pci_dev;
 
 extern void pcie_clear_root_pme_status(struct pci_dev *dev);
 
+#ifdef CONFIG_HOTPLUG_PCI_PCIE
+extern int pciehp_msi_disabled;
+
+static inline bool pciehp_no_msi(void)
+{
+	return pciehp_msi_disabled;
+}
+
+#else  /* !CONFIG_HOTPLUG_PCI_PCIE */
+static inline bool pciehp_no_msi(void) { return false; }
+#endif /* !CONFIG_HOTPLUG_PCI_PCIE */
+
 #ifdef CONFIG_PCIE_PME
 extern bool pcie_pme_msi_disabled;
 
Index: linux-3.2/drivers/pci/pcie/portdrv_core.c
===================================================================
--- linux-3.2.orig/drivers/pci/pcie/portdrv_core.c
+++ linux-3.2/drivers/pci/pcie/portdrv_core.c
@@ -189,8 +189,20 @@ static int init_service_irqs(struct pci_
 {
 	int i, irq = -1;
 
-	/* We have to use INTx if MSI cannot be used for PCIe PME. */
-	if ((mask & PCIE_PORT_SERVICE_PME) && pcie_pme_no_msi()) {
+	/* We have to use INTx if MSI cannot be used for PCIe PME or pciehp. */
+	if (((mask & PCIE_PORT_SERVICE_PME) && pcie_pme_no_msi()) ||
+	    ((mask & PCIE_PORT_SERVICE_HP) && pciehp_no_msi())) {
+		if (dev->pin)
+			irq = dev->irq;
+		goto no_msi;
+	}
+
+	/*
+	 * Disable MSI/MSI-X to prevent un-wanted interrupts while
+	 * device shutting down
+	 */
+	if ((mask & PCIE_PORT_SERVICE_HP) &&
+	    dev->vendor == PCI_VENDOR_ID_IDT && dev->device == 0x807f) {
 		if (dev->pin)
 			irq = dev->irq;
 		goto no_msi;
Index: linux-3.2/Documentation/kernel-parameters.txt
===================================================================
--- linux-3.2.orig/Documentation/kernel-parameters.txt
+++ linux-3.2/Documentation/kernel-parameters.txt
@@ -2076,6 +2076,10 @@ bytes respectively. Such letter suffixes
 		force	Enable ASPM even on devices that claim not to support it.
 			WARNING: Forcing ASPM on may cause system lockups.
 
+	pcie_hp=	[PCIE] PCI Express Hotplug driver options:
+		nomsi	Do not use MSI for PCI Express Native Hotplug (this
+			makes all PCIe ports use INTx for hotplug services).
+
 	pcie_ports=	[PCIE] PCIe ports handling:
 		auto	Ask the BIOS whether or not to use native PCIe services
 			associated with PCIe ports (PME, hot-plug, AER).  Use
