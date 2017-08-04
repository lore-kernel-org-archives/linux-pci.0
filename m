Return-Path: <linux-kernel-owner@vger.kernel.org>
From: Srinath Mannam <srinath.mannam@broadcom.com>
To: bhelgaas@google.com
Cc: linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
        bcm-kernel-feedback-list@broadcom.com,
        Srinath Mannam <srinath.mannam@broadcom.com>
Subject: [RFC PATCH v3] pci: Concurrency issue during pci enable bridge
Date: Fri,  4 Aug 2017 20:27:28 +0530
Message-Id: <1501858648-22228-1-git-send-email-srinath.mannam@broadcom.com>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Concurrency issue is observed during pci enable bridge called
for multiple pci devices initialization in SMP system.

Setup details:
 - SMP system with 8 ARMv8 cores running Linux kernel(4.11).
 - Two EPs are connected to PCIe RC through bridge as shown
   in the below figure.

                   [RC]
                    |
                 [BRIDGE]
                    |
               -----------
              |           |
             [EP]        [EP]

Issue description:
After PCIe enumeration completed EP driver probe function called
for both the devices from two CPUS simultaneously.
>From EP probe function, pci_enable_device_mem called for both the EPs.
This function called pci_enable_bridge enable for all the bridges
recursively in the path of EP to RC.

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

Signed-off-by: Srinath Mannam <srinath.mannam@broadcom.com>
---
 drivers/pci/pci.c | 8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)

diff --git a/drivers/pci/pci.c b/drivers/pci/pci.c
index af0cc34..12721df 100644
--- a/drivers/pci/pci.c
+++ b/drivers/pci/pci.c
@@ -52,6 +52,7 @@ static void pci_pme_list_scan(struct work_struct *work);
 static LIST_HEAD(pci_pme_list);
 static DEFINE_MUTEX(pci_pme_list_mutex);
 static DECLARE_DELAYED_WORK(pci_pme_work, pci_pme_list_scan);
+static DEFINE_MUTEX(pci_bridge_mutex);
 
 struct pci_pme_device {
 	struct list_head list;
@@ -1348,10 +1349,11 @@ static void pci_enable_bridge(struct pci_dev *dev)
 	if (bridge)
 		pci_enable_bridge(bridge);
 
+	mutex_lock(&pci_bridge_mutex);
 	if (pci_is_enabled(dev)) {
 		if (!dev->is_busmaster)
 			pci_set_master(dev);
-		return;
+		goto end;
 	}
 
 	retval = pci_enable_device(dev);
@@ -1359,6 +1361,8 @@ static void pci_enable_bridge(struct pci_dev *dev)
 		dev_err(&dev->dev, "Error enabling bridge (%d), continuing\n",
 			retval);
 	pci_set_master(dev);
+end:
+	mutex_unlock(&pci_bridge_mutex);
 }
 
 static int pci_enable_device_flags(struct pci_dev *dev, unsigned long flags)
@@ -1383,7 +1387,7 @@ static int pci_enable_device_flags(struct pci_dev *dev, unsigned long flags)
 		return 0;		/* already enabled */
 
 	bridge = pci_upstream_bridge(dev);
-	if (bridge)
+	if (bridge && !pci_is_enabled(bridge))
 		pci_enable_bridge(bridge);
 
 	/* only skip sriov related */
-- 
2.7.4
