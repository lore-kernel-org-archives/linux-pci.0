Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.99]:47576 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751732AbeAZVcx (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Fri, 26 Jan 2018 16:32:53 -0500
Subject: [PATCH 3/4] PCI: Add SPDX GPL-2.0 to replace COPYING boilerplate
From: Bjorn Helgaas <helgaas@kernel.org>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Kate Stewart <kstewart@linuxfoundation.org>,
        linux-pci@vger.kernel.org, Thomas Gleixner <tglx@linutronix.de>,
        linux-kernel@vger.kernel.org,
        Philippe Ombredanne <pombredanne@nexb.com>
Date: Fri, 26 Jan 2018 15:32:48 -0600
Message-ID: <20180126213248.31503.63731.stgit@bhelgaas-glaptop.roam.corp.google.com>
In-Reply-To: <20180126212536.31503.43805.stgit@bhelgaas-glaptop.roam.corp.google.com>
References: <20180126212536.31503.43805.stgit@bhelgaas-glaptop.roam.corp.google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

From: Bjorn Helgaas <bhelgaas@google.com>

Add SPDX GPL-2.0 to all PCI files that referred to the kernel default
"COPYING" file, which specifies GPL version 2.

Remove the boilerplate language referring to the GPL and "COPYING", relying
on the assertion in b24413180f56 ("License cleanup: add SPDX GPL-2.0
license identifier to files with no license") that the SPDX identifier may
be used instead of the full boilerplate text.

Signed-off-by: Bjorn Helgaas <bhelgaas@google.com>
---
 drivers/pci/host/pci-thunder-ecam.c    |    5 +----
 drivers/pci/hotplug/sgi_hotplug.c      |    5 +----
 drivers/pci/pcie/aer/aerdrv.c          |    5 +----
 drivers/pci/pcie/aer/aerdrv_core.c     |    5 +----
 drivers/pci/pcie/aer/aerdrv_errprint.c |    5 +----
 drivers/pci/pcie/pcie-dpc.c            |    5 +----
 6 files changed, 6 insertions(+), 24 deletions(-)

diff --git a/drivers/pci/host/pci-thunder-ecam.c b/drivers/pci/host/pci-thunder-ecam.c
index fc0ca03f280e..32d1d7b81ef4 100644
--- a/drivers/pci/host/pci-thunder-ecam.c
+++ b/drivers/pci/host/pci-thunder-ecam.c
@@ -1,8 +1,5 @@
+// SPDX-License-Identifier: GPL-2.0
 /*
- * This file is subject to the terms and conditions of the GNU General Public
- * License.  See the file "COPYING" in the main directory of this archive
- * for more details.
- *
  * Copyright (C) 2015, 2016 Cavium, Inc.
  */
 
diff --git a/drivers/pci/hotplug/sgi_hotplug.c b/drivers/pci/hotplug/sgi_hotplug.c
index 339bce0403dd..42d713578524 100644
--- a/drivers/pci/hotplug/sgi_hotplug.c
+++ b/drivers/pci/hotplug/sgi_hotplug.c
@@ -1,8 +1,5 @@
+// SPDX-License-Identifier: GPL-2.0
 /*
- * This file is subject to the terms and conditions of the GNU General Public
- * License.  See the file "COPYING" in the main directory of this archive
- * for more details.
- *
  * Copyright (C) 2005-2006 Silicon Graphics, Inc. All rights reserved.
  *
  * This work was based on the 2.4/2.6 kernel development by Dick Reigner.
diff --git a/drivers/pci/pcie/aer/aerdrv.c b/drivers/pci/pcie/aer/aerdrv.c
index 6ff5f5b4f5e6..3f8c58f897f0 100644
--- a/drivers/pci/pcie/aer/aerdrv.c
+++ b/drivers/pci/pcie/aer/aerdrv.c
@@ -1,10 +1,7 @@
+// SPDX-License-Identifier: GPL-2.0
 /*
  * drivers/pci/pcie/aer/aerdrv.c
  *
- * This file is subject to the terms and conditions of the GNU General Public
- * License.  See the file "COPYING" in the main directory of this archive
- * for more details.
- *
  * This file implements the AER root port service driver. The driver will
  * register an irq handler. When root port triggers an AER interrupt, the irq
  * handler will collect root port status and schedule a work.
diff --git a/drivers/pci/pcie/aer/aerdrv_core.c b/drivers/pci/pcie/aer/aerdrv_core.c
index 744805232155..df45383c35f7 100644
--- a/drivers/pci/pcie/aer/aerdrv_core.c
+++ b/drivers/pci/pcie/aer/aerdrv_core.c
@@ -1,10 +1,7 @@
+// SPDX-License-Identifier: GPL-2.0
 /*
  * drivers/pci/pcie/aer/aerdrv_core.c
  *
- * This file is subject to the terms and conditions of the GNU General Public
- * License.  See the file "COPYING" in the main directory of this archive
- * for more details.
- *
  * This file implements the core part of PCIe AER. When a PCIe
  * error is delivered, an error message will be collected and printed to
  * console, then, an error recovery procedure will be executed by following
diff --git a/drivers/pci/pcie/aer/aerdrv_errprint.c b/drivers/pci/pcie/aer/aerdrv_errprint.c
index 54c4b691e51f..1f0456f802af 100644
--- a/drivers/pci/pcie/aer/aerdrv_errprint.c
+++ b/drivers/pci/pcie/aer/aerdrv_errprint.c
@@ -1,10 +1,7 @@
+// SPDX-License-Identifier: GPL-2.0
 /*
  * drivers/pci/pcie/aer/aerdrv_errprint.c
  *
- * This file is subject to the terms and conditions of the GNU General Public
- * License.  See the file "COPYING" in the main directory of this archive
- * for more details.
- *
  * Format error messages and print them to console.
  *
  * Copyright (C) 2006 Intel Corp.
diff --git a/drivers/pci/pcie/pcie-dpc.c b/drivers/pci/pcie/pcie-dpc.c
index 2d976a623ddc..d1fb5cf9379e 100644
--- a/drivers/pci/pcie/pcie-dpc.c
+++ b/drivers/pci/pcie/pcie-dpc.c
@@ -1,12 +1,9 @@
+// SPDX-License-Identifier: GPL-2.0
 /*
  * PCI Express Downstream Port Containment services driver
  * Author: Keith Busch <keith.busch@intel.com>
  *
  * Copyright (C) 2016 Intel Corp.
- *
- * This file is subject to the terms and conditions of the GNU General Public
- * License.  See the file "COPYING" in the main directory of this archive
- * for more details.
  */
 
 #include <linux/delay.h>
