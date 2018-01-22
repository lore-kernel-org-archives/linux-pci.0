Return-Path: <linux-kernel-owner@vger.kernel.org>
From: Jan Kiszka <jan.kiszka@siemens.com>
To: Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>,
        "H . Peter Anvin" <hpa@zytor.com>,
        Bjorn Helgaas <bhelgaas@google.com>
Cc: x86@kernel.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        jailhouse-dev@googlegroups.com, linux-pci@vger.kernel.org,
        virtualization@lists.linux-foundation.org,
        Benedikt Spranger <b.spranger@linutronix.de>
Subject: [PATCH 2/6] pci: Scan all functions when probing while running over Jailhouse
Date: Mon, 22 Jan 2018 07:12:46 +0100
Message-Id: <66bfcfc6dc1832baa3fbd8e4879764d36aa9c1e7.1516601570.git.jan.kiszka@siemens.com>
In-Reply-To: <cover.1516601570.git.jan.kiszka@siemens.com>
References: <cover.1516601570.git.jan.kiszka@siemens.com>
In-Reply-To: <cover.1516601570.git.jan.kiszka@siemens.com>
References: <cover.1516601570.git.jan.kiszka@siemens.com>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

From: Jan Kiszka <jan.kiszka@siemens.com>

PCI and PCIBIOS probing only scans devices at function number 0/8/16/...
Subdevices (e.g. multiqueue) have function numbers which are not a
multiple of 8.

The simple hypervisor Jailhouse passes subdevices directly w/o providing
a virtual PCI topology like KVM. As a consequence a PCI passthrough from
Jailhouse to a guest will not be detected by Linux.

Based on patch by Benedikt Spranger, adding Jailhouse probing to avoid
changing the behavior in the absence of the hypervisor.

CC: Benedikt Spranger <b.spranger@linutronix.de>
Signed-off-by: Jan Kiszka <jan.kiszka@siemens.com>
---
 arch/x86/pci/legacy.c | 4 +++-
 drivers/pci/probe.c   | 4 +++-
 2 files changed, 6 insertions(+), 2 deletions(-)

diff --git a/arch/x86/pci/legacy.c b/arch/x86/pci/legacy.c
index 1cb01abcb1be..a7b0476b4f44 100644
--- a/arch/x86/pci/legacy.c
+++ b/arch/x86/pci/legacy.c
@@ -5,6 +5,7 @@
 #include <linux/export.h>
 #include <linux/pci.h>
 #include <asm/pci_x86.h>
+#include <asm/jailhouse_para.h>
 
 /*
  * Discover remaining PCI buses in case there are peer host bridges.
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
index 14e0ea1ff38b..60ad14c8245f 100644
--- a/drivers/pci/probe.c
+++ b/drivers/pci/probe.c
@@ -17,6 +17,7 @@
 #include <linux/acpi.h>
 #include <linux/irqdomain.h>
 #include <linux/pm_runtime.h>
+#include <linux/hypervisor.h>
 #include "pci.h"
 
 #define CARDBUS_LATENCY_TIMER	176	/* secondary latency timer */
@@ -2454,6 +2455,7 @@ static unsigned int pci_scan_child_bus_extend(struct pci_bus *bus,
 					      unsigned int available_buses)
 {
 	unsigned int used_buses, normal_bridges = 0, hotplug_bridges = 0;
+	unsigned int stride = jailhouse_paravirt() ? 1 : 8;
 	unsigned int start = bus->busn_res.start;
 	unsigned int devfn, cmax, max = start;
 	struct pci_dev *dev;
@@ -2461,7 +2463,7 @@ static unsigned int pci_scan_child_bus_extend(struct pci_bus *bus,
 	dev_dbg(&bus->dev, "scanning bus\n");
 
 	/* Go find them, Rover! */
-	for (devfn = 0; devfn < 0x100; devfn += 8)
+	for (devfn = 0; devfn < 0x100; devfn += stride)
 		pci_scan_slot(bus, devfn);
 
 	/* Reserve buses for SR-IOV capability. */
-- 
2.13.6
