Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from smtp.codeaurora.org ([198.145.29.96]:49090 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751197AbdK0GUs (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 27 Nov 2017 01:20:48 -0500
From: Sinan Kaya <okaya@codeaurora.org>
To: linux-pci@vger.kernel.org, timur@codeaurora.org
Cc: linux-arm-msm@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        Sinan Kaya <okaya@codeaurora.org>,
        Jonathan Corbet <corbet@lwn.net>,
        Bjorn Helgaas <bhelgaas@google.com>,
        "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@kernel.org>,
        Christoffer Dall <cdall@linaro.org>,
        Mimi Zohar <zohar@linux.vnet.ibm.com>,
        Marc Zyngier <marc.zyngier@arm.com>,
        Ding Tianhong <dingtianhong@huawei.com>,
        Michal Hocko <mhocko@suse.com>,
        linux-doc@vger.kernel.org (open list:DOCUMENTATION),
        linux-kernel@vger.kernel.org (open list)
Subject: [PATCH V2 7/7] PCI: make reset poll time adjustable
Date: Mon, 27 Nov 2017 01:20:28 -0500
Message-Id: <1511763628-11856-8-git-send-email-okaya@codeaurora.org>
In-Reply-To: <1511763628-11856-1-git-send-email-okaya@codeaurora.org>
References: <1511763628-11856-1-git-send-email-okaya@codeaurora.org>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Introduce pci=resetpolltime= argument to override 60 seconds poll time in
units of milliseconds.

Signed-off-by: Sinan Kaya <okaya@codeaurora.org>
---
 Documentation/admin-guide/kernel-parameters.txt |  2 ++
 drivers/pci/pci.c                               | 13 ++++++++-----
 2 files changed, 10 insertions(+), 5 deletions(-)

diff --git a/Documentation/admin-guide/kernel-parameters.txt b/Documentation/admin-guide/kernel-parameters.txt
index 0549662..a07d4f5 100644
--- a/Documentation/admin-guide/kernel-parameters.txt
+++ b/Documentation/admin-guide/kernel-parameters.txt
@@ -3071,6 +3071,8 @@
 		pcie_scan_all	Scan all possible PCIe devices.  Otherwise we
 				only look for one device below a PCIe downstream
 				port.
+		resetpolltime=	Adjusts the default poll time following hot reset
+				and D3->D0 transition.
 
 	pcie_aspm=	[PCIE] Forcibly enable or disable PCIe Active State Power
 			Management.
diff --git a/drivers/pci/pci.c b/drivers/pci/pci.c
index 8472c24..a6c3e25 100644
--- a/drivers/pci/pci.c
+++ b/drivers/pci/pci.c
@@ -127,7 +127,7 @@ static int __init pcie_port_pm_setup(char *str)
 
 /* time to wait after a reset for device to become responsive */
 #define PCIE_RESET_READY_POLL_MS 60000
-
+static unsigned long pci_reset_polltime = PCIE_RESET_READY_POLL_MS;
 /**
  * pci_bus_max_busnr - returns maximum PCI bus number of given bus' children
  * @bus: pointer to PCI bus structure to search
@@ -3904,7 +3904,7 @@ int pcie_flr(struct pci_dev *dev)
 	 */
 	msleep(100);
 
-	return pci_dev_wait(dev, "FLR", PCIE_RESET_READY_POLL_MS);
+	return pci_dev_wait(dev, "FLR", pci_reset_polltime);
 }
 EXPORT_SYMBOL_GPL(pcie_flr);
 
@@ -3945,7 +3945,7 @@ static int pci_af_flr(struct pci_dev *dev, int probe)
 	 */
 	msleep(100);
 
-	return pci_dev_wait(dev, "AF_FLR", PCIE_RESET_READY_POLL_MS);
+	return pci_dev_wait(dev, "AF_FLR", pci_reset_polltime);
 }
 
 /**
@@ -3990,7 +3990,7 @@ static int pci_pm_reset(struct pci_dev *dev, int probe)
 	pci_write_config_word(dev, dev->pm_cap + PCI_PM_CTRL, csr);
 	pci_dev_d3_sleep(dev);
 
-	return pci_dev_wait(dev, "PM D3->D0", PCIE_RESET_READY_POLL_MS);
+	return pci_dev_wait(dev, "PM D3->D0", pci_reset_polltime);
 }
 
 void pci_reset_secondary_bus(struct pci_dev *dev)
@@ -4035,7 +4035,7 @@ int pci_reset_bridge_secondary_bus(struct pci_dev *dev)
 {
 	pcibios_reset_secondary_bus(dev);
 
-	return pci_dev_wait(dev, "bus reset", PCIE_RESET_READY_POLL_MS);
+	return pci_dev_wait(dev, "bus reset", pci_reset_polltime);
 }
 EXPORT_SYMBOL_GPL(pci_reset_bridge_secondary_bus);
 
@@ -5528,6 +5528,9 @@ static int __init pci_setup(char *str)
 				pcie_bus_config = PCIE_BUS_PEER2PEER;
 			} else if (!strncmp(str, "pcie_scan_all", 13)) {
 				pci_add_flags(PCI_SCAN_ALL_PCIE_DEVS);
+			} else if (!strncmp(str, "resetpolltime=", 14)) {
+				pci_reset_polltime =
+					simple_strtoul(str + 14, &str, 0);
 			} else {
 				printk(KERN_ERR "PCI: Unknown option `%s'\n",
 						str);
-- 
1.9.1
