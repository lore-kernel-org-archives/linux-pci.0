Return-Path: <linux-kernel-owner@vger.kernel.org>
Subject: [PATCH 1/4] PCI: Add SPDX GPL-2.0 when no license was specified
From: Bjorn Helgaas <helgaas@kernel.org>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Kate Stewart <kstewart@linuxfoundation.org>,
        linux-pci@vger.kernel.org, Thomas Gleixner <tglx@linutronix.de>,
        linux-kernel@vger.kernel.org,
        Philippe Ombredanne <pombredanne@nexb.com>
Date: Fri, 26 Jan 2018 15:32:27 -0600
Message-ID: <20180126213227.31503.41635.stgit@bhelgaas-glaptop.roam.corp.google.com>
In-Reply-To: <20180126212536.31503.43805.stgit@bhelgaas-glaptop.roam.corp.google.com>
References: <20180126212536.31503.43805.stgit@bhelgaas-glaptop.roam.corp.google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

From: Bjorn Helgaas <bhelgaas@google.com>

b24413180f56 ("License cleanup: add SPDX GPL-2.0 license identifier to
files with no license") added SPDX GPL-2.0 to several PCI files that
previously contained no license information.

Add SPDX GPL-2.0 to all other PCI files that did not contain any license
information and hence were under the default GPL version 2 license of the
kernel.

Signed-off-by: Bjorn Helgaas <bhelgaas@google.com>
---
 drivers/pci/Kconfig                     |    1 +
 drivers/pci/access.c                    |    1 +
 drivers/pci/ats.c                       |    1 +
 drivers/pci/bus.c                       |    1 +
 drivers/pci/dwc/Kconfig                 |    2 ++
 drivers/pci/endpoint/Kconfig            |    1 +
 drivers/pci/endpoint/Makefile           |    1 +
 drivers/pci/endpoint/functions/Kconfig  |    1 +
 drivers/pci/endpoint/functions/Makefile |    1 +
 drivers/pci/host-bridge.c               |    1 +
 drivers/pci/host/Kconfig                |    2 ++
 drivers/pci/host/pci-v3-semi.c          |    1 +
 drivers/pci/hotplug/Kconfig             |    1 +
 drivers/pci/iov.c                       |    1 +
 drivers/pci/msi.c                       |    1 +
 drivers/pci/pci-acpi.c                  |    1 +
 drivers/pci/pci.c                       |    1 +
 drivers/pci/pcie/Kconfig                |    1 +
 drivers/pci/pcie/aer/Kconfig            |    1 +
 drivers/pci/pcie/aer/Kconfig.debug      |    1 +
 drivers/pci/pcie/portdrv_bus.c          |    1 +
 drivers/pci/probe.c                     |    1 +
 drivers/pci/remove.c                    |    1 +
 drivers/pci/rom.c                       |    1 +
 drivers/pci/search.c                    |    1 +
 drivers/pci/setup-bus.c                 |    1 +
 drivers/pci/setup-irq.c                 |    1 +
 drivers/pci/slot.c                      |    1 +
 drivers/pci/switch/Kconfig              |    2 ++
 drivers/pci/switch/Makefile             |    1 +
 drivers/pci/vpd.c                       |    1 +
 drivers/pci/xen-pcifront.c              |    1 +
 lib/pci_iomap.c                         |    1 +
 33 files changed, 36 insertions(+)

diff --git a/drivers/pci/Kconfig b/drivers/pci/Kconfig
index bda151788f3f..949aa74206cd 100644
--- a/drivers/pci/Kconfig
+++ b/drivers/pci/Kconfig
@@ -1,3 +1,4 @@
+# SPDX-License-Identifier: GPL-2.0
 #
 # PCI configuration
 #
diff --git a/drivers/pci/access.c b/drivers/pci/access.c
index 913d6722ece9..5a64da3fb033 100644
--- a/drivers/pci/access.c
+++ b/drivers/pci/access.c
@@ -1,3 +1,4 @@
+// SPDX-License-Identifier: GPL-2.0
 #include <linux/delay.h>
 #include <linux/pci.h>
 #include <linux/module.h>
diff --git a/drivers/pci/ats.c b/drivers/pci/ats.c
index ad8ddbbbf245..6ad80a1fd5a7 100644
--- a/drivers/pci/ats.c
+++ b/drivers/pci/ats.c
@@ -1,3 +1,4 @@
+// SPDX-License-Identifier: GPL-2.0
 /*
  * drivers/pci/ats.c
  *
diff --git a/drivers/pci/bus.c b/drivers/pci/bus.c
index bc56cf19afd3..30a4d33038bf 100644
--- a/drivers/pci/bus.c
+++ b/drivers/pci/bus.c
@@ -1,3 +1,4 @@
+// SPDX-License-Identifier: GPL-2.0
 /*
  *	drivers/pci/bus.c
  *
diff --git a/drivers/pci/dwc/Kconfig b/drivers/pci/dwc/Kconfig
index 113e09440f85..fe1cb56b71f1 100644
--- a/drivers/pci/dwc/Kconfig
+++ b/drivers/pci/dwc/Kconfig
@@ -1,3 +1,5 @@
+# SPDX-License-Identifier: GPL-2.0
+
 menu "DesignWare PCI Core Support"
 
 config PCIE_DW
diff --git a/drivers/pci/endpoint/Kconfig b/drivers/pci/endpoint/Kconfig
index c09623ca8c3b..d1e7e4199432 100644
--- a/drivers/pci/endpoint/Kconfig
+++ b/drivers/pci/endpoint/Kconfig
@@ -1,3 +1,4 @@
+# SPDX-License-Identifier: GPL-2.0
 #
 # PCI Endpoint Support
 #
diff --git a/drivers/pci/endpoint/Makefile b/drivers/pci/endpoint/Makefile
index 1041f80a4645..95b2fe47e3b0 100644
--- a/drivers/pci/endpoint/Makefile
+++ b/drivers/pci/endpoint/Makefile
@@ -1,3 +1,4 @@
+# SPDX-License-Identifier: GPL-2.0
 #
 # Makefile for PCI Endpoint Support
 #
diff --git a/drivers/pci/endpoint/functions/Kconfig b/drivers/pci/endpoint/functions/Kconfig
index 2942066607e0..8820d0f7ec77 100644
--- a/drivers/pci/endpoint/functions/Kconfig
+++ b/drivers/pci/endpoint/functions/Kconfig
@@ -1,3 +1,4 @@
+# SPDX-License-Identifier: GPL-2.0
 #
 # PCI Endpoint Functions
 #
diff --git a/drivers/pci/endpoint/functions/Makefile b/drivers/pci/endpoint/functions/Makefile
index 6d94a4801838..d6fafff080e2 100644
--- a/drivers/pci/endpoint/functions/Makefile
+++ b/drivers/pci/endpoint/functions/Makefile
@@ -1,3 +1,4 @@
+# SPDX-License-Identifier: GPL-2.0
 #
 # Makefile for PCI Endpoint Functions
 #
diff --git a/drivers/pci/host-bridge.c b/drivers/pci/host-bridge.c
index add66236215c..ac8d81268296 100644
--- a/drivers/pci/host-bridge.c
+++ b/drivers/pci/host-bridge.c
@@ -1,3 +1,4 @@
+// SPDX-License-Identifier: GPL-2.0
 /*
  * host bridge related code
  */
diff --git a/drivers/pci/host/Kconfig b/drivers/pci/host/Kconfig
index 38d12980db0f..a4ed7484d127 100644
--- a/drivers/pci/host/Kconfig
+++ b/drivers/pci/host/Kconfig
@@ -1,3 +1,5 @@
+# SPDX-License-Identifier: GPL-2.0
+
 menu "PCI host controller drivers"
 	depends on PCI
 
diff --git a/drivers/pci/host/pci-v3-semi.c b/drivers/pci/host/pci-v3-semi.c
index 02f6e1e3a421..7fef64869d19 100644
--- a/drivers/pci/host/pci-v3-semi.c
+++ b/drivers/pci/host/pci-v3-semi.c
@@ -1,3 +1,4 @@
+// SPDX-License-Identifier: GPL-2.0
 /*
  * Support for V3 Semiconductor PCI Local Bus to PCI Bridge
  * Copyright (C) 2017 Linus Walleij <linus.walleij@linaro.org>
diff --git a/drivers/pci/hotplug/Kconfig b/drivers/pci/hotplug/Kconfig
index aadce45a9b4a..a8f21d051e0c 100644
--- a/drivers/pci/hotplug/Kconfig
+++ b/drivers/pci/hotplug/Kconfig
@@ -1,3 +1,4 @@
+# SPDX-License-Identifier: GPL-2.0
 #
 # PCI Hotplug support
 #
diff --git a/drivers/pci/iov.c b/drivers/pci/iov.c
index 6bacb8995e96..c533325e8d86 100644
--- a/drivers/pci/iov.c
+++ b/drivers/pci/iov.c
@@ -1,3 +1,4 @@
+// SPDX-License-Identifier: GPL-2.0
 /*
  * drivers/pci/iov.c
  *
diff --git a/drivers/pci/msi.c b/drivers/pci/msi.c
index e06607167858..7f7547d200e4 100644
--- a/drivers/pci/msi.c
+++ b/drivers/pci/msi.c
@@ -1,3 +1,4 @@
+// SPDX-License-Identifier: GPL-2.0
 /*
  * File:	msi.c
  * Purpose:	PCI Message Signaled Interrupt (MSI)
diff --git a/drivers/pci/pci-acpi.c b/drivers/pci/pci-acpi.c
index 4708eb9df71b..3b82bb86a203 100644
--- a/drivers/pci/pci-acpi.c
+++ b/drivers/pci/pci-acpi.c
@@ -1,3 +1,4 @@
+// SPDX-License-Identifier: GPL-2.0
 /*
  * File:	pci-acpi.c
  * Purpose:	Provide PCI support in ACPI
diff --git a/drivers/pci/pci.c b/drivers/pci/pci.c
index 4a7c6864fdf4..50e716b3e2b8 100644
--- a/drivers/pci/pci.c
+++ b/drivers/pci/pci.c
@@ -1,3 +1,4 @@
+// SPDX-License-Identifier: GPL-2.0
 /*
  *	PCI Bus Services, see include/linux/pci.h for further explanation.
  *
diff --git a/drivers/pci/pcie/Kconfig b/drivers/pci/pcie/Kconfig
index ac53edbc9613..6d75a2eb6ecb 100644
--- a/drivers/pci/pcie/Kconfig
+++ b/drivers/pci/pcie/Kconfig
@@ -1,3 +1,4 @@
+# SPDX-License-Identifier: GPL-2.0
 #
 # PCI Express Port Bus Configuration
 #
diff --git a/drivers/pci/pcie/aer/Kconfig b/drivers/pci/pcie/aer/Kconfig
index 7d1437b01fdd..5a64eb3d6c7a 100644
--- a/drivers/pci/pcie/aer/Kconfig
+++ b/drivers/pci/pcie/aer/Kconfig
@@ -1,3 +1,4 @@
+# SPDX-License-Identifier: GPL-2.0
 #
 # PCI Express Root Port Device AER Configuration
 #
diff --git a/drivers/pci/pcie/aer/Kconfig.debug b/drivers/pci/pcie/aer/Kconfig.debug
index 9142949734f5..67e02174b65b 100644
--- a/drivers/pci/pcie/aer/Kconfig.debug
+++ b/drivers/pci/pcie/aer/Kconfig.debug
@@ -1,3 +1,4 @@
+# SPDX-License-Identifier: GPL-2.0
 #
 # PCI Express Root Port Device AER Debug Configuration
 #
diff --git a/drivers/pci/pcie/portdrv_bus.c b/drivers/pci/pcie/portdrv_bus.c
index 87e79a6ffb5a..f0fba552a0e2 100644
--- a/drivers/pci/pcie/portdrv_bus.c
+++ b/drivers/pci/pcie/portdrv_bus.c
@@ -1,3 +1,4 @@
+// SPDX-License-Identifier: GPL-2.0
 /*
  * File:	portdrv_bus.c
  * Purpose:	PCI Express Port Bus Driver's Bus Overloading Functions
diff --git a/drivers/pci/probe.c b/drivers/pci/probe.c
index 14e0ea1ff38b..3ea2d610d607 100644
--- a/drivers/pci/probe.c
+++ b/drivers/pci/probe.c
@@ -1,3 +1,4 @@
+// SPDX-License-Identifier: GPL-2.0
 /*
  * probe.c - PCI detection and setup code
  */
diff --git a/drivers/pci/remove.c b/drivers/pci/remove.c
index 2fa0dbde36b7..6f072eae4f7a 100644
--- a/drivers/pci/remove.c
+++ b/drivers/pci/remove.c
@@ -1,3 +1,4 @@
+// SPDX-License-Identifier: GPL-2.0
 #include <linux/pci.h>
 #include <linux/module.h>
 #include <linux/pci-aspm.h>
diff --git a/drivers/pci/rom.c b/drivers/pci/rom.c
index 1f5e6af96c83..9ba3fa841eb0 100644
--- a/drivers/pci/rom.c
+++ b/drivers/pci/rom.c
@@ -1,3 +1,4 @@
+// SPDX-License-Identifier: GPL-2.0
 /*
  * drivers/pci/rom.c
  *
diff --git a/drivers/pci/search.c b/drivers/pci/search.c
index 4c6044ad7368..bc1e023f1353 100644
--- a/drivers/pci/search.c
+++ b/drivers/pci/search.c
@@ -1,3 +1,4 @@
+// SPDX-License-Identifier: GPL-2.0
 /*
  *	PCI searching functions.
  *
diff --git a/drivers/pci/setup-bus.c b/drivers/pci/setup-bus.c
index b1ad466199ad..0a26648f1712 100644
--- a/drivers/pci/setup-bus.c
+++ b/drivers/pci/setup-bus.c
@@ -1,3 +1,4 @@
+// SPDX-License-Identifier: GPL-2.0
 /*
  *	drivers/pci/setup-bus.c
  *
diff --git a/drivers/pci/setup-irq.c b/drivers/pci/setup-irq.c
index 86106c44ce94..9c8d81b3cf82 100644
--- a/drivers/pci/setup-irq.c
+++ b/drivers/pci/setup-irq.c
@@ -1,3 +1,4 @@
+// SPDX-License-Identifier: GPL-2.0
 /*
  *	drivers/pci/setup-irq.c
  *
diff --git a/drivers/pci/slot.c b/drivers/pci/slot.c
index e42909524dee..d10f556dc03e 100644
--- a/drivers/pci/slot.c
+++ b/drivers/pci/slot.c
@@ -1,3 +1,4 @@
+// SPDX-License-Identifier: GPL-2.0
 /*
  * drivers/pci/slot.c
  * Copyright (C) 2006 Matthew Wilcox <matthew@wil.cx>
diff --git a/drivers/pci/switch/Kconfig b/drivers/pci/switch/Kconfig
index 4c49648e0646..aee28a5bb98f 100644
--- a/drivers/pci/switch/Kconfig
+++ b/drivers/pci/switch/Kconfig
@@ -1,3 +1,5 @@
+# SPDX-License-Identifier: GPL-2.0
+
 menu "PCI switch controller drivers"
 	depends on PCI
 
diff --git a/drivers/pci/switch/Makefile b/drivers/pci/switch/Makefile
index 37d8cfb03f3f..acd56d3b4a35 100644
--- a/drivers/pci/switch/Makefile
+++ b/drivers/pci/switch/Makefile
@@ -1 +1,2 @@
+# SPDX-License-Identifier: GPL-2.0
 obj-$(CONFIG_PCI_SW_SWITCHTEC) += switchtec.o
diff --git a/drivers/pci/vpd.c b/drivers/pci/vpd.c
index 39b79070335d..70fba57d6103 100644
--- a/drivers/pci/vpd.c
+++ b/drivers/pci/vpd.c
@@ -1,3 +1,4 @@
+// SPDX-License-Identifier: GPL-2.0
 /*
  * File:	vpd.c
  * Purpose:	Provide PCI VPD support
diff --git a/drivers/pci/xen-pcifront.c b/drivers/pci/xen-pcifront.c
index 8fc2e9532575..82fe8526ac90 100644
--- a/drivers/pci/xen-pcifront.c
+++ b/drivers/pci/xen-pcifront.c
@@ -1,3 +1,4 @@
+// SPDX-License-Identifier: GPL-2.0
 /*
  * Xen PCI Frontend.
  *
diff --git a/lib/pci_iomap.c b/lib/pci_iomap.c
index c10fba461454..2d3eb1cb73b8 100644
--- a/lib/pci_iomap.c
+++ b/lib/pci_iomap.c
@@ -1,3 +1,4 @@
+// SPDX-License-Identifier: GPL-2.0
 /*
  * Implement the default iomap interfaces
  *
