Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.99]:57188 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S932494AbeCMWfl (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Tue, 13 Mar 2018 18:35:41 -0400
Subject: [PATCH v1 2/2] PCI: Tidy comments
From: Bjorn Helgaas <helgaas@kernel.org>
To: linux-pci@vger.kernel.org
Cc: linux-kernel@vger.kernel.org
Date: Tue, 13 Mar 2018 17:35:37 -0500
Message-ID: <152098053765.43178.17961518962767710469.stgit@bhelgaas-glaptop.roam.corp.google.com>
In-Reply-To: <152098048688.43178.2089454526004328425.stgit@bhelgaas-glaptop.roam.corp.google.com>
References: <152098048688.43178.2089454526004328425.stgit@bhelgaas-glaptop.roam.corp.google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

From: Bjorn Helgaas <bhelgaas@google.com>

Remove pointless comments that tell us the file name, remove blank line
comments, follow multi-line comment conventions.  No functional change
intended.

Signed-off-by: Bjorn Helgaas <bhelgaas@google.com>
---
 drivers/pci/access.c                   |   12 +++++++-----
 drivers/pci/ats.c                      |   10 ++++------
 drivers/pci/bus.c                      |    2 --
 drivers/pci/host-bridge.c              |    2 +-
 drivers/pci/iov.c                      |    8 +++-----
 drivers/pci/mmap.c                     |    2 +-
 drivers/pci/msi.c                      |    3 +--
 drivers/pci/pci-acpi.c                 |    3 +--
 drivers/pci/pci-driver.c               |    2 --
 drivers/pci/pci-label.c                |    5 +++--
 drivers/pci/pci-stub.c                 |    3 ++-
 drivers/pci/pci-sysfs.c                |    3 ---
 drivers/pci/pci.c                      |    9 +++++----
 drivers/pci/pcie/aer/aerdrv.c          |    9 +++------
 drivers/pci/pcie/aer/aerdrv.h          |    1 -
 drivers/pci/pcie/aer/aerdrv_acpi.c     |    1 -
 drivers/pci/pcie/aer/aerdrv_core.c     |   11 ++++-------
 drivers/pci/pcie/aer/aerdrv_errprint.c |    3 ---
 drivers/pci/pcie/aer/ecrc.c            |    4 ++--
 drivers/pci/pcie/aspm.c                |    3 +--
 drivers/pci/pcie/portdrv.h             |    1 -
 drivers/pci/pcie/portdrv_core.c        |    1 -
 drivers/pci/pcie/portdrv_pci.c         |    2 --
 drivers/pci/probe.c                    |    2 +-
 drivers/pci/proc.c                     |    4 ++--
 drivers/pci/quirks.c                   |   14 +++++++-------
 drivers/pci/rom.c                      |    4 +---
 drivers/pci/search.c                   |    8 ++++----
 drivers/pci/setup-bus.c                |    6 +-----
 drivers/pci/setup-irq.c                |    4 +---
 drivers/pci/setup-res.c                |   10 +++-------
 drivers/pci/slot.c                     |    1 -
 drivers/pci/syscall.c                  |    9 +++------
 drivers/pci/vpd.c                      |    3 +--
 drivers/pci/xen-pcifront.c             |    4 ++--
 35 files changed, 64 insertions(+), 105 deletions(-)

diff --git a/drivers/pci/access.c b/drivers/pci/access.c
index e080eb74bda0..a3ad2fe185b9 100644
--- a/drivers/pci/access.c
+++ b/drivers/pci/access.c
@@ -15,9 +15,9 @@
 DEFINE_RAW_SPINLOCK(pci_lock);
 
 /*
- *  Wrappers for all PCI configuration access functions.  They just check
- *  alignment, do locking and call the low-level functions pointed to
- *  by pci_dev->ops.
+ * Wrappers for all PCI configuration access functions.  They just check
+ * alignment, do locking and call the low-level functions pointed to
+ * by pci_dev->ops.
  */
 
 #define PCI_byte_BAD 0
@@ -318,8 +318,10 @@ void pci_cfg_access_unlock(struct pci_dev *dev)
 
 	raw_spin_lock_irqsave(&pci_lock, flags);
 
-	/* This indicates a problem in the caller, but we don't need
-	 * to kill them, unlike a double-block above. */
+	/*
+	 * This indicates a problem in the caller, but we don't need
+	 * to kill them, unlike a double-block above.
+	 */
 	WARN_ON(!dev->block_cfg_access);
 
 	dev->block_cfg_access = 0;
diff --git a/drivers/pci/ats.c b/drivers/pci/ats.c
index 6ad80a1fd5a7..89305b569d3d 100644
--- a/drivers/pci/ats.c
+++ b/drivers/pci/ats.c
@@ -1,14 +1,12 @@
 // SPDX-License-Identifier: GPL-2.0
 /*
- * drivers/pci/ats.c
- *
- * Copyright (C) 2009 Intel Corporation, Yu Zhao <yu.zhao@intel.com>
- * Copyright (C) 2011 Advanced Micro Devices,
- *
- * PCI Express I/O Virtualization (IOV) support.
+ * PCI Express I/O Virtualization (IOV) support
  *   Address Translation Service 1.0
  *   Page Request Interface added by Joerg Roedel <joerg.roedel@amd.com>
  *   PASID support added by Joerg Roedel <joerg.roedel@amd.com>
+ *
+ * Copyright (C) 2009 Intel Corporation, Yu Zhao <yu.zhao@intel.com>
+ * Copyright (C) 2011 Advanced Micro Devices,
  */
 
 #include <linux/export.h>
diff --git a/drivers/pci/bus.c b/drivers/pci/bus.c
index 737d1c52f002..bc2ded4c451f 100644
--- a/drivers/pci/bus.c
+++ b/drivers/pci/bus.c
@@ -1,7 +1,5 @@
 // SPDX-License-Identifier: GPL-2.0
 /*
- *	drivers/pci/bus.c
- *
  * From setup-res.c, by:
  *	Dave Rusling (david.rusling@reo.mts.dec.com)
  *	David Mosberger (davidm@cs.arizona.edu)
diff --git a/drivers/pci/host-bridge.c b/drivers/pci/host-bridge.c
index ac8d81268296..e01d53f5b32f 100644
--- a/drivers/pci/host-bridge.c
+++ b/drivers/pci/host-bridge.c
@@ -1,6 +1,6 @@
 // SPDX-License-Identifier: GPL-2.0
 /*
- * host bridge related code
+ * Host bridge related code
  */
 
 #include <linux/kernel.h>
diff --git a/drivers/pci/iov.c b/drivers/pci/iov.c
index 677924ae0350..538de9057c23 100644
--- a/drivers/pci/iov.c
+++ b/drivers/pci/iov.c
@@ -1,12 +1,10 @@
 // SPDX-License-Identifier: GPL-2.0
 /*
- * drivers/pci/iov.c
- *
- * Copyright (C) 2009 Intel Corporation, Yu Zhao <yu.zhao@intel.com>
- *
- * PCI Express I/O Virtualization (IOV) support.
+ * PCI Express I/O Virtualization (IOV) support
  *   Single Root IOV 1.0
  *   Address Translation Service 1.0
+ *
+ * Copyright (C) 2009 Intel Corporation, Yu Zhao <yu.zhao@intel.com>
  */
 
 #include <linux/pci.h>
diff --git a/drivers/pci/mmap.c b/drivers/pci/mmap.c
index 814a3ce341fc..24505b08de40 100644
--- a/drivers/pci/mmap.c
+++ b/drivers/pci/mmap.c
@@ -1,6 +1,6 @@
 // SPDX-License-Identifier: GPL-2.0
 /*
- * mmap.c — generic PCI resource mmap helper
+ * Generic PCI resource mmap helper
  *
  * Copyright © 2017 Amazon.com, Inc. or its affiliates.
  *
diff --git a/drivers/pci/msi.c b/drivers/pci/msi.c
index 8b0729c94bb7..30250631efe7 100644
--- a/drivers/pci/msi.c
+++ b/drivers/pci/msi.c
@@ -1,7 +1,6 @@
 // SPDX-License-Identifier: GPL-2.0
 /*
- * File:	msi.c
- * Purpose:	PCI Message Signaled Interrupt (MSI)
+ * PCI Message Signaled Interrupt (MSI)
  *
  * Copyright (C) 2003-2004 Intel
  * Copyright (C) Tom Long Nguyen (tom.l.nguyen@intel.com)
diff --git a/drivers/pci/pci-acpi.c b/drivers/pci/pci-acpi.c
index 78157688dcc9..1abdbf267c19 100644
--- a/drivers/pci/pci-acpi.c
+++ b/drivers/pci/pci-acpi.c
@@ -1,7 +1,6 @@
 // SPDX-License-Identifier: GPL-2.0
 /*
- * File:	pci-acpi.c
- * Purpose:	Provide PCI support in ACPI
+ * PCI support in ACPI
  *
  * Copyright (C) 2005 David Shaohua Li <shaohua.li@intel.com>
  * Copyright (C) 2004 Tom Long Nguyen <tom.l.nguyen@intel.com>
diff --git a/drivers/pci/pci-driver.c b/drivers/pci/pci-driver.c
index 3bed6beda051..5f1215222113 100644
--- a/drivers/pci/pci-driver.c
+++ b/drivers/pci/pci-driver.c
@@ -1,7 +1,5 @@
 // SPDX-License-Identifier: GPL-2.0
 /*
- * drivers/pci/pci-driver.c
- *
  * (C) Copyright 2002-2004, 2007 Greg Kroah-Hartman <greg@kroah.com>
  * (C) Copyright 2007 Novell Inc.
  */
diff --git a/drivers/pci/pci-label.c b/drivers/pci/pci-label.c
index a961a71d950f..a5910f942857 100644
--- a/drivers/pci/pci-label.c
+++ b/drivers/pci/pci-label.c
@@ -1,7 +1,8 @@
 // SPDX-License-Identifier: GPL-2.0
 /*
- * Purpose: Export the firmware instance and label associated with
- * a pci device to sysfs
+ * Export the firmware instance and label associated with a PCI device to
+ * sysfs
+ *
  * Copyright (C) 2010 Dell Inc.
  * by Narendra K <Narendra_K@dell.com>,
  * Jordan Hargrave <Jordan_Hargrave@dell.com>
diff --git a/drivers/pci/pci-stub.c b/drivers/pci/pci-stub.c
index 10d54f939048..66f8a59fadbd 100644
--- a/drivers/pci/pci-stub.c
+++ b/drivers/pci/pci-stub.c
@@ -1,5 +1,6 @@
 // SPDX-License-Identifier: GPL-2.0
-/* pci-stub - simple stub driver to reserve a pci device
+/*
+ * Simple stub driver to reserve a PCI device
  *
  * Copyright (C) 2008 Red Hat, Inc.
  * Author:
diff --git a/drivers/pci/pci-sysfs.c b/drivers/pci/pci-sysfs.c
index 4415e624cf7e..ae88b6bee169 100644
--- a/drivers/pci/pci-sysfs.c
+++ b/drivers/pci/pci-sysfs.c
@@ -1,7 +1,5 @@
 // SPDX-License-Identifier: GPL-2.0
 /*
- * drivers/pci/pci-sysfs.c
- *
  * (C) Copyright 2002-2004 Greg Kroah-Hartman <greg@kroah.com>
  * (C) Copyright 2002-2004 IBM Corp.
  * (C) Copyright 2003 Matthew Wilcox
@@ -12,7 +10,6 @@
  * File attributes for PCI devices
  *
  * Modeled after usb's driverfs.c
- *
  */
 
 
diff --git a/drivers/pci/pci.c b/drivers/pci/pci.c
index b7ff5786b76b..22f06de93696 100644
--- a/drivers/pci/pci.c
+++ b/drivers/pci/pci.c
@@ -1,11 +1,11 @@
 // SPDX-License-Identifier: GPL-2.0
 /*
- *	PCI Bus Services, see include/linux/pci.h for further explanation.
+ * PCI Bus Services, see include/linux/pci.h for further explanation.
  *
- *	Copyright 1993 -- 1997 Drew Eckhardt, Frederic Potter,
- *	David Mosberger-Tang
+ * Copyright 1993 -- 1997 Drew Eckhardt, Frederic Potter,
+ * David Mosberger-Tang
  *
- *	Copyright 1997 -- 2000 Martin Mares <mj@ucw.cz>
+ * Copyright 1997 -- 2000 Martin Mares <mj@ucw.cz>
  */
 
 #include <linux/acpi.h>
@@ -4183,6 +4183,7 @@ void pci_reset_secondary_bus(struct pci_dev *dev)
 	pci_read_config_word(dev, PCI_BRIDGE_CONTROL, &ctrl);
 	ctrl |= PCI_BRIDGE_CTL_BUS_RESET;
 	pci_write_config_word(dev, PCI_BRIDGE_CONTROL, ctrl);
+
 	/*
 	 * PCI spec v3.0 7.6.4.2 requires minimum Trst of 1ms.  Double
 	 * this to 2ms to ensure that we meet the minimum requirement.
diff --git a/drivers/pci/pcie/aer/aerdrv.c b/drivers/pci/pcie/aer/aerdrv.c
index da8331f5684d..9066d6e976d4 100644
--- a/drivers/pci/pcie/aer/aerdrv.c
+++ b/drivers/pci/pcie/aer/aerdrv.c
@@ -1,15 +1,12 @@
 // SPDX-License-Identifier: GPL-2.0
 /*
- * drivers/pci/pcie/aer/aerdrv.c
- *
- * This file implements the AER root port service driver. The driver will
- * register an irq handler. When root port triggers an AER interrupt, the irq
- * handler will collect root port status and schedule a work.
+ * Implement the AER root port service driver. The driver registers an IRQ
+ * handler. When a root port triggers an AER interrupt, the IRQ handler
+ * collects root port status and schedules work.
  *
  * Copyright (C) 2006 Intel Corp.
  *	Tom Long Nguyen (tom.l.nguyen@intel.com)
  *	Zhang Yanmin (yanmin.zhang@intel.com)
- *
  */
 
 #include <linux/pci.h>
diff --git a/drivers/pci/pcie/aer/aerdrv.h b/drivers/pci/pcie/aer/aerdrv.h
index 5449e5ce139d..72835141d640 100644
--- a/drivers/pci/pcie/aer/aerdrv.h
+++ b/drivers/pci/pcie/aer/aerdrv.h
@@ -3,7 +3,6 @@
  * Copyright (C) 2006 Intel Corp.
  *	Tom Long Nguyen (tom.l.nguyen@intel.com)
  *	Zhang Yanmin (yanmin.zhang@intel.com)
- *
  */
 
 #ifndef _AERDRV_H_
diff --git a/drivers/pci/pcie/aer/aerdrv_acpi.c b/drivers/pci/pcie/aer/aerdrv_acpi.c
index b2019440e882..08c87de13cb8 100644
--- a/drivers/pci/pcie/aer/aerdrv_acpi.c
+++ b/drivers/pci/pcie/aer/aerdrv_acpi.c
@@ -5,7 +5,6 @@
  * Copyright (C) 2006 Intel Corp.
  *	Tom Long Nguyen (tom.l.nguyen@intel.com)
  *	Zhang Yanmin (yanmin.zhang@intel.com)
- *
  */
 
 #include <linux/module.h>
diff --git a/drivers/pci/pcie/aer/aerdrv_core.c b/drivers/pci/pcie/aer/aerdrv_core.c
index a4bfea52e7d4..0ea5acc40323 100644
--- a/drivers/pci/pcie/aer/aerdrv_core.c
+++ b/drivers/pci/pcie/aer/aerdrv_core.c
@@ -1,16 +1,13 @@
 // SPDX-License-Identifier: GPL-2.0
 /*
- * drivers/pci/pcie/aer/aerdrv_core.c
- *
- * This file implements the core part of PCIe AER. When a PCIe
- * error is delivered, an error message will be collected and printed to
- * console, then, an error recovery procedure will be executed by following
- * the PCI error recovery rules.
+ * Implement the core part of PCIe AER. When a PCIe error is delivered, an
+ * error message will be collected and printed to console, then an error
+ * recovery procedure will be executed by following the PCI error recovery
+ * rules.
  *
  * Copyright (C) 2006 Intel Corp.
  *	Tom Long Nguyen (tom.l.nguyen@intel.com)
  *	Zhang Yanmin (yanmin.zhang@intel.com)
- *
  */
 
 #include <linux/module.h>
diff --git a/drivers/pci/pcie/aer/aerdrv_errprint.c b/drivers/pci/pcie/aer/aerdrv_errprint.c
index 6a352e638699..cfc89dd57831 100644
--- a/drivers/pci/pcie/aer/aerdrv_errprint.c
+++ b/drivers/pci/pcie/aer/aerdrv_errprint.c
@@ -1,13 +1,10 @@
 // SPDX-License-Identifier: GPL-2.0
 /*
- * drivers/pci/pcie/aer/aerdrv_errprint.c
- *
  * Format error messages and print them to console.
  *
  * Copyright (C) 2006 Intel Corp.
  *	Tom Long Nguyen (tom.l.nguyen@intel.com)
  *	Zhang Yanmin (yanmin.zhang@intel.com)
- *
  */
 
 #include <linux/module.h>
diff --git a/drivers/pci/pcie/aer/ecrc.c b/drivers/pci/pcie/aer/ecrc.c
index 26d3cac9e635..36e671835c41 100644
--- a/drivers/pci/pcie/aer/ecrc.c
+++ b/drivers/pci/pcie/aer/ecrc.c
@@ -1,8 +1,8 @@
 // SPDX-License-Identifier: GPL-2.0
 /*
- *    Enables/disables PCIe ECRC checking.
+ * Enable/disable PCIe ECRC checking
  *
- *    (C) Copyright 2009 Hewlett-Packard Development Company, L.P.
+ * (C) Copyright 2009 Hewlett-Packard Development Company, L.P.
  *    Andrew Patterson <andrew.patterson@hp.com>
  */
 
diff --git a/drivers/pci/pcie/aspm.c b/drivers/pci/pcie/aspm.c
index 57feef2ecfe7..bb14a104ebbb 100644
--- a/drivers/pci/pcie/aspm.c
+++ b/drivers/pci/pcie/aspm.c
@@ -1,7 +1,6 @@
 // SPDX-License-Identifier: GPL-2.0
 /*
- * File:	drivers/pci/pcie/aspm.c
- * Enabling PCIe link L0s/L1 state and Clock Power Management
+ * Enable PCIe link L0s/L1 state and Clock Power Management
  *
  * Copyright (C) 2007 Intel
  * Copyright (C) Zhang Yanmin (yanmin.zhang@intel.com)
diff --git a/drivers/pci/pcie/portdrv.h b/drivers/pci/pcie/portdrv.h
index a854bc569117..9681aba0d428 100644
--- a/drivers/pci/pcie/portdrv.h
+++ b/drivers/pci/pcie/portdrv.h
@@ -1,6 +1,5 @@
 /* SPDX-License-Identifier: GPL-2.0 */
 /*
- * File:	portdrv.h
  * Purpose:	PCI Express Port Bus Driver's Internal Data Structures
  *
  * Copyright (C) 2004 Intel
diff --git a/drivers/pci/pcie/portdrv_core.c b/drivers/pci/pcie/portdrv_core.c
index ef3bad4ad010..07833e5cde36 100644
--- a/drivers/pci/pcie/portdrv_core.c
+++ b/drivers/pci/pcie/portdrv_core.c
@@ -1,6 +1,5 @@
 // SPDX-License-Identifier: GPL-2.0
 /*
- * File:	portdrv_core.c
  * Purpose:	PCI Express Port Bus Driver's Core Functions
  *
  * Copyright (C) 2004 Intel
diff --git a/drivers/pci/pcie/portdrv_pci.c b/drivers/pci/pcie/portdrv_pci.c
index fb1c1bb87316..06d9445997ff 100644
--- a/drivers/pci/pcie/portdrv_pci.c
+++ b/drivers/pci/pcie/portdrv_pci.c
@@ -1,9 +1,7 @@
 // SPDX-License-Identifier: GPL-2.0
 /*
- * File:	portdrv_pci.c
  * Purpose:	PCI Express Port Bus Driver
  * Author:	Tom Nguyen <tom.l.nguyen@intel.com>
- * Version:	v1.0
  *
  * Copyright (C) 2004 Intel
  * Copyright (C) Tom Long Nguyen (tom.l.nguyen@intel.com)
diff --git a/drivers/pci/probe.c b/drivers/pci/probe.c
index ef5377438a1e..7762ba4d9220 100644
--- a/drivers/pci/probe.c
+++ b/drivers/pci/probe.c
@@ -1,6 +1,6 @@
 // SPDX-License-Identifier: GPL-2.0
 /*
- * probe.c - PCI detection and setup code
+ * PCI detection and setup code
  */
 
 #include <linux/kernel.h>
diff --git a/drivers/pci/proc.c b/drivers/pci/proc.c
index 58a662e3c4a6..1ee8927a0635 100644
--- a/drivers/pci/proc.c
+++ b/drivers/pci/proc.c
@@ -1,8 +1,8 @@
 // SPDX-License-Identifier: GPL-2.0
 /*
- *	Procfs interface for the PCI bus.
+ * Procfs interface for the PCI bus
  *
- *	Copyright (c) 1997--1999 Martin Mares <mj@ucw.cz>
+ * Copyright (c) 1997--1999 Martin Mares <mj@ucw.cz>
  */
 
 #include <linux/init.h>
diff --git a/drivers/pci/quirks.c b/drivers/pci/quirks.c
index fbe1127086c8..ec280f2223b3 100644
--- a/drivers/pci/quirks.c
+++ b/drivers/pci/quirks.c
@@ -1,15 +1,15 @@
 // SPDX-License-Identifier: GPL-2.0
 /*
- *  This file contains work-arounds for many known PCI hardware
- *  bugs.  Devices present only on certain architectures (host
- *  bridges et cetera) should be handled in arch-specific code.
+ * This file contains work-arounds for many known PCI hardware bugs.
+ * Devices present only on certain architectures (host bridges et cetera)
+ * should be handled in arch-specific code.
  *
- *  Note: any quirks for hotpluggable devices must _NOT_ be declared __init.
+ * Note: any quirks for hotpluggable devices must _NOT_ be declared __init.
  *
- *  Copyright (c) 1999 Martin Mares <mj@ucw.cz>
+ * Copyright (c) 1999 Martin Mares <mj@ucw.cz>
  *
- *  Init/reset quirks for USB host controllers should be in the
- *  USB quirks file, where their drivers can access reuse it.
+ * Init/reset quirks for USB host controllers should be in the USB quirks
+ * file, where their drivers can use them.
  */
 
 #include <linux/types.h>
diff --git a/drivers/pci/rom.c b/drivers/pci/rom.c
index 374a33443be9..a7b5c37a85ec 100644
--- a/drivers/pci/rom.c
+++ b/drivers/pci/rom.c
@@ -1,11 +1,9 @@
 // SPDX-License-Identifier: GPL-2.0
 /*
- * drivers/pci/rom.c
+ * PCI ROM access routines
  *
  * (C) Copyright 2004 Jon Smirl <jonsmirl@yahoo.com>
  * (C) Copyright 2004 Silicon Graphics, Inc. Jesse Barnes <jbarnes@sgi.com>
- *
- * PCI ROM access routines
  */
 #include <linux/kernel.h>
 #include <linux/export.h>
diff --git a/drivers/pci/search.c b/drivers/pci/search.c
index bc1e023f1353..2b5f720862d3 100644
--- a/drivers/pci/search.c
+++ b/drivers/pci/search.c
@@ -1,11 +1,11 @@
 // SPDX-License-Identifier: GPL-2.0
 /*
- *	PCI searching functions.
+ * PCI searching functions
  *
- *	Copyright (C) 1993 -- 1997 Drew Eckhardt, Frederic Potter,
+ * Copyright (C) 1993 -- 1997 Drew Eckhardt, Frederic Potter,
  *					David Mosberger-Tang
- *	Copyright (C) 1997 -- 2000 Martin Mares <mj@ucw.cz>
- *	Copyright (C) 2003 -- 2004 Greg Kroah-Hartman <greg@kroah.com>
+ * Copyright (C) 1997 -- 2000 Martin Mares <mj@ucw.cz>
+ * Copyright (C) 2003 -- 2004 Greg Kroah-Hartman <greg@kroah.com>
  */
 
 #include <linux/pci.h>
diff --git a/drivers/pci/setup-bus.c b/drivers/pci/setup-bus.c
index 3cce29a069e6..072784f55ea5 100644
--- a/drivers/pci/setup-bus.c
+++ b/drivers/pci/setup-bus.c
@@ -1,16 +1,12 @@
 // SPDX-License-Identifier: GPL-2.0
 /*
- *	drivers/pci/setup-bus.c
+ * Support routines for initializing a PCI subsystem
  *
  * Extruded from code written by
  *      Dave Rusling (david.rusling@reo.mts.dec.com)
  *      David Mosberger (davidm@cs.arizona.edu)
  *	David Miller (davem@redhat.com)
  *
- * Support routines for initializing a PCI subsystem.
- */
-
-/*
  * Nov 2000, Ivan Kokshaysky <ink@jurassic.park.msu.ru>
  *	     PCI-PCI bridges cleanup, sorted resource allocation.
  * Feb 2002, Ivan Kokshaysky <ink@jurassic.park.msu.ru>
diff --git a/drivers/pci/setup-irq.c b/drivers/pci/setup-irq.c
index 5ad4ee7d7b1e..7129494754dd 100644
--- a/drivers/pci/setup-irq.c
+++ b/drivers/pci/setup-irq.c
@@ -1,13 +1,11 @@
 // SPDX-License-Identifier: GPL-2.0
 /*
- *	drivers/pci/setup-irq.c
+ * Support routines for initializing a PCI subsystem
  *
  * Extruded from code written by
  *      Dave Rusling (david.rusling@reo.mts.dec.com)
  *      David Mosberger (davidm@cs.arizona.edu)
  *	David Miller (davem@redhat.com)
- *
- * Support routines for initializing a PCI subsystem.
  */
 
 
diff --git a/drivers/pci/setup-res.c b/drivers/pci/setup-res.c
index 369d48d6c6f1..1ef01d79b52e 100644
--- a/drivers/pci/setup-res.c
+++ b/drivers/pci/setup-res.c
@@ -1,18 +1,14 @@
 // SPDX-License-Identifier: GPL-2.0
 /*
- *	drivers/pci/setup-res.c
+ * Support routines for initializing a PCI subsystem
  *
  * Extruded from code written by
  *      Dave Rusling (david.rusling@reo.mts.dec.com)
  *      David Mosberger (davidm@cs.arizona.edu)
  *	David Miller (davem@redhat.com)
  *
- * Support routines for initializing a PCI subsystem.
- */
-
-/* fixed for multiple pci buses, 1999 Andrea Arcangeli <andrea@suse.de> */
-
-/*
+ * Fixed for multiple PCI buses, 1999 Andrea Arcangeli <andrea@suse.de>
+ *
  * Nov 2000, Ivan Kokshaysky <ink@jurassic.park.msu.ru>
  *	     Resource sorting
  */
diff --git a/drivers/pci/slot.c b/drivers/pci/slot.c
index d10f556dc03e..bdea6d4061ae 100644
--- a/drivers/pci/slot.c
+++ b/drivers/pci/slot.c
@@ -1,6 +1,5 @@
 // SPDX-License-Identifier: GPL-2.0
 /*
- * drivers/pci/slot.c
  * Copyright (C) 2006 Matthew Wilcox <matthew@wil.cx>
  * Copyright (C) 2006-2009 Hewlett-Packard Development Company, L.P.
  *	Alex Chiang <achiang@hp.com>
diff --git a/drivers/pci/syscall.c b/drivers/pci/syscall.c
index e725f99b5479..d96626c614f5 100644
--- a/drivers/pci/syscall.c
+++ b/drivers/pci/syscall.c
@@ -1,11 +1,8 @@
 // SPDX-License-Identifier: GPL-2.0
 /*
- *	pci_syscall.c
- *
- * For architectures where we want to allow direct access
- * to the PCI config stuff - it would probably be preferable
- * on PCs too, but there people just do it by hand with the
- * magic northbridge registers..
+ * For architectures where we want to allow direct access to the PCI config
+ * stuff - it would probably be preferable on PCs too, but there people
+ * just do it by hand with the magic northbridge registers.
  */
 
 #include <linux/errno.h>
diff --git a/drivers/pci/vpd.c b/drivers/pci/vpd.c
index f24c3600be73..00b8b5d37056 100644
--- a/drivers/pci/vpd.c
+++ b/drivers/pci/vpd.c
@@ -1,7 +1,6 @@
 // SPDX-License-Identifier: GPL-2.0
 /*
- * File:	vpd.c
- * Purpose:	Provide PCI VPD support
+ * PCI VPD support
  *
  * Copyright (C) 2010 Broadcom Corporation.
  */
diff --git a/drivers/pci/xen-pcifront.c b/drivers/pci/xen-pcifront.c
index 8785014f656e..eba6e33147a2 100644
--- a/drivers/pci/xen-pcifront.c
+++ b/drivers/pci/xen-pcifront.c
@@ -1,8 +1,8 @@
 // SPDX-License-Identifier: GPL-2.0
 /*
- * Xen PCI Frontend.
+ * Xen PCI Frontend
  *
- *   Author: Ryan Wilson <hap9@epoch.ncsc.mil>
+ * Author: Ryan Wilson <hap9@epoch.ncsc.mil>
  */
 #include <linux/module.h>
 #include <linux/init.h>
