Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from 2.mo1.mail-out.ovh.net ([178.32.119.250]:51768 "EHLO
        2.mo1.mail-out.ovh.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751014AbeACVwG (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 3 Jan 2018 16:52:06 -0500
Received: from player691.ha.ovh.net (gw6.ovh.net [213.251.189.206])
        by mo1.mail-out.ovh.net (Postfix) with ESMTP id BDB76B9EDD
        for <linux-pci@vger.kernel.org>; Wed,  3 Jan 2018 22:15:58 +0100 (CET)
From: Cyrille Pitchen <cyrille.pitchen@free-electrons.com>
To: bhelgaas@google.com, kishon@ti.com, lorenzo.pieralisi@arm.com,
        linux-pci@vger.kernel.org
Cc: adouglas@cadence.com, stelford@cadence.com, dgary@cadence.com,
        kgopi@cadence.com, eandrews@cadence.com,
        thomas.petazzoni@free-electrons.com, sureshp@cadence.com,
        nsekhar@ti.com, linux-kernel@vger.kernel.org, robh@kernel.org,
        devicetree@vger.kernel.org,
        Cyrille Pitchen <cyrille.pitchen@free-electrons.com>
Subject: [RFC] PCI: Cleanup drivers/pci/Makefile
Date: Wed,  3 Jan 2018 22:15:40 +0100
Message-Id: <20180103211540.21906-1-cyrille.pitchen@free-electrons.com>
In-Reply-To: <20180102191639.GD6211@bhelgaas-glaptop.roam.corp.google.com>
References: <20180102191639.GD6211@bhelgaas-glaptop.roam.corp.google.com>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Remove empty lines, useless comments and sort rules by alphabetical
order.

Signed-off-by: Cyrille Pitchen <cyrille.pitchen@free-electrons.com>
---
Hi Bjorn,

This is the kernel oops I get when I test this patch.
I've applied it on top of the series for the Cadence PCIe controller.
I didn't have time to investigate more yet, sorry!

kernel BUG at drivers/base/driver.c:153!
Internal error: Oops - BUG: 0 [#1] PREEMPT SMP                  
Modules linked in:                                              
CPU: 0 PID: 1 Comm: swapper/0 Not tainted 4.15.0-rc4+ #151      
Hardware name: Cadence CSP (DT)                                 
pstate: 40000005 (nZcv daif -PAN -UAO)
pc : driver_register+0xc0/0xf8
lr : pcie_port_service_register+0x4c/0x60
sp : ffffffc006457d90
x29: ffffffc006457d90 x28: 0000000000000000
x27: ffffff80086e2028 x26: ffffff800884a000
x25: ffffff8008690474 x24: ffffff80086d7068
x23: ffffff800868b0b8 x22: ffffff80086d7078
x21: 0000000000000000 x20: ffffff80088692d4
x19: ffffff80086af380 x18: 0000000000000000
x17: 000000000000037f x16: 0000000000000000
x15: 0000000000000000 x14: 0000000000000400
x13: 0000000000000001 x12: 0000000000000000
x11: 0000000000000001 x10: 0000000000000980
x9 : ffffffc006457b60 x8 : ffffffc0064589e0
x7 : ffffffc006458100 x6 : 000000000000a6e8
x5 : 000000000000a6e8 x4 : 0000000000000000
x1 : ffffff800881d720 x0 : ffffff800881c820
Process swapper/0 (pid: 1, stack limit = 0x00000000d680c8f0)
Call trace:
 driver_register+0xc0/0xf8
 pcied_init+0x24/0x7c
 do_one_initcall+0x38/0x120
 kernel_init_freeable+0x134/0x1d0
 kernel_init+0x10/0x100
 ret_from_fork+0x10/0x18
Code: 2a1403e0 a94153f3 a8c27bfd d65f03c0 (d4210000)

Best regards,

Cyrille

 drivers/pci/Makefile | 84 +++++++++++++++++++++-------------------------------
 1 file changed, 33 insertions(+), 51 deletions(-)

diff --git a/drivers/pci/Makefile b/drivers/pci/Makefile
index 3b6c22afb2aa..fd4401cf1b4a 100644
--- a/drivers/pci/Makefile
+++ b/drivers/pci/Makefile
@@ -3,57 +3,39 @@
 # Makefile for the PCI bus specific drivers.
 #
 
-obj-$(CONFIG_PCI)	+= access.o bus.o probe.o host-bridge.o remove.o pci.o \
-			pci-driver.o search.o pci-sysfs.o rom.o setup-res.o \
-			irq.o vpd.o setup-bus.o vc.o mmap.o setup-irq.o
+ccflags-$(CONFIG_PCI_DEBUG) := -DDEBUG
 
+# PCI core
+obj-$(CONFIG_ACPI)			+= pci-acpi.o
+obj-$(CONFIG_HOTPLUG_PCI)		+= hotplug/
+obj-$(CONFIG_PCI)			+= access.o bus.o probe.o host-bridge.o \
+					   remove.o pci.o pci-driver.o search.o \
+					   pci-sysfs.o rom.o setup-res.o irq.o \
+					   vpd.o setup-bus.o vc.o mmap.o \
+					   setup-irq.o
 ifdef CONFIG_PCI
-obj-$(CONFIG_PROC_FS) += proc.o
-obj-$(CONFIG_SYSFS) += slot.o
-obj-$(CONFIG_OF) += of.o
+obj-$(CONFIG_OF)			+= of.o
+obj-$(CONFIG_PROC_FS)			+= proc.o
+obj-$(CONFIG_SYSFS)			+= slot.o
 endif
-
-obj-$(CONFIG_PCI_QUIRKS) += quirks.o
-
-# Build PCI Express stuff if needed
-obj-$(CONFIG_PCIEPORTBUS) += pcie/
-
-# Build the PCI Hotplug drivers if we were asked to
-obj-$(CONFIG_HOTPLUG_PCI) += hotplug/
-
-# Build the PCI MSI interrupt support
-obj-$(CONFIG_PCI_MSI) += msi.o
-
-obj-$(CONFIG_PCI_ATS) += ats.o
-obj-$(CONFIG_PCI_IOV) += iov.o
-
-#
-# ACPI Related PCI FW Functions
-# ACPI _DSM provided firmware instance and string name
-#
-obj-$(CONFIG_ACPI)    += pci-acpi.o
-
-# SMBIOS provided firmware instance and labels
-obj-$(CONFIG_PCI_LABEL) += pci-label.o
-
-# Intel MID platform PM support
-obj-$(CONFIG_X86_INTEL_MID) += pci-mid.o
-
-obj-$(CONFIG_PCI_SYSCALL) += syscall.o
-
-obj-$(CONFIG_PCI_STUB) += pci-stub.o
-
-obj-$(CONFIG_PCI_ECAM) += ecam.o
-
-obj-$(CONFIG_XEN_PCIDEV_FRONTEND) += xen-pcifront.o
-
-ccflags-$(CONFIG_PCI_DEBUG) := -DDEBUG
-
-# PCI host controller drivers
-obj-y += host/
-obj-y += switch/
-
-obj-$(CONFIG_PCI_ENDPOINT)	+= endpoint/
-obj-$(CONFIG_PCIE_CADENCE)	+= cadence/
-# PCI dwc controller drivers
-obj-y				+= dwc/
+obj-$(CONFIG_PCIEPORTBUS)		+= pcie/
+obj-$(CONFIG_PCI_ATS)			+= ats.o
+obj-$(CONFIG_PCI_ECAM)			+= ecam.o
+obj-$(CONFIG_PCI_IOV)			+= iov.o
+obj-$(CONFIG_PCI_LABEL)			+= pci-label.o
+obj-$(CONFIG_PCI_MSI)			+= msi.o
+obj-$(CONFIG_PCI_QUIRKS)		+= quirks.o
+obj-$(CONFIG_PCI_STUB)			+= pci-stub.o
+obj-$(CONFIG_PCI_SYSCALL)		+= syscall.o
+obj-$(CONFIG_X86_INTEL_MID)		+= pci-mid.o
+obj-$(CONFIG_XEN_PCIDEV_FRONTEND)	+= xen-pcifront.o
+
+# PCI controllers
+obj-y					+= host/
+obj-y					+= switch/
+obj-$(CONFIG_PCI_ENDPOINT)		+= endpoint/
+
+# PCI controllers supporting both host and endpoint modes:
+# their associated drivers must currently be linked after the EPC/EPF libraries
+obj-$(CONFIG_PCIE_CADENCE)		+= cadence/
+obj-y					+= dwc/
-- 
2.11.0
