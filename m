Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-eopbgr710085.outbound.protection.outlook.com ([40.107.71.85]:40416
        "EHLO NAM05-BY2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S933995AbeFVQRp (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Fri, 22 Jun 2018 12:17:45 -0400
From: Alan Douglas <adouglas@cadence.com>
To: <bhelgaas@google.com>, <kishon@ti.com>, <lorenzo.pieralisi@arm.com>
CC: <linux-pci@vger.kernel.org>, <shawn.lin@rock-chips.com>,
        Alan Douglas <adouglas@cadence.com>
Subject: [PATCH] PCI: Update Makefile to move Endpoint library before controllers
Date: Fri, 22 Jun 2018 17:17:17 +0100
Message-ID: <1529684237-10424-1-git-send-email-adouglas@cadence.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

The Endpoint library must be initialized before its users, which
are in drivers/pci/controllers

This change corrects a kernel crash when loading the Cadence EP
driver, since it calls devm_pci_epc_create() and this is only
valid once the Endpoint library has been initialized.

Signed-off-by: Alan Douglas <adouglas@cadence.com>
---
 drivers/pci/Makefile |    6 +++---
 1 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/pci/Makefile b/drivers/pci/Makefile
index 5352019..1b2cfe5 100644
--- a/drivers/pci/Makefile
+++ b/drivers/pci/Makefile
@@ -28,10 +28,10 @@ obj-$(CONFIG_PCI_PF_STUB)	+= pci-pf-stub.o
 obj-$(CONFIG_PCI_ECAM)		+= ecam.o
 obj-$(CONFIG_XEN_PCIDEV_FRONTEND) += xen-pcifront.o
 
-obj-y				+= controller/
-obj-y				+= switch/
-
 # Endpoint library must be initialized before its users
 obj-$(CONFIG_PCI_ENDPOINT)	+= endpoint/
 
+obj-y				+= controller/
+obj-y				+= switch/
+
 ccflags-$(CONFIG_PCI_DEBUG) := -DDEBUG
-- 
1.7.1
