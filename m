Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-vc0-f202.google.com ([209.85.220.202]:60108 "EHLO
	mail-vc0-f202.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758631Ab2FUAQk (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Wed, 20 Jun 2012 20:16:40 -0400
Received: by vcbfl13 with SMTP id fl13so9372vcb.1
        for <linux-pci@vger.kernel.org>; Wed, 20 Jun 2012 17:16:40 -0700 (PDT)
Received: from bhelgaas.mtv.corp.google.com (bhelgaas.mtv.corp.google.com [172.18.96.155])
	by wpzn4.hot.corp.google.com (Postfix) with ESMTP id 117751E0043
	for <linux-pci@vger.kernel.org>; Wed, 20 Jun 2012 17:16:39 -0700 (PDT)
Received: from bhelgaas.mtv.corp.google.com (unknown [IPv6:::1])
	by bhelgaas.mtv.corp.google.com (Postfix) with ESMTP id C349B180181
	for <linux-pci@vger.kernel.org>; Wed, 20 Jun 2012 17:16:38 -0700 (PDT)
Subject: [PATCH 1/6] PCI: use __weak consistently
To: linux-pci@vger.kernel.org
From: Bjorn Helgaas <bhelgaas@google.com>
Date: Wed, 20 Jun 2012 18:16:38 -0600
Message-ID: <20120621001638.4834.10145.stgit@bhelgaas.mtv.corp.google.com>
In-Reply-To: <20120621000840.4834.26832.stgit@bhelgaas.mtv.corp.google.com>
References: <20120621000840.4834.26832.stgit@bhelgaas.mtv.corp.google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Use "__weak" instead of the gcc-specific "__attribute__ ((weak))"

Signed-off-by: Bjorn Helgaas <bhelgaas@google.com>
---
 drivers/pci/pci-sysfs.c |    2 +-
 drivers/pci/pci.c       |    8 ++++----
 2 files changed, 5 insertions(+), 5 deletions(-)

diff --git a/drivers/pci/pci-sysfs.c b/drivers/pci/pci-sysfs.c
index 86c63fe..a0b435f 100644
--- a/drivers/pci/pci-sysfs.c
+++ b/drivers/pci/pci-sysfs.c
@@ -1112,7 +1112,7 @@ static struct bin_attribute pcie_config_attr = {
 	.write = pci_write_config,
 };
 
-int __attribute__ ((weak)) pcibios_add_platform_entries(struct pci_dev *dev)
+int __weak pcibios_add_platform_entries(struct pci_dev *dev)
 {
 	return 0;
 }
diff --git a/drivers/pci/pci.c b/drivers/pci/pci.c
index 447e834..8f4a5ea 100644
--- a/drivers/pci/pci.c
+++ b/drivers/pci/pci.c
@@ -1349,7 +1349,7 @@ void pcim_pin_device(struct pci_dev *pdev)
  * is the default implementation. Architecture implementations can
  * override this.
  */
-void __attribute__ ((weak)) pcibios_disable_device (struct pci_dev *dev) {}
+void __weak pcibios_disable_device (struct pci_dev *dev) {}
 
 static void do_pci_disable_device(struct pci_dev *dev)
 {
@@ -1413,8 +1413,8 @@ pci_disable_device(struct pci_dev *dev)
  * Sets the PCIe reset state for the device. This is the default
  * implementation. Architecture implementations can override this.
  */
-int __attribute__ ((weak)) pcibios_set_pcie_reset_state(struct pci_dev *dev,
-							enum pcie_reset_state state)
+int __weak pcibios_set_pcie_reset_state(struct pci_dev *dev,
+					enum pcie_reset_state state)
 {
 	return -EINVAL;
 }
@@ -3851,7 +3851,7 @@ static void __devinit pci_no_domains(void)
  * greater than 0xff). This is the default implementation. Architecture
  * implementations can override this.
  */
-int __attribute__ ((weak)) pci_ext_cfg_avail(struct pci_dev *dev)
+int __weak pci_ext_cfg_avail(struct pci_dev *dev)
 {
 	return 1;
 }

