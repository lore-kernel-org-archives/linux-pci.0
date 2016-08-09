Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from Galois.linutronix.de ([146.0.238.70]:47388 "EHLO
	Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751914AbcHILYv (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Tue, 9 Aug 2016 07:24:51 -0400
Date: Tue, 9 Aug 2016 13:22:30 +0200 (CEST)
From: Thomas Gleixner <tglx@linutronix.de>
To: LKML <linux-kernel@vger.kernel.org>
cc: x86@kernel.org, Bjorn Helgaas <bhelgaas@google.com>,
	linux-pci@vger.kernel.org, Jan Kiszka <jan.kiszka@siemens.com>,
	Benedikt Spranger <b.spranger@linutronix.de>
Subject: x86/PCI: Scan all functions during probing
Message-ID: <alpine.DEB.2.20.1608091318530.5388@nanos>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

From: Benedikt Spranger <b.spranger@linutronix.de>

PCI and PCIBIOS probing only scans devices at function number 0/8/16/...
Subdevices (e.g. multiqueue) have function numbers which are not a
multiple of 8.

Simple hypervisors (e.g. Jailhouse) pass subdevices directly w/o providing
virtual PCI mappings like KVM. As a consequence a simple PCI passthrough from
Jailhouse to a linux guest is not able to detect such devices.

Changing the probe functions to scan all function numbers makes it work. This
has no side effects and there is no reason to force the 0/8/16... probing
scheme.

Signed-off-by: Benedikt Spranger <b.spranger@linutronix.de>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
---
 arch/x86/pci/legacy.c |    2 +-
 drivers/pci/probe.c   |    2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

--- a/arch/x86/pci/legacy.c
+++ b/arch/x86/pci/legacy.c
@@ -42,7 +42,7 @@ void pcibios_scan_specific_bus(int busn)
 	if (pci_find_bus(0, busn))
 		return;
 
-	for (devfn = 0; devfn < 256; devfn += 8) {
+	for (devfn = 0; devfn < 256; devfn++) {
 		if (!raw_pci_read(0, busn, devfn, PCI_VENDOR_ID, 2, &l) &&
 		    l != 0x0000 && l != 0xffff) {
 			DBG("Found device at %02x:%02x [%04x]\n", busn, devfn, l);
--- a/drivers/pci/probe.c
+++ b/drivers/pci/probe.c
@@ -2063,7 +2063,7 @@ unsigned int pci_scan_child_bus(struct p
 	dev_dbg(&bus->dev, "scanning bus\n");
 
 	/* Go find them, Rover! */
-	for (devfn = 0; devfn < 0x100; devfn += 8)
+	for (devfn = 0; devfn < 0x100; devfn++)
 		pci_scan_slot(bus, devfn);
 
 	/* Reserve buses for SR-IOV capability. */
