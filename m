Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-qk0-f182.google.com ([209.85.220.182]:35190 "EHLO
        mail-qk0-f182.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1755240AbdEHPKJ (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 8 May 2017 11:10:09 -0400
Received: by mail-qk0-f182.google.com with SMTP id a72so38274033qkj.2
        for <linux-pci@vger.kernel.org>; Mon, 08 May 2017 08:10:09 -0700 (PDT)
From: Srinath Mannam <srinath.mannam@broadcom.com>
To: bhelgaas@google.com
Cc: linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
        bcm-kernel-feedback-list@broadcom.com,
        Srinath Mannam <srinath.mannam@broadcom.com>
Subject: [RFC PATCH] pci: Concurrency issue in NVMe Init through PCIe switch
Date: Mon,  8 May 2017 20:39:50 +0530
Message-Id: <1494256190-28993-1-git-send-email-srinath.mannam@broadcom.com>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

We found a concurrency issue in NVMe Init when we initialize
multiple NVMe connected over PCIe switch.

Setup details:
 - SMP system with 8 ARMv8 cores running Linux kernel(4.11).
 - Two NVMe cards are connected to PCIe RC through bridge as shown
   in the below figure.

                   [RC]
                    |
                 [BRIDGE]
                    |
               -----------
              |           |
            [NVMe]      [NVMe]

Issue description:
After PCIe enumeration completed NVMe driver probe function called
for both the devices from two CPUS simultaneously.
>From nvme_probe, pci_enable_device_mem called for both the EPs. This
function called pci_enable_bridge enable recursively until RC.

Inside pci_enable_bridge function, at two places concurrency issue is
observed.

Place 1:
  CPU 0:
    1. Done Atomic increment dev->enable_cnt
       in pci_enable_device_flags
    2. Inside pci_enable_resources
    3. Completed pci_read_config_word(dev, PCI_COMMAND, &cmd)
    4. Ready to set PCI_COMMAND_MEMORY (0x2) in
       pci_write_config_word(dev, PCI_COMMAND, cmd)
  CPU 1:
    1. Check pci_is_enabled in function pci_enable_bridge
       and it is true
    2. Check (!dev->is_busmaster) also true
    3. Gone into pci_set_master
    4. Completed pci_read_config_word(dev, PCI_COMMAND, &old_cmd)
    5. Ready to set PCI_COMMAND_MASTER (0x4) in
       pci_write_config_word(dev, PCI_COMMAND, cmd)

By the time of last point for both the CPUs are read value 0 and
ready to write 2 and 4.
After last point final value in PCI_COMMAND register is 4 instead of 6.

Place 2:
  CPU 0:
    1. Done Atomic increment dev->enable_cnt in
       pci_enable_device_flags
    2. Inside pci_enable_resources
    3. Completed pci_read_config_word(dev, PCI_COMMAND, &cmd)
    4. Ready to set PCI_COMMAND_MEMORY (0x2) in
       pci_write_config_word(dev, PCI_COMMAND, cmd);
  CPU 1:
    1. Done Atomic increment dev->enable_cnt in function
       pci_enable_device_flag fail return 0 from there
    2. Gone into pci_set_master
    3. Completed pci_read_config_word(dev, PCI_COMMAND, &old_cmd)
    4. Ready to set PCI_COMMAND_MASTER (0x4) in
       pci_write_config_word(dev, PCI_COMMAND, cmd)

By the time of last point for both the CPUs are read value 0 and
ready to write 2 and 4.
After last point final value in PCI_COMMAND register is 4 instead of 6.

Signed-off-by: Srinath Mannam <srinath.mannam@broadcom.com>

diff --git a/drivers/pci/pci.c b/drivers/pci/pci.c
index 7904d02..6c5744e 100644
--- a/drivers/pci/pci.c
+++ b/drivers/pci/pci.c
@@ -1345,21 +1345,39 @@ static void pci_enable_bridge(struct pci_dev *dev)
 {
 	struct pci_dev *bridge;
 	int retval;
+	int err;
+	int i;
+	unsigned int bars = 0;
+	unsigned long flags = IORESOURCE_MEM | IORESOURCE_IO;
 
 	bridge = pci_upstream_bridge(dev);
 	if (bridge)
 		pci_enable_bridge(bridge);
 
-	if (pci_is_enabled(dev)) {
-		if (!dev->is_busmaster)
-			pci_set_master(dev);
+	if (dev->pm_cap) {
+		u16 pmcsr;
+
+		pci_read_config_word(dev, dev->pm_cap + PCI_PM_CTRL, &pmcsr);
+		dev->current_state = (pmcsr & PCI_PM_CTRL_STATE_MASK);
+	}
+
+	if (atomic_inc_return(&dev->enable_cnt) > 1)
+		return;		/* already enabled */
+
+	/* only skip sriov related */
+	for (i = 0; i <= PCI_ROM_RESOURCE; i++)
+		if (dev->resource[i].flags & flags)
+			bars |= (1 << i);
+	for (i = PCI_BRIDGE_RESOURCES; i < DEVICE_COUNT_RESOURCE; i++)
+		if (dev->resource[i].flags & flags)
+			bars |= (1 << i);
+
+	err = do_pci_enable_device(dev, bars);
+	if (err < 0) {
+		atomic_dec(&dev->enable_cnt);
 		return;
 	}
 
-	retval = pci_enable_device(dev);
-	if (retval)
-		dev_err(&dev->dev, "Error enabling bridge (%d), continuing\n",
-			retval);
 	pci_set_master(dev);
 }
 
-- 
2.7.4
