Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from goliath.siemens.de ([192.35.17.28]:50277 "EHLO
        goliath.siemens.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751110AbeCGHjg (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 7 Mar 2018 02:39:36 -0500
From: Jan Kiszka <jan.kiszka@siemens.com>
To: Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>,
        "H . Peter Anvin" <hpa@zytor.com>,
        Bjorn Helgaas <bhelgaas@google.com>
Cc: x86@kernel.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        jailhouse-dev@googlegroups.com, linux-pci@vger.kernel.org,
        virtualization@lists.linux-foundation.org,
        Andy Shevchenko <andy.shevchenko@gmail.com>,
        Benedikt Spranger <b.spranger@linutronix.de>
Subject: [PATCH v5 2/7] PCI: Scan all functions when running over Jailhouse
Date: Wed,  7 Mar 2018 08:39:13 +0100
Message-Id: <06e279b2a3e06cf6689ab3975f8ab592bba02362.1520408357.git.jan.kiszka@siemens.com>
In-Reply-To: <cover.1520408357.git.jan.kiszka@siemens.com>
References: <cover.1520408357.git.jan.kiszka@siemens.com>
In-Reply-To: <cover.1520408357.git.jan.kiszka@siemens.com>
References: <cover.1520408357.git.jan.kiszka@siemens.com>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

From: Jan Kiszka <jan.kiszka@siemens.com>

Per PCIe r4.0, sec 7.5.1.1.9, multi-function devices are required to
have a function 0.  Therefore, Linux scans for devices at function 0
(devfn 0/8/16/...) and only scans for other functions if function 0
has its Multi-Function Device bit set or ARI or SR-IOV indicate
there are more functions.

The Jailhouse hypervisor may pass individual functions of a
multi-function device to a guest without passing function 0, which
means a Linux guest won't find them.

Change Linux PCI probing so it scans all function numbers when
running as a guest over Jailhouse.

This is technically prohibited by the spec, so it is possible that
PCI devices without the Multi-Function Device bit set may have
unexpected behavior in response to this probe.

Derived from original patch by Benedikt Spranger.

CC: Benedikt Spranger <b.spranger@linutronix.de>
Signed-off-by: Jan Kiszka <jan.kiszka@siemens.com>
Acked-by: Bjorn Helgaas <bhelgaas@google.com>
Reviewed-by: Andy Shevchenko <andy.shevchenko@gmail.com>
---
 arch/x86/pci/legacy.c |  4 +++-
 drivers/pci/probe.c   | 22 +++++++++++++++++++---
 2 files changed, 22 insertions(+), 4 deletions(-)

diff --git a/arch/x86/pci/legacy.c b/arch/x86/pci/legacy.c
index 1cb01abcb1be..dfbe6ac38830 100644
--- a/arch/x86/pci/legacy.c
+++ b/arch/x86/pci/legacy.c
@@ -4,6 +4,7 @@
 #include <linux/init.h>
 #include <linux/export.h>
 #include <linux/pci.h>
+#include <asm/jailhouse_para.h>
 #include <asm/pci_x86.h>
 
 /*
@@ -34,13 +35,14 @@ int __init pci_legacy_init(void)
 
 void pcibios_scan_specific_bus(int busn)
 {
+	int stride = jailhouse_paravirt() ? 1 : 8;
 	int devfn;
 	u32 l;
 
 	if (pci_find_bus(0, busn))
 		return;
 
-	for (devfn = 0; devfn < 256; devfn += 8) {
+	for (devfn = 0; devfn < 256; devfn += stride) {
 		if (!raw_pci_read(0, busn, devfn, PCI_VENDOR_ID, 2, &l) &&
 		    l != 0x0000 && l != 0xffff) {
 			DBG("Found device at %02x:%02x [%04x]\n", busn, devfn, l);
diff --git a/drivers/pci/probe.c b/drivers/pci/probe.c
index ef5377438a1e..3c365dc996e7 100644
--- a/drivers/pci/probe.c
+++ b/drivers/pci/probe.c
@@ -16,6 +16,7 @@
 #include <linux/pci-aspm.h>
 #include <linux/aer.h>
 #include <linux/acpi.h>
+#include <linux/hypervisor.h>
 #include <linux/irqdomain.h>
 #include <linux/pm_runtime.h>
 #include "pci.h"
@@ -2518,14 +2519,29 @@ static unsigned int pci_scan_child_bus_extend(struct pci_bus *bus,
 {
 	unsigned int used_buses, normal_bridges = 0, hotplug_bridges = 0;
 	unsigned int start = bus->busn_res.start;
-	unsigned int devfn, cmax, max = start;
+	unsigned int devfn, fn, cmax, max = start;
 	struct pci_dev *dev;
+	int nr_devs;
 
 	dev_dbg(&bus->dev, "scanning bus\n");
 
 	/* Go find them, Rover! */
-	for (devfn = 0; devfn < 0x100; devfn += 8)
-		pci_scan_slot(bus, devfn);
+	for (devfn = 0; devfn < 256; devfn += 8) {
+		nr_devs = pci_scan_slot(bus, devfn);
+
+		/*
+		 * The Jailhouse hypervisor may pass individual functions of a
+		 * multi-function device to a guest without passing function 0.
+		 * Look for them as well.
+		 */
+		if (jailhouse_paravirt() && nr_devs == 0) {
+			for (fn = 1; fn < 8; fn++) {
+				dev = pci_scan_single_device(bus, devfn + fn);
+				if (dev)
+					dev->multifunction = 1;
+			}
+		}
+	}
 
 	/* Reserve buses for SR-IOV capability */
 	used_buses = pci_iov_bus_range(bus);
-- 
2.13.6
